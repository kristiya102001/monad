// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ProjectReportManagement {
    struct Report {
        string projectName;
        string reportContent;
        uint256 submissionDate;
        address submitter;
        bool reviewed;
    }

    mapping(uint256 => Report) public reports;
    uint256 public reportCount;

    event ReportSubmitted(uint256 reportId, string projectName, address submitter, uint256 submissionDate);
    event ReportReviewed(uint256 reportId, bool reviewed);

    function submitReport(string memory _projectName, string memory _reportContent) public {
        require(bytes(_projectName).length > 0, "Project name cannot be empty");
        require(bytes(_reportContent).length > 0, "Report content cannot be empty");

        reportCount++;
        reports[reportCount] = Report({
            projectName: _projectName,
            reportContent: _reportContent,
            submissionDate: block.timestamp,
            submitter: msg.sender,
            reviewed: false
        });

        emit ReportSubmitted(reportCount, _projectName, msg.sender, block.timestamp);
    }

    function reviewReport(uint256 _reportId, bool _reviewed) public {
        require(_reportId > 0 && _reportId <= reportCount, "Invalid report ID");

        reports[_reportId].reviewed = _reviewed;
        emit ReportReviewed(_reportId, _reviewed);
    }

    function getReport(uint256 _reportId) public view returns (string memory projectName, string memory reportContent, uint256 submissionDate, address submitter, bool reviewed) {
        require(_reportId > 0 && _reportId <= reportCount, "Invalid report ID");

        Report storage report = reports[_reportId];
        return (report.projectName, report.reportContent, report.submissionDate, report.submitter, report.reviewed);
    }
}