<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="alert.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("role")!=null){
        if(session.getAttribute("role").equals("examiner"))
            response.sendRedirect("examiner/home.jsp");
        else
            response.sendRedirect("student/home.jsp");             
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online test|Sign up</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">        
        <title>Online Test</title>
        <!--bootstrap css-->
        <link rel="stylesheet" type="text/css" href="./ui_css/bootstrap.min.css"/>   
        <link rel="stylesheet" type="text/css" href="./ui_css/ui_css.css"/>             
        <!--jquery-->
        <script src="./ui_js/jquery.min.js"></script>
        <!--bootstrap js-->
        <script src="./ui_js/bootstrap.min.js"></script>     
        <script src="./ui_js/validation/signup.js"></script>                  
    </head>
    <body style="background: url(pics/background.svg)">
			<h1 class="display-4 text-center">Sign up</h1> 
                        <hr class="my-4">
			<!-- sign up form -->                        
                        <form class="container jumbotron" method="POST" onsubmit="return validateSignup()">
			  <div class="form-row">
			    <div class="form-group col-md-6">
			      <label for="inputUsername" class="text-primary">*Username</label>
                              <input type="text" class="form-control" name="username" id="inputUsername" onfocusout="user()" placeholder="Username">
                              <strong class="danger" id="usernameError"></strong>
                            </div>
			    <div class="form-group col-md-6">
			      <label for="inputPassword" class="text-primary">*Password</label>
                              <input type="password" class="form-control" name="password" id="inputPassword" onfocusout="pass()" placeholder="Password">
                              <strong class="danger" id="passwordError"></strong>			    
                            </div>
			  </div>
			  <div class="form-row">
			    <div class="form-group col-md-6">
			      <label for="inputFname" class="text-primary">*First name</label>
                              <input type="text" class="form-control" name="fname" id="inputFname" placeholder="First name" onfocusout="firstname()">
                              <strong class="danger" id="fnameError"></strong>			    
                            </div>
			    <div class="form-group col-md-6">
			      <label for="lname">Last name</label>
                              <input type="text" class="form-control" name="lname" id="lname" placeholder="Last name">
                            </div>                              
			  </div>
			  <div class="form-row">
			    <div class="form-group col-md-6">
			      <label for="inputContact" class="text-primary">*Contact</label>
                              <input type="number" class="form-control" name="contact" id="inputContact" onfocusout="mobile()" placeholder="e.g. 9118548596">
                              <strong class="danger" id="contactError"></strong>			    			    
                            </div>
                            <div class="form-group col-md-6">
			      <label for="inputEmail" class="text-primary">*E-mail</label>
                              <input type="email" class="form-control" name="email" id="inputEmail" placeholder="e.g. one@gmail.com" onfocusout="emailAdd()">
                              <strong class="danger" id="emailError"></strong>			    			    			    
                            </div>  
			  </div>		
                            <div class="form-row">   
                            <div class="form-group col-md-6">
                              <label for="address1">Address</label>
                              <input type="text" class="form-control" name="address1" id="address1" placeholder="e.g. 1234 Main St">
                            </div>
                              <div class="form-group col-md-6">
                                  <label for="gender" class="text-primary">*Gender</label>
                                  <select id="gender" class="form-control" name="gender">
                                      <option value="male">Male</option>
                                      <option value="female">Female</option>                                  
                                  </select>
                              </div>
                            </div>     
			  <div class="form-group">
			    <label for="address2">Address 2</label>
                            <input type="text" class="form-control" name="address2" id="address2" placeholder="e.g. 	Apartment, studio, or floor">
			  </div>
			  <div class="form-row">
			    <div class="form-group col-md-6">
			      <label for="city">City</label>
                              <input type="text" class="form-control" name="city" id="city" placeholder="e.g Indore">
			    </div> 
			    <div class="form-group col-md-6">
			      <label for="state">State</label>
                              <select id="state" class="form-control" name="state">
                                  <option value="Uttar pradesh">Uttar pradesh</option>
                                  <option value="Madhya pradesh">Madhya pradesh</option>
                                  <option value="Gujrat">Gujrat</option>
                                  <option value="Maharashtra">Maharashtra</option>                                                                
			      </select>
			    </div>
			  </div>
                            <button type="submit" name="signup" class="btn btn-primary btn-lg text-center col-md-12">Sign up</button>
                        Already a user? <a href="index.jsp">Sign in</a>                            
			</form>			
			<!--\ sign up form -->
                       
        <!--jquery-->
        <script src="./ui_js/jquery.min.js"></script>
        <!--bootstrap js-->
        <script src="./ui_js/bootstrap.min.js"></script>   
        
        <!--sign up jsp-->
        <%
            try{
                if(request.getParameter("signup")!=null){
                    // inserting into examiner personal info
                    String sql = "insert into examiner values (?,?,?,?,?,?);";
                    Dbcon.getConnection();
                    PreparedStatement st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, request.getParameter("username"));
                    st.setString(2, request.getParameter("fname"));
                    st.setString(3, request.getParameter("lname"));
                    st.setString(4, request.getParameter("email"));
                    st.setString(5, request.getParameter("contact"));
                    st.setString(6, request.getParameter("gender"));
                    Dbcon.update(st);
                    // inserting adress info
                    sql = "insert into address values (?,?,?,?,?)";
                    st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, request.getParameter("username"));
                    st.setString(2, request.getParameter("address1"));
                    st.setString(3, request.getParameter("address2"));
                    st.setString(4, request.getParameter("city"));
                    st.setString(5, request.getParameter("state"));
                    Dbcon.update(st);     
                    // inserting login credentials
                    sql = "insert into login values (?,?,?)";
                    st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, request.getParameter("username"));
                    st.setString(2, request.getParameter("password"));
                    st.setString(3, "examiner");             
                    Dbcon.update(st);
                    %>
                    <script>
                        $("#title").html("Signup successfull");
                        $("#body").html("You are now registered as an examiner, please go ahead and login.");
                        $("#button").html("okay");
                        $("#modal").modal("show");                        
                        $("#button").click(function(){
                           document.location.href="index.jsp";
                        });
                    </script>
                    <% 
                }
            }catch(Exception ex){
                System.out.println("signup.jsp: "+ex.getMessage());
                    %>
                    <script>
                        $("#title").html("Error");
                        $("#body").html("Internal server error, please try after some time.");
                        $("#button").html("okay");
                        $("#modal").modal("show");                                                
                        $("#button").click(function(){
                           document.location.href="index.jsp";
                        });
                    </script>
                    <%
            }finally{
                Dbcon.close();
            }
        %>
        <!--\sign up jsp-->
    </body>
</html>
