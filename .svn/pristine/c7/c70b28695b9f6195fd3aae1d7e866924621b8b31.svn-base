<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30220E_T001.jsp
■ 프로그램명   : 월추정 관리
■ 작성일자     : 2015-08-31
■ 작성자       : 김태윤
■ 이력관리     : 
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

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT C.UPJANGNM, C.UPJANG, A.ACCT_CLASS, A.ACCT_NM, A.ACCT_CD, A.YY, B.CONFIRM_YN	\n");
		sbSql.append("      ,ROUND(A.MM_AMT_01 / 1000) AS MM_AMT_01											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_02 / 1000) AS MM_AMT_02											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_03 / 1000) AS MM_AMT_03											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_04 / 1000) AS MM_AMT_04											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_05 / 1000) AS MM_AMT_05											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_06 / 1000) AS MM_AMT_06											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_07 / 1000) AS MM_AMT_07											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_08 / 1000) AS MM_AMT_08											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_09 / 1000) AS MM_AMT_09											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_10 / 1000) AS MM_AMT_10											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_11 / 1000) AS MM_AMT_11											\n");
		sbSql.append("      ,ROUND(A.MM_AMT_12 / 1000) AS MM_AMT_12											\n");
		sbSql.append("		,NVL(ROUND(( A.MM_AMT_01      			  										\n");
		sbSql.append("					+A.MM_AMT_02  														\n");
		sbSql.append("					+A.MM_AMT_03  														\n");
		sbSql.append("					+A.MM_AMT_04  														\n");
		sbSql.append("					+A.MM_AMT_05  														\n");
		sbSql.append("					+A.MM_AMT_06  														\n");
		sbSql.append("					+A.MM_AMT_07  														\n");
		sbSql.append("					+A.MM_AMT_08  														\n");
		sbSql.append("					+A.MM_AMT_09  														\n");
		sbSql.append("					+A.MM_AMT_10  														\n");
		sbSql.append("					+A.MM_AMT_11  														\n");
		sbSql.append("					+A.MM_AMT_12  														\n");
		sbSql.append("  			  ) / 1000 ), 0)  SUM_AMT												\n");			
		sbSql.append("      , A.VER_CD, A.CC_CD, A.JOB_GRADE_CD, A.JOB_GRADE_NM								\n");
		sbSql.append("  FROM MAP_MON_PLAN2 A  																\n");
        sbSql.append(" 		,MAP_MON_LOG_MGMT2 B 															\n");
        sbSql.append(" 		,ST_UPJANG C 																	\n");
        sbSql.append("      ,(																				\n");
		sbSql.append(" 		 SELECT *								  										\n");
		sbSql.append(" 		  FROM MAP_MARGIN_RATE_MGMT														\n");
		sbSql.append(" 		 WHERE UPJANG IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG      \n");                                                                           
		sbSql.append("                           AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'  \n");
		sbSql.append("                           AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  				\n");
		sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'				\n");
		sbSql.append(" 		   AND CLASS = '" + "P" + "'													\n");
		sbSql.append(" 		 ) D 																			\n");
		sbSql.append(" WHERE A.TM_CD = B.TM_CD		 														\n");
		sbSql.append("   AND A.SABUN = B.SABUN 																\n");
		sbSql.append("   AND A.YY = B.YY 																	\n");
		sbSql.append("   AND A.UPJANG = C.UPJANG															\n");
		/*
		sbSql.append("   AND A.UPJANG  IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG      \n");                                                                           
		sbSql.append("                        AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'  \n");
		sbSql.append("                        AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  				  \n");
		*/
		sbSql.append("   AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'					\n");
		sbSql.append("   AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'					\n");
		sbSql.append("   AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'					\n");
		sbSql.append("   AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'		\n");
		sbSql.append("   AND B.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS2")) + "'		\n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+)															\n");
		sbSql.append(" ORDER BY A.UPJANG, A.ACCT_CD, A.CC_CD												\n");
		
out_vl.add("fa_Sql", sbSql.toString());

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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