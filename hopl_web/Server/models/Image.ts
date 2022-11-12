import mongoose from "mongoose";

const imageSchema = new mongoose.Schema({});

export default mongoose.models.Image || mongoose.model("Image", imageSchema);
