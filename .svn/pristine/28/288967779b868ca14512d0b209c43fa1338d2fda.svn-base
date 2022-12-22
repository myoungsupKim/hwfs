<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID : 
■ 프로그램명   : 
■ 작성일자     : 
■ 작성자       : 
■ 이력관리     : 
* HISTORY    : 
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
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		DataSet ds_List, ds_ListTmp;
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT * FROM (   \n");
		
		//본사통합=Y 업장내역조회
		sbSql.append("SELECT A.MAIN_UPJANG, A.UPJANG																													\n");
		sbSql.append("	, DECODE(A.MAIN_UPJANG,A.UPJANG,'0','1')  AS BON_GB                                                                                             \n");
		sbSql.append("	, DECODE(A.MAIN_UPJANG,A.UPJANG,NULL,' - ')||A.UPJANGNM_DISP UPJANGNM_DISP                                                                      \n");
		sbSql.append("	, (CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS TOTAL_CREDIT -- 총여신      \n");
		sbSql.append("	, (CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS BASIC_CREDIT -- 기본여신    \n");
		sbSql.append("	, NVL(B.SCHD_AMT_MST,0) AS SCHD_AMT_MST -- 집계매입예정액                                                                                         \n");
		sbSql.append("	, NVL(B.CONFIRM_AMT_MST,0) AS CONFIRM_AMT_MST -- 집계매입확정액                                                                                   \n");
		sbSql.append("	, NVL(B.SCHD_AMT_SUBUL,0) AS SCHD_AMT_SUBUL -- 수불매입예정액                                                                                     \n");
		sbSql.append("	, NVL(B.CONFIRM_AMT_SUBUL,0) AS CONFIRM_AMT_SUBUL --수불매입확정액                                                                                \n");
		sbSql.append("	, (NVL(B.SCHD_AMT_MST,0) - NVL(B.SCHD_AMT_SUBUL,0)) AS SCHD_AMT_DIF -- 매입예정액차                                                               \n");
		sbSql.append("	, (NVL(B.CONFIRM_AMT_MST,0) - NVL(B.CONFIRM_AMT_SUBUL,0)) AS CONFIRM_AMT_DIF -- 매입확정액차                                                      \n");
		sbSql.append("	, (NVL(B.SCHD_AMT_MST,0) - NVL(B.SCHD_AMT_SUBUL,0))+(NVL(B.CONFIRM_AMT_MST,0) - NVL(B.CONFIRM_AMT_SUBUL,0)) AS AVAIL_CREDIT_DIF -- 가용여신차이   \n");
		sbSql.append("	, B.CALL_DATE                                                                                                                                   \n");
		sbSql.append("	, B.CDATE                                                                                                                                       \n");
		sbSql.append("  , A.HEAD_CREDIT_YN AS TOT_YN	 																												\n");
		sbSql.append("  , DECODE((NVL(B.SCHD_AMT_MST,0) - NVL(B.SCHD_AMT_SUBUL,0))+(NVL(B.CONFIRM_AMT_MST,0) - NVL(B.CONFIRM_AMT_SUBUL,0)), 0, 'N', 'Y') AS DIF_YN		\n");
		sbSql.append("  , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.PART_SALES_SABUN) AS PART_SALES_NM														\n");
		sbSql.append("  , (SELECT CC_NM FROM HLDC_SC_DEPT_V WHERE DEPT_ID = A.DEPT_ID) AS DEPT_NM																		\n");
		
		sbSql.append("FROM FMS_UPJANG A, CREDITAMT_SUM_MST_SUBUL B                                                                                                      \n");
		sbSql.append("WHERE 1=1                                                                                                                                         \n");
		sbSql.append("	AND A.UPJANG = B.UPJANG                                                                                                                         \n");
		sbSql.append("	AND A.HEAD_CREDIT_YN = 'Y' AND NVL(B.MODIFY_YN,'N') = ('N')																						\n");	
		//sbSql.append("	AND B.CALL_DATE = (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)																			\n");
		sbSql.append("	AND B.CALL_DATE = (																																	\n");
		sbSql.append("			CASE WHEN ((SELECT COUNT(*) FROM CREDITAMT_SUM_MST_SUBUL WHERE CALL_DATE = (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)) > 10000)	\n");
		sbSql.append("			THEN (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)																					\n");
		sbSql.append("			 ELSE (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL WHERE CALL_DATE NOT IN ((SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)))	\n");
		sbSql.append("			END )																																		\n");
		
		
		
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		    sbSql.append("AND    A.PART_SALES_SABUN =  '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
	       sbSql.append(" AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n"); 
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals(""))
		    sbSql.append("  AND B.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " AND HEAD_CREDIT_YN = 'Y') \n"); 
	    
		sbSql.append("   UNION ALL    ");
		
		//본사통합=N 업장내역조회
		sbSql.append("SELECT A.MAIN_UPJANG, A.UPJANG																													\n");
		sbSql.append("	, DECODE(A.MAIN_UPJANG,A.UPJANG,'0','1')  AS BON_GB                                                                                             \n");
		sbSql.append("	, A.UPJANGNM_DISP                                                                    \n");
		sbSql.append("	, (CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS TOTAL_CREDIT -- 총여신      \n");
		sbSql.append("	, (CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS BASIC_CREDIT -- 기본여신    \n");
		sbSql.append("	, NVL(B.SCHD_AMT_MST,0) AS SCHD_AMT_MST -- 집계매입예정액                                                                                         \n");
		sbSql.append("	, NVL(B.CONFIRM_AMT_MST,0) AS CONFIRM_AMT_MST -- 집계매입확정액                                                                                   \n");
		sbSql.append("	, NVL(B.SCHD_AMT_SUBUL,0) AS SCHD_AMT_SUBUL -- 수불매입예정액                                                                                     \n");
		sbSql.append("	, NVL(B.CONFIRM_AMT_SUBUL,0) AS CONFIRM_AMT_SUBUL --수불매입확정액                                                                                \n");
		sbSql.append("	, (NVL(B.SCHD_AMT_MST,0) - NVL(B.SCHD_AMT_SUBUL,0)) AS SCHD_AMT_DIF -- 매입예정액차                                                               \n");
		sbSql.append("	, (NVL(B.CONFIRM_AMT_MST,0) - NVL(B.CONFIRM_AMT_SUBUL,0)) AS CONFIRM_AMT_DIF -- 매입확정액차                                                      \n");
		sbSql.append("	, (NVL(B.SCHD_AMT_MST,0) - NVL(B.SCHD_AMT_SUBUL,0))+(NVL(B.CONFIRM_AMT_MST,0) - NVL(B.CONFIRM_AMT_SUBUL,0)) AS AVAIL_CREDIT_DIF -- 가용여신차이   \n");
		sbSql.append("	, B.CALL_DATE                                                                                                                                   \n");
		sbSql.append("	, B.CDATE                                                                                                                                       \n");
		sbSql.append("  , A.HEAD_CREDIT_YN AS TOT_YN	 																												\n");
		sbSql.append("  , DECODE((NVL(B.SCHD_AMT_MST,0) - NVL(B.SCHD_AMT_SUBUL,0))+(NVL(B.CONFIRM_AMT_MST,0) - NVL(B.CONFIRM_AMT_SUBUL,0)), 0, 'N', 'Y') AS DIF_YN		\n");
		sbSql.append("  , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.PART_SALES_SABUN) AS PART_SALES_NM														\n");
		sbSql.append("  , (SELECT CC_NM FROM HLDC_SC_DEPT_V WHERE DEPT_ID = A.DEPT_ID) AS DEPT_NM																		\n");
		
		sbSql.append("FROM FMS_UPJANG A, CREDITAMT_SUM_MST_SUBUL B                                                                                                      \n");
		sbSql.append("WHERE 1=1                                                                                                                                         \n");
		sbSql.append("	AND A.UPJANG = B.UPJANG                                                                                                                         \n");
		sbSql.append("	AND A.HEAD_CREDIT_YN = 'N'  AND NVL(B.MODIFY_YN,'N') = ('N')																					\n");	
		//sbSql.append("	AND B.CALL_DATE = (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)																			\n");
		sbSql.append("	AND B.CALL_DATE = (																																	\n");
		sbSql.append("			CASE WHEN ((SELECT COUNT(*) FROM CREDITAMT_SUM_MST_SUBUL WHERE CALL_DATE = (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)) > 10000)	\n");
		sbSql.append("			THEN (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)																					\n");
		sbSql.append("			 ELSE (SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL WHERE CALL_DATE NOT IN ((SELECT MAX(CALL_DATE) FROM CREDITAMT_SUM_MST_SUBUL)))	\n");
		sbSql.append("			END )																																		\n");
				
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
			sbSql.append(" AND A.PART_SALES_SABUN =  '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");	
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals(""))
			sbSql.append(" AND A.UPJANG IN ( SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " )  \n"); 
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
		    sbSql.append(" AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n"); 

		
		sbSql.append("  ) ORDER BY MAIN_UPJANG, BON_GB, TOT_YN, UPJANG     ");
		
		
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close(); 

		
		
		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>
