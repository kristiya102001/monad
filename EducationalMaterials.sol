// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract EducationalMaterials {
    struct Material {
        string title;
        string description;
        string content;
        address uploader;
        uint256 uploadDate;
    }

    mapping(uint => Material) public materials;
    uint public materialCount;

    function uploadMaterial(string memory title, string memory description, string memory content) public {
        materials[materialCount] = Material({
            title: title,
            description: description,
            content: content,
            uploader: msg.sender,
            uploadDate: block.timestamp
        });
        materialCount++;
    }

    function getMaterial(uint materialId) public view returns (string memory title, string memory description, string memory content, address uploader, uint256 uploadDate) {
        require(materialId < materialCount, "Material does not exist.");
        Material memory material = materials[materialId];
        return (material.title, material.description, material.content, material.uploader, material.uploadDate);
    }
}