
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		//기간별 상세내역 조회
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 변수
		String PR_NUM = in_vl.getString("PR_NUM");
		
		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length()); //클리어
		sbSql.append("SELECT A.ITEM_CODE  										\n ");
		sbSql.append("     , A.ITEM_NAME  										\n ");
		sbSql.append("     , A.ITEM_SIZE  										\n ");
		sbSql.append("     , A.PO_UOM  											\n ");
		sbSql.append("     , A.PO_QTY 											\n ");
		sbSql.append("     , B.IMG_YN 											\n ");
		sbSql.append("     , B.IMG_PATH  										\n ");
		sbSql.append(" FROM  HLDC_PO_PO A                                   	\n ");
		sbSql.append("     , HLDC_PO_ITEM_MST B                             	\n ");
		sbSql.append(" WHERE A.PO_NUM = '"+ PR_NUM +"'                     		\n ");
		sbSql.append("   AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')	\n ");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE							\n ");
		sbSql.append(" ORDER BY A.ITEM_CODE                                   	\n ");
	
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_item = this.makeDataSet(rs, "ds_item"); //ds_list

		//FileLog.println("d:\\ds_item.txt", ds_list);
		
		/**종료**/
		out_dl.add(ds_item);
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