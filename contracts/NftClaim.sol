// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CourseCertificateNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId = 1;
    string public certificateURI; 

    constructor(string memory _certificateURI) ERC721("Course Certificate", "CCERT") Ownable(msg.sender) {
        certificateURI = _certificateURI; 
    }

    function mintCertificate() public returns (uint256) {
        uint256 tokenId = _nextTokenId;
        _nextTokenId++;
        
        // Mint the NFT to the caller's address
        _safeMint(msg.sender, tokenId);
        
        // Set the token URI (metadata pointing to the NFT image)
        _setTokenURI(tokenId, certificateURI);
        
        return tokenId;
    }

    function hasCertificate(address student) public view returns (bool) {
        return balanceOf(student) > 0;
    }

    function getCurrentTokenId() public view returns (uint256) {
        return _nextTokenId - 1;
    }


    function _onERC721Received(
        address,
        address,
        uint256 /*firstTokenId*/,
        bytes memory /*data*/
    ) internal virtual  {
            require(msg.sender == address(0), "This NFT is soulbound and cannot be transferred");

    }
}