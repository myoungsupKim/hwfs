<%
/*-----------------------------------------------------------------------------
■ 시스템명          : 공통팝업 상품조회
■ 프로그램ID   		: FMZ_UPJANG_ITEM_T001.jsp
■ 프로그램명       	: 공통팝업 상품조회(단가 포함)
■ 작성일자          : 2009.01.07
■ 작성자            : 노규완
■ 이력관리          : 2009.01.07
					  [고도화]_운영율 관련 수정_김경은
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
	
		String strNeedDate = nullToBlank(in_vl.getString("needDate"));
	
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.AVG_TIME, A.MAX_TIME, B.CHK                                                                                                                                  \n");
		sbSql.append("FROM   (SELECT TO_CHAR(AVG(TO_DATE(TO_CHAR(CDATE, 'HH24MI'), 'HH24MI') - TO_DATE('1111', 'HH24MI')) + TO_DATE('1111', 'HH24MI'), 'HH24MI') AS AVG_TIME	\n");
		sbSql.append("        		,TO_CHAR(MAX(TO_DATE(TO_CHAR(CDATE, 'HH24MI'), 'HH24MI') - TO_DATE('1111', 'HH24MI')) + TO_DATE('1111', 'HH24MI'), 'HH24MI') AS MAX_TIME	\n");
		sbSql.append("        FROM   FMS_CRDINFO_CHK                                                                                                                            \n");
		sbSql.append("        WHERE  NEED_DATE BETWEEN SYSDATE - 7 AND SYSDATE) A                                                                                               \n");
		sbSql.append("     , (SELECT DECODE(MAX(NEED_DATE), :strNeedDate, 'Y', 'N')	 AS CHK                                                                                     \n");
		sbSql.append("        FROM   FMS_CRDINFO_CHK                                                                                                                            \n");
		sbSql.append("        WHERE    CLOSE_YN = 'Y') B                                                                                                               			\n");

		out_vl.add("fa_Sql", sbSql.toString());
		
		npstmt = new NamedParameterStatement(conn, sbSql.toString());
		
		npstmt.setString("strNeedDate", strNeedDate);
		
		rs = npstmt.executeQuery();            

		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		npstmt.close();

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
		if(npstmt != null) {
			try {
				npstmt.close();
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
