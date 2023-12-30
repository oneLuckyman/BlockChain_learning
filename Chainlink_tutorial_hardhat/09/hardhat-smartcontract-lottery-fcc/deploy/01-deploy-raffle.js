const { network } = require("hardhat");
const { developmentChains } = require("../helper-hardhat-config");

module.exports = async function({getNameAccounts, deployments}) {
    const {deploy, log} = deployments;
    const {deployer} = await getNameAccounts();
    let vrfCoordinatorV2Address

    if (developmentChains.includes(network.name)) {
        const vrfCoordinatorV2Mock = await ethers.getContract("VRFCoordinatorV2Mock")
        vrfCoordinatorV2Address = vrfCoordinatorV2Mock.address
    }

    const args = []
    const raffle = await deploy("Raffle", {
        from: deployer, 
        args: args,
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })
}