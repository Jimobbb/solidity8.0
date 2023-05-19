// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 全局变量——不用定义就能显示内容的变量——记录链上信息
contract GlobalVariables {
    // view可以读取状态和全局变量，pure不可以
    function globalVars() external view returns (address, uint, uint) {
        address sender = msg.sender; // 账户内容，(上一个)调用合约的地址
        uint timestamp =  block.timestamp; // 区块的时间戳——体现当前按下按钮的时间，如果是初始区块就是初始创建的时间
        uint blockNum = block.number; // 区块编号
        return (sender, timestamp, blockNum);
    }
}

// 0:
// address: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 1:
// uint256: 1684416879
// 2:
// uint256: 9