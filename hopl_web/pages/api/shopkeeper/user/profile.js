import DbConnect from "../../../../Server/config/Db_Config";
import jwt from "jsonwebtoken";

const handler = async (req, res) => {
  if (req.body.method === "GET") {
    await GETHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const GETHANDLER = async (req, res) => {
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

    if (tempUser.shopkeeper === false) {
      return res.status(401).send("Your are Not a Shopkeeper");
    }

    const orderData = await DbModels.userOrder.findById(body.orderId);

    const userData = await DbModels.user.findById(orderData.userId);

    const user = {
      name: userData.name,
      phoneNumber: userData.phoneNumber,
      address: userData.address,
      imgUrl: userData.imgUrl,
      createdAt: userData.createdAt,
    };

    return res.send(user);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

export default handler;
