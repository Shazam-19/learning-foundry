// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "src/Wallet.sol";

contract AuthTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function testOwnerIsDeployer() public view {
        assertEq(wallet.owner(), address(this));
    }

    function testSetOwner() public {
        address newOwner = address(0x123);
        wallet.setOwner(payable(newOwner));
        assertEq(wallet.owner(), newOwner);
    }

    function testSetOwnerByNonOwnerShouldRevert() public {
        address newOwner = address(0x123);

        // Simulate a call from a non-owner
        vm.prank(address(0x456));

        vm.expectRevert("Not the owner");
        wallet.setOwner(payable(newOwner));
    }

    function testSetOwnerMultipleTimes() public {
        // The wallet owner is initially the deployer (this contract)
        // msg.sender = address(this)
        wallet.setOwner(payable(address(0x123)));

        vm.startPrank(address(0x123)); // Now the owner is address(0x123)

        // msg.msg.sender is now address(0x123), so this should succeed
        wallet.setOwner(payable(address(0x123)));
        wallet.setOwner(payable(address(0x123)));
        wallet.setOwner(payable(address(0x123)));

        vm.stopPrank();

        vm.expectRevert("Not the owner");
        // msg.sender is now address(this) again, which is not the owner anymore
        wallet.setOwner(payable(address(0x456))); // This should revert
    }
}
