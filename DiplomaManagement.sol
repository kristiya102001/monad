// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract DiplomaManagement {
    struct Diploma {
        string degree;
        string university;
        uint256 graduationYear;
        address graduate;
    }

    mapping(address => Diploma[]) public diplomas;

    function addDiploma(string memory degree, string memory university, uint256 graduationYear) public {
        diplomas[msg.sender].push(Diploma({
            degree: degree,
            university: university,
            graduationYear: graduationYear,
            graduate: msg.sender
        }));
    }

    function getDiplomas(address graduate) public view returns (Diploma[] memory) {
        return diplomas[graduate];
    }
}