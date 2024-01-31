// have a function to enter the lottery
import { useWeb3Contract } from "react-moralis"
import {abi, contractAddresses} from "../constants"
import { useMoralis } from "react-moralis"

export default function LotteryEntrace() {
    const {chainId: chainIdHex} = useMoralis()
    
    const {runContractFunction: enterRaffle} = useWeb3Contract({
        abi: abi,
        contractAddress: contractAddresses,
        functionName: "enterRaffle",
        params: {},
        msgValue: ,
    })
    return <div>Hi from lottery entrance!</div>
}