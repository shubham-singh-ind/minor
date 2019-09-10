function readQuestion(event)
{
    var id = event.id;
    $.ajax({
       url: 'getQuestion.jsp',
       dataType:'text',
       data:{
           quest_id: id
       },
       method:'POST',
       success:function(resp){
           resp = JSON.parse(resp);
           $.ajax({
               url: 'getAnswered.jsp',
               dataType:'text',
               data:{
                   quest_id: id
               },
               success:function(res){
                   res = JSON.parse(res);
                   console.log(res);
                   if(res.option>="a"){
                        $('input:radio[name=option]').filter('[value='+res.option+']').prop('checked',true);                         
                   }else{
                        $('input:radio[name=option]').filter('[value=a]').prop('checked',false);
                        $('input:radio[name=option]').filter('[value=b]').prop('checked',false);           
                        $('input:radio[name=option]').filter('[value=c]').prop('checked',false);           
                        $('input:radio[name=option]').filter('[value=d]').prop('checked',false);                          
                   }
               }
           });        

           $("#q_id").val(resp.q_id);
           $("#ques_desc").text("Q. "+resp.ques_desc);
           $("#a").text(resp.option_a);
           $("#b").text(resp.option_b);
           $("#c").text(resp.option_c);
           $("#d").text(resp.option_d);
       }
    });
}