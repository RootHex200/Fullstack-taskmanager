

const mongoose=require("mongoose")
const config=require("./config")

const dburl=config.db.URL;

mongoose.connect(dburl).then((value)=>console.log("database connected ")).catch((e)=>console.log("database not connected"))
