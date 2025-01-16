//SPDX-License-Identifier: MIT

// A fund script
// & A withdraw script

pragma solidity ^0.8.18;

import {console, Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../script/FundMe.sol";

contract FundFundMe is Script{
    uint256 constant SEND_VALUE = 0.1 ether;

   function fundFundMe(address mostRecentlyDeployed) public {
        console.log("Most recently deployed FundMe contract: %s", mostRecentlyDeployed);
        console.log("Sending %s to FundMe contract", SEND_VALUE);
        console.log("Funding FundMe contract with %s", SEND_VALUE);
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
    }



    function run() external {
        vm.startBroadcast();
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe", block.chainid
            );
            fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script{ uint256 constant SEND_VALUE = 0.1 ether;

    function withdrawFundMe(address mostRecentlyDeployed)  public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }


    function run() external {
        vm.startBroadcast();
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe", block.chainid
            );
            withdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }

}