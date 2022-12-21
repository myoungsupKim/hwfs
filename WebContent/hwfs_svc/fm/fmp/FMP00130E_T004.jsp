<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ֹ�����
�� ���α׷�ID   : FMP00130E_T004.jsp
�� ���α׷���   : ���������� ����
�� �ۼ�����     : 2008.01.21
�� �ۼ���       : ������
�� �̷°���     : 2009-03-16 ������ CSR#(25384) ��û��:������(fs��ȹ��)
               ���� �ۼ�
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
		//DataSet ds_List     = in_dl.get("ds_List");
		//�Է� �Ķ����
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sItemCode    = nullToBlank(in_vl.getString("sItemCode"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
			
		int iInsCnt         = 0;
		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();


		//�Ĵܺ���
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
		sbSql.append("   SET A.PR_YN  = 'N' \n");
		sbSql.append("     , A.PR_ID  = NULL \n");
		sbSql.append("     , A.PR_NUM = NULL \n");
		sbSql.append("     , A.PR_QTY = 0 \n");
		sbSql.append("     , A.UUSER  = '" + g_EmpNo + "' \n");
		sbSql.append("     , A.UDATE  = SYSDATE \n");
		sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND A.NEED_DATE = '" + sNeedDate + "' \n");
		sbSql.append("   AND A.ITEM_CODE = '" + sItemCode + "' \n");
		sbSql.append("   AND A.PR_YN  = 'Y' \n");
		sbSql.append("   AND A.PR_ID  = -999 \n");
		sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
		sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
		sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
		sbSql.append("                  AND B.UPJANG = " + sUpjang + " \n");
		sbSql.append("                  AND B.SUBINV_CODE = '" + sSubinv + "') \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		iInsCnt = pstmt.executeUpdate();
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