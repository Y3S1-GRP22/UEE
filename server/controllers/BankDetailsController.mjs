import Bank from "../models/BankDetails.mjs";
import User from "../models/User.mjs"; // Import the User model

export const createBankAccountDetails = async (req, res) => {
  console.log("Received request to create bank details"); // New log

  const { email, bankName, branchName, branchNumber, accountNumber } = req.body;

  console.log(`Checking existence for email: ${email}`); // New log

  console.log(
    email +
      " " +
      bankName +
      " " +
      branchName +
      " " +
      branchNumber +
      " " +
      accountNumber
  );

  // Check if a user with the given email already exists
  const userExists = await User.findOne({ email });

  if (userExists) {
    // User with the provided email already exists, so create bank details
    Bank.create({
      email,
      bankName,
      branchName,
      branchNumber,
      accountNumber,
    })
      .then((bank) => {
        console.log({ status: "Success", bank });
        return res.json(bank);
      })
      .catch((err) => {
        console.log({ status: "Error", err });
        return res.json({ status: "Error", err });
      });
  } else {
    console.log(`No user found for email: ${email}`); // New log
    // User with the provided email doesn't exist
    return res.status(404).json({ status: "Error", message: "User not found" });
  }
};
