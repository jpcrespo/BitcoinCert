import os
os.system('cls' if os.name == 'nt' else 'clear')

import hashlib, json
from bitcoinutils.setup import setup
from bitcoinutils.keys import PrivateKey, PublicKey, P2trAddress
from bitcoinutils.transactions import Transaction, TxInput, TxOutput, TxWitnessInput
from bitcoinutils.script import Script
from coincurve import PrivateKey as ccPrivateKey , PublicKeyXOnly 
from pathlib import Path

from bitcoinutils.utils import tapleaf_tagged_hash, tapbranch_tagged_hash

setup("regtest")

seed_sign_key = hashlib.sha256(b"Deanship").digest()
sk_sign = ccPrivateKey(seed_sign_key)
pk_sign = sk_sign.public_key_xonly.format().hex()

def hash_pdf(pdf_path):
    with open(pdf_path, "rb") as f:
        pdf_bytes = f.read()
    
    return hashlib.sha256(pdf_bytes).hexdigest()

def extract_id_from_pdf_name(pdf_path):
    name = Path(pdf_path).stem   # e.g.: doc_001_3d198
    return name.replace("doc_", "", 1)

def sort_hash_dict(batch):
    return dict(
        sorted(
            ((int(k.split("_")[0]), v) for k, v in batch.items()),
            key=lambda item: item[0]
        )
    )

def hash_pdfs_in_path(folder_path: str):
    folder = Path(folder_path)
    if not folder.exists():
        raise FileNotFoundError(f"La ruta no existe: {folder_path}")
    if not folder.is_dir():
        raise NotADirectoryError(f"La ruta no es un directorio: {folder_path}")
    hashes = {}
    for pdf_file in folder.glob("*.pdf"):
        index = extract_id_from_pdf_name(pdf_file)
        hashes[index[:-6]] = hash_pdf(pdf_file)
    return hashes

def build_tap_tree(leafs):
    nodes = leafs[:]   

    while len(nodes) > 1:
        next_level = []

        for i in range(0, len(nodes), 2):
            if i + 1 < len(nodes):
                next_level.append([nodes[i], nodes[i + 1]])
            else:
                next_level.append(nodes[i])

        nodes = next_level
    return nodes[0]



def build_merkle_proofs_from_leafs(leafs):
    if not leafs:
        raise ValueError("leafs está vacío")
    level = [
        {
            "hash": tapleaf_tagged_hash(leaf),
            "positions": [i]
        }
        for i, leaf in enumerate(leafs)
    ]

    proofs = {i: [] for i in range(len(leafs))}

    while len(level) > 1:
        next_level = []

        for i in range(0, len(level), 2):
            if i + 1 < len(level):
                left = level[i]
                right = level[i + 1]

                parent_hash = tapbranch_tagged_hash(left["hash"], right["hash"])

                for pos in left["positions"]:
                    proofs[pos].append(right["hash"])

                for pos in right["positions"]:
                    proofs[pos].append(left["hash"])

                next_level.append({
                    "hash": parent_hash,
                    "positions": left["positions"] + right["positions"]
                })
            else:
                next_level.append(level[i])

        level = next_level

    root = level[0]["hash"]
    return root, proofs


def build_pdf_deliverables(CONTROL, leafs, internal_key_hex, idtx,path_batch,taproot_addr_str=None):
    if len(CONTROL) != len(leafs):
        raise ValueError("CONTROL y leafs no tienen la misma longitud")

    root, proofs = build_merkle_proofs_from_leafs(leafs)

    deliverables = {}
    control_items = list(CONTROL.items())

    for pos, (doc_id, item) in enumerate(control_items):
        deliverables[doc_id] = {
            "index": item["index"],
            "hash": item["hash"],
            "sig": item["sig"],
            "pk_sign": item["pk_sign"],
            "proof": [h.hex() for h in proofs[pos]],
            "internal_key": internal_key_hex,
            "root": root.hex(),
            "idtx": idtx,
        }
        if taproot_addr_str is not None:
            deliverables[doc_id]["address"] = taproot_addr_str
        filename = f"/doc_{doc_id}_proof.json"
        Path(path_batch+filename).write_text(json.dumps(deliverables[item["index"]], indent=4))


print(f"----------------------------------------------------\n"*2)
print('"Create a Taproot Commit Address"')
print('\033[1mby Juan Crespo\033[0m') 
print("-----------------------------------------------------\n"*2)
print('\n'*3)



if __name__ == "__main__":
    # path_batch = input("Insert the path to the batch of pdfs (e.g. files/batch_size/128): ")
    path_batch = 'files/batch_size/8'
    batch = sort_hash_dict(hash_pdfs_in_path(path_batch))

    CONTROL = {}
    for key, value in batch.items():
        doc_sing = sk_sign.sign_schnorr(bytes.fromhex(value))
        CONTROL[key] = {
                        "index": key,
                        "sig": doc_sing.hex(),
                        "pk_sign": pk_sign,
                        "hash": value,
                        }

    btc_sk = PrivateKey(secret_exponent=1)
    btc_pub = btc_sk.get_public_key()
    btc_xonly = btc_pub.to_x_only_hex()

    leafs = []

    for value in CONTROL.values():
        index = int(value['index']).to_bytes(4, "big").hex()
        hash_doc = value['hash']
        sign = value['pk_sign']
        opcode = 'OP_FALSE'
        script = Script([index,hash_doc,sign,opcode])
        leafs.append(script)
        
    tap_tree = build_tap_tree(leafs)
    taproot_addr = btc_pub.get_taproot_address(tap_tree)
    print('Address Taproot to pay:')
    print(taproot_addr.to_string())
    idtx = input("Insert the txid of the payment transaction: ")


    build_pdf_deliverables(
        CONTROL=CONTROL,
        leafs=leafs,
        internal_key_hex=btc_xonly,
        taproot_addr_str=taproot_addr.to_string(),
        idtx=idtx,
        path_batch=path_batch
    )
    
    MASTER_PROOF = {
    'batch': batch,
    'address': taproot_addr.to_string(),
    'idtx': idtx,
    }
    Path('MASTER_PROOF.json').write_text(json.dumps(MASTER_PROOF, indent=4))