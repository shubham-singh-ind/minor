<%@page import="java.sql.ResultSet"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<%
    if(session.getAttribute("username")!=null){
        if(request.getParameter("topic_id")!=null)
            session.setAttribute("topic_id", request.getParameter("topic_id"));
        try{
            String sql = "select topic_name, topic_desc, time from topic where topic_id=?";
            Dbcon.getConnection();
            PreparedStatement st = Dbcon.con.prepareStatement(sql);
            st.setInt(1, Integer.parseInt((String)session.getAttribute("topic_id")));
            ResultSet rs = Dbcon.retrive(st);
            if(rs.next()){
            System.out.println("hi");

%>
        <!-- container -->
        <nav class="navbar-light">
                <!-- breadcrum -->
                <h1 class="display-4 text-center">Update topic</h1>
                <!--\ breadcrum -->
                <!-- back button -->
                <div class="container">
                    <a class="btn btn-primary btn-lg text-center" style="position:fixed; bottom: 2px; left: 2px;z-index: 100;"  href="view_topics.jsp"><i class="fa fa-chevron-left"></i> Back</a>
                </div>				
                <!--\ back button -->
                <!-- update topic form -->                         
                <form class="container mt-5 animated bounceInUp" method="POST">
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <div class="form-group col-md-4">
                          <label for="name" class="text-primary">*Topic name</label>
                          <input type="text" class="form-control" name="name" id="name" value="<%=rs.getString("topic_name")%>" placeholder="Topic name">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="desc" class="text-primary">*Topic description</label>
                            <input type="text" class="form-control" name="desc" id="password" value="<%=rs.getString("topic_desc")%>" placeholder="Topic description">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-4"></div>
                        <div class="form-group col-md-4">
                            <label for="time" class="text-primary">*Timing</label>
                            <select id="time" class="form-control" name="time">
                                <option value="10">10 min</option>
                                <option value="20">20 min</option>
                                <option value="30">30 min</option>
                                <option value="40">40 min</option>
                                <option value="50">50 min</option>  
                                <option value="60">60 min</option>                                                                
                            </select>
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
            System.out.println("examiner/update_topic: "+ex.getMessage());
        %>
        <script type="text/javascript">
                $("#title").text("Server error");
                $("#body").text("Internal server error, please try after some time.");
                $("#button").text("Okay");
                $("#modal").modal('show');
                $("#button").click(function(){
                        document.location.href="../index.jsp";
                });
        </script>       
        <%
        }finally{
            Dbcon.close();
        }
        %>
        <!--update group jsp-->
        <%
            try{
                if(request.getParameter("update")!=null){
                    Dbcon.getConnection();
                    String sql = "update topic set topic_name=?, topic_desc=?, time=? where topic_id=?";
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, request.getParameter("name"));
                    st.setString(2, request.getParameter("desc"));     
                    st.setString(3, request.getParameter("time"));
                    st.setString(4, (String)session.getAttribute("topic_id"));                                                            
                    Dbcon.update(st);
                    %>
                    <script type="text/javascript">
                            $("#title").text("Added");
                            $("#body").text("Topic updated successfully");
                            $("#button").text("View topics");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="view_topics.jsp";
                            });
                    </script> 
                    <%
                }
            }catch(Exception ex){
                System.out.println("examiner/update_topic.jsp: "+ex.getMessage());
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