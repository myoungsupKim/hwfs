<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ܰ�����/���޾�ü����
�� ���α׷�ID   : FMU00270E_T003.jsp
�� ���α׷���   : ��� ���߾��� ��ȸ(��ȸ)
�� �ۼ�����     : 2008.04.14
�� �ۼ���       : ������
�� �̷°���     : [��ȭ]_��� ���뱸�� �ּ�ó��_�����
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
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������ȸ
		sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP, B.SAVE_CNT, C.CLASS_CNT, B.OP_RATE_AVG, '0' AS CHK, B.SDATE  \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("     , (SELECT A.UPJANG, COUNT(1) AS SAVE_CNT, ROUND(NVL(AVG(OP_RATE),0),1) AS OP_RATE_AVG, MAX(A.SDATE) AS SDATE \n");
		sbSql.append("          FROM FMU_OP_RATE A, \n");
		sbSql.append("        ( \n");
        sbSql.append("        SELECT A.UPJANG, MAX(SDATE) AS SDATE \n");
		sbSql.append("          FROM FMU_OP_RATE A \n");
		sbSql.append("         WHERE 1=1 \n");
		sbSql.append("           AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") \n");
		sbSql.append("           AND A.ITEM_TYPE = 'C' \n");
		sbSql.append("           AND A.USE_YN = 'Y' \n");
		sbSql.append("         GROUP BY A.UPJANG \n");		
		sbSql.append("         ) B \n");
		sbSql.append("         WHERE 1=1 \n");
		sbSql.append("           AND A.UPJANG = B.UPJANG \n");
		sbSql.append("           AND A.SDATE = B.SDATE \n");
		sbSql.append("           AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") \n");
		sbSql.append("           AND A.ITEM_TYPE = 'C' \n");
		sbSql.append("           AND A.USE_YN = 'Y' \n");
		sbSql.append("         GROUP BY A.UPJANG) B \n");
		sbSql.append("     , (SELECT COUNT(1) AS CLASS_CNT \n");
		sbSql.append("          FROM HLDC_PO_ITEM_CLASS A \n");
		sbSql.append("         WHERE A.CLASS_TYPE = 'D' \n");
		sbSql.append("           AND (A.CLASS_CODE LIKE 'F%') \n");
		sbSql.append("           AND A.USE_YN = 'Y') C \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		//sbSql.append("   AND A.OP_RATE_YN = 'C' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY 1 \n");

		out_vl.add("fa_Sql", sbSql.toString());
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close(); 
		pstmt.close();		

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
