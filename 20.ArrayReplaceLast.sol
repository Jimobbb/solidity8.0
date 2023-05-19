// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 通过最后一个元素替换，节省gas
contract ArrayReplaceLast {
    uint[] public arr;

    // [1,2,3,4] -- remove(1) -- [1,4,3]
    // [1,4,3] -- remove(2) -- [1,4]
    function remove(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }
}