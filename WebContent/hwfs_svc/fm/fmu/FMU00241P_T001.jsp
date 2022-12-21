<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ܰ�����/���޾�ü����
�� ���α׷�ID   : FMU00241P_T001.jsp
�� ���α׷���   : ��� ��ϰ���/�з��� ���(��ȸ)
�� �ۼ�����     : 2008.08.04
�� �ۼ���       : ������
�� �̷°���     : [��ȭ]_�����ڵ� ���� ����_�����
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
		String g_Upjang    = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo     = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang     = nullToBlank(in_vl.getString("sUpjang"));
		String sSdate      = nullToBlank(in_vl.getString("sSdate"));
		String sClassType  = nullToBlank(in_vl.getString("sClassType"));

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������ȸ
		sbSql.append("SELECT A.CLASS_CODE \n");
		sbSql.append("     , SUBSTR(A.CLASS_CODE,DECODE('" + sClassType + "','M',2,'S',4,'D',6),2)||' '||A.CLASS_NAME AS CLASS_NAME \n");
		sbSql.append("     , B.OP_RATE \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + sUpjang + " \n");
		//sbSql.append("          AND A.SDATE = '00000000' \n");
		//SDATE='00000000' �������� �Ǿ��־� ������ �ȳ����� ������ ���Ƽ� ���� �ֱ� ���� ������ �������� ���� ��û�� ������ 20170608
        sbSql.append("          AND (A.ITEM_CODE,A.SDATE  ) IN (  SELECT  ITEM_CODE,MAX(SDATE) \n");
        sbSql.append("                         FROM FMU_OP_RATE A  \n");
        sbSql.append("                         WHERE  upjang = " + sUpjang + "  \n");
        //sbSql.append("                         AND  ATTR01 = 'P'  \n");
        sbSql.append("                         AND  NVL(ATTR01, 'NONE') =   \n");
        sbSql.append("								CASE WHEN (SELECT COUNT(1) FROM FMU_OP_RATE WHERE UPJANG = " + sUpjang + " AND ATTR01 = 'P') = 0 THEN 'NONE'	\n");
        sbSql.append("								ELSE 'P'	\n");
        sbSql.append("								END	\n");
        sbSql.append("                        GROUP BY ITEM_CODE )  \n");
		sbSql.append("      ) B \n");
		sbSql.append(" WHERE A.CLASS_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CLASS_CODE LIKE 'F%' \n");
		sbSql.append("   AND A.CLASS_TYPE = '" + sClassType + "' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append("   AND SUBSTR(A.CLASS_CODE, 1, 3) <> 'F28' \n"); // 2015.07.20 ������Ŵ�����û���� 28 ������(��������) ����ó��
		sbSql.append("   AND SUBSTR(A.CLASS_CODE, 1, 3) <> 'F30' \n"); // 2018.03.12 ������Ŵ�����û���� 28 ������(��������) ����ó��
		sbSql.append("   AND SUBSTR(A.CLASS_CODE, 1, 3) <> 'F70' \n"); // 2016.12.27 ������ ��û���� 70 ����ǰ ����ó��
		sbSql.append(" ORDER BY A.CLASS_CODE \n");

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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//�Է� ����Ÿ
		//�Է� �Ķ����
		String g_Upjang    = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo     = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang     = nullToBlank(in_vl.getString("sUpjang"));
		String sSdate      = nullToBlank(in_vl.getString("sSdate"));
		String sClassType  = nullToBlank(in_vl.getString("sClassType"));

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������ȸ
		sbSql.append("SELECT A.CLASS_CODE \n");
		sbSql.append("     , SUBSTR(A.CLASS_CODE,DECODE('" + sClassType + "','M',3,'S',5,'D',7),2)||' '||A.CLASS_NAME AS CLASS_NAME \n");
		sbSql.append("     , B.OP_RATE \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("     ,(SELECT A.ITEM_CODE, A.OP_RATE \n");
		sbSql.append("         FROM FMU_OP_RATE A \n");
		sbSql.append("        WHERE A.UPJANG = " + sUpjang + " \n");
//		if (sClassType.equals("D"))
//			sbSql.append("          AND A.SDATE = '" + sSdate + "' \n");
//		else
			sbSql.append("          AND A.SDATE = '00000000' \n");
		sbSql.append("      ) B \n");
		sbSql.append(" WHERE A.CLASS_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND A.CLASS_CODE LIKE '01%' \n");
		sbSql.append("   AND A.CLASS_TYPE = '" + sClassType + "' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY A.CLASS_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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

--%>
