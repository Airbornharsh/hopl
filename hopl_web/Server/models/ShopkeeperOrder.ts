import mongoose from "mongoose";

const shopkeeperOrderSchema = new mongoose.Schema({
  shopid: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Shop",
  },
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  refUserOrderId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "UserOrder",
  },
});

export default mongoose.models.ShopkeeperOrder ||
  mongoose.model("ShopkeeperOrder", shopkeeperOrderSchema);
