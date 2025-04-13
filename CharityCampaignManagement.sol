// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract CharityCampaignManagement {
    struct Campaign {
        string name;
        string description;
        uint256 goalAmount;
        uint256 raisedAmount;
        bool completed;
    }

    mapping(uint256 => Campaign) public campaigns;
    uint256 public campaignCount;

    event CampaignCreated(uint256 campaignId, string name, string description, uint256 goalAmount);
    event DonationMade(uint256 campaignId, address donor, uint256 amount);
    event CampaignCompleted(uint256 campaignId);

    function createCampaign(string memory _name, string memory _description, uint256 _goalAmount) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_description).length > 0, "Description cannot be empty");
        require(_goalAmount > 0, "Goal amount must be greater than zero");

        campaignCount++;
        campaigns[campaignCount] = Campaign({
            name: _name,
            description: _description,
            goalAmount: _goalAmount,
            raisedAmount: 0,
            completed: false
        });

        emit CampaignCreated(campaignCount, _name, _description, _goalAmount);
    }

    function makeDonation(uint256 _campaignId, uint256 _amount) public {
        require(_campaignId > 0 && _campaignId <= campaignCount, "Invalid campaign ID");
        require(_amount > 0, "Amount must be greater than zero");
        require(!campaigns[_campaignId].completed, "Campaign is already completed");

        campaigns[_campaignId].raisedAmount += _amount;
        emit DonationMade(_campaignId, msg.sender, _amount);

        if (campaigns[_campaignId].raisedAmount >= campaigns[_campaignId].goalAmount) {
            campaigns[_campaignId].completed = true;
            emit CampaignCompleted(_campaignId);
        }
    }

    function getCampaign(uint256 _campaignId) public view returns (string memory name, string memory description, uint256 goalAmount, uint256 raisedAmount, bool completed) {
        require(_campaignId > 0 && _campaignId <= campaignCount, "Invalid campaign ID");

        Campaign storage campaign = campaigns[_campaignId];
        return (campaign.name, campaign.description, campaign.goalAmount, campaign.raisedAmount, campaign.completed);
    }
}