<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@include file="header.jsp" %>
<%@include file="alert.jsp" %> 
<%
    if(session.getAttribute("username")!=null){
            if(request.getParameter("topic_id")!=null)
                session.setAttribute("topic_id", request.getParameter("topic_id"));
%>
        <!-- container -->
        <nav class="navbar-light" style="z-index: 0;">
            <h1 class='display-4 text-center'>Read instructions</h1>
            <div class="container" style="height:500px;overflow: auto;">
                <ul>
                    <li>Click on the Attempt test button to start the test.</li>
                    <li>Mobile phones,mp3 players,smartwatches and other elsectronic devides must be turned off and put away.</li>
                    <li>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enimad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</li>
                    <li>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</li>
                    <li>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</li>
                    <li>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</li>
                    <li>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</li>
                    <li>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</li>
                    <li style="list-style-type: none;" class="text-center">
                        <a class="btn btn-outline-success btn-lg" href="test.jsp?topic_id=<%=session.getAttribute("topic_id")%>" target="_blank">Attempt test</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- \container -->
        
<!--jsp for assigning time to student-->
<%
    try{
//        take last_time from student table
        String sql = "select last_time from student where stud_id=?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setString(1, (String)session.getAttribute("username")); 
        ResultSet rs1 = Dbcon.retrive(st);
        if(rs1.next()){
//            if last time is 0:0 then assign time to student for particular topic
            if(rs1.getString("last_time").equals("0:0")){
                sql = "select time from topic where topic_id=?";
                st = Dbcon.con.prepareStatement(sql);
                st.setInt(1, Integer.parseInt((String)session.getAttribute("topic_id"))); 
                ResultSet rs2 = Dbcon.retrive(st);
                if(rs2.next()){
                    sql = "update student set last_time=? where stud_id=?";
                    st = Dbcon.con.prepareStatement(sql);
                    st.setString(1, rs2.getString("time")+":0");
                    st.setString(2, (String)session.getAttribute("username"));                    
                    Dbcon.update(st);
                }
            }
        }
    }catch(Exception ex){
        System.out.println("student/instruction: "+ex.getMessage());
    }
%>

<!--\ jsp for assigning time to student-->

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