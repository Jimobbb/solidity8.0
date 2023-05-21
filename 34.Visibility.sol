// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 可视范围
// 私有private —— 只合约内可见
// 内部internal —— 内部合约和子合约
// 公开public —— 内部和外部合约都可视，范围最大
// 外部external —— 只在外部合约看到，内部看不到

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }
    function internalFunc() internal pure returns (uint) {
        return 100;
    }
    function publicFunc() public pure returns (uint) {
        return 200;
    }
    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function examples() external view {
        // 除external内部都可以用
        x + y + z;

        privateFunc();
        internalFunc();
        publicFunc();
        // 只有external函数，不能在函数内部使用
        // 使用this, 先到合约外部再指定,不建议使用
        this.externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        // 继承的子合约：只能internal和public
        y + z;
        internalFunc();
        publicFunc();
    }
}