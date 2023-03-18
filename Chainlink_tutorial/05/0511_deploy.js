const ethers = require("ethers");       // 导入 ethers 包
const fs = require("fs-extra");         // 导入 fs 包，用于读文件

async function main() {
    const provider = new ethers.providers.JsonRpcProvider("RPC URL");           // 连接上某个 RPC URL 所对应的区块链
    const wallet = new ethers.Wallet("Address private key", provider);          // 指定部署者的私钥以及要部署上的区块链
    const abi  = fs.readFileSync("abi file path", "utf8");                      // 读取 abi 文件
    const binary = fs.readFileSync("binary file path", "utf8");                 // 读取 binary 文件
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet);    // 实例化合约工厂，指定 abi，binary，wallet 对象
    console.log("Deploying, please wait...");
    const contract = await contractFactory.deploy();                            // 部署合约
    // await 是重要的，它表示要等待后面内容的 promise 处理完成并把对象返回回来之后再继续运行
    // 如果没有 await 就会导致合约还未部署完成就继续运行了
    console.log(contract);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })