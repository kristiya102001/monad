// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract MedicalCard {
    struct MedicalRecord {
        string diagnosis;
        string treatment;
        uint256 recordDate;
        address doctor;
    }

    mapping(address => MedicalRecord[]) public medicalRecords;

    function addMedicalRecord(address patient, string memory diagnosis, string memory treatment) public {
        medicalRecords[patient].push(MedicalRecord({
            diagnosis: diagnosis,
            treatment: treatment,
            recordDate: block.timestamp,
            doctor: msg.sender
        }));
    }

    function getMedicalRecords(address patient) public view returns (MedicalRecord[] memory) {
        return medicalRecords[patient];
    }
}