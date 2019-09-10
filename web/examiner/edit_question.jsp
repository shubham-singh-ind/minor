<%@page import="java.sql.ResultSet"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<%
    if(session.getAttribute("username")!=null){
        try{
            Dbcon.getConnection();
            String sql = "select * from question where quest_id=?";
            PreparedStatement st = Dbcon.con.prepareStatement(sql);
            st.setString(1, request.getParameter("quest_id"));
            ResultSet rs = Dbcon.retrive(st);
            if(rs.next()){
%>
        <!-- container -->
        <nav class="navbar-light">
                <!-- breadcrum -->
                <h1 class="display-4 text-center">Update question</h1>
                <!--\ breadcrum -->
                <!-- back button -->
                <a class="btn btn-primary btn-lg" style="position:fixed; bottom: 2px; left: 2px;z-index: 100;" href="view_questions.jsp"><i class="fa fa-chevron-left"></i> Back</a>                           
                <!--\ back button -->
                <!-- update question form -->                         
                <form class="container mt-5 animated slideInLeft" method="POST">
                    <input type='hidden' value='<%=request.getParameter("quest_id")%>' name="quest_id"/>
                    <div class="form-row">    
                        <div class="col-md-4"></div>
                        <div class="form-group col-md-4">
                          <label for="name" class="text-primary">*Question description</label>
                          <textarea class="form-control" name="desc" placeholder="Question description"><%=rs.getString("ques_desc")%></textarea>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionA" class="text-primary">*Option A</label>
                            <input type="text" class="form-control" name="optionA" value='<%=rs.getString("option_a")%>' id="optionA" placeholder="Option A">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionB" class="text-primary">*Option B</label>
                            <input type="text" class="form-control" name="optionB" value='<%=rs.getString("option_b")%>' id="optionB" placeholder="Option B">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionC" class="text-primary">*Option C</label>
                            <input type="text" class="form-control" name="optionC" value='<%=rs.getString("option_c")%>' id="optionC" placeholder="Option C">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-row">    
                        <div class="col-md-4"></div>                    
                        <div class="form-group col-md-4">
                            <label for="optionD" class="text-primary">*Option D</label>
                            <input type="text" class="form-control" name="optionD" value='<%=rs.getString("option_d")%>' id="optionD" placeholder="Option D">
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
                        <button type="submit" name="add" class="btn btn-primary btn-lg text-center col-md-4 mb-5">Update</button>   
                        <div class="col-md-4"></div>                            
                    </div>
                </form>			
                <!--\ update group form -->     
        <!--update group jsp-->
        <%
            try{
                if(request.getParameter("add")!=null){
                    Dbcon.getConnection();
                    System.out.println(session.getAttribute("topic_id"));
                    sql = "update question set ques_desc=?, option_a=?, option_b=?, option_c=?,option_d=?,correct_option=? where quest_id=?";
                    st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, request.getParameter("desc"));
                    st.setString(2, request.getParameter("optionA"));     
                    st.setString(3, request.getParameter("optionB"));
                    st.setString(4, request.getParameter("optionC"));                                        
                    st.setString(5, request.getParameter("optionD"));                                        
                    st.setString(6, request.getParameter("correct"));                                        
                    st.setString(7, request.getParameter("quest_id"));    
                    Dbcon.update(st);
                    %>
                    <script type="text/javascript">
                            $("#title").text("Updated");
                            $("#body").text("Question Updated successfully");
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
        <!--\update group jsp-->                        
        </nav>
        <!-- \container --> 
<%          }
        }catch(Exception ex){
            System.out.println("examiner/edit_question.jsp: "+ex.getMessage());
        }
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