// in node.js
// require()

// in front-end javascript you can't use require
// import
import {ethers} from "./ethers-5.6.esm.min.js"
import {abi, contractAddress} from "./constants.js"

const connectButton = document.getElementById("connectButton")
const fundButton = document.getElementById("fundButton")
connectButton.onclick = connect
fundButton.onclick = fund

console.log(ethers)

async function connect(){
    if (typeof window.ethereum !== "undefined"){
        window.ethereum.request({method: "eth_requestAccounts"})
        connectButton.innerHTML = "Connected!"
    } else {
        connectButton.innerHTML = "Please install metamask!"
    }
}

async function fund() {
    const ethAmount = "0.1"
    console.log(`Funding with ${ethAmount}...`)
    if (typeof window.ethereum !== "undefined"){
        // provider / connection to the blockchain
        // signer / wallet / someone with some gas
        // contract that we are interaction with
        // ^ ABI & Address
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const signer = provider.getSigner()
        console.log(signer)
        const contract = new ethers.Contract(contractAddress, abi, signer)
        try {
        const transactionResponse = await contract.fund({value: ethers.utils.parseEther(ethAmount)})
        } catch(error)
    }
}

// fund function

// withdraw
