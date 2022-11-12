import mongoose from "mongoose";

const userOrderSchema = new mongoose.Schema({
  products: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "UserProduct",
    },
  ],
  confirm: {
    type: Boolean,
    default: false,
  },
});

export default mongoose.models.UserOrder ||
  mongoose.model("UserOrder", userOrderSchema);
