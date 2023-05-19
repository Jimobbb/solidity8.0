// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 函数修改器——使复用的代码简化
// basic inputs sandwich
// java 拦截器

contract FunctionModifier {
    bool public paused;
    uint public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    modifier whenNotPaused() {
        require(!paused, "paused");
        _;  // 下划线代表其他代码在哪里运行，调回原函数
    }

    // 函数运行起来先进入modifier中确认
    function inc() external whenNotPaused {
        // require(!paused, "paused");
        count++;
    }

    function dec() external whenNotPaused {
        // require(!paused, "paused");
        count--;
    }

    modifier cap(uint _x) {
        require(_x < 100, "x >= 100");
        _;
    }
    function incBy(uint _x) external whenNotPaused cap(_x) {
        // require(_x < 100, "x >= 100");
        count += _x;
    }

    // 三明治式写法——将代码夹在中间
    modifier sandwich() {
        count += 10;
        _;
        count *= 2;
    }
    function foo() external sandwich {
        // 先进入modifier+=10，再+=1 最后*=2
        count += 1;
    }
}