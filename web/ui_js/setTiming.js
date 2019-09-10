function setTimingAtServer(){
    var min = localStorage.getItem("minute");
    var sec = localStorage.getItem("second");
    $.ajax({
        url:'setTiming.jsp',
        dataType:'text',
        data:{
            min: min,
            sec: sec
        },
        success:function(){
//            console.log('done');
        }
    });
}

function setTimingAtLocal(){
    var min = localStorage.getItem("minute");
    var sec = localStorage.getItem("second");
    if(min==0 && sec==0){
        clearInterval(localIn);
        clearInterval(serverIn);        
        judge();
    } 
    
    if(sec==0){ 
        sec = 59;
        min--;
    }else{
        sec--;        
    }
    
    localStorage.setItem("minute",min);
    localStorage.setItem("second",sec);

    $("#minute").text(min);
    $("#second").text(sec);
}