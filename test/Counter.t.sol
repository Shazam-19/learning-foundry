// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

/**
 * @title CounterTest
 * @notice Foundry test suite for the Counter contract.
 * @dev Each `test*` function is automatically discovered and run by `forge test`.
 *      `setUp()` runs before every individual test, giving each test a fresh
 *      contract instance to work with.
 *
 *      Run only this file:
 *        forge test --match-path test/Counter.t.sol
 *
 *      Run with a gas usage report:
 *        forge test --match-path test/Counter.t.sol --gas-report
 */
contract CounterTest is Test {
    /// @dev The Counter instance shared across all test functions in this suite.
    Counter public counter;

    /**
     * @notice Deploys a fresh Counter before each test.
     * @dev Foundry calls `setUp()` automatically before every `test*` function,
     *      ensuring tests are isolated and do not affect one another.
     */
    function setUp() public {
        counter = new Counter();
    }

    /**
     * @notice Verifies that `inc()` increases the count by 1.
     * @dev Starting from 0 (the default), a single `inc()` call should produce 1.
     */
    function testInc() public {
        counter.inc(); // Call inc() on the deployed Counter contract
        assertEq(counter.count(), 1); // Assert the count is now exactly 1
    }

    /**
     * @notice Verifies that `dec()` decreases the count by 1.
     * @dev Increments twice (count = 2), then decrements once (count = 1).
     *      Confirms the final value is 1.
     */
    function testDec() public {
        counter.inc(); // count → 1
        counter.inc(); // count → 2
        counter.dec(); // count → 1
        assertEq(counter.count(), 1);
    }

    /**
     * @notice Verifies that `dec()` reverts when the counter is at zero.
     * @dev `vm.expectRevert()` tells Foundry that the next call MUST revert.
     *      If it does not revert, this test fails.
     *      This version accepts any revert reason.
     */
    function testDecReverts() public {
        vm.expectRevert();
        counter.dec(); // Should revert — count is 0, underflow is not allowed
    }

    /**
     * @notice Verifies that `dec()` reverts with the specific `CounterUnderflow` error.
     * @dev `vm.expectRevert(selector)` is stricter than `vm.expectRevert()`:
     *      it checks that the revert reason exactly matches the custom error's
     *      4-byte selector. Use this when the error type matters, not just
     *      whether a revert occurred.
     *
     *      Example selector: `bytes4(keccak256("CounterUnderflow()"))`
     */
    function testDecRevertsWithCustomError() public {
        vm.expectRevert(Counter.CounterUnderflow.selector);
        counter.dec(); // Should revert with CounterUnderflow — count is 0
    }
}
