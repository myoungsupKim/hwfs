<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/���Ű���/��ǰ��������
�� ���α׷�ID   : FMP00863P_T001.jsp
�� ���α׷���   : ���ã�� ����� �� �ϰ� ����(����)
�� �ۼ�����     : 2010-04-05
�� �ۼ���       : ��Կ�
�� �̷°���     : 2010-04-05 - �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
	
		//�Է� ����Ÿ
		DataSet ds_MultiUpj = in_dl.get("ds_MultiUpjang");
		DataSet ds_List   = in_dl.get("ds_con");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
//		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sItem_Code  = nullToBlank(in_vl.getString("sItem_Code"));
		String sGubun  = nullToBlank(in_vl.getString("sGubun"));
		
		 

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		String sSql, sSql2, sChk;
	
		
		if (sGubun.equals("1")) //�ϰ� �߰�
		{
			//**************************************************************************
			//  1. ���� ��ǰ �ϰ� �߰� 
			//**************************************************************************
			
			sSql = "INSERT INTO FMP_FAVORITE(UPJANG, FAVOR_GROUP, ITEM_CODE, USE_YN, CUSER, CDATE )" +
	        "VALUES (?,?,?,?,?,SYSDATE)";
			for ( int iUpj = 0; iUpj < ds_MultiUpj.getRowCount(); iUpj++ )
			{
				sChk = nullToBlank(ds_MultiUpj.getString(iUpj, "CHK"));
				if (sChk.equals("0")) continue;
				
				sUpjang = nullToBlank(ds_MultiUpj.getString(iUpj, "UPJANG"));
				//�����ڷ� ����(���ã�� �׷� ���� ����)
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM FMP_FAVORITE \n");			
				sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
				sbSql.append("   AND SUBSTR(FAVOR_GROUP,8,2) = '01' \n");
				sbSql.append("   AND ITEM_CODE = '" + sItem_Code + "' \n");			
	out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();

				//�Է�
				pstmt = conn.prepareStatement(sSql);
				//for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
				//{
					pstmt.setString(1, sUpjang);          //����
					pstmt.setString(2, sUpjang.substring(0,6)+"001");    //���ã�� �׷��ڵ�
					pstmt.setString(3, sItem_Code);      //���ã�� �׷��				
					pstmt.setString(4, "Y");              //�������
					pstmt.setString(5, g_EmpNo);          //�����				

					//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
					pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
				//}
				pstmt.executeBatch(); //��ġó��
				pstmt.close();
			}			
				
		}	
		else  //�ϰ� ����
		{
			//**************************************************************************
			//  2. ���� ��ǰ �ϰ� ���� 
			//**************************************************************************		
			for ( int iUpj = 0; iUpj < ds_MultiUpj.getRowCount(); iUpj++ )
			{
				sChk = nullToBlank(ds_MultiUpj.getString(iUpj, "CHK"));
				if (sChk.equals("0")) continue;
				
				sUpjang = nullToBlank(ds_MultiUpj.getString(iUpj, "UPJANG"));
				//�����ڷ� ����(���ã�� �׷� ���� ����)
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM FMP_FAVORITE \n");			
				sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
//				sbSql.append("   AND SUBSTR(FAVOR_GROUP,8,2) = '01' \n");
				sbSql.append("   AND ITEM_CODE = '" + sItem_Code + "' \n");			
	out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}			
		}		

		/**����**/
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