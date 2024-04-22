const hre = require("hardhat");

async function main() {
    [owner, addr1] = await ethers.getSigners();


  const FutureCertX = await hre.ethers.getContractFactory("FutureCertX");
  const futureCertX = await FutureCertX.deploy(owner.address);

 // await futureCertX.deployed();

  console.log("My NFT deployed to:", owner.address);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
  