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
                <h1 class="display-4 text-center">Add topic</h1>
                <!--\ breadcrum -->
                <!-- back button -->
                <div class="container">
                    <a class="btn btn-primary btn-lg text-center" style="position:fixed; bottom: 2px; left: 2px;z-index: 100;"  href="view_topics.jsp"><i class="fa fa-chevron-left"></i> Back</a>
                </div>				
                <!--\ back button -->
                <!-- add topic form -->                         
                <form class="container mt-5" method="POST">
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <div class="form-group col-md-4">
                          <label for="name" class="text-primary">*Topic name</label>
                          <input type="text" class="form-control" name="name" id="name" placeholder="Topic name">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="desc" class="text-primary">*Topic description</label>
                            <input type="text" class="form-control" name="desc" id="password" placeholder="Topic description">
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
                    String sql = "insert into topic (group_id, topic_name, topic_desc, time) values (?,?,?,?)";
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, (String)session.getAttribute("group_id"));
                    st.setString(2, request.getParameter("name"));
                    st.setString(3, request.getParameter("desc"));     
                    st.setString(4, request.getParameter("time"));                                        
                    Dbcon.update(st);
                    %>
                    <script type="text/javascript">
                            $("#title").text("Added");
                            $("#body").text("Topic added successfully");
                            $("#button").text("Okay");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="view_topics.jsp";
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