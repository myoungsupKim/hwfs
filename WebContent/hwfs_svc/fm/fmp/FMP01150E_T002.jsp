<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��
�� ���α׷�ID   : FMP01150E_T001.jsp
�� ���α׷���   : ������ �԰��� ���ܾ������(����)
�� �ۼ�����     : 2015-11-27
�� �ۼ���       : �ڿ��
�� �̷°���     : �űԻ���
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//������Ʈ ��ü
	PlatformRequest platformRequest = this.proc_input(request);

	in_vl = platformRequest.getData().getVariableList();	//�Ķ���� �޴� ��ü
	in_dl = platformRequest.getData().getDataSetList();		//�����ͼ� �޴� ��ü
	
	//�Է� ����Ÿ��
	DataSet ds_list   = in_dl.get("ds_List");

	//�Է� �Ķ����
	String g_Upjang   	= nullToBlank(in_vl.getString("g_Upjang"));
	String g_EmpNo    	= nullToBlank(in_vl.getString("g_EmpNo"));
	String g_TeamCode  	= nullToBlank(in_vl.getString("g_TeamCode"));
	String g_NeedDate  	= nullToBlank(in_vl.getString("g_NeedDate"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	this.accessWriteLog(pageContext, new Object[]{"ADDR_INFO"});
	
	try
	{
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		String checkFlag	= "";
		
		this.accessWriteLog(pageContext, new Object[]{"ADDR_INFO, TEL_NO, HP_NO"});
		
		//�Է�,����
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
		        sbSql.append("  INTO FSP_HOLIDAY_UPJANG ( \n");
		        sbSql.append("  NEED_DATE,             \n");
		        sbSql.append("  UPJANG,                  \n");
		        sbSql.append("  TM_CD,               \n");
		        sbSql.append("  REMARK,             \n");
		        sbSql.append("  USE_YN,             \n");
		        sbSql.append("  CUSER,                   \n");
		        sbSql.append("  CDATE,                   \n");
		        sbSql.append("  UUSER,                   \n");
		        sbSql.append("  UDATE                    \n");
		        sbSql.append("  ) VALUES (              \n");
		        sbSql.append("    '"+g_NeedDate+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"UPJANG"))+"',\n");
		        sbSql.append("    '"+g_TeamCode+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"REMARK"))+"',\n");
		        sbSql.append("    'Y', \n");
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
		        sbSql.append("UPDATE FSP_HOLIDAY_UPJANG          \n");
		        sbSql.append("   SET NEED_DATE = '"+g_NeedDate+"',\n");
		        sbSql.append("       UPJANG = '"	+nullToBlank(ds_list.getString(i,"UPJANG"))+"',  \n");
		        sbSql.append("       TM_CD = '"		+g_TeamCode+"',  \n");
		        sbSql.append("       REMARK = '"	+nullToBlank(ds_list.getString(i,"REMARK"))+"',  \n");
		        sbSql.append("       USE_YN = 'Y',  \n");
		        sbSql.append("       UUSER = '"+g_EmpNo+"',     \n");
		        sbSql.append("       UDATE = SYSDATE           \n");
		        sbSql.append(" WHERE 1 = 1               \n");
		        sbSql.append(" 	 AND NEED_DATE = '"		+g_NeedDate+"'   \n");
		        sbSql.append(" 	 AND UPJANG = '"		+nullToBlank(ds_list.getString(i,"UPJANG"))+"'   \n");
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

		//����
		for ( int i = 0 ; i < ds_list.getRemovedRowCount() ; i++ )
		{
			//System.out.println("############################" + ds_list.getRemovedStringData(i,"UPJANG"));
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("\n\n");
	        sbSql.append("DELETE FROM FSP_HOLIDAY_UPJANG   \n");
	        sbSql.append("WHERE 1=1\n");
	        sbSql.append(" 	 AND NEED_DATE = '"		+g_NeedDate+"'   \n");
	        sbSql.append(" 	 AND UPJANG = '"		+nullToBlank(ds_list.getRemovedStringData(i,"UPJANG"))+"'   \n");
	        sbSql.append("\n\n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		
		/**����**/
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