<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/상품정보
■ 프로그램ID   : FMP00030V_T002.jsp
■ 프로그램명   : 주문통제 등록관리(저장)
■ 작성일자     : 2008-05-16
■ 작성자       : 박은규
■ 이력관리     : 2008-05-16
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);		
	
		//입력 데이타
		DataSet ds_List      = in_dl.get("ds_List");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));
		String sCtrlType    = nullToBlank(in_vl.getString("sCtrlType"));
		String sItemType    = nullToBlank(in_vl.getString("sItemType"));
		String sCenterCode  = nullToBlank(in_vl.getString("sCenterCode"));
		//FileLog.println("d:\\aaa.txt", ds_list);

/**
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//초기화
		sbSql.append("DELETE FROM FMP_ORD_CTRL A \n");
		sbSql.append(" WHERE A.CTRL_TYPE = '" + sCtrlType + "' \n");
		if (!sItemType.equals("%"))
			sbSql.append("   AND A.ITEM_TYPE = '" + sItemType + "' \n");
		if (sMainUpjang.equals("%"))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_UPJANG B WHERE B.UPJANG = A.UPJANG AND B.USE_YN = 'Y') \n");
		else
			sbSql.append("   AND A.UPJANG IN (SELECT B.UPJANG FROM FMS_UPJANG B WHERE B.MAIN_UPJANG = " + sMainUpjang + " AND B.USE_YN = 'Y') \n");
		if (! sCenterCode.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM VO_CENTER_UPJANG X, HLDC_ST_UPJANG Y WHERE X.CENTER_CODE = " + sCenterCode + " AND X.UPJANG = Y.AP_UNITPRICE_UPJANG AND Y.UPJANG = A.UPJANG) \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		
		pstmt.close();

		//재입력
		String sSql;
		sSql = "INSERT INTO FMP_ORD_CTRL(UPJANG, CTRL_TYPE, ITEM_TYPE, MON, TUE, WED, THU, FRI, SAT, SUN, CUSER, CDATE, UUSER, UDATE, REMARK)" +
               "VALUES (?,?,?,SCC_YN_FUN(?,'U'),SCC_YN_FUN(?,'U'),SCC_YN_FUN(?,'U'),SCC_YN_FUN(?,'U'),SCC_YN_FUN(?,'U'),SCC_YN_FUN(?,'U'),SCC_YN_FUN(?,'U'),?,SYSDATE,?,SYSDATE,?)";
		pstmt = conn.prepareStatement(sSql);
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			pstmt.setString(1, nullToBlank(ds_List.getString(i, "UPJANG")));
			pstmt.setString(2, sCtrlType);
			pstmt.setString(3, nullToBlank(ds_List.getString(i, "ITEM_TYPE")));
			pstmt.setString(4, nullToBlank(ds_List.getString(i, "MON")));
			pstmt.setString(5, nullToBlank(ds_List.getString(i, "TUE")));
			pstmt.setString(6, nullToBlank(ds_List.getString(i, "WED")));
			pstmt.setString(7, nullToBlank(ds_List.getString(i, "THU")));
			pstmt.setString(8, nullToBlank(ds_List.getString(i, "FRI")));
			pstmt.setString(9, nullToBlank(ds_List.getString(i, "SAT")));
			pstmt.setString(10, nullToBlank(ds_List.getString(i, "SUN")));
			pstmt.setString(11, g_EmpNo);
			pstmt.setString(12, g_EmpNo);
			pstmt.setString(13, nullToBlank(ds_List.getString(i, "REMARK")));
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		pstmt.executeBatch(); //배치처리
		pstmt.close();
**/
		StringBuffer sbSql = new StringBuffer();	
		sbSql.append("	MERGE INTO FMP_ORD_CTRL S	\n");
		sbSql.append("	    USING DUAL ON ( S.UPJANG = ? AND S.CTRL_TYPE = ? AND S.ITEM_TYPE = ? )	\n");
		sbSql.append("	    WHEN MATCHED THEN	\n");
		sbSql.append("	        UPDATE SET S.MON = SCC_YN_FUN(?,'U')	\n");
		sbSql.append("						, S.TUE = SCC_YN_FUN(?,'U')	\n");
		sbSql.append("						, S.WED = SCC_YN_FUN(?,'U')	\n");
		sbSql.append("						, S.THU = SCC_YN_FUN(?,'U')	\n");
		sbSql.append("						, S.FRI = SCC_YN_FUN(?,'U')	\n");
		sbSql.append("						, S.SAT = SCC_YN_FUN(?,'U')	\n");
		sbSql.append("						, S.SUN = SCC_YN_FUN(?,'U')	\n");
		sbSql.append("						, S.UUSER = ?	\n");
		sbSql.append("						, S.UDATE = SYSDATE	\n");
		sbSql.append("						, S.REMARK = ?	\n");		
		sbSql.append("	    WHEN NOT MATCHED THEN	\n");
		sbSql.append("	        INSERT (S.UPJANG, S.CTRL_TYPE, S.ITEM_TYPE, S.MON, S.TUE, S.WED, S.THU, S.FRI, S.SAT, S.SUN, S.CUSER, S.CDATE, S.UUSER, S.UDATE, S.REMARK)	\n");
		sbSql.append("	        VALUES (?, ?, ?	\n");
		sbSql.append("			        		, SCC_YN_FUN(?,'U'), SCC_YN_FUN(?,'U'), SCC_YN_FUN(?,'U'), SCC_YN_FUN(?,'U'), SCC_YN_FUN(?,'U'), SCC_YN_FUN(?,'U'), SCC_YN_FUN(?,'U')	\n");
		sbSql.append("							, ?, SYSDATE, ?, SYSDATE, ?)	\n");
		pstmt = conn.prepareStatement(sbSql.toString());
		
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			pstmt.setString(1, nullToBlank(ds_List.getString(i, "UPJANG")));
			pstmt.setString(2, sCtrlType);
			pstmt.setString(3, nullToBlank(ds_List.getString(i, "ITEM_TYPE")));
			pstmt.setString(4, nullToBlank(ds_List.getString(i, "MON")));
			pstmt.setString(5, nullToBlank(ds_List.getString(i, "TUE")));
			pstmt.setString(6, nullToBlank(ds_List.getString(i, "WED")));
			pstmt.setString(7, nullToBlank(ds_List.getString(i, "THU")));
			pstmt.setString(8, nullToBlank(ds_List.getString(i, "FRI")));
			pstmt.setString(9, nullToBlank(ds_List.getString(i, "SAT")));
			pstmt.setString(10, nullToBlank(ds_List.getString(i, "SUN")));
			pstmt.setString(11, g_EmpNo);
			pstmt.setString(12, nullToBlank(ds_List.getString(i, "REMARK")));
			
			pstmt.setString(13, nullToBlank(ds_List.getString(i, "UPJANG")));
			pstmt.setString(14, sCtrlType);
			pstmt.setString(15, nullToBlank(ds_List.getString(i, "ITEM_TYPE")));
			pstmt.setString(16, nullToBlank(ds_List.getString(i, "MON")));
			pstmt.setString(17, nullToBlank(ds_List.getString(i, "TUE")));
			pstmt.setString(18, nullToBlank(ds_List.getString(i, "WED")));
			pstmt.setString(19, nullToBlank(ds_List.getString(i, "THU")));
			pstmt.setString(20, nullToBlank(ds_List.getString(i, "FRI")));
			pstmt.setString(21, nullToBlank(ds_List.getString(i, "SAT")));
			pstmt.setString(22, nullToBlank(ds_List.getString(i, "SUN")));
			pstmt.setString(23, g_EmpNo);
			pstmt.setString(24, g_EmpNo);
			pstmt.setString(25, nullToBlank(ds_List.getString(i, "REMARK")));
			
			//차례로 sql문의 ? 위치에 맞게 변수를 대입하세요.
			pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
		}
		pstmt.executeBatch(); //배치처리
		pstmt.close();
		
		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);		
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>