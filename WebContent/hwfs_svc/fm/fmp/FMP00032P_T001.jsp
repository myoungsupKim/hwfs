<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업
■ 프로그램ID   : FMP00032P_T001.jsp
■ 프로그램명   : 아이템 조회(팝업조회)
■ 작성일자     : 2015-11-22
■ 작성자       : 박용대
■ 이력관리     : 신규생성
-----------------------------------------------------------------------------*/
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

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String sItemName = nullToBlank(ds_Cond.getString(0, "ITEM_NAME"));

		//내역조회
        sbSql.append("SELECT A.ITEM_CODE,                                    \n");
        sbSql.append("       A.ITEM_NAME,                               \n");
        sbSql.append("       A.ITEM_SIZE, \n");
        sbSql.append("       A.UOM_CODE \n");
        sbSql.append("  FROM HLDC_PO_ITEM_MST A                                \n");
        sbSql.append(" WHERE 1=1                                               \n");
        if(!sItemName.isEmpty())
        {
        	sbSql.append("   AND A.ITEM_NAME LIKE '%"+sItemName+"%'                \n");
        }
        

		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		logger.debug(sbSql.toString());
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
