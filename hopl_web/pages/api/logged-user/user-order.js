import jwt from "jsonwebtoken";
import DbConnect from "../../../Server/config/Db_Config";

const handler = async (req, res) => {
  if (req.body.method === "LIST") {
    await LISTHANDLER(req, res);
  } else if (req.method === "POST") {
    await POSTHANDLER(req, res);
  } else if (req.method === "DELETE") {
    await DELETEHANDLER(req, res);
  } else if (req.method === "GET") {
    await GETHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
  }
};

const LISTHANDLER = async (req, res) => {
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

    const orderData = await DbModels.userOrder.find({
      userId: tempUser._id,
    });

    return res.send(orderData);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

const POSTHANDLER = async (req, res) => {
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

    const newOrder = new DbModels.userOrder({
      userId: tempUser._id,
      shopId: body.shopId,
      userProducts: [],
    });

    const orderData = await newOrder.save();

    await DbModels.user.findByIdAndUpdate(tempUser._id, {
      $push: { orders: orderData._id },
    });

    return res.send(orderData);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

const DELETEHANDLER = async (req, res) => {
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

    await DbModels.userOrder.findByIdAndDelete(body.userOrderId);

    await DbModels.user.findByIdAndUpdate(tempUser._id, {
      $pull: { orders: body.userOrderId },
    });

    await DbModels.userProduct.deleteMany({ orderId: body.userOrderId });

    return res.send("Deleted Item");
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
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

    const orderData = await DbModels.userOrder.findById(body.userOrderId);

    if (!orderData) return res.status(400).send("No product Found");

    return res.send(orderData);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

export default handler;
