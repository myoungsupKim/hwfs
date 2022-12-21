<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 도소매관리/기준정보/타사매입처등록/타사매입처등록
■ 프로그램ID   : FMW00110E_T001.jsp
■ 프로그램명   : 타사매입처등록
■ 작성일자     : 2010.12.28
■ 작성자       : 맹수영
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
		DataSet ds_input     	= in_dl.get("ds_CustI");
	
		//String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		//String strOTCUSTCD		= nullToBlank(ds_input.getString(0, "OTCUSTCD"));
		//String strOTCUSTCD   = nullToBlank(in_vl.getString("g_OTCUSTCD"));
		//String strUPJANG  = nullToBlank(in_vl.getString("g_Upjang"));
		
		//out 데이타
		DataSet ds_in;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
		
		sbSql.append("\n  SELECT                   ");
		sbSql.append("\n  	 LPAD(OTCUSTCD,4,'0') AS  OTCUSTCD_DIS      ");
		sbSql.append("\n  	,OTCUSTCD      ");
		sbSql.append("\n  	,UPJANG              ");
		sbSql.append("\n  	,OTCUSTNM              ");
		sbSql.append("\n  	,SAUPNM                ");
		sbSql.append("\n    ,DRNAME                ");
		sbSql.append("\n  	,JUMIN_NO              ");
		sbSql.append("\n    ,SAUPNO                ");
		sbSql.append("\n    ,UP_TAE                ");
		sbSql.append("\n    ,UP_JONG               ");
		sbSql.append("\n  	,OTCUST_ZIPCODE         ");	
		sbSql.append("\n  	,OTCUST_ADDR1           ");
		sbSql.append("\n  	,OTCUST_ADDR2           ");
		sbSql.append("\n  	,OTCUSTP_ZIPCODE          ");	
		sbSql.append("\n  	,OTCUSTP_ADDR1          ");
		sbSql.append("\n  	,OTCUSTP_ADDR2          ");	
		sbSql.append("\n    ,TEL_NO                ");
		sbSql.append("\n    ,HP_NO                 ");
		sbSql.append("\n    ,DEAL_SDATE            ");
		sbSql.append("\n  	,DEAL_EDATE            ");
		sbSql.append("\n    ,FAX_NO                ");
		sbSql.append("\n    ,EMAIL                 ");
		sbSql.append("\n    ,USE_YN    		       ");
		sbSql.append("\n   FROM FMW_OTCUST       ");
		sbSql.append("\n  WHERE 1=1     ");
		
		if (! ds_input.getString(0, "OTCUSTCD").equals(""))
			sbSql.append("\n     AND OTCUSTCD = '" + nullToBlank(ds_input.getString(0, "OTCUSTCD")) + "'     ");
		
		if (! ds_input.getString(0, "UPJANG").equals(""))
			sbSql.append("\n     AND UPJANG = '" + nullToBlank(ds_input.getString(0, "UPJANG")) + "'         ");

		sbSql.append("\n  ORDER BY TO_NUMBER(OTCUSTCD)      ");		
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_in = this.makeDataSet(rs, "ds_in"); //ds_in
		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_in);
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
