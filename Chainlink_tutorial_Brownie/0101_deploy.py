from solcx import compile_standard

with open("./0101_SimpleStorage.sol", "r") as file:
    simple_storage_file = file.read()

# Compile Our Solidity 

compile_sol = compile_standard(
    "language": "Solidity",
    "sources": {"0101_SimpleStorage.sol": {"content": simple_storage_file}},
    "settings": {
        "outputSelection": {
            "*" : {"*" : ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
        }
    }
)