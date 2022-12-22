<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 마감관리/세금계산서등록및발행 
//■ 프로그램ID   : FMW00610E_S001.jsp
//■ 프로그램명   : 세금계산서등록및발행(매출조회)
//■ 작성일자     : 2010.01.12
//■ 작성자       : 맹수영
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
		DataSet ds_input     	= in_dl.get("ds_input2");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strDATE		    = nullToBlank(ds_input.getString(0, "W_DATE"));
		String strHallCode	    = nullToBlank(ds_input.getString(0, "HALL_CODE"));
		
		//out 데이타
		DataSet ds_Maechul;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
				
        sbSql.append("SELECT K.SALE_VAT_SUM, K.VAT, K.SALE_AMT                           \n");
        sbSql.append("     ,(K.SALE_VAT_SUM+K.VAT)+K.SALE_AMT AS SALE_AMOUNT             \n");
        sbSql.append("  FROM (                                                           \n");
        sbSql.append("           SELECT SUM(DECODE(B.TAX_CODE,100,ROUND(NVL(A.SALE_AMOUNT,0)/1.1),0)) AS SALE_VAT_SUM                    \n");
        sbSql.append("                 ,SUM(DECODE(B.TAX_CODE,100,(NVL(A.SALE_AMOUNT,0) - ROUND(NVL(A.SALE_AMOUNT,0)/1.1)),0)) AS VAT    \n");
        sbSql.append("                 ,SUM(DECODE(B.TAX_CODE,100,0,NVL(A.SALE_AMOUNT,0))) AS SALE_AMT                                   \n");
        sbSql.append("             FROM FMW_PO_TRANSACTION A, FMW_ITEM_V B               \n");
        sbSql.append("            WHERE A.ITEM_CODE = B.ITEM_CODE                        \n");
        sbSql.append("              AND A.TRANS_TYPE LIKE 'O%'    \n");
        sbSql.append(" 			    AND A.HALL_CODE = '" + strHallCode + "'              \n");
        sbSql.append("              AND A.UPJANG    = '" + strUpjang + "'                \n");
        sbSql.append("              AND SUBSTR(A.TRANS_DATE,1,6) = '" + strDATE + "') K  \n");                
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_Maechul = this.makeDataSet(rs, "gds_Csqlout");  
		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_Maechul);
		//this.setResultMessage(0, "OK", out_vl);
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
