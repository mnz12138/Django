//判断字符是否为空的方法
function isEmpty(obj){
    if(typeof obj == "undefined" || obj == null || obj == "" || obj.trim() == ""){
        return true;
    }else{
        return false;
    }
}