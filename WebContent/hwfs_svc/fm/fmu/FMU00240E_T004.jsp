<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ܰ�����/���޾�ü����
�� ���α׷�ID   : FMU00240E_T004.jsp
�� ���α׷���   : ��� ��ϰ���(����)
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
		DataSet ds_UpjLst = in_dl.get("ds_UpjLst");
	
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sOtcust      = nullToBlank(in_vl.getString("sOtcust"));

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
		//�����ڷ� ����
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = ? \n");
		sbSql.append("   AND A.SDATE  = ? \n");
		sbSql.append("   AND A.ITEM_TYPE  = 'M' \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = ?) \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		//�Է�
		for ( int iRow = 0; iRow < ds_UpjLst.getRowCount(); iRow++ )
		{
			pstmt.setString(1, nullToBlank(ds_UpjLst.getString(iRow, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "SDATE")));
			pstmt.setString(3, sOtcust);
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
		}	
		pstmt.executeBatch(); //��ġó��
		pstmt.close();
		
		
		//�Է�ó��Sql
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO FMU_OP_RATE \n");
		sbSql.append("( UPJANG \n");
		sbSql.append(", ITEM_TYPE \n");
		sbSql.append(", SDATE \n");
		sbSql.append(", ITEM_CODE \n");
		sbSql.append(", EDATE \n");
		sbSql.append(", OP_PRICE \n");
		sbSql.append(", OP_RATE \n");
		sbSql.append(", CEIL_VAL \n");
		sbSql.append(", CUSER \n");
		sbSql.append(", CDATE \n");
		sbSql.append(", UUSER \n");
		sbSql.append(", UDATE \n");
		sbSql.append(") VALUES \n");
		sbSql.append("( ? \n");
		sbSql.append(", 'M' \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		//�� ��� ���� ������ ��� ��ȸ(������ ����) �߰��� ������쿡�� 99991231�� �ƴ϶� ���� ����� ��������
		sbSql.append(", NVL((SELECT /*+ INDEX_ASC(Z FMU_OP_RATE_PK) */ \n");
		sbSql.append("              TO_CHAR(TO_DATE(Z.SDATE,'YYYYMMDD')-1,'YYYYMMDD') \n");
		sbSql.append("         FROM FMU_OP_RATE Z \n");
		sbSql.append("        WHERE Z.UPJANG = ? \n");
		sbSql.append("          AND Z.SDATE > ? \n");
		sbSql.append("          AND Z.ITEM_CODE = ? \n");
		sbSql.append("          AND Z.ITEM_TYPE = 'M' \n");
		sbSql.append("          AND ROWNUM <= 1), ?) \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(", ? \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(") \n");
		pstmt = conn.prepareStatement(sbSql.toString());
	
		//�� ��� ���� ������ ����
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FMU_OP_RATE A \n");
		sbSql.append("   SET A.EDATE = TO_CHAR(TO_DATE(?,'YYYYMMDD')-1,'YYYYMMDD') \n");
		sbSql.append(" WHERE A.UPJANG = ? \n");
		//sbSql.append("   AND A.SDATE < ? \n");
		sbSql.append("   AND A.SDATE = (SELECT MAX(SDATE) FROM FMU_OP_RATE WHERE UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND ITEM_TYPE = 'M' AND SDATE < ?) \n");
		sbSql.append("   AND A.SDATE <> '00000000' \n");
		sbSql.append("   AND A.ITEM_CODE = ? \n");
		sbSql.append("   AND A.ITEM_TYPE = 'M' \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
		pstmt2 = conn.prepareStatement(sbSql.toString());

		//�Է�
		for ( int iRow = 0; iRow < ds_UpjLst.getRowCount(); iRow++ )
		{
			for ( int JRow = 0; JRow < ds_List.getRowCount(); JRow++ )
			{
				//�Է�ó��
				pstmt.setString(1, nullToBlank(ds_UpjLst.getString(iRow, "UPJANG")));
				pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "SDATE")));
				pstmt.setString(3, nullToBlank(ds_List.getString(JRow, "ITEM_CODE")));
				pstmt.setString(4, nullToBlank(ds_UpjLst.getString(iRow, "UPJANG")));
				pstmt.setString(5, nullToBlank(ds_Cond.getString(0, "SDATE")));
				pstmt.setString(6, nullToBlank(ds_List.getString(JRow, "ITEM_CODE")));
				pstmt.setString(7, nullToBlank(ds_List.getString(JRow, "EDATE")));
				pstmt.setString(8, nullToBlank(ds_List.getString(JRow, "OP_PRICE")));
				pstmt.setString(9, nullToBlank(ds_List.getString(JRow, "OP_RATE")));
				pstmt.setString(10, nullToBlank(ds_List.getString(JRow, "CEIL_VAL")));
				pstmt.setString(11, g_EmpNo);
				pstmt.setString(12, g_EmpNo);
				//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
				pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�

				//�� ��� ���� ������ ����
				pstmt2.setString(1, nullToBlank(ds_Cond.getString(0, "SDATE")));
				pstmt2.setString(2, nullToBlank(ds_UpjLst.getString(iRow, "UPJANG")));
				pstmt2.setString(3, nullToBlank(ds_Cond.getString(0, "SDATE")));
				pstmt2.setString(4, nullToBlank(ds_List.getString(JRow, "ITEM_CODE")));
				//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
				pstmt2.addBatch(); //���������� ������ ���� ��ġ�߰�
			}
		}
		pstmt.executeBatch(); //��ġó��
		pstmt2.executeBatch(); //��ġó��
		pstmt.close();
		pstmt2.close();

		
		/*
		//����Sql
		sbSql.delete(0, sbSql.length());
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = ? \n");
		sbSql.append("   AND A.SDATE  = ? \n");
		sbSql.append("   AND A.ITEM_TYPE  = 'M' \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = ?) \n");
		//
		pstmt = conn.prepareStatement(sbSql.toString());
		
		for ( int iRow = 0; iRow < ds_UpjLst.getRowCount(); iRow++ )
		{
			pstmt.setString(1, nullToBlank(ds_UpjLst.getString(iRow, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "SDATE")));
			pstmt.setString(3, sOtcust);
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
		}	
		pstmt.executeBatch(); //��ġó��
		pstmt.close();
		*/
		
		/*
		//�Է�Sql
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO FMU_OP_RATE \n");
		sbSql.append("(UPJANG, ITEM_TYPE, SDATE, EDATE, ITEM_CODE, OP_RATE, CEIL_VAL, OP_PRICE, USE_YN, CUSER, CDATE, UUSER, UDATE) \n");
		sbSql.append("SELECT ?, 'M', SDATE, EDATE, ITEM_CODE, OP_RATE, CEIL_VAL, OP_PRICE, USE_YN, CUSER, SYSDATE, UUSER, SYSDATE \n");
		sbSql.append("  FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = ? \n");
		sbSql.append("   AND A.SDATE  = ? \n");
		sbSql.append("   AND A.ITEM_TYPE  = 'M' \n");
		if (! sOtcust.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = ?) \n");
		//
		pstmt = conn.prepareStatement(sbSql.toString());
		
		//�Է�
		for ( int iRow = 0; iRow < ds_UpjLst.getRowCount(); iRow++ )
		{
			//�Է�ó��
			pstmt.setString(1, nullToBlank(ds_UpjLst.getString(iRow, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "UPJANG")));
			pstmt.setString(3, nullToBlank(ds_Cond.getString(0, "SDATE")));
			pstmt.setString(4, sOtcust);
			
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
		}
		
		pstmt.executeBatch(); //��ġó��
		pstmt.close();
		*/
		
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