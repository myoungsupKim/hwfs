<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 마감관리/세금계산서등록및발행 (사용안함)
//■ 프로그램ID   : FMW00610E_S001.jsp
//■ 프로그램명   : 세금계산서등록및발행
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
				
        sbSql.append("SELECT BILL_ID,      \n");
        sbSql.append("       UPJANG,       \n");
        sbSql.append("       PAGE_NUM,     \n");
        sbSql.append("       HO_NUM,       \n");
        sbSql.append("       BILL_TYPE,    \n");
        sbSql.append("       PUBLISH_TYPE, \n");
        sbSql.append("       PRINT_TYPE,   \n");
        sbSql.append("       SAUPNO1,      \n");
        sbSql.append("       CUSTNM1,      \n");
        sbSql.append("       DRNAME1,      \n");
        sbSql.append("       ADDR1,        \n");
        sbSql.append("       UP_TAE1,      \n");
        sbSql.append("       UP_JONG1,     \n");
        sbSql.append("       SAUPNO2,      \n");
        sbSql.append("       CUSTNM2,      \n");
        sbSql.append("       DRNAME2,      \n");
        sbSql.append("       ADDR2,        \n");
        sbSql.append("       UP_TAE2,      \n");
        sbSql.append("       UP_JONG2,     \n");
        sbSql.append("       W_DATE,       \n");
        sbSql.append("       SPACE_NUM,    \n");
        sbSql.append("       AMT,          \n");
        sbSql.append("       VAT,          \n");
        sbSql.append("       CONTEXTS,     \n");
        sbSql.append("       LINE1_MMDD,   \n");
        sbSql.append("       LINE1_ITEM,   \n");
        sbSql.append("       LINE1_SPEC,   \n");
        sbSql.append("       LINE1_QTY,    \n");
        sbSql.append("       LINE1_PRICE,  \n");
        sbSql.append("       LINE1_AMT,    \n");
        sbSql.append("       LINE1_TAX,    \n");
        sbSql.append("       LINE1_REMARK, \n");
        sbSql.append("       LINE2_MMDD,   \n");
        sbSql.append("       LINE2_ITEM,   \n");
        sbSql.append("       LINE2_SPEC,   \n");
        sbSql.append("       LINE2_QTY,    \n");
        sbSql.append("       LINE2_PRICE,  \n");
        sbSql.append("       LINE2_AMT,    \n");
        sbSql.append("       LINE2_TAX,    \n");
        sbSql.append("       LINE2_REMARK, \n");
        sbSql.append("       LINE3_MMDD,   \n");
        sbSql.append("       LINE3_ITEM,   \n");
        sbSql.append("       LINE3_SPEC,   \n");
        sbSql.append("       LINE3_QTY,    \n");
        sbSql.append("       LINE3_PRICE,  \n");
        sbSql.append("       LINE3_AMT,    \n");
        sbSql.append("       LINE_TAX,     \n");
        sbSql.append("       LINE_REMARK,  \n");
        sbSql.append("       LINE4_MMDD,   \n");
        sbSql.append("       LINE4_ITEM,   \n");
        sbSql.append("       LINE4_SPEC,   \n");
        sbSql.append("       LINE4_QTY,    \n");
        sbSql.append("       LINE4_PRICE,  \n");
        sbSql.append("       LINE4_AMT,    \n");
        sbSql.append("       LINE4_TAX,    \n");
        sbSql.append("       LINE4_REMARK, \n");
        sbSql.append("       TOT_AMT       \n");
        sbSql.append("  FROM FMW_SALE_BILL \n");                                                                                                   
        sbSql.append(" WHERE 1=1 \n"); 
        
        if (! strUpjang.equals(""))
        	sbSql.append("   AND UPJANG = '" + strUpjang + "'                                                                                                                   \n");

        if (! strDATE.equals(""))
        	sbSql.append("   AND SUBSTR(W_DATE,1,6) =  '" + strDATE + "'                                                                                                                   \n");        
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet gds_Csqlout = this.makeDataSet(rs, "gds_Csqlout");  
		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(gds_Csqlout);
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
