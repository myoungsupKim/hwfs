<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	Statement stmt             =  null;
	try 
	{	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
//		PGM_ID        프로그램ID        
//		PGM_NM        프로그램명        
//		MU_CD        MU코드        
//		MU_NM        MU명        
//		CC_CD        CC코드        
//		CC_NM        CC명        
//		DEPT_ID        DEPT코드        
//		SABUN        사용자사번        
//		NM_KOR        사용자명        
//		REMARK        비고        
//		CREATE_BY        생성자        
//		CREATE_DATE        생성일        
//		UPDATE_BY        수정자        
//		UPDATE_DATE        수정일        
		//입력 데이타
		DataSet ds_list     = in_dl.get("ds_list");		
		
		//'" + nullToBlank(ds_Cond.getString(0, "ROLE")) + "'
		//입력 파라메터		
		DataSet in_ds  =  in_dl.get("ds_list");

		int RowCnt = in_ds.getRowCount();
		
		StringBuffer sbSql = new StringBuffer();

//		System.out.println("DataSet : " + in_ds);


			//sbSql.append("INSERT INTO SC_USE_COUNT@FSTEST_IRIS_HLDC \n");
			sbSql.append("INSERT INTO HLDC_SC_USE_COUNT \n");
			sbSql.append("	  (PGM_ID, PGM_NM, MU_CD, MU_NM, CC_CD, CC_NM, DEPT_ID, SABUN, NM_KOR, CREATE_BY, CREATE_DATE )  \n"); 
			sbSql.append("    VALUES \n");
			sbSql.append("  	('" + nullToBlank(ds_list.getString(0, "PGM_ID")) + "' \n");
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "PGM_NM")) + "' \n");
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_Mu_Cd")) + "' \n");     // MU_CD
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_Mu_Nm")) + "' \n");     // MU_NM
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_Cc_Cd")) + "' \n");     // CC_CD
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_Cc_Nm")) + "' \n");     // CC_NM
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_Deptid")) + "' \n");    // DEPT_ID
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_EmpNo")) + "' \n");     // SABUN
			//제니퍼로 확인한 결과 긴데이터의 업장이름이 들어가는 경우가 있어서 SQL EXCEPTION이 떨어짐
			//따라서 데이터를 넣을때 크기에 맞게 잘라 넣는 로직추가(잘라서 넣어도 큰 문제 없음. 단순 카운트 계산)
			//2013년 10월 26일 박용대 수정
			//sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_Name")) + "' \n");      // NM_KOR
			sbSql.append("		, SUBSTRB('" + nullToBlank(ds_list.getString(0, "g_Name")) + "',1,20) \n");      // NM_KOR
			sbSql.append("		, '" + nullToBlank(ds_list.getString(0, "g_EmpNo")) + "' \n");     // CREATE_BY
			sbSql.append("		, SYSDATE)             \n"); // CREATE_DATE

			stmt =  conn.createStatement();
			stmt.execute(sbSql.toString());

			stmt.close();
		
		
	   conn.commit();
	   this.setResultMessage(0, "OK",out_vl);

		
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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