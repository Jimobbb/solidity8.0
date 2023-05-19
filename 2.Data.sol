// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 数据类型常用变量

contract ValueTypes {
    bool public b = true;
    uint public u = 123; 
    // uint = uint256 0-2**256-1
    //        uint8 0-2**8-1
    //        uint16 0-2**16-1
    int public i = -123; 
    // int = int256 -2**255~2*255-1
    //       int128 -2**127~2*127-1
    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    // 地址类型address——通过计算算出来
    address public addr = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    // bytes类型——比地址长一点
    // bytes32 public b32 = 0xd9145CCE52D386f254917e481eB44e9943F39138;
}