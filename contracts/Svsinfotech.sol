/*
'########::'########::'#######::'##::: ##:'####:
 ##.... ##: ##.....::'##.... ##: ###:: ##:. ##::
 ##:::: ##: ##::::::: ##:::: ##: ####: ##:: ##::
 ##:::: ##: ######::: ##:::: ##: ## ## ##:: ##::
 ##:::: ##: ##...:::: ##:::: ##: ##. ####:: ##::
 ##:::: ##: ##::::::: ##:::: ##: ##:. ###:: ##::
 ########:: ########:. #######:: ##::. ##:'####:
........:::........:::.......:::..::::..::....:: 
*/
// For More Information Contact : info@deoni.world

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract Svsinfotech is ERC20Capped, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    mapping(address => uint256) private _balances;

    constructor() ERC20("SVSINFOTECH", "SVSINFO") ERC20Capped(cap()) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function cap() public view virtual override returns (uint256) {
        return 10000000000*10**18;
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        require(totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        _mint(to, amount);
    }
}

// Made with love by Deoni Foundation
// www.deoni.world
// "We never dream about SUCCESS, We work for it". 