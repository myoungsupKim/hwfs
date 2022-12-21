<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 마감관리/세금계산서등록및출력
//■ 프로그램ID   : FMW00610E_T001.jsp
//■ 프로그램명   : 세금계산서등록및출력
//■ 작성일자     : 2011.01.20
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
		//System.out.println("ddd");
		//입력 데이타
		DataSet ds_input     	= in_dl.get("ds_input");
		DataSet ds_list     	= in_dl.get("ds_list");
		
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strDATE		    = nullToBlank(ds_input.getString(0, "DATE"));
		String g_EmpNo          =  nullToBlank(in_vl.getString("g_EmpNo"));
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		 
		//rs.close();
		//pstmt.close();		
		
		//기존자료 삭제
		//sbSql.delete(0, sbSql.length());
			
 
        sbSql.append("INSERT INTO FMW_SALE_BILL   \n");
        sbSql.append("(                           \n");
        sbSql.append("	  BILL_ID               \n");
        sbSql.append("	, UPJANG                   \n");
        sbSql.append("	, PAGE_NUM                 \n");
        sbSql.append("	, HO_NUM                   \n");
        sbSql.append("	, BILL_TYPE             \n");
        sbSql.append("	, PUBLISH_TYPE             \n");
        sbSql.append("	, PRINT_TYPE               \n");
        sbSql.append("	, SAUPNO1                  \n");
        sbSql.append("	, CUSTNM1                  \n");
        sbSql.append("	, DRNAME1                  \n");
        sbSql.append("	, ADDR1                    \n");
        sbSql.append("	, UP_TAE1                  \n");
        sbSql.append("	, UP_JONG1                 \n");
        sbSql.append("	, SAUPNO2                  \n");
        sbSql.append("	, CUSTNM2                  \n");
        sbSql.append("	, DRNAME2                  \n");
        sbSql.append("	, ADDR2                    \n");
        sbSql.append("	, UP_TAE2                  \n");
        sbSql.append("	, UP_JONG2                 \n");
        sbSql.append("	, W_DATE                   \n");
        sbSql.append("	, SPACE_NUM                \n");
        sbSql.append("	, AMT                      \n");
        sbSql.append("	, VAT                      \n");
        sbSql.append("	, CONTEXTS                 \n");
        sbSql.append("	, LINE1_MMDD               \n");
        sbSql.append("	, LINE1_ITEM               \n");
        sbSql.append("	, LINE1_SPEC               \n");
        sbSql.append("	, LINE1_QTY                \n");
        sbSql.append("	, LINE1_PRICE              \n");
        sbSql.append("	, LINE1_AMT                \n");
        sbSql.append("	, LINE1_TAX                \n");
        sbSql.append("	, LINE1_REMARK             \n");
        sbSql.append("	, LINE2_MMDD               \n");
        sbSql.append("	, LINE2_ITEM               \n");
        sbSql.append("	, LINE2_SPEC               \n");
        sbSql.append("	, LINE2_QTY                \n");
        sbSql.append("	, LINE2_PRICE              \n");
        sbSql.append("	, LINE2_AMT                \n");
        sbSql.append("	, LINE2_TAX                \n");
        sbSql.append("	, LINE2_REMARK             \n");
        sbSql.append("	, LINE3_MMDD               \n");
        sbSql.append("	, LINE3_ITEM               \n");
        sbSql.append("	, LINE3_SPEC               \n");
        sbSql.append("	, LINE3_QTY                \n");
        sbSql.append("	, LINE3_PRICE              \n");
        sbSql.append("	, LINE3_AMT                \n");
        sbSql.append("	, LINE3_TAX                \n");
        sbSql.append("	, LINE3_REMARK             \n");
        sbSql.append("	, LINE4_MMDD               \n");
        sbSql.append("	, LINE4_ITEM               \n");
        sbSql.append("	, LINE4_SPEC               \n");
        sbSql.append("	, LINE4_QTY                \n");
        sbSql.append("	, LINE4_PRICE              \n");
        sbSql.append("	, LINE4_AMT                \n");
        sbSql.append("	, LINE4_TAX                \n");
        sbSql.append("	, LINE4_REMARK             \n");
        sbSql.append("	, TOT_AMT                  \n");
        sbSql.append("	, USE_YN                   \n");
        sbSql.append("	, CUSER                    \n");
        sbSql.append("	, CDATE                    \n");
        sbSql.append(")                           \n");
        sbSql.append(" VALUES (	\n");			
		sbSql.append("    FMW_SALE_BILL_S.NEXTVAL 	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "UPJANG")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "PAGE_NUM")) + "'	\n");		
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "HO_NUM")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "BILL_TYPE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "PUBLISH_TYPE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "PRINT_TYPE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "SAUPNO1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "CUSTNM1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "DRNAME1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "ADDR1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "UP_TAE1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "UP_JONG1")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "SAUPNO2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "CUSTNM2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "DRNAME2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "ADDR2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "UP_TAE2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "UP_JONG2")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "W_DATE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "SPACE_NUM")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "AMT")) + "'	\n");				
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "VAT")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "CONTEXTS")) + "'	\n");		
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_MMDD")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_ITEM")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_SPEC")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_QTY")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_PRICE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_AMT")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_TAX")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE1_REMARK")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_MMDD")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_ITEM")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_SPEC")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_QTY")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_PRICE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_AMT")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_TAX")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE2_REMARK")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_MMDD")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_ITEM")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_SPEC")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_QTY")) + "'	\n");		
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_PRICE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_AMT")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_TAX")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE3_REMARK")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_MMDD")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_ITEM")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_SPEC")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_QTY")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_PRICE")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_AMT")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_TAX")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "LINE4_REMARK")) + "'	\n");
		sbSql.append("    ,'" + nullToBlank(ds_list.getString(0, "TOT_AMT")) + "'	\n");
		sbSql.append("    ,'Y'	\n");
		sbSql.append("    ,'" + g_EmpNo + "', SYSDATE	\n");
		sbSql.append(" ) \n");
		
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
