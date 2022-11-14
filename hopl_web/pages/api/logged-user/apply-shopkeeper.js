import jwt from "jsonwebtoken";
import DbConnect from "../../../Server/config/Db_Config";

const handler = async (req, res) => {
  if (req.method === "POST") {
    await POSTHANDLER(req, res);
  } else {
    return res.status(400).send("Wrong Method");
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

    const newShop = new DbModels.shop({
      name: body.name,
      description: body.description,
      shopKeeperId: tempUser._id,
      address: body.address,
      longitude: body.longitude,
      latitude: body.latitude,
      category: body.category,
    });
      
      console.log(tempUser);

    const shopData = await newShop.save();

    await DbModels.user.findByIdAndUpdate(tempUser._id, {
      shopkeeper: true,
    });

    return res.send({ shopData });
  } catch (e) {
    return res.status(500).send(e);
  }
};

export default handler;
