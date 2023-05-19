// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 数组
contract Array {
    uint[] public nums = [1, 2, 3]; // 变化数组
    uint[3] public numsFixed = [4, 5, 6]; // 定长数组

    function examples() external {
        nums.push(4); // [1,2,3,4]
        uint x = nums[1]; // 访问数组元素
        nums[2] = 777; // [1,2,777,4]
        delete nums[1]; // [1,0,777,4] delete不能修改数组长度
        nums.pop(); // [1,0,777]
        uint len = nums.length; // 3;

        // 内存中创建数组
        uint[] memory a = new uint[](5);
        a[1] = 123;
        // 内存中的数组不能用pop push
    }

    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}