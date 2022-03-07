package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDao() {
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String user ="hr";
			String password="1234";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url,user,password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String sql="select userPassword from board where userID=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,userID);
			
			rs =pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인 성공
				} else {
					return 0;// 비밀번호 불일치
				}
			}
			return -1; // 아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;//데이터베이스 오류 
	}
	
	public int join(UserDto dto) {
		String sql="insert into board(userID,userPassword,userName,userGender,userEmail) values (?,?,?,?,?)";
		try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getUserID());
		pstmt.setString(2, dto.getUserPassword());
		pstmt.setString(3, dto.getUserName());
		pstmt.setString(4, dto.getUserGender());
		pstmt.setString(5, dto.getUserEmail());
		
		return pstmt.executeUpdate(); // insert문은 반드시 0이상의 숫자가 반환됨
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;//데이터베이스 오류
	}
	
	
	

}
