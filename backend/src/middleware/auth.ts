import {Request,Response,NextFunction} from 'express';
import jwt from 'jsonwebtoken';
export type Role='Admin'|'Sales'|'Warehouse'|'Accounts';
export interface AuthRequest extends Request { user?: {id:number; role:Role; name:string} }
export function auth(req:AuthRequest,res:Response,next:NextFunction){
 const token=req.headers.authorization?.startsWith('Bearer ')?req.headers.authorization.slice(7):undefined;
 if(!token) return res.status(401).json({message:'Authentication required'});
 try{req.user=jwt.verify(token,process.env.JWT_SECRET!) as AuthRequest['user']; next();}catch{return res.status(401).json({message:'Invalid or expired token'});}
}
export function roles(...allowed:Role[]){return (req:AuthRequest,res:Response,next:NextFunction)=>{if(!req.user||!allowed.includes(req.user.role))return res.status(403).json({message:'You do not have permission for this action'});next();};}
