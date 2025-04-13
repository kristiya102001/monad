// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract MusicWorkManagement {
    struct Work {
        string title;
        string artist;
        string contentHash;
        uint256 releaseDate;
        bool copyrighted;
    }

    mapping(uint256 => Work) public works;
    uint256 public workCount;

    event WorkReleased(uint256 workId, string title, string artist, uint256 releaseDate);
    event CopyrightApplied(uint256 workId, bool copyrighted);

    function releaseWork(string memory _title, string memory _artist, string memory _contentHash) public {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_artist).length > 0, "Artist cannot be empty");
        require(bytes(_contentHash).length > 0, "Content hash cannot be empty");

        workCount++;
        works[workCount] = Work({
            title: _title,
            artist: _artist,
            contentHash: _contentHash,
            releaseDate: block.timestamp,
            copyrighted: false
        });

        emit WorkReleased(workCount, _title, _artist, block.timestamp);
    }

    function applyCopyright(uint256 _workId, bool _copyrighted) public {
        require(_workId > 0 && _workId <= workCount, "Invalid work ID");

        works[_workId].copyrighted = _copyrighted;
        emit CopyrightApplied(_workId, _copyrighted);
    }

    function getWork(uint256 _workId) public view returns (string memory title, string memory artist, string memory contentHash, uint256 releaseDate, bool copyrighted) {
        require(_workId > 0 && _workId <= workCount, "Invalid work ID");

        Work storage work = works[_workId];
        return (work.title, work.artist, work.contentHash, work.releaseDate, work.copyrighted);
    }
}