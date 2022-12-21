<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ű���/���ö�
�� ���α׷�ID   : FSP00040E_T001.jsp
�� ���α׷���   : ���ö� �ֹ�����
�� �ۼ�����     : 2012-09-10
�� �ۼ���       : ������
�� �̷°���     : 2012-09-10 ������ �����ۼ� CH201209_00102 FS��ȹ��
                2013-07-05 �赿ǥ ���� CH201209_00102 ��ȸ������ ���Ͽ�
                                     ���ö��޴��� A,B -> A,B,C,D,E�� Ȯ��
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//�Է� ����Ÿ
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//�Է�,����
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
		{
			if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			//����üũ
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT 1 FROM FMP_LUNCH_CLS A \n");
			sbSql.append(" WHERE A.ORDER_DATE = '" + nullToBlank(ds_List.getString(iRow, "ORDER_DATE")) + "' \n");
			sbSql.append("   AND A.CC_CD = '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' \n");
			sbSql.append("   AND A.OPEN_FLAG = 'Y' \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append("SELECT 1 FROM DUAL \n");
			sbSql.append(" WHERE TO_CHAR(SYSDATE+NVL(" + nullToBlank(ds_Cond.getString(0, "CDAY")) + ",0),'YYYYMMDDHH24MI') < '" + nullToBlank(ds_List.getString(iRow, "ORDER_DATE")) + "'||'" + nullToBlank(ds_Cond.getString(0, "CTIME")) + "' \n");
			out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());		
			rs = pstmt.executeQuery();
			if(! rs.next())
			{
				this.setResultMessage(-1, nullToBlank(ds_List.getString(iRow, "ORDER_DATE_DISP")) + " �ֹ��� �����ð��� �ʰ��Ͽ����ϴ�.", out_vl);
				conn.rollback();
				proc_output(response,out,out_vl,out_dl);
				return;
			}	
			rs.close();
			pstmt.close();

			//����
			sbSql.delete(0, sbSql.length());
			sbSql.append("MERGE INTO FMP_LUNCH A \n");
			sbSql.append("USING (SELECT '" + nullToBlank(ds_List.getString(iRow, "ORDER_DATE")) + "' AS ORDER_DATE \n");
			sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "SABUN")) + "' AS SABUN \n");
			sbSql.append("         FROM DUAL) B \n");
			sbSql.append("   ON (A.ORDER_DATE = B.ORDER_DATE AND \n");
			sbSql.append("       A.SABUN = B.SABUN) \n");
			sbSql.append(" WHEN MATCHED THEN \n");
			sbSql.append("      UPDATE \n");
			sbSql.append("         SET A.QTY_A = " + nullToBlank(ds_List.getString(iRow, "QTY_A")) + " \n");
			sbSql.append("           , A.QTY_B = " + nullToBlank(ds_List.getString(iRow, "QTY_B")) + " \n");
			
			sbSql.append("           , A.QTY_C = " + nullToBlank(ds_List.getString(iRow, "QTY_C")) + " \n");
			
			sbSql.append("           , A.QTY_D = " + nullToBlank(ds_List.getString(iRow, "QTY_D")) + " \n");
			
			sbSql.append("           , A.QTY_E = " + nullToBlank(ds_List.getString(iRow, "QTY_E")) + " \n");
			sbSql.append("           , A.DEPT_ID = (SELECT Z.DEPT_ID FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = B.SABUN) \n");
			sbSql.append("           , A.UDATE = SYSDATE \n");
			sbSql.append("           , A.UUSER = '" + g_EmpNo + "' \n");
			sbSql.append(" WHEN NOT MATCHED THEN \n");
			sbSql.append("      INSERT ( A.ORDER_DATE \n");
			sbSql.append("             , A.SABUN \n");
			sbSql.append("             , A.QTY_A \n");
			sbSql.append("             , A.QTY_B \n");
			
			sbSql.append("             , A.QTY_C \n");
			
			sbSql.append("             , A.QTY_D \n");
			
			sbSql.append("             , A.QTY_E \n");
			sbSql.append("             , A.DEPT_ID \n");
			sbSql.append("             , A.CDATE \n");
			sbSql.append("             , A.CUSER \n");
			sbSql.append("             , A.UDATE \n");
			sbSql.append("             , A.UUSER ) \n");
			sbSql.append("      VALUES ( B.ORDER_DATE \n");
			sbSql.append("             , B.SABUN \n");
			sbSql.append("             , " + nullToBlank(ds_List.getString(iRow, "QTY_A")) + " \n");
			sbSql.append("             , " + nullToBlank(ds_List.getString(iRow, "QTY_B")) + " \n");
			
			sbSql.append("             , " + nullToBlank(ds_List.getString(iRow, "QTY_C")) + " \n");
			
			sbSql.append("             , " + nullToBlank(ds_List.getString(iRow, "QTY_D")) + " \n");
			
			sbSql.append("             , " + nullToBlank(ds_List.getString(iRow, "QTY_E")) + " \n");
			sbSql.append("             , (SELECT Z.DEPT_ID FROM HLDC_HR_PERSONAL Z WHERE Z.SABUN = B.SABUN) \n");
			sbSql.append("             , SYSDATE \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             , SYSDATE \n");
			sbSql.append("             , '" + g_EmpNo + "' \n");
			sbSql.append("             ) \n");

out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
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