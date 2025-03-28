// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract CourseCertification {
    struct Certification {
        string courseName;
        string institution;
        uint256 completionDate;
        address student;
    }

    mapping(address => Certification[]) public certifications;

    function addCertification(string memory courseName, string memory institution, uint256 completionDate) public {
        certifications[msg.sender].push(Certification({
            courseName: courseName,
            institution: institution,
            completionDate: completionDate,
            student: msg.sender
        }));
    }

    function getCertifications(address student) public view returns (Certification[] memory) {
        return certifications[student];
    }
}