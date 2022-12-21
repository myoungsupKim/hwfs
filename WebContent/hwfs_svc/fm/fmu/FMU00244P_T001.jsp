<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ܰ�����/���޾�ü����
�� ���α׷�ID   : FMU00240E_T002.jsp
�� ���α׷���   : ��� ��ϰ��� ��������(����)
�� �ۼ�����     : 2008.04.15
�� �ۼ���       : ������
�� �̷°���     : 2008.04.15
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	PreparedStatement pstmt2 = null;	
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
	
		//�Է� ����Ÿ
		DataSet ds_Cond   = in_dl.get("ds_Cond");
		DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);
		
		System.out.println(ds_List.getRowCount());

		//�Է� �Ķ����
		String sUpjang     = nullToBlank(in_vl.getString("Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sSdate      = nullToBlank(in_vl.getString("Sdate"));

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
		int sRowStatus;
		
		/*
		//������ ����
		sbSql.delete(0, sbSql.length());
        sbSql.append("UPDATE FMU_OP_RATE SET EDATE = ?   \n");
        sbSql.append("WHERE UPJANG = '"+sUpjang+"'                     \n");
        sbSql.append("AND SDATE = '"+sSdate+"'                      \n");
        sbSql.append("AND ITEM_TYPE = 'M'                         \n");
        sbSql.append("AND ITEM_CODE = ?                  \n");		
		
		pstmt = conn.prepareStatement(sbSql.toString());
		
		//�Է�
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			//������ ����
			pstmt.setString(1, nullToBlank(ds_List.getString(iRow, "EDATE")));
			pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
		}
		
		pstmt.executeBatch(); //��ġó��
		pstmt.close();
		*/
		
		//�Է�,����
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_List.getRowType(i);
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				/*
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("\n\n");
	
		        sbSql.append("\n\n");
			
				out_vl.add("fa_Sql", sbSql.toString());		
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
		     	// IN
				//sbSql.append("   call SCC_ADDR_PRO('" + nullToBlank(ds_List.getString(i, "ADDR_INFO")) + "', '" + g_EmpNo + "')              \n");
		     
				out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery();
				
				pstmt.close();
				rs.close();
				*/
			}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("\n\n");
		        sbSql.append("UPDATE FMU_OP_RATE SET EDATE = '" + nullToBlank(ds_List.getString(i, "EDATE")) + "'   \n");
		        sbSql.append("WHERE UPJANG = '"+sUpjang+"'                     \n");
		        sbSql.append("AND SDATE = '"+sSdate+"'                      \n");
		        sbSql.append("AND ITEM_TYPE = 'M'                         \n");
		        sbSql.append("AND ITEM_CODE = '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "'                  \n");
		        sbSql.append("\n\n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
			}
		}

		//����
		for ( int i = 0 ; i < ds_List.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("\n\n");
	        sbSql.append("DELETE FMU_OP_RATE\n");
	        sbSql.append("WHERE UPJANG = '"+sUpjang+"'                     \n");
	        sbSql.append("AND SDATE = '"+sSdate+"'                      \n");
	        sbSql.append("AND ITEM_TYPE = 'M'                         \n");
	        sbSql.append("AND ITEM_CODE = '" + ds_List.getRemovedData(i, "ITEM_CODE") + "'                  \n");
	        sbSql.append("\n\n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
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
		if(pstmt2 != null) {
			try {
				pstmt2.close();
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
	
		//�Է� ����Ÿ
		DataSet ds_Cond   = in_dl.get("ds_Cond");
		DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);
	
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));


		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		String sOtcust     = nullToBlank(ds_Cond.getString(0, "OTCUSTCD"));

		/*
		//�����ڷ� ����
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.SDATE  = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("   AND A.EDATE  = '" + nullToBlank(ds_Cond.getString(0, "EDATE")) + "' \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "') \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		
		pstmt.close();
		*/
		
		
		//sql�� ���ۻ���
		//StringBuffer sbSql = new StringBuffer();

		//�����ڷ� ����
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.ITEM_CODE  = ? \n");
		sbSql.append("   AND A.ITEM_TYPE  = 'M' \n");
		sbSql.append("   AND A.SDATE  = ? \n");
		sbSql.append("   AND A.EDATE  = ? \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "') \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			pstmt.setString(1, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "EDATE")));
			
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
		}	
		pstmt.executeBatch(); //��ġó��
		pstmt.close();
		
		//�Է�
		String sSql;
		sSql = "INSERT INTO FMU_OP_RATE(UPJANG, ITEM_TYPE, SDATE, EDATE, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, CUSER, CDATE, UUSER, UDATE) " +
               "VALUES (?,'M',?,?,?,?,?,?,?,SYSDATE,?,SYSDATE)";
		pstmt = conn.prepareStatement(sSql);
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			//if ((Double.parseDouble(ds_List.getString(iRow, "OP_RATE")) == 0) &&
			//	(Double.parseDouble(ds_List.getString(iRow, "OP_PRICE")) == 0)) continue;

			//�Է�
			//pstmt.setString(1, nullToBlank(ds_List.getString(iRow, "UPJANG")));
			//pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			//pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "EDATE")));
			pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_List.getString(iRow, "SDATE")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "EDATE")));
			pstmt.setString(4, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(5, nullToBlank(ds_List.getString(iRow, "OP_RATE")));
			pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "OP_PRICE")));
			pstmt.setString(7, nullToBlank(ds_List.getString(iRow, "CEIL_VAL")));
			pstmt.setString(8, g_EmpNo);
			pstmt.setString(9, g_EmpNo);
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
		}
		pstmt.executeBatch(); //��ġó��
		pstmt.close();

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

--%>