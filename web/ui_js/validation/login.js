var loginArr=[false,false];
function user(){
    
    if($("#inputUsername").val()!==""){
        $("#usernameError").text("");                
        loginArr[0] = true;
    }else{
        loginArr[0] = false;        
        $("#usernameError").text("Username can't be empty.");        
    }
}
function pass(){
    if($("#inputPassword").val()!==""){
        $("#passwordError").text("");                
        loginArr[1] = true;
    }else{
        loginArr[1] = false;        
        $("#passwordError").text("Password can't be empty.");        
    }
}
function validateLogin(){
    for(i=0; i<loginArr.length; i++){
        if(loginArr[i]==false)
            return false;
    }
    return true;
}