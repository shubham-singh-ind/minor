<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<%
    if(session.getAttribute("username")!=null){
            if(request.getParameter("group_id")!=null)
                session.setAttribute("group_id", request.getParameter("group_id"));
%>
        <!-- container -->
        <nav class="navbar-light">
                <!-- breadcrum -->
                <a class="btn btn-primary btn-lg" style="position:fixed; bottom: 2px; left: 2px;z-index: 100;" href="home.jsp"><i class="fa fa-chevron-left"></i> Back</a>
                <h1 class="display-4 text-center animated slideInDown">Topics..</h1>
                <!--\ breadcrum -->
                <!-- search box for group -->
                <div class="input-group mb-4 container">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><i class="fa fa-search"></i></span>
                  </div>
                  <input type="text" class="form-control" placeholder="Search topic">
                </div>
                <!--\ search box for group -->
                <div class="container">
                <!-- add topic button -->
                    <a class="btn btn-primary btn-lg text-center mb-4" href="addtopic.jsp"><i class="fa fa-plus-square"></i> Add topic</a>
                <!--\ add topic button -->
                </div>
                <%
                    try{
                        Dbcon.getConnection();
                        String sql = "select * from topic where group_id = ?";
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setString(1, (String)session.getAttribute("group_id"));
                        ResultSet rs = Dbcon.retrive(st);
                        boolean topicAvailable = false;
                        while(rs.next()){
                            topicAvailable = true;
                %>
                <!-- showing group -->
                <div class="container jumbotron animated slideInUp">
                        <div class="text-center">
                        <img src="../pics/login_avtar.png" class="rounded-circle" style="width: 150px;">
                        </div>
                  <h1 class="display-4 text-center"><%=rs.getString("topic_name")%></h1>
                  <blockquote class="blockquote text-center"><%=rs.getString("topic_desc")%></blockquote>
                  <blockquote class="text-center"><i>Test timing: <%=rs.getInt("time")%> minute</i></blockquote>
                <hr class="my-4">
                <a class="btn btn-outline-primary btn-lg" href='view_questions.jsp?topic_id=<%=rs.getInt("topic_id")%>'><i class="fa fa-chevron-right"></i> Enter to topic</a>
                <a class="btn btn-danger btn-lg" href='delete_topic.jsp?group_id=<%=rs.getInt("group_id")%>'><i class="fa fa-trash"></i> Delete</a>			
                <a class="btn btn-success btn-lg" href='update_topic.jsp?topic_id=<%=rs.getInt("topic_id")%>'><i class="fa fa-pencil-square-o"></i> Update</a>	
                </div>
                <!--\showing group-->
                <%
                        }
                        if(!topicAvailable){
                            %>
                            <p class="display-4 text-center">No topics created yet.</p>
                            <%
                        }
                    }catch(Exception ex){
                        System.out.println("examiner/view_topics.jsp: "+ex.getMessage());
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