const { network } = require("hardhat")
const {developmentChains} = require("../helper-hardhat-config")



module.exports = async function ({getNamedAccouts, deployments}) {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccouts()
    const chainId = network.config.chainId

    if(developmentChains.includes(network.name)){
        log("Local network detected! Deploying mocks...")
        // deploy a mock vrfcoordinator...
    }
}