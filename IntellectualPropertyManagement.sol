// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract IntellectualPropertyManagement {
    struct Patent {
        string title;
        string description;
        string inventor;
        uint256 applicationDate;
        bool granted;
    }

    mapping(uint256 => Patent) public patents;
    uint256 public patentCount;

    event PatentApplied(uint256 patentId, string title, string inventor, uint256 applicationDate);
    event PatentGranted(uint256 patentId, bool granted);

    function applyForPatent(string memory _title, string memory _description, string memory _inventor) public {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_description).length > 0, "Description cannot be empty");
        require(bytes(_inventor).length > 0, "Inventor cannot be empty");

        patentCount++;
        patents[patentCount] = Patent({
            title: _title,
            description: _description,
            inventor: _inventor,
            applicationDate: block.timestamp,
            granted: false
        });

        emit PatentApplied(patentCount, _title, _inventor, block.timestamp);
    }

    function grantPatent(uint256 _patentId, bool _granted) public {
        require(_patentId > 0 && _patentId <= patentCount, "Invalid patent ID");

        patents[_patentId].granted = _granted;
        emit PatentGranted(_patentId, _granted);
    }

    function getPatent(uint256 _patentId) public view returns (string memory title, string memory description, string memory inventor, uint256 applicationDate, bool granted) {
        require(_patentId > 0 && _patentId <= patentCount, "Invalid patent ID");

        Patent storage patent = patents[_patentId];
        return (patent.title, patent.description, patent.inventor, patent.applicationDate, patent.granted);
    }
}