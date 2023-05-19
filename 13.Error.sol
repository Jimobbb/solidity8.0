// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// require revert assert 自定义error
// 节约gas 状态回滚

contract Error {
    function testRequire(uint _i) public pure {
        require(_i <= 10, "i > 10");
    }

    function testRevert(uint _i) public pure {
        if(_i > 10) {
            revert("i > 10");
        }
    }

    uint public num = 123;
    function testAssert() public view {
        assert(num == 123);
    }

    // 回收gas状态回滚的实例
    function foo(uint _i) public {
        num += 1;
        // 如果_i不小于10——前面即使运行了代码，数据也会被回滚，花费的gas费也会退回
        require(_i < 10);
    }

    // 自定义error
    // 如果是一个很长的字符串的报错信息，会浪费gas
    // 使用自定义变量，自定义报错信息
    error MyError(address caller, uint i);
    function testCustomError(uint _i) public view {
        if(_i > 10) {
            revert MyError(msg.sender, _i);
        }
    }
}