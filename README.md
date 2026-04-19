# Bitcoin-Core Example

## Introduction

Install Bitcoin-Core. Try 'bitcoin --version' to see if the instalation is correct.

Use this 'bitcoin.conf'

``` conf
regtest=1
daemon=1
server=1
rpcuser=ghost
rpcpassword=ghost
txindex=1
fallbackfee=0.00001
```

and start with 'bitcoind'.
A helloworld command for check if all is working properly 'bitcoin-cli getblockchaininfo' you will get an answer like:

``` t
{
  "chain": "regtest",
  "blocks": 0,
  "headers": 0,
  "bestblockhash": "0f9188f13cb7b2c71f2a335e3a4fc328bf5beb436012afca590b1a11466e2206",
  "difficulty": 4.656542373906925e-10,
  "time": 1296688602,
  "mediantime": 1296688602,
  "verificationprogress": 1,
  "initialblockdownload": true,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000002",
  "size_on_disk": 293,
  "pruned": false,
  "warnings": ""
}
```

## Create a Wallet

First we need to create a Bitcoin Node wallet.

> bitcoin-cli -regtest createwallet "w"

Create a new Address for reciving new BTC from block emision.

> bitcoin-cli -regtest -rpcwallet=w getnewaddress "funding" bech32

In our example we have this answer

bcrt1q5fgyt4thplhpqs83u9yrp9tpjyh7aw8jkf2ua0

We have the control of the PoW. We can generate blocks pay to the last created address.

> bitcoin-cli -regtest generatetoaddress 101 bcrt1q5fgyt4thplhpqs83u9yrp9tpjyh7aw8jkf2ua0

We need to start with 101 blocks for spend 1 block because the maduration block rule. With the next command we can see the actual balance avaiable for spend.

> bitcoin-cli -regtest -rpcwallet=w getbalance

## Pay to another Address

We need to create an external Address for deposit an amount of Bitcoin. 

In our example:

bcrt1p2kg7st9vvlusr0um65w7lujk6tkynq8vdjcsa4hyf7fdqrvgye0sdgyeac

We pay 25 BTC:

> bitcoin-cli -regtest -rpcwallet=w sendtoaddress "bcrt1p2kg7st9vvlusr0um65w7lujk6tkynq8vdjcsa4hyf7fdqrvgye0sdgyeac" 25

and the result given is a TXID:

5f7d21efce3c8c7e5ddd228414b304f8193d5be84a423480c7df1a04730f3bb9

Now we need to confirm the transaction introducing them to one block

> bitcoin-cli -regtest generatetoaddress 1 bcrt1q5fgyt4thplhpqs83u9yrp9tpjyh7aw8jkf2ua0

The transaction is confirmed and we can see info using:

>  bitcoin-cli -regtest getrawtransaction "5f7d21efce3c8c7e5ddd228414b304f8193d5be84a423480c7df1a04730f3bb9" true

This transaction contain the commitent for the all batch.

## Creating a Revocation

This step is not necessary at all, only if you need revocate someone document.
Use the revocation.py script and we obtained the hex of the new transaction with the op return revocation status

02000000000101b93b0f73041adfc78034424ae85b3d19f804b3148422dd5d7e8c3cceef217d5f0000000000fdffffff0218f50295000000002251205591e82cac67f901bf9bd51deff256d2ec4980ec6cb10ed6e44f92d00d88265f0000000000000000036a01f0014074e59663d413708c403e4793cf4f9d03e35ccde9058933d132dd49b8225df9f5656eb5a11c180c27593c1134b6fdbf339fd23a7890d3a5871b895073995afc7a00000000

This transaction is signed and ready to broadcast by any node.

For test the validity before bradcast and check the correct construction we can use the following command:

> bitcoin-cli testmempoolaccept '["02000000000101b93b0f73041adfc78034424ae85b3d19f804b3148422dd5d7e8c3cceef217d5f0000000000fdffffff0218f50295000000002251205591e82cac67f901bf9bd51deff256d2ec4980ec6cb10ed6e44f92d00d88265f0000000000000000036a01f0014074e59663d413708c403e4793cf4f9d03e35ccde9058933d132dd49b8225df9f5656eb5a11c180c27593c1134b6fdbf339fd23a7890d3a5871b895073995afc7a00000000"]'

``` json
  {
    "txid": "4dd9abce6621b1ba252525f51415c7778ca197b2c5d39d5c7a40e26b19eac96e",
    "wtxid": "bce7ef73d5ebb22b11c812e9c134955944621eb6009f72dd3d2a369fcb8dbb8c",
    "allowed": true,
    "vsize": 123,
    "fees": {
      "base": 0.00001000,
      "effective-feerate": 0.00008130,
      "effective-includes": [
        "bce7ef73d5ebb22b11c812e9c134955944621eb6009f72dd3d2a369fcb8dbb8c"
      ]
    }
  }
```

We saw the construction was well constructed and it will be accepted for broadcast by any node.

We can see the transaction information using:

> bitcoin-cli decoderawtransaction "02000000000101b93b0f73041adfc78034424ae85b3d19f804b3148422dd5d7e8c3cceef217d5f0000000000fdffffff0218f50295000000002251205591e82cac67f901bf9bd51deff256d2ec4980ec6cb10ed6e44f92d00d88265f0000000000000000036a01f0014074e59663d413708c403e4793cf4f9d03e35ccde9058933d132dd49b8225df9f5656eb5a11c180c27593c1134b6fdbf339fd23a7890d3a5871b895073995afc7a00000000"

``` json
{
  "txid": "4dd9abce6621b1ba252525f51415c7778ca197b2c5d39d5c7a40e26b19eac96e",
  "hash": "bce7ef73d5ebb22b11c812e9c134955944621eb6009f72dd3d2a369fcb8dbb8c",
  "version": 2,
  "size": 174,
  "vsize": 123,
  "weight": 492,
  "locktime": 0,
  "vin": [
    {
      "txid": "5f7d21efce3c8c7e5ddd228414b304f8193d5be84a423480c7df1a04730f3bb9",
      "vout": 0,
      "scriptSig": {
        "asm": "",
        "hex": ""
      },
      "txinwitness": [
        "74e59663d413708c403e4793cf4f9d03e35ccde9058933d132dd49b8225df9f5656eb5a11c180c27593c1134b6fdbf339fd23a7890d3a5871b895073995afc7a"
      ],
      "sequence": 4294967293
    }
  ],
  "vout": [
    {
      "value": 24.99999000,
      "n": 0,
      "scriptPubKey": {
        "asm": "1 5591e82cac67f901bf9bd51deff256d2ec4980ec6cb10ed6e44f92d00d88265f",
        "desc": "rawtr(5591e82cac67f901bf9bd51deff256d2ec4980ec6cb10ed6e44f92d00d88265f)#43dasd0z",
        "hex": "51205591e82cac67f901bf9bd51deff256d2ec4980ec6cb10ed6e44f92d00d88265f",
        "address": "bcrt1p2kg7st9vvlusr0um65w7lujk6tkynq8vdjcsa4hyf7fdqrvgye0sdgyeac",
        "type": "witness_v1_taproot"
      }
    },
    {
      "value": 0.00000000,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_RETURN -112",
        "desc": "raw(6a01f0)#r2xcrtqa",
        "hex": "6a01f0",
        "type": "nulldata"
      }
    }
  ]
}
```

We can send and broadcast the transaction using:

>  bitcoin-cli -regtest sendrawtransaction 02000000000101b93b0f73041adfc78034424ae85b3d19f804b3148422dd5d7e8c3cceef217d5f0000000000fdffffff0218f50295000000002251205591e82cac67f901bf9bd51deff256d2ec4980ec6cb10ed6e44f92d00d88265f0000000000000000036a01f0014074e59663d413708c403e4793cf4f9d03e35ccde9058933d132dd49b8225df9f5656eb5a11c180c27593c1134b6fdbf339fd23a7890d3a5871b895073995afc7a00000000

And get the txid,  check the output of revocation.py script has the same id.

4dd9abce6621b1ba252525f51415c7778ca197b2c5d39d5c7a40e26b19eac96e

And we confirm the transaction into a new block

> bitcoin-cli -regtest generatetoaddress 1 bcrt1q5fgyt4thplhpqs83u9yrp9tpjyh7aw8jkf2ua0


## Verification

This step use the python script called verification.py and we perform this script anytime, after or before the revocation.

Use an bitcoin-cli commands, the server needs a Bitcoin-Core. We recommend the following bitcoin.conf

``` conf
regtest=1
daemon=1
server=1
rpcuser=ghost
rpcpassword=ghost
txindex=1
fallbackfee=0.00001
```

