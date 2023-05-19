// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 事件——体现在交易记录或浏览器的logs中，通过事件可以查看状态
contract Event {
    event Log(string message, uint val);
    // indexed标记一个索引，可以链外查询
    // 有index的变量最多3个
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 789);
    }

    // 链外调用可以用消息变量，可以用事件
    // 事件更省gas
    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}