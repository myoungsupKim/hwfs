
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 변수
		String g_CustCd 	= in_vl.getString("g_CustCd");
		
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


		sbSql.append(" SELECT ROWNUM NUM, QNA_ID, TITLE, UPJANGNM, TO_CHAR(CREATE_DATE,'YYYY-MM-DD AM HH:MI:SS') CREATE_DATE  \n ");
		sbSql.append("    FROM (                                                 \n ");
		sbSql.append("         SELECT A.QNA_ID,                                  \n ");
		sbSql.append("                A.TITLE,                                   \n ");
		sbSql.append("                C.UPJANGNM,                                \n ");
		sbSql.append("                A.CREATE_DATE                              \n ");
		sbSql.append("           FROM PO_CUST_QNA A, ST_UPJANG C                 \n ");
		sbSql.append("          WHERE A.UPJANG = C.UPJANG(+)                     \n ");
		sbSql.append("            AND A.CUSTCD = "+ g_CustCd  +"                          \n ");
		sbSql.append("          ORDER BY QNA_ID                                  \n ");
		sbSql.append("         )                                                 \n ");
		sbSql.append("   ORDER BY ROWNUM DESC                                    \n ");
		
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list1 = this.makeDataSet(rs, "ds_list1"); //ds_list

		//FileLog.println("d:\\ds_listdfdf.txt", ds_list);
		
		/**종료**/
		out_dl.add(ds_list1);
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