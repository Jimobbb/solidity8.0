// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Immutable {
    // immutable可以在合约部属时定义值，比常量省gas
    address public immutable owner = msg.sender;

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}