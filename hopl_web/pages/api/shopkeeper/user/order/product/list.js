import DbConnect from "../../../../../../Server/config/Db_Config";
import jwt from "jsonwebtoken";

const handler = async (req, res) => {
  if (req.body.method === "LIST") {
    await LISTHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const LISTHANDLER = async (req, res) => {
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

    const productList = await DbModels.userProduct.find({
      orderId: body.orderId,
    });

    // const productIds = [];

    // productList.forEach((product) => {
    //   productIds.push(product.productId);
    // });

    // const products = await DbModels.product.find({
    //   _id: productIds,
    // });

    // console.log(products);

    return res.send(productList);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

export default handler;
