<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 도소매관리/입고내역조회
■ 프로그램ID   : FMW00201V_T001.jsp
■ 프로그램명   : 입고내역조회
■ 작성일자     : 2011.02.09
■ 작성자       : 황승한
■ 이력관리     : 2011.02.09
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
		DataSet ds_Condput     	= in_dl.get("ds_Cond");
	
		String strUpjang       = nullToBlank(ds_Condput.getString(0, "UPJANG"));
		String strOtcustcd     = nullToBlank(ds_Condput.getString(0, "OTCUSTCD"));
		String strClass_code_s = nullToBlank(ds_Condput.getString(0, "CLASS_CODE_S"));
		
		String strDATEF		    = nullToBlank(ds_Condput.getString(0, "DATEF"));
		String strDATET		    = nullToBlank(ds_Condput.getString(0, "DATET"));
		
		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
			
    sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS TRANS_DATE \n");
    sbSql.append("     , A.UPJANG, A.HALL_CODE \n");    
    sbSql.append("     , (SELECT OTCUSTNM FROM (SELECT OTCUSTCD, OTCUSTNM FROM FMW_OTCUST  WHERE (1=1)	 AND USE_YN = 'Y' AND UPJANG =  " + strUpjang + "  UNION ALL SELECT '0000' AS OTCUSTCD, '한화호텔&리조트' AS OTCUSTNM FROM DUAL) WHERE OTCUSTCD = B.OTCUSTCD) AS OTCUSTNM \n");    
    sbSql.append("     , (SELECT Z.HALL_NAME FROM FMW_HALL Z WHERE Z.HALL_CODE = A.HALL_CODE AND Z.UPJANG = A.UPJANG) AS HALL_NAME \n");
    sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME \n");
    sbSql.append("     , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
    sbSql.append("     , (CASE WHEN SIGN(A.TRANS_QTY) = -1 THEN '반품' ELSE '정상입고' END) AS TRANS_TYPENM \n");
    sbSql.append("     , A.TRANS_QTY \n");
    sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1) AS AMOUNT_BOX \n");
    sbSql.append("     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1) AS AMOUNT_BONG \n");
    sbSql.append("     , (A.AVG_PRICE * B.ITEM_SIZE_BONG) AS PRICE_BOX \n");
    sbSql.append("     , A.AVG_PRICE AS PRICE_BONG \n");
    sbSql.append("     , DECODE(B.TAX_CODE,100,ROUND(A.AVG_AMOUNT/1.1),A.AVG_AMOUNT) AS AMT \n");
    sbSql.append("     , DECODE(B.TAX_CODE,100,(A.AVG_AMOUNT -ROUND(A.AVG_AMOUNT/1.1)),0) AS VAT \n");
    sbSql.append("     , A.AVG_AMOUNT AS SUM \n");
    sbSql.append("     , A.TRANS_TYPE \n");
    sbSql.append("     , A.REMARK \n");
    sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_ITEM_V B \n");
    sbSql.append(" WHERE (A.ITEM_CODE = B.ITEM_CODE) \n");
    sbSql.append("   AND (A.UPJANG   = " + strUpjang + ") \n");
    
    
    if (! strOtcustcd.equals(""))
    {
    	sbSql.append("   AND (B.OTCUSTCD = '" + strOtcustcd + "') \n");        	
    }    
    

    if (! strClass_code_s.equals(""))
    {
    	sbSql.append("   AND (SUBSTR(B.ITEM_CLASS3,1,6) = SUBSTR('" + strClass_code_s + "',1,6))     \n");        	
    }
  
    sbSql.append("   AND (A.TRANS_DATE BETWEEN '" + strDATEF + "' AND '" + strDATET + "') \n");
    sbSql.append("   AND (A.TRANS_TYPE LIKE 'I%') \n");
    sbSql.append(" ORDER BY A.TRANS_DATE, B.OTCUSTCD, A.ITEM_CODE,DECODE(TRANS_TYPENM, '정상입고', 1, 2),  TRANS_DATE  \n");

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