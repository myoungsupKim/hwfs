<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �濵����/���ͽ���
�� ���α׷�ID   : MAS40060E_T001.jsp
�� ���α׷���   : �������Ͱ�ȹ��ȸ
�� �ۼ�����     : 2013-12-18
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
		
		// �����������
		if(ds_Cond.getString(0, "DIV").equals("U")){
			if(ds_Cond.getString(0, "STYPE").equals("M")){	// ��ȸ���� : ����(M)
		        sbSql.append("SELECT A.MGMT_ACCT_CD                                                                                                              \n");
		        sbSql.append("     , B.MGMT_ACCT_NAME                                                                                                            \n");
		        sbSql.append("     , B.ATTR01 AS INPUT_YN                                                                                                                   \n");
		        sbSql.append("     , TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYY-MM-DD'), 'YYYY-MM-DD')|| ' (' || DECODE(TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYYMMDD'), 'D'), '1', '��', '2', '��', '3', 'ȭ', '4', '��', '5', '��', '6', '��', '7', '��') || ')' AS P_DATE                                                                                                                 \n");
		        sbSql.append("     , SUM(A.ACT_AMT) ACT_AMT                                                                                                      \n");
		        sbSql.append("  FROM MAS_DAILY_PL_REPORT A                                                                                                       \n");
		        sbSql.append("     , MAC_MGMT_ACCT       B                                                                                                       \n");
		        sbSql.append(" WHERE 1 = 1                                                                                                                       \n");
		        sbSql.append("   AND A.MGMT_ACCT_CD = B.MGMT_ACCT_CD                                                                                             \n");
		        sbSql.append("   AND B.ACCT_TYPE = 'WP'                                                                                                          \n");
		        sbSql.append("   AND B.USE_YN = 'Y'                                                                                                              \n");
		        sbSql.append("   AND A.INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "'  \n");
		        sbSql.append("   AND A.DOC_GUBUN = 'P' /* ����ȹ */                                                                                                \n");
	
		        // ����(������)����
		        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
		        	sbSql.append("   AND A.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* ���� �Ǵ� ������ */   \n");
		        } 
		        
		        sbSql.append("   AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* ���� �������� ���(������ ����) */   \n");
		        sbSql.append(" GROUP BY A.INPUT_DD, A.MGMT_ACCT_CD, MGMT_ACCT_NAME, B.ATTR01                                                                     \n");
			}else{// ��ȸ���� : �繫(U)
				// �Է� �� �����ʹ� �����ݾ����� �ԷµǾ� �����Ƿ� �繫�ݾ����� �����ؾ� �Ѵ�.
				// �繫�ݾ����� �����ؾ� �ϴ� ���������� '���������'������ �繫�ݾ����� �����Ѵ�.
				// '���������'�� ����Ǹ� '����'������ '�������', '��������'������ ���� ����ȴ�.
				sbSql.append("SELECT A10.MGMT_ACCT_CD                                                                                                                                                                                                    \n");
		        sbSql.append("     , A10.MGMT_ACCT_NAME                                                                                                                                                                                                  \n");
		        sbSql.append("     , A10.INPUT_YN                                                                                                                                                                                                        \n");
		        sbSql.append("     , A10.P_DATE                                                                                                                                                                                                          \n");
		        sbSql.append("     , SUM(CASE WHEN A10.MGMT_ACCT_CD IN ('PLB00000', 'PLB20000') THEN /* �������, ���� */                                                                                                                              \n");
		        sbSql.append("                     A10.U_ACT_AMT - A10.DIFF_ACT_AMT  /* �����ݾ׿��� �繫�ݾ��� ���̸�ŭ ���ش�.(�繫�ݾ��� ����������� �ݾ��̹Ƿ� �� �۴� */                                                                                   \n");
		        sbSql.append("                WHEN A10.MGMT_ACCT_CD IN ('PLC00000') THEN /* �������� */                                                                                                                                                  \n");
		        sbSql.append("                     A10.U_ACT_AMT + A10.DIFF_ACT_AMT  /* ��������(�����-�������)�̹Ƿ� ��������� �۾����� ���������� �����Ѵ�. */                                                                              \n");
		        sbSql.append("           ELSE                                                                                                                                                                                                            \n");
		        sbSql.append("                A10.U_ACT_AMT                                                                                                                                                                                              \n");
		        sbSql.append("           END) AS ACT_AMT                                                                                                                                                                                                 \n");
		        sbSql.append("  FROM (                                                                                                                                                                                                                   \n");
		        sbSql.append("        SELECT A.DOC_CD                                                                                                                                                                                                    \n");
		        sbSql.append("             , A.MGMT_ACCT_CD                                                                                                                                                                                              \n");
		        sbSql.append("             , B.MGMT_ACCT_NAME                                                                                                                                                                                            \n");
		        sbSql.append("             , B.ATTR01 AS INPUT_YN                                                                                                                                                                                        \n");
		        sbSql.append("             , A.INPUT_DD                                                                                                                                                                                                  \n");
		        sbSql.append("             , TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYY-MM-DD'), 'YYYY-MM-DD')|| ' (' || DECODE(TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYYMMDD'), 'D'), '1', '��', '2', '��', '3', 'ȭ', '4', '��', '5', '��', '6', '��', '7', '��') || ')' AS P_DATE \n");
		        sbSql.append("             , A.ACT_AMT -- �����ݾ�                                                                                                                                                                                       \n");
		        sbSql.append("             , CASE WHEN B.ATTR03 = 'Y'THEN /* ��������� �����̰� �繫�ݾ����� ��ȸ�ϸ� */                                                                                                                                \n");
		        sbSql.append("                    A.ACT_AMT/NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND DOC_CD = A.DOC_CD AND GUBUN = 'P'), 100)*100                                                                                    \n");
		        sbSql.append("               ELSE                                                                                                                                                                                                        \n");
		        sbSql.append("                    A.ACT_AMT                                                                                                                                                                                              \n");
		        sbSql.append("               END U_ACT_AMT -- �繫�ݾ�                                                                                                                                                                                   \n");
		        sbSql.append("             , C.DIFF_ACT_AMT -- ������ �繫�� ���̱ݾ�                                                                                                                                                                    \n");
		        sbSql.append("          FROM MAS_DAILY_PL_REPORT A                                                                                                                                                                                       \n");
		        sbSql.append("             , MAC_MGMT_ACCT       B                                                                                                                                                                                       \n");
		        sbSql.append("             , (SELECT A.DOC_CD                                                                                                                                                                                            \n");
		        sbSql.append("                     , A.INPUT_DD                                                                                                                                                                                          \n");
		        sbSql.append("                     , A.ACT_AMT - A.ACT_AMT/NVL((SELECT M_RATE FROM MAS_UPJANG_M_RATE_MGMT WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND DOC_CD = A.DOC_CD AND GUBUN = 'P'), 100)*100 AS DIFF_ACT_AMT                                                     \n");
		        sbSql.append("                  FROM MAS_DAILY_PL_REPORT A                                                                                                                                                                               \n");
		        sbSql.append("                     , MAC_MGMT_ACCT       B                                                                                                                                                                               \n");
		        sbSql.append("                 WHERE 1 = 1                                                                                                                                                                                               \n");
		        sbSql.append("                   AND A.MGMT_ACCT_CD = B.MGMT_ACCT_CD                                                                                                                                                                     \n");
		        sbSql.append("                   AND B.ACCT_TYPE = 'WP'                                                                                                                                                                                  \n");
		        sbSql.append("                   AND B.USE_YN = 'Y'                                                                                                                                                                                      \n");
		        sbSql.append("                   AND A.INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "'                                                                                                                                                                               \n");
		        sbSql.append("                   AND A.DOC_GUBUN = 'P'    /* ����ȹ */                                                                                                                                                                   \n");
		        //sbSql.append("                   AND A.DOC_CD = '100751'  /* ���� �Ǵ� ������ */                                                                                                                                                         \n");
		        
		     	// ����(������)����
		        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
		        	sbSql.append("   AND A.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* ���� �Ǵ� ������ */   \n");
		        }		        
		        
		        sbSql.append("                   AND B.ATTR03 = 'Y'                                                                                                                                                                                      \n");
		        sbSql.append("                   AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* ���� �������� ���(������ ����) */                                                                             \n");
		        sbSql.append("               ) C /* ���忡 ���ں� ������������� �����ݾװ� �繫�ݾ��� ���� */                                                                                                                                           \n");
		        sbSql.append("         WHERE 1 = 1                                                                                                                                                                                                       \n");
		        sbSql.append("           AND A.MGMT_ACCT_CD = B.MGMT_ACCT_CD                                                                                                                                                                             \n");
		        sbSql.append("           AND B.ACCT_TYPE = 'WP'                                                                                                                                                                                          \n");
		        sbSql.append("           AND B.USE_YN = 'Y'                                                                                                                                                                                              \n");
		        sbSql.append("           AND A.INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "'                                                                                                                                                                                       \n");
		        sbSql.append("           AND A.DOC_GUBUN = 'P' /* ����ȹ */                                                                                                                                                                              \n");
		        sbSql.append("           AND A.DOC_CD = C.DOC_CD                                                                                                                                                                                         \n");
		        sbSql.append("           AND A.INPUT_DD = C.INPUT_DD                                                                                                                                                                                     \n");
//		        sbSql.append("           AND A.DOC_CD = '100751'  /* ���� �Ǵ� ������ */                                                                                                                                                                 \n");

		     	// ����(������)����
		        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
		        	sbSql.append("   AND A.DOC_CD = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* ���� �Ǵ� ������ */   \n");
		        }

		        sbSql.append("           AND EXISTS (SELECT 1 FROM SCO_UPJANG_MST_V WHERE UPJANG = A.DOC_CD AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "') /* ���� �������� ���(������ ����) */                                                                                     \n");
		        sbSql.append("       ) A10                                                                                                                                                                                                               \n");
		        sbSql.append(" GROUP BY A10.P_DATE, A10.MGMT_ACCT_CD, A10.MGMT_ACCT_NAME, A10.INPUT_YN                                                                                                                                                   \n");
			}
		}else{ // �����ͽ�������
			sbSql.append("SELECT A.MGMT_ACCT_CD                                                                                                              \n");
	        sbSql.append("     , B.MGMT_ACCT_NAME                                                                                                            \n");
	        sbSql.append("     , B.ATTR01 AS INPUT_YN                                                                                                                   \n");
	        sbSql.append("     , TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYY-MM-DD'), 'YYYY-MM-DD')|| ' (' || DECODE(TO_CHAR(TO_DATE(A.INPUT_DD, 'YYYYMMDD'), 'D'), '1', '��', '2', '��', '3', 'ȭ', '4', '��', '5', '��', '6', '��', '7', '��') || ')' AS P_DATE                                                                                                                 \n");
	        sbSql.append("     , SUM(A.ACT_AMT) ACT_AMT                                                                                                      \n");
	        sbSql.append("  FROM MAS_DAILY_PL_REPORT A                                                                                                       \n");
	        sbSql.append("     , MAC_MGMT_ACCT       B                                                                                                       \n");
	        sbSql.append(" WHERE 1 = 1                                                                                                                       \n");
	        sbSql.append("   AND A.MGMT_ACCT_CD(+) = B.MGMT_ACCT_CD                                                                                             \n");
	        sbSql.append("   AND B.ACCT_TYPE = 'WP'                                                                                                          \n");
	        sbSql.append("   AND B.USE_YN = 'Y'                                                                                                              \n");
	        sbSql.append("   AND A.INPUT_YM(+) = '" + ds_Cond.getString(0, "INPUT_YM") + "'  \n");
	        sbSql.append("   AND A.DOC_GUBUN(+) = 'P' /* ����ȹ */                                                                                                \n");

	        // ����(������)����
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("   AND A.DOC_CD(+) = '" + ds_Cond.getString(0, "DOC_CD") + "'  /* ���� �Ǵ� ������ */   \n");
	        } 
	        
	     	sbSql.append("  AND A.DOC_CD IN (SELECT V.SABUN                                                                                                                            \n");
	        sbSql.append("                   FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        sbSql.append("                  WHERE 1=1                                                                                                                                \n");
	        sbSql.append("                    AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        sbSql.append("                    AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "')  \n");
	                
	        sbSql.append(" GROUP BY A.INPUT_DD, A.MGMT_ACCT_CD, MGMT_ACCT_NAME, B.ATTR01                                                                     \n");	        
	        			
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