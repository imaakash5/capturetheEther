//SPDX - License - Identifier : Unlicensed
pragma solidity ^0.8.23;

import {DonationChallenge} from "../src/Donation.sol";
import {console, Test} from "forge-std/Test.sol";

contract TestDonation is Test {
    address admin;
    address user1;
    DonationChallenge mainContract;

    function setUp() external {
        admin = vm.addr(123456);
        vm.prank(admin);
        vm.deal(admin, 5 ether);
        mainContract = new DonationChallenge{value: 1 ether}();
        console.log(address(mainContract),"Donation address");
    }

    function test_isComplete() external view {
        bool isComplete = mainContract.isComplete();
        assertEq(isComplete, false);
    }

    function test_donate() external {
        vm.deal(user1, 5 ether);
        vm.prank(user1);
        
        mainContract.donate{value: 3 ether}();
        assertEq(address(mainContract).balance, 4 ether);
    }

    function test_withdraw() external{
        vm.prank(user1);
        vm.expectRevert();
        mainContract.withdraw();
    }
}
