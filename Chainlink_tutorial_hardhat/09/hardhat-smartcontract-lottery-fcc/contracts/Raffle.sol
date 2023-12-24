// Raffle
// Enter the lottery (paying some amount)
// Pick a random winner (verifiably random)
// Winner to be selected every X minutes -> completly automate
// Chainlink Oracle -> Randomness, Automated Execution (Chainlink Keeper)

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/automation/KeeperCompatible.sol";

error Raffle__NotEnoughETHEntered();
error Raffle__TransferFailed();
error Raffle__NotOpen();

contract Raffle is VRFConsumerBaseV2, KeeperCompatible {
    /* Type declarations */
    enum RaffleState {
        OPEN,
        CALCULATING
    }

    /* State Variables */
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    // Lottery Variables
    address private s_recentWinner;
    RaffleState private s_raffleState;

    /* Events */
    event RaffleEnter(address indexed player);
    event RequestedRaffleWinner(uint256 indexed requestId);
    event WinnerPicked(address indexed winner);
    
    constructor(address vrfCoordinatorV2, uint256 entranceFee, bytes32 gasLane, uint64 subscriptionId, uint32 callbackGasLimit) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_entranceFee = entranceFee;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_raffleState = RaffleState.OPEN;
    }

    function enterRaffle() public payable {
        // require (msg.value > i_entranceFee, "Not enough ETH!")
        if(msg.value < i_entranceFee){revert Raffle__NotEnoughETHEntered();}
        if(s_raffleState != RaffleState.OPEN){
            revert Raffle__NotOpen();
        }
        s_players.push(payable(msg.sender));
        // Emit an event when we update a dynamic array or mapping
        // Named events with the function name reversed
        emit RaffleEnter(msg.sender);
    }

    /** 
     * @dev This is the function that the Chainlink Keeper nodes call
     * they look for the `upkeepNeeded` to return true.
     * The following should be true in order to return true:
     * 1. Our time interval should have passed
     * 2. The lottery should have at least 1 player, and have some ETH
     * 3. Our subscription is funded with LINK
     * 4. The lottery should be in an "open" state.
     */
    function checkUpkeep(bytes calldata /* checkData */) external override returns (bool ) {
        
    }

    function requestRandominner() external {
        // Request the random number
        // Once we get it, do something with it
        // 2 transaction process 
        s_raffleState = RaffleState.CALCULATING;
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, // gasLane
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
        emit RequestedRaffleWinner(requestId);
    }

    function fulfillRandomWords(uint256 /*requestId*/, uint256[] memory randomWords) internal override {
        uint256 indexOfWinner = randomWords[0] % s_players.length;
        address payable recentWinner = s_players[indexOfWinner];
        s_recentWinner = recentWinner;
        s_raffleState = RaffleState.OPEN;
        (bool success, ) = recentWinner.call{value: address(this).balance}("");
        if(!success){
            revert Raffle__TransferFailed();
        }
        emit WinnerPicked(recentWinner);
    }

    /* View / Prue functions */
    function getEntranceFee() public view returns(uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns(address) {
        return s_players[index];
    }

    function getRecentWinner() public view returns(address) {
        return s_recentWinner;
    }
}