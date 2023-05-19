// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 数据存储位置 storage-状态变量 memory-局部变量 calldata-类似于memory但只能在输入的参数中
// 按cpp的区分：storage = 指针 memory = 局部变量(深拷贝)  calldata = 只能传递参数 引用
contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint[] calldata y, string calldata s) external returns (uint[] memory){
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});
        // storage状态变量会一直存储
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo";

        // memory局部变量，运行之后内存中就消失，不修改链上状态
        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.foo = 456;

        // 使用calldate可以将输入的参数直接传递给下一个变量
        _internal(y);
        // 将局部变量返回到链外
        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        return memArr;
    }

    function _internal(uint[] calldata y) private pure {
        uint x = y[0];
    }
}