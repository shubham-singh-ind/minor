<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%@page import="org.json.simple.JSONObject"%>

<%

       try{
           System.out.println("hi");
            String sql = "insert into answer (option,stud_id,quest_id) values(?,?,?)";
            Dbcon.getConnection();
            PreparedStatement st = Dbcon.con.prepareStatement(sql);
            st.setString(1, request.getParameter("option"));
            st.setString(2, (String)session.getAttribute("username"));
            st.setInt(3, Integer.parseInt(request.getParameter("quest_id")));
            Dbcon.update(st);
       }catch(Exception ex){
           System.out.println("student/answer:"+ex.getMessage());
           String sql = "update answer set option = ? where stud_id=? and quest_id=?";
            PreparedStatement st = Dbcon.con.prepareStatement(sql);
            st.setString(1, request.getParameter("option"));
            st.setString(2, (String)session.getAttribute("username"));
            st.setInt(3, Integer.parseInt(request.getParameter("quest_id")));
            Dbcon.update(st);           
       }finally{
           Dbcon.close();
       }
%>