
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract appreciationToken is ERC1155 {
    uint256 private tokenIdCounter;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "you do not have permissions to do this");
        _;
    }

    constructor() ERC1155("APT") {
        owner = msg.sender;
        tokenIdCounter = 1;
    }

    function sendTokenToDonor(address donor, uint256 amount) external onlyOwner {

        _mint(donor, tokenIdCounter, amount, "");

        tokenIdCounter++;
    }

    function checkTokenBalance(address account, uint256 tokenId) external view returns (uint256) {
        return balanceOf(account, tokenId);
    }
}
