import mongoose from "mongoose";

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
  },
  shopId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Shop",
  },
  quantity: { type: Number },
  price: { type: Number },
  category: { type: String },
    imgUrl: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Image",
  },
});

export default mongoose.models.Product ||
  mongoose.model("Product", productSchema);
