package service;

import static db.JdbcUtil.*;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import board.BoardBean;
import db.JdbcUtil;

public class serviceDAO {
	ResultSet rs;
	PreparedStatement pstmt,pstmt2;
	Connection con;
	
	public int insertService(serviceDTO dto) {
		int insertCount=0;
		
		int num = 1;

		try {
			con = getConnection();

			String sql = "SELECT MAX(num) FROM service";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {// 등록된 게시물이 하나라도 존재할 경우(= 최대값이 조회될 경우)
				num = rs.getInt(1) + 1;
			}

			String sql2 = "INSERT INTO service VALUES(?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql2);

			pstmt2.setInt(1, num);
			pstmt2.setString(2, dto.getName());
			pstmt2.setString(3, dto.getPass());
			pstmt2.setString(4, dto.getSubject());
			pstmt2.setString(5, dto.getContent());

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
	
	public serviceDTO selectBoard(int num) {

		serviceDTO dto = null;
		con = getConnection();

		try {
			String sql = "SELECT * FROM service WHERE num =?";
			pstmt = con.prepareCall(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			// 1개 레코드를 저장할 BoardBean 객체 생성

			// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
			if (rs.next()) {
				dto = new serviceDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));

			}
			System.out.println(dto);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(pstmt);
			 JdbcUtil.close(con);
		}

		return dto;

	}
	
	
	public int selectListCount() {
		int listCount = 0;

		con = getConnection();

		try {
			String sql = "SELECT COUNT(num) FROM service";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {// 등록된 게시물이 하나라도 존재할 경우(= 최대값이 조회될 경우)
				listCount = rs.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(pstmt);
			 JdbcUtil.close(con);
		}

		return listCount;
	}
	
	// 게시물 목록 조회작업 수행하는 selectBoardList()
		public ArrayList<serviceDTO> selectBoardList(int pagenum, int listLimit) {
			ArrayList<serviceDTO> boardList = null;

			try {
				con = getConnection();

				// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작)행 번호 게산
				// ex) 1page= 0;
				// ex) 2page= 10;
				// ex) 3page= 20;

				int startRow = (pagenum - 1) * listLimit;

				// (정렬방식(ORDER BY)=> 오름차순 /내림차순: DESC) 개수제한 구문 LIMIT(시작하는 행번호,뽑고싶은 레코드 갯수)
				// =>목록갯수는 파라미터로 전달받은 LISTlIMIT 값사용
				// => 시작행번호는 (페이지번호 -1) * listLimit
				String sql = "SELECT * FROM service ORDER BY num DESC LIMIT ?,?";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, startRow);
				pstmt.setInt(2, listLimit);

				rs = pstmt.executeQuery();

				boardList = new ArrayList<serviceDTO>();

				while (rs.next()) {

					// 1개 레코드를 저장할 BoardBean 객체 생성
					serviceDTO board = new serviceDTO();
					// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
					board.setNum(rs.getInt("num"));
					board.setName(rs.getString("name"));
					board.setPass(rs.getString("pass"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setDate(rs.getDate("date"));
					board.setReadcount(rs.getInt("readcount"));

					boardList.add(board);
				}

				System.out.println(boardList);

			} catch (SQLException e) {

				e.printStackTrace();
				System.out.println("sql 구문오류 -selectBoardList()");
			}finally {
				 JdbcUtil.close(rs);
				 JdbcUtil.close(pstmt);
				 JdbcUtil.close(con);
				 
			}

			return boardList;

		}
		// ---------------------- 검색 기능 ----------------------
		// 검색어에 해당하는 게시물 목록 갯수를 조회하는 selectSearchListCount()
		// => 파라미터 : 검색어(search), 리턴타입 : int(listCount)
		public int selectSearchListCount(String search, String searchType) {
			int listCount = 0;

			try {
				con = getConnection();
				
				String sql = "SELECT COUNT(num) FROM service WHERE " + searchType + " LIKE ?";
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

		// 검색어에 해당하는 게시물 목록 조회작업을 수행하는 selectSearchBoardList()
		// => 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit), 검색어(search)
		// 리턴타입 : java.util.ArrayList<BoardBean>(boardList)
		public ArrayList<serviceDTO> selectSearchBoardList(int pageNum, int listLimit, String search, String searchType) {
			ArrayList<serviceDTO> boardList = null;

			try {
				// 1 & 2단계
				con = getConnection();

				// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
				int startRow = (pageNum - 1) * listLimit;

				// 3단계. SQL 구문 작성 및 전달
				// 검색어에 해당하는 board 테이블의 모든 레코드 조회(글번호(num) 기준으로 내림차순 정렬)
				String sql = "SELECT * FROM service " +
							 "WHERE " + searchType + " LIKE ? " + 
							 "ORDER BY num DESC LIMIT ?,?";
				// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, listLimit);

				// 4단계. SQL 구문 실행 및 결과 처리
				rs = pstmt.executeQuery();

				// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성
				// => 주의! 반복문 시작 전에 미리 생성해야함
				boardList = new ArrayList<serviceDTO>();

				// 다음레코드가 존재할 동안 반복하면서
				// 1개 레코드 정보를 BoardBean 객체에 저장 후
				// 다시 BoardBean 객체를 전체 레코드 저장하는 ArrayList<BoardBean> 객체에 추가
				while (rs.next()) {
					// 1개 레코드를 저장할 BoardBean 객체 생성
					serviceDTO board = new serviceDTO();
					// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
					board.setNum(rs.getInt("num"));
					board.setName(rs.getString("name"));
					board.setPass(rs.getString("pass"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setDate(rs.getDate("date"));
					board.setReadcount(rs.getInt("readcount"));

					// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
					boardList.add(board);
					System.out.println(boardList.toString());
				}

//						System.out.println(boardList);

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("SQL 구문 오류 - selectBoardList()");
			} finally {
				 JdbcUtil.close(rs);
				 JdbcUtil.close(pstmt);
				 JdbcUtil.close(con);
			}

			return boardList;
		}
		//service_content
		public void updateReadcount(int num) {

			con = getConnection();

			try {
				String sql = "UPDATE service SET readcount=readcount+1 WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);

				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL구문 오류-updateReadcount()");
				e.printStackTrace();
			} finally {
				
				 JdbcUtil.close(pstmt);
				 JdbcUtil.close(con);
			}

		}
		//service_updatePro
		public int updateBoard(serviceDTO board) {
			int updateCount = 0;

			try {
				con = getConnection();

				// 1. 패스워드 판별 작업
//					String sql = "SELECT * FROM board WHERE num=? AND pass=?"; // 패스워드에 맞는 게시물 조회 시
				String sql = "SELECT pass FROM service WHERE num=?"; // 패스워드 조회 후 별도로 비교 시
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, board.getNum());
				rs = pstmt.executeQuery();

				if (rs.next()) { // 조회 결과가 존재할 경우
					// 패스워드 판별 작업 수행
					if (rs.getString("pass").equals(board.getPass())) { // 패스워드 일치 시
						// 2. 수정(UPDATE) 작업
						// => 번호에 해당하는 작성자, 제목, 내용 수정
						String sql1 = "UPDATE service SET name=?,subject=?,content=? WHERE num=?";
						pstmt2 = con.prepareStatement(sql1);
						pstmt2.setString(1, board.getName());
						pstmt2.setString(2, board.getSubject());
						pstmt2.setString(3, board.getContent());
						pstmt2.setInt(4, board.getNum());

						updateCount = pstmt2.executeUpdate();
					}
				}

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("SQL 구문오류");
			} finally {
				 JdbcUtil.close(pstmt);
				 JdbcUtil.close(pstmt2);
				 JdbcUtil.close(con);
				
			}

			return updateCount;
		}
		//service_deletePRP
		public int deleteBoard(int num, String pass) {
			int deleteCount = 0;

			try {
				con = getConnection();
				// 글번호와 패스워드가 모두 일치하는 게시물 조회
				String sql = "SELECT * FROM service WHERE num=? AND pass=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, pass);
				rs = pstmt.executeQuery();
				if (rs.next()) {

					String sql1 = "DELETE FROM service WHERE num=?";
					pstmt2 = con.prepareStatement(sql1);
					pstmt2.setInt(1, num);
					deleteCount = pstmt2.executeUpdate();

				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JdbcUtil.close(pstmt2);
				 JdbcUtil.close(pstmt);
				 JdbcUtil.close(con);
				
			}

			return deleteCount;

		}
}
