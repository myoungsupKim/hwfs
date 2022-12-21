<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/���Ұ���
�� ���α׷�ID   : FMP00200V_T001.jsp
�� ���α׷���   : �԰�Ȯ�� �� ��ǰ��ȸ
�� �ۼ�����     : 2008.01.22
�� �ۼ���       : ������
�� �̷°���     : 2008.01.22
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������ȸ
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		sbSql.append("     , DECODE(A.TAX_CODE,'100','����','210','�鼼','����') AS TAX_CODE \n");
		sbSql.append("     , (A.ADJUST_QTY + A.PO_QTY) AS PR_QTY \n");
		sbSql.append("     , (A.ADJUST_QTY + A.CENTER_UNDELI_QTY + A.UNDELIVERED_QTY + A.RETURNED_QTY) AS RTN_QTY \n");
		sbSql.append("     , (A.DELIVERED_QTY - A.RETURNED_QTY) AS IN_QTY \n");
		sbSql.append("     , B.CODE_NAME AS LINE_STATUS \n");
		sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
		sbSql.append("     , DECODE(LINE_STATUS, 'GC', '�԰�Ȯ��', 'IV', '�԰�Ȯ��', '�԰���') AS STATUS \n");
		sbSql.append("  FROM (SELECT A.*, B.ORIGIN_TYPE FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A, (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0037') B \n");
		sbSql.append(" WHERE A.LINE_STATUS = B.CODE \n");
		sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		//sbSql.append("   AND A.LINE_STATUS = DECODE('" + nullToBlank(ds_cond.getString(0, "LINE_STATUS")) + "','%',A.LINE_STATUS,'" + nullToBlank(ds_cond.getString(0, "LINE_STATUS")) + "') \n");
		sbSql.append("   AND (A.ADJUST_QTY + A.PO_QTY) > 0 \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**����**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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
