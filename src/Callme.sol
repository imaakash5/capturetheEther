//SPDX - License - Identifier : Unlicensed
pragma solidity ^0.8.23;

contract Callme {
    bool public isComplete = false;

    function callme() public {
        isComplete = true;
    }
}
