//SPDX - Identifier : License : Unlicensed
pragma solidity ^0.8.23;

contract Tokensale {
    uint256 pricePerToken = 1 ether;
    mapping(address => uint256) private tokensBalance;

    constructor() payable {
        require(msg.value == 1 ether, "1 ether is required for deployment");
    }

    function isComplete() external view returns (bool isComplete_) {
         if(address(this).balance < 1 ether)  //"balance > 1 ether");
            isComplete_ = true;
    }

    function buy(uint256 numberOfTokens) external payable {
        require(msg.value >= (numberOfTokens * pricePerToken), "BUY : Insufficient funds");
        tokensBalance[msg.sender] += numberOfTokens;
    }

    function sell(uint256 numberOfTokens) external {
        require(numberOfTokens <= tokensBalance[msg.sender], "Insufficient tokens");
        tokensBalance[msg.sender] -= numberOfTokens;
        payable(msg.sender).transfer(numberOfTokens * pricePerToken);
    }

    function checkBalance() external view returns (uint256) {
        return tokensBalance[msg.sender];
    }
}
