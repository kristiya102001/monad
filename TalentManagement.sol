// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract TalentManagement {
    struct Talent {
        string name;
        string skill;
        string portfolioHash;
        uint256 registrationDate;
        bool verified;
    }

    mapping(uint256 => Talent) public talents;
    uint256 public talentCount;

    event TalentRegistered(uint256 talentId, string name, string skill, uint256 registrationDate);
    event TalentVerified(uint256 talentId, bool verified);

    function registerTalent(string memory _name, string memory _skill, string memory _portfolioHash) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_skill).length > 0, "Skill cannot be empty");
        require(bytes(_portfolioHash).length > 0, "Portfolio hash cannot be empty");

        talentCount++;
        talents[talentCount] = Talent({
            name: _name,
            skill: _skill,
            portfolioHash: _portfolioHash,
            registrationDate: block.timestamp,
            verified: false
        });

        emit TalentRegistered(talentCount, _name, _skill, block.timestamp);
    }

    function verifyTalent(uint256 _talentId, bool _verified) public {
        require(_talentId > 0 && _talentId <= talentCount, "Invalid talent ID");

        talents[_talentId].verified = _verified;
        emit TalentVerified(_talentId, _verified);
    }

    function getTalent(uint256 _talentId) public view returns (string memory name, string memory skill, string memory portfolioHash, uint256 registrationDate, bool verified) {
        require(_talentId > 0 && _talentId <= talentCount, "Invalid talent ID");

        Talent storage talent = talents[_talentId];
        return (talent.name, talent.skill, talent.portfolioHash, talent.registrationDate, talent.verified);
    }
}