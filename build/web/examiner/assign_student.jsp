<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %>
<%
    if(session.getAttribute("username")!=null){
        if(request.getParameter("group_id")!=null){
            session.setAttribute("group_id", request.getParameter("group_id"));
            session.setAttribute("group_name", request.getParameter("group_name"));
        }
%>
        <!--javascript for select all-->
        <script class="text/Javascript">
            function check(){
                    if($(".checkAll").is(":checked")){
                        $.each($("input[name='checkbox']"), function(){
                             $(this).prop('checked',true);
                         });
                    }else{
                        $.each($("input[name='checkbox']"), function(){
                             $(this).prop('checked',false);
                         });
                    }
            }
        </script>
        <!--\javascript for select all-->
        <!-- container -->
        <nav class="navbar-light">
                <!-- breadcrum -->
                <a class="btn btn-primary btn-lg" style="position:fixed; bottom: 2px; left: 2px;" href="home.jsp"><i class="fa fa-chevron-left"></i> Back</a>                
                <h1 class="display-4 text-center">Assign student to group</h1>
                <h4 class="text-center uppercase"><%=session.getAttribute("group_name")%></h4>                
                <!--\ breadcrum -->
                
                <!-- showing students-->                
            <form method="POST" class='animated slideInLeft     '>    
                <div class="container">
                    <table class="table">
                    <tr>
                        <th>Student id</th>
                        <th>Student name</th>  
                        <th>
                            <label class="content">
                                <input type="checkbox" class="checkAll" onclick="check()">
                                <span class="checkmark"></span>
                            </label>
                        </th>                                                
                    </tr>
                <%!String disabled;%>
                <%
                    try{
                        Dbcon.getConnection();
                        String sql = "select stud_id,fname from student where examiner_id = ?";
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setString(1, (String)session.getAttribute("username"));
                        ResultSet rs = Dbcon.retrive(st);
                        ResultSet rs2=null;
                        boolean studentsRemains = false;
                        disabled="disabled";
                        while(rs.next()){
                            String sql2 = "select count(*) as count from group_member where group_id=? and stud_id=?";
                            PreparedStatement st2 = Dbcon.con.prepareStatement(sql2);
                            st2.setInt(1, Integer.parseInt((String)session.getAttribute("group_id")));
                            st2.setString(2, rs.getString("stud_id"));    
                            rs2 = Dbcon.retrive(st2);
                            if(rs2.next()){
                                if(rs2.getInt("count")>0)
                                    continue;
                            }
                            studentsRemains = true; 
                            disabled="";
                %>
                    <tr>
                        <td><%=rs.getString("stud_id")%></td>
                        <td><%=rs.getString("fname")%></td>          
                        <td>
                            <label class="content">
                                <input type="checkbox" class="boxes" value="<%=rs.getString("stud_id")%>" name="checkbox">
                                <span class="checkmark"></span>
                            </label>                            
                        </td>                                                                        
                    </tr>
                <%
                        }
                        if(!studentsRemains){
                            %>
                            <tr>
                                <td colspan="3"><strong>No student left, </strong><i>All present students are added to this group.</i></td>
                            </tr>
                            <%
                        }
                    }catch(Exception ex){
                        System.out.println("examiner/home.jsp: "+ex.getMessage());
                    }finally{
                        Dbcon.close();
                    }
                %>
                </table>
                <div class="container text-center">
                    <button class="btn btn-outline-success btn-lg" <%=disabled%> type="submit" name="assign">Assign</button>                                    
                </div>
                </div>
        </form>  
                <!--\showing students-->                
        </nav>
        <!-- \container -->        
        
        <!--jsp for assigning student-->
        <%
            if(request.getParameter("assign")!=null){
                try{    
                    String[] selected = request.getParameterValues("checkbox");
                    if(selected!=null){
                        Dbcon.getConnection();
                        String sql = "insert into group_member values (?,?,?);";
                        PreparedStatement st=null;
                        for(String student:selected){
                            st = Dbcon.con.prepareStatement(sql);
                            st.setInt(1, Integer.parseInt((String)session.getAttribute("group_id")));
                            st.setString(2, (String)session.getAttribute("username"));
                            st.setString(3, student);
                            Dbcon.update(st);
                        }
                        %>
                        <script type="text/javascript">
                                $("#title").text("Successful");
                                $("#body").text("Students have been assigned to this group successfully");
                                $("#button").text("Okay");
                                $("#modal").modal('show');
                                $("#button").click(function(){
                                        document.location.href="assign_student.jsp";
                                });
                        </script>        
                        <%                        
                    }else{
                        %>
                        <script type="text/javascript">
                                $("#title").text("Not selected");
                                $("#body").text("No students are selected, please select at least one student");
                                $("#button").text("Okay");
                                $("#modal").modal('show');
                                $("#button").click(function(){
                                        document.location.href="assign_student.jsp";
                                });
                        </script>        
                        <%
                    }
                }catch(Exception ex){
                    System.out.println("examiner/assign_student: "+ex.getMessage());
                    %>
                    <script type="text/javascript">
                            $("#title").text("Server error");
                            $("#body").text("Internal server error, please try again.");
                            $("#button").text("Okay");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="assign_student.jsp";
                            });
                    </script>        
                    <%
                }finally{
                    Dbcon.close();
                }
            }
        %>
        <!--\jsp for assigning student-->        
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