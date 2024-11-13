// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Callme} from "../src/Callme.sol";

contract Deploy is Script{
    Callme mainContract;
    function run() external {
        vm.startBroadcast();
        mainContract = new Callme();
        vm.stopBroadcast();
    }
}

