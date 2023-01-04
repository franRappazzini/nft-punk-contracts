import { ethers } from "hardhat";

async function main() {
  const NFTPunk = await ethers.getContractFactory("NFTPunk");
  const nftPunk = await NFTPunk.deploy(999);

  await nftPunk.deployed();

  console.log(`NFT Punk deployed: ${nftPunk.address}`); // 0x2B2d85737B4A352A4000b055FF0a2B4Db2e7051b
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
