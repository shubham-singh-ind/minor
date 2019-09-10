
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%
    if(session.getAttribute("role")!=null){
        if(session.getAttribute("role").equals("examiner"))
            response.sendRedirect("examiner/home.jsp");
        else
            response.sendRedirect("student/home.jsp");             
    }
%>
<style>
input,select{
    transition-property: transform!important;
    transition-duration: 0.5s!important;
}
input:focus,select:focus{
    transform: scale(1.2)!important;
} 
body{
    background: url(./pics/background.svg);
    background-size: cover;
    background-repeat: no-repeat;
}
    </style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">        
        <title>Online Test</title>
        <!--bootstrap css-->
        <link rel="stylesheet" type="text/css" href="./ui_css/bootstrap.min.css"/>
        <!--login css-->
        <link rel="stylesheet" type="text/css" href="./ui_css/login.css"/> 
        <!--jquery-->
        <script src="./ui_js/jquery.min.js"></script>
        <!--bootstrap js-->
        <script src="./ui_js/bootstrap.min.js"></script>     
        <script src="./ui_js/validation/login.js"></script>                
        <!--custom css-->
        <link rel="stylesheet" type="text/css" href="./ui_css/ui_css.css">
    </head>
    <body>
    <!--login form-->
    <form class="form-signin" action="" method="POST" onsubmit="return validateLogin()">
      <img src="./pics/login_avtar.png" alt="" class="rounded-circle mb-4" width="120" height="120" style="position: relative;left: 30%;">
      <h1 class="h3 mb-3 font-weight-normal text-center text-white">Please sign in</h1>
      <label for="inputUsername" class="sr-only">Username</label>
      <input type="text" id="inputUsername" class="form-control" placeholder="Username" name="username" onfocusout="user()"autofocus>
      <strong id="usernameError" class="danger"></strong>            
      <label for="inputPassword" class="sr-only" name="pass" >Password</label>
      <input type="password" id="inputPassword" class="form-control" placeholder="Password" name="password" onfocusout="pass()">
      <strong id="passwordError" class="danger"></strong>      
      <label for="inputRole" class="sr-only">Role</label>
		<select name="role" id="inputRole" class="form-control" required> 
			<option value="examiner">Examiner</option>	
			<option value="student">Student</option>
                </select><br>
      <button class="btn btn-lg btn-primary btn-block" type="submit" name="signin">Sign in</button>
      Not a user? <a href="signup.jsp" class='text-white'>Sign up</a>
    </form>
    <!--\login form--> 

        <!--jquery-->
        <script src="./ui_js/jquery.min.js"></script>
        <!--bootstrap js-->
        <script src="./ui_js/bootstrap.min.js"></script>
    <!--login jsp-->
    <%
        try{
            if(request.getParameter("signin")!=null){
                String sql = "select user_id, role from login where user_id=? and password=? and role=?";
                Dbcon.getConnection();
                PreparedStatement st = Dbcon.con.prepareStatement(sql);
                st.setString(1, request.getParameter("username"));
                st.setString(2, request.getParameter("password"));
                st.setString(3, request.getParameter("role"));                
                ResultSet result = Dbcon.retrive(st);
                if(result.next()){
                    session.setAttribute("username", request.getParameter("username"));
                    session.setAttribute("role", request.getParameter("role"));
                    if(request.getParameter("role").equals("examiner"))    
                        response.sendRedirect("examiner/home.jsp");
                    else
                        response.sendRedirect("student/home.jsp");                        
                }else{
                    %>
                    <%@include file="loginfail.jsp" %>
                    <script type="text/javascript">
                        $("#incorrect").modal('show');
                        $("#try").click(function(){
                                document.location.href="index.jsp";
                        });
                    </script>
                    <%
                }
            }
        }catch(Exception ex){
            System.out.println("index.jsp: "+ex.getMessage());
        }
    %>
    <!--\login jsp-->                
    </body>
</html> 
