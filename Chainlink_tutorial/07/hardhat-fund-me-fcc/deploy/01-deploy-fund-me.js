// function deployFunc(hre) {
//     console.log("Hi!")
//     hre.getNamedAccounts()
//     hre.deployments
// }

const { network } = require("hardhat")

// module.exports.default = deployFunc

// module.exports = async (hre) => {
//     const {getNamedAccounts, deployments} = hre
// }

const {networkConfig} = require("../helper-hardhat-config")

module.exports = async ({getNamedAccounts, deployments}) => {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()
    const chainId = network.config.chainId

    const ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"]

    // well what happens when we want to change chains?
    // when going for localhost or hardhat network we want to use a mock
    const fundMe = await deploy("FundMe", {
        from: deployer,
        args: [],
        log: true,
    })
}