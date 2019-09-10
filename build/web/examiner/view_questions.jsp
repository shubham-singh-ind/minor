<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<%
    if(session.getAttribute("username")!=null){
        if(request.getParameter("topic_id")!=null)    
            session.setAttribute("topic_id", request.getParameter("topic_id"));        
%>
        <!-- container -->
        <nav class="navbar-light">
                <a class="btn btn-primary btn-lg" style="position:fixed; bottom: 2px; left: 2px;z-index: 100" href="view_topics.jsp"><i class="fa fa-chevron-left"></i> Back</a>           
                <!-- breadcrum -->
                <h1 class="display-4 text-center">Questions..</h1>
                <!--\ breadcrum -->               
                <!-- add question button -->
                <div class="container">
                    <a class="btn btn-primary btn-lg text-center text-white" href="addquestion.jsp"><i class="fa fa-plus-square"></i> Add question</a>
                </div>				 
                <!--\ add question button -->
                <%
                    try{
                        Dbcon.getConnection();
                        String sql = "select * from question where topic_id = ?";
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setString(1, (String)session.getAttribute("topic_id"));
                        ResultSet rs = Dbcon.retrive(st);
                        int count=0;
                        while(rs.next()){
                            ++count;
                %>
                <!-- showing questions --> 
                <div class="container jumbotron animated bounceInUp">
                  <blockquote class="blockquote">Q. <%=count%>. <%=rs.getString("ques_desc")%></blockquote>
                <hr class="my-4">
                  <blockquote class="blockquote">A. <%=rs.getString("option_a")%></blockquote>
                  <blockquote class="blockquote">B. <%=rs.getString("option_b")%></blockquote>
                  <blockquote class="blockquote">C. <%=rs.getString("option_c")%></blockquote>
                  <blockquote class="blockquote">D. <%=rs.getString("option_d")%></blockquote>                
                  <a class="btn btn-danger btn-lg" href='delete_question.jsp?quest_id=<%=rs.getInt("quest_id")%>'><i class="fa fa-trash"></i> Delete</a>			
                <a class="btn btn-success btn-lg" href='edit_question.jsp?quest_id=<%=rs.getInt("quest_id")%>'><i class="fa fa-pencil-square-o"></i> Update</a>	
                </div>
                <!--\showing questions-->
                <%
                        }
                    }catch(Exception ex){
                        System.out.println("examiner/view_questions.jsp: "+ex.getMessage());
                    }finally{
                        Dbcon.close();
                    }
                %>
        </nav>

        <!-- \container -->
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