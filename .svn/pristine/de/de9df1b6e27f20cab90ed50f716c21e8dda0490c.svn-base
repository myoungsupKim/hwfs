<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00161E_T002.jsp
■ 프로그램명   : 발주저장 당시 여신 이력 로그생성
■ 작성일자     : 2022.07.27
■ 작성자       : 김혜진
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//In 데이타
		DataSet ds_Cond  	    = in_dl.get("ds_CrdInfo");
		
		//입력 파라미터
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String NEED_DATE      = nullToBlank(in_vl.getString("NEED_DATE"));
		
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
        sbSql.append("INSERT INTO FMP_ORDER_CREDIT_LOG(   \n");
        sbSql.append("		 ORDER_UPJANG \n");
        sbSql.append("		,UPJANG \n");
        sbSql.append(" 		,UPJANGNM_DISP \n");
        sbSql.append(" 		,MAIN_UPJANG \n");
        sbSql.append("    	,HEAD_CREDIT_YN \n");
        sbSql.append("   	,CREDIT_TURN_DAYS \n");
        sbSql.append("  	,CREDIT_TURN_DAYS_TOT \n");
        sbSql.append(" 		,CREDIT_AMOUNT \n");
        sbSql.append("		,CREDIT_OVER_AMOUNT ,BOND_AMT\n");
        sbSql.append(" 		,L_BILL_DATE \n");
        sbSql.append("		,CREDIT_RMN_AMT \n");
        sbSql.append(" 		,CREDIT_AVAIL_AMT \n");
        sbSql.append("		,LAST_TURN_CNT \n");
        sbSql.append(" 		,CREDIT_TURN_CONTROL_YN \n");
        sbSql.append("		,CREDIT_AMOUNT_CONTROL_YN \n");
        sbSql.append("		,CREDIT_CONTROL_YN \n");
        sbSql.append(" 		,CREDIT_CONTROL_DESC \n");
        sbSql.append("   	,CREDIT_START \n");
        sbSql.append("  	,CREDIT_END \n");
        sbSql.append(" 		,L_BILL_DATE_DISP \n");
        sbSql.append("  	,NEED_DATE \n");
        sbSql.append("  	,CDATE \n");
        sbSql.append("		,CUSER \n");
        sbSql.append(")VALUES(                    \n");
        sbSql.append("		 '" + nullToBlank(ds_Cond.getString(0, "ORDER_UPJANG")) + "' \n");
        sbSql.append("		,'" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "UPJANGNM_DISP")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + "' \n");
        sbSql.append("    	,'" + nullToBlank(ds_Cond.getString(0, "HEAD_CREDIT_YN")) + "' \n");
        sbSql.append("   	,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_TURN_DAYS")) + "' \n");
        sbSql.append("  	,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_TURN_DAYS_TOT")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_AMOUNT")) + "' \n");
        sbSql.append("		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_OVER_AMOUNT")) + "' \n");
        sbSql.append("      ,'" + nullToBlank(ds_Cond.getString(0, "BOND_AMT")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "L_BILL_DATE")) + "' \n");
        sbSql.append("		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_RMN_AMT")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_AVAIL_AMT")) + "' \n");
        sbSql.append("		,'" + nullToBlank(ds_Cond.getString(0, "LAST_TURN_CNT")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_TURN_CONTROL_YN")) + "' \n");
        sbSql.append("		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_AMOUNT_CONTROL_YN")) + "' \n");
        sbSql.append("		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_CONTROL_YN")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_CONTROL_DESC")) + "' \n");
        sbSql.append("   	,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_START")) + "' \n");
        sbSql.append("  	,'" + nullToBlank(ds_Cond.getString(0, "CREDIT_END")) + "' \n");
        sbSql.append(" 		,'" + nullToBlank(ds_Cond.getString(0, "L_BILL_DATE_DISP")) + "' \n");
        sbSql.append("  	,'"+ NEED_DATE +"'  \n");
        sbSql.append("  	,SYSDATE                  \n");
        sbSql.append("  	,'"+ g_EmpNo +"'          \n");
        sbSql.append(")                           \n");
        
out_vl.add("fa_Sql", sbSql.toString());
	//System.out.println(sbSql.toString());
	pstmt = conn.prepareStatement(sbSql.toString());
	pstmt.executeUpdate();
	pstmt.close();
	
	/**종료**/
	conn.commit();
	//out_vl.add("fa_Chk", "등록되었습니다.");
	this.setResultMessage(0, "OK", out_vl);
	   	
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);	
	    this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
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
//		if(stmt != null) {
//			try {
//				stmt.close();
//			}catch(Exception e) {}
//		}
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