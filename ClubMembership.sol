// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ClubMembership {
    struct Member {
        string name;
        string membershipType;
        uint256 membershipStartDate;
        bool isActive;
    }

    mapping(address => Member) public members;
    address[] public memberList;

    function joinClub(string memory name, string memory membershipType) public {
        require(!members[msg.sender].isActive, "Already a member.");
        members[msg.sender] = Member({
            name: name,
            membershipType: membershipType,
            membershipStartDate: block.timestamp,
            isActive: true
        });
        memberList.push(msg.sender);
    }

    function renewMembership(string memory membershipType) public {
        require(members[msg.sender].isActive, "Not a member.");
        members[msg.sender].membershipType = membershipType;
        members[msg.sender].membershipStartDate = block.timestamp;
    }

    function leaveClub() public {
        require(members[msg.sender].isActive, "Not a member.");
        members[msg.sender].isActive = false;
    }

    function getMember(address memberAddress) public view returns (string memory name, string memory membershipType, uint256 membershipStartDate, bool isActive) {
        require(members[memberAddress].membershipStartDate > 0, "Member does not exist.");
        Member memory member = members[memberAddress];
        return (member.name, member.membershipType, member.membershipStartDate, member.isActive);
    }

    function getMemberList() public view returns (address[] memory) {
        return memberList;
    }
}