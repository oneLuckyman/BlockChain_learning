const {deployments, ethers, getNamedAccounts} = require("hardhat")
const {assert} = require("chai")

describe("FundMe", async function() {
    let fundMe
    let deployer
    let mockV3Aggregator
    beforeEach(async function() {
        // deploy our fundMe contract
        // using Hardhat-deploy
        // const accounts = await ethers.getSigners()
        // const accountZero = accounts[0]
        deployer = (await getNamedAccounts()).deployer
        await deployments.fixture(["all"])
        fundMe = await ethers.getContract("FundMe", deployer)
        mockV3Aggregator = await ethers.getContract("MockV3Aggregator", deployer)
    })

    describe("constructor", async function() {
        it("sets the aggregator addresses correctly", async function(){
            const response = await fundMe.priceFeed()
            assert.equal(response, mockV3Aggregator.target)
        })
    })

    // describe("fund", async function() {
    //     it("Fails if you don't send enough ETH", async function () {

    //     })
    // })
})