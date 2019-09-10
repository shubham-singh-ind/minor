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
                <h1 class="display-4 text-center">Add question</h1>
                <!--\ breadcrum -->
                <!-- back button -->
                <div class="container">
                    <a class="btn btn-outline-primary btn-lg text-center" href="view_questions.jsp"><i class="fa fa-chevron-left"></i> Back</a>
                </div>				
                <!--\ back button -->
                <!-- add topic form -->                         
                <form class="container mt-5" method="POST">
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <div class="form-group col-md-4">
                          <label for="name" class="text-primary">*Question description</label>
                          <textarea class="form-control" name="desc" placeholder="Question description"></textarea>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionA" class="text-primary">*Option A</label>
                            <input type="text" class="form-control" name="optionA" id="optionA" placeholder="Option A">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionB" class="text-primary">*Option B</label>
                            <input type="text" class="form-control" name="optionB" id="optionB" placeholder="Option B">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionC" class="text-primary">*Option C</label>
                            <input type="text" class="form-control" name="optionC" id="optionC" placeholder="Option C">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionD" class="text-primary">*Option D</label>
                            <input type="text" class="form-control" name="optionD" id="optionD" placeholder="Option D">
                        </div>
                        <div class="col-md-4"></div>
                    </div> 
                    <div class="form-row">
                        <div class="col-md-4"></div>                        
			    <div class="form-group col-md-4">
                                <label for="correct" class="text-primary">*Correct option</label>
                              <select id="correct" class="form-control" name="correct">
                                  <option value="a">a</option>
                                  <option value="b">b</option>
                                  <option value="c">c</option>
                                  <option value="d">d</option>                                                                
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
                    System.out.println(session.getAttribute("topic_id"));
                    String sql = "insert into question (topic_id, ques_desc, option_a, option_b, option_c, option_d, correct_option) values (?,?,?,?,?,?,?)";
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, (String)session.getAttribute("topic_id"));
                    st.setString(2, request.getParameter("desc"));
                    st.setString(3, request.getParameter("optionA"));     
                    st.setString(4, request.getParameter("optionB"));
                    st.setString(5, request.getParameter("optionC"));                                        
                    st.setString(6, request.getParameter("optionD"));                                        
                    st.setString(7, request.getParameter("correct"));                                                            
                    Dbcon.update(st);
                    %>
                    <script type="text/javascript">
                            $("#title").text("Added");
                            $("#body").text("Question added successfully");
                            $("#button").text("Okay");
                            $("#modal").modal('show');
                            $("#button").click(function(){
                                    document.location.href="view_questions.jsp";
                            });
                    </script>  
                    <%
                }
            }catch(Exception ex){
                System.out.println("examiner/addquestion.jsp: "+ex.getMessage());
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