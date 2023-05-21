// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

// 创建工厂合约
contract AccountFactory {
    Account[] public accounts;
    function createAccount(address _owner) external payable {
        Account account = new Account{value: 111}(_owner); // 可以记录创建的地址, value传入主币
        accounts.push(account);
    }
}