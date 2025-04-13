// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract AcademicDiplomaManagement {
    struct Diploma {
        string degree;
        string studentName;
        uint256 graduationYear;
        address university;
        bool verified;
    }

    mapping(uint256 => Diploma) public diplomas;
    uint256 public diplomaCount;

    event DiplomaIssued(uint256 diplomaId, string degree, string studentName, uint256 graduationYear, address university);
    event DiplomaVerified(uint256 diplomaId, bool verified);

    function issueDiploma(string memory _degree, string memory _studentName, uint256 _graduationYear) public {
        require(bytes(_degree).length > 0, "Degree cannot be empty");
        require(bytes(_studentName).length > 0, "Student name cannot be empty");
        require(_graduationYear > 0, "Graduation year must be greater than zero");

        diplomaCount++;
        diplomas[diplomaCount] = Diploma({
            degree: _degree,
            studentName: _studentName,
            graduationYear: _graduationYear,
            university: msg.sender,
            verified: false
        });

        emit DiplomaIssued(diplomaCount, _degree, _studentName, _graduationYear, msg.sender);
    }

    function verifyDiploma(uint256 _diplomaId, bool _verified) public {
        require(_diplomaId > 0 && _diplomaId <= diplomaCount, "Invalid diploma ID");

        diplomas[_diplomaId].verified = _verified;
        emit DiplomaVerified(_diplomaId, _verified);
    }

    function getDiploma(uint256 _diplomaId) public view returns (string memory degree, string memory studentName, uint256 graduationYear, address university, bool verified) {
        require(_diplomaId > 0 && _diplomaId <= diplomaCount, "Invalid diploma ID");

        Diploma storage diploma = diplomas[_diplomaId];
        return (diploma.degree, diploma.studentName, diploma.graduationYear, diploma.university, diploma.verified);
    }
}