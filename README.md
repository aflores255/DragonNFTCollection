# 🎨 DragonNFTCollection

## 📌 **Description**
The **DragonNFTCollection** is a Solidity-based smart contract for an ERC-721 NFT collection. It allows users to mint unique NFTs until the maximum supply is reached (only one per wallet). The contract is built using **OpenZeppelin** for security and standard compliance and tested with **Foundry**.

You can see an example of the deployed contract here: https://arbiscan.io/address/0xaffc28fd8dbdfbd17e6d47a98aa2b7a73ae39c33

---

## 🚀 **Features**
| **Feature** | **Description** |
|------------|----------------|
| 🎭 **ERC-721 Standard** | Implements the ERC-721 standard for non-fungible tokens. |
| 🎨 **NFT Minting** | Users can mint one NFT per wallet until the maximum collection supply is reached. |
| 🔗 **Base URI** | Metadata URIs are structured as `<baseURI><tokenId>.json`. |
| 📜 **Event Emission** | Emits `MintNFT`, `MintFeeUpdated`, and `FundsWithdrawn` events. |

---

## 📜 **Contract Details**

### 📡 **Events**
| **Event** | **Description** |
|-----------|----------------|
| **`MintNFT(address indexed owner, uint256 indexed tokenId)`** | Emitted when a new NFT is minted. |
| **`MintFeeUpdated(uint256 newFee)`** | Emitted when the minting fee is updated. |
| **`FundsWithdrawn(address owner, uint256 amount)`** | Emitted when the owner withdraws funds from the contract. |

### 🔧 **Contract Functions**
| **Function** | **Description** |
|------------|----------------|
| **`safeMint()`** | Mints a new NFT to the caller, ensuring supply limits are respected. |
| **`setMintFee(uint256 newFee)`** | Allows the owner to update the minting fee. |
| **`withdrawFunds()`** | Allows the owner to withdraw the accumulated contract funds. |
| **`_baseURI()`** | Returns the base URI for metadata storage. |
| **`tokenURI(uint256 tokenId)`** | Returns the full URI for a given token ID. |

---

## 🧪 **Testing with Foundry**
The contract has been thoroughly tested using Foundry. The test suite verifies minting, supply limits, and metadata retrieval.

### ✅ **Implemented Tests**
| **Test** | **Description** |
|-----------|----------------|
| **`testInitialSupply`** | Ensures the total supply is set correctly at deployment. |
| **`testMintNFT`** | Verifies that an NFT can be minted and assigned correctly. |
| **`testMintNFTDifferentUsers`** | Ensures multiple users can mint NFTs. |
| **`testMintUpToMaxSupply`** | Confirms that minting stops once the max supply is reached. |
| **`testTokenURI`** | Ensures metadata URIs are generated correctly. |
| **`testSetMintFeeWithOwner`** | Verifies that only the owner can update the minting fee. |
| **`testWithdrawWithOwner`** | Confirms that only the owner can withdraw contract funds. |

---

## 🛠️ **How to Use**

### 🔧 **Prerequisites**
- Install **Foundry**: [Installation Guide](https://book.getfoundry.sh/)
- Ensure you have an Ethereum wallet and testnet ETH if deploying.

### 🚀 **Deployment Steps**
1. Clone the project repository.
2. Navigate to the project folder.
3. Install dependencies. 
4. Run the tests.
5. Deploy the contract.

### 📄 License
This project is UNLICENSED. Modify it as needed for your use case!

