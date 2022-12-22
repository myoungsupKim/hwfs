<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체단가견적제출
■ 프로그램ID   : FSV00370E_T004.jsp
■ 프로그램명   : 엑셀업로드 자재코드 체크
■ 작성일자     : 2012.07.20
■ 작성자       : 문형광
■ 이력관리     : 2012.07.20
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 데이타
		DataSet ds_Cond1_Excel     	 = in_dl.get("ds_Cond1_Excel");
	
		
		String vCENTER_CODE    = nullToBlank(ds_Cond1_Excel.getString(0, "CENTER_CODE"));
		String vCUSTCD         = nullToBlank(ds_Cond1_Excel.getString(0, "CUSTCD")); 
		String vITEM_CODE      = nullToBlank(ds_Cond1_Excel.getString(0, "ITEM_CODE"));
			
		//IRIS 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
		//out 데이타
		DataSet ds_List1_Excel;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //클리어
		sbSql.append("SELECT A.ITEM_CODE                                                    \n");
		sbSql.append("     , B.ITEM_NAME                                                    \n");
		sbSql.append("     , B.ITEM_SIZE                                                    \n");
		sbSql.append("     , B.PO_UOM                                                       \n");
		sbSql.append("     , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE  \n");
		sbSql.append("     , B.KEEPING_TYPE                                                 \n");
		sbSql.append("     , '신규' AS ESTIMATE_STATUS                                       \n");
		sbSql.append("  FROM PO_CUSTOM_ITEM A, PO_ITEM_MST B                                \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                      \n");
		sbSql.append("   AND A.CENTER_UPJANG = '" + vCENTER_CODE + "'                       \n");
		sbSql.append("   AND A.CUSTCD = '" + vCUSTCD + "'                                   \n");
		sbSql.append("   AND A.ITEM_CODE = '" + vITEM_CODE + "'                             \n");
		sbSql.append("   AND A.USE_TYPE = '01'                                              \n");
out_vl.add("fa_Sql", sbSql.toString());	
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List1_Excel = this.makeDataSet(rs, "ds_List1_Excel"); 
		//FileLog.println("d:\\ds_list.txt", ds_list);
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_List1_Excel);
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