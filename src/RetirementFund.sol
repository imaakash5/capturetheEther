//SPDX - License - Identifier : Unlicensed
pragma solidity ^0.8.23;

contract RetirementFund {
    mapping(address => uint256) balanceOfUser;
    uint64 depositTime = uint64(block.timestamp) + 365 * 60 * 60 * 24;
    address beneficiary;
    address owner = msg.sender;

    constructor(address beneficiary_) {
        beneficiary = beneficiary_;
    }

    function setBeneficiary(address beneficiary_) external {
        require(msg.sender == beneficiary, "Not a beneficiary");
        beneficiary = beneficiary_;
    }

    function depositFunds() external payable {
        require(msg.sender == owner);
        require(msg.value == 1 ether, "user deposits 1 ether");
        payable(address(this)).transfer(1 ether);
    }

    function withdraw() external payable {
        require(msg.sender == owner);
        if (
            block.timestamp < depositTime //,"Period less than 10 years");
        ) {
            payable(msg.sender).transfer(address(this).balance * 9 / 10);
        } else {
            payable(msg.sender).transfer(address(this).balance);
        }
    }

    function collectPenalty(address payable collector) public {
        require(msg.sender == beneficiary);
        if (address(this).balance > 0) {
            payable(collector).transfer(address(this).balance);
        }
    }

    receive() external payable {}
}
