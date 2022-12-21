<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ܰ�����/���޾�ü����
�� ���α׷�ID   : FMU00250E_T001.jsp
�� ���α׷���   : /��ܰ��� ����� ����(��ȸ)
�� �ۼ�����     : 2008.05.14
�� �ۼ���       : ������
�� �̷°���     : 2008.05.14
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
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		String strOpRateGb;

		//��� ����
		sbSql.append("SELECT A.OP_RATE_YN \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		rs.next();
		strOpRateGb = rs.getString("OP_RATE_YN");
		pstmt.close();
		rs.close();

out_vl.add("fa_OpRate_gb", strOpRateGb);

		//������ȸ
		sbSql.delete(0, sbSql.length());
		//�Һз���
		if (strOpRateGb.equals("C"))
		{
			sbSql.append("SELECT SUBSTR(A.ITEM_CODE,1,4)||'0000' AS ITEM_CLASS2 \n");
			sbSql.append("     , (SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = SUBSTR(A.ITEM_CODE,1,4)||'0000') AS CLASS_NAME2 \n");
			sbSql.append("     , SUBSTR(A.ITEM_CODE,1,6)||'00' AS ITEM_CLASS3 \n");
			sbSql.append("     , (SELECT Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = SUBSTR(A.ITEM_CODE,1,6)||'00') AS CLASS_NAME3 \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , C.CLASS_NAME AS ITEM_NAME \n");
			sbSql.append("     , A.OP_RATE \n");
			sbSql.append("     , A.CEIL_VAL \n");
			sbSql.append("     , A.OP_PRICE \n");
			sbSql.append("     , B.OP_RATE AS OP_RATET \n");
			sbSql.append("     , B.CEIL_VAL AS CEIL_VALT \n");
			sbSql.append("     , B.OP_PRICE AS OP_PRICET \n");
			sbSql.append("  FROM (SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.OP_PRICE \n");
			sbSql.append("          FROM FMU_OP_RATE A \n");
			sbSql.append("         WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("           AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append("           AND A.USE_YN = 'Y') A \n");
			sbSql.append("     , (SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.OP_PRICE \n");
			sbSql.append("          FROM FMU_OP_RATE A \n");
			sbSql.append("         WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANGT")) + " \n");
			sbSql.append("           AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATET")) + "' \n");
			sbSql.append("           AND A.USE_YN = 'Y') B \n");
			sbSql.append("     ,(SELECT Z.CLASS_CODE, Z.CLASS_NAME \n");
			sbSql.append("         FROM HLDC_PO_ITEM_CLASS_HLDC_V Z \n");
			sbSql.append("        WHERE Z.CLASS_CODE LIKE '01%' \n");
			sbSql.append("          AND Z.CLASS_TYPE = 'D') C \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.CLASS_CODE \n");
			sbSql.append(" ORDER BY A.ITEM_CODE \n");
		}
		//���纰
		else if (strOpRateGb.equals("I"))
		{
			sbSql.append("SELECT (SELECT SUBSTR(Z.CLASS_CODE,3,2)||' '||Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS2) AS CLASS_NAME2 \n");
			sbSql.append("     , (SELECT SUBSTR(Z.CLASS_CODE,5,2)||' '||Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS3) AS CLASS_NAME3 \n");
			sbSql.append("     , (SELECT SUBSTR(Z.CLASS_CODE,7,2)||' '||Z.CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS4) AS CLASS_NAME4 \n");
			sbSql.append("     , A.ITEM_CODE, C.ITEM_NAME \n");
			sbSql.append("     , A.OP_RATE \n");
			sbSql.append("     , A.CEIL_VAL \n");
			sbSql.append("     , A.OP_PRICE \n");
			sbSql.append("     , B.OP_RATE AS OP_RATET \n");
			sbSql.append("     , B.CEIL_VAL AS CEIL_VALT \n");
			sbSql.append("     , B.OP_PRICE AS OP_PRICET \n");
			sbSql.append("  FROM (SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.OP_PRICE \n");
			sbSql.append("          FROM FMU_OP_RATE A \n");
			sbSql.append("         WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("           AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append("           AND A.USE_YN = 'Y') A \n");
			sbSql.append("     , (SELECT A.ITEM_CODE, A.OP_RATE, A.CEIL_VAL, A.OP_PRICE \n");
			sbSql.append("          FROM FMU_OP_RATE A \n");
			sbSql.append("         WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANGT")) + " \n");
			sbSql.append("           AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATET")) + "' \n");
			sbSql.append("           AND A.USE_YN = 'Y') B \n");
			sbSql.append("     , FMS_ITEM_V C \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append(" ORDER BY C.ITEM_CLASS4, A.ITEM_CODE \n");
		}
		else
		{
			this.setResultMessage(-1, "�ش� ������ ��� ��뼳���� ���� �ʾҽ��ϴ�!", out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;			
		}

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
