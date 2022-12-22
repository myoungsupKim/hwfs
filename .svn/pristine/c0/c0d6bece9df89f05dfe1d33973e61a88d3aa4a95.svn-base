<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 시스템공통 > 공통코드 > 권한별 프로그램 구성
 - ViewPage    : SCC00060E.xml 
 - Description : 프로그램별 권한 리스트 저장
 - Author      : 손 창 덕
 - History     : 1) 2008. 04. 11 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility,  com.ifis.sc.scc.CommonUtil"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN DataSet
		DataSet ds_Input       = in_dl.get("ds_Input"      );
		DataSet ds_ProgramRole = in_dl.get("ds_ProgramRole");
		
		// IN Variables
		String sEmpNo = in_vl.getString("EMP_NO");
	

		int iTotUpdateCnt = ds_ProgramRole.getRowCount();
		int iTotDeleteCnt = ds_ProgramRole.getRemovedRowCount();
		int iTotCnt = iTotUpdateCnt + iTotDeleteCnt;
		int iSucCnt = 0;
		
		System.out.println("iTotDeleteCnt="+iTotDeleteCnt);
		System.out.println("iTotUpdateCnt="+iTotUpdateCnt);
		
		StringBuffer sbInsertQuery = new StringBuffer();
		StringBuffer sbUpdateQuery = new StringBuffer();
		StringBuffer sbDeleteQuery = new StringBuffer();
		
		PreparedStatement pstmtInsert = null;
		PreparedStatement pstmtUpdate = null;
		PreparedStatement pstmtDelete = null;
		
		// INSERT Query Setting
		sbInsertQuery.setLength(0);
		sbInsertQuery.append("\nINSERT INTO SCC_ROLE_MENU(SYS_TYPE, ROLE, MENU_ID,							");
		sbInsertQuery.append("\n                          SRC_YN, PRT_YN, EXL_YN, INS_YN, DEL_YN, SAV_YN, PRSINF_YN, 	");
		sbInsertQuery.append("\n                          USE_YN, CUSER, CDATE, UUSER, UDATE)				");
		sbInsertQuery.append("\n                  VALUES (?, ?, ?,											");
		sbInsertQuery.append("\n                          DECODE(?, '1', 'Y', 'N'),							");
		sbInsertQuery.append("\n                          DECODE(?, '1', 'Y', 'N'),							");
		sbInsertQuery.append("\n                          DECODE(?, '1', 'Y', 'N'),							");
		sbInsertQuery.append("\n                          DECODE(?, '1', 'Y', 'N'),							");
		sbInsertQuery.append("\n                          DECODE(?, '1', 'Y', 'N'),							");
		sbInsertQuery.append("\n                          DECODE(?, '1', 'Y', 'N'),							");
		sbInsertQuery.append("\n                          DECODE(?, '1', 'Y', 'N'),							");
		sbInsertQuery.append("\n                          'Y', ?, SYSDATE, ?, SYSDATE)						");
		
		pstmtInsert = conn.prepareStatement(sbInsertQuery.toString());
		
		// UPDATE Query Setting
		sbUpdateQuery.setLength(0);
		sbUpdateQuery.append("\nUPDATE SCC_ROLE_MENU						");
		sbUpdateQuery.append("\n   SET SRC_YN = DECODE(?, '1', 'Y', 'N')	");
		sbUpdateQuery.append("\n     , PRT_YN = DECODE(?, '1', 'Y', 'N')	");
		sbUpdateQuery.append("\n     , EXL_YN = DECODE(?, '1', 'Y', 'N')	");
		sbUpdateQuery.append("\n     , INS_YN = DECODE(?, '1', 'Y', 'N')	");
		sbUpdateQuery.append("\n     , DEL_YN = DECODE(?, '1', 'Y', 'N')	");
		sbUpdateQuery.append("\n     , SAV_YN = DECODE(?, '1', 'Y', 'N')	");
		sbUpdateQuery.append("\n     , PRSINF_YN = DECODE(?, '1', 'Y', 'N')	");
		sbUpdateQuery.append("\n     , UUSER  = ?							");
		sbUpdateQuery.append("\n WHERE SYS_TYPE = ?							");
		sbUpdateQuery.append("\n   AND ROLE = ?								");
		sbUpdateQuery.append("\n   AND MENU_ID = ?							");
		
		pstmtUpdate = conn.prepareStatement(sbUpdateQuery.toString());
		
		// DELETE Query Setting
		sbDeleteQuery.setLength(0);
		sbDeleteQuery.append("\nDELETE FROM SCC_ROLE_MENU	");
		sbDeleteQuery.append("\n WHERE SYS_TYPE = ?			");
		sbDeleteQuery.append("\n   AND ROLE = ?				");
		sbDeleteQuery.append("\n   AND MENU_ID = ?			");
		
		pstmtDelete = conn.prepareStatement(sbDeleteQuery.toString());
		
		/* Delete1 */
		for( int j=0; j<iTotDeleteCnt; j++ ) {
			pstmtDelete.setString(1,  ds_ProgramRole.getRemovedData(j, "SYS_TYPE").toString()           );
			pstmtDelete.setString(2,  ds_ProgramRole.getRemovedData(j, "ROLE").toString()               );
			pstmtDelete.setInt(3,     ds_ProgramRole.getRemovedIntData(j, "MENU_ID"));
			
			iSucCnt += pstmtDelete.executeUpdate();
		}
		
		/* Insert / Update */
		for( int i=0; i<iTotUpdateCnt; i++ ) {
			if( ds_ProgramRole.getRowType(i) == DataSet.ROW_TYPE_INSERTED ) {
				pstmtInsert.setString(1,  ds_ProgramRole.getString(i, "SYS_TYPE")           );
				pstmtInsert.setString(2,  ds_ProgramRole.getString(i, "ROLE")               );
				pstmtInsert.setInt(3,     ds_ProgramRole.getInt(i, "MENU_ID"));
				pstmtInsert.setString(4,  ds_ProgramRole.getString(i, "SRC_YN")             );
				pstmtInsert.setString(5,  ds_ProgramRole.getString(i, "PRT_YN")             );
				pstmtInsert.setString(6,  ds_ProgramRole.getString(i, "EXL_YN")             );
				pstmtInsert.setString(7,  ds_ProgramRole.getString(i, "INS_YN")             );
				pstmtInsert.setString(8,  ds_ProgramRole.getString(i, "DEL_YN")             );
				pstmtInsert.setString(9,  ds_ProgramRole.getString(i, "SAV_YN")             );
				pstmtInsert.setString(10,  ds_ProgramRole.getString(i, "PRSINF_YN")             );
				pstmtInsert.setString(11, sEmpNo                                                    );
				pstmtInsert.setString(12, sEmpNo                                                    );
				
				iSucCnt += pstmtInsert.executeUpdate();
			} else if( ds_ProgramRole.getRowType(i) == DataSet.ROW_TYPE_UPDATED ) {
				pstmtUpdate.setString(1,  ds_ProgramRole.getString(i, "SRC_YN")             );
				pstmtUpdate.setString(2,  ds_ProgramRole.getString(i, "PRT_YN")             );
				pstmtUpdate.setString(3,  ds_ProgramRole.getString(i, "EXL_YN")             );
				pstmtUpdate.setString(4,  ds_ProgramRole.getString(i, "INS_YN")             );
				pstmtUpdate.setString(5,  ds_ProgramRole.getString(i, "DEL_YN")             );
				pstmtUpdate.setString(6,  ds_ProgramRole.getString(i, "SAV_YN")             );
				pstmtUpdate.setString(7,  ds_ProgramRole.getString(i, "PRSINF_YN")             );
				pstmtUpdate.setString(8,  sEmpNo                                                    );
				pstmtUpdate.setString(9,  ds_ProgramRole.getString(i, "SYS_TYPE")           );
				pstmtUpdate.setString(10,  ds_ProgramRole.getString(i, "ROLE")               );
				pstmtUpdate.setInt(11,    ds_ProgramRole.getInt(i, "MENU_ID"));
				
				iSucCnt += pstmtUpdate.executeUpdate();
			}
		}
		
		/* Transaction 처리 */
		if( iTotCnt == iSucCnt ) {
			conn.commit();
			this.setResultMessage(0, "OK", out_vl);
		} else {
			conn.rollback();
			this.setResultMessage(-1, "TOTAL COUNT와 UPDATE COUNT가 같지 않습니다.", out_vl);
		}
		
		/* PreparedStatement Close */
		if(pstmtInsert != null) {
			try {
				pstmtInsert.close();
			}catch(Exception e) {}
		}
		if(pstmtUpdate != null) {
			try {
				pstmtUpdate.close();
			}catch(Exception e) {}
		}
		if(pstmtDelete != null) {
			try {
				pstmtDelete.close();
			}catch(Exception e) {}
		}
		
	} catch(Exception ex) {
	   ex.printStackTrace();
       this.setResultMessage(-1, ex.toString(), out_vl);
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
		proc_output(response, out, out_vl, out_dl);
	}
%>