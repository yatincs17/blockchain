window.addEventListener('load', async () => {
    if (window.ethereum) {
        window.web3 = new Web3(ethereum);
        try {
            await ethereum.request({ method: 'eth_requestAccounts' });
            console.log("MetaMask connected");
        } catch (error) {
            console.error("User denied account access", error);
        }
    } else {
        console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }

    document.getElementById('donateButton').addEventListener('click', async () => {
        console.log("Donate button clicked");
        const amount = document.getElementById('donationAmount').value;
        if (!amount || isNaN(amount) || amount <= 0) {
            alert('Please enter a valid donation amount');
            return;
        }
        await sendDonation(amount);
    });
});

async function sendDonation(amount) {
    const contractAddress = '0xE871E35A619B0cf36748CFF0c5F6FFb98F384111';
    const accounts = await web3.eth.getAccounts();
    const amountInWei = web3.utils.toWei(amount, 'ether');

    web3.eth.sendTransaction({
        from: accounts[0],
        to: contractAddress,
        value: amountInWei
    }).then(receipt => {
        console.log('Transaction successful: ', receipt);
    }).catch(error => {
        console.error('Error sending donation:', error);
    });
}
