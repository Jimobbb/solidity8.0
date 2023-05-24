// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 多重委托调用
// A -> 多重调用 后面调用完看到的msg.sender上一级
// A -> 多重委托调用 最后看到的，还是msg.sender = A 本人

// 委托调用合约：必须继承使用
// 漏洞——重复调用时，可能会存在增加余额，产生漏洞
// 不要重复计算eth数量，或者不许计算eth
contract MultiDelegateCall {
    error DelegatecallFailed();

    function multiDelegateCall(bytes[] calldata data)
        external
        payable
        returns (bytes[] memory results)
    {
        results = new bytes[](data.length);

        for(uint i; i < data.length; i++) {
            (bool ok, bytes memory res) = address(this).delegatecall(data[i]);
            if(!ok) {
                revert DelegatecallFailed();
            }
            results[i] = res;
        }
    }
}

contract TestMultiDelegatecall is MultiDelegateCall {
    event Log(address caller, string func, uint i);

    function func1(uint x, uint y) external {
        emit Log(msg.sender, "func1", x + y);
    }

    function func2() external returns (uint) {
        emit Log(msg.sender, "func2", 2);
        return 111;
    }
}

contract Helper {
    function getFunc1Data(uint x, uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func1.selector, x, y);
    }

    function getFunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func2.selector);
    }
}