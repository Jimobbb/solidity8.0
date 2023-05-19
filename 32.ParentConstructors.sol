// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 已知参数内容——直接传递参数
contract U is S("s"), T("t") {

}

contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

// 混搭使用——S T VV初始化顺序
contract VV is S("s"), T {
    constructor(string memory _name, string memory _text) T(_text) {

    }
}
// 按照继承的顺序运行合约
