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

    if (tempUser.shopkeeper === false) {
      return res.status(401).send("Your are Not a Shopkeeper");
    }

    const shopDetail = await DbModels.shop.findOne({
      shopKeeperId: tempUser._id,
    });

    const productData = await DbModels.product.find({ shopId: shopDetail._id });

    return res.send(productData);
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

    if (tempUser.shopkeeper === false) {
      return res.status(401).send("Your are Not a Shopkeeper");
    }

    const shopDetail = await DbModels.shop.findOne({
      shopKeeperId: tempUser._id,
    });

    console.log(body);

    const newProduct = await DbModels.product({
      name: body.name,
      description: body.description,
      shopId: shopDetail._id,
      quantity: body.quantity,
      price: body.price,
      category: body.category,
      imgUrl: body.imgUrl
        ? body.imgUrl
        : "https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-…",
    });

    const productData = await newProduct.save();

    return res.send(productData);
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

    if (tempUser.shopkeeper === false) {
      return res.status(401).send("Your are Not a Shopkeeper");
    }

    const productData = await DbModels.product.findById(body.productId);

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

    if (tempUser.shopkeeper === false) {
      return res.status(401).send("Your are Not a Shopkeeper");
    }

    const updateProduct = {};

    body.name && (updateProduct.name = body.name);
    body.description && (updateProduct.description = body.description);
    body.quantity && (updateProduct.quantity = body.quantity);
    body.price && (updateProduct.price = body.price);
    body.category && (updateProduct.category = body.category);

    if (
      !updateProduct.name &&
      !updateProduct.description &&
      !updateProduct.quantity &&
      !updateProduct.price &&
      !updateProduct.category
    ) {
      return res.status(400).send("Nothing to Update");
    }

    await DbModels.product.findByIdAndUpdate(body.productId, updateProduct);

    return res.send({ status: "Updated" });
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

    if (tempUser.shopkeeper === false) {
      return res.status(401).send("Your are Not a Shopkeeper");
    }

    await DbModels.product.findByIdAndDelete(body.productId);

    return res.send({ status: "Deleted" });
  } catch (e) {
    console.log(e);
    return res.status(500).send(e);
  }
};

export default handler;
