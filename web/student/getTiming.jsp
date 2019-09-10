<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONObject"%>

<%
        JSONObject json = new JSONObject();    
        try{
                String sql = "select last_time from student where stud_id=?";
                Dbcon.getConnection();
                PreparedStatement st = Dbcon.con.prepareStatement(sql);
                st.setString(1, (String)session.getAttribute("username"));
                ResultSet rs = Dbcon.retrive(st);
                String time="";
                if(rs.next())
                    time = rs.getString("last_time");
                json.put("time", time);
        }catch(Exception e){
            System.out.println("student/getTiming.jsp:"+e.getMessage());
        }finally{
            Dbcon.close();
        }
        out.print(json);    
%>