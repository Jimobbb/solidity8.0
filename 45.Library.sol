// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 库合约
library Math {
    // 一定要用internal才有意义
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint x) internal view returns (uint) {
        for(uint i = 0; i < arr.length; i++) {
            if(arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract Test {
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}

contract TestArray {
    using ArrayLib for uint[]; // 让uint[]类型添加ArrayLib的功能,类似于JS的添加原型
    uint[] public arr = [3, 2, 1];

    function testFind() external view returns (uint i) {
        return arr.find(2);
    }
}