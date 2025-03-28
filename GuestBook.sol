// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract GuestBook {
    struct Entry {
        string message;
        address signer;
        uint256 entryDate;
    }

    Entry[] public entries;

    function addEntry(string memory message) public {
        entries.push(Entry({
            message: message,
            signer: msg.sender,
            entryDate: block.timestamp
        }));
    }

    function getEntries() public view returns (Entry[] memory) {
        return entries;
    }
}