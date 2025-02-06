// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CourseCertificateNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId = 1;

    constructor() ERC721("Course Certificate", "CCERT") Ownable(msg.sender) {}

    function mintCertificate(address student, string memory tokenURI) public onlyOwner returns (uint256) {
        // Get the next token ID and increment
        uint256 tokenId = _nextTokenId;
        _nextTokenId++;
        
        // Mint the NFT to the student
        _safeMint(student, tokenId);
        
        // Set the token URI (metadata pointing to the NFT image)
        _setTokenURI(tokenId, tokenURI);
        
        return tokenId;
    }

    // Function to check if a student has a certificate
    function hasCertificate(address student) public view returns (bool) {
        return balanceOf(student) > 0;
    }

    // Optional: function to get the current token count
    function getCurrentTokenId() public view returns (uint256) {
        return _nextTokenId - 1;
    }
}