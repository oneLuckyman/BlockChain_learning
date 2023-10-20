const {deployments, ethers, getNamedAccounts} = require("hardhat")
const {assert, expect} = require("chai")

describe("FundMe", async function() {
    let fundMe
    let deployer
    let mockV3Aggregator
    const sendValue = ethers.parseEther("1") // 1 ETH
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
            const response = await fundMe.s_priceFeed()
            assert.equal(response, mockV3Aggregator.target)
        })
    })

    describe("fund", async function() {
        it("Fails if you don't send enough ETH", async function () {
            await expect(fundMe.fund()).to.be.revertedWith("You need to spend more ETH!")
        })
        it("updated the amount funded data structure", async function (){
            await fundMe.fund({value: sendValue})
            const response = await fundMe.s_addressToAmountFunded(deployer)
            assert.equal(response.toString(), sendValue.toString())
        })
        it("Adds funder to array of s_funders", async function() {
            await fundMe.fund({value: sendValue})
            const funder = await fundMe.s_funders(0)
            assert.equal(funder, deployer)
        })
    })
    describe("withdraw", async function() {
        beforeEach(async function() {
            await fundMe.fund({ value: sendValue })
        })

        it("withdraw ETH from a single founder", async function() {
            // Arrange
            const stratingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const startingDeployerBalance = await ethers.provider.getBalance(deployer)
            // Act
            const transactionResponse = await fundMe.withdraw()
            const transactionReceipt = await transactionResponse.wait(1)
            const {gasUsed, gasPrice} = transactionReceipt
            const gasCost = gasUsed * gasPrice

            const endingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const endingDeployerBalance = await ethers.provider.getBalance(deployer)
            // Assert
            assert.equal(endingFundMeBalance, 0)
            assert.equal((stratingFundMeBalance + startingDeployerBalance).toString(), (endingDeployerBalance + gasCost).toString())
        })

        it("withdraw ETH from a single founder", async function() {
            // Arrange
            const stratingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const startingDeployerBalance = await ethers.provider.getBalance(deployer)
            // Act
            const transactionResponse = await fundMe.cheaperWithdraw()
            const transactionReceipt = await transactionResponse.wait(1)
            const {gasUsed, gasPrice} = transactionReceipt
            const gasCost = gasUsed * gasPrice

            const endingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const endingDeployerBalance = await ethers.provider.getBalance(deployer)
            // Assert
            assert.equal(endingFundMeBalance, 0)
            assert.equal((stratingFundMeBalance + startingDeployerBalance).toString(), (endingDeployerBalance + gasCost).toString())
        })

        it("allows us to withdraw with multiple s_funders", async function() {
            // Arrange
            const accounts = await ethers.getSigners()
            for (let i = 1; i < 6; i++){
                const fundMeConnectedContract = await fundMe.connect(accounts[i])
                await fundMeConnectedContract.fund({value: sendValue})
            }
            const stratingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const startingDeployerBalance = await ethers.provider.getBalance(deployer)

            // Act
            const transactionResponse = await fundMe.withdraw()
            const transactionReceipt = await transactionResponse.wait(1)
            const {gasUsed, gasPrice} = transactionReceipt
            const gasCost = gasUsed * gasPrice
            // Assert
            const endingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const endingDeployerBalance = await ethers.provider.getBalance(deployer)
            assert.equal(endingFundMeBalance, 0)
            assert.equal((stratingFundMeBalance + startingDeployerBalance).toString(), (endingDeployerBalance + gasCost).toString())

            // Make sure that the s_funders are reset properly
            await expect(fundMe.s_funders(0)).to.be.reverted

            for (i = 1; i < 6; i++){
                assert.equal(await fundMe.s_addressToAmountFunded(accounts[i].address), 0)
            }
        })

        it("Only allows the owner to withdraw", async function(){
            const accounts = await ethers.getSigners()
            const attacker = accounts[1]
            const attackerConnectedContract = await fundMe.connect(attacker)
            await expect(attackerConnectedContract.withdraw()).to.be.revertedWithCustomError(fundMe, "FundMe__NotOwner")
        })

        it("cheaperWithdraw testing...", async function() {
            // Arrange
            const accounts = await ethers.getSigners()
            for (let i = 1; i < 6; i++){
                const fundMeConnectedContract = await fundMe.connect(accounts[i])
                await fundMeConnectedContract.fund({value: sendValue})
            }
            const stratingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const startingDeployerBalance = await ethers.provider.getBalance(deployer)

            // Act
            const transactionResponse = await fundMe.cheaperWithdraw()
            const transactionReceipt = await transactionResponse.wait(1)
            const {gasUsed, gasPrice} = transactionReceipt
            const gasCost = gasUsed * gasPrice
            // Assert
            const endingFundMeBalance = await ethers.provider.getBalance(fundMe.target)
            const endingDeployerBalance = await ethers.provider.getBalance(deployer)
            assert.equal(endingFundMeBalance, 0)
            assert.equal((stratingFundMeBalance + startingDeployerBalance).toString(), (endingDeployerBalance + gasCost).toString())

            // Make sure that the s_funders are reset properly
            await expect(fundMe.s_funders(0)).to.be.reverted

            for (i = 1; i < 6; i++){
                assert.equal(await fundMe.s_addressToAmountFunded(accounts[i].address), 0)
            }
        })
    })
})