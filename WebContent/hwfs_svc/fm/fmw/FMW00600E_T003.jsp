<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ������
�� ���α׷�ID   : FMW00600E_T003.jsp
�� ���α׷���   : ������ ��
�� �ۼ�����     : 2011.01.20
�� �ۼ���       : ������
�� �̷°���     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();	
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
		//In ����Ÿ
		DataSet ds_List  	    = in_dl.get("ds_List");
		
		if (ds_List.getRowCount() == 0)
		{
			return;
		}	
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			String v_SubinvCode     = nullToBlank(ds_List.getString(i, "SUBINV_CODE"));
			String v_Date           = nullToBlank(ds_List.getString(i, "CLS_YM"));
			String v_Flag           = nullToBlank(ds_List.getString(i, "CLS_FLAG"));
			String sClsYm           = "";	
		    //out ����Ÿ		
			StringBuffer sbSql = new StringBuffer();
		    if (v_Flag.equals("N"))
		    {
		    	return;	
		    }
		    else		
		    {	
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT CLS_YM         						\n");
		        sbSql.append("  FROM FMW_CLOSING    					  	\n");
		        sbSql.append(" WHERE SUBINV_CODE = '" + v_SubinvCode + "' 	\n");
		        sbSql.append("   AND CLS_YM > '" + v_Date + "'      	\n");
		        sbSql.append("   AND CLS_FLAG = 'Y' 						\n");
		        sbSql.append("   AND ROWNUM <= 1    						\n");
out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();		
				if (rs.next())
				{
					sClsYm = rs.getString("CLS_YM");
					rs.close();
					pstmt.close();
					out_vl.add("sClsYm", sClsYm+ " �� ������ ����ϼž� ó���� �����մϴ�!.");
					return;
				}
				else
				{
					rs.close();
				    pstmt.close();
				}
				sbSql.delete(0, sbSql.length());
				sbSql.append( "DELETE FROM FMW_CLOSING A \n");
				sbSql.append( " WHERE A.CLS_YM      = '" + v_Date + "'  \n");
				sbSql.append( "   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
				sbSql.append( "   AND A.CLS_FLAG    = 'Y' \n");
out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
//System.out.println("sOnhandMonth:" + sOnhandMonth);	       
			}				
		}		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp �α׳����
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);


%>