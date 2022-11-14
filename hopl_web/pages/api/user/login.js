import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import DbConnect from "../../../Server/config/Db_Config";

const login = async (req, res) => {
  if (req.method === "POST") {
    await POSTHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const POSTHANDLER = async (req, res) => {
  const body = req.body;
  try {
    const DbModels = await DbConnect();

    const tempUser = await DbModels.user.findOne({ emailId: body.emailId });
    if (!tempUser) {
      return res.status(401).send("No Email Id Exists");
    }

    const passwordConfirm = await bcrypt.compare(
      body.password,
      tempUser.password
    );

    if (!passwordConfirm) {
      return res.status(402).send("Wrong Password");
    }

    const sendUser = {
      _id: tempUser._id,
      emailId: tempUser.emailId,
      phoneNumber: tempUser.phoneNumber,
      shopkeeper: tempUser.shopkeeper,
    };

    const accessToken = jwt.sign(sendUser, process.env.JWT_SECRET);

    return res.send({ accessToken });
  } catch (e) {
    console.log(e);
    return res.status(500).send(e.message);
  }
};

export default login;
