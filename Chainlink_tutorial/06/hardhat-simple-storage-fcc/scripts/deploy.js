// imports
const {ethers} = require("hardhat")

// async main
async function main() {
  const [deployer] = await ethers.getSigners()
  console.log("Deploying contracts with the account:", deployer.address)

  const SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
  console.log("Deploying contract...")
  const simpleStorage = await SimpleStorageFactory.deploy()
  await simpleStorage.waitForDeployment()
  // what's the private key?
  // what's the rpc url?
  console.log(`Deployed contract to: ${simpleStorage.target}`)
}

// main
main().then(() => process.exit(0)).catch((error) => {
  console.error(error)
  process.exit(1)
})