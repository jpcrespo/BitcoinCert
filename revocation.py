
import os
os.system('cls' if os.name == 'nt' else 'clear')


import hashlib, json
from bitcoinutils.setup import setup
from bitcoinutils.keys import PrivateKey, PublicKey, P2trAddress
from bitcoinutils.transactions import Transaction, TxInput, TxOutput, TxWitnessInput
from bitcoinutils.script import Script
from coincurve import PrivateKey as ccPrivateKey , PublicKeyXOnly 
from pathlib import Path

setup("regtest")



print(f"----------------------------------------------------\n"*2)
print('"Create a Taproot Revocation Op return"')
print('\033[1mby Juan Crespo\033[0m') 
print("-----------------------------------------------------\n"*2)
print('\n'*3)




path_master_proof = input("Insert the path to the Master proof file: ")


MASTER_PROOF = json.loads(Path(path_master_proof).read_text())

seed_sign_key = hashlib.sha256(b"Deanship").digest()
sk_sign = ccPrivateKey(seed_sign_key)
pk_sign = sk_sign.public_key_xonly.format().hex()

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


CONTROL = {}
for key, value in MASTER_PROOF['batch'].items():
    doc_sing = sk_sign.sign_schnorr(bytes.fromhex(value))
    CONTROL[key] = {
                    "index": key,
                    "sig": doc_sing.hex(),
                    "pk_sign": pk_sign,
                    "hash": value,
                    }


leafs = []

for value in CONTROL.values():
    index = int(value['index']).to_bytes(4, "big").hex()
    hash_doc = value['hash']
    sign = value['pk_sign']
    opcode = 'OP_FALSE'
    script = Script([index,hash_doc,sign,opcode])
    leafs.append(script)


btc_sk = PrivateKey(secret_exponent=1)
btc_pub = btc_sk.get_public_key()

txid_in = MASTER_PROOF['idtx']
vout_in = 0
amount_in = 25 * 100_000_000


addr_out = MASTER_PROOF['address']
addr_out_obj = P2trAddress.from_address(addr_out)
amount_out = (25 * 100_000_000)-1000 # FEE

# THE BITMAP WITH REVOCATION 
BITMAP = 0b11110000   # doc5, doc6,doc7,doc8 revoqued 
payload = BITMAP.to_bytes(1, 'big').hex()

opret_script = Script(["OP_RETURN", payload])
opret_out = TxOutput(0, opret_script)

txin = TxInput(txid_in, vout_in)
out1 = TxOutput(amount_out, addr_out_obj.to_script_pub_key())

tx = Transaction(
    [txin],
    [out1, opret_out],
    has_segwit=True
)

tap_tree =  build_tap_tree(leafs)
taproot_addr = btc_pub.get_taproot_address(tap_tree)
utxo_scripts = [taproot_addr.to_script_pub_key()]
amounts = [amount_in]

sig = btc_sk.sign_taproot_input(
    tx,
    0,
    utxo_scripts,
    amounts,
    script_path=False,
    tapleaf_scripts=tap_tree,
)

tx.witnesses.append(TxWitnessInput([sig]))


print('\n'*5)
print('The revocation transaction is created.')
print('')

rawtx = tx.serialize()
print(rawtx)
print("TXID:", tx.get_txid())
