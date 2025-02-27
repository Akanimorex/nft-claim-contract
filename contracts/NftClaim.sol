// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title CourseCertificateNFT
 * @dev A simplified soulbound (non-transferable) NFT contract for course completion
 */
contract CourseCertificateNFT is ERC721URIStorage, Ownable {
    // Manual counter for token IDs
    uint256 private _currentTokenId = 0;
    
    // Fixed token URI for all NFTs, set at deployment
    string private _certificateURI;
    
    // Map to track if an address has already minted an NFT
    mapping(address => bool) private _hasMinted;
    
    // Events
    event CertificateMinted(address indexed recipient, uint256 tokenId);

    /**
     * @dev Sets the token name, symbol, and the fixed token URI for all NFTs
     * @param certificateURI The IPFS URI for the certificate metadata
     */
    constructor(string memory certificateURI) ERC721("Course Completion Certificate", "CERT") Ownable(msg.sender) {
        _certificateURI = certificateURI;
    }
    
    /**
     * @dev Mint a new soulbound NFT certificate with no arguments
     * @return The ID of the newly minted token
     */
    function mint() external returns (uint256) {
        // Ensure user hasn't already minted
        require(!_hasMinted[msg.sender], "Already minted a certificate");
        
        // Increment token ID manually
        _currentTokenId += 1;
        uint256 newTokenId = _currentTokenId;
        
        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _certificateURI);
        
        // Mark that this address has minted
        _hasMinted[msg.sender] = true;
        
        emit CertificateMinted(msg.sender, newTokenId);
        
        return newTokenId;
    }
    
    /**
     * @dev Override _update to make tokens soulbound (non-transferable)
     * Only allows minting, prevents all transfers
     */
    function _update(address to, uint256 tokenId, address auth) internal override returns (address) {
        address from = _ownerOf(tokenId);
        
        // Allow minting (from = address(0))
        if (from == address(0)) {
            return super._update(to, tokenId, auth);
        }
        
        // Prevent all transfers once minted
        revert("Soulbound tokens cannot be transferred");
    }
    
    /**
     * @dev Check if an address has already minted a certificate
     * @param user The address to check
     * @return Boolean indicating if the user has minted
     */
    function hasMinted(address user) external view returns (bool) {
        return _hasMinted[user];
    }
    
    /**
     * @dev Allow contract owner to update the certificate URI if needed
     * @param newCertificateURI The new IPFS URI
     */
    function updateCertificateURI(string calldata newCertificateURI) external onlyOwner {
        _certificateURI = newCertificateURI;
    }
    
    /**
     * @dev Get the current token ID (for informational purposes)
     * @return The current token ID
     */
    function getCurrentTokenId() external view returns (uint256) {
        return _currentTokenId;
    }
}