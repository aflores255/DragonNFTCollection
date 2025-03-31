//1. License
// SPDX-License-Identifier: UNLICENSED

//2. Solidity
pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "../src/DragonNFTCollection.sol";

//3. Contract
contract DragonNFTCollectionTest is Test {
    DragonNFTCollection nftCollection;
    address user = vm.addr(1);
    address owner = vm.addr(2);
    uint256 mintFee = 1 wei;
    uint256 constant MAX_SUPPLY = 10;
    string constant BASE_URI = "ipfs://example/";

    function setUp() public {
        nftCollection = new DragonNFTCollection("DragonFloNFT", "FLO", MAX_SUPPLY, BASE_URI,mintFee,owner);
    }

    // test Supply
    function testInitialSupply() public view {
        assert(nftCollection.NFTCollectionSupply() == MAX_SUPPLY);
    }

    // test owner

     function testOwnerIsCorrect() view public {
        assert(nftCollection.owner() == owner);
    }

   // Test mint 
    function testMintNFT() public {
        uint256 userBalance = 1 ether;
        vm.startPrank(user);
        vm.deal(user,userBalance);
        nftCollection.safeMint{value: mintFee}();
        assert(nftCollection.ownerOf(0) == user);
        assert(address(nftCollection).balance == mintFee);
       
        vm.stopPrank();
    }

    // Test mint with no funds
    function testNoFundsMintNFT() public {
        vm.startPrank(user);
        vm.expectRevert("Invalid amount");
        nftCollection.safeMint();
        vm.stopPrank();
    }

    // Test mint incorrect value
    function testIncorrectValueMintNFT() public {
        uint256 userBalance = 1 ether;
        uint256 invalidAmount = 0.5 ether;
        vm.startPrank(user);
        vm.deal(user,userBalance);
        vm.expectRevert("Invalid amount");
        nftCollection.safeMint{value: invalidAmount}();
        vm.stopPrank();
    }

    // Test mint different users
    function testMintNFTDifferentUsers() public {
        uint256 usersBalance = 1 ether;
        for (uint256 i = 0; i < MAX_SUPPLY; i++) {
            address userMint = vm.addr(i + 1);
            vm.startPrank(userMint);
            vm.deal(userMint,usersBalance);
            nftCollection.safeMint{value: mintFee}();
            assert(nftCollection.ownerOf(i) == userMint);
            vm.stopPrank();    
        }
    }

   // Test mint mint more that max supply
    function testMintNFTMaxSupply() public {
        uint256 usersBalance = 1 ether;
        address userMintMax = vm.addr(1);

        for (uint256 i = 0; i < MAX_SUPPLY; i++) {
            address userMint = vm.addr(i + 2);
            vm.startPrank(userMint);
            vm.deal(userMint,usersBalance);
            nftCollection.safeMint{value: mintFee}();
            assert(nftCollection.ownerOf(i) == userMint);
            vm.stopPrank();    
        }
        

        vm.startPrank(userMintMax);
        vm.deal(userMintMax,usersBalance);
        vm.expectRevert("Max Supply reached");
        nftCollection.safeMint{value: mintFee}();
        vm.stopPrank();


    }

    function testTokenURI() public {
        uint256 userBalance = 1 ether;
        vm.startPrank(user);
        vm.deal(user,userBalance);
        nftCollection.safeMint{value: mintFee}();

        string memory expectedURI = string.concat(BASE_URI, "0.json");
        assertEq(nftCollection.tokenURI(0), expectedURI);
        vm.stopPrank();
    }
}