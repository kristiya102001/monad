// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ScientificPaperManagement {
    struct Paper {
        string title;
        string author;
        string contentHash;
        uint256 publicationDate;
        bool peerReviewed;
    }

    mapping(uint256 => Paper) public papers;
    uint256 public paperCount;

    event PaperPublished(uint256 paperId, string title, string author, uint256 publicationDate);
    event PeerReviewCompleted(uint256 paperId, bool peerReviewed);

    function publishPaper(string memory _title, string memory _author, string memory _contentHash) public {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_author).length > 0, "Author cannot be empty");
        require(bytes(_contentHash).length > 0, "Content hash cannot be empty");

        paperCount++;
        papers[paperCount] = Paper({
            title: _title,
            author: _author,
            contentHash: _contentHash,
            publicationDate: block.timestamp,
            peerReviewed: false
        });

        emit PaperPublished(paperCount, _title, _author, block.timestamp);
    }

    function completePeerReview(uint256 _paperId, bool _peerReviewed) public {
        require(_paperId > 0 && _paperId <= paperCount, "Invalid paper ID");

        papers[_paperId].peerReviewed = _peerReviewed;
        emit PeerReviewCompleted(_paperId, _peerReviewed);
    }

    function getPaper(uint256 _paperId) public view returns (string memory title, string memory author, string memory contentHash, uint256 publicationDate, bool peerReviewed) {
        require(_paperId > 0 && _paperId <= paperCount, "Invalid paper ID");

        Paper storage paper = papers[_paperId];
        return (paper.title, paper.author, paper.contentHash, paper.publicationDate, paper.peerReviewed);
    }
}