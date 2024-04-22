require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  paths: {
    artifacts: './artifacts',
  },
  networks:{
    localhost: {
       url: 'http://localhost:8545',
      chainId: 31337,
      accounts: ["0xdf57089febbacf7ba0bc227dafbffa9fc08a93fdc68e1e42411a14efcf23656e"]
    },

   sepolia:{
    url:"https://eth-sepolia.g.alchemy.com/v2/ChjRX36rordyM_ORNlolsPsmUqSeWYPc",
    accounts:["c8c3d27fac5a14aec077f99338626a8590d0a5739434a353d674f1c8c4cd1ad2"]
   }
  }

};
