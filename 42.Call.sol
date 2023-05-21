// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 低级调用合约——call
// 本节实例不好用，参考下面原版英文实例
contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 999);
    }
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 111, gas: 5000}(
            abi.encodeWithSignature(
                "foo(string,uint256)", "call foo", 123
            )
        );
        require(success, "call failed");
        data = _data;
    }

    function callDoesNotExit(address _text) external {
        (bool success, ) = _text.call(abi.encodeWithSignature("doesNotExist()"));
        require(success, "call failed");
    }
}

// 原版英文实例
contract Receiver {
    event Received(address caller, uint amount, string message);

    receive() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    function foo(string memory _message, uint _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }
}

contract Caller {
    event Response(bool success, bytes data);

    // Let's imagine that contract B does not have the source code for
    // contract A, but we do know the address of A and the function to call.
    function testCallFoo(address payable _addr) public payable {
        // You can send ether and specify a custom gas amount
        (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );

        emit Response(success, data);
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address _addr) public {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }
}