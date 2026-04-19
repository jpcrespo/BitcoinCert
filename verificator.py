# Librerias


import os
os.system('cls' if os.name == 'nt' else 'clear')


import hashlib, json
from bitcoinutils.setup import setup
from bitcoinutils.keys import PublicKey
from bitcoinutils.script import Script
from coincurve import PrivateKey as ccPrivateKey, PublicKeyXOnly 
from pathlib import Path
from bitcoinutils.utils import tapleaf_tagged_hash, tapbranch_tagged_hash
from bitcoinrpc.authproxy import AuthServiceProxy
import sys

RPC_USER = "ghost"
RPC_PASS = "ghost"
RPC_PORT = 18443
RPC_HOST = "127.0.0.1"

rpc = AuthServiceProxy(f"http://{RPC_USER}:{RPC_PASS}@{RPC_HOST}:{RPC_PORT}")



setup("regtest")


def rebuild_address_from_deliverable(deliverable):
    required = {
        "index",
        "hash",
        "pk_sign",
        "proof",
        "internal_key",
    }

    missing = required - set(deliverable.keys())
    if missing:
        raise KeyError(f"Faltan campos requeridos: {sorted(missing)}")

    index = deliverable["index"]
    hash_hex = deliverable["hash"]
    pk_sign_hex = deliverable["pk_sign"]
    proof_hex = deliverable["proof"]
    internal_key_hex = deliverable["internal_key"]

    if not isinstance(index, int):
        raise TypeError("deliverable['index'] debe ser int")

    if not isinstance(hash_hex, str) or len(hash_hex) != 64:
        raise ValueError("deliverable['hash'] debe ser hex string de 32 bytes")

    if not isinstance(pk_sign_hex, str) or len(pk_sign_hex) != 64:
        raise ValueError("deliverable['pk_sign'] debe ser x-only hex string de 32 bytes")

    if not isinstance(internal_key_hex, str) or len(internal_key_hex) != 64:
        raise ValueError("deliverable['internal_key'] debe ser x-only hex string de 32 bytes")

    if not isinstance(proof_hex, list):
        raise TypeError("deliverable['proof'] debe ser list[str]")

    for i, sibling_hex in enumerate(proof_hex):
        if not isinstance(sibling_hex, str) or len(sibling_hex) != 64:
            raise ValueError(f"proof[{i}] debe ser hex string de 32 bytes")

    # reconstrucción exacta del leaf
    index_hex = index.to_bytes(4, "big").hex()
    leaf = Script([index_hex, hash_hex, pk_sign_hex, "OP_FALSE"])

    # tapleaf hash
    h = tapleaf_tagged_hash(leaf)
    tapleaf_hash_hex = h.hex()

    # root reconstruida
    for sibling_hex in proof_hex:
        sibling = bytes.fromhex(sibling_hex)
        h = tapbranch_tagged_hash(h, sibling)

    root_rebuilt_hex = h.hex()

    # chequeo opcional contra root guardada
    if "root" in deliverable and deliverable["root"] != root_rebuilt_hex:
        raise ValueError(
            f"Root reconstruida distinta.\n"
            f"esperada={deliverable['root']}\n"
            f"obtenida={root_rebuilt_hex}"
        )

    # internal_key es x-only; para PublicKey.from_hex se reconstruye como compressed even-y
    internal_pub = PublicKey.from_hex("02" + internal_key_hex)

    # python-bitcoin-utils acepta bytes como merkle root en get_taproot_address(...)
    address_obj = internal_pub.get_taproot_address(h)
    address_str = address_obj.to_string()

    # chequeo opcional contra address guardada
    if "address" in deliverable and deliverable["address"] != address_str:
        raise ValueError(
            f"Address reconstruida distinta.\n"
            f"esperada={deliverable['address']}\n"
            f"obtenida={address_str}"
        )

    return {
        "leaf": leaf,
        "tapleaf_hash": tapleaf_hash_hex,
        "root": root_rebuilt_hex,
        "address": address_str,
    }
    

def read_proof(path):
    with open(path, 'r', encoding='utf-8') as archivo:
        # 2. Cargar el contenido y transformarlo en diccionario
        datos = json.load(archivo)   
    return datos

def hash_pdf(pdf_path):
    with open(pdf_path, "rb") as f:
        pdf_bytes = f.read()
    
    return hashlib.sha256(pdf_bytes).hexdigest()

def find_child_by_same_address(rpc, address: str, parent_txid: str):
    res = rpc.scantxoutset("start", [f"addr({address})"])
    for u in res.get("unspents", []):
        if u["txid"] != parent_txid:
            return {
                "child_txid": u["txid"],
                "child_vout": u["vout"],
                "amount": u["amount"],
                "raw": u,
            }
    return None

def check_revocation(path):
        
    rpc = AuthServiceProxy(f"http://{RPC_USER}:{RPC_PASS}@{RPC_HOST}:{RPC_PORT}")

    address_check = deliverable['address']
    idtx_check = deliverable['idtx']
    result = find_child_by_same_address(
        rpc,
        address_check,
        idtx_check
    )

    result['child_txid']
    tx = rpc.getrawtransaction(result['child_txid'], 1)

    revocation_hex = tx['vout'][1]['scriptPubKey']['hex'][4:]
    revocation_bitmap = bin(int(revocation_hex, 16))[2:].zfill(len(revocation_hex) * 4)

    if revocation_bitmap[-deliverable['index']]=='1':
        print('Revoqued')
        print('\n\nThe document '+path+' is not Valid')
    else: 
        print('Not Revoqued')
        print('\n\nThe document in '+path+' is valid')

print(f"----------------------------------------------------\n"*2)
print('"Verification Document using TapRoot Bitcoin"')
print('\033[1mby Juan Crespo\033[0m') 
print("-----------------------------------------------------\n"*2)
print('\n'*3)

    
path_proof = input("Insert the path to the proof file (e.g. files/batch_size/8/doc_0_proof.json): ")

path_doc = input('Insert the path to the document file (e.g. files/batch_size/8/doc_8_da463.pdf): ')

deliverable = json.loads(Path(path_proof).read_text())

try:
    deliverable = json.loads(Path(path_proof).read_text())  
    print('Proof file loaded successfully.')
except (KeyError, TypeError, ValueError) as e:
    print(f"Error rebuilding address: {e}")
    

result = rebuild_address_from_deliverable(deliverable)

hash_doc = hash_pdf(path_doc)


if hash_doc == deliverable['hash']:
    if result['address'] == deliverable["address"]:
        print("Verification Integrity: Address reconstructed matches.")
else: 
    print('Verification Integrity Fail')
    sys.exit()






A = PublicKeyXOnly(bytes.fromhex(deliverable['pk_sign']))
B = bytes.fromhex(deliverable['sig'])
C = bytes.fromhex(deliverable['hash'])

if A.verify(B,C):
    print('Verification Authenticity Succesful: Signature is valid.')
else:   print('Verification Authenticity Fail: Signature is NOT valid.')





rawtx = deliverable['idtx']

decoded = rpc.getrawtransaction(rawtx, 1)

for output in decoded['vout']:
    # Buscamos dentro de scriptPubKey
    if 'address' in output['scriptPubKey']:
        if output['scriptPubKey']['address'] == deliverable['address']:
            utxo_base =  output['n']

utxo_spend = rpc.gettxout(rawtx,int(utxo_base))

if utxo_spend:
    print('Revocation on Batch?: False')
    print('The document are Total Verified and Valid')
else:
    print('Revocation on Batch?: True')
    check_revocation(path_doc)