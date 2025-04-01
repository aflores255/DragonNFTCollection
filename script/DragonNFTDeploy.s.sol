// 1. License
//SPDX-License-Identifier: UNLICENSED

//2. Solidity
pragma solidity 0.8.28;

//3. Contract

import {Script} from "forge-std/Script.sol";
import {DragonNFTCollection} from "../src/DragonNFTCollection.sol";

contract DeployFloNFTCollection is Script {
    function run() external returns (DragonNFTCollection) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        uint256 mintFee = 1 wei;
        address owner = address(0x36e985fd5fCD00F6a30a4c3291214a2d29e2B583);
        vm.startBroadcast(deployerPrivateKey);
        string memory name_ = "DragonFlo Collection NFT";
        string memory symbol_ = "DFL";
        uint256 NFTCollectionSupply_ = 10;
        string memory baseURI_ = "ipfs://bafybeifnpbzzngay5vvrgqnnymsfnttw4i3woujiluv4jqk3rjo3uokeee/";
        DragonNFTCollection dragonNFTCollection =
            new DragonNFTCollection(name_, symbol_, NFTCollectionSupply_, baseURI_, mintFee, owner);
        vm.stopBroadcast();
        return dragonNFTCollection;
    }
}
