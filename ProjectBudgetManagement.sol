// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract ProjectBudgetManagement {
    struct Budget {
        string projectName;
        uint256 totalBudget;
        uint256 allocatedAmount;
        bool finalized;
    }

    mapping(uint256 => Budget) public budgets;
    uint256 public budgetCount;

    event BudgetCreated(uint256 budgetId, string projectName, uint256 totalBudget);
    event AllocationMade(uint256 budgetId, uint256 amount);
    event BudgetFinalized(uint256 budgetId);

    function createBudget(string memory _projectName, uint256 _totalBudget) public {
        require(bytes(_projectName).length > 0, "Project name cannot be empty");
        require(_totalBudget > 0, "Total budget must be greater than zero");

        budgetCount++;
        budgets[budgetCount] = Budget({
            projectName: _projectName,
            totalBudget: _totalBudget,
            allocatedAmount: 0,
            finalized: false
        });

        emit BudgetCreated(budgetCount, _projectName, _totalBudget);
    }

    function allocateFunds(uint256 _budgetId, uint256 _amount) public {
        require(_budgetId > 0 && _budgetId <= budgetCount, "Invalid budget ID");
        require(_amount > 0, "Amount must be greater than zero");
        require(!budgets[_budgetId].finalized, "Budget is already finalized");
        require(budgets[_budgetId].allocatedAmount + _amount <= budgets[_budgetId].totalBudget, "Insufficient budget");

        budgets[_budgetId].allocatedAmount += _amount;
        emit AllocationMade(_budgetId, _amount);
    }

    function finalizeBudget(uint256 _budgetId) public {
        require(_budgetId > 0 && _budgetId <= budgetCount, "Invalid budget ID");
        require(!budgets[_budgetId].finalized, "Budget is already finalized");

        budgets[_budgetId].finalized = true;
        emit BudgetFinalized(_budgetId);
    }

    function getBudget(uint256 _budgetId) public view returns (string memory projectName, uint256 totalBudget, uint256 allocatedAmount, bool finalized) {
        require(_budgetId > 0 && _budgetId <= budgetCount, "Invalid budget ID");

        Budget storage budget = budgets[_budgetId];
        return (budget.projectName, budget.totalBudget, budget.allocatedAmount, budget.finalized);
    }
}