// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// create2 合约部署合约
// 特点：部署合约前可以计算出来合约地址

contract DeployWithCreate2 {
    // 被部署的合约
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

contract Create2Factory {
    event Deploy(address addr);

    // create2方式——salt变量, 改变salt值可以改变新部署合约的地址
    function deploy(uint _salt) external {
        DeployWithCreate2 _contract = new DeployWithCreate2{
            salt: bytes32(_salt)
        }(msg.sender);
        emit Deploy(address(_contract));
    }

    // 计算地址
    function getAddress(bytes memory bytecode, uint _salt) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), _salt, keccak256(bytecode)
            )
        );
        // uint160 地址标准格式
        return address(uint160(uint(hash)));
    }

    // 计算机器码
    function getBytecode(address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}