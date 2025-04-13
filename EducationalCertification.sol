// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract EducationalCertification {
    struct Certification {
        string courseName;
        string studentName;
        uint256 issueDate;
        bool verified;
    }

    mapping(uint256 => Certification) public certifications;
    uint256 public certificationCount;

    event CertificationIssued(uint256 certificationId, string courseName, string studentName, uint256 issueDate);
    event CertificationVerified(uint256 certificationId, bool verified);

    function issueCertification(string memory _courseName, string memory _studentName) public {
        require(bytes(_courseName).length > 0, "Course name cannot be empty");
        require(bytes(_studentName).length > 0, "Student name cannot be empty");

        certificationCount++;
        certifications[certificationCount] = Certification({
            courseName: _courseName,
            studentName: _studentName,
            issueDate: block.timestamp,
            verified: false
        });

        emit CertificationIssued(certificationCount, _courseName, _studentName, block.timestamp);
    }

    function verifyCertification(uint256 _certificationId, bool _verified) public {
        require(_certificationId > 0 && _certificationId <= certificationCount, "Invalid certification ID");

        certifications[_certificationId].verified = _verified;
        emit CertificationVerified(_certificationId, _verified);
    }

    function getCertification(uint256 _certificationId) public view returns (string memory courseName, string memory studentName, uint256 issueDate, bool verified) {
        require(_certificationId > 0 && _certificationId <= certificationCount, "Invalid certification ID");

        Certification storage certification = certifications[_certificationId];
        return (certification.courseName, certification.studentName, certification.issueDate, certification.verified);
    }
}