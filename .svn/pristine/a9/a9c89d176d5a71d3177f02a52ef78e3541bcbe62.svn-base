<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00050V_T001.jsp
■ 프로그램명   : 본사 매출장려율 조회
■ 작성일자     : 2008-04-01
■ 작성자       : 박은규
■ 이력관리     : 2008-04-01
				 [고도화]_매출장려율 테이블 변경_김경은
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
		String sMainUpjang = nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG"));
		String sUPjang     = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String sSubinvCode = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT TO_CHAR(A.MAIN_UPJANG)||'  '||A.MAIN_UPJANGNM_DISP AS MAIN_UPJANG \n"); 
		sbSql.append("     , TO_CHAR(A.UPJANG)||'  '||A.UPJANGNM_DISP AS UPJANG \n");
		sbSql.append("     , A.SUBINV_CODE \n");
		sbSql.append("     , A.SUBINV_NAME \n");
		sbSql.append("     , A.CLASS_CODE \n");
		sbSql.append("     , A.CLASS_NAME \n");
		sbSql.append("     , NVL(F.FM_SALE_RATE, E.FM_SALE_RATE) AS FM_SALE_RATE \n"); 
		sbSql.append("     , NVL(F.FM_NOSALE_RATE, E.FM_NOSALE_RATE) AS FM_NOSALE_RATE \n");
		sbSql.append("     , NVL(F.SDATE, E.SDATE) AS SDATE \n");
		sbSql.append("     , NVL(F.EDATE, E.EDATE) As EDATE \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT A.MAIN_UPJANG \n");
		sbSql.append("             , B.UPJANGNM_DISP AS MAIN_UPJANGNM_DISP \n");
		sbSql.append("             , A.UPJANG \n");
		sbSql.append("             , A.UPJANGNM_DISP \n");
		sbSql.append("             , C.SUBINV_CODE \n");
		sbSql.append("             , C.SUBINV_NAME \n");
		sbSql.append("             , D.CLASS_CODE \n");
		sbSql.append("             , D.CLASS_NAME \n");
		sbSql.append("          FROM FMS_UPJANG A \n");                                                  
		sbSql.append("             , FMS_UPJANG B \n");                                                  
		sbSql.append("             , HLDC_PO_SUBINVENTORY C \n");                                        
		sbSql.append("             , HLDC_PO_ITEM_CLASS D \n"); 
		sbSql.append("         WHERE A.MAIN_UPJANG = B.UPJANG \n");                                      
		sbSql.append("           AND A.UPJANG = C.UPJANG \n");                                           
		sbSql.append("           AND D.CLASS_TYPE = 'D' \n");                                            
		sbSql.append("           AND D.CLASS_CODE LIKE 'F%' \n");  
		sbSql.append("        ) A \n");
		sbSql.append("     , ( SELECT * \n");                                                    
		sbSql.append("           FROM FMS_SALE_RATE -- 소분류 \n");                              
		sbSql.append("          WHERE CASH_CODE = '003' -- 장려금 \n");                          
		sbSql.append("            AND LENGTH(ITEM_CLASS) = 5 \n");                               
		sbSql.append("            AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");             
		sbSql.append("            AND USE_YN = 'Y' \n");                                         
		sbSql.append("       ) E \n");                                                           
		sbSql.append("     , ( SELECT * \n");                                                    
		sbSql.append("           FROM FMS_SALE_RATE -- 세분류 \n");                              
		sbSql.append("          WHERE CASH_CODE = '003' -- 장려금 \n");                          
		sbSql.append("            AND LENGTH(ITEM_CLASS) = 7 \n");                               
		sbSql.append("            AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");             
		sbSql.append("            AND USE_YN = 'Y' \n");                                         
		sbSql.append("       ) F \n"); 
		sbSql.append(" WHERE 1=1 \n");
		
		if (! sMainUpjang.equals(""))
			sbSql.append("   AND A.MAIN_UPJANG = " + sMainUpjang + "   \n");
		if (! sUPjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + sUPjang + "            \n");
		if (! sSubinvCode.equals(""))
			sbSql.append("   AND A.SUBINV_CODE = '" + sSubinvCode + "' \n");
		
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");                  
		sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");                  
		sbSql.append("   AND SUBSTR(A.CLASS_CODE, 1, 5) = E.ITEM_CLASS(+) \n");                  
		sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN E.SDATE(+) AND E.EDATE(+) \n"); 
		sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");                  
		sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) \n");                  
		sbSql.append("   AND A.CLASS_CODE = F.ITEM_CLASS(+) \n");                                
		sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN F.SDATE(+) AND F.EDATE(+) \n"); 
		sbSql.append(" ORDER BY A.UPJANG, A.SUBINV_CODE, A.CLASS_CODE \n"); 
		
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

