<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 위생관리 > 건강진단결과 관리
 - ViewPage    : FSC00100E.xml 
 - Description : 건강진단결과 저장
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 21 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN Valiables
		String sUpjang = in_vl.getString("UPJANG");
		String sEmpNo  = in_vl.getString("EMP_NO");
		
		// IN DataSet
		DataSet ds_List = in_dl.get("ds_List");


		// 임시 데이터셋
		DataSet ds_Temp;
		
		// sql에서 사용할 statement를 선언
		PreparedStatement psInsert = null;
		PreparedStatement psUpdate = null;
		
		// SELECT Query
		StringBuffer sbSelectQuery = new StringBuffer();
		sbSelectQuery.setLength(0);
		sbSelectQuery.append("\nSELECT COUNT(SABUN)	RCNT		");
		sbSelectQuery.append("\n  FROM FSC_HEALTH_CHECK			");
		sbSelectQuery.append("\n WHERE UPJANG = ?				");
		sbSelectQuery.append("\n   AND SABUN = ?				");
		pstmt = conn.prepareStatement(sbSelectQuery.toString());
		
		// INSERT Query
		StringBuffer sbInsertQuery = new StringBuffer();
		sbInsertQuery.setLength(0);
		sbInsertQuery.append("\nINSERT INTO FSC_HEALTH_CHECK(UPJANG, SABUN, JIK_KUN, CHECK_DATE, CHECK_TERM,				");
		sbInsertQuery.append("\n                             END_DD, FIRST_INFORM, SECOND_INFORM, THIRD_INFORM, CHECK_ITEM,	");
		sbInsertQuery.append("\n                             ADD_CHECK, CHECK_RESULT, CHARG_TERM, REMARK, CUSER,			");
		sbInsertQuery.append("\n                             CDATE, HLTH_CHK_DD, HLTH_CHK_YN)  						        ");
		sbInsertQuery.append("\n                      VALUES(?, ?, ?, ?, ?,													");
		sbInsertQuery.append("\n                             ?, ?, ?, ?, ?,													");
		sbInsertQuery.append("\n                             ?, DECODE(?, '0', '0', '1'), ?, ?, ?,							");
		sbInsertQuery.append("\n                             SYSDATE, ?, ?)													");
		psInsert = conn.prepareStatement(sbInsertQuery.toString());
		
		// UPDATE Query
		StringBuffer sbUpdateQuery = new StringBuffer();
		sbUpdateQuery.setLength(0);
		sbUpdateQuery.append("\nUPDATE FSC_HEALTH_CHECK			");
		sbUpdateQuery.append("\n   SET JIK_KUN = ?,				");
		sbUpdateQuery.append("\n       CHECK_DATE = ?,			");
		sbUpdateQuery.append("\n       CHECK_TERM = ?,			");
		sbUpdateQuery.append("\n       END_DD = ?,				");
		sbUpdateQuery.append("\n       FIRST_INFORM = ?,		");
		sbUpdateQuery.append("\n       SECOND_INFORM = ?,		");
		sbUpdateQuery.append("\n       THIRD_INFORM = ?,		");
		sbUpdateQuery.append("\n       CHECK_ITEM = ?,			");
		sbUpdateQuery.append("\n       ADD_CHECK = ?,			");
		sbUpdateQuery.append("\n       CHECK_RESULT = ?,		");
		sbUpdateQuery.append("\n       CHARG_TERM = ?,			");
		sbUpdateQuery.append("\n       REMARK = ?,				");
		sbUpdateQuery.append("\n       UUSER = ?,				");
		sbUpdateQuery.append("\n       UDATE = SYSDATE,			");
		sbUpdateQuery.append("\n       HLTH_CHK_DD = ?,			");
		sbUpdateQuery.append("\n       HLTH_CHK_YN = ?			");
		sbUpdateQuery.append("\n WHERE UPJANG = ?				");
		sbUpdateQuery.append("\n   AND SABUN = ?				");
		psUpdate = conn.prepareStatement(sbUpdateQuery.toString());
		
		// 결과 체크용 변수
		int iTotCnt = ds_List.getRowCount();
		int iSucCnt = 0;
		
		for( int i=0; i<iTotCnt; i++ ) {
			// Set PrepareStatement Parameters
			pstmt.setInt(1, ds_List.getInt(i, "UPJANG"));
			pstmt.setString(2, ds_List.getString(i, "SABUN")          );
			
			rs = pstmt.executeQuery();
			rs.next();
			
			// 기존 데이터가 있는 경우 -> UPDATE
			if( rs.getInt("RCNT") != 0 ) {
				psUpdate.setString(1,  nullToBlank(ds_List.getString(i, "JIK_KUN")));
				psUpdate.setString(2,  nullToBlank(ds_List.getString(i, "CHECK_DATE")));
				psUpdate.setString(3,  nullToBlank(ds_List.getString(i, "CHECK_TERM")));
				psUpdate.setString(4,  nullToBlank(ds_List.getString(i, "END_DD")));
				psUpdate.setString(5,  nullToBlank(ds_List.getString(i, "FIRST_INFORM")));
				psUpdate.setString(6,  nullToBlank(ds_List.getString(i, "SECOND_INFORM")));
				psUpdate.setString(7,  nullToBlank(ds_List.getString(i, "THIRD_INFORM")));
				psUpdate.setString(8,  nullToBlank(ds_List.getString(i, "CHECK_ITEM")));
				psUpdate.setString(9,  nullToBlank(ds_List.getString(i, "ADD_CHECK")));
				psUpdate.setString(10, nullToBlank(ds_List.getString(i, "CHECK_RESULT")));
				psUpdate.setString(11, nullToBlank(ds_List.getString(i, "CHARG_TERM")));
				psUpdate.setString(12, nullToBlank(ds_List.getString(i, "REMARK")));
				psUpdate.setString(13, sEmpNo                                            );
				psUpdate.setString(14, nullToBlank(ds_List.getString(i, "HLTH_CHK_DD")));
				psUpdate.setString(15, nullToBlank(ds_List.getString(i, "HLTH_CHK_YN")));
				psUpdate.setInt(16,    ds_List.getInt(i, "UPJANG"));
				psUpdate.setString(17, ds_List.getString(i,  "SABUN")            );
				
				System.out.println(ds_List.getInt(i, "UPJANG"));
				System.out.println(ds_List.getString(i,  "SABUN"));
				
				iSucCnt += psUpdate.executeUpdate();
			} else {	// 기존 데이터가 없는 경우 -> INSERT
				psInsert.setInt(1,     ds_List.getInt(i, "UPJANG"));
				psInsert.setString(2,  ds_List.getString(i, "SABUN")             );
				psInsert.setString(3,  nullToBlank(ds_List.getString(i, "JIK_KUN")));
				psInsert.setString(4,  nullToBlank(ds_List.getString(i, "CHECK_DATE")));
				psInsert.setString(5,  nullToBlank(ds_List.getString(i, "CHECK_TERM")));
				psInsert.setString(6,  nullToBlank(ds_List.getString(i, "END_DD")));
				psInsert.setString(7,  nullToBlank(ds_List.getString(i, "FIRST_INFORM")));
				psInsert.setString(8,  nullToBlank(ds_List.getString(i, "SECOND_INFORM")));
				psInsert.setString(9,  nullToBlank(ds_List.getString(i, "THIRD_INFORM")));
				psInsert.setString(10, nullToBlank(ds_List.getString(i, "CHECK_ITEM")));
				psInsert.setString(11, nullToBlank(ds_List.getString(i, "ADD_CHECK")));
				psInsert.setString(12, nullToBlank(ds_List.getString(i, "CHECK_RESULT")));
				psInsert.setString(13, nullToBlank(ds_List.getString(i, "CHARG_TERM")));
				psInsert.setString(14, nullToBlank(ds_List.getString(i, "REMARK")));
				psInsert.setString(15, sEmpNo                                            );
				psInsert.setString(16, nullToBlank(ds_List.getString(i, "HLTH_CHK_DD")));
				psInsert.setString(17, nullToBlank(ds_List.getString(i, "HLTH_CHK_YN")));
				
				iSucCnt += psInsert.executeUpdate();
			}
		}
		
		if( iSucCnt == iTotCnt ) {
			conn.commit();
		} else {
			throw new Exception("iSucCnt != iTotCnt");
		}
		out_dl.add(ds_List);
	   	this.setResultMessage(0, "OK", out_vl);
	   	
	} catch(Exception ex) {
	   ex.printStackTrace();
       this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			}catch(Exception e) {}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		proc_output(response,out,out_vl,out_dl);
	}
%>
