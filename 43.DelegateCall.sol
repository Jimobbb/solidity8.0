// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 传统调用方法
// A调用B 给B 100wei B调用C 给C 50wei
// A->B->C msg.sender = B msg.value = 50 
// C改变状态变量 ETH在C

// 委托调用
// A调用B 给B 100wei B委托调用C (delegate call)
// A->B->C msg.sender = A msg.value = 100
// B改变状态变量 ETH在B

contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;

    // 被调用合约的合约布局和委托合约的合约布局不一样时, 容易发生错误!
    // 在被调用合约的后面添加会避免这个问题——原因：栈式虚拟机，直接进行内存拷贝没有类型检查
    function setVars(uint _num) external payable {
        // 可以在这里面添加升级范式，作为可升级合约的模板
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable {
        (bool success,) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "delegatecall failed");
    }
}