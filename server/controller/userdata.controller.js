
const userschema=require("../model/userdata.model")

const authschema=require("../model/auth.model")

const createTodo=async(req,res)=>{
    const id=req.body.id
    const title=req.body.title;
    const details=req.body.details;
    const category=req.body.category;
    
    if(id!=null && title!=null && details!=null){
        try{
            const data=userschema({
                id,
                title,
                details,
                category
            });
            await data.save();
            res.status(201).json({message:"data is store in database"})
        }catch{
            res.status(404).json({message:"something wrong!!"})
        }
    }else{
        res.status(404).json({message:"data is emty plz write something"})
    }

    
}

const getTodo=async(req,res)=>{
    const id=req.params.id;
    try{
        const data=await userschema.find({id:id});
        res.status(200).json(data);
    }catch{
        res.status(404).json({message:"something wrong!"})
    }
    
}

const updateTodo=async(req,res)=>{
    const id=req.params.id;
    const title=req.body.title;
    const details=req.body.details;
    const category=req.body.category;
    
    if(id!=null && title!=null && details!=null && category!=null){
        try{
            await userschema.updateOne({_id:id},{title:title,details:details,category:category})
            res.status(200).json({message:"data is updated"})
        }catch{
            res.status(404).json({message:"something wrong!!"})
        }
    }else{
        res.status(404).json({message:"data is emty plz write something"})
    }
}

const deleteTodo=async(req,res)=>{
    try{
        await userschema.findByIdAndDelete({_id:req.params.id});
        res.status(200).json({message:"delete data successfully"})
    }catch{
        res.status(404).json({message:"something wrong!"})
    }
}

const getGroup=async(req,res)=>{
    const name=req.body.category;
    const id=req.params.id;
    console.log(name)
    try{
        const response=await userschema.find({id:id,category:name})

        res.status(200).json(response)
    }catch{
        res.status(404).json({message:"not data found"})
    }
}


const addCategory=async(req,res)=>{
    try{
        const userid=req.params.id;
        const response=await authschema.findById({_id:userid});
        const updatedata=response.category;
        updatedata.push(req.body.categoryname);
        console.log(updatedata)
        await authschema.updateOne({_id:userid},{category:updatedata});
        res.status(200).json({message:"data is updated"});
    }catch{
        res.status(400).json({mesae:"something wrong"})
    }
}

const getCategory=async(req,res)=>{
    try{
        const userid=req.params.id;
        const response=await authschema.findById({_id:userid});
        res.status(200).json({category:response.category})

    }catch{
        res.status(400).json({message:"data not found"})
    }
}
module.exports={createTodo,getTodo,updateTodo,deleteTodo,getGroup,addCategory,getCategory}