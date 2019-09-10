<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%
    try{
        String sql = "select option from answer where stud_id=? and quest_id=?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setString(1, (String)session.getAttribute("username"));
        st.setString(2, request.getParameter("quest_id"));
        ResultSet rs = Dbcon.retrive(st);
        JSONObject jo=new JSONObject();
        if(rs.next()){
            jo.put("option", rs.getString("option"));
        }
        out.print(jo);
    }catch(Exception ex){
        System.out.println("student/getAnswered:"+ex.getMessage());
    }
%>