import DbConnect from "../../../Server/config/Db_Config";
import jwt from "jsonwebtoken";

const handler = async (req, res) => {
  if (req.method === "GET") {
    await GETHANDLER(req, res);
  } else if (req.method === "PUT") {
    await PUTHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const GETHANDLER = async (req, res) => {
  try {
    const DbModels = await DbConnect();

    const accessToken = req.headers.authorization.split(" ")[2];

    let tempUser;
    let tempErr;

    jwt.verify(accessToken, process.env.JWT_SECRET, (err, user) => {
      tempErr = err;
      tempUser = user;
    });

    if (tempErr) {
      return res.status(401).send(tempErr);
    }

    const userData = await DbModels.user.findById(tempUser._id);

    return res.send(userData);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

const PUTHANDLER = async (req, res) => {
  try {
    const body = req.body;
    const DbModels = await DbConnect();

    const accessToken = req.headers.authorization.split(" ")[2];

    let tempUser;
    let tempErr;

    jwt.verify(accessToken, process.env.JWT_SECRET, (err, user) => {
      tempErr = err;
      tempUser = user;
    });

    if (tempErr) {
      return res.status(401).send(tempErr);
    }

    let updateUser = {};

    body.name && (updateUser.name = body.name);
    body.address && (updateUser.address = body.address);

    if (!updateUser.name && !updateUser.address) {
      return res.status(400).send("Nothing to Update");
    }

    await DbModels.user.findByIdAndUpdate(tempUser._id, updateUser);

    return res.send("Updated");
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

export default handler;
