import{d as I,q as V,s as m,o as y,t as F,v as i,x as s,w as t,y as k,A as z,B as C,E as c,C as R,D as b,F as B,G as S,H as A,I as P}from"./index-bb0f1fa8.js";import{E as M,a as N,_ as U}from"./logo-2-d1987cba.js";const Z=d=>(S("data-v-7d31a842"),d=d(),A(),d),T={class:"login"},$={class:"login-box"},q=Z(()=>i("div",{class:"head"},[i("img",{src:U,alt:""})],-1)),D={class:"form"},G={class:"content"},H=I({__name:"Register",setup(d){const _=z(),u=V(),f=(a,o,e)=>{if(!o)return e(new Error("请输入邮箱"));var n=/^[0-9a-zA-Z_.-]+[@][0-9a-zA-Z_.-]+([.][a-zA-Z]+){1,2}$/;setTimeout(()=>{n.test(o)?e():e(new Error("请输入邮箱"))},1e3)},g=(a,o,e)=>{if(o==="")e(new Error("Please input the password"));else{if(r.repassword!==""){if(!u.value)return;u.value.validateField("repassword",()=>null)}e()}},v=(a,o,e)=>{o===""?e(new Error("请再次输入密码")):o!==r.password?e(new Error("两次输入的密码不一致!")):e()},r=m({username:"",password:"",repassword:""}),w=m({username:[{validator:f,trigger:"blur"}],password:[{validator:g,trigger:"blur"}],repassword:[{validator:v,trigger:"blur"}]}),E=a=>{a&&a.validate(o=>{if(o)console.log("submit!",r),C.post("/api/register",r).then(function(e){e.data.retCode=="000"?(c({message:e.data.retMsg,type:"success"}),console.log(e.data),console.log("register",e.data.token,e.data.user_id),sessionStorage.setItem("token",e.data.token),sessionStorage.setItem("userId",e.data.user_id),_.push({path:"/"})):c.error(e.data.retMsg)}).catch(function(e){c.error(e)});else return console.log("error submit!"),!1})};return(a,o)=>{const e=R("Icon"),n=b,p=M,h=B,x=N;return y(),F("div",T,[i("div",$,[q,i("div",D,[i("div",G,[s(x,{ref_key:"ruleFormRef",ref:u,model:r,"status-icon":"",rules:w,class:"demo-ruleForm"},{default:t(()=>[s(p,{prop:"username"},{default:t(()=>[s(n,{modelValue:r.username,"onUpdate:modelValue":o[0]||(o[0]=l=>r.username=l),placeholder:"请输入用户名"},{prefix:t(()=>[s(e,{name:"fa fa-user",class:"form-item-icon",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue"])]),_:1}),s(p,{prop:"pass"},{default:t(()=>[s(n,{modelValue:r.password,"onUpdate:modelValue":o[1]||(o[1]=l=>r.password=l),type:"password",autocomplete:"off",placeholder:"请输入密码"},{prefix:t(()=>[s(e,{name:"fa fa-unlock-alt",class:"form-item-icon",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue"])]),_:1}),s(p,{prop:"checkPass"},{default:t(()=>[s(n,{modelValue:r.repassword,"onUpdate:modelValue":o[2]||(o[2]=l=>r.repassword=l),type:"password",autocomplete:"off",placeholder:"确认密码"},{prefix:t(()=>[s(e,{name:"fa fa-unlock-alt",class:"form-item-icon",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue"])]),_:1}),s(p,null,{default:t(()=>[s(h,{class:"submit-button",type:"primary",onClick:o[3]||(o[3]=l=>E(u.value))},{default:t(()=>[k("注册")]),_:1})]),_:1})]),_:1},8,["model","rules"])])])])])}}});const K=P(H,[["__scopeId","data-v-7d31a842"]]);export{K as default};
