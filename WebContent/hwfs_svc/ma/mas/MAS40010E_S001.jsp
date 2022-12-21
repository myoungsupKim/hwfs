<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �濵����/���ͽ���
�� ���α׷�ID   : MAS40010E_S001.jsp
�� ���α׷���   : �����Ͱ�ȹ����
�� �ۼ�����     : 2013-12-10
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
		
//System.out.println(ds_Cond.getString(0, "INPUT_YM") + "<<<-------------------------------------");
//System.out.println(ds_Cond.getString(1, "INPUT_YM") + "<<<-------------------------------------");
//System.out.println(ds_Cond.getString(2, "INPUT_YM") + "<<<-------------------------------------");
		
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out ����Ÿ
		DataSet ds_List;
		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		sbSql.append("        SELECT A10.MGMT_ACCT_CD                                                 \n");
        sbSql.append("             , A10.MGMT_ACCT_NAME                                               \n");
        sbSql.append("             , A10.ACCT_LEVEL                                                   \n");
        sbSql.append("             , A10.ACCT_TYPE                                                    \n");
        sbSql.append("             , B10.P_DATE                                                       \n");
        sbSql.append("             , 0 ACT_AMT                                                        \n");
        sbSql.append("             , A10.INPUT_YN                                                     \n");
        sbSql.append("          FROM (                                                                \n");
        sbSql.append("                SELECT A.MGMT_ACCT_CD AS MGMT_ACCT_CD                           \n");
        sbSql.append("                 	 , A.MGMT_ACCT_NAME AS MGMT_ACCT_NAME                         \n");
        sbSql.append("                	 , A.PC_CLASS AS PC_CLASS                                      \n");
        sbSql.append("                	 , A.ACCT_LEVEL AS ACCT_LEVEL                                  \n");
        sbSql.append("                	 , A.ACCT_TYPE                                                 \n");
        sbSql.append("                	 , A.ATTR01 AS INPUT_YN                                        \n");
        sbSql.append("                  FROM MAC_MGMT_ACCT       A                                    \n");
        sbSql.append("                 WHERE 1=1                                                      \n");
        sbSql.append("                   AND A.ACCT_TYPE = 'WP'                                       \n");
        sbSql.append("                   AND A.USE_YN = 'Y'                                           \n");
        sbSql.append("               ) A10,                                                           \n");
        sbSql.append("               (                                                                \n");
        sbSql.append("                SELECT TO_CHAR(TO_DATE(P_DATE, 'YYYY-MM-DD'), 'YYYY-MM-DD') AS P_DATE  \n");
        sbSql.append("                  FROM (                                                        \n");
        sbSql.append("                        -- �������̺�                                           \n");
        sbSql.append("                        SELECT TO_CHAR(TO_DATE('" + ds_Cond.getString(0, "INPUT_YM") + "'||'01', 'YYYYMMDD')+LEVEL-1,'YYYYMMDD') P_DATE \n");
        sbSql.append("                          FROM DUAL                                             \n");
        sbSql.append("                         WHERE 1=1                                              \n");
        sbSql.append("                         CONNECT BY LEVEL-1 <= 365*10                           \n");
        sbSql.append("                        )                                                       \n");
        sbSql.append("                 WHERE P_DATE BETWEEN '" + ds_Cond.getString(0, "INPUT_YM") + "'||'01' AND '" + ds_Cond.getString(0, "INPUT_YM") + "'||'31'         \n");
        sbSql.append("               ) B10                                                            \n");
        sbSql.append("         ORDER BY B10.P_DATE, A10.MGMT_ACCT_CD                                \n");

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