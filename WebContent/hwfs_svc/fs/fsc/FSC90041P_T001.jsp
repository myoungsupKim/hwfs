<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : �޴�����/��������                                                                                                                                                                     
�� ���α׷�ID   : FSC00041P_T001.jsp                                                                                                                                                                    
�� ���α׷���   : �б⺰ ���˰����ȸ/������ ���˾�                                                                                                                                               
�� �ۼ�����     : 2008-12-29                                                                                                                                                                            
�� �ۼ���       : ������                                                                                                                                                                                
�� �̷°���     : 2008-12-29                                                                                                                                                                            
1)������ 2012-10-22 CSR#(CH201210_00118) ��û��:ȫȣ��(��ǰ������)
���� �⺰ ��ȸ���� �Ⱓ���� ��ȸ
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//============================================================================================
		//(2012-10-22 ����) ����
		// ������ 2012-10-22 CSR#(CH201210_00118) ��û��:ȫȣ��(��ǰ������)
		// �⵵��ȸ���� �Ⱓ��ȸ�� ����
		//============================================================================================
		//String sYear        = nullToBlank(in_vl.getString("sYear"));
		String sFromDate      = nullToBlank(in_vl.getString("sFromDate"));
		String sToDate        = nullToBlank(in_vl.getString("sToDate"));
		//============================================================================================
		//(2012-10-22 ����) ��
		//============================================================================================
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		//

		//������ȸ
		sbSql.append("SELECT TO_CHAR(TO_DATE(C.CHECK_DATE,'YYYYMMDD'),'YYYY.MM.DD') AS CHECK_DATE \n");
		sbSql.append("     , A.CLASS_NAME \n");
		sbSql.append("     , C.EVAL_CONTENTS \n");
		sbSql.append("     , C.MARK \n");
		sbSql.append("  FROM FSC_SAFE_CLASS_MST A, FSC_SAFE_FORM_DTL B, FSC_SAFE_RESULT_DTL C \n");
		sbSql.append(" WHERE A.CLASS_CD = C.CLASS_CD \n");
		sbSql.append("   AND B.TABLE_TYPE = C.TABLE_TYPE \n");
		sbSql.append("   AND B.FORM_CD = C.FORM_CD \n");
		sbSql.append("   AND B.CLASS_CD = C.CLASS_CD \n");
		//============================================================================================
		//(2012-10-22 ����) ����
		// ������ 2012-10-22 CSR#(CH201210_00118) ��û��:ȫȣ��(��ǰ������)
		// �⵵��ȸ���� �Ⱓ��ȸ�� ����
		//============================================================================================
		//sbSql.append("   AND C.CHECK_DATE BETWEEN '" + sYear + "'||'0101' AND '" + sYear + "'||'1231' \n");
		sbSql.append("   AND C.CHECK_DATE BETWEEN '" + sFromDate + "' AND '" + sToDate + "' \n");
		//============================================================================================
		//(2012-10-22 ����) ��
		//============================================================================================
		sbSql.append("   AND C.UPJANG = " + sUpjang + " \n");
		sbSql.append("   -- �ּ����̸鼭 ������ �Ǽ��� �ִ°� \n");
		sbSql.append("   AND ((LEAST(NVL(B.MARK_1,999), NVL(B.MARK_2,999), NVL(B.MARK_3,999), NVL(B.MARK_4,999)) = C.MARK AND C.NOT_FIT_CNT > 0) \n");
		sbSql.append("   -- �Ǵ�, �հ������� 60�̸��ΰ� \n");
		sbSql.append("        OR EXISTS (SELECT 1 \n");
		sbSql.append("                     FROM FSC_SAFE_RESULT_MST X \n");
		sbSql.append("                    WHERE X.TABLE_TYPE = C.TABLE_TYPE \n");
		sbSql.append("                      AND X.FORM_CD = C.FORM_CD \n");
		sbSql.append("                      AND X.UPJANG = C.UPJANG \n");
		sbSql.append("                      AND X.CHECK_DATE = C.CHECK_DATE \n");
		sbSql.append("                      AND X.SCORE < 60) \n");
		sbSql.append("   -- �Ǵ�, �ߺз��� ���������ε� �ִ����� �ƴ� ���� �������� �Ǽ� �̻��ΰ� \n");
		sbSql.append("        OR EXISTS (SELECT 1 \n");
		sbSql.append("                     FROM FSC_SAFE_RESULT_DTL X, FSC_SAFE_CLASS_MST Y \n");
		sbSql.append("                    WHERE X.TABLE_TYPE = Y.TABLE_TYPE \n");
		sbSql.append("                      AND X.FORM_CD = Y.FORM_CD \n");
		sbSql.append("                      AND SUBSTR(X.CLASS_CD,1,5)||'000' = Y.CLASS_CD \n");
		sbSql.append("                      AND Y.MNGM_FLAG = 'Y' --���������ϴ� �ߺз� \n");
		sbSql.append("                      AND Y.MNGM_CNT > 0 --������������������ �ִ� �� \n");
		sbSql.append("                      AND X.MAX_YN != 'Y' --������ �ƴ� �׸� \n");
		sbSql.append("                      AND X.TABLE_TYPE = C.TABLE_TYPE \n");
		sbSql.append("                      AND X.FORM_CD = C.FORM_CD \n");
		sbSql.append("                      AND X.UPJANG = C.UPJANG \n");
		sbSql.append("                      AND X.CHECK_DATE = C.CHECK_DATE \n");
		sbSql.append("                    GROUP BY Y.CLASS_CD, Y.MNGM_CNT \n");
		sbSql.append("                   HAVING Y.MNGM_CNT <= COUNT(X.CLASS_CD))--�����ƴ� ������ ������������ �̻��̸� ������ \n");
		sbSql.append("       ) \n");
		sbSql.append(" ORDER BY C.CHECK_DATE, C.CLASS_CD \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
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
                                                                                                                                                                                                      