function judge(){
//    $("#loader").css({
//        display: 'inline'
//    });
//    get all questions
    $.ajax({
       url: 'getTopicQuestions.jsp',
       success:getQuestions
    });
//    \ get all questions

//get all answered questions
    $.ajax({
       url: 'getAnsweredQuestions.jsp',
       dataType: 'text',
       success:getAnsweredQuestions
    });
// \ get all answered questions



}

var allQuestions;
var correctAnswers;
var answeredQuestions;

function getQuestions(resp){
    console.log(JSON.parse(resp));
    allQuestions = JSON.parse(resp);
}

function getAnsweredQuestions(resp){
    answeredQuestions = JSON.parse(resp);
    setTimeout(calculate,1000);
}

function calculate(){
    $("#result").text("");
       var count = answeredQuestions.questions.length;
       var totalQuestion = allQuestions.questions.length;
       var result = "0/"+totalQuestion;
       counter = 0;
       j=0;
       QNo=1;
       for(i=0; i<count; i++){
           var correct = allQuestions.questions[i].correct_option;
           var thisCorrect = answeredQuestions.questions[i].option;
           if(correct===thisCorrect){
               counter++;
           }
               a='',b='',c='',d='';
               one='',two='',three='',four='';
               switch(thisCorrect){
                   case 'a': one='red-text';break;
                   case 'b': two='red-text';break;
                   case 'c': three='red-text';break;
                   case 'd': four='red-text';break;                    
               }

               switch(correct){
                   case 'a':
                       a='green-text';                  
                       break;
                   case 'b':
                       b='green-text';
                       break;
                   case 'c':
                       c='green-text';          
                       break;
                   case 'd':
                       d='green-text';                                       
                       break;                    
               }

               $("#result").append("<p><strong>"+"Q. "+QNo+". "+allQuestions.questions[i].ques_desc+"</p></strong>");
               $("#result").append("<p class="+a+" "+one+">"+"A. "+allQuestions.questions[i].option_a+"</p>");
               $("#result").append("<p class="+b+" "+two+">"+"B. "+allQuestions.questions[i].option_b+"</p>");
               $("#result").append("<p class="+c+" "+three+">"+"C. "+allQuestions.questions[i].option_c+"</p>");
               $("#result").append("<p class="+d+" "+four+">"+"D. "+allQuestions.questions[i].option_d+"</p>");  
               QNo++;
       }
   //    $("#loader").css({
   //        display: 'none'
   //    });
   // 
    result = counter+"/"+count;
       $("#score").text(" "+counter+"/"+count);
       $("#scoreModal").modal('show');
    $.ajax({
       url: 'appendTestRecord.jsp',
       dataType: 'text',
       data:{
           marks: result
       },
       success:function(){
           //
       }
    });
}