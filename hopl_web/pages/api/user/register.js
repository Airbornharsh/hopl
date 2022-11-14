import bcrypt from "bcrypt";
import DbConnect from "../../../Server/config/Db_Config";
import { Auth } from "two-step-auth";
import jwt from "jsonwebtoken";

const register = async (req, res) => {
  if (req.method == "POST") {
    await POSTHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const POSTHANDLER = async (req, res) => {
  try {
    const DbModels = await DbConnect();

    const tempUser = await DbModels?.user.findOne({
      emailId: req.body.emailId,
    });
    if (tempUser) {
      return res.send("Email Id Exist!");
    }

    const hashPassword = await bcrypt.hash(req.body.password, 10);

    const otpData = await Auth(req.body.emailId, "Hopl");

    const newUser = {
      name: req.body.name,
      emailId: req.body.emailId,
      phoneNumber: req.body.phoneNumber,
      password: hashPassword,
      otp: otpData.OTP,
    };

    const accessToken = jwt.sign(newUser, process.env.JWT_SECRET);

    return res.status(200).send({ accessToken });
  } catch (e) {
    console.log(e);
    return res.status(500).send(e.message);
  }
};

export default register;
