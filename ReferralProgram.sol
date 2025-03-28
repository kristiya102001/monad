// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ReferralProgram {
    struct Referral {
        address referee;
        uint256 referralDate;
    }

    mapping(address => Referral[]) public referrals;

    function refer(address referee) public {
        require(referee != msg.sender, "Cannot refer yourself.");
        require(!isReferred(referee), "Referee already referred.");

        referrals[msg.sender].push(Referral({
            referee: referee,
            referralDate: block.timestamp
        }));
    }

    function isReferred(address referee) internal view returns (bool) {
        for (uint i = 0; i < referrals[msg.sender].length; i++) {
            if (referrals[msg.sender][i].referee == referee) {
                return true;
            }
        }
        return false;
    }

    function getReferrals(address referrer) public view returns (Referral[] memory) {
        return referrals[referrer];
    }
}