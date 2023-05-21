// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 发送ETH主币
// 三种方式
// transfer 2300gas 失败回滚
// send 2300gas 返回bool
// call 发送所有剩余gas 返回是否成功的bool和data

contract SendEther {
    constructor() payable {}

    // 只接受eth不接受数据——receive
    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123); 
    }
    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(123);
        require(sent, "send failed"); 
    }
    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 123}(""); 
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}