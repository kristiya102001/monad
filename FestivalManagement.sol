// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract FestivalManagement {
    struct Festival {
        string name;
        string location;
        uint256 startDate;
        uint256 endDate;
        bool cancelled;
    }

    mapping(uint256 => Festival) public festivals;
    uint256 public festivalCount;

    event FestivalScheduled(uint256 festivalId, string name, string location, uint256 startDate, uint256 endDate);
    event FestivalCancelled(uint256 festivalId);

    function scheduleFestival(string memory _name, string memory _location, uint256 _startDate, uint256 _endDate) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_location).length > 0, "Location cannot be empty");
        require(_startDate > block.timestamp, "Start date must be in the future");
        require(_endDate > _startDate, "End date must be after start date");

        festivalCount++;
        festivals[festivalCount] = Festival({
            name: _name,
            location: _location,
            startDate: _startDate,
            endDate: _endDate,
            cancelled: false
        });

        emit FestivalScheduled(festivalCount, _name, _location, _startDate, _endDate);
    }

    function cancelFestival(uint256 _festivalId) public {
        require(_festivalId > 0 && _festivalId <= festivalCount, "Invalid festival ID");
        require(!festivals[_festivalId].cancelled, "Festival is already cancelled");

        festivals[_festivalId].cancelled = true;
        emit FestivalCancelled(_festivalId);
    }

    function getFestival(uint256 _festivalId) public view returns (string memory name, string memory location, uint256 startDate, uint256 endDate, bool cancelled) {
        require(_festivalId > 0 && _festivalId <= festivalCount, "Invalid festival ID");

        Festival storage festival = festivals[_festivalId];
        return (festival.name, festival.location, festival.startDate, festival.endDate, festival.cancelled);
    }
}