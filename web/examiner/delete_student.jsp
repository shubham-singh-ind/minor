<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<!--bootstrap css--> 
<link rel="stylesheet" type="text/css" href="../ui_css/bootstrap.min.css"/>   
<!--jquery-->
<script src="../ui_js/jquery.min.js"></script>
<!--bootstrap js-->
<script src="../ui_js/bootstrap.min.js"></script>
<%@include file="alert.jsp" %> 
<%
    try{
        String sql = "delete from student where stud_id = ?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setString(1, request.getParameter("stud_id")); 
        Dbcon.update(st);
        sql = "delete from login where user_id =? and role=?";
        st = Dbcon.con.prepareStatement(sql);
        st.setString(1, request.getParameter("stud_id"));
        st.setString(2, "student");        
        Dbcon.update(st);
        %>
        <script type="text/javascript"> 
                $("#title").text("Deleted");
                $("#body").text("Student deleted successfully");
                $("#button").text("Okay");
                $("#modal").modal('show');
                $("#button").click(function(){
                        document.location.href="addstudent.jsp";
                });
        </script>         
        <%
    }catch(Exception ex){
        System.out.println("examiner/delete_student:"+ex.getMessage());
        ex.printStackTrace();
        %>
        <script type="text/javascript">
                $("#title").html("Error");
                $("#body").html("<strong>Internal server error.</strong>");
                $("#button").html("Okay");
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