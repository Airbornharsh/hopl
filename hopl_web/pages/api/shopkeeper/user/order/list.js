import DbConnect from "../../../../../Server/config/Db_Config";
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

    const shopDetail = await DbModels.shop.findOne({
      shopKeeperId: tempUser._id,
    });

    const userOrderList = await DbModels.userOrder.find({
      shopId: shopDetail._id,
      confirm: false,
    });

    const tempUserIds = [];

    userOrderList.forEach((user) => {
      tempUserIds.push(user.userId);
    });

    const userList = await DbModels.user.find({
      _id: tempUserIds,
    });

    const filteredUserOrderList = [];

    for (let i = 0; i < userOrderList.length; i++) {
      const tempUserOrder = {
        _id: userOrderList[i]._id,
        userId: userOrderList[i].userId,
        shopId: userOrderList[i].shopId,
        userProducts: userOrderList[i].userProducts,
        confirm: userOrderList[i].confirm,
        createdAt: userOrderList[i].createdAt,
      };
      tempUserOrder.user = {
        name: userList[i].name,
        emailId: userList[i].emailId,
        phoneNumber: userList[i].phoneNumber,
        address: userList[i].address,
        imgUrl: userList[i].imgUrl,
      };

      filteredUserOrderList.push(tempUserOrder);
    }

    return res.send(filteredUserOrderList);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

export default handler;
