// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 *
 * @title Wallet
 * @notice A simple wallet contract that stores Ether and allows the owner
 * ```
 *       to withdraw funds and transfer ownership.
 *   ```
 * @dev The deployer becomes the initial owner.
 */
contract Wallet {
    // Address that controls this wallet contract.
    address payable public owner;

    /**
     * @notice Sets the deployer as the initial owner.
     * @dev msg.sender is the account or contract that deploys the contract.
     */
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     *
     * @notice Restricts access to the current owner.
     * @dev Reverts if the caller is not the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");

        _;
    }

    /**
     *
     * @notice Withdraws Ether from the contract.
     * @param _amount Amount of Ether (in wei) to withdraw.
     * @dev Only the owner can call this function.
     */
    function withdraw(uint256 _amount) external onlyOwner {
        require(_amount <= address(this).balance, "Insufficient balance");

        owner.transfer(_amount);
    }

    /**
     *
     * @notice Transfers ownership of the wallet to a new address.
     * @param _newOwner Address of the new owner.
     * @dev The zero address is not allowed.
     */
    function setOwner(address payable _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Invalid address");

        owner = _newOwner;
    }

    /**
     *
     * @notice Accepts incoming Ether transfers.
     * @dev Executes when Ether is sent without calldata.
     */
    receive() external payable {}
}
