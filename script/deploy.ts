import { ethers } from "hardhat";

async function main() {
  // Define the certificate URI
  const certificateURI: string = "ipfs://bafkreicgeq73eavrzwxrvd53q34pyvs2jpgn7gdebmxac7zokmnymjwjl4"; // Replace with actual IPFS or metadata link

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
