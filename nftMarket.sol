// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTMarketplace {
    // Define the structure of the NFT
    struct NFT {
        string name;
        string description;
        string image;
        address owner;
    }

    // Create a mapping to store the NFTs
    mapping(uint256 => NFT) public nfts;

    // Function for listing an NFT for sale
    function listNFT(uint256 tokenId, string memory name, string memory description, string memory image) external {
        // Set the NFT details and owner
        nfts[tokenId] = NFT(name, description, image, msg.sender);
    }

    // Function for buying an NFT
    function buyNFT(uint256 tokenId) external payable {
        // Check if the NFT is listed for sale
        require(nfts[tokenId].owner != address(0), "NFT not found");

        // Check if the buyer has sent enough Ether
        require(msg.value >= 1 ether, "Insufficient funds");

        // Transfer ownership of the NFT to the buyer
        nfts[tokenId].owner = msg.sender;

        // Transfer the payment to the seller
        payable(nfts[tokenId].owner).transfer(msg.value);
    }

    // Function for transferring an NFT to another user
    function transferNFT(uint256 tokenId, address to) external {
        // Check if the NFT belongs to the sender
        require(nfts[tokenId].owner == msg.sender, "Not the owner");

        // Transfer ownership of the NFT to the specified user
        nfts[tokenId].owner = to;
    }
}