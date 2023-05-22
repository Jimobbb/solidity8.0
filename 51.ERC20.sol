// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// ERC20的标准是 只要满足了ERC20的接口的合约 就叫ERC20合约

interface IERC20 {
    // 当前合约的token总量
    function totalSupply() external view returns (uint); 

    // 某一个账户的当前余额
    function balanceOf(address account) external view returns (uint);

    // 账户中的余额由当前账户发到另一个账户中——写入方法，向链外汇报一个transfer事件, 查询token流转
    function transfer(address recipient, uint amount) external returns (bool);

    // 把账户中的数量批准给另一个数量
    function approve(address spender, uint amount) external returns (bool);

    // 查询某一个账户对另一个账户的批准额度有多少
    function allowance(address owner, address spender) external view returns (uint);

    // 向另一个合约存款，调用方法将本账户的token拿到其合约 和approve联合使用
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}

contract ERC20 is IERC20 {
    uint public totalSupply; // token总量
    mapping (address => uint) public balanceOf; // 账户余额
    mapping (address => mapping(address => uint)) public allowance;
    string public name = "Test";
    string public symbol = "TEST";
    uint public decimals = 18;

    // 账户中的余额由当前账户发到另一个账户中——写入方法，向链外汇报一个transfer事件, 查询token流转
    function transfer(address recipient, uint amount) external returns (bool) {
        // 在发送者账户中- 在接收者账户中+
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // 把账户中的数量批准给另一个数量
    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // 向另一个合约存款，调用方法将本账户的token拿到其合约 和approve联合使用
    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // 铸币方法
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        // 铸币, 从0地址发出
        emit Transfer(address(0), msg.sender, amount);
    }

    // 销毁方法
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        // 销毁，最后是0地址
        emit Transfer(msg.sender, address(0), amount);
    }
}