// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 多签钱包——必须有多个人同意的情况下才能把资金转出

contract MultiSigWallet {
    // 存款
    event Deposit(address indexed sender, uint amount);
    // 提交交易申请
    event Submit(uint indexed txId);
    // 合约签名人进行批准
    event Approve(address indexed owner, uint indexed txId);
    // 撤销批准
    event Revoke(address indexed owner, uint indexed txId);
    // 执行
    event Execute(uint indexed txId);

    struct Transaction {
        address to; // 目标地址
        uint value; // 发送金额
        bytes data; // 若目标是合约地址，可以执行合约函数
        bool executed; // 是否被执行成功
    }

    address[] public owners; // 保留所有签名人
    mapping(address => bool) public isOwner; // 查找是否是签名人的地址
    uint public required;

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public approved;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint _txId) {
        // 交易id < 数组长度 交易存在
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint _txId) {
        // 当前某人没批准
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(transactions[_txId].executed, "tx already executed");
        _;
    }

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required");
        require(
            _required > 0 && _required <= _owners.length,
            "invalid required number of owner"
        );
        for(uint i; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner {
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));
        // 数组坐标就是交易id
        emit Submit(transactions.length - 1);
    }

    function approve(uint _txId) 
        external 
        onlyOwner 
        txExists(_txId) 
        notApproved(_txId) 
        notExecuted(_txId) 
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    // 计算有多少人批准了合约
    function _getApprovalCount(uint _txId) private view returns (uint count) {
        for(uint i; i < owners.length; i++) {
            if(approved[_txId][owners[i]]) {
                count++;
            }
        }
    }

    // 执行
    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovalCount(_txId) >= required, "approved < required");
        Transaction storage transaction = transactions[_txId];

        transaction.executed = true;

        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "tx failed");

        emit Execute(_txId);
    }

    // 撤回
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}