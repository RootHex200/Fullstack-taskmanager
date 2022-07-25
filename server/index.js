


const app=require("./app")
const config=require("./config/config")

const PORT=config.app.PORT;


app.listen(PORT,(req,res)=>{
    console.log(`server is running http://localhost:${PORT}`)
})