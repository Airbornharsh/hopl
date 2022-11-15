import mongoose from "mongoose";

const userOrderSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  shopId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "shop",
    required: true,
  },
  userProducts: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "UserProduct",
    },
  ],
  confirm: {
    type: Boolean,
    default: false,
  },
  createdAt: {
    type: Date,
    default: Date.now(),
  },
});

export default mongoose.models.UserOrder ||
  mongoose.model("UserOrder", userOrderSchema);
