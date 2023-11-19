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
    const transactionReceipt = await contract.deployTransaction.wait(1);

    // console.log("Let's deploy with only transaction data!");
    // const nonce = await wallet.getTransactionCount();
    // const tx = {
    //     nonce: nonce,
    //     gasPrice: 20000000000,
    //     gasLimit: 1000000,
    //     to: null,
    //     value: 0,
    //     data: "0xbinary file",
    //     chainId: 1337,              // Network_ID
    // };
    // const sentTxResponse = await wallet.sendTransaction(tx);
    // await sentTxResponse.wait(1);
    // console.log(sentTxResponse);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })