import { ethers } from "hardhat";

async function main() {
  const NFTPunk = await ethers.getContractFactory("NFTPunk");
  const nftPunk = await NFTPunk.deploy(999);

  await nftPunk.deployed();

  console.log(`NFT Punk deployed: ${nftPunk.address}`); // 0x1e833cD3Ac84dAaF02fDa3C1729a2b9f16111256
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
