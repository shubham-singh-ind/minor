<%@page import="java.sql.ResultSet"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %>
<%
    if(session.getAttribute("username")!=null){
        session.setAttribute("group_id", request.getParameter("group_id"));
    try{
        String sql = "select group_name, group_desc from e_group where group_id=?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setInt(1, Integer.parseInt((String)session.getAttribute("group_id")));
        ResultSet rs = Dbcon.retrive(st);
        if(rs.next()){
%>
        <!-- container -->
        <nav class="navbar-light">
                <!-- breadcrum -->
                <h1 class="display-4 text-center animated bounceInDown">Update group</h1>
                <!--\ breadcrum -->
                <!-- back button -->
                <div class="container">
                    <a class="btn btn-primary btn-lg text-center" style="position:fixed; bottom: 2px; left: 2px;z-index: 100;"  href="home.jsp"><i class="fa fa-chevron-left"></i> Back</a>
                </div>				
                <!--\ back button -->
                <!-- add group form -->                         
                <form class="container mt-5 animated bounceInUp" method="POST">
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <div class="form-group col-md-4">
                          <label for="name" class="text-primary">*Group name</label>
                          <input type="text" class="form-control" name="name" value="<%=rs.getString("group_name")%>" id="name" placeholder="Group name">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="desc" class="text-primary">*Group description</label>
                            <input type="text" class="form-control" name="desc" id="password" value="<%=rs.getString("group_desc")%>" placeholder="Group description">
                        </div>
                        <div class="col-md-4"></div>
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
            System.out.println("examiner/update_group: "+ex.getMessage());
        }
        %>
        <!--add group jsp-->
        <%
            try{
                if(request.getParameter("update")!=null){
                    Dbcon.getConnection();
                    String sql = "update e_group set group_name=?, group_profile_url=?, group_desc=? where group_id=?";
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, request.getParameter("name"));
                    st.setString(2, request.getParameter("profile"));
                    st.setString(3, request.getParameter("desc"));                    
                    st.setString(4, (String)session.getAttribute("group_id"));                    
                    Dbcon.update(st); 
                    %>
                    <script type="text/javascript">
                            $("#title").text("Updated");
                            $("#body").text("Group updated successfully");
                            $("#button").text("Okay");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="../index.jsp";
                            });
                    </script>   
                    <%
                }
            }catch(Exception ex){
                System.out.println("examiner/update_group.jsp: "+ex.getMessage());
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