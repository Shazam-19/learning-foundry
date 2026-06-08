// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// This console feature is only available during testing and allows us to print debug information.
// It should be removed or commented out in production code to save gas and avoid unnecessary imports.
import "forge-std/console.sol";

/**
 * @title Counter
 * @notice A simple on-chain counter that can be incremented or decremented.
 * @dev Demonstrates basic state variables, custom errors, and external functions.
 *      The counter is stored permanently on the blockchain and starts at zero.
 */
contract Counter {
    /// @notice The current value of the counter. Publicly readable by anyone.
    uint256 public count;

    /**
     * @notice Thrown when `dec()` is called but the counter is already at zero.
     * @dev Using a custom error instead of `require` saves gas on revert.
     */
    error CounterUnderflow();

    /**
     * @notice Increases the counter by 1.
     * @dev Safe from overflow in Solidity 0.8+ — arithmetic reverts automatically
     *      if the value exceeds the maximum uint256 (~1.15 × 10^77).
     */
    function inc() external {
        console.log("Current count before incrementing:", count);
        count += 1;
    }

    /**
     * @notice Decreases the counter by 1.
     * @dev Reverts with `CounterUnderflow` if `count` is already 0,
     *      preventing unsigned integer underflow (which would otherwise wrap
     *      around to a very large number in older Solidity versions).
     */
    function dec() external {
        if (count == 0) {
            revert CounterUnderflow();
        }
        count -= 1;
    }
}
