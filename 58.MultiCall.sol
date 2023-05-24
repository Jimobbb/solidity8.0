// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 一个多个合约的多次调用打包到一个交易中

contract TestMultiCall {
    // 要获取同一个区块的状态——这种无法调用
    function func1() external view returns (uint, uint) {
        return (1, block.timestamp);
    }

    function func2() external view returns (uint, uint) {
        return (2, block.timestamp);
    }

    function getData1() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.func1.selector);
    }

    function getData2() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.func2.selector);
    }
}

contract MultiCall {
    function multiCall(address[] calldata targets, bytes[] calldata data) 
        external 
        view 
        returns (bytes[] memory)
    {
        require(targets.length == data.length, "not same length");
        bytes[] memory results = new bytes[](data.length);

        for(uint i; i < targets.length; i++) {
            // 静态调用
            (bool success, bytes memory result) = targets[i].staticcall(data[i]);
            require(success, "call failed");
            results[i] = result;
        }

        return results;
    }
    // 调用结果：时间戳相同——在一个区块内调用
}