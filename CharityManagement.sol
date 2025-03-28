// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract CharityManagement {
    struct Donation {
        address donor;
        string projectName;
        uint256 donationDate;
    }

    mapping(address => Donation[]) public donations;

    function donateToProject(string memory projectName) public {
        donations[msg.sender].push(Donation({
            donor: msg.sender,
            projectName: projectName,
            donationDate: block.timestamp
        }));
    }

    function getDonations(address donor) public view returns (Donation[] memory) {
        return donations[donor];
    }
}