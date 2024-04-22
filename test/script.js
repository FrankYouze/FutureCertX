// test/FutureCertX.test.js

const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("FutureX", function () {
  let futureCertX;
  let owner;
  let addr1;
  const rec = "0xdD2FD4581271e230360230F9337D5c0430Bf44C0"
  const addr2 = "0xd90fbbe044d9775cf77513dcf122699a41f1aec4"

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();

    const FutureCertX = await ethers.getContractFactory("FutureCertX");
    futureCertX = await FutureCertX.deploy(owner.address);
 //   await futureCertX.deployed();
  });

  it("Should set the right owner", async function () {
    expect(await futureCertX.owner()).to.equal(owner.address);
  });

  it("Should mint a cert to an address", async function () {
    const tokenId = 0;
    const uri = "cid/.png";
    await futureCertX.safeMint(owner.address, uri);
    const ownedTokensIDs = await futureCertX.getOwnedTokens(addr2);
    expect(await futureCertX.ownerOf(tokenId)).to.equal(owner.address);
   // expect(await futureCertX.tokenURI(tokenId)).to.equal("ipfs://" + uri);
  });

  it("Should allow owner to set mint requrments", async function () {
    const newPrice = ethers.parseEther("0.0002");
    await futureCertX.connect(owner).setMintPrice(newPrice);
    expect(await futureCertX.mintPrice()).to.equal(newPrice);
  });

  it("Should allow user to redeem certificate", async function () {
    const metadataURI = "cid/test2.png";
    //const initialBalance = await ethers.getBalance(addr1.address);
    const initialBalance = await futureCertX.balanceOf(addr2);
    console.log(initialBalance);
    // const tx = await futureCertX.connect(rec).payToMint(metadataURI, {
    //   value: ethers.parseEther("0.0001"),
    // });

    const tx = await futureCertX.payToMint(rec,metadataURI,{value: ethers.parseEther("0.0001")});
    

    const receipt = await tx.wait();
  //  const gasUsed = receipt.gasUsed.mul(tx.gasPrice);
    const finalBalance = await ethers.provider.getBalance(rec);
  
    await futureCertX.payToMint(rec, metadataURI, { value: ethers.parseEther("0.0001") });
    await futureCertX.payToMint(rec, metadataURI, { value: ethers.parseEther("0.0001") });
    await futureCertX.payToMint(rec, metadataURI, { value: ethers.parseEther("0.0001") });
    await futureCertX.payToMint(rec, metadataURI, { value: ethers.parseEther("0.0001") });
   // console.log("Balance of address " + rec + ": " + (await futureCertX.balanceOf(rec)).toString());
    


    // expect(finalBalance).to.equal(
    //   initialBalance.sub(ethers.parseEther("0.0001")).sub(gasUsed)
    // );

     //const tokenId = await futureCertX.tokenOfOwnerByIndex(addr1.address, 0);
    // expect(await futureCertX.ownerOf(tokenId)).to.equal(addr1.address);
    // expect(await futureCertX.tokenURI(tokenId)).to.equal("ipfs://" + metadataURI);
  });

  it("Should revert if user pays insufficient amount to mint", async function () {
    const metadataURI = "cid/test3.png";
    await expect(
      futureCertX.payToMint(rec,metadataURI, {
        value: ethers.parseEther("0.00009"), // Insufficient amount
      })
    ).to.be.revertedWith("Insufficient credits to certfy!");
  });


  it("Should return the correct number of NFTs owned by an address", async function () {
    const metadataURI = "cid/test4.png";
    //const recipient = rec;
    const initialBalance = await futureCertX.balanceOf(rec);
    
    // Mint some NFTs to the recipient
    await futureCertX.payToMint(rec, metadataURI, { value: ethers.parseEther("0.0001") });
    await futureCertX.payToMint(rec, metadataURI, { value: ethers.parseEther("0.0001") });
    
    // Check the balance after minting
    const finalBalance = await futureCertX.balanceOf(rec);
    //const myBigInt = Number(finalBalance);
    
    // Expect the final balance to be increased by the number of minted tokens
    expect(finalBalance).to.equal(initialBalance + BigInt(2));
   // console.log("Balance of address " + rec + ": " + (await futureCertX.balanceOf(rec)).toString());





});
it("Should console.log the list of token IDs owned by an address", async function () {
  const metadataURI = "cid/test4.png";
  const metadataURI2 = "cid/test5.png";
  
  // Fetch the list of token IDs owned by the 'rec' address
  await futureCertX.payToMint(rec, metadataURI, { value: ethers.parseEther("0.0001") });
  await futureCertX.payToMint(rec, metadataURI2, { value: ethers.parseEther("0.0001") });

});



it("Should return the correct tokenURIs of tokens owned by an address", async function () {
  const metadataURI = 'cid/${tokenId}.json'
  const initialBalance = await futureCertX.balanceOf(rec);
  
  // Mint some NFTs to the recipient
  await futureCertX.payToMint(addr2, metadataURI, { value: ethers.parseEther("0.0001") });
  await futureCertX.payToMint(addr2, metadataURI, { value: ethers.parseEther("0.0001") });
 // console.log("Balance of address " + rec + ": " + (await futureCertX.balanceOf(rec)).toString());
  
  // Check the balance after minting
  const finalBalance = await futureCertX.balanceOf(addr2);
  expect(finalBalance).to.equal(initialBalance + BigInt(2));

  // Get the token URIs owned by the recipient
  const myURI = await futureCertX.tokenURI(0);
  const tokenURIs = await futureCertX.tokensURIsOfOwner(0x2765D46477FFcFb0c3F51886d02054AaFDe034Ad);
  const ownedTokens = await futureCertX.getOwnedTokens(addr2);
  const tokenCount = await futureCertX.getTokenCount(addr2);
 // const uri = await futureCertX.getTokenURI(1);
  //console.log("retrived URIs "+ tokenURIs.logs);
 
  // Check the token URI for each token owned by the recipient
    // for (const uri of tokenURIs) {
    //     expect(uri).to.equal("ipfs://" + metadataURI);
    // }
    console.log("myUri "+ myURI);
    console.log("tokenCount " + tokenCount);
    console.log("owned tokens "+ ownedTokens);
  console.log("retrived URIs "+ tokenURIs);
  
});

});
