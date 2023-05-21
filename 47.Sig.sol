// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 通过智能合约验证签名——四个步骤
// 1.消息签名
// 2.消息哈希值  hash(message)
// 3.消息和私钥签名 sign(hash(message), private key) 链外
// 4.恢复签名——ecrecover(hash(message), signature) == signer

contract VerifySig {
    function verify(address _signer, string memory _message, bytes memory _sig)
        external pure returns (bool) 
    {
        // 对消息进行hash
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        // 恢复签名验证
        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        // 链下完成的签名，需要增加一个字符串再进行一次哈希
        // 理由：一次哈希会被数学破解，所以两次哈希且增加一个字符串
        return keccak256(abi.encodePacked(
                "\x19Ethereum Signed Message:\n32",
                _messageHash
        ));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns (address) {
        // 非对称加密
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        // ecrecover恢复签名
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "invalid length");
        // 内联汇编来分割
        assembly {
            // r:前32位 s:后32位 v:最后一位
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}