// have a function to enter the lottery
import { useWeb3Contract } from "react-moralis"
import {abi, contractAddresses} from "../constants"
import { useMoralis } from "react-moralis"
import { useEffect, useState } from "react"
import { ethers } from "ethers"

export default function LotteryEntrace() {
    const {chainId: chainIdHex} = useMoralis()
    const chainId = parseInt(chainIdHex)
    const raffleAddress = chainIdHex in contractAddresses ? contractAddresses[chainId][0] : null
    const [entranceFee, setEntranceFee] = useState("0")
    
    const {runContractFunction: enterRaffle} = useWeb3Contract({
        abi: abi,
        contractAddress: raffleAddress,
        functionName: "enterRaffle",
        params: {},
        msgValue: ,
    })

    const {runContractFunction: getEntranceFee} = useWeb3Contract({
        abi: abi,
        contractAddress: raffleAddress,
        functionName: "getEntranceFee",
        params: {},
    })

    useEffect(() => {
        if (isWeb3Enabled) {
            async function updateUI() {
                const entranceFeeFromcall = (await getEntranceFee()).toString()
                setEntranceFee(ethers.utils.formatUnits(entranceFeeFromcall, "ether"))
            }
            updateUI()
        }
    }, [isWeb3Enabled])

    return <div>Hi from lottery entrance!</div> <div>Entrance Fee: {entranceFee} ETH</div>
}