<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �濵����/�ְ���������
�� ���α׷�ID   : MAS40020E_T002.jsp
�� ���α׷���   : �Ϻ����ͽ�������
�� �ۼ�����     : 2013-12-02
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
		DataSet ds_List     = in_dl.get("ds_List");// ����� ����Ÿ
		//DataSet ds_List_ALL = in_dl.get("ds_List_ALL");// ��� ������
		
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//FileLog.println("d:\\b.txt", ds_List);
		//FileLog.println("d:\\a.txt", ds_List_ALL);

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
        sbSql.append("SELECT COUNT(1) ISDATA  \n");
        sbSql.append("  FROM MAS_DAILY_PL_REPORT \n");
        sbSql.append(" WHERE INPUT_YM = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YM")) + "' \n");
        sbSql.append("   AND DOC_CD = '" + nullToBlank(ds_Cond.getString(0, "DOC_CD")) + "' \n");
        sbSql.append("   AND DOC_GUBUN = 'R' \n");
        //sbSql.append("   AND ROWNUM = 1 \n");
        
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		rs.next();
		
		String isData = rs.getString("ISDATA");

		//System.out.println("========================>" + rs.next());
		
		// �� �����Ǿ� ������ �ش� ��¥�� �����͸� ������Ʈ�Ѵ�.
		//if (rs.next()){

			//�Է�,����
			for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
			{
				//�� ������ ����Ÿ�� ������ ����Ǹ� ������Ʈ�Ѵ�.
				if (!isData.equals("0")){	
					if(ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED){
						//System.out.println("111========================>" + isData);
						//System.out.println("========================>" + ds_List.getString(iRow, "P_DATE").substring(11, 12));
						// �հ�� �������� �ʴ´�.
						// �հ�� '['�� �����ϱ� ������ �̰����� �����Ѵ�.
						if(!ds_List.getString(iRow, "P_DATE").substring(11, 12).equals("[")){
							//����
							sbSql.delete(0, sbSql.length());
							sbSql.append("MERGE INTO MAS_DAILY_PL_REPORT A \n");
							sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' AS INPUT_YM \n");
							sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "P_DATE").substring(0, 10).replaceAll("-", "")) + "' AS INPUT_DD \n");
							sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "DOC_CD")) + "' AS DOC_CD \n");
							sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "MGMT_ACCT_CD")) + "' AS MGMT_ACCT_CD \n");
							sbSql.append("         FROM DUAL) B                   \n");
							sbSql.append("   ON (A.INPUT_YM     = B.INPUT_YM AND  \n");
							sbSql.append("       A.INPUT_DD     = B.INPUT_DD AND      \n");
							sbSql.append("       A.DOC_CD       = B.DOC_CD AND        \n");
							sbSql.append("       A.DOC_GUBUN    = 'R' AND        \n");
							sbSql.append("       A.MGMT_ACCT_CD = B.MGMT_ACCT_CD) \n");
							sbSql.append(" WHEN MATCHED THEN                      \n");
							sbSql.append("      UPDATE                            \n");
							sbSql.append("         SET A.ACT_AMT    = " + nullToBlank(ds_List.getString(iRow, "ACT_AMT")) + " \n");
							sbSql.append("           , A.CONFIRM_YN = DECODE(" + nullToBlank(ds_List.getString(iRow, "CONFIRM_YN")) + ", 1, 'Y', 'N') \n");
							sbSql.append("           , A.UDATE      = SYSDATE \n");
							sbSql.append("           , A.UUSER      = '" + g_EmpNo + "' \n");
							sbSql.append(" WHEN NOT MATCHED THEN \n");
							sbSql.append("      INSERT ( A.INPUT_YM \n");
							sbSql.append("             , A.INPUT_DD \n");
							sbSql.append("             , A.DOC_CD \n");
							sbSql.append("             , A.MGMT_ACCT_CD \n");
							sbSql.append("             , A.DOC_GUBUN \n");
							sbSql.append("             , A.ACT_AMT \n");
							sbSql.append("             , A.CONFIRM_YN \n");
							sbSql.append("             , A.CUSER \n");
							sbSql.append("             , A.CDATE \n");
							sbSql.append("             , A.UUSER \n");
							sbSql.append("             , A.UDATE ) \n");
							sbSql.append("      VALUES ( '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' \n");
							sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "P_DATE").substring(0, 10).replaceAll("-", "")) + "' \n");
							sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0,    "DOC_CD")) + "' \n");
							sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "MGMT_ACCT_CD")) + "' \n");
							sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0,    "DOC_GUBUN")) + "' \n");
							sbSql.append("             , " + nullToBlank(ds_List.getString(iRow,  "ACT_AMT")) + " \n");
							sbSql.append("             , DECODE(" + nullToBlank(ds_List.getString(iRow, "CONFIRM_YN")) + ", 1, 'Y', 'N') \n");
							sbSql.append("             , '" + g_EmpNo + "' \n");
							sbSql.append("             , SYSDATE \n");
							sbSql.append("             , '" + g_EmpNo + "' \n");
							sbSql.append("             , SYSDATE \n");
							sbSql.append("             ) \n");
				
				
				out_vl.add("fa_Sql", sbSql.toString());
							//System.out.println(sbSql.toString());
							pstmt = conn.prepareStatement(sbSql.toString());
							pstmt.executeUpdate();
							pstmt.close();
						}
					}
				}else{
					//System.out.println("222========================>" + isData);
					// �հ�� �������� �ʴ´�.
					// �հ�� '['�� �����ϱ� ������ �̰����� �����Ѵ�.
					if(!ds_List.getString(iRow, "P_DATE").substring(11, 12).equals("[")){
						//����
						sbSql.delete(0, sbSql.length());
						sbSql.append("MERGE INTO MAS_DAILY_PL_REPORT A \n");
						sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' AS INPUT_YM \n");
						sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "P_DATE").substring(0, 10).replaceAll("-", "")) + "' AS INPUT_DD \n");
						sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "DOC_CD")) + "' AS DOC_CD \n");
						sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "MGMT_ACCT_CD")) + "' AS MGMT_ACCT_CD \n");
						sbSql.append("         FROM DUAL) B                   \n");
						sbSql.append("   ON (A.INPUT_YM     = B.INPUT_YM AND  \n");
						sbSql.append("       A.INPUT_DD     = B.INPUT_DD AND      \n");
						sbSql.append("       A.DOC_CD       = B.DOC_CD AND        \n");
						sbSql.append("       A.DOC_GUBUN    = 'R' AND        \n");
						sbSql.append("       A.MGMT_ACCT_CD = B.MGMT_ACCT_CD) \n");
						sbSql.append(" WHEN MATCHED THEN                      \n");
						sbSql.append("      UPDATE                            \n");
						sbSql.append("         SET A.ACT_AMT    = " + nullToBlank(ds_List.getString(iRow, "ACT_AMT")) + " \n");
						sbSql.append("           , A.CONFIRM_YN = DECODE(" + nullToBlank(ds_List.getString(iRow, "CONFIRM_YN")) + ", 1, 'Y', 'N') \n");
						sbSql.append("           , A.UDATE      = SYSDATE \n");
						sbSql.append("           , A.UUSER      = '" + g_EmpNo + "' \n");
						sbSql.append(" WHEN NOT MATCHED THEN \n");
						sbSql.append("      INSERT ( A.INPUT_YM \n");
						sbSql.append("             , A.INPUT_DD \n");
						sbSql.append("             , A.DOC_CD \n");
						sbSql.append("             , A.MGMT_ACCT_CD \n");
						sbSql.append("             , A.DOC_GUBUN \n");
						sbSql.append("             , A.ACT_AMT \n");
						sbSql.append("             , A.CONFIRM_YN \n");
						sbSql.append("             , A.CUSER \n");
						sbSql.append("             , A.CDATE \n");
						sbSql.append("             , A.UUSER \n");
						sbSql.append("             , A.UDATE ) \n");
						sbSql.append("      VALUES ( '" + nullToBlank(ds_Cond.getString(0,    "INPUT_YM")) + "' \n");
						sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "P_DATE").substring(0, 10).replaceAll("-", "")) + "' \n");
						sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0,    "DOC_CD")) + "' \n");
						sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "MGMT_ACCT_CD")) + "' \n");
						sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0,    "DOC_GUBUN")) + "' \n");
						sbSql.append("             , " + nullToBlank(ds_List.getString(iRow,  "ACT_AMT")) + " \n");
						sbSql.append("             , DECODE(" + nullToBlank(ds_List.getString(iRow, "CONFIRM_YN")) + ", 1, 'Y', 'N') \n");
						sbSql.append("             , '" + g_EmpNo + "' \n");
						sbSql.append("             , SYSDATE \n");
						sbSql.append("             , '" + g_EmpNo + "' \n");
						sbSql.append("             , SYSDATE \n");
						sbSql.append("             ) \n");
		
					out_vl.add("fa_Sql", sbSql.toString());
						//System.out.println(sbSql.toString());
						pstmt = conn.prepareStatement(sbSql.toString());
						pstmt.executeUpdate();
						pstmt.close();	
					}
				}
			}
			
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