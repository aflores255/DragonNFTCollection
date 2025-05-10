# 🎨 ERC-721 DragonNFTCollection

## 📌 **Description**
**DragonNFTCollection** is a feature-rich and secure NFT smart contract developed in Solidity using the **Foundry** framework. It enables the creation of a fully compliant **ERC-721** collection with a fixed total supply, structured metadata URIs, and enforced minting limits per wallet to ensure fair distribution. Each mint requires a fee, introducing value to the tokens and enabling revenue generation for the project. Collected fees are managed by the contract’s **owner**, allowing centralized control for funding development, marketing, or community rewards. The contract is deployed on the **Arbitrum** network, ensuring fast, low-cost transactions for both creators and collectors.

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

### 🏗️ Constructor

| **Constructor** | **Description** |
|----------------|----------------|
| `constructor(string memory name_, string memory symbol_, uint256 NFTCollectionSupply_, string memory baseURI_, uint256 mintFee_, address owner_)` | Initializes the NFT collection with name, symbol, max supply, metadata URI, minting fee, and assigns contract ownership for fee management. |

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

## 🚀 Deployment & Usage

This section demonstrates the functionality of the `DragonNFTCollection` smart contract, deployed on the **Arbitrum One** network. It includes steps to mint NFTs using the live contract and manage the collected minting fees.

🔗 **Deployed Contract:** [0xaffc28fd8dbdfbd17e6d47a98aa2b7a73ae39c33 on Arbiscan](https://arbiscan.io/address/0xaffc28fd8dbdfbd17e6d47a98aa2b7a73ae39c33)

---

### 🐉 How to Mint a Dragon NFT

1. **Go to the Arbiscan contract page**:  
   [Write Contract → Connect to Web3](https://arbiscan.io/address/0xaffc28fd8dbdfbd17e6d47a98aa2b7a73ae39c33#writeContract)

2. **Connect your wallet** (e.g. MetaMask on Arbitrum One network).

3. **Locate `safeMint()` function**:
   - Enter the required amount of ETH (mint fee) into the "Value" field (e.g., `1` wei of Ether).
   - Click "Write" and approve the transaction.

4. **Check Ownership and Metadata**:
   - Switch to **Read Contract** tab.
   - Use `balanceOf(address)` to confirm you own a token.
   - Use `tokenURI(tokenId)` to get the metadata URI.

   ✅ Example:
   - Token ID: `0`
   - View token URI: [tokenURI(0)]

---

### 💰 Fee Management (Owner Only)

The contract owner can withdraw the collected minting fees by calling:

- `withdraw()`

This function transfers the entire contract balance to the owner's wallet.  
Only the `owner` address (set during deployment) can execute this function.

---

### 🔗 Example Transaction

Example of a successful mint:

🔹 [Tx Hash: 0x244e...](https://arbiscan.io/tx/0x244e8772c8d11e1b89b3711192d498b844196d392e027c1eebe71eaddd36d42f)  
- Status: Success  
- Value sent: `1 wei`  
- Token ID: `0`  
- Result: NFT minted and registered on-chain.

---

🧭 Minted NFTs can be viewed and traded on supported Arbitrum marketplaces like [OpenSea](https://opensea.io/) once metadata is indexed.

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

### 📊 Test Coverage

The following table summarizes the unit test coverage for the `DragonNFTCollection` smart contract. All lines, statements, and functions are fully covered. The only uncovered branch corresponds to the **successful path of the `call` used in `withdrawFunds()`**, which is tested through a failure case but not explicitly verified in a success scenario.

| **File**                      | **% Lines**     | **% Statements** | **% Branches** | **% Functions** |
|------------------------------|-----------------|------------------|----------------|-----------------|
| `src/DragonNFTCollection.sol`| 100.00% (28/28) | 100.00% (25/25)  | 90.00% (9/10)  | 100.00% (6/6)   |

---

### 📄 License
This project is UNLICENSED. Modify it as needed for your use case!

