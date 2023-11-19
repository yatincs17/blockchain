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
    const contractAddress = '0x86F50902b5326cE7eA71EE01316F2ec2efb9c9B8';
    const accounts = await web3.eth.getAccounts();
    const amountInWei = web3.utils.toWei(amount, 'ether');

    web3.eth.sendTransaction({ from: accounts[0], to: contractAddress, value: amountInWei
    }).then(receipt => {
        console.log('transaction successful: ', receipt);
    }).catch(error => {
        console.error('error:', error);
    });
}
})