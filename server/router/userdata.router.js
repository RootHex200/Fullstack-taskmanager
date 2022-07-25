

const router=require("express").Router();
const {createTodo,getTodo,updateTodo,deleteTodo,getGroup,addCategory,getCategory}=require("../controller/userdata.controller")

router.post("/create",createTodo)

router.get("/gettodo/:id",getTodo);

router.patch("/update/:id",updateTodo);

router.delete("/delete/:id",deleteTodo);
router.get("/group/:id",getGroup);

router.post("/addcategory/:id",addCategory)
router.get("/getcategory/:id",getCategory)

module.exports=router;