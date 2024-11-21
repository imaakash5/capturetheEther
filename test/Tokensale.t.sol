//SPDX - Identifier : License : Unlicensed
pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {Tokensale} from "../src/Tokensale.sol";

contract TestTokensale is Test {
    address admin;
    Tokensale mainContract;

    function setUp() public {
        admin = vm.addr(674373);
        vm.deal(admin, 1 ether);
        vm.prank(admin);
        mainContract = new Tokensale{value: 1 ether}();
    }

    function test_setUp() external view {
        assertEq(address(mainContract).balance, 1 ether);
    }

    function test_isComplete() external view {
        bool isComplete = mainContract.isComplete();
        assertEq(isComplete, false);
    }

    function test_buy() external {
        vm.deal(address(this), 10 ether);
        mainContract.buy{value: 10 ether}(10);
        uint256 tokensBalance = mainContract.checkBalance();
        assertEq(tokensBalance, 10);
    }

    function test_sell() external {
        vm.deal(address(this), 10 ether);
        mainContract.buy{value: 10 ether}(10);
        mainContract.sell(5);
        assertEq(address(this).balance, 5 ether);
    }

    receive() external payable {
        vm.deal(address(this), 10 ether);
        mainContract.buy{value: 10 ether}(10);
        fund.sell(10);
        fund.sell(5);
    }
}
