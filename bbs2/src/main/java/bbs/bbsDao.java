package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;

public class bbsDao {
	
	
	private Connection conn;
	private ResultSet rs;
	
	public bbsDao() {
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
	
	public String getDate() {
		String sql ="SELECT TO_DATE(SYSDATE, 'YYYYMMDD HH24:MI:SS') FROM DUAL";
		try {
			
		PreparedStatement pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()) {
			return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스오류
		
	}
	
	public int getNext() {
		String sql ="SELECT bbsID from board_bbs order by bbsID desc";
		try {
			
			PreparedStatement pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) +1 ;
			} 
				return 1;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스오류
		
	}
	
	public int write(String bbsTitle,String userID,String bbsContent) {
		String sql ="insert into board_bbs(bbsID,bbsTitle,userID,bbsContent,bbsDate,bbsAvailable,readCounts,upCounts) values(?,?,?,?,sysdate,?,0,0)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, bbsContent);
			pstmt.setInt(5, 1);
			
			return pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;//데이터베이스 오류
	}
	
	public ArrayList<bbsDto> getList(int pageNumber){
		String sql = "select * from board_bbs where bbsID < ? AND bbsAvailable=1 AND rownum <=10 order by bbsID desc";
		ArrayList<bbsDto> list=new ArrayList<bbsDto>();		
				try {
					PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, getNext()-(pageNumber-1)*10);
					
					rs=pstmt.executeQuery();
					while(rs.next()) {
						bbsDto bbsDto=new bbsDto();
						bbsDto.setBbsId(rs.getInt(1));
						bbsDto.setBbsTitle(rs.getString(2));
						bbsDto.setUserID(rs.getString(3));
						bbsDto.setBbsDate(rs.getString(4));
						bbsDto.setBbsContent(rs.getString(5));
						bbsDto.setBbsAvailable(rs.getInt(6));
						bbsDto.setReadCounts(rs.getInt(7));
						bbsDto.setUpCounts(rs.getInt(8));
						
						list.add(bbsDto);
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				return list;//데이터베이스 오류
		
	}
	
	public boolean nextPage(int pageNumber) {
		String sql = "select * from board_bbs where bbsID < ? AND bbsAvailable=1";
				try {
					PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, getNext()-(pageNumber-1)*10);
					
					rs=pstmt.executeQuery();
					while(rs.next()) {
						return true;
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				return false;//데이터베이스 오류
	}
	
	public bbsDto getBbsDto(int bbsID) {
		String sql="select * from board_bbs where bbsID=? AND bbsAvailable=1";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bbsDto bbsDto = new bbsDto();
				bbsDto.setBbsId(rs.getInt(1));
				bbsDto.setBbsTitle(rs.getString(2));
				bbsDto.setUserID(rs.getString(3));
				bbsDto.setBbsDate(rs.getString(4));
				bbsDto.setBbsContent(rs.getString(5));
				bbsDto.setBbsAvailable(rs.getInt(6));
				bbsDto.setReadCounts(rs.getInt(7));
				bbsDto.setUpCounts(rs.getInt(8));
				
				return bbsDto;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public void updateReadCount(int bbsID) {
		String sql = "update board_bbs set readcounts=(readcounts+1) where bbsID =?";//게시글의 조회수를 증가시키는 SQL문을 작성하시오.
		try(
			PreparedStatement pstmt	=conn.prepareStatement(sql)){
		
		pstmt.setInt(1, bbsID);
		
        pstmt.executeUpdate();
        
		}catch(Exception e){e.printStackTrace();}
	}
	
	
	
	public int updateUpCounts(int bbsID) {
		String sql = "update board_bbs set upCounts=(upCounts+1) where bbsID =? ";//게시글의 조회수를 증가시키는 SQL문을 작성하시오.
		try(
				PreparedStatement pstmt	=conn.prepareStatement(sql)){
			
			pstmt.setInt(1, bbsID);
			
			return pstmt.executeUpdate();
			
			
		}catch(Exception e){e.printStackTrace();}
		
		return -1;
	}
	
	public int updateUpCountsDown(int bbsID) {
		String sql = "update board_bbs set upCounts=(upCounts-1) where bbsID =? ";
		try(
				PreparedStatement pstmt	=conn.prepareStatement(sql)){
			
			pstmt.setInt(1, bbsID);
			
			return pstmt.executeUpdate();
			
			
		}catch(Exception e){e.printStackTrace();}
		
		return -1;
	}
	

	
	
	
	

}
