//SPDX - License - Identifier : Unlicensed
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import {Deploycontract} from "../src/Deploy.sol";
import {console, Test} from "forge-std/Test.sol";

contract Deployscript is Script {
    function run() external {
        Deploycontract deployContract;
        vm.startBroadcast();
        deployContract = new Deploycontract();
        console.log("Contract deployed Address", address(deployContract));
        vm.stopBroadcast();
    }
}
