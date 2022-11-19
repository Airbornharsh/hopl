import mongoose from "mongoose";

const shopSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  description: String,
  shopKeeperId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  rating: {
    type: Number,
  },
  longitude: {
    type: String,
    required: true,
  },
  latitude: {
    type: String,
    required: true,
  },
  category: String,
  imgUrl: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Image",
  },
  products: [
    { type: mongoose.Schema.Types.ObjectId, ref: "Product", default: [] },
  ],
});

export default mongoose.models.Shop || mongoose.model("Shop", shopSchema);
