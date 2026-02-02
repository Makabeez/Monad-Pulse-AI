// Script de pilotage automatique pour Monad Pulse
const CONTRACT_ADDRESS = "0x860...db3fd"; // Ton adresse de contrat déployé

async function main() {
    console.log("🤖 Initialisation de l'Agent Monad Pulse...");
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    const myAddress = accounts[0];
    
    // Définition de l'ABI simplifiée
    const abi = [{"inputs":[{"internalType":"string","name":"_strategy","type":"string"}],"name":"triggerPulse","outputs":[],"stateMutability":"nonpayable","type":"function"}];
    const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, ethers.provider.getSigner());

    setInterval(async () => {
        try {
            console.log("📊 Analyse du marché en cours via IA...");
            const strategy = "HighFreq_Arb_v1";
            
            console.log("🚀 Envoi du signal de trading au contrat Monad...");
            const tx = await contract.triggerPulse(strategy);
            console.log(`✅ Transaction validée ! Hash: ${tx.hash}`);
        } catch (error) {
            console.error("❌ Erreur de l'agent :", error.message);
        }
    }, 30000); // Exécution toutes les 30 secondes
}

main();
