// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Counter {
    uint public count;

    // 因为要改变值，所以不能有view/pure
    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}