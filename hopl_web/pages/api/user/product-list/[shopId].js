import jwt from "jsonwebtoken";
import DbConnect from "../../../../Server/config/Db_Config";

const handler = async (req, res) => {
  if (req.method === "GET") {
    await GETHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const GETHANDLER = async (req, res) => {
  try {
    const { shopId } = req.query;

    const DbModels = await DbConnect();

    const tempProducts = await DbModels.product.find({ shopId: shopId });

    return res.send(tempProducts);
  } catch (e) {
    return res.status(500).send(e);
  }
};

export default handler;
