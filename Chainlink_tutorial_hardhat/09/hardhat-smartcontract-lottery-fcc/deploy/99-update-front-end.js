const {ethers} = require("hardhat")
const fs = require("fs")

const FRONT_END_ADDRESSES_FILE = "../../10/nextjs-smartcontract-lottery-fcc/constants/contractAddresses.json"
const FRONT_END_ABI_FILE = "../../10/nextjs-smartcontract-lottery-fcc/constants/abi.json"

module.export = async function () {
    if(process.env.UPDATE_FRONT_END) {
        console.log("Updating front end")
        updateContractAddresses()
    }
}

async function updateContractAddresses() {
    const raffle = await ethers.getContract("Raffle")
    const currentAddresses = JSON.parse(fs.readFileSync(FRONT_END_ADDRESSES_FILE))
}