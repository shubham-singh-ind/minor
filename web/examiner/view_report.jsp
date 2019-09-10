<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %>
<%
    if(session.getAttribute("username")!=null){
%>
    <nav class="navbar-light">
        <!-- breadcrum -->
        <h1 class="display-4 text-center">Student reports</h1>
        <!--\ breadcrum -->
        <!-- search box for student -->
        <div class="input-group mb-4 container">
          <div class="input-group-prepend">
            <span class="input-group-text" id="basic-addon1"><i class="fa fa-search"></i></span>
          </div>
          <input type="text" class="form-control" placeholder="Search student">
        </div>
        <!--\ search box for student -->  
        
        <!--showing student reports-->
        <div class="container">
            <table class="table">
                <tr>
                    <th>Student name</th>
                    <th>Group name</th>
                    <th>Topic name</th>
                    <th>Result</th>                                
                </tr>
                <%
                try{
//                    String sql = "select * from view_report where ";
                %>
                <tr>
                    <td>.....</td>
                    <td>.....</td>
                    <td>.....</td>
                    <td>.....</td>                    
                </tr>
                <%
                }catch(Exception ex){
                    System.out.println("examiner/view_report:"+ex.getMessage());
                }
                %>
            </table>
        </div>        
        <!--\showing student reports-->        
    </nav>
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