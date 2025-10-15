// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
import {CREATE3} from "solady/utils/CREATE3.sol";

contract CounterScript is Script {
    Counter public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = Counter(
            CREATE3.deployDeterministic(
                0, abi.encodePacked(type(Counter).creationCode), keccak256(abi.encodePacked("MyCounter"))
            )
        );

        counter.number();
        counter.increment();
        counter.number();

        vm.stopBroadcast();
    }
}
