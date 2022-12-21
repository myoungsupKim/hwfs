<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �޴�����/�������/��ȹ���� �����Ȳ ��ȸ
�� ���α׷�ID   : FSI00095V_T001.jsp
�� ���α׷���   : �м����(�پ缺)
�� �ۼ�����     : 2013-11-13
�� �ۼ���       : �����
�� �̷°���     : 
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
		//FileLog.println("d:\\aaa.txt", ds_cond
		
		String strFromDt = nullToBlank(ds_Cond.getString(0, "FROM_DT"));
		String strToDt	 = nullToBlank(ds_Cond.getString(0, "TO_DT"));
		String strTmCd	 = nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String strUpjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		
		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		//������ȸ
		sbSql.append("WITH T AS \n");
		sbSql.append("( \n");
		sbSql.append("    SELECT /*+ ORDERED USE_NL(B A) */ \n");
		sbSql.append("           A.TRANS_UPJANG AS UPJANG                         /* ���� */ \n");
		sbSql.append("         , (SELECT COUNT(DISTINCT REP_ITEM_CODE) \n");
		sbSql.append("              FROM FSI_DUTY_MST   \n");
		sbSql.append("             WHERE CENTER_CODE = (SELECT CENTER_CODE  \n");
		sbSql.append("                                    FROM HLDC_PO_UPJANG_CENTER \n");
		sbSql.append("                                   WHERE UPJANG = A.TRANS_UPJANG)  \n");
		sbSql.append("               AND START_DATE <= '" + strToDt + "' AND END_DATE >= '" + strFromDt + "' \n");
		sbSql.append("           ) AS CENT_ALL_ITEM_CNT                           /* ���Ϳ� ���� �� ��ȹ����� */  \n");
		sbSql.append("         , COUNT(DISTINCT B.REP_ITEM_CODE) AS REP_ITEM_CNT  /* ���忡�� ����ϴ� ��ȹ��������� */ \n");
		sbSql.append("      FROM FSI_DUTY_MST B   \n");
		sbSql.append("         , HLDC_PO_TRANSACTION    A \n");
		sbSql.append("     WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("       AND A.CUSTCD = B.CUSTCD  \n");
		sbSql.append("       AND A.ITEM_CODE = B.ITEM_CODE   \n");
		sbSql.append("       AND A.TRANS_DATE BETWEEN GREATEST(B.START_DATE,'" + strFromDt + "') AND LEAST(B.END_DATE,'" + strToDt + "') \n");
		sbSql.append("       AND B.START_DATE <= '" + strToDt + "' AND B.END_DATE >= '" + strFromDt + "'    \n");
		sbSql.append("       AND A.TRANS_MU_CD = 'YA'     \n");
		sbSql.append("       AND A.SUBINV_CODE LIKE 'C%'       \n");
		sbSql.append("       AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))      \n");
		sbSql.append("     GROUP BY A.TRANS_UPJANG    \n");
		sbSql.append(" )  \n");
		sbSql.append(" SELECT A.TM_CD      \n");
		sbSql.append("      , A.TM_NAME    \n");
		sbSql.append("      , A.JOB_CD     \n");
		sbSql.append("      , A.JOB_NAME   \n");
		sbSql.append("      , A.SUB_JOB_CD     \n");
		sbSql.append("      , A.SUB_JOB_NAME    \n");
		sbSql.append("      , A.UPJANG    \n");
		sbSql.append("      , A.UPJANGNM    \n");
		sbSql.append("      , C.CENT_ALL_ITEM_CNT    \n");
		sbSql.append("      , C.REP_ITEM_CNT    \n");
		sbSql.append("      , ROUND(DECODE(C.CENT_ALL_ITEM_CNT, 0, 0, (C.REP_ITEM_CNT/C.CENT_ALL_ITEM_CNT)*100), 2) AS RATE /* �پ缺(%) */    \n");
		sbSql.append(" FROM MAC_UPJANG_V A    \n");
		sbSql.append("     , T C    \n");
		sbSql.append(" WHERE 1=1    \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG    \n");
		
		// ������
		if (! strTmCd.equals(""))
			sbSql.append("   AND A.TM_CD = '" + strTmCd + "' \n");
		
		// ���弱��
		if (! strUpjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
		sbSql.append(" ORDER BY A.TM_NAME, A.UPJANGNM \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
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