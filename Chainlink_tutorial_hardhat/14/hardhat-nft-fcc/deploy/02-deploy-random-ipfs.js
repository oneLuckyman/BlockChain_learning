const { network } = require("hardhat")
const { developmentChains, networkConfig } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")
const { storeImages } = require("../utils/uploadToPinata")


const imagesLocation = "./images/randomNft"

const metadataTemplate = {
    name: "",
    description: "",
    image: "",
    attributes: [
        {
            trait_type: "Cuteness",
            value: 100,
        }
    ]
}

module.exports = async function({getNamedAccounts, developments}) {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()
    const chainId = network.config.chainId
    let tokenUris
    // get the IPFS hashes of out images
    if (process.env.UPLOAD_TO_PINATA == "true"){
        tokenUris = await handleTokenUris()
    }

    // 1. With our own IPFS node. https://docs.ipfs.io/
    // 2. pinata https://www.pinata.cloud/
    // 3. nft.storage https://nft.storage/


    let vrfCoordinatorV2Address, subscriptionId

    if(developmentChains.includes(network.name)){
        const vrfCoordinatorV2Mock = await ethers.getContract("VRFCoordinatorMock")
        vrfCoordinatorV2Address = vrfCoordinatorV2Mock.address
        const tx = await vrfCoordinatorV2Mock.createSubscription()
        const txReceipt = await tx.wait(1)
        subscriptionId = txReceipt.events[0].args.subId
    } else {
        vrfCoordinatorV2Address = networkConfig[chainId].vrfCoordinatorV2
        subscriptionId = networkConfig[chainId].subscriptionId
    }

    log("---------------------------------")
    await storeImages(imagesLocation)
    // const args = [
    //     vrfCoordinatorV2Address,
    //     subscriptionId,
    //     networkConfig[chainId].gasLane,
    //     networkConfig[chainId].callbackGasLimit,
    //     // tokenuris,
    //     networkConfig[chainId].mintFee,
    // ]
}

async function handleTokenUris() {
    tokenUris = []
    // store the Image in IPFS
    // store the metadata in IPFS

    return tokenUris
}

async function storeTokenUriMetadata(metadata) {
    tokenUris = []
    // store the Image in IPFS
    // Store the metadata in IPFS
    const {response: imageUploadResponses, files} = await storeImages(imageLocation)
}
module.exports.tags = ["all", "randomipfs", "main"]