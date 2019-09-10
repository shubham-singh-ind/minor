<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%
    try{
        String sql = "insert into test_record values (?,?,?,?);";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setString(1, (String)session.getAttribute("username"));
        st.setString(2, (String)session.getAttribute("group_id"));
        st.setString(3, (String)session.getAttribute("topic_id"));
        st.setString(4, request.getParameter("marks"));
        Dbcon.update(st);
    }catch(Exception ex){
        System.out.println("student/appendTestRecord: "+ex.getMessage());
    }
%>