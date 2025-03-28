// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract EventParticipants {
    struct Event {
        string name;
        string location;
        uint256 startDate;
        uint256 endDate;
        address organizer;
        address[] participants;
    }

    mapping(uint => Event) public events;
    uint public eventCount;

    function createEvent(string memory name, string memory location, uint256 startDate, uint256 endDate) public {
        events[eventCount] = Event({
            name: name,
            location: location,
            startDate: startDate,
            endDate: endDate,
            organizer: msg.sender,
            participants: new address[](0)
        });
        eventCount++;
    }

    function registerParticipant(uint eventId) public {
        require(eventId < eventCount, "Event does not exist.");
        require(events[eventId].organizer != msg.sender, "Organizer cannot participate.");
        require(!isParticipant(eventId, msg.sender), "Already registered.");

        events[eventId].participants.push(msg.sender);
    }

    function isParticipant(uint eventId, address participant) internal view returns (bool) {
        for (uint i = 0; i < events[eventId].participants.length; i++) {
            if (events[eventId].participants[i] == participant) {
                return true;
            }
        }
        return false;
    }

    function getEvent(uint eventId) public view returns (string memory name, string memory location, uint256 startDate, uint256 endDate, address organizer, address[] memory participants) {
        require(eventId < eventCount, "Event does not exist.");
        Event memory evt = events[eventId];
        return (evt.name, evt.location, evt.startDate, evt.endDate, evt.organizer, evt.participants);
    }
}