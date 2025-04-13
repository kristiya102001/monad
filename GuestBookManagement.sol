// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract GuestBookManagement {
    struct Entry {
        string guestName;
        string message;
        uint256 entryDate;
    }

    Entry[] public entries;

    event EntryAdded(uint256 entryId, string guestName, string message, uint256 entryDate);

    function addEntry(string memory _guestName, string memory _message) public {
        require(bytes(_guestName).length > 0, "Guest name cannot be empty");
        require(bytes(_message).length > 0, "Message cannot be empty");

        entries.push(Entry({
            guestName: _guestName,
            message: _message,
            entryDate: block.timestamp
        }));

        emit EntryAdded(entries.length, _guestName, _message, block.timestamp);
    }

    function getEntry(uint256 _entryId) public view returns (string memory guestName, string memory message, uint256 entryDate) {
        require(_entryId > 0 && _entryId <= entries.length, "Invalid entry ID");

        Entry storage entry = entries[_entryId - 1];
        return (entry.guestName, entry.message, entry.entryDate);
    }

    function getEntryCount() public view returns (uint256) {
        return entries.length;
    }
}