<%--
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
		String sMainUpjang = nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG"));
		String sUPjang     = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String sSubinvCode = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT /*+ USE_HASH(E)*/                                             \n"); 
		sbSql.append("       TO_CHAR(A.MAIN_UPJANG)||'  '||B.UPJANGNM_DISP AS MAIN_UPJANG  \n");
		sbSql.append("     , TO_CHAR(A.UPJANG)||'  '||A.UPJANGNM_DISP AS UPJANG            \n");
		sbSql.append("     , C.SUBINV_CODE                                                 \n");
		sbSql.append("     , C.SUBINV_NAME                                                 \n");
		sbSql.append("     , D.CLASS_CODE                                                  \n");
		sbSql.append("     , D.CLASS_NAME                                                  \n");
		sbSql.append("     , NVL(F.FM_SALE_RATE, E.FM_SALE_RATE) AS FM_SALE_RATE           \n");
		sbSql.append("     , NVL(F.FM_NOSALE_RATE, E.FM_NOSALE_RATE) AS FM_NOSALE_RATE     \n");
		sbSql.append("     , NVL(F.SDATE, E.SDATE) AS SDATE                                \n");
		sbSql.append("     , NVL(F.EDATE, E.EDATE) As EDATE                                \n");
		sbSql.append("  FROM FMS_UPJANG A                                                  \n");
		sbSql.append("     , FMS_UPJANG B                                                  \n");
		sbSql.append("     , HLDC_PO_SUBINVENTORY C                                        \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS D                                          \n");
		sbSql.append("     , ( SELECT *                                                    \n");
		sbSql.append("           FROM FMS_SALE_RATE -- 소분류                              \n");
		sbSql.append("          WHERE CASH_CODE = '003' -- 장려금                          \n");
		sbSql.append("            AND LENGTH(ITEM_CLASS) = 5                               \n");
		sbSql.append("            AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0)             \n");
		sbSql.append("            AND USE_YN = 'Y'                                         \n");
		sbSql.append("       ) E                                                           \n");
		sbSql.append("     , ( SELECT *                                                    \n");
		sbSql.append("           FROM FMS_SALE_RATE -- 세분류                              \n");
		sbSql.append("          WHERE CASH_CODE = '003' -- 장려금                          \n");
		sbSql.append("            AND LENGTH(ITEM_CLASS) = 7                               \n");
		sbSql.append("            AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0)             \n");
		sbSql.append("            AND USE_YN = 'Y'                                         \n");
		sbSql.append("       ) F                                                           \n");
		sbSql.append(" WHERE A.MAIN_UPJANG = B.UPJANG                                      \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG                                           \n");
		
		if (! sMainUpjang.equals(""))
			sbSql.append("   AND A.MAIN_UPJANG = " + sMainUpjang + "   \n");
		if (! sUPjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + sUPjang + "            \n");
		if (! sSubinvCode.equals(""))
			sbSql.append("   AND C.SUBINV_CODE = '" + sSubinvCode + "' \n");
		
		sbSql.append("   AND D.CLASS_TYPE = 'D'                                            \n");
		sbSql.append("   AND D.CLASS_CODE LIKE 'F%'                                        \n");
		
		sbSql.append("   AND A.UPJANG = E.UPJANG(+)                  \n");
		sbSql.append("   AND C.SUBINV_CODE = E.SUBINV_CODE(+)                  \n");
		sbSql.append("   AND SUBSTR(D.CLASS_CODE, 1, 5) = E.ITEM_CLASS(+)                  \n");
		sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		

		sbSql.append("   AND A.UPJANG = F.UPJANG(+)                  \n");
		sbSql.append("   AND C.SUBINV_CODE = F.SUBINV_CODE(+)                  \n");
		sbSql.append("   AND D.CLASS_CODE = F.ITEM_CLASS(+)                                \n");
		sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
		
		sbSql.append(" ORDER BY C.SUBINV_CODE, D.CLASS_CODE                                \n");
		
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

--%>

<%--
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
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT TO_CHAR(A.MAIN_UPJANG)||'  '||B.UPJANGNM_DISP AS MAIN_UPJANG \n");
		sbSql.append("     , TO_CHAR(A.UPJANG)||'  '||A.UPJANGNM_DISP AS UPJANG \n");
		sbSql.append("     , C.SUBINV_CODE, C.SUBINV_NAME, D.FM_SALE_RATE, SUBSTR(D.ITEM_CLASS,1,6)||'00' AS ITEM_CLASS  \n");
		sbSql.append("     , (SELECT F.CLASS_NAME3  FROM HLDC_PO_ITEM_CLASS_FULL_HLDC_V F WHERE F.CLASS_CODE3 = D.ITEM_CLASS GROUP BY F.CLASS_NAME3) AS CLASS_NAME, D.FM_NOSALE_RATE \n");		
		sbSql.append("     , D.SDATE, D.EDATE \n");
		sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG B, HLDC_PO_SUBINVENTORY C \n");
		sbSql.append("     , HLDC_FM_SALE_RATE D \n");
		sbSql.append(" WHERE A.MAIN_UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG \n");
		sbSql.append("   AND C.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN D.SDATE(+) AND D.EDATE(+)  \n");
		sbSql.append("   AND C.USE_YN(+) = 'Y' \n");		
		
		String sMainUpjang = nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG"));
		String sUPjang     = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String sSubinvCode = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));
		if (! sMainUpjang.equals(""))
			sbSql.append("   AND A.MAIN_UPJANG = " + sMainUpjang + " \n");
		if (! sUPjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + sUPjang + " \n");
		if (! sSubinvCode.equals(""))
			sbSql.append("   AND C.SUBINV_CODE = '" + sSubinvCode + "' \n");
		sbSql.append(" ORDER BY A.MAIN_UPJANG, A.UPJANG, C.SUBINV_CODE, D.SDATE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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

--%>