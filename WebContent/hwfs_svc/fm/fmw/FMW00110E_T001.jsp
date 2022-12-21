<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 도소매관리/기준정보/타사매입처등록/타사매입처등록
//■ 프로그램ID   : FMW00110E_T001.jsp
//■ 프로그램명   : 타사매입처등록
//■ 작성일자     : 2010.12.28
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
		 
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
		//입력 데이타
		DataSet ds_in     = in_dl.get("ds_in");
			
		//입력 파라메터
		//String strUpjang 		= ds_cond.getRemovedData(0, "UPJANG").toString();
		//String strOtcust        = ds_cond.getRemovedData(0, "OTCUSTCD").toString();		
		//String g_OTCUSTCD    = nullToBlank(in_vl.getString("OTCUSTCD"));	
		int int_Row           = Integer.parseInt(in_vl.getString("int_Row"));
		String v_OTCUSTCD     =  nullToBlank(ds_in.getString(int_Row,"OTCUSTCD"));
		String v_USE_YN       =  nullToBlank(ds_in.getString(int_Row,"USE_YN"));
		String g_EmpNo       =  nullToBlank(in_vl.getString("g_EmpNo"));
		
		
		
		
		
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		 
		//rs.close();
		//pstmt.close();		
		
		//기존자료 삭제
		//sbSql.delete(0, sbSql.length());
		//System.out.println(v_OTCUSTCD +"ddd");	

		if (v_OTCUSTCD.equals(""))	
		{    
		sbSql.append("INSERT INTO FMW_OTCUST (				\n");                   
		sbSql.append("     OTCUSTCD       	\n");        
		sbSql.append("    ,UPJANG	\n");
		sbSql.append("    ,OTCUSTNM	\n");
		sbSql.append("    ,SAUPNM       	\n");        
		sbSql.append("    ,DRNAME	\n");
		sbSql.append("    ,JUMIN_NO	\n");
		sbSql.append("    ,SAUPNO      	\n");        
		sbSql.append("    ,UP_TAE	\n");
		sbSql.append("    ,UP_JONG	\n");		
		sbSql.append("    ,OTCUST_ZIPCODE	\n");
		sbSql.append("    ,OTCUST_ADDR1	\n");
		sbSql.append("    ,OTCUST_ADDR2       	\n");        
		sbSql.append("    ,OTCUSTP_ZIPCODE	\n");
		sbSql.append("    ,OTCUSTP_ADDR1	\n");
		sbSql.append("    ,OTCUSTP_ADDR2       	\n");        
		sbSql.append("    ,TEL_NO	\n");
		sbSql.append("    ,HP_NO	\n");		
		sbSql.append("    ,DEAL_SDATE       	\n");        
		sbSql.append("    ,DEAL_EDATE	\n");
		sbSql.append("    ,FAX_NO	\n");
		sbSql.append("    ,EMAIL       	\n");        
		sbSql.append("    ,USE_YN 	\n");
		sbSql.append("    ,CUSER, CDATE )	\n");
		sbSql.append(" VALUES (	\n");			
		sbSql.append("    FMW_OTCUST_S.NEXTVAL 	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "UPJANG")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "OTCUSTNM")) + "'	\n");		
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "SAUPNM")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "DRNAME")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "JUMIN_NO")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "SAUPNO")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "UP_TAE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "UP_JONG")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "OTCUST_ZIPCODE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "OTCUST_ADDR1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "OTCUST_ADDR2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "OTCUSTP_ZIPCODE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "OTCUSTP_ADDR1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "OTCUSTP_ADDR2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "TEL_NO")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "HP_NO")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "DEAL_SDATE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "DEAL_EDATE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "FAX_NO")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "EMAIL")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_in.getString(int_Row, "USE_YN")) + "'	\n");	
		sbSql.append("	, '" + g_EmpNo + "' \n");
		sbSql.append("	, SYSDATE \n");
		sbSql.append(" ) \n");
		}
		else
		{
			sbSql.append("UPDATE FMW_OTCUST \n");
			sbSql.append("   SET UPJANG = '" + nullToBlank(ds_in.getString(int_Row, "UPJANG")) + "' \n");
			sbSql.append("     , OTCUSTNM = '" + nullToBlank(ds_in.getString(int_Row, "OTCUSTNM")) + "' \n");
			sbSql.append("     , SAUPNM = '" + nullToBlank(ds_in.getString(int_Row, "SAUPNM")) + "' \n");
			sbSql.append("     , DRNAME = '" + nullToBlank(ds_in.getString(int_Row, "DRNAME")) + "' \n");
			sbSql.append("     , JUMIN_NO = '" + nullToBlank(ds_in.getString(int_Row, "JUMIN_NO")) + "' \n");
			sbSql.append("     , SAUPNO = '" + nullToBlank(ds_in.getString(int_Row, "SAUPNO")) + "' \n");
			sbSql.append("     , UP_TAE = '" + nullToBlank(ds_in.getString(int_Row, "UP_TAE")) + "' \n");
			sbSql.append("     , UP_JONG = '" + nullToBlank(ds_in.getString(int_Row, "UP_JONG")) + "' \n");
			sbSql.append("     , OTCUST_ZIPCODE = '" + nullToBlank(ds_in.getString(int_Row, "OTCUST_ZIPCODE")) + "' \n");
			sbSql.append("     , OTCUST_ADDR1 = '" + nullToBlank(ds_in.getString(int_Row, "OTCUST_ADDR1")) + "' \n");
			sbSql.append("     , OTCUST_ADDR2 = '" + nullToBlank(ds_in.getString(int_Row, "OTCUST_ADDR2")) + "' \n");
			sbSql.append("     , OTCUSTP_ZIPCODE = '" + nullToBlank(ds_in.getString(int_Row, "OTCUSTP_ZIPCODE")) + "' \n");
			sbSql.append("     , OTCUSTP_ADDR1 = '" + nullToBlank(ds_in.getString(int_Row, "OTCUSTP_ADDR1")) + "' \n");
			sbSql.append("     , OTCUSTP_ADDR2 = '" + nullToBlank(ds_in.getString(int_Row, "OTCUSTP_ADDR2")) + "' \n");
			sbSql.append("     , TEL_NO = '" + nullToBlank(ds_in.getString(int_Row, "TEL_NO")) + "' \n");
			sbSql.append("     , HP_NO ='" + nullToBlank(ds_in.getString(int_Row, "HP_NO")) + "' \n");
			sbSql.append("     , DEAL_SDATE = '" + nullToBlank(ds_in.getString(int_Row, "DEAL_SDATE")) + "' \n");
			//sbSql.append("     , DEAL_EDATE = '" + nullToBlank(ds_in.getString(int_Row, "DEAL_EDATE")) + "' \n");
			sbSql.append("     , FAX_NO = '" + nullToBlank(ds_in.getString(int_Row, "FAX_NO")) + "' \n");
			sbSql.append("     , EMAIL = '" + nullToBlank(ds_in.getString(int_Row, "EMAIL")) + "' \n");
			sbSql.append("     , USE_YN = '" + nullToBlank(ds_in.getString(int_Row, "USE_YN")) + "' \n");
			sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
			sbSql.append("     , UDATE = SYSDATE \n");
						
			if (v_USE_YN.equals("N"))
				sbSql.append("     , DEAL_EDATE = TO_CHAR(SYSDATE,'YYYYMMDD') \n");	
			else
			    sbSql.append("     , DEAL_EDATE = '" + nullToBlank(ds_in.getString(int_Row, "DEAL_EDATE")) + "' \n");	
			
			
			sbSql.append(" WHERE OTCUSTCD = '" + v_OTCUSTCD + "'\n");
		}
		
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeQuery();
		
		
		pstmt.close();	
		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
		
	}		
	catch(Exception ex)
	{
		conn.rollback();
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
