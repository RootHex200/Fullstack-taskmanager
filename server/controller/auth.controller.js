
const auth=require("../model/auth.model")

const bcrypt = require('bcrypt');
const saltRounds = 10;
const jwt = require('jsonwebtoken');
const passport=require("passport")

const login=async(req,res)=>{
    const email=req.body.email;
    const password=req.body.password;
    if(email.length==0 && password.length==0){
        res.status(400).json({message:"plz enter email and password"})
    }else if(password.length<6){
        res.status(400).json({message:"should length 6"})
    }else{
        try{
            const response=await auth.findOne({email:email});

            if(bcrypt.compare(password, response.password)){
                const payload={
                    id:response._id,
                    email:response.email,
                }
    
                const token=jwt.sign(payload,process.env.SECRET_KEY,{
                    expiresIn:"2d"
                })
    
                res.status(200).json({
                    id:response._id,
                    email:response.email,
                    token:"Bearer "+token,
                })
            }else{
                res.status(400).json({message:"password is wrong!"})
            }

            
        }catch{
            res.status(400).json({message:"user not found"})
        }
    }
    // res.json({messge:"hellow"})
}

const registers=async(req,res)=>{
    try{
        const email=req.body.email;
        const password=req.body.password;
        if(email.length==0&& password.length==0){
            res.status(400).json({message:"plz enter email and password"})
        }else if(password.length<6){
            res.status(400).json({message:"should length 6"})
        }else{
    
                bcrypt.hash(password, saltRounds,async function(err, hash) {
                    const data=await auth({
                        email,
                        password:hash,
                    });
                    await data.save().then((response)=>res.status(200).json({
                        id:response._id,
                        email:response.email
                    }))
                    .catch((e)=>res.status(500).send({message:"user allready exist"}))
                });
        }
    }catch{
        console.log("somthing wrong!!")
    }
}


const profile=
function(req, res) {
    res.send({
        id:req.user.id,
        email:req.user.email,
        
    });
}
module.exports={login,registers,profile}