<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00270E_T001.jsp
■ 프로그램명   : 운영율 등록관리(조회)
■ 작성일자     : 2008.04.14
■ 작성자       : 박은규
■ 이력관리     : [고도화]_운영율 관련 수정_김경은
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
		sbSql.append("SELECT SUBSTR(A.CLASS_CODE,1,3) AS ITEM_CLASS2 \n");
		sbSql.append("     , (SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = SUBSTR(A.CLASS_CODE,1,3)) AS CLASS_NAME2 \n");
		sbSql.append("     , SUBSTR(A.CLASS_CODE,1,5) AS ITEM_CLASS3 \n");
		sbSql.append("     , (SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = SUBSTR(A.CLASS_CODE,1,5)) AS CLASS_NAME3 \n");
		sbSql.append("     , A.CLASS_CODE AS ITEM_CLASS4 \n");
		sbSql.append("     , A.CLASS_NAME AS CLASS_NAME4 \n");
		sbSql.append("     , TO_CHAR(TO_DATE(B.SDATE,'YYYYMMDD'),'YYYY-MM-DD') AS PRE_SDATE \n");
		sbSql.append("     , B.OP_RATE AS PRE_OP_RATE \n");
		sbSql.append("     , B.CEIL_VAL AS PRE_CEIL_VAL \n");
// 		sbSql.append("     , NVL(C.OP_RATE,0) AS OP_RATE \n");
		sbSql.append("     , C.OP_RATE \n");
		sbSql.append("     , NVL(C.CEIL_VAL,1) AS CEIL_VAL \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.EDATE,'YYYYMMDD'),'YYYY-MM-DD') AS EDATE \n");
		sbSql.append("     , DECODE(C.OP_RATE, NULL, 'N', 'Y') AS SAVE_YN \n");
		sbSql.append("     , C.CUSER\n");
		sbSql.append("     , TO_CHAR(C.CDATE,'YYYY-MM-DD HH24:MI:SS') AS CDATE \n");
		sbSql.append("     , C.UUSER\n");
		sbSql.append("     , TO_CHAR(C.UDATE,'YYYY-MM-DD HH24:MI:SS') AS UDATE \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS A \n");
		
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.CDATE, A.UDATE, A.CUSER, A.UUSER \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD')-1,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		sbSql.append("          AND A.SDATE > '00000000' \n");
		sbSql.append("          AND A.EDATE > '00000000' \n");
		sbSql.append("          AND A.ITEM_TYPE = 'C' \n");
		
		sbSql.append("          AND A.USE_YN = 'Y') B \n");
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.EDATE, A.CDATE, A.UDATE, A.CUSER, A.UUSER  \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("          AND A.ITEM_TYPE = 'C' \n");
		sbSql.append("          AND A.USE_YN = 'Y') C \n");
		
		sbSql.append(" WHERE A.CLASS_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CLASS_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CLASS_TYPE = 'D' \n");
		sbSql.append("   AND A.CLASS_CODE LIKE 'F%' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append("   AND SUBSTR(A.CLASS_CODE,1,3) NOT IN ('F28', 'F30', 'F50', 'F70') --반제품 자제 검색 안되게 \n");
		sbSql.append(" ORDER BY A.CLASS_CODE \n");

		out_vl.add("fa_Sql", sbSql.toString());
		
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

		//운영율 구분
		sbSql.append("SELECT 1 \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.OP_RATE_YN = 'C' \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if (! rs.next())
		{
			this.setResultMessage(-1, "해당 업장은 분류별 운영율 사용설정을 하지 않았습니다!", out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT SUBSTR(A.CLASS_CODE,1,4)||'0000' AS ITEM_CLASS2 \n");
		sbSql.append("     , (SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = SUBSTR(A.CLASS_CODE,1,4)||'0000') AS CLASS_NAME2 \n");
		sbSql.append("     , SUBSTR(A.CLASS_CODE,1,6)||'00' AS ITEM_CLASS3 \n");
		sbSql.append("     , (SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = SUBSTR(A.CLASS_CODE,1,6)||'00') AS CLASS_NAME3 \n");
		sbSql.append("     , A.CLASS_CODE AS ITEM_CLASS4 \n");
		sbSql.append("     , A.CLASS_NAME AS CLASS_NAME4 \n");
		sbSql.append("     , TO_CHAR(TO_DATE(B.SDATE,'YYYYMMDD'),'YYYY-MM-DD') AS PRE_SDATE \n");
		sbSql.append("     , B.OP_RATE AS PRE_OP_RATE \n");
		sbSql.append("     , B.CEIL_VAL AS PRE_CEIL_VAL \n");
		sbSql.append("     , NVL(C.OP_RATE,0) AS OP_RATE \n");
		sbSql.append("     , NVL(C.CEIL_VAL,1) AS CEIL_VAL \n");
		sbSql.append("     , TO_CHAR(TO_DATE(C.EDATE,'YYYYMMDD'),'YYYY-MM-DD') AS EDATE \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS A \n");
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.SDATE \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "','YYYYMMDD')-1,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE \n");
		sbSql.append("          AND A.SDATE > '00000000' \n");
		sbSql.append("          AND A.EDATE > '00000000' \n");
		sbSql.append("          AND A.USE_YN = 'Y') B \n");
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.EDATE \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("          AND A.USE_YN = 'Y') C \n");
		sbSql.append(" WHERE A.CLASS_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND A.CLASS_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND A.CLASS_TYPE = 'D' \n");
		sbSql.append("   AND (A.CLASS_CODE < '0130' OR A.CLASS_CODE LIKE '0190%') \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY A.CLASS_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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

--%>
