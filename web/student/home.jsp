<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %>
<%
    if(session.getAttribute("username")!=null){
%>
        <!-- container -->
        <nav class="navbar-light animateIt">
                <!-- breadcrum -->
                <h1 class="display-4 text-center jump">Available groups..</h1>
                <!--\ breadcrum -->
                <!-- search box for group -->
                <div class="input-group mb-4 container">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><i class="fa fa-search"></i></span>
                  </div>
                  <input type="text" class="form-control" placeholder="Search group">
                </div>
                <!--\ search box for group -->
                <%
                    try{
                        Dbcon.getConnection();
                        String sql = "select * from group_member where stud_id= ?";
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setString(1, (String)session.getAttribute("username"));
                        ResultSet rs = Dbcon.retrive(st);
                        ResultSet rs2 = null;
                        while(rs.next()){
                            String sql2 = "select group_name,group_desc from e_group where group_id=?";
                            st = Dbcon.con.prepareStatement(sql2);
                            st.setInt(1, rs.getInt("group_id"));
                            rs2 = Dbcon.retrive(st);
                            if(rs2.next()){
                %>
                <!-- showing group -->
                <div class="container jumbotron">
                  <blockquote class="text-left"><i>Creator's id: <%=rs.getString("examiner_id")%></i></blockquote>                  
                        <div class="text-center">
                        <img src="../pics/login_avtar.png" class="rounded-circle" style="width: 150px;">
                        </div>
                  <h1 class="display-4 text-center"><%=rs2.getString("group_name")%></h1>
                  <blockquote class="blockquote text-center"><%=rs2.getString("group_desc")%></blockquote>
                <hr class="my-4">
                <a class="btn btn-outline-primary btn-lg" href='view_topics.jsp?group_id=<%=rs.getInt("group_id")%>'><i class="fa fa-chevron-right"></i> Enter to group</a>
                </div>
                <!--\showing group-->
                <%
                            }
                        }
                    }catch(Exception ex){
                        System.out.println("student/home.jsp: "+ex.getMessage());
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