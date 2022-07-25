const { login, registers, profile } = require("../controller/auth.controller");


const passport=require("passport")
const authrouter=require("express").Router();

authrouter.post("/signin",login);
authrouter.post("/signup",registers)
authrouter.get('/profile',passport.authenticate('jwt', { session: false }),profile
);
module.exports=authrouter;