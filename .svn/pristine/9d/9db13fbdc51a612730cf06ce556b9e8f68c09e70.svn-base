
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 변수
		String QNA_ID 	= in_vl.getString("QNA_ID");
		
		//입력 데이타
		//DataSet ds_input     	= in_dl.get("ds_input");
		//String UPJANG     = nullToBlank(ds_input.getString(0, "UPJANG"));
		
		//IRIS 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
	

		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //클리어


		sbSql.append(" SELECT A.QNA_ID,                                             \n ");
		sbSql.append("        A.TITLE,                                              \n ");
		sbSql.append("        A.MEMO,                                               \n ");
		sbSql.append("        DECODE(C.UPJANGNM,'','알수없음',C.UPJANGNM) UPJANGNM, \n ");
		sbSql.append("        TO_CHAR(A.CREATE_DATE,'YYYY-MM-DD') CREATE_DATE       \n ");
		sbSql.append("   FROM PO_CUST_QNA A, ST_UPJANG C                            \n ");
		sbSql.append("  WHERE A.UPJANG = C.UPJANG(+)                                \n ");
		sbSql.append("    AND A.QNA_ID = "+ QNA_ID +"                               \n ");
		
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list2 = this.makeDataSet(rs, "ds_list2"); //ds_list

		//FileLog.println("d:\\ds_list2dfd.txt", ds_list);
		
		/**종료**/
		out_dl.add(ds_list2);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}
	proc_output(response,out,out_vl,out_dl);
%>