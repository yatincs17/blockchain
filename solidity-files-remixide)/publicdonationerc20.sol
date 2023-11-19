// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OrganLedgerToken is ERC20 {
    address public owner;
    uint256 public donationPool;

    event incomingDonation(address indexed donor, uint256 amount);
    event transferDonation(address indexed recipient, uint256 amount);

    
    mapping(address => uint256) public donorIds;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(uint256 initialSupply) ERC20("OrganLedgerToken", "OLT") {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    function donate(uint256 amount) public {
        require(amount > 0, "donation must be greater than 0");
        _transfer(msg.sender, address(this), amount);
        donationPool += amount;
        emit incomingDonation(msg.sender, amount);
    }

    function transferFunds(address recipient, uint256 amount) public onlyOwner {
        require(amount <= donationPool, "Insufficient funds");
        donationPool -= amount;
        _transfer(address(this), recipient, amount);
        emit transferDonation(recipient, amount);
    }

    function checkDonationPoolBalance() public view returns (uint256) {
        return donationPool;
    }
    function checkDonationsFromAddress(address donor) public view returns (uint256) {
        return donorIds[donor];
    }

    receive() external payable {
        donationPool += msg.value;
        emit incomingDonation(msg.sender, msg.value);

    }
}
