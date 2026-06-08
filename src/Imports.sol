// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "solady/src/tokens/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Token is ERC20 {
    function name() public pure override returns (string memory) {
        return "My Token";
    }

    function symbol() public pure override returns (string memory) {
        return "MTK";
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    constructor() {
        _mint(msg.sender, 1_000_000 ether);
    }
}
