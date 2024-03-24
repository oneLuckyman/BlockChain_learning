const { network } = require("hardhat")
const { developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")

module.exports = async function({getNamedAccounts, developments}) {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()

    log("-----------------------------")
}