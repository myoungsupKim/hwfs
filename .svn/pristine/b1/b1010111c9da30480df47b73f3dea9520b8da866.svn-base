<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00290V_T001.jsp
■ 프로그램명   : 운영율 등록여부(조회)
■ 작성일자     : 2015.04.08
■ 작성자       : 김경은
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
		
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
		sbSql.append("SELECT A.MAIN_UPJANG \n");
		sbSql.append("     , (SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = A.MAIN_UPJANG) AS MAIN_UPJANG_DISP \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , A.UPJANGNM_DISP \n");
		sbSql.append("     , NVL(C.CLASS_CNT, 0) AS CLASS_CNT \n");
		sbSql.append("     , NVL(B.SAVE_CNT, 0) AS SAVE_CNT \n");
		sbSql.append("     , NVL(B.OP_RATE_AVG, 0) AS OP_RATE_AVG \n");
		//sbSql.append("     , DECODE(B.SAVE_CNT, NULL, DECODE(D.SAVE_CNT, NULL, 'N', 'Y'), 'Y') AS SAVE_YN \n");
		sbSql.append("     , DECODE(B.SAVE_CNT, NULL, 'N', 'Y') AS SAVE_YN \n");
		sbSql.append("     , DECODE(B.SDATE, NULL, D.SDATE, B.SDATE) AS SDATE \n");
		sbSql.append("     , DECODE(B.EDATE, NULL, D.EDATE, B.EDATE) AS EDATE \n");
		sbSql.append("     , TO_CHAR(DECODE(B.CDATE, NULL, D.CDATE, B.CDATE),'YYYY-MM-DD HH24:MI:SS') AS CDATE \n");
		sbSql.append("     , DECODE(B.CUSER, NULL, D.CUSER, B.CUSER) AS CUSER \n");
		sbSql.append("     , TO_CHAR(DECODE(B.UDATE, NULL, D.UDATE, B.UDATE),'YYYY-MM-DD HH24:MI:SS') AS UDATE \n");
		sbSql.append("     , DECODE(B.UUSER, NULL, D.UUSER, B.UUSER) AS UUSER \n");
		sbSql.append("     , NVL(D.SAVE_CNT, 0) AS ITEM_SAVE_CNT \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("     , (SELECT A.UPJANG, COUNT(1) AS SAVE_CNT, TRUNC(NVL(AVG(OP_RATE),0),1) AS OP_RATE_AVG \n");
		sbSql.append("             , A.SDATE, A.EDATE, MAX(A.CDATE) CDATE, MAX(A.CUSER) CUSER, MAX(A.UDATE) UDATE, MAX(A.UUSER) UUSER \n");
		sbSql.append("          FROM FMU_OP_RATE A \n");
		sbSql.append("         WHERE '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN A.SDATE AND A.EDATE \n");
		sbSql.append("           AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") \n");
		sbSql.append("           AND A.ITEM_TYPE = 'C' \n");
		sbSql.append("           AND A.ITEM_CODE LIKE 'F%' \n");
		sbSql.append("           AND SUBSTR(A.ITEM_CODE,1,3) NOT IN ('F70') --반제품 자제 검색 안되게 \n");
		sbSql.append("         GROUP BY A.UPJANG, A.SDATE, A.EDATE, A.CDATE, A.CUSER, A.UDATE, A.UUSER) B \n");
		sbSql.append("     , (SELECT COUNT(1) AS CLASS_CNT \n");
		sbSql.append("          FROM HLDC_PO_ITEM_CLASS A \n");
		sbSql.append("         WHERE A.CLASS_TYPE = 'D' \n");
		sbSql.append("           AND A.CLASS_CODE LIKE 'F%' \n");
		sbSql.append("           AND A.USE_YN = 'Y') C \n");
		sbSql.append("     , (SELECT A.UPJANG, COUNT(1) AS SAVE_CNT, MAX(A.SDATE) AS SDATE, MAX(A.EDATE) AS EDATE, MAX(A.CDATE) CDATE, MAX(A.CUSER) CUSER, MAX(A.UDATE) UDATE, MAX(A.UUSER) UUSER \n");                                                                 
		sbSql.append("               FROM FMU_OP_RATE A \n");                                                                    
		sbSql.append("              WHERE '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN A.SDATE AND A.EDATE \n"); 
		sbSql.append("                AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") \n"); 
		sbSql.append("                AND A.ITEM_TYPE = 'M' \n");                                                                
		sbSql.append("                AND A.ITEM_CODE LIKE 'F%' \n");                                                            
		sbSql.append("              GROUP BY A.UPJANG) D \n"); 
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY 1 \n");
		
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
