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
        String sql = "delete from group_member where group_id = ?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setInt(1, Integer.parseInt(request.getParameter("group_id"))); 
        Dbcon.update(st);
        sql = "delete from e_group where group_id = ?";
        st = Dbcon.con.prepareStatement(sql);
        st.setInt(1, Integer.parseInt(request.getParameter("group_id")));
        Dbcon.update(st);
        %>
        <script type="text/javascript">
                $("#title").text("Deleted");
                $("#body").text("Group deleted successfully");
                $("#button").text("Okay");
                $("#modal").modal('show');
                $("#button").click(function(){
                        document.location.href="../index.jsp";
                });
        </script>         
        <%
    }catch(SQLException ex){
        System.out.println("delete_group:"+ex.getMessage());
        %>
        <script type="text/javascript">
                $("#title").html("Error");
                $("#body").html("You can't delete group for security reasons. <strong>Please delete topics inside group first.</strong>");
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