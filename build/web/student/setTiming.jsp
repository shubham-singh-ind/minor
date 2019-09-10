<%@page import="java.sql.PreparedStatement"%>
<%@page import="SqlUtil.Dbcon"%>
<%   
        try{    
            String sql = "update student set last_time = ? where stud_id=?";
             Dbcon.getConnection();
             PreparedStatement st = Dbcon.con.prepareStatement(sql);
             st.setString(1, request.getParameter("min")+":"+request.getParameter("sec"));
             st.setString(2, (String)session.getAttribute("username"));
             Dbcon.update(st);
        }catch(Exception ex){
            System.out.println("student/setTiming.jsp:"+ex.getMessage());
        }finally{
            Dbcon.close();
        }                     
%>