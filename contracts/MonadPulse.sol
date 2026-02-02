// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title MonadPulse
 * @dev Intelligent Vault for AI-driven liquidity management on Monad
 */
contract MonadPulse {
    address public owner;
    address public aiAgent;
    
    event StrategyExecuted(string strategyName, uint256 timestamp);
    event FundsReceived(address from, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function setAiAgent(address _aiAgent) external onlyOwner {
        aiAgent = _aiAgent;
    }

    function triggerPulse(string calldata _strategy) external {
        require(msg.sender == owner || msg.sender == aiAgent, "Access denied");
        emit StrategyExecuted(_strategy, block.timestamp);
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        emit FundsReceived(msg.sender, msg.value);
    }
}
