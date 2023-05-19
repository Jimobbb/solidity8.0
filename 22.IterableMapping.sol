// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract IterableMapping {
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint _val) external {
        balances[_key] = _val;
        if(!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    // 返回数组中第一个地址的余额
    function first() external view returns (uint) {
        return balances[keys[0]];
    }

    // 返回数组中最后一个地址的余额
    function last() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    // 返回任意一个地址的余额
    function get(uint _i) external view returns (uint) {
        return balances[keys[_i]];
    }
}