<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 실적관리/업종별 매출추이
//■ 프로그램ID   : FMW00370V_T001.jsp
//■ 프로그램명   : 업종별 매출추이
//■ 작성일자     : 2011.03.03
//■ 작성자       : 문형광
//■ 이력관리     :  
//-----------------------------------------------------------------------------*/
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
	
		String strUpjang 		= nullToBlank(ds_Condput.getString(0, "UPJANG"));
		String strSUBINV_CODE	= nullToBlank(ds_Condput.getString(0, "SUBINV_CODE"));
		String strDATEF		    = nullToBlank(ds_Condput.getString(0, "DATEF"));
		String strDATET		    = nullToBlank(ds_Condput.getString(0, "DATET"));
		String strUPJONG 	    = nullToBlank(ds_Condput.getString(0, "UPJONG"));
		
		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
        sbSql.append("SELECT A.UPJANG                                                                                                                                 \n");
        sbSql.append("     , C.HALL_TYPE                                                                                                                              \n");
        sbSql.append("     , C.HALL_TYPE_NAME                                                                                                                         \n");
        sbSql.append("     , NVL(TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD(DAY)'),'자료없음') AS TRANS_DATE                                                  \n");
        sbSql.append("     , SUM(DECODE(B.TAX_CODE,100,ROUND(A.SALE_AMOUNT/1.1),A.SALE_AMOUNT)) AS AMT                                                                \n");
        sbSql.append("     , SUM(DECODE(B.TAX_CODE,100,(A.SALE_AMOUNT -ROUND(A.SALE_AMOUNT/1.1)),0)) AS VAT                                                           \n");
        sbSql.append("     , SUM(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),1,INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')-1)) AS AMOUNT_BOX \n");
        sbSql.append("     , SUM(SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,NULL,A.TRANS_QTY),',')+1)) AS AMOUNT_BONG \n");
        sbSql.append("  FROM FMW_PO_TRANSACTION A, FMW_ITEM_V B                                                                                                       \n");
        sbSql.append("     , (SELECT Z.HALL_CODE, Z.UPJANG, Z.HALL_TYPE, Y.CODE_NAME AS HALL_TYPE_NAME                                                                \n");
        sbSql.append("          FROM FMW_HALL Z, SCC_COMMON_CODE Y                                                                                                    \n");
        sbSql.append("         WHERE Z.HALL_TYPE = Y.CODE                                                                                                             \n");
        if (! strUPJONG.equals(""))
        	sbSql.append("       	AND Z.HALL_TYPE = '" + strUPJONG + "' \n");
        sbSql.append("           AND Y.GROUP_CODE = 'FMW003') C                                                                                                       \n");
        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                \n");
        sbSql.append("   AND A.UPJANG = C.UPJANG                                                                                                                      \n");
        sbSql.append("   AND A.HALL_CODE = C.HALL_CODE                                                                                                                \n");
        sbSql.append("   AND A.UPJANG = " + strUpjang + "                                                                                                             \n");
        sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strDATEF + "' AND '" + strDATET + "'                                                                           \n");
        sbSql.append("   AND A.TRANS_TYPE LIKE 'O%'                                                                                                                   \n");
        sbSql.append(" GROUP BY A.UPJANG, C.HALL_TYPE, C.HALL_TYPE_NAME, A.TRANS_DATE                                                                                    \n");
        sbSql.append(" ORDER BY C.HALL_TYPE, A.TRANS_DATE                                                                                                             \n");
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