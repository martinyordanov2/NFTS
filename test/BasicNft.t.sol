// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "lib/forge-std/src/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployNft.s.sol";

contract BasicNftTest is Test{
    BasicNft public basicNft;
    DeployBasicNft public deployer;
    address public USER = makeAddr("user");
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    

    function setUp() public{
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view{
        string memory expected = "Doggie";
        string memory actual = basicNft.name();
        //assertEq(expected, actual);
        assert(keccak256(abi.encodePacked(expected)) == keccak256(abi.encodePacked(actual)));
    }

    function testSymbolIsCorrect() public view{
        string memory expected = "DOG";
        string memory actual = basicNft.symbol();
        assertEq(expected, actual);
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assertEq(basicNft.balanceOf(USER), 1);
        assertEq(PUG, basicNft.tokenURI(0));
    }
}