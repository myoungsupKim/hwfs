<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �濵����/���ͽ���
�� ���α׷�ID   : MAS40080E_S001.jsp
�� ���α׷���   : �ְ����ͷ���ȸ
�� �ۼ�����     : 2014-02-14
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
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);
		
		//System.out.println("g_Upjang-------------------" + g_Upjang);

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
		// ����
		if(ds_Cond.getString(0, "DIV").equals("U")){

			sbSql.append("SELECT A10.DOC_CD                                                                                                                        \n");
	        sbSql.append("     , (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = A10.DOC_CD) DOC_NM                                                        \n");
	        sbSql.append("     , A10.ACCU_MC_GSS_AMT    -- ��ȸ�Ⱓ������ ����� ������                                                                        \n");
	        sbSql.append("     , A10.ACCU_MC_GSS_AMT - MAS_MACHUL_COST_FUN(A10.DOC_CD, '" + ds_Cond.getString(0, "INPUT_YMD") + "', 'G', '" + ds_Cond.getString(0, "STYPE") + "') ACCU_MC_P_GSS_AMT -- ��ȸ�Ⱓ������ ������ �������� \n");
	        sbSql.append("     , A10.ACCU_MC_PL_AMT    -- ��ȸ�Ⱓ������ ����� �����ȹ(A)                                                                        \n");
	        sbSql.append("     , A10.ACCU_MC_PL_AMT - MAS_MACHUL_COST_FUN(A10.DOC_CD, '" + ds_Cond.getString(0, "INPUT_YMD") + "', 'P', '" + ds_Cond.getString(0, "STYPE") + "') ACCU_MC_P_PL_AMT -- ��ȸ�Ⱓ������ �������� �����ȹ(C) \n");
	        sbSql.append("     , A10.ACCU_MC_RLT_AMT   -- ��ȸ�Ⱓ������ ����� �������(B)                                                                        \n");
	        sbSql.append("     , A10.ACCU_MC_RLT_AMT - MAS_MACHUL_COST_FUN(A10.DOC_CD, '" + ds_Cond.getString(0, "INPUT_YMD") + "', 'R', '" + ds_Cond.getString(0, "STYPE") + "') ACCU_MC_P_RLT_AMT-- ��ȸ�Ⱓ������ �������� �������(D) \n");
	        sbSql.append("  FROM (                                                                                                                                 \n");
	        sbSql.append("       -- ��ȹ(Ȯ������)                                                                                                                 \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                   \n");
	        sbSql.append("               A.DOC_CD          -- ����/�����ȣ                                                                                        \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND B.ATTR02 = '�����' AND A.INPUT_DD = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '00' THEN \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                        \n");
	        sbSql.append("                   ELSE                                                                                                                  \n");
	        sbSql.append("                        0                                                                                                                \n");
	        sbSql.append("                   END) AS ACCU_MC_GSS_AMT   -- ��ȸ�Ⱓ������ ����� ������(����)                                                     \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND B.ATTR02 = '�����' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                        \n");
	        sbSql.append("                   ELSE                                                                                                                  \n");
	        sbSql.append("                        0                                                                                                                \n");
	        sbSql.append("                   END) AS ACCU_MC_PL_AMT   -- ��ȸ�Ⱓ������ ����� �����ȹ(����)                                                      \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND B.ATTR02 = '�����' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                        \n");
	        sbSql.append("                   ELSE                                                                                                                  \n");
	        sbSql.append("                        0                                                                                                                \n");
	        sbSql.append("                   END) AS ACCU_MC_RLT_AMT  -- ��ȸ�Ⱓ������ ����� �������(����)                                                      \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                     \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                           \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                     \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                        \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                        \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                            \n");
	        // test���� ���� 
	        sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6)                                                                                  \n");
	        sbSql.append("           AND B.ATTR02 IN ('�����','�������')                                                                                        \n");
	        sbSql.append("        GROUP BY A.DOC_CD                                                                                                                \n");
	        sbSql.append("       ) A10                                                                                                                             \n");
	        sbSql.append(" WHERE 1 = 1                                                                                                                             \n");

	     	// ��������
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A10.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* ����  */   \n");
	        } 
	     	
		    // ������
	        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A10.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* ���� �������� ���(������ ����) */   \n");
	        
	        
	        
	        
		}else{ // ������
			sbSql.append("SELECT A10.DOC_CD                                                                                                                         \n");
			sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE SABUN = DOC_CD) AS DOC_NM                                                                         \n");
	        sbSql.append("     , A10.ACCU_MC_PL_AMT    -- ��ȸ�Ⱓ������ ����� �����ȹ(A)                                                                         \n");
	        sbSql.append("     , A10.ACCU_MC_P_PL_AMT  -- ��ȸ�Ⱓ������ �������� �����ȹ(C)                                                                       \n");
	        sbSql.append("     , A10.ACCU_MC_RLT_AMT   -- ��ȸ�Ⱓ������ ����� �������(B)                                                                         \n");
	        sbSql.append("     , A10.ACCU_MC_P_RLT_AMT -- ��ȸ�Ⱓ������ �������� �������(D)                                                                       \n");
	        sbSql.append("  FROM (                                                                                                                                  \n");
	        sbSql.append("       -- ��ȹ(Ȯ������)                                                                                                                  \n");
	        sbSql.append("        SELECT /*+ INDEX(A MAS_DAILY_PL_REPORT_PK)  */                                                                                    \n");
	        sbSql.append("               A.DOC_CD          -- ����/�����ȣ                                                                                         \n");
	        
	        // ������ ���� �����ؾ� ��. 20140325 ����� 
	        //sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND B.ATTR02 = '�����' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '00' AND SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '00' THEN \n");
	        //sbSql.append("                        A.ACT_AMT                                                                                                         \n");
	        //sbSql.append("                   ELSE                                                                                                                   \n");
	        //sbSql.append("                        0                                                                                                                 \n");
	        //sbSql.append("                   END) AS ACCU_GSS_AMT   -- ������                                                             \n");
	        
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND B.ATTR02 = '�����' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                         \n");
	        sbSql.append("                   ELSE                                                                                                                   \n");
	        sbSql.append("                        0                                                                                                                 \n");
	        sbSql.append("                   END) AS ACCU_MC_PL_AMT   -- ��ȸ�Ⱓ������ ����� �����ȹ                                                             \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'P' AND B.ATTR02 = '��������' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                         \n");
	        sbSql.append("                   ELSE                                                                                                                   \n");
	        sbSql.append("                        0                                                                                                                 \n");
	        sbSql.append("                   END) AS ACCU_MC_P_PL_AMT   -- ��ȸ�Ⱓ������ �������� �����ȹ                                                         \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND B.ATTR02 = '�����' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                         \n");
	        sbSql.append("                   ELSE                                                                                                                   \n");
	        sbSql.append("                        0                                                                                                                 \n");
	        sbSql.append("                   END) AS ACCU_MC_RLT_AMT  -- ��ȸ�Ⱓ������ ����� �������                                                             \n");
	        sbSql.append("             , SUM(CASE WHEN A.DOC_GUBUN = 'R' AND B.ATTR02 = '��������' AND A.INPUT_DD BETWEEN SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6) || '01' AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' THEN \n");
	        sbSql.append("                        A.ACT_AMT                                                                                                         \n");
	        sbSql.append("                   ELSE                                                                                                                   \n");
	        sbSql.append("                        0                                                                                                                 \n");
	        sbSql.append("                   END) AS ACCU_MC_P_RLT_AMT  -- ��ȸ�Ⱓ������ �������� �������                                                         \n");
	        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                      \n");
	        sbSql.append("             , MAC_MGMT_ACCT B                                                                                                            \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                      \n");
	        sbSql.append("           AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                         \n");
	        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                         \n");
	        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                             \n");
	     	// test���� ���� 
	     	sbSql.append("           AND A.INPUT_YM(+) = SUBSTR('" + ds_Cond.getString(0, "INPUT_YMD") + "', 1, 6)                                                                                   \n");
	        sbSql.append("           AND B.ATTR02 IN ('�����', '��������')                                                                                         \n");
			
	        // ��縶���ͷ� ��ȸ
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("       AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* ������ */   \n");
	        } 	        
	        
	        // �������� ��ȸ
	        sbSql.append("  AND A.DOC_CD IN (SELECT V.SABUN                                                                                                                            \n");
	        sbSql.append("                   FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        sbSql.append("                  WHERE 1=1                                                                                                                                \n");
	        sbSql.append("                    AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        sbSql.append("                    AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "')  \n");
	        
	        sbSql.append("        GROUP BY A.DOC_CD                                                                                                                 \n");
	        sbSql.append("       ) A10                                                                                                                              \n");
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