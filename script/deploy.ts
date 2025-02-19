import { ethers } from "hardhat";

async function main() {
  // Define the certificate URI
  const certificateURI: string = "ipfs://bafkareick4f4rfu3rqdzyzrhs2jum2lj3yyyxtlwp5boey5oknpsg5u5tle"; // Replace with actual IPFS or metadata link

  // Get the contract factory
  const CourseCertificateNFT = await ethers.getContractFactory("CourseCertificateNFT");

  // Deploy the contract with the fixed certificate URI
  const contract = await CourseCertificateNFT.deploy(certificateURI as any); // Explicitly cast certificateURI

  // Ensure the contract is deployed
  await contract.waitForDeployment();

  // Retrieve and log contract address
  const certificateAddress = await contract.getAddress();
  console.log(`CourseCertificateNFT deployed to: ${certificateAddress}`);
}

// Execute deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
