// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 函数签名(函数选择器)
// 代表虚拟机是如何找到函数的

contract Receiver {
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        // 第一部分:0xa9059cbb 就是address和uint类型经过下面操作的结果
        emit Log(msg.data);
        // 返回的部分 1.函数签名 2.参数
        // 将函数参数类型打包, 哈希后, 去前4位16进制中
    }
}

contract FunctionSelector {
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}