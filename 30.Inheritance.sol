// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// A为父合约，B为子合约
// virtual定义哪些是可以重写的函数
// override定义哪些是覆盖可以重写的函数

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }
    
    // 完全被B继承
    function baz() public pure returns (string memory) {
        return "A";
    }
}

// B是A的子合约——B is A
contract B is A {
    function foo() public pure override returns (string memory) {
        return "B";
    }

    function bar() public pure override returns (string memory) {
        return "B";
    }
}