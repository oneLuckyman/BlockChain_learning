const {assert} = require("chai")
const { network, getNamedAccounts } = require("hardhat")
const {developmentChains, networkConfig} = require("../../helper-hardhat-config.js")
const { toNumber } = require("ethers")

developmentChains.includes(network.name)
    ? describe.skip
    :describe("Raffle Unit Tests", function (){
        let raffle, raffleEntranceFee, deployer

        beforeEach(async function() {
            deployer = (await getNamedAccounts()).deployer
            raffle = await ethers.getContract("Raffle", deployer)
            raffleEntranceFee = await raffle.getEntranceFee()
        })

        describe("fulfillRandomWords", function() {
            it("works with live Chainlink Keepers and Chainlink VRF, we get a random winner", async function() {
                // enter the raffle
                const startingTimeStamp = await raffle.getLatestTimeStamp()
                const accounts = await ethers.getSigners()

                await new Promise(async (resolve, reject) => {
                    // setup listener before we enter the raffle
                    // Just in case the blockchain moves REALLY fast
                    raffle.once("WinnerPicked", async () => {
                        console.log("WinnerPicked event fired!")
                        resolve()
                        try {
                            const recentWinner = await raffle.getRecentWinner()
                            const raffleState = await raffle.getRaffleState()
                            const winnerBalance = await accounts[0].getBalance()
                            const endingTimeStamp = await raffle.getLatestTimeStamp()
                            const winnerEndingBalance = await accounts[0].getBlance()
                            
                            await expect(raffle.getPlayer()).to.be.reverted
                            assert.equal(recentWinner.toString(), accounts[0].address)
                            assert.equal(raffleState, 0)
                            assert.equal(winnerEndingBalance.toString(), winnerStartingBalance.add(raffleEntranceFee).toString())
                            assert(endingTimeStamp > startingTimeStamp)
                            resolve()
                        } catch (error) {
                            console.log(error)
                            reject(error)
                        }
                    })
                })
                // Then entering the raffle
                await raffle.enterRaffle({value: raffleEntranceFee})
                const winnerStartingBalance = await accounts[0].getBlance()
            })
        })
    })