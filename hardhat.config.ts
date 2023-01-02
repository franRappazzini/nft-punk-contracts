import "@nomicfoundation/hardhat-toolbox";

import { HardhatUserConfig } from "hardhat/config";
import dotenv from "dotenv";

dotenv.config();

const { PRIVATE_KEY, ALCHEMY_PROJECT_ID } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    hardhat: { chainId: 1337 },
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/${ALCHEMY_PROJECT_ID}`,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};

export default config;
