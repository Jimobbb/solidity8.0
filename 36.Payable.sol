// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 支付eth
// payable关键词，函数可以接受以太坊主币的介入，不标记就会报错
// address标注payable——可以发送以太坊主币

contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 在remix中此函数会变成 红色 证明可以接受eth主币
    function deposit() external payable {}

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}