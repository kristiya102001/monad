// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ConstructionTools {
    struct Tool {
        string name;
        string description;
        uint256 quantity;
        bool isAvailable;
    }

    struct LoanRecord {
        address borrower;
        uint256 loanDate;
        bool returned;
    }

    mapping(uint => Tool) public tools;
    mapping(uint => LoanRecord[]) public loanRecords;
    uint public toolCount;

    function addTool(string memory name, string memory description, uint256 quantity) public {
        tools[toolCount] = Tool({
            name: name,
            description: description,
            quantity: quantity,
            isAvailable: true
        });
        toolCount++;
    }

    function loanTool(uint toolId, uint256 quantity) public {
        require(toolId < toolCount, "Tool does not exist.");
        require(tools[toolId].isAvailable, "Tool is not available.");
        require(tools[toolId].quantity >= quantity, "Not enough quantity.");

        tools[toolId].quantity -= quantity;
        loanRecords[toolId].push(LoanRecord({
            borrower: msg.sender,
            loanDate: block.timestamp,
            returned: false
        }));
    }

    function returnTool(uint toolId, uint256 quantity) public {
        require(toolId < toolCount, "Tool does not exist.");
        require(loanRecords[toolId].length > 0, "No loan records found for this tool.");
        require(loanRecords[toolId][loanRecords[toolId].length - 1].borrower == msg.sender, "Not the borrower of this tool.");
        require(!loanRecords[toolId][loanRecords[toolId].length - 1].returned, "Tool already returned.");

        tools[toolId].quantity += quantity;
        loanRecords[toolId][loanRecords[toolId].length - 1].returned = true;
    }

    function getTool(uint toolId) public view returns (string memory name, string memory description, uint256 quantity, bool isAvailable) {
        require(toolId < toolCount, "Tool does not exist.");
        Tool memory tool = tools[toolId];
        return (tool.name, tool.description, tool.quantity, tool.isAvailable);
    }

    function getLoanRecords(uint toolId) public view returns (LoanRecord[] memory) {
        require(toolId < toolCount, "Tool does not exist.");
        return loanRecords[toolId];
    }
}