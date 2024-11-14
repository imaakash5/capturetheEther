//SPDX - Identifier - License : Unlicensed
pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {GuesstheChallenge} from "../src/GuessNumber.sol";

contract TestGuessNumber is Test {
    address admin;
    GuesstheChallenge mainContract;

    function setUp() public {
        admin = vm.addr(12020111);
        vm.deal(admin, 3 ether);
        vm.prank(admin);
        mainContract = new GuesstheChallenge{value: 1 ether}();
        console.log(admin.balance, "balance");
    }

    function test_setUp() external view {
        assertEq(admin.balance, 2 ether);
    }

    function test_guesstheNumber_negative() external {
        vm.prank(admin);
        console.log(address(mainContract).balance, "contract balance before play");
        mainContract.guesstheNumber{value: 1 ether}(35, payable(msg.sender));
        console.log(address(mainContract).balance, "contract balance after play");
        (bool isComplete) = mainContract.isComplete();
        assertEq(isComplete, false);
    }

    function test_guesstheNumber_positive() external {
        vm.prank(admin);
        console.log(address(mainContract).balance, "contract balance before play");
        mainContract.guesstheNumber{value: 1 ether}(42, payable(msg.sender));
        console.log(address(mainContract).balance, "contract balance after play");
        (bool isComplete) = mainContract.isComplete();
        assertEq(isComplete, true);
    }
}
