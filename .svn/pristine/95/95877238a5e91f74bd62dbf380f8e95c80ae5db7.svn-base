<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS식단/구매관리
■ 프로그램ID   : FSP00340V_T001.jsp
■ 프로그램명   : 업장별 매입금액분석
■ 작성일자     : 2010-01-01
■ 작성자       : 박은규
■ 이력관리     : 2010-01-01 CSR#(#####) 박은규 최초작성
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
		
		String MU_CD 			= nullToBlank(ds_Cond.getString(0, "MU_CD"));
		String TM_CD 			= nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String UPJANG 			= nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String TRANS_DATE_FR 	= nullToBlank(ds_Cond.getString(0, "TRANS_DATE_FR"));
		String TRANS_DATE_TO 	= nullToBlank(ds_Cond.getString(0, "TRANS_DATE_TO"));
		String ITEM_CLASS1 		= nullToBlank(ds_Cond.getString(0, "ITEM_CLASS1"));
		String ITEM_CLASS2 		= nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2"));
		String ITEM_CLASS3 		= nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3"));
		String ITEM_CLASS4 		= nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4"));
		String ITEM_NAME 		= nullToBlank(ds_Cond.getString(0, "ITEM_NAME"));  
		String FAMT 			= nullToBlank(ds_Cond.getString(0, "FAMT"));
		String TAMT 			= nullToBlank(ds_Cond.getString(0, "TAMT"));
	
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
		if (UPJANG.equals(""))
			sbSql.append("SELECT /*+ INDEX(A PO_TRANSACTION_PT_I6) */ \n");
		else
			sbSql.append("SELECT /*+ INDEX(A PO_TRANSACTION_PT_I8) */ \n");
		sbSql.append("       A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TRANS_UPJANG AS UPJANG \n");
		sbSql.append("     , (SELECT REPLACE(Z.UPJANGNM,'단체급식 ') FROM ST_UPJANG Z WHERE Z.UPJANG = A.TRANS_UPJANG) AS UPJANGNM \n");
		sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY), 2) AS TRANS_QTY \n");
		sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT), 0) AS TRANS_MAMOUNT \n");
		sbSql.append("     , DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
		sbSql.append("  FROM HLDC_PO_TRANSACTION A, HLDC_PO_ITEM_MST B \n");
		if (UPJANG.equals(""))
			sbSql.append("     , HLDC_SC_DEPT_V C \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		if (UPJANG.equals(""))
		{
			sbSql.append("   AND A.TRANS_DEPT_ID = C.DEPT_ID \n");
			sbSql.append("   AND C.MU_CD = '" + MU_CD + "' \n");
			if (!TM_CD.equals(""))
				sbSql.append("   AND C.TM_CD = '" + TM_CD + "' \n");
		}
		else
			sbSql.append("   AND A.TRANS_UPJANG = '" + UPJANG + "' \n");
		sbSql.append("   AND A.TRANS_DATE BETWEEN '" + TRANS_DATE_FR + "' AND '" + TRANS_DATE_TO + "' \n");
		sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("   AND B.ITEM_CLASS1 = 'F' \n");
		if (!ITEM_CLASS1.equals(""))
			sbSql.append("   AND B.ITEM_CLASS1 = '" + ITEM_CLASS1 + "' \n");
		if (!ITEM_CLASS2.equals(""))
			sbSql.append("   AND B.ITEM_CLASS2 = '" + ITEM_CLASS2 + "' \n");
		if (!ITEM_CLASS3.equals(""))
			sbSql.append("   AND B.ITEM_CLASS3 = '" + ITEM_CLASS3 + "' \n");
		if (!ITEM_CLASS4.equals(""))
			sbSql.append("   AND B.ITEM_CLASS4 = '" + ITEM_CLASS4 + "' \n");
		if (!ITEM_NAME.equals(""))
			sbSql.append("   AND A.ITEM_NAME LIKE '%" + ITEM_NAME + "%' \n");
		sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TRANS_UPJANG, DECODE(A.TAX_CODE, '100', '과세', '210', '면세', '영세') \n");
		if ((!FAMT.equals("")) && (!TAMT.equals("")))
		{
			sbSql.append(" HAVING SUM(A.TRANS_MAMOUNT) BETWEEN " + FAMT + " \n");
			sbSql.append("                                 AND " + TAMT + " \n");
		}
		else if (!FAMT.equals(""))
			sbSql.append(" HAVING SUM(A.TRANS_MAMOUNT) >= " + FAMT + " \n");
		else if (!FAMT.equals(""))
			sbSql.append(" HAVING SUM(A.TRANS_MAMOUNT) <= " + FAMT + " \n");
		
		sbSql.append(" ORDER BY A.ITEM_CODE, SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_MAMOUNT) DESC ");
		
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