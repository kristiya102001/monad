// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ProjectVoting {
    struct Project {
        string name;
        string description;
        uint256 voteCount;
        bool isActive;
    }

    mapping(uint => Project) public projects;
    uint public projectCount;

    function addProject(string memory name, string memory description) public {
        projects[projectCount] = Project({
            name: name,
            description: description,
            voteCount: 0,
            isActive: true
        });
        projectCount++;
    }

    function vote(uint projectId) public {
        require(projectId < projectCount, "Project does not exist.");
        require(projects[projectId].isActive, "Project is not active.");

        projects[projectId].voteCount++;
    }

    function getProject(uint projectId) public view returns (string memory name, string memory description, uint256 voteCount, bool isActive) {
        require(projectId < projectCount, "Project does not exist.");
        Project memory project = projects[projectId];
        return (project.name, project.description, project.voteCount, project.isActive);
    }

    function endProjectVoting(uint projectId) public {
        require(projectId < projectCount, "Project does not exist.");
        projects[projectId].isActive = false;
    }
}