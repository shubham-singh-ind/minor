<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<script src="../ui_js/readQuestion.js"></script>
<script src="../ui_js/setTiming.js"></script>
<script src="../ui_js/getTiming.js"></script>
<script src="../ui_js/judge.js"></script>

<style>
    .ques-btn{
        outline: none;
        border: none;
        padding: 15px;
        border-radius: 50px; 
    }
    .answered{
        background: green;
        color:white;
    }
    .green-text{
        color:green;
    }
    .red-text{
        color: red;
    }
    @keyframes enterance{
    from{
        opacity:0;
    }
    to{
        opacity:1;
    }
}

div{
    animation-name: enterance!important;
    animation-duration: 1s;
}
</style>
<%
    if(session.getAttribute("username")!=null){
            if(request.getParameter("group_id")!=null)
                session.setAttribute("group_id", request.getParameter("group_id"));
%>
<!--answer script-->
<script>
    function answer(studId){
        var checked = $("input[name=option]:checked").val();
        var questId = $("#q_id").val();
        $.ajax({
            url: 'answer.jsp',
            dataType:'text',
            data:{
                option:checked,
                username: studId,
                quest_id: questId
            },
            success:function(resp){
                $("#"+questId).addClass("answered");
            }
        });
    }
</script>
<!--answer script-->
        <!-- container -->
        <nav class="navbar-light bg-light">
            <h1 class="display-4 text-center">Countdown: <span id="minute">30</span>:<span id="second">0</span></h1>
            <hr class="my-2">
        </nav>
        <div class="row">
            <div class="col-md-4">
                <!--terminate test button-->    
                <button class="btn btn-danger btn-block ml-2" onclick="judge()">Terminate test</button>  <br>              
                <%
                    final int TERMINATE=100;
                    String firstId="";
                    String firstDesc = "";
                    String firstOptA = "";
                    String firstOptB = "";
                    String firstOptC = "";
                    String firstOptD = ""; 
                    try{
                        String sql = "select * from question where topic_id=?";
                        Dbcon.getConnection();  
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setInt(1, Integer.parseInt((String)session.getAttribute("topic_id")));
                        ResultSet rs = Dbcon.retrive(st);
                        int count=1;
                        ResultSet rs1=null;
                        sql = "select option from answer where quest_id=? and stud_id=?";
                        st = Dbcon.con.prepareStatement(sql);                        
                        while(rs.next()){
                            if(count>TERMINATE)
                                break;
                            if(count==1){
                                firstId = Integer.toString(rs.getInt("quest_id"));
                                firstDesc = rs.getString("ques_desc");
                                firstOptA = rs.getString("option_a");
                                firstOptB = rs.getString("option_b");
                                firstOptC = rs.getString("option_c");
                                firstOptD = rs.getString("option_d");
                            }
                            st.setInt(1, rs.getInt("quest_id"));
                            st.setString(2, (String)session.getAttribute("username"));
                            rs1 = Dbcon.retrive(st);
                            String temp="";
                            if(rs1.next()){
                                if(!(rs1.getString("option").equals(""))&&rs1.getString("option").charAt(0)>='a'){
                                    temp = "answered";
                                }
                            }
                %>
                <button class="ques-btn <%=temp%>" id="<%=rs.getInt("quest_id")%>" onclick="readQuestion(this)"><%=count%></button>
                <%
                            ++count;
                        }
                    }catch(Exception ex){
                        System.out.println("student/test:"+ex.getMessage());
                    }finally{
                        Dbcon.close();
                    }
                %>
                
                
            </div>
            <div class="col-md-8">
                <!-- showing question --> 
                <div class="jumbotron">
                    <blockquote class="blockquote text-primary" id="ques_desc">Q. <%=firstDesc%></blockquote>
                    <input type="hidden" value="<%=firstId%>" id="q_id">
                <hr class="my-4">
                <blockquote class="blockquote" id="option_a">
                    <label class="radioContent">
                        <span id="a"><%=firstOptA%></span>
                        <input type="radio" name="option" onclick="answer('<%=session.getAttribute("username")%>')" value="a">
                        <span class="radioCheckmark"></span>
                    </label>
                </blockquote>
                  <blockquote class="blockquote" id="option_b">
                      <label class="radioContent">
                        <span id="b"><%=firstOptB%></span>                          
                        <input type="radio" name="option" onclick="answer('<%=session.getAttribute("username")%>')" class="option" value="b">
                        <span class="radioCheckmark"></span>
                    </label>
                  </blockquote>
                  <blockquote class="blockquote" id="option_c">
                    <label class="radioContent">
                        <span id="c"><%=firstOptC%></span>                                                  
                        <input type="radio" name="option" onclick="answer('<%=session.getAttribute("username")%>')" class="option" value="c">
                        <span class="radioCheckmark"></span>
                    </label>
                  </blockquote>
                  <blockquote class="blockquote" id="option_d">
                      <label class="radioContent">
                        <span id="d"><%=firstOptD%></span>                                                    
                        <input type="radio" name="option" onclick="answer('<%=session.getAttribute("username")%>')" class="option" value="d">
                        <span class="radioCheckmark"></span>
                    </label>
                  </blockquote>
                </div>
                <!--\showing question-->
            </div>             
        </div>
        <!-- \container -->
<!-- Modal -->
<div class="modal" id="scoreModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="exampleModalLabel">Result: </h2>
                <h2 class="modal-title" id="score"></h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div> 
            <div class="modal-body" id="result">
                <!--results appends here-->
            </div>
            <div class="modal-footer">
                <form action="../logout.jsp">
                    <button type="submit" class="btn btn-primary" >Thank you</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!--\modal-->

<!--<script>
    $("#scoreModal").on("hidden.bs.modal", function () {
        $.ajax({
            url: "../logout.jsp",
            success:function(){
                document.location.href="../index.jsp"
            }
        });
    });
</script>-->

<%
    }else{
        %>
        <script type="text/javascript">
                $("#title").text("Expired");
                $("#body").text("Session expired, please continue to login");
                $("#button").text("Continue");
                $("#modal").modal('show');
                $("#button").click(function(){
                        document.location.href="../index.jsp";
                });
        </script>       
        <%
    }
%>