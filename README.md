This repository can help verify Alberta tax brackets without revealing the following financial information:

* employment income
* rental income
* investment income
* pension or retirement income
* other taxable benefits
* RRSP contributions
* union professional dues
* childcare expenses
* moving expenses
* business or employment expenses
* support payments

The circom file (`alberta.circom`) in this repository can be used to generate files such as those in the verification bundle folder. Such files could then be used to verify the Alberta tax bracket of a user without giving away additional information. Only the tax bracket of the user needs to be shown.

A more detailed description of the tax bracket calculation used here can be seen in the Python file (`alberta.py`). The files in the verification bundle folder are for demonstration purposes only. For instance, I only used one ceremony contributor to generate them.

How to use files in the verification bundle folder:

* Off-Chain Verification (App/Server): use proof.json and public.json with verification\_key.json
* On-Chain Verification: use proof.json and public.json with verifier.sol

`verifier.sol` and `verification\_key.json` only depend on the circom file, while `proof.json` and `public.json` also depend on the user.

The algorithm used is Groth16, and snarkjs was used to generate the files in the verification bundle folder.

