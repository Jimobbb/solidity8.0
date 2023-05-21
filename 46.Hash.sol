// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 1.输入值相同，输出值一定相同
// 2.无论输入值有多大，输出值定长且不可逆
contract HashFunc {
    // hash的标准格式 bytes32
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        // 智能合约中特定的hash算法函数
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function encode(string memory text0, string memory text1) external pure returns (bytes memory) {
        // 打包后会给16进制补0
        return abi.encode(text0, text1);
    }
    
    function encodePack(string memory text0, string memory text1) external pure returns (bytes memory) {
        // 只是进行转化为16进制，不会补0 —— 容易有漏洞出现
        return abi.encodePacked(text0, text1);
    }

    // hash碰撞试验
    function collision(string memory text0, uint x, string memory text1) external pure returns (bytes32) {
        // 打包后不补0——不同的参数同样的哈希值，导致错误，所以选择encode打包来解决
        // 另一种解决方案，把两个字符串隔开(例如用别的参数隔开)
        return keccak256(abi.encodePacked(text0, x, text1));
    }
}