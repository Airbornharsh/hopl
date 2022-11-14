import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
  emailId: {
    type: String,
    unique: true,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  phoneNumber: {
    type: Number,
    required: true,
  },
  orders: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "UserOrder",
    default: [],
  },
  shopkeeper: {
    type: Boolean,
    default: false,
  },
  address: {
    type: String,
    required: false,
  },
  imgUrl: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Image",
  },

  createdAt: {
    type: Date,
    default: Date.now(),
  },
});

export default mongoose.models.User || mongoose.model("User", userSchema);
