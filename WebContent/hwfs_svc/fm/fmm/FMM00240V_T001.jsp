<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/��Ȳ����
�� ���α׷�ID   : FMM00240V_T001.jsp
�� ���α׷���   : ���缺�� �м�ǥ(�������)
�� �ۼ�����     : 2008-04-08
�� �ۼ���       : ������
�� �̷°���     : 2008-04-08 - �����ۼ�
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
		sbSql.append("SELECT A.UPJANG, A.MENU_CD, A.MENU_NAME \n");
		sbSql.append("     , B.CODE_NAME||C.CODE_NAME AS MEAL_CORNER \n");
		sbSql.append("     , FMM_RECIPENAME_FUN(A.UPJANG, A.MENU_CD, '1') AS MENU_DISP \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , A.EXPECT_MEAL_QTY \n");
		sbSql.append("     , '0' AS CHK \n");
		sbSql.append("  FROM FMM_MENU A, FMS_MEAL_CORNER A2 \n");
		sbSql.append("     ,(SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') B \n");
		sbSql.append("     ,(SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') C \n");
		sbSql.append(" WHERE A.MEAL = B.CODE \n");
		sbSql.append("   AND A.CORNER = C.CODE \n");
		sbSql.append("   AND A.SUBINV_CODE = A2.SUBINV_CODE \n");
		sbSql.append("   AND A.MEAL = A2.MEAL \n");
		sbSql.append("   AND A.CORNER = A2.CORNER \n");
		sbSql.append("   AND A2.USE_YN = 'Y' \n");
		sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + " \n");
		sbSql.append("   AND A.MENU_DATE = '" + nullToBlank(ds_cond.getString(0,"MENU_DATE")) + "' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0,"SUBINV_CODE")) + "' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();		
		//FileLog.println("d:\\aaa.txt", ds_List);

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