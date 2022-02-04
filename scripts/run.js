const main = async () => {
    const  [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
    await waveContract.deployed();
    console.log("Contract addy:", waveContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by: ", owner.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave("Hi There, First!");
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave('Hi There, Second!');
    await waveTxn.wait();

    // This should fail ("Wait 15min")
    /*
    waveTxn = await waveContract.connect(randomPerson).wave('Hi There, Third!');
    await waveTxn.wait();
    */

    waveCount = await waveContract.getTotalWaves();

    senderCount = await waveContract.getSenderCount(randomPerson.address);

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
        "COntract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );


};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();