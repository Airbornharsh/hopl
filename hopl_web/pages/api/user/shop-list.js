import jwt from "jsonwebtoken";
import DbConnect from "../../../Server/config/Db_Config";

const handler = async (req, res) => {
  if (req.method === "GET") {
    await GETHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const GETHANDLER = async (req, res) => {
  try {
    const DbModels = await DbConnect();

    const tempShop = await DbModels.shop.find({});

    return res.send(tempShop);
  } catch (e) {
    return res.status(500).send(e);
  }
};

export default handler;
