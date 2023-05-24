// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 节约gas的方案

contract GasGolf {
    // 1.使用calldata
    // 2.将状态变量放入memory
    // 3.减少编译路径长度
    // 4.减少循环增量(++i)
    // 5.减少缓存数组长度
    // 6.数组元素提前赋值于memory
    uint public total;
    function sumIfEvenAndLessThan99(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;

        for(uint i = 0; i < len; ++i) {
            uint num = nums[i];
            if (num % 2 == 0 && num < 99) {
                _total += num;
            }
        }
        total = _total;
    }
}