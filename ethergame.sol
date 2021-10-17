//SPDX-License-Identifier:MIT
pragma solidity ^0.6.2;
//14th person to deposit 1ether wins all the ether(14)
//we need a targetAmount = 14ether
// we need a balance state variable to prevent forceful sending ether(as long as it's below 14)
// address of the winner
// a payable function to send ether to(deposit)
//ensure msg.value is 1ether and not anything less
//update the balance with the msg.value manually 
//as long as balance is less than target amount then "game is over"
//winner when balance is equal to target amount
//winner is set to the msg.sender 
//claim reward function that can only be called by the winner 
//that'll send the balance to the winner once claimed
//function for checking balance

contract EtherGame {
    address public winner;
    uint public targetAmount = 14 ether;
    uint public balance;
    
    function deposit() public payable {
        require(msg.value == 1 ether, "Only accepts 1 ether");
        
        balance += msg.value;
        
        require(balance <= targetAmount, "Game Over!");
        
        if(balance == targetAmount) {
            winner = msg.sender;
            balance = 0 ether;
        }
    }
    
    function claimReward() public {
        require(msg.sender == winner, "Not the winner");
        
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
    
    function checkBalance() public view returns(uint) {
        
        return address(this).balance;
        
        
    }
    
    
    
    
    
    
    
    
    
    
}