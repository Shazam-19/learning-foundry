// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Wallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function withdraw(uint256 _amount) external onlyOwner {
        require(_amount <= address(this).balance, "Insufficient balance");

        owner.transfer(_amount);
    }

    function setOwner(address payable _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }

    function restrictedFunction() public onlyOwner {
        // Function logic that should only be accessible by the owner
    }

    receive() external payable {} // Accept incoming Ether transfers
}
