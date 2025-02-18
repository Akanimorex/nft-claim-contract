import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
dotenv.config();
const PrivateKey = process.env.PRIVATE_KEY ;

// const config: HardhatUserConfig = {
//   solidity: "0.8.28",
// };









const config: HardhatUserConfig  = {
  defaultNetwork: 'testnet',

  networks: {
     hardhat: {
     },
     testnet: {
        url: 'https://rpc.test2.btcs.network',
        accounts: [PrivateKey!],
        chainId: 1114,
      }
  },
  solidity: {
     compilers: [
       {
          version: '0.8.20',
          settings: {
             evmVersion: 'paris',
             optimizer: {
                enabled: true,
                runs: 200,
             },
          },
       },
     ],
  },
  etherscan: {
    apiKey: {
      testnet: process.env.CORE_TEST_SCAN_KEY!,
      mainnet: process.env.CORE_MAIN_SCAN_KEY!,
    },
    customChains: [
      {
        network: "testnet",
        chainId: 1114,
        urls: {
          apiURL: "https://api.test2.btcs.network/api",
          browserURL: "https://scan.test2.btcs.network/"
        }
      },
      {
        network: "mainnet",
        chainId: 1116,
        urls: {
          apiURL: "https://openapi.coredao.org/api",
          browserURL: "https://scan.coredao.org/"
        }
      }
    ]
  },
  paths: {
     sources: './contracts',
     cache: './cache',
     artifacts: './artifacts',
  },
  mocha: {
     timeout: 20000,
  },

  
};

export default config;
