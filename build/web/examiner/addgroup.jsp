<%@page import="SqlUtil.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %>
<%
    if(session.getAttribute("username")!=null){
%>
        <!-- container -->
        <nav class="navbar-light">
                <!-- breadcrum -->
                <h1 class="display-4 text-center animated slideInDown">Add group</h1>
                <!--\ breadcrum -->
                <!-- back button -->
                <a class="btn btn-primary btn-lg" style="position:fixed; bottom: 2px; left: 2px;" href="home.jsp"><i class="fa fa-chevron-left"></i> Back</a>		
                <!--\ back button -->
                <!-- add group form -->                         
                <form class="container mt-5 animated slideInUp" method="POST">
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <div class="form-group col-md-4">
                          <label for="name" class="text-primary">*Group name</label>
                          <input type="text" class="form-control" name="name" id="name" placeholder="Group name">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="desc" class="text-primary">*Group description</label>
                            <input type="text" class="form-control" name="desc" id="password" placeholder="Group description">
                        </div>
                        <div class="col-md-4"></div>
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
        <!--add group jsp-->
        <%
            try{
                if(request.getParameter("add")!=null){
                    Dbcon.getConnection();
                    String sql = "insert into e_group (examiner_id, group_name, group_profile_url, group_desc) values (?,?,?,?)";
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, (String)session.getAttribute("username"));
                    st.setString(2, request.getParameter("name"));
                    st.setString(3, request.getParameter("profile"));
                    st.setString(4, request.getParameter("desc"));                    
                    Dbcon.update(st); 
                    %>
                    <script type="text/javascript">
                            $("#title").text("Added");
                            $("#body").text("Group added successfully");
                            $("#button").text("Okay");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="../index.jsp";
                            });
                    </script>   
                    <%
                }
            }catch(Exception ex){
                System.out.println("examiner/addgroup.jsp: "+ex.getMessage());
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