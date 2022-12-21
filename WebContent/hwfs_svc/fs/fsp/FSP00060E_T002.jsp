<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ű���/���ö�
�� ���α׷�ID   : FSP00060E_T001.jsp
�� ���α׷���   : ���ö� ��������
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
		//�Է� �Ķ����
		String strOrderDate = nullToBlank(in_vl.getString("strOrderDate"));
		String strCcCd      = nullToBlank(in_vl.getString("strCcCd"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\aaa.txt", ds_List);

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//�Է�,����
		sbSql.delete(0, sbSql.length());
		sbSql.append("MERGE INTO FMP_LUNCH_CLS A \n");
		sbSql.append("USING (SELECT '" + strOrderDate + "' AS ORDER_DATE \n");
		sbSql.append("            , '" + strCcCd + "' AS CC_CD \n");
		sbSql.append("         FROM DUAL) B \n");
		sbSql.append("   ON (A.ORDER_DATE = B.ORDER_DATE AND \n");
		sbSql.append("       A.CC_CD = B.CC_CD) \n");
		sbSql.append(" WHEN MATCHED THEN \n");
		sbSql.append("      UPDATE \n");
		sbSql.append("         SET A.OPEN_FLAG = DECODE(A.OPEN_FLAG,'Y','N','Y') \n");
		sbSql.append("           , A.UDATE = SYSDATE \n");
		sbSql.append("           , A.UUSER = '" + g_EmpNo + "' \n");
		sbSql.append(" WHEN NOT MATCHED THEN \n");
		sbSql.append("      INSERT ( A.ORDER_DATE \n");
		sbSql.append("             , A.CC_CD \n");
		sbSql.append("             , A.OPEN_FLAG \n");
		sbSql.append("             , A.CDATE \n");
		sbSql.append("             , A.CUSER \n");
		sbSql.append("             , A.UDATE \n");
		sbSql.append("             , A.UUSER ) \n");
		sbSql.append("      VALUES ( B.ORDER_DATE \n");
		sbSql.append("             , B.CC_CD \n");
		sbSql.append("             , 'Y' \n");
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