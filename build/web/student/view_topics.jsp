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
                <a class="btn btn-primary btn-lg" style="position:fixed; bottom: 2px; left: 2px;z-index: 100" href="home.jsp"><i class="fa fa-chevron-left"></i> Back</a>
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
                <%
                    try{
                        String disabled="";
                        Dbcon.getConnection();
                        String sql = "select * from topic where group_id = ?";
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setString(1, (String)session.getAttribute("group_id"));
                        ResultSet rs = Dbcon.retrive(st);
                        sql = "select * from test_record where stud_id=? and group_id=? and topic_id=?";
                        st = Dbcon.con.prepareStatement(sql);
                        while(rs.next()){
                            st.setString(1, (String)session.getAttribute("username"));
                            st.setString(2, (String)session.getAttribute("group_id"));
                            st.setString(3, rs.getString("topic_id"));
                            ResultSet rs2 = Dbcon.retrive(st);
                            if(rs2.next()){
                                disabled="";
                            }else{
                                disabled="";
                            }
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
                <%if(disabled.equals("")){%>
                    <a class="btn btn-outline-primary btn-lg"  href='instruction.jsp?topic_id=<%=rs.getInt("topic_id")%>'><i class="fa fa-chevron-right"></i> Enter to topic</a>
                <%}else{%>
                    <p class="btn btn-outline-secondary btn-lg"><i class="fa fa-chevron-right"></i> You've attempted this test.</p>
                <%}%>
                </div>
                <!--\showing group-->
                <%
                        }
                    }catch(Exception ex){
                        System.out.println("student/view_topics.jsp: "+ex.getMessage());
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