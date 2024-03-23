const express = require("express");
const mongoose = require("mongoose");
// const { MongoClient } = require("mongodb");

const app = express();
app.use(express.json());

const uri = 'mongodb+srv://Vinaykatewa:vinay123@cluster0.k3f1phd.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
// const client = new MongoClient(uri);

//Connecting
mongoose.connect(uri).then(() => console.log(`Connected Mongoose`)).catch((e) => console.log(`this is the error ${e}`));


//Schema
const userSchema = new mongoose.Schema({
  userName: {type: String, required: true},
  email: {type: String, required: true, unique: [true, "Email already exists"]},
  uid: {type: String, required: true},
  profileImage: {type: String, required: true},
});

//Model
const userModel = mongoose.model("Users", userSchema);

//Chat Schema
const chatSchema = new mongoose.Schema({
  senderUid: {type: String, required: true},
  senderMessage: {type: String, required: true},
  timeStamp: {type: Date, default: Date.now},
});

//channels Schema
const channelsSchema = new mongoose.Schema({
  channelName: {type: String, required: true},
  chat: {type: [chatSchema]},
}, { timestamps: true });

//Model
const channelsModel = mongoose.model("Channels", channelsSchema);


app.use(express.urlencoded({ extended: true }));
const PORT = process.env.PORT || 2000;

app.listen(PORT, ()=>{
    console.log(`listening to port ${PORT}`);
});

app.post("/api/user", async (req, res) => {
  const user = {
    name: req.body.name,
    email: req.body.email,
    title: req.body.title,
  }

  const userObject = await userModel.create(user);
  return res.status(200).json({message: 'Done'});
});

app.post("/sendMessage", async (req, res) => {
  const { channelName, senderUid, senderMessage } = req.body;
  console.log('we have hit the sendMessage api');
  const message = {
    senderUid,
    senderMessage,
    timeStamp: new Date(),
  };

  const channel = await channelsModel.findOneAndUpdate(
    { channelName }, // find a document with this filter
    { $push: { chat: message } }, // update the document
    { new: true, upsert: true } // options: return updated one, create one if none match
  );
  res.status(200).json(channel);
});

app.get("/api/getUserDB", async (req, res) => {
  const allUserDb = await userModel.find({});
  return res.send(allUserDb);
});

app.get("/getchannels", async (req, res) => {
  const channels = await channelsModel.find({}).sort({ updatedAt: -1 });;
  console.log('we have hit the getchannels api');
  res.status(200).json(channels);
});

