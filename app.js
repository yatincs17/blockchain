window.addEventListener('load', async () => {
    if (window.ethereum) {
        window.web3 = new Web3(ethereum);
        try {
            await ethereum.request({ method: 'eth_requestAccounts' });
            console.log("metamask connected");
        } catch (error) {
            console.error("error", error);
        }
    } else {
        console.log('try metamask');
    }

    document.getElementById('donateButton').addEventListener('click', async () => {
        console.log("Donate button clicked");
        const amount = document.getElementById('donationAmount').value;
        if (!amount || isNaN(amount) || amount <= 0) {
            alert('enter valid amount');
            return;
        }
        await sendDonation(amount);
    });

async function sendDonation(amount) {
    const contractAddress = '0xb01d2a4afc6DBdd6A9f21a2146781a3fAF43380f';
    const accounts = await web3.eth.getAccounts();
    const amountInWei = web3.utils.toWei(amount, 'ether');

    web3.eth.sendTransaction({ from: accounts[0], to: contractAddress, value: amountInWei
    }).then(receipt => {
        console.log('transaction successful: ', receipt);
        alert("Donation to hospital was successful. We appreciate your donation!")
    }).catch(error => {
        console.error('error:', error);
    });
}
})