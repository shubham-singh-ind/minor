<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="org.json.simple.JSONObject" %>
<%
    try{
        String sql = "select * from question where quest_id=?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setInt(1, Integer.parseInt(request.getParameter("quest_id")));
        ResultSet rs = Dbcon.retrive(st);
        JSONObject jo = new JSONObject();
        if(rs.next()){
            jo.put("q_id", rs.getString("quest_id"));            
            jo.put("ques_desc", rs.getString("ques_desc"));
            jo.put("option_a", rs.getString("option_a"));
            jo.put("option_b", rs.getString("option_b"));
            jo.put("option_c", rs.getString("option_c"));
            jo.put("option_d", rs.getString("option_d"));            
        }
            out.print(jo);
    }catch(Exception ex){
        System.out.println("student/getQuestion:"+ex.getMessage());
    }
%>