import mongoose from "mongoose";

const userProductSchema = new mongoose.Schema({
  productId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Product",
  },
  quantity: {
    type: Number,
  },
  price: {
    type: Number,
  },
  confirm: {
    type: Boolean,
    default: false,
  },
});

export default mongoose.models.UserProduct ||
  mongoose.model("UserProduct", userProductSchema);
