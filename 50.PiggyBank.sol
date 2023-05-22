// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 小猪存钱罐
// 任何人都可以向其发送eth,只有合约拥有者才能取出eth,取出后会被自毁

contract PiggyBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        // 使用selfdestruct——利用其调用后销毁合约，并把所有eth转移到某地址中
        selfdestruct(payable(msg.sender));
    }
}