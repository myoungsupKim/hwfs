<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/강제레시피                                                                                                                                                                   
■ 프로그램ID   : FSR90100E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 강제레시피대상사업장 저장                                                                                                                                               
■ 작성일자     : 2015-02-23                                                                                                                                                                           
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;

	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo       = in_vl.getString("g_EmpNo");
		String UPJANG        = "";
		String UPJANGNM      = "";
		String START_DD      = "";
		String END_DD        = "";
		DataSet ds_upjangList = in_dl.get("ds_upjangList2");
		
		StringBuffer sbSql = new StringBuffer();
		int RowStatus;
		
		// 삭제
		int RowCnt = ds_upjangList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			UPJANG    = ds_upjangList.getRemovedData(i,"UPJANG").toString(); 
			START_DD  = ds_upjangList.getRemovedData(i,"START_DD").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSR_ENF_RECIPE_UPJANG             \n"); 
			sbSql.append(" WHERE UPJANG    = '" + UPJANG + "'      \n");
			sbSql.append("   AND START_DD  = '" + START_DD + "'    \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 등록
		RowCnt = ds_upjangList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_upjangList.getRowType(i);
			
			UPJANG    = nullToBlank(ds_upjangList.getString(i,"UPJANG"));
			UPJANGNM  = nullToBlank(ds_upjangList.getString(i,"UPJANGNM"));
			START_DD  = nullToBlank(ds_upjangList.getString(i,"START_DD"));
			END_DD    = nullToBlank(ds_upjangList.getString(i,"END_DD"));
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT COUNT(*) AS CNT \n");
				sbSql.append("  FROM FSR_ENF_RECIPE_UPJANG \n");
				sbSql.append(" WHERE UPJANG    = '" + UPJANG + "'      \n");
				sbSql.append("   AND START_DD  <= '" + END_DD + "' AND END_DD >= '" + START_DD + "'   \n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				rs.next();
				if(rs.getInt("CNT") > 0) {
					throw new Exception(UPJANGNM + " 사업장에 기간이 중복됩니다.\n확인하신 후 기간연장 또는 삭제 후 재등록 바랍니다.");
				}
				
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSR_ENF_RECIPE_UPJANG(UPJANG, START_DD, END_DD, CUSER, CDATE, UUSER, UDATE) \n");
				sbSql.append("VALUES (" + UPJANG + ", '" + START_DD + "', '" + END_DD + "', '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "', SYSDATE) \n");
				System.out.println(sbSql.toString());
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT COUNT(*) AS CNT \n");
				sbSql.append("  FROM FSR_ENF_RECIPE_UPJANG \n");
				sbSql.append(" WHERE UPJANG    = '" + UPJANG + "'      \n");
				sbSql.append("   AND START_DD  <> '" + START_DD + "'      \n");
				sbSql.append("   AND START_DD  <= '" + END_DD + "' AND END_DD >= '" + START_DD + "'   \n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				rs.next();
				if(rs.getInt("CNT") > 0) {
					throw new Exception(UPJANGNM + " 사업장에 기간이 중복됩니다.\n확인하신 후 기간연장 또는 삭제 후 재등록 바랍니다.");
				}
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSR_ENF_RECIPE_UPJANG             \n"); 
				sbSql.append("   SET END_DD    = '" + END_DD + "'      \n"); 
				sbSql.append("     , UUSER     = '" + g_EmpNo + "'     \n"); 
				sbSql.append("     , UDATE     = SYSDATE               \n"); 
				sbSql.append(" WHERE UPJANG    = '" + UPJANG + "'      \n");
				sbSql.append("   AND START_DD  = '" + START_DD + "'    \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}			
		}
		
		//트랜잭션 성공
		conn.commit();		
		this.setResultMessage(0, "OK", out_vl);
	
	} catch(Exception ex) {	
		ex.printStackTrace();
		//트랜잭션 실패
		conn.rollback();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
		this.setResultMessage(-1, ex.getMessage(),out_vl);
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}			
		
		if(pstmt != null) {
			try {
				stmt.close();
			}catch(Exception e) {}
		}
		if(stmt != null) {
			try {
				stmt.close();
			}catch(Exception e) {}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}	
	
    proc_output(response,out,out_vl,out_dl);

%>