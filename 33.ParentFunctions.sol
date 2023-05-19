// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 调用父合约的函数
// FG继承E H继承FG

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar(); // super自动寻找父级合约并调用函数
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

contract H is F, G {
    function foo() public virtual override(F, G) {
        // 先触发F.foo 后触发E.foo
        F.foo();
    }

    function bar() public virtual override(F, G) {
        // G F E, 根据继承顺序来决定
        super.bar();
    }
}