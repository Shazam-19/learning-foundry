// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "src/Wallet.sol";

/**
 * @title AuthTest
 * @notice Tests ownership and access-control behavior of the Wallet contract.
 */
contract AuthTest is Test {
    // Wallet instance used for testing.
    Wallet public wallet;

    // Deploys a fresh Wallet contract before each test.
    function setUp() public {
        wallet = new Wallet();
    }

    /**
     * @notice Verifies that the deployer becomes the initial owner.
     * @dev Since this test contract deploys Wallet, address(this) should be the owner.
     */
    function testOwnerIsDeployer() public view {
        assertEq(wallet.owner(), address(this));
    }

    // Verifies that the owner can transfer ownership.
    function testSetOwner() public {
        address newOwner = address(0x123);

        wallet.setOwner(payable(newOwner));

        assertEq(wallet.owner(), newOwner);
    }

    // Verifies that a non-owner cannot transfer ownership.
    function testSetOwnerByNonOwnerShouldRevert() public {
        address newOwner = address(0x123);

        // Simulate the next call as address(0x456)
        // instead of 'address(this)'
        vm.prank(address(0x456));

        vm.expectRevert("Not the owner");
        wallet.setOwner(payable(newOwner));
    }

    /**
     * @notice Verifies ownership behavior after multiple ownership changes.
     * @dev Demonstrates how startPrank changes msg.sender for multiple calls.
     */
    function testSetOwnerMultipleTimes() public {
        // Ownership is transferred from address(this)
        // to 'address(0x123)'
        wallet.setOwner(payable(address(0x123)));

        // All subsequent calls are executed as address(0x123)
        // until 'vm.stopPrank()' is called.

        vm.startPrank(address(0x123));

        // address(0x123) is the current owner,
        // so all calls satisfy the 'onlyOwner' modifier.

        wallet.setOwner(payable(address(0x123)));
        wallet.setOwner(payable(address(0x123)));
        wallet.setOwner(payable(address(0x123)));

        vm.stopPrank();

        // Calls now originate from 'address(this)' again.
        // Since ownership belongs to address(0x123),
        // this call should revert.

        vm.expectRevert("Not the owner");

        wallet.setOwner(payable(address(0x456)));
    }
}
