package public_news;

import static db.JdbcUtil.*;
import static db.JdbcUtil.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import board.BoardBean;
import db.JdbcUtil;

public class publicDAO {

	Connection con = null;
	PreparedStatement pstmt, pstmt2 = null;
	ResultSet rs = null;

	// ----public_write.pro 글작성
	public int insertPublic(publicDTO board) {
		int insertCount = 0;
		int num = 1;

		try {
			con = getConnection();

			String sql = "SELECT MAX(num) FROM news";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {// 등록된 게시물이 하나라도 존재할 경우(= 최대값이 조회될 경우)
				num = rs.getInt(1) + 1;
			}

			String sql2 = "INSERT INTO news VALUES(?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql2);

			pstmt2.setInt(1, num);
			pstmt2.setString(2, board.getName());
			pstmt2.setString(3, board.getPass());
			pstmt2.setString(4, board.getSubject());
			pstmt2.setString(5, board.getContent());

			insertCount = pstmt2.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(pstmt);
			close(con);
		}

		return insertCount;
	}

	// public.jsp 게시판 갯수 설정
	public int selectBoard() {
		int selsectCount = 0;

		try {
			con = getConnection();

			String sql = "SELECT COUNT(num) FROM news";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {// 등록된 게시물이 하나라도 존재할 경우(= 최대값이 조회될 경우)
				selsectCount = rs.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return selsectCount;
	}

	// public.jsp 게시판 목록 갯수 뿌리기 페이지 갯수 뿌리기
	public ArrayList<publicDTO> selectBoardList(int pagenum, int listLimit) {
		ArrayList<publicDTO> boardList = null;

		try {
			con = getConnection();
			int startRow = (pagenum - 1) * listLimit;
			String sql = "SELECT * FROM news ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			rs = pstmt.executeQuery();

			boardList = new ArrayList<publicDTO>();

			while (rs.next()) {
				publicDTO dto = new publicDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));

				boardList.add(dto);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}

		return boardList;
	}

	// public_content //글 목록 상세히보기
	public publicDTO selectBoard(int num) {
		publicDTO news = null;

		con = getConnection();

		try {
			String sql = "SELECT * FROM news WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				news = new publicDTO();
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}

		return news;

	}

	// public_content //글 목록 조회수 증가
	public void updateReadCount(int num) {

		con = getConnection();
		
		try {
			String sql = "UPDATE news SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			if (rs.next()) {
				rs.getInt(num);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {

			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}

	}

	public int UpdatePublic(publicDTO dto) {
		int UpdateCount = 0;

		try {
			con = getConnection();
			String sql = "SELECT pass FROM news WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (rs.getString("pass").equals(dto.getPass())) {
					String sql2 = "UPDATE news SET name=?,subject=?,content=? WHERE num=?";
					pstmt2 = con.prepareStatement(sql2);
					pstmt2.setString(1, dto.getName());
					pstmt2.setString(2, dto.getSubject());
					pstmt2.setString(3, dto.getContent());
					pstmt2.setInt(4, dto.getNum());
				}
				UpdateCount = pstmt2.executeUpdate();
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}

		return UpdateCount;
	}

	public int deletenews(int num, String pass) {
		int deleteCount = 0;

		try {
			con = getConnection();
			// 글번호와 패스워드가 모두 일치하는 게시물 조회
			String sql = "SELECT * FROM news WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				String sql1 = "DELETE FROM news WHERE num=?";
				pstmt2 = con.prepareStatement(sql1);
				pstmt2.setInt(1, num);
				deleteCount = pstmt2.executeUpdate();

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}

		return deleteCount;

	}
	//public_search : num 의 최대갯수 구하기
	public int selectSearchListCount(String search, String searchType) {
		int listCount = 0;

		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM news WHERE " + searchType + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			// 검색어 생성을 위해서는 검색 키워드 앞뒤로 "%" 문자열 결합 필요

			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();

			// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
			if (rs.next()) {
				listCount = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectListCount()");
		} finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(pstmt);
			 JdbcUtil.close(con);
		}

		return listCount;
	}

	//public_search :게시판에 dto 뿌리고 페이징
	public ArrayList<publicDTO> selectPublicList(int PageNum, int ListLimit, String searchType, String search) {
		ArrayList<publicDTO> publicList = null;
		int startRow = (PageNum - 1) * ListLimit;
		try {
			con = getConnection();
			String sql = "SELECT * FROM news " +
					 "WHERE " + searchType + " LIKE ? " + 
					 "ORDER BY num DESC LIMIT ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, ListLimit);
			
			publicList=new ArrayList<publicDTO>();
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				publicDTO dto = new publicDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));

				publicList.add(dto);
			}
			//System.out.println(publicList.toString());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}

		return publicList;
	}
	//main: 최근 게시물 5개 뿌리기
	public ArrayList<publicDTO> selectRecentPublicList() {
		ArrayList<publicDTO> publicList = null;

		try {
			con = getConnection();
			String sql = "SELECT * FROM news ORDER BY num DESC LIMIT 1,5";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			publicList = new ArrayList<publicDTO>();

			while (rs.next()) {

				// 1개 레코드를 저장할 BoardBean 객체 생성
				publicDTO publicdto = new publicDTO();
				// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
				publicdto.setNum(rs.getInt("num"));
				publicdto.setName(rs.getString("name"));
				publicdto.setSubject(rs.getString("subject"));
				publicdto.setDate(rs.getDate("date"));

				publicList.add(publicdto);
			}

			System.out.println(publicList);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(pstmt);
			 JdbcUtil.close(con);
			
		}

		return publicList;

	}

}
