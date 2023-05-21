// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 回退函数——函数不存在 & 直接发送ETH时调用
// 合约中携带了主币——有数据 fallback 没有数据 receive
// 如果receive不存在 都调用fallback

contract Fallback {
    // 调用函数中不存在的名称就进入回退函数中，但是不能接受ETH的直接发送
    // 加上payable才能接受ETH的发送
    event Log(string func, address sender, uint value, bytes data);
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    // 只接受ETH的方法, 必须加入payable, 只负责接受主币对于receive函数
    // 如果发送数据有其他的，就用fallback了
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
}