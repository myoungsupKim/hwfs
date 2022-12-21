
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		//기간별 상세내역 조회
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 변수
		String TRANS_DATE = in_vl.getString("TRANS_DATE");
		String TRANS_UPJANG = in_vl.getString("TRANS_UPJANG");

		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length()); //클리어
		sbSql.append(" SELECT ITEM_NAME, TRANS_MPRICE, TRANS_QTY                \n ");
		sbSql.append(" FROM   HWFS_MAS_ADV_PO_TRANSACTION                  \n ");
		sbSql.append(" WHERE  TRANS_TYPE = 'I004'                          \n ");
		sbSql.append(" AND    ITEM_CODE  BETWEEN '010100000001' AND '019999999999'  \n ");
		sbSql.append(" AND    TRANS_DATE = '"+ TRANS_DATE +"'                   \n ");
		sbSql.append(" AND    TRANS_UPJANG = '"+ TRANS_UPJANG +"'               \n ");
		sbSql.append(" ORDER BY ITEM_NAME                                       \n ");


	
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_item2 = this.makeDataSet(rs, "ds_item2"); //ds_list

		//FileLog.println("d:\\ds_item2.txt", ds_list);
		
		/**종료**/
		out_dl.add(ds_item2);
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