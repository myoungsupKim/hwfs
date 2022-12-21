<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업
■ 프로그램ID   : FMP00032V_T001.jsp
■ 프로그램명   : CS상품정보 공유(저장)
■ 작성일자     : 2015-11-22
■ 작성자       : 박용대
■ 이력관리     : 신규생성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);

	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();		//데이터셋 받는 객체
	
	//입력 데이타셋
	DataSet ds_list   = in_dl.get("ds_List");

	//입력 파라미터
	String g_Upjang   	= nullToBlank(in_vl.getString("g_Upjang"));
	String g_EmpNo    	= nullToBlank(in_vl.getString("g_EmpNo"));
	String g_DateType   = nullToBlank(in_vl.getString("g_DateType"));
	String g_SubinvType = nullToBlank(in_vl.getString("g_SubinvType"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	this.accessWriteLog(pageContext, new Object[]{"ADDR_INFO"});
	
	
	
	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		String checkFlag	= "";
		
		this.accessWriteLog(pageContext, new Object[]{"ADDR_INFO, TEL_NO, HP_NO"});
		
		//입력,수정
		for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_list.getRowType(i);
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				sbSql.delete(0, sbSql.length());
				
				System.out.println(ds_list.getRowType(i));
				
				sbSql.append("\n\n");
		        sbSql.append("INSERT                     \n");
		        sbSql.append("  INTO FMS_CSITEM_INFO_SHARE ( \n");
		        sbSql.append("  ITEM_CODE,             \n");
		        sbSql.append("  ITEM_NAME,             \n");
		        sbSql.append("  ITEM_INFO,              \n");
		        sbSql.append("  CUSER,               \n");
		        sbSql.append("  CDATE,               \n");
		        sbSql.append("  UUSER,             \n");
		        sbSql.append("  UDATE             \n");
		        sbSql.append("  ) VALUES (              \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITEM_CODE"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITEM_NAME"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITEM_INFO"))+"',\n");
		        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
		        sbSql.append("    SYSDATE,              \n");
		        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
		        sbSql.append("    SYSDATE               \n");
		        sbSql.append(")                           \n");
		        sbSql.append("\n\n");
			
				out_vl.add("fa_Sql", sbSql.toString());		
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
		     	// IN
				sbSql.append("   call SCC_ADDR_PRO('" + nullToBlank(ds_list.getString(i, "ADDR_INFO")) + "', '" + g_EmpNo + "')              \n");
		     
				out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery();
				
				pstmt.close();
				rs.close();
			}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("\n\n");
		        sbSql.append("UPDATE FMS_CSITEM_INFO_SHARE          \n");
		        sbSql.append("   SET ITEM_CODE = '"+nullToBlank(ds_list.getString(i,"ITEM_CODE"))+"',\n");
		        sbSql.append("       ITEM_INFO = '"	+nullToBlank(ds_list.getString(i,"ITEM_INFO"))+"',  \n");
		        sbSql.append("       UUSER = '"+g_EmpNo+"',     \n");
		        sbSql.append("       UDATE = SYSDATE           \n");
		        sbSql.append(" WHERE 1 = 1               \n");
		        sbSql.append(" 	 AND ITEM_CODE = '"		+nullToBlank(ds_list.getString(i,"ITEM_CODE"))+"'   \n");
		        sbSql.append("\n\n");

				out_vl.add("fa_Sql", sbSql.toString());		
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
		     	// IN
				sbSql.append("   call SCC_ADDR_PRO('" + nullToBlank(ds_list.getString(i, "ADDR_INFO")) + "', '" + g_EmpNo + "')              \n");
		     
				out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery();
				
				pstmt.close();
				rs.close();
			}
		}

		//삭제
		for ( int i = 0 ; i < ds_list.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("\n\n");
	        sbSql.append("DELETE FROM FMS_CSITEM_INFO_SHARE   \n");
	        sbSql.append("WHERE 1=1  \n");
	        sbSql.append(" 	 AND ITEM_CODE = '"		+nullToBlank(ds_list.getString(i,"ITEM_CODE"))+"'   \n");
	        sbSql.append("\n\n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		
		/**종료**/
		conn.commit();
		out_vl.add("fa_Msg", "");
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