
package dbschema;

import SqlUtil.Dbcon;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class Schema {
    public void up() throws Exception{
        String query=null;
  
//        Login
        query = "create table if not exists login(user_id varchar(50), password varchar(30), role varchar(30), PRIMARY KEY(user_id, role))";
        Dbcon.getConnection();
        Dbcon.create(query);
        
//        Examiner
        query = "create table if not exists examiner(examiner_id varchar(50) PRIMARY KEY, fname varchar(30) not null, lname varchar(30), email varchar(60) not null, contact varchar(15) not null,  gender varchar(10))";
        Dbcon.create(query);        

//        Student
        query = "create table if not exists student(stud_id varchar(50), examiner_id varchar(50), fname varchar(30), lname varchar(30), institute_name varchar(50), gender varchar(10), last_time varchar(10), PRIMARY KEY(stud_id, examiner_id), FOREIGN KEY(examiner_id) references examiner(examiner_id))";
        Dbcon.create(query);

                
//        Address
        query = "create table if not exists address(user_id varchar(50) PRIMARY KEY, add_line_1 varchar(100), add_line_2 varchar(100), city varchar(30), state varchar(30))";
        Dbcon.create(query);
        
        
//        E group
        query = "create table if not exists e_group(group_id int PRIMARY KEY AUTO_INCREMENT, examiner_id varchar(50), group_name varchar(30), group_profile_url varchar(100), group_desc varchar(100), FOREIGN KEY(examiner_id) REFERENCES examiner(examiner_id))";
        Dbcon.create(query);
        
//        Group member
        query = "create table if not exists group_member (group_id int, examiner_id varchar(50) NOT NULL, stud_id varchar(50),PRIMARY KEY(group_id,stud_id), FOREIGN KEY(group_id) REFERENCES e_group(group_id), FOREIGN KEY(examiner_id) REFERENCES examiner(examiner_id), FOREIGN KEY(stud_id) REFERENCES student(stud_id))";
        Dbcon.create(query);
        
//        Topic
        query = "create table if not exists topic(topic_id int PRIMARY KEY AUTO_INCREMENT, group_id int, topic_name varchar(30), topic_desc varchar(50), time int, FOREIGN KEY(group_id) REFERENCES e_group(group_id))";
        Dbcon.create(query);
        
//        Test record
        query = "create table if not exists test_record(examiner_id varchar(50), stud_id varchar(30),  group_id int, topic_id int, marks varchar(20), PRIMARY KEY(stud_id,group_id,topic_id),FOREIGN KEY(stud_id) REFERENCES student(stud_id), FOREIGN KEY(group_id) REFERENCES e_group(group_id), FOREIGN KEY(topic_id) REFERENCES topic(topic_id), FOREIGN KEY(examiner_id) REFERENCES examiner(examiner_id))";
        Dbcon.create(query);
        
//        Question
        query = "create table if not exists question(quest_id int PRIMARY KEY AUTO_INCREMENT, topic_id int, ques_desc varchar(200), option_a varchar(50), option_b varchar(50), option_c varchar(50), option_d varchar(50), correct_option varchar(50), FOREIGN KEY(topic_id) REFERENCES topic(topic_id))";
        Dbcon.create(query);
        

//        Correct
        query = "create table if not exists answer(stud_id varchar(50), quest_id int, option varchar(2), FOREIGN KEY(stud_id) REFERENCES student(stud_id), FOREIGN KEY(quest_id) REFERENCES question(quest_id), PRIMARY KEY(stud_id,quest_id))";
        Dbcon.create(query);
        
    }
    
    public void down() throws Exception{
        String query=null;
       
//        test_record
        query = "drop table if exists test_record";
        Dbcon.create(query);    

//        login
        query = "drop table if exists login";
        Dbcon.create(query);        
                
        
//        address
        query = "drop table if exists address";
        Dbcon.create(query);       
              
          
        
//        group_member
        query = "drop table if exists group_member";
        Dbcon.create(query);        

//        answer
        query = "drop table if exists answer";
        Dbcon.create(query);
        
//        question
        query = "drop table if exists question";
        Dbcon.create(query);  
       
//        topic
        query = "drop table if exists topic";
        Dbcon.create(query);        
                
//        e_group
        query = "drop table if exists e_group";
        Dbcon.create(query); 

//        student
        query = "drop table if exists student";
        Dbcon.create(query);         
        
//        examiner
        query = "drop table if exists examiner";
        Dbcon.create(query); 
        
    }    
    
    

//    Database Schema modifications
    public static void main(String[] args) {
        try{
        Dbcon.getConnection();
        Schema sc = new Schema();
            sc.down();            
            sc.up();
        }catch(Exception ex){
            System.out.println("dbschema/Schema:"+ex.getMessage());
        }finally{
            Dbcon.close();
        }
    }
}
