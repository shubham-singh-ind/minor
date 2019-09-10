<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%
    try{
            String sql = "select quest_id,option from answer where stud_id=?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setString(1, (String)session.getAttribute("username"));
        ResultSet rs = Dbcon.retrive(st);
        
        JSONObject mainObj = new JSONObject();        
        JSONArray array = new JSONArray();
        int count=0;
        while(rs.next()){
            JSONObject jo = new JSONObject();
            jo.put("quest_id", rs.getInt("quest_id"));
            jo.put("option", rs.getString("option"));
            array.add(jo);
            count++;
        }
        mainObj.put("questions", array);
        mainObj.put("count", count);
        out.print(mainObj);
    }catch(Exception ex){
        System.out.println("student/getAnsweredQuestions:"+ex.getMessage());
    }finally{
        Dbcon.close();
    }
%>