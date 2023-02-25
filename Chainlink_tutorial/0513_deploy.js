const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
    const provider = new ethers.providers.JsonRpcProvider("RPC URL");
    const wallet = new ethers.Wallet("Address private key", provider);
    const abi  = fs.readFileSync("abi file path", "utf8");
    const binary = fs.readFileSync("binary file path", "utf8");
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
    console.log("Deploying, please wait...");
    const contract = await contractFactory.deploy();
    const transactionReceipt = await contract.deployTransaction.wait(1);            // 等待一定数量的区块确认后，可以返回一个回执

    // transaction response 是在创建交易后就会生成的东西，包含交易执行结果（成功或失败）和某些可选返回数据
    console.log("Here is the deployment transaction (transaction response): ");     
    console.log(contract.deployTransaction);

    // transaction receipt 则是交易彻底完成，即写入区块后才会生成的东西，需要等待一定的区块确认后才能获得，内容包含一些交易所在区块的信息等
    console.log("Here is the transaction receipt: ");                               
    console.log(transactionReceipt);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })