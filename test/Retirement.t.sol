//SPDX - Identifier - License : Unlicensed
pragma solidity ^0.8.23;

import {console, Test} from "forge-std/Test.sol";
import {RetirementFund} from "../src/RetirementFund.sol";

contract TestRetirementFund is Test {
    RetirementFund fund;
    address admin;
    address user1;
    address payable user2;

    function setUp() external {
        admin = vm.addr(12334);
        user1 = vm.addr(73929272);
        user2 = payable(vm.addr(3202002002));
        vm.prank(admin);
        fund = new RetirementFund(user1);
    }

    function test_depositFunds() external {
        vm.deal(admin, 1 ether);
        vm.prank(admin);
        fund.depositFunds{value: 1 ether}();
        assertEq(address(fund).balance, 1 ether);
    }

    function test_withdraw() external {
        vm.deal(admin, 1 ether);
        vm.prank(admin);
        fund.depositFunds{value: 1 ether}();
        vm.warp(block.timestamp + 10 days);
        vm.prank(admin);
        console.log(admin.balance, "owner's balance");
        fund.withdraw();
        console.log(admin.balance, "owner's balance");
        //assertEq(admin.balance, 1 ether - 100000000000000000);
    }

    function test_collectPenalty() external {
        vm.deal(admin, 1 ether);
        vm.prank(admin);
        fund.depositFunds{value: 1 ether}();
        vm.warp(block.timestamp + 10 days);
        vm.prank(admin);
        console.log(admin.balance, "owner's balance");
        fund.withdraw();
        vm.prank(user1);
        fund.collectPenalty(user2);
        //assertEq(user2.balance,0.1 ether);
    }

    receive() external payable {
        vm.prank(admin);
        fund.withdraw();
    }
}
