// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ConsoleTest is Test {
    function testConsole() public pure {
        console.log("Hello, Foundry! This is a console log from a test.");
        uint256 value = 42;
        console.log("The answer to the Ultimate Question of Life, The Universe, and Everything is:", value);

        int256 x = -10;
        console.log(x);
    }
}
