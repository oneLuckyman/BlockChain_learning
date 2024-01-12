const {assert} = require("chai")
const { network, getNamedAccounts } = require("hardhat")
const {developmentChains, networkConfig} = require("../../helper-hardhat-config.js")
const { toNumber } = require("ethers")

!developmentChains.includes(network.name)
    ? describe.skip
    : describe("Raffle Unit Tests", function (){
        let raffle, vrfCoordinatorV2Mock, raffleEntranceFee, deployer, interval
        const chainId = network.config.chainId

        beforeEach(async function() {
            deployer = (await getNamedAccounts()).deployer
            await deployments.fixture(["all"])
            raffle = await ethers.getContract("Raffle", deployer)
            vrfCoordinatorV2Mock = await ethers.getContract("VRFCoordinatorV2Mock", deployer)
            raffleEntranceFee = await raffle.getEntranceFee()
            interval = await raffle.getInterval()
        })

        describe("constructor", function() {
            it("initializes the raffle correctly", async function() {
                // Ideally we make out tests have just 1 assert per "it"
                const raffleState = await raffle.getRaffleState()
                assert.equal(raffleState.toString(), "0")
                assert.equal(interval.toString(), networkConfig[chainId]["interval"])
            })
        })

        describe("enterRaffle", function() {
            it("reverts when you don't pay enough", async function() {
                await expect(raffle.enterRaffle()).to.be.revertedWith("Raffle__NotEnoughETHEntered")
            })
            it("records players when they enter", async function() {
                await raffle.enterRaffle({value: raffleEntranceFee})
                const playerFromContract = await raffle.getPlayer(0)
                assert.equal(playerFromContract, deployer)
            })
            it("emits event on enter", async function(){
                await expect(raffle.enterRaffle({value: raffleEntranceFee})).to.emit(raffle, "RaffleEnter")
            })
            it("doesnt allow entrance when raffle is calculating", async function() {
                await raffle.enterRaffle({value: raffleEntranceFee})
                await network.provider.send("evm_increaseTime", [interval.toNumber() + 1])
                await network.provider.send("evm_mine", [])
                await network.provider.request({method: "evm_mine", params: []})
                await raffle.performUpkeep([])
                await expect(raffle.enterRaffle()).to.be.revertedWith("Raffle__NotOpen")
            })
        })

        describe("checkUpkeep", function() {
            it("returns false if people haven't sent any ETH", async function() {
                await network.provider.send("evm_increaseTime", [interval.toNumber() + 1])
                await network.provider.send("evm_mine", [])
                const {upkeepNeeded} = await raffle.callStatic.checkUpkeep([])
                assert(!upkeepNeeded)
            })
            it("returns false if raffle isn't open", async function() {
                await raffle.enterRaffle({value: raffleEntranceFee})
                await network.provider.send("evm_increaseTime", [interval.toNumber() + 1])
                await network.provider.send("evm_mine", [])
                await raffle.performUpkeep([])
                const raffleState = await raffle.getRaffleState()
                const {upkeepNeeded} = raffle.callStatic.checkUpkeep([])
                assert.equal(raffleState.toString(), "1")
                assert.equal(upkeepNeeded, false)
            })
            it("return false if enough time hasn't passed", async () => {
                await raffle.enterRaffle({value: raffleEntranceFee})
                await network.provider.send("evm_increaseTime", [interval.toNumber() - 1])
                await network.provider.request({method: "evm_mine", params: []})
                const {upkeepNeeded} = await raffle.callStatic.checkUpkeep("0x")
                assert(!upkeepNeeded)
            })
            it("return true if enough time has passed, has players, eth, and is open", async () => {
                await raffle.enterRaffle({value: raffleEntranceFee})
                await network.provider.send("evm_increaseTime", [interval.toNumber() + 1])
                await network.provider.request({method: "evm_mine", params: []})
                const {upkeepNeeded} = await raffle.callStatic.checkUpkeep("0x")
                assert(upkeepNeeded)
            })
        })

        describe("performUpkeep", function() {
            it("it can only run if checkUpkeep is true", async function() {
                await raffle.enterRaffle({value: raffleEntranceFee})
                await network.provider.send("evm_increaseTime", [interval.toNumber() + 1])
                await network.provider.request({method: "evm_mine", params: []})
                const tx = await raffle.performUpkeep([])
                assert(tx)
            })
            it("reverts when checkUpkeep is false", async function() {
                await expect(raffle.performUpkeep([])).to.be.revertedWith("Raffle__UpkeepNotNeeded")
            })
            it("updates the raffle state, emits and event, and calls the vrf coordinator", async function() {
                await raffle.enterRaffle({value: raffleEntranceFee})
                await network.provider.send("evm_increaseTime", [interval.toNumber() + 1])
                await network.provider.request({method: "evm_mine", params: []})
                const txResponse = await raffle.performUpkeep([])
                const txReceipt = await txResponse.wait(1)
                const requestId = txReceipt.events[1].args.requestId
                const raffleState = await raffle.getRaffleState()
                assert(requestId.toNumber() > 0)
                assert(raffleState.toString() == "1")
            })
        })

        describe("fulfillRandomWords", function() {
            beforeEach(async function() {
                await raffle.enterRaffle({value: enterRaffle})
                await network.provider.send("evm_increaseTime", [interval.toNumber() + 1])
                await network.provider.request({method: "evm_mine", params: []})
            })
            it("can only be called after performUpkeep", async function() {
                await expect(vrfCoordinatorV2Mock.fulfillRanfomWords(0, raffle.address)).to.be.revertedWith("nonexistent reques")
                await expect(vrfCoordinatorV2Mock.fulfillRanfomWords(1, raffle.address)).to.be.revertedWith("nonexistent reques")
            })
            it("picks a winner, resets the lottery, and sends money", async function() {
                const additionalEntrants = 3
                const startingAccountIndex = 1  // deployer = 0
                const accounts = await ethers.getSigners()
                for(let i = startingAccountIndex; i < startingAccountIndex + additionalEntrants; i++){
                    const accountConnectedRaffle = raffle.connect(accounts[i])
                    await accountConnectedRaffle.enterRaffle({value: raffleEntranceFee})
                }
                const startingTimeStamp = await raffle.getLastTimeStamp()
                
                await new Promise(async (resolve, reject) => {
                    raffle.once("WinnerPicked", () => {
                        console.log("Found the event!")
                        try {
                            console.log(recentWinner)
                            console.log(accounts[0])
                            console.log(accounts[1])
                            console.log(accounts[2])
                            console.log(accounts[3])
                            const recentWinner = await raffle.getRecentWinner()
                            const raffleState = await raffle.getRaffleState()
                            const endingTimeStamp = await raffle.getLastTimeStamp()
                            const numPlayers = await raffle.getNumberOfPlayers()
                            assert.equal(numPlayers.toString(), "0")
                            assert.equal(raffleState.toString(), "0")
                            assert(endingTimeStamp > startingTimeStamp)
                        } catch (e) {
                            reject(e)
                        }
                        resolve()
                    })
                    const tx = await raffle.performUpkeep([])
                    const txReceipt = await tx.wait(1)
                    await vrfCoordinatorV2Mock.fulfillRanfomWords(txReceipt.events[1].args.requestId, raffle.address)
                })
            })
        })
    })