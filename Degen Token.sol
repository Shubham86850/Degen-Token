// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DegenToken {
    string public name = "Degen";
    string public symbol = "DGN";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;
    mapping(address => uint256) private redeemedTokens;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 amount);
    event Redeem(address indexed from, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Mint to zero address");
        totalSupply += amount;
        balances[to] += amount;
        emit Mint(to, amount);
        emit Transfer(address(0), to, amount);
    }

    function redeem(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        redeemedTokens[msg.sender] += amount;
        _burn(msg.sender, amount);
        emit Redeem(msg.sender, amount);
    }

    function redeemedTokensOf(address account) external view returns (uint256) {
        return redeemedTokens[account];
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "Burn from zero address");
        require(balances[account] >= amount, "Burn amount exceeds balance");
        totalSupply -= amount;
        balances[account] -= amount;
        emit Burn(account, amount);
        emit Transfer(account, address(0), amount);
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0) && recipient != address(0), "Invalid address");
        require(balances[sender] >= amount, "Insufficient balance");
        require(balances[sender] - redeemedTokens[sender] >= amount, "Exceeds available balance after redemption");

        balances[sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address tokenOwner, address spender) external view returns (uint256) {
        return allowances[tokenOwner][spender];
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        require(allowances[sender][msg.sender] >= amount, "Exceeds allowance");
        _transfer(sender, recipient, amount);
        allowances[sender][msg.sender] -= amount;
        return true;
    }
}



