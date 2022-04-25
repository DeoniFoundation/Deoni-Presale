// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const { ethers } = require("ethers");


async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  const addr = await web3.eth.getAccounts();
  // for (const addrr of addr) {
  //   console.log(addrr.address);
  // }
  console.log("Address 0:", addr[0]);
  // We get the contract to deploy
  // const Deoni = await hre.ethers.getContractFactory("Deoni");
  // const deoni = await Deoni.deploy();

  // await deoni.deployed();
  

  // console.log("Deoni deployed to:", deoni.address);

  // const Svsinfotech = await hre.ethers.getContractFactory("Svsinfotech");
  // const svsinfotech = await Svsinfotech.deploy();

  // await svsinfotech.deployed();
  // console.log("svsinfotech deployed to:", svsinfotech.address);

  const deoni_address = "0x80a1e9a8B3B8eDd9e121B77F1bd73C8b128784de";
  const deoni2_address = "0x37e2dbe5c4363c4242fCDfEEAbFaa32a4837A193";
  // const deoni2_address = svsinfotech.address;

  const DeoniCrowsale1 = await hre.ethers.getContractFactory("DeoniCrowsale1");
  console.log("Deoni1 deployed : DeoniCrowsale1:");
  // console.log("Deoni deployed :",deoni.address);
  // const deoniCrowsale1 = await DeoniCrowsale1.deploy(ethers.utils.parseEther("0.00002"),1, addr[0],ethers.utils.parseEther("10"), deoni_address, svsinfotech.address);
  const deoniCrowsale1 = await DeoniCrowsale1.deploy(ethers.utils.parseEther("0.00002"),1, addr[0],ethers.utils.parseEther("10"), deoni_address, deoni2_address);
  console.log("Deoni1 deployed : deoniCrowsale1");
  const tokenInstance = await deoniCrowsale1.deployed();
  // await deoni.
  // await tokenInstance.transfer(DeoniCrowsale.address, 100);
  console.log("Crowd Sale deployed to:", tokenInstance.address);
  
  // await hre.run("verify:verify", {
  //   address: deoni.address
  // });
  // await sleep(1000);

  // await hre.run("verify:verify", {
  //   address: svsinfotech.address
  // });

  await hre.run("verify:verify", {
    address: tokenInstance.address,
    constructorArguments: [
      ethers.utils.parseEther("0.00002"),
      1,
      addr[0],
      ethers.utils.parseEther("10"),
      deoni_address,
      deoni2_address
    ],
  });
  // await hre.run("verify:verify", {
  //   address: tokenInstance.address,
  //   constructorArguments: [
  //     ethers.utils.parseEther("0.00002"),
  //     1,
  //     addr[0],
  //     ethers.utils.parseEther("10"),
  //     deoni_address,
  //     svsinfotech.address
  //   ],
  // });

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
