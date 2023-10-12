// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;
    mapping (address => uint) public balances;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");
        require(balances[msg.sender] != 0, "you dont have any balance")

        uint wwithdrawAmount = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(withdrawAmount);
        emit Withdrawal(withdrawAmount, block.timestamp);
    }


    function deposit() public payable {
        require(msg.sender != address(0), "caller is a zero address");
        balances[msg.sender] = msg.value;
        emit Deposit(msg.sender, msg.value, block.timestamp)
    }
}
