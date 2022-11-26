import jwt from "jsonwebtoken";
import DbConnect from "../../../../Server/config/Db_Config";

const handler = async (req, res) => {
  if (req.body.method === "LIST") {
    await LISTHANDLER(req, res);
  } else if (req.method === "POST") {
    await POSTHANDLER(req, res);
  } else if (req.method === "DELETE") {
    await DELETEHANDLER(req, res);
  } else if (req.method === "GET") {
    await GETHANDLER(req, res);
  } else if (req.method === "PATCH") {
    await PATCHHANDLER(req, res);
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

    const productsData = await DbModels.userProduct.find({
      orderId: body.userOrderId,
    });

    return res.send(productsData);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

const POSTHANDLER = async (req, res) => {
  try {
    const body = req.body;
    const DbModels = await DbConnect();

    // const accessToken = req.headers.authorization.split(" ")[2];

    // let tempUser;
    // let tempErr;

    // jwt.verify(accessToken, process.env.JWT_SECRET, (err, user) => {
    //   tempErr = err;
    //   tempUser = user;
    // });

    // if (tempErr) {
    //   return res.status(401).send(tempErr);
    // }

    const newProduct = new DbModels.userProduct({
      productId: body.productId,
      orderId: body.orderId,
      quantity: 1,
      name: body.name,
      price: body.price,
    });

    
    const productData = await newProduct.save();

    await DbModels.userOrder.findByIdAndUpdate(body.orderId, {
      $push: { userProducts: productData._id },
    });

    return res.send(productData);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

const PATCHHANDLER = async (req, res) => {
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

    await DbModels.userProduct.findByIdAndUpdate(body.userProductId, {
      $inc: { quantity: body.count },
    });

    return res.send("Updated");
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

    await DbModels.userProduct.findByIdAndDelete(body.userProductId);

    await DbModels.userOrder.findByIdAndUpdate(body.userOrderId, {
      $pull: { userProducts: body.userProductId },
    });

    return res.send("Deleted Item");
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
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

    const productData = await DbModels.userProduct.findById(body.userProductId);

    if (!productData) return res.status(400).send("No product Found");

    return res.send(productData);
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

export default handler;
