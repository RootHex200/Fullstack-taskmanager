


const mongoose=require("mongoose")

const authschema=mongoose.Schema({

    email:{
        type:String,
        required:true,
        unique:true,
    },
    password:{
        type:String,
        required:true
    },
    category:{
        type:Array, 
        default:"All"      
    }
});

module.exports=mongoose.model("auth",authschema);