//SPDX _ Identifier - License : Unlicensed
pragma solidity ^0.8.23;

contract GuesstheChallenge {
    uint8 public answer;

    constructor() payable {
        answer = 42;
        require(msg.value == 1 ether, "balance is not 1");
    }

    receive() external payable {}

    function isComplete() external view returns (bool) {
        return address(this).balance == 0;
    }

    function guesstheNumber(uint8 number, address payable recipient) external payable {
        require(msg.value == 1 ether, "gamer pay 1ether");
        if (number == answer) {
            recipient.transfer(2 ether); //{value: 2 ether}("");
        }
    }
}
