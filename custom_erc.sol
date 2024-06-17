//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Custom_ERC20 is ERC20 {

    constructor(string memory _Token_Name, string memory _Token_Symbol,uint256 initialSupply) ERC20(_Token_Name, _Token_Symbol) {
        _mint(msg.sender, initialSupply);
    }

    function mint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    } 

    function burn(uint256 _amount) public {
        _burn(msg.sender, _amount);
    }
}
