// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title MonadPulse
 * @dev Vault intelligent pour la gestion de liquidité par IA sur Monad
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
        require(msg.sender == owner, "Seul le proprietaire peut faire ca");
        _;
    }

    // Définit l'adresse du script IA qui pourra envoyer des signaux
    function setAiAgent(address _aiAgent) external onlyOwner {
        aiAgent = _aiAgent;
    }

    // Fonction que l'IA appellera pour simuler une action de trading haute frequence
    function triggerPulse(string calldata _strategy) external {
        require(msg.sender == owner || msg.sender == aiAgent, "Acces refuse");
        emit StrategyExecuted(_strategy, block.timestamp);
    }

    // Permet de retirer les MON accumules (les profits !)
    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        emit FundsReceived(msg.sender, msg.value);
    }
}
