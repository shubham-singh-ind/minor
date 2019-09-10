$(document).ready(getTiming);
 
var minute=0;
var second=0;
function getTiming(){
    $.ajax({
        url: "getTiming.jsp",
        success:function(resp){
            time = JSON.parse(resp);
            time = time.time;
            i=0;
            var min='',sec='';
            while(time.charAt(i)!==':'){
                min += time.charAt(i);
                i++;
            }
            i++;
            while(i<=time.length){
                sec += time.charAt(i);
                i++;
            }
            localStorage.setItem("minute",min);
            localStorage.setItem("second",sec);
            $("#minute").text(min);
            $("#second").text(sec);
        } 
    });
}
 

localIn = setInterval(setTimingAtLocal,1000); 
serverIn = setInterval(setTimingAtServer,1000); 
 



