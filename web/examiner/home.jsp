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
                <div class="container">
                <!-- add group button -->                    
                    <a class="btn btn-primary btn-block text-center text-white mb-4" href="addgroup.jsp"><i class="fa fa-plus-square"></i> Add Group</a>
                <!--\ add group button -->               
                </div>		
                <!-- showing group -->                
                <%
                    try{
                        Dbcon.getConnection();
                        String sql = "select * from e_group where examiner_id = ?";
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setString(1, (String)session.getAttribute("username"));
                        ResultSet rs = Dbcon.retrive(st);
                        boolean groupAvailable = false;
                        while(rs.next()){
                            groupAvailable = true;
                %>
                <div class="container jumbotron">
                        <div class="text-center">
                        <img src="../pics/group.jpg" class="rounded-circle" style="width: 150px;">
                        </div>
                  <h1 class="display-4 text-center"><%=rs.getString("group_name")%></h1>
                  <blockquote class="blockquote text-center"><%=rs.getString("group_desc")%></blockquote>
                <hr class="my-4">
                <!--enter to group button-->
                <a class="btn btn-outline-primary btn-lg jump" href='view_topics.jsp?group_id=<%=rs.getInt("group_id")%>'><i class="fa fa-chevron-right"></i> Enter to group</a>
                <!--delete group button-->
                <a class="btn btn-danger btn-lg jump" href='delete_group.jsp?group_id=<%=rs.getInt("group_id")%>'><i class="fa fa-trash"></i> Delete</a>			
                <!--update group button-->
                <a class="btn btn-success btn-lg jump" href='update_group.jsp?group_id=<%=rs.getInt("group_id")%>'><i class="fa fa-pencil-square-o"></i> Update</a>	
                <!--Assign student-->
                <a class="btn btn-primary btn-lg text-center jump" href="assign_student.jsp?group_id=<%=rs.getInt("group_id")%>&group_name=<%=rs.getString("group_name")%>"><i class="fa fa-plus-square"></i> Assign student</a>
                <!--view students-->
                <a class="btn btn-primary btn-lg text-center jump" href="view_students.jsp?group_id=<%=rs.getInt("group_id")%>&group_name=<%=rs.getString("group_name")%>"><i class="fa fa-eye"></i> View students</a>                
                </div>

                <%
                        }
                        if(!groupAvailable){
                            %>
                            <p class="display-4 text-center">No groups created yet.</p>
                            <%
                        }
                %>
                <%
                    }catch(Exception ex){
                        System.out.println("examiner/home.jsp: "+ex.getMessage());
                    }finally{
                        Dbcon.close();
                    }
                %>
                <!--\showing group-->
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