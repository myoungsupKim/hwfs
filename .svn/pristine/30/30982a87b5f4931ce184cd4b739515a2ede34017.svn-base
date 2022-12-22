<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 실적관리 > 물류센터재고조회
■ 프로그램ID   : FSV00440V_T001.jsp
■ 프로그램명   : 센터재고조회
■ 작성일자     : 2011-02-17
■ 작성자       : 문형광
■ 이력관리     : 2011-02-17 - 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String v_CenterCode = nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
		String v_CustCd     = nullToBlank(ds_Cond.getString(0, "CUSTCD"));
		String v_TrDateF    = nullToBlank(ds_Cond.getString(0, "TRANS_DATE_F"));
		String v_TrDateT    = nullToBlank(ds_Cond.getString(0, "TRANS_DATE_T"));
		String sSubinvCode = "";
		String sOnhandMonth = "";
		//IRIS DB연결
		//if(conn != null && !conn.isClosed()) conn.close();
		//conn = getIRISConn();
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//센터재고조회
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT * FROM DUAL    \n");
out_vl.add("fa_Sql", sbSql.toString());
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