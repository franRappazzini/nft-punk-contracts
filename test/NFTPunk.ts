import { ethers } from "hardhat";
import { expect } from "chai";

describe("NFT Punk Contract", () => {
  const setup = async ({ supply = 999 }) => {
    const NFTPunk = await ethers.getContractFactory("NFTPunk");
    const nftPunk = await NFTPunk.deploy(supply);
    await nftPunk.deployed();
    const [owner] = await ethers.getSigners();

    return { nftPunk, owner };
  };

  it("Sets max supply", async () => {
    const supply = 100;

    const { nftPunk } = await setup({ supply });

    expect(await nftPunk.maxSupply()).to.equal(supply);
  });

  it("Has a minting limit", async () => {
    const supply = 2;

    const { nftPunk } = await setup({ supply });

    await Promise.all([nftPunk.mint(), nftPunk.mint()]);

    await expect(nftPunk.mint()).to.be.revertedWith("No NFT Punks left...");
  });

  it("returns valid metadata", async () => {
    const { nftPunk } = await setup({});

    await nftPunk.mint();

    const tokenURI = await nftPunk.tokenURI(0);
    const stringifiedTokenURI = tokenURI.toString();
    const [, base64JSON] = stringifiedTokenURI.split("data:application/json;base64,");
    const stringifiedMetadata = Buffer.from(base64JSON, "base64").toString("ascii");
    const metadata = JSON.parse(stringifiedMetadata);

    expect(metadata).to.have.all.keys("name", "description", "image");
  });
});
