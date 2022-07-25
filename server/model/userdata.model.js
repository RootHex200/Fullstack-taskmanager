

const mongoose=require("mongoose")


const userDataschema=mongoose.Schema({
    id:{
        type:String,

    },
    title:{
        type:String
    },
    details:{
        type:String
    },
    creteAt:{
        type:Date,
        default:Date.now()
    },
    category:{
        type:String,
    }
});

module.exports=mongoose.model("Datas",userDataschema);