const { getNamedAccounts, ethers } = require("hardhat")
const { getWeth } = require("../scripts/getWeth")

async function main(){
    // the protocol treats everything as an ERC20 token
    await getWeth()
    const { deployer } = await getNamedAccounts()
    const lendingPool = await getLendingPool(deployer)
    console.log(`LendingPool address ${lendingPool.address}`)
}

async function getLendingPool(account) {
    const lendingPoolAddressProvider = await ethers.getContractAt("ILendingPoolAddressesProvider",
     "0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5",
     account)
    const lendingPoolAddress = await lendingPoolAddressProvider.getLendingPool()
    const lendingPool = await ethers.getContractAt("ILendingPool", lendingPoolAddress, account)

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error)
        process.exit(1)
    })