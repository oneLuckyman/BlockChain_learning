const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
    const provider = new ethers.providers.JsonRpcProvider("RPC URL");
    const wallet = new ethers.Wallet("Address private key", provider);
    const abi  = fs.readFileSync("abi file path", "utf8");
    const binary = fs.readFileSync("binary file path", "utf8");
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
    console.log("Deploying, please wait...");
    const contract = await contractFactory.deploy({gasPrice: 1000000000});      // deploy 函数具有某些 overrides 选项，例如指定 gasPrice
    // const contract = await contractFactory.deploy({gasLimit: 1000000000});      // 指定 gas Limit
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })