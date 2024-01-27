module.export = async function () {
    if(process.env.UPDATE_FRONT_END) {
        console.log("Updating front end")
        updateContractAddresses()
    }
}

async function updateContractAddresses() {
    const raffle = await ethers.getContract("Raffle")
}