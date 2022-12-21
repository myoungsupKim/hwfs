<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ܰ�����/���޾�ü����
�� ���α׷�ID   : FMU00250E_T002.jsp
�� ���α׷���   : /��ܰ��� ����� ����(����)
�� �ۼ�����     : 2008.05.14
�� �ۼ���       : ������
�� �̷°���     : 2008.05.14
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
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//�����ڷ� ����
		sbSql.append("DELETE FROM FMU_OP_RATE A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANGT")) + " \n");
		sbSql.append("   AND A.SDATE  = '" + nullToBlank(ds_Cond.getString(0, "SDATET")) + "' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();

		//�Է�
		//�Է�ó��Sql
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO FMU_OP_RATE \n");
		sbSql.append("( UPJANG \n");
		sbSql.append(", SDATE \n");
		sbSql.append(", ITEM_CODE \n");
		sbSql.append(", EDATE \n");
		sbSql.append(", OP_RATE \n");
		sbSql.append(", CEIL_VAL \n");
		sbSql.append(", OP_PRICE \n");
		sbSql.append(", CUSER \n");
		sbSql.append(", CDATE \n");
		sbSql.append(", UUSER \n");
		sbSql.append(", UDATE \n");
		sbSql.append(") VALUES \n");
		sbSql.append("( ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		//�� ��� ���� ������ ��� ��ȸ(������ ����)
		sbSql.append(", NVL((SELECT /*+ INDEX_ASC(Z FMU_OP_RATE_PK) */ \n");
		sbSql.append("              TO_CHAR(TO_DATE(Z.SDATE,'YYYYMMDD')-1,'YYYYMMDD') \n");
		sbSql.append("         FROM FMU_OP_RATE Z \n");
		sbSql.append("        WHERE Z.UPJANG = ? \n");
		sbSql.append("          AND Z.SDATE > ? \n");
		sbSql.append("          AND Z.ITEM_CODE = ? \n");
		sbSql.append("          AND ROWNUM <= 1), '20291231') \n");
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
		sbSql.append("UPDATE /*+ INDEX_DESC(A FMU_OP_RATE_PK) */ FMU_OP_RATE A \n");
		sbSql.append("   SET A.EDATE = TO_CHAR(TO_DATE(?,'YYYYMMDD')-1,'YYYYMMDD') \n");
		sbSql.append(" WHERE A.UPJANG = ? \n");
		sbSql.append("   AND A.SDATE < ? \n");
		sbSql.append("   AND A.ITEM_CODE = ? \n");
		sbSql.append("   AND ROWNUM <= 1 \n");
		pstmt2 = conn.prepareStatement(sbSql.toString());
		//�Է�
		for ( int iRow = 0; iRow < ds_List.getRowCount(); iRow++ )
		{
			//�Է�ó��
			pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "UPJANGT")));
			pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "SDATET")));
			pstmt.setString(3, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(4, nullToBlank(ds_Cond.getString(0, "UPJANGT")));
			pstmt.setString(5, nullToBlank(ds_Cond.getString(0, "SDATET")));
			pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			pstmt.setString(7, nullToBlank(ds_List.getString(iRow, "OP_RATE")));
			pstmt.setString(8, nullToBlank(ds_List.getString(iRow, "CEIL_VAL")));
			pstmt.setString(9, nullToBlank(ds_List.getString(iRow, "OP_PRICE")));
			pstmt.setString(10, g_EmpNo);
			pstmt.setString(11, g_EmpNo);
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�

			//�� ��� ���� ������ ����
			pstmt2.setString(1, nullToBlank(ds_Cond.getString(0, "SDATET")));
			pstmt2.setString(2, nullToBlank(ds_Cond.getString(0, "UPJANGT")));
			pstmt2.setString(3, nullToBlank(ds_Cond.getString(0, "SDATET")));
			pstmt2.setString(4, nullToBlank(ds_List.getString(iRow, "ITEM_CODE")));
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt2.addBatch(); //���������� ������ ���� ��ġ�߰�
		}
		pstmt.executeBatch(); //��ġó��
		pstmt2.executeBatch(); //��ġó��
		pstmt.close();
		pstmt2.close();

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