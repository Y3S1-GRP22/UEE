import User from "../models/User.mjs";
import logger from "../utils/logger.mjs";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

export const createUser = async (req, res) => {
  const { userName, email, contact, password, role } = req.body;
  console.log(userName + " " + email + " " + contact + " " + role);
  const hashedPassword = await bcrypt.hash(password, 12);

  User.create({
    userName,
    email,
    contact,
    password: hashedPassword,
    role,
  })
    .then((User) => {
      console.log({ status: "Success", User });
      return res.json(User);
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (await bcrypt.compare(password, user.password)) {
      res.status(200).json({
        user: {
          userName: user.userName,
          email: user.email,
          contact: user.contact,
          role: user.role,
        },
      });
    } else {
      res.status(401).json({ message: "Invalid credentials" });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

export const changePassword = async (req, res) => {
  try {
    const { email, newPassword } = req.body;

    // Find the user by email
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Generate a new salt and hash the new password
    const saltRounds = 12; // You can adjust this value as needed
    const hashedNewPassword = await bcrypt.hash(newPassword, saltRounds);

    // Update the user's password
    user.password = hashedNewPassword;
    await user.save();

    res.status(200).json({ message: "Password changed successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

export const updateUser = async (req, res) => {
  try {
    const { email, username, contact } = req.body;

    // Find the user by email
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Update the user's username, password, and contact
    if (username) {
      user.userName = username;
    }
    if (contact) {
      user.contact = contact;
    }

    await user.save();

    res.status(200).json({ message: "User information updated successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

export const deleteUser = async (req, res) => {
  try {
    const email = req.params.email;

    // Find the user by email
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Delete the user
    await User.deleteOne({ email: email });

    res.status(200).json({ message: "User deleted successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error", error: error.message });
  }
};

export const getFarmerContact = async (req, res) => {
  try {
      const { farmerName } = req.params;

      const farmer = await User.findOne({ userName:farmerName });

      if (!farmer) {
          return res.status(404).json({ error: "Farmer not found" });
      }

      res.status(200).json({ contact: farmer.contact });
  } catch (error) {
      res.status(500).json({ error: "Internal server error" });
  }
};


export const getEmailFromUserName = async (req, res) => {
  const { userName } = req.params;
  try {
    const user = await User.findOne({ userName });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    const { email } = user;
    return res.status(200).json({ email });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'Internal Server Error' });
  }
};