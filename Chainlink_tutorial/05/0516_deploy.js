const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

async function main() {
    // 使用 .env 保存敏感信息
    // 使用 .gitignore 忽略上传至 github 的文件
    // process.env 调用 .env 中的变量
    console.log(process.env.PRIVATE_KEY)
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
    const abi  = fs.readFileSync("abi file path", "utf8");
    const binary = fs.readFileSync("binary file path", "utf8");
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
    console.log("Deploying, please wait...");
    const contract = await contractFactory.deploy();
    await contract.deployTransaction.wait(1);
    // Get number
    const currentFavoriteNumber = await contract.retrieve();
    console.log(`Current Favorite Number: ${currentFavoriteNumber.toString()}`);
    const transactionResponse = await contract.store("7");
    const transactionReceipt = await transactionResponse.wait(1);
    const updatedFavoriteNumber = await contract.retrieve();
    console.log(`Updated favorite number is: ${updatedFavoriteNumber}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })