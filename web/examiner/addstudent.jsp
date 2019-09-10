<%@page import="java.sql.ResultSet"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<%
    if(session.getAttribute("username")!=null){
%>
        <!-- container -->
        <nav class="navbar-light animateIt">
                <!-- breadcrum -->
                <h1 class="display-4 text-center jump">Add Student</h1>
                <!--\ breadcrum -->
                <!-- search box for student-->
                <div class="input-group mb-4 container">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><i class="fa fa-search"></i></span>
                  </div>
                  <input type="text" class="form-control" placeholder="Search student">
                </div>
                <!--\ search box for student-->
                <!-- add topic form -->                         
                <form class="container mt-5" method="POST">
                    <div class="form-row">
                        <div class="col-md-2"></div>                        
                        <div class="form-group col-md-4">
                          <label for="username" class="text-primary">*Username</label>
                          <input type="text" class="form-control" id="username" placeholder="Username" name="username">
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
                          <input type="text" class="form-control" id="fname" placeholder="First name" name="fname">
                        </div>
                        <div class="form-group col-md-4">
                          <label for="lname">Last name</label>
                          <input type="text" class="form-control" id="lname" placeholder="Last name" name="lname">
                        </div>
                        <div class="col-md-2"></div>                        
                    </div>
                    <div class="form-row">
                        <div class="col-md-2"></div>
                        <div class="form-group col-md-4">
                          <label for="institute">Institute name</label>
                          <input type="text" class="form-control" id="institute" placeholder="Institute name" name="institute">
                        </div>
                        <div class="col-md-2"></div>                        
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <button type="submit" name="add" class="btn btn-primary btn-lg text-center col-md-4 mb-5">Add</button>   
                        <div class="col-md-4"></div>                            
                    </div>
                </form>			
                <!--\ add group form -->                
        </nav>
        <!-- \container --> 
                <%
                    try{
                        Dbcon.getConnection();
                        String sql = "select * from student where examiner_id = ?";
                        PreparedStatement st = Dbcon.con.prepareStatement(sql);
                        st.setString(1, (String)session.getAttribute("username"));
                        ResultSet rs = Dbcon.retrive(st);
                        String imgURL="../pics/login_avtar.png";
                        while(rs.next()){
                            if(rs.getString("gender").equals("female"))
                                imgURL="../pics/female.png";
                            else
                                imgURL="../pics/login_avtar.png";
                %>
                <!-- showing group -->
                <div class="container jumbotron">
                        <div class="text-center">
                            <img src="<%=imgURL%>" class="rounded-circle" style="width: 150px;">
                        </div>
                  <h1 class="display-4 text-center"><%=rs.getString("fname")%></h1>
                  <blockquote class="blockquote text-center"><%=rs.getString("lname")%></blockquote>                  
                <hr class="my-4">
                <!-- <a class="btn btn-outline-primary btn-lg" href='view_student.jsp?stud_id=<%=rs.getString("stud_id")%>'><i class="fa fa-chevron-right"></i> Read more</a> -->
                <a class="btn btn-danger btn-lg" href='delete_student.jsp?stud_id=<%=rs.getString("stud_id")%>'><i class="fa fa-trash"></i> Delete</a>			
                <a class="btn btn-success btn-lg" href='edit_student.jsp?stud_id=<%=rs.getString("stud_id")%>'><i class="fa fa-pencil-square-o"></i> Edit</a>	
                </div>
                <!--\showing group-->
                <%
                        }
                    }catch(Exception ex){
                        System.out.println("examiner/addstudent.jsp: "+ex.getMessage());
                    }finally{
                        Dbcon.close();
                    }
                %>   
                
        <!--add group jsp-->
        
        <%
            try{
                if(request.getParameter("add")!=null){
                    String username = request.getParameter("username")+"_"+(String)session.getAttribute("username");                    
                    Dbcon.getConnection();
                    String sql = "insert into student values (?,?,?,?,?,?,?)";
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, username);                    
                    st.setString(2, (String)session.getAttribute("username"));
                    st.setString(3, request.getParameter("fname"));
                    st.setString(4, request.getParameter("lname"));     
                    st.setString(5, request.getParameter("institute"));                                       
                    st.setString(6, request.getParameter("gender"));                                     
                    st.setString(7, "0:0");                                                                    
                    Dbcon.update(st); 
                    sql = "insert into login values (?,?,?)";
                    st = Dbcon.con.prepareStatement(sql);  
                    st.setString(1, username); 
                    st.setString(2, username+"_test"+(int)(Math.random()*50+1));                    
                    st.setString(3, "student");                    
                    Dbcon.update(st);
                    %>
                    <script type="text/javascript">
                            $("#title").text("Added");
                            $("#body").text("Student added successfully");
                            $("#button").text("Okay");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="addstudent.jsp";
                            });
                    </script> 
                    <%
                }
            }catch(Exception ex){
                System.out.println("examiner/addstudent.jsp: "+ex.getMessage());
                %>
                <script type="text/javascript">
                        $("#title").text("Error");
                        $("#body").text("Internal server error");
                        $("#button").text("Try again");
                        $("#modal").modal('show');
                        $("#button").click(function(){
                                document.location.href="addstudent.jsp";
                        });
                </script> 
                <%
            }finally{
                Dbcon.close();
            }
        %>  
        <!--\add group jsp-->        
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