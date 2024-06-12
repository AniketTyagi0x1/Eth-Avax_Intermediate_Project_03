// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ERC20_self {

    // name of a custom token 
    string public name;

    // symbol of a custom token 
    string public symbol;

    // represent a decimal value for the tokens 
    uint8 public decimals;

    // Total Supply that represent a supply of a token 
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    // Allowance - A special type of mapping that store the allowance of a each address to spend tokens
    mapping(address => mapping(address => uint256)) public allowance;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 10**uint256(_decimals); // 10
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        
        require(_to != address(0), "Wrong address");
        require(balanceOf[msg.sender] >= _value, "Low balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != address(0), "Wrong address");
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        
        require(_from != address(0), "Wrong address");
        require(_to != address(0), "Wrong address");
        require(balanceOf[_from] >= _value, "Low balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance Not Working");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        
        require(_to != address(0), "Wrong address");
        totalSupply += _amount;
        balanceOf[_to] += _amount;
        emit Transfer(address(0), _to, _amount);
    }

    function burn(uint256 _amount) public {
        require(balanceOf[msg.sender] >= _amount, "low` balance");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Transfer(msg.sender, address(0), _amount);
    }
}
