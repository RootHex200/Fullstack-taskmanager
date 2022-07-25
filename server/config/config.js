


require("dotenv").config();


const dev={
    app:{
        PORT:process.env.PORT || 4000
    },
    db:{
        URL:process.env.DB_URL || "mongodb://127.0.0.1:27017/Todo"
    }
}


module.exports=dev;