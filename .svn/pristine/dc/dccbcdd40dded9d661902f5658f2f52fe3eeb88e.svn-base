<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 마감관리/세금계산서등록및발행
//■ 프로그램ID   : FMW00610E_S002.jsp
//■ 프로그램명   : 세금계산서등록및발행(기본조회)
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
		DataSet ds_input     	= in_dl.get("ds_input");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strDATE		    = nullToBlank(ds_input.getString(0, "W_DATE"));
		
		//out 데이타
		DataSet ds_cond1;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
				

        sbSql.append("SELECT  TAX_INV.*                                                                        \n");
        sbSql.append("        , SUBSTR(W_DATE,0,4) AS W_DATE_YYYY                                              \n");
        sbSql.append("        , SUBSTR(W_DATE,5,2) AS W_DATE_MM                                                \n");
        sbSql.append("        , SUBSTR(W_DATE,7,2) AS W_DATE_DD                                                \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),1,1) AS S1                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),2,1) AS S2                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),3,1) AS S3                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),4,1) AS S4                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),5,1) AS S5                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),6,1) AS S6                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),7,1) AS S7                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),8,1) AS S8                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),9,1) AS S9                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),10,1) AS S10                                  \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(AMT),11,' '),11,1) AS S11                                  \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),1,1) AS T1                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),2,1) AS T2                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),3,1) AS T3                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),4,1) AS T4                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),5,1) AS T5                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),6,1) AS T6                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),7,1) AS T7                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),8,1) AS T8                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),9,1) AS T9                                    \n");
        sbSql.append("        , SUBSTR(LPAD(TO_CHAR(VAT),10,' '),10,1) AS T10                                  \n");
        sbSql.append("        , SUBSTR(LINE1_MMDD,0,2) AS LINE1_MM                                             \n");
        sbSql.append("        , SUBSTR(LINE1_MMDD,3,2) AS LINE1_DD                                             \n");
        sbSql.append("        , SUBSTR(LINE2_MMDD,0,2) AS LINE2_MM                                             \n");
        sbSql.append("        , SUBSTR(LINE2_MMDD,3,2) AS LINE2_DD                                             \n");
        sbSql.append("        , SUBSTR(LINE3_MMDD,0,2) AS LINE3_MM                                             \n");
        sbSql.append("        , SUBSTR(LINE3_MMDD,3,2) AS LINE3_DD                                             \n");
        sbSql.append("        , SUBSTR(LINE4_MMDD,0,2) AS LINE4_MM                                             \n");
        sbSql.append("        , SUBSTR(LINE4_MMDD,3,2) AS LINE4_DD                                             \n");
        sbSql.append("        , CASE WHEN USE_YN = 'N' THEN '[수정불가, 출력불가]' ELSE '[수정불가]'END AS ABLE_TYPE \n");
        sbSql.append("FROM    FMW_SALE_BILL TAX_INV                                                          \n");                                                                                               
        sbSql.append("WHERE 1=1 \n"); 
        
        if (! strUpjang.equals(""))
        	sbSql.append("   AND UPJANG = '" + strUpjang + "'                                                                                                                   \n");

        if (! strDATE.equals(""))
        	sbSql.append("   AND SUBSTR(W_DATE,1,6) = '" + strDATE + "'                                                                                                                   \n");        
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");  
		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_list);
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
