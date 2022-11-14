import DbConnect from "../../../../Server/config/Db_Config";
import jwt from "jsonwebtoken";

const verify = async (req, res) => {
  if (req.method === "POST") {
    await POSTHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const POSTHANDLER = async (req, res) => {
  try {
    const DbModels = await DbConnect();

    if (!req.body.accessToken) return res.status(401).send("No access Token");

    let tempUser;
    let tempErr;

    jwt.verify(req.body.accessToken, process.env.JWT_SECRET, (err, temp) => {
      tempUser = temp;
      tempErr = err;
    });


    if (tempErr) return res.status(400).send(tempErr.message);

    if (req.body.otp !== tempUser.otp.toString())
      return res.status(400).send("Wrong Otp");

    const newUser = new DbModels.user({
      name: tempUser.name,
      emailId: tempUser.emailId,
      phoneNumber: tempUser.phoneNumber,
      password: tempUser.password,
    });

    const userSave = await newUser.save();

    return res.send(userSave);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e.message);
  }
};

export default verify;
