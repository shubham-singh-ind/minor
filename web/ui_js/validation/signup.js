var signupArr=[false,false,false,false,false];
function user(){
    var unmRegex = /^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$/;
    if($("#inputUsername").val()!==""){
        $("#usernameError").text("");                
        signupArr[0] = true;
    }else{
        signupArr[0] = false;        
        $("#usernameError").text("Username can't be empty.");        
    }
}
function pass(){
    if($("#inputPassword").val()!==""){
        $("#passwordError").text("");                
        signupArr[1] = true;
    }else{
        signupArr[1] = false;        
        $("#passwordError").text("Password can't be empty.");        
    }
}
function firstname(){
    if($("#inputFname").val()!==""){
        $("#fnameError").text("");                
        signupArr[2] = true;
    }else{
        signupArr[2] = false;        
        $("#fnameError").text("First name can't be empty.");        
    }
}
function mobile(){
    if($("#inputContact").val()!==""){
        $("#contactError").text("");                
        signupArr[3] = true;
    }else{
        signupArr[3] = false;        
        $("#contactError").text("Contact can't be empty.");        
    }
}
function emailAdd(){
    if($("#inputEmail").val()!==""){
        $("#emailError").text("");                
        signupArr[4] = true;
    }else{
        signupArr[4] = false;        
        $("#emailError").text("Email can't be empty.");        
    }
}
function validateSignup(){
    user();
    pass();
    firstname();
    mobile();
    emailAdd();
    for(i=0; i<signupArr.length; i++){
        if(signupArr[i]==false)
            return false;
    }
    return true;
}