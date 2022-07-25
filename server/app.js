


const express=require("express")
const cors=require("cors")
const morgan=require("morgan")
const app=express();
const userdatarouter=require("./router/userdata.router");
const authrouter = require("./router/auth.router");
const passport=require("passport")


//initlized database
require("./config/db")
//middelware
app.use(express.urlencoded({extended:true}))
app.use(express.json())
app.use(cors())
app.use(morgan("dev"))
app.use(passport.initialize())
//userdatarouter
app.use("/user",userdatarouter)

app.use("/user/auth",authrouter)
//route error handel


require("./config/passport")



app.use((req,res,next)=>{
    res.status(404).json({message:"No route Found"})
})

//server error handle
app.use((erro,req,res,next)=>{
    res.status(500).json({message:"500 Internal Server Error"})
})


module.exports=app;