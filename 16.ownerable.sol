// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 制作一个完整的合约
// 状态变量，全局变量，函数修改器，函数，错误控制
// ownerable合约——常见的以太坊合约, 可以设置管理员的地址

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "invalid addresss");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() external onlyOwner() {
        // code
    }

    function anyOneCanCall() external {
        // code
    }
}