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
        String sql = "delete from question where quest_id = ?";
        Dbcon.getConnection(); 
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setInt(1, Integer.parseInt(request.getParameter("quest_id"))); 
        Dbcon.update(st);
        %>
        <script type="text/javascript">
                $("#title").text("Deleted");
                $("#body").text("Question deleted successfully");
                $("#button").text("Okay");
                $("#modal").modal('show');
                $("#button").click(function(){
                        document.location.href="view_questions.jsp";
                });
        </script>         
        <%
    }catch(SQLException ex){
        System.out.println("delete_question:"+ex.getMessage());
    }finally{
        Dbcon.close();
    }
%>