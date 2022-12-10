import bcrypt from "bcrypt";
import DbConnect from "../../../Server/config/Db_Config";
// const { Auth } = require("two-step-auth");
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

    const hashPassword = await bcrypt.hash(req.body.password.trim(), 10);

    const newUser = new DbModels.user({
      name: req.body.name,
      emailId: req.body.emailId,
      phoneNumber: req.body.phoneNumber,
      password: hashPassword,
      orders: [],
      imgUrl:
        req.body.imgUrl ||
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
      address: "",
    });

    const userSave = await newUser.save();

    return res.status(200).send(userSave);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e.message);
  }
};

export default register;
