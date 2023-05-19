// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 太消耗gas了
contract ArrayShift {
    uint[] public arr;

    function example() public {
        arr = [1, 2, 3];
        delete arr[1];
    }

    // [1,2,3] -- remove(1) -- [1,3,3]左移 -- [1,3]删除后面元素
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");
        for(uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
}