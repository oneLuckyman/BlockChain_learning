// 第五章总结
// Node.js 本地运行 JavaScript
// 使用 yarn 或 npm 添加外部包，存放在 node_modules 里
// prettier 代码格式
// 手动验证合约，即把合约代码内容而不是二进制内容放到 etherscan 上

// 导入包
const ethers = require("ethers");   // ethers 是一个方便与区块链交互的包
const fs = require("fs-extra");
require("dotenv").config();

// 定义 async main 函数
async function main() {
    // compile them in our code
    // compile them separately
    // http://127.0.0.1:7545
    // 通过 RPC URL 连接到指定区块链
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
    // 将钱包私钥和节点链接起来
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
    // 加密私钥
    // const encryptedJson = fs.readFileSync("./.encryptedKey.json", "utf8");
    // let wallet = new ethers.Wallet.fromEncryptedJsonSync(encryptedJson, process.env.PRIVATE_KEY_PASSWORD);
    // wallet = await wallet.connect(provider);
    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
    const binary = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf8");
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
    console.log("Deploying, please wait...");
    const contract = await contractFactory.deploy();
    // await 关键字等待 promise 完成
    await contract.deployTransaction.wait(1);
    console.log(`Contract Address: ${contract.address}`)
    // Get number
    // 通过程序与合约交互
    const currentFavoriteNumber = await contract.retrieve();
    console.log(`Current Favorite Number: ${currentFavoriteNumber.toString()}`);
    const transactionResponse = await contract.store("7");
    const transactionReceipt = await transactionResponse.wait(1);
    const updatedFavoriteNumber = await contract.retrieve();
    console.log(`Updated favorite number is: ${updatedFavoriteNumber}`);
}

// 运行 main 函数
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })