// imports
const {ethers, run, network} = require("hardhat")

// async main

async function main() {
  const [deployer] = await ethers.getSigners()
  console.log("Deploying contracts with the account:", deployer.address)

  const SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
  console.log("Deploying contract...")
  const simpleStorage = await SimpleStorageFactory.deploy()
  await simpleStorage.waitForDeployment()
  console.log(`Deployed contract to: ${simpleStorage.target}`)
  // what happens when we deploy to our hardhat network
  if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY) {
    await simpleStorage.deploymentTransaction.wait(6)
    await verify(simpleStorage.target, [])
  }
}

async function verify(contractAddress, args) {
  console.log("Verifying contract...")
  try{
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    })
  } catch(e) {
    if (e.message.toLowerCase().includes("already verified")){
      console.log("Already Verified!")
    } else {
      console.log(e)
    }
  }
}

// main
main().then(() => process.exit(0)).catch((error) => {
  console.error(error)
  process.exit(1)
})