import dotenv from "dotenv";
import mongoose from "mongoose";
import user from "../models/User";
import shop from "../models/Shop";
import product from "../models/Product";
import shopkeeperOrder from "../models/ShopkeeperOrder";
import userOrder from "../models/UserOrder";
import userProduct from "../models/UserProduct";

dotenv.config();

const DB_URI = process.env.DB_URI as string;

const DbConnect = async () => {
  try {
    const connect = await mongoose.connect(DB_URI);
    console.log("Db Connected");

    return {
      connect,
      user,
      shop,
      product,
      shopkeeperOrder,
      userOrder,
      userProduct,
    };
  } catch (e) {
    console.log(e);
  }
};

export default DbConnect;
