// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract OrganDonationNFT is ERC721URIStorage {
    uint256 private tokenId = 0;
    address public owner;

       struct theOrgan {
        string organName;
        string organCondition;
        string bloodGroup;
        string hospitalName;
        string description; 
        uint256 donorID;
    }

    mapping(uint256 => theOrgan) public theOrgans;

    event OrganTokenMinted(uint256 indexed donorId, uint256 tokenId);

    constructor() ERC721("OrganDonationNFT", "ODN") {}

       function mintOrganToken(string memory organName, string memory organCondition, string memory bloodGroup, string memory hospitalName, string memory description, uint256 donorID) public  {
        tokenId++;

        _mint(msg.sender, tokenId);

        theOrgans[tokenId] = theOrgan(organName, organCondition, bloodGroup, hospitalName, description, donorID);

    }
}
