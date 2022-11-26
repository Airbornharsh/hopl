import mongoose from "mongoose";

const userProductSchema = new mongoose.Schema({
  productId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Product",
    required: true,
  },
  orderId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "UserOrder",
    required: true,
  },
  quantity: {
    type: Number,
    default: 1,
  },
  name: {
    type: String,
  },
  price: {
    type: Number,
  },
  imgUrl: {
    type: String,
  },
  confirm: {
    type: Boolean,
    default: false,
  },
});

export default mongoose.models.UserProduct ||
  mongoose.model("UserProduct", userProductSchema);
