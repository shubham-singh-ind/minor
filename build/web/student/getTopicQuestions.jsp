<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%
    try{
        String sql = "select * from question where topic_id=?";
        Dbcon.getConnection();
        PreparedStatement st = Dbcon.con.prepareStatement(sql);
        st.setInt(1, Integer.parseInt((String)session.getAttribute("topic_id")));
        ResultSet rs = Dbcon.retrive(st);
        
        JSONObject mainObj = new JSONObject();        
        JSONArray array = new JSONArray();
        int count=0;
        while(rs.next()){
            JSONObject jo = new JSONObject();
            jo.put("quest_id", rs.getInt("quest_id"));
            jo.put("ques_desc", rs.getString("ques_desc"));            
            jo.put("option_a", rs.getString("option_a"));
            jo.put("option_b", rs.getString("option_b"));
            jo.put("option_c", rs.getString("option_c"));
            jo.put("option_d", rs.getString("option_d"));            
            jo.put("correct_option", rs.getString("correct_option"));
            array.add(jo);
            count++;
        }
        mainObj.put("questions", array);
        mainObj.put("count", count);
        out.print(mainObj);
    }catch(Exception ex){
        System.out.println("student/getTopicQuestions:"+ex.getMessage());
    }finally{
        Dbcon.close();
    }
%>