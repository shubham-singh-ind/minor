<%@page import="java.sql.ResultSet"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<%
    if(session.getAttribute("username")!=null){
        session.setAttribute("stud_id", request.getParameter("stud_id")); 
        try{
            Dbcon.getConnection();
            String sql = "select * from student where stud_id=? and examiner_id=?";
            PreparedStatement st = Dbcon.con.prepareStatement(sql);
            st.setString(1, (String)session.getAttribute("stud_id"));
            st.setString(2, (String)session.getAttribute("username"));  
            ResultSet rs = Dbcon.retrive(st);
            if(rs.next()){
%>
        <!-- container -->
        <nav class="navbar-light">
                <!-- breadcrum -->
                <h1 class="display-4 text-center">Edit Student</h1>
                <!--\ breadcrum -->
                <!--back button-->
                <a class="btn btn-primary btn-lg" style="position:fixed; bottom: 2px; left: 2px;z-index: 100;" href="addstudent.jsp"><i class="fa fa-chevron-left"></i> Back</a>		
                <!--\ back button-->
                <!-- add topic form -->                         
                <form class="container mt-5 animated bounceInUp" method="POST"> 
                    <div class="form-row">
                        <div class="col-md-2"></div>                        
                        <div class="form-group col-md-4">
                          <label for="username" class="text-primary">*Username</label>
                          <input type="text" class="form-control" disabled id="username" placeholder="Username" value="<%=rs.getString("stud_id")%>" name="username">
                        </div>
                        <div class="form-group col-md-4">
                          <label for="gender" class="text-primary">*Gender</label>
                          <select id="gender" name="gender" class="form-control">
                              <option value="male">Male</option>
                              <option value="female">Female</option>                              
                          </select>
                        </div>
                        <div class="col-md-2"></div>                        
                    </div>
                    <div class="form-row">
                        <div class="col-md-2"></div>                        
                        <div class="form-group col-md-4">
                          <label for="fname" class="text-primary">*First name</label>
                          <input type="text" class="form-control" id="fname" placeholder="First name" value="<%=rs.getString("fname")%>" name="fname">
                        </div>
                        <div class="form-group col-md-4">
                          <label for="lname">Last name</label>
                          <input type="text" class="form-control" id="lname" placeholder="Last name" name="lname" value="<%=rs.getString("lname")%>">
                        </div>
                        <div class="col-md-2"></div>                        
                    </div>
                    <div class="form-row">
                        <div class="col-md-2"></div>
                        <div class="form-group col-md-4">
                          <label for="institute">Institute name</label>
                          <input type="text" class="form-control" id="institute" placeholder="Institute name" value="<%=rs.getString("institute_name")%>" name="institute">
                        </div>
                        <div class="col-md-2"></div>                        
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <button type="submit" name="update" class="btn btn-primary btn-lg text-center col-md-4 mb-5">Update</button>   
                        <div class="col-md-4"></div>                            
                    </div>
                </form>			
                <!--\ add group form -->                
        </nav>
        <!-- \container --> 
        <%
            }
        }catch(Exception ex){
            System.out.println("examiner/edit_student.jsp: "+ex.getMessage());
        }finally{
            Dbcon.close();
        }   
        %>
        <!--update group jsp-->
        
        <%
            try{
                if(request.getParameter("update")!=null){
                    Dbcon.getConnection();
                    String sql = "update student set fname=?, lname=?, institute_name=?, gender=? where stud_id=? and examiner_id=?";
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, request.getParameter("fname"));                    
                    st.setString(2, request.getParameter("lname"));
                    st.setString(3, request.getParameter("institute"));
                    st.setString(4, request.getParameter("gender"));                                    
                    st.setString(5, (String)session.getAttribute("stud_id"));                                        
                    st.setString(6, (String)session.getAttribute("username"));                                             
                    Dbcon.update(st);
                    %>
                    <script type="text/javascript">
                            $("#title").text("Updated");
                            $("#body").text("Student updated successfully");
                            $("#button").text("Okay");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="addstudent.jsp";
                            });
                    </script> 
                    <%
                }
            }catch(Exception ex){
                System.out.println("examiner/addtopic.jsp: "+ex.getMessage());
            }finally{
                Dbcon.close();
            }
        %>  
        <!--\update group jsp-->        
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