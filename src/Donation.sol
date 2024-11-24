//SPDX - Identifier : License : Unlicensed
pragma solidity ^0.8.23;

contract DonationChallenge {
    address owner;

    constructor() payable {
        require(msg.value == 1 ether);
        owner = msg.sender;
    }

    struct Donation {
        uint256 amount;
        uint256 timeStamp;
    }

    Donation[] public donations;

    function isComplete() external view returns (bool) {
        return (address(this).balance == 0);
    }

    function donate() external payable {
        require(msg.value > 0, "funds >0");
        Donation memory donation;
        donation.timeStamp = block.timestamp;
        donation.amount = msg.value;
        donations.push(donation);
    }

    function withdraw() external payable {
        require(msg.sender == owner, "not the owner");
        require(address(this).balance > 0, "contract do not have enough funds");
        payable(msg.sender).transfer(address(this).balance);
    }

    //constructor - deploy 1 ether
    //withdraw - withdraw the money
    //iscomplete - check if the work is done or not
    //donate - to donate the money
    //steal the contracts ether
}
