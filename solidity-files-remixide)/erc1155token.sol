// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract OrganDonationToken is ERC1155 {

    uint256 private organTokenId = 0; 
    uint256 public donationPool = 0; 

    address public owner;

    struct theOrgan {
        string organName;
        string organCondition;
        string bloodGroup;
        string hospitalName;
        string description; 
        uint256 donorID;
    }
    
    event incomingDonation(address indexed donor, uint256 amount);
    event transferDonation(address indexed recipient, uint256 amount);

    mapping(uint256 => theOrgan) public theOrgans;

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can do perform this action!");
        _;
    }

    constructor() ERC1155("") {
        owner = msg.sender;
    }
    function mintOrganToken(string memory organName, string memory organCondition, string memory bloodGroup, string memory hospitalName, string memory description, uint256 donorID) public {
        organTokenId++;
        uint256 newTokenId = organTokenId;
        _mint(msg.sender, newTokenId, 1, ""); 

        theOrgans[newTokenId] = theOrgan(organName, organCondition, bloodGroup, hospitalName, description, donorID);
    }

    function donate() public payable {
         require(msg.value > 0, "Donation must be greater than 0");
        donationPool += msg.value;
        emit incomingDonation(msg.sender, msg.value);
    }

    function checkDonationPoolBalance() public view returns (uint256) {
        return donationPool;
    }
      receive() external payable {
        donationPool += msg.value;
        emit incomingDonation(msg.sender, msg.value);

    }
}
