// 1. License
//SPDX-License-Identifier : UNLICENSED

//2. Solidity
pragma solidity 0.8.28;

//3. Contract

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Strings} from "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract DragonNFTCollection is ERC721, Ownable {
    using Strings for uint256;

    // Variables definition

    uint256 public currentTokenId; //0
    uint256 public NFTCollectionSupply;
    string public baseUri;
    uint256 public mintFee;
    mapping(address => bool) public hasMinted;

    //Events

    event MintNFT(address address_, uint256 tokenId_);
    event MintFeeUpdated(uint256 newFee);
    event FundsWithdrawn(address owner, uint256 amount);

    /**
     * @notice Constructor of the DragonNFTCollection contract.
     * @param name_ Name of the NFT collection.
     * @param symbol_ Symbol of the NFT collection.
     * @param NFTCollectionSupply_ Maximum number of NFTs allowed to be minted.
     * @param baseURI_ Base URI used to generate token metadata URIs.
     * @param mintFee_ Fee in wei required to mint a single NFT.
     * @param owner_ Address that will be assigned as the contract owner.
     */
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 NFTCollectionSupply_,
        string memory baseURI_,
        uint256 mintFee_,
        address owner_
    ) ERC721(name_, symbol_) Ownable(owner_) {
        NFTCollectionSupply = NFTCollectionSupply_;
        baseUri = baseURI_;
        mintFee = mintFee_;
    }

    // Functions

    /**
     * @notice Allows users to mint one NFT per wallet, enforcing fee and supply restrictions.
     */
    function safeMint() external payable {
        require(currentTokenId < NFTCollectionSupply, "Max Supply reached");
        require(msg.value == mintFee, "Invalid amount");
        require(!hasMinted[msg.sender], "Wallet has already minted");
        _safeMint(msg.sender, currentTokenId);
        uint256 actualId = currentTokenId;
        currentTokenId++;
        hasMinted[msg.sender] = true;
        emit MintNFT(msg.sender, actualId);
    }

    /**
     * @notice Updates the minting fee required to mint a new NFT.
     * @param newFee The new minting fee (in wei) to be applied.
     */
    function setMintFee(uint256 newFee) external onlyOwner {
        mintFee = newFee;
        emit MintFeeUpdated(newFee);
    }

    /**
     * @notice Withdraws all ETH from the contract to the owner's address.
     */
    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");
        (bool success,) = msg.sender.call{value: balance}("");
        require(success, "Withdraw failed");
        emit FundsWithdrawn(owner(), balance);
    }

    /**
     * @notice Returns the base URI used for computing {tokenURI}.
     * @return The base URI string set during contract deployment.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return baseUri;
    }

    /**
     * @notice Returns the metadata URI for a given token ID.
     * @param tokenId The ID of the token whose URI is being queried.
     * @return A string representing the full metadata URI for the token.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireOwned(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string.concat(baseURI, tokenId.toString(), ".json") : "";
    }
}
