<%
//-----------------------------------------------------------------------------
//�� �ý��۸�     : ���翵��/���Ұ���/��������/��ǰ�� �ŷ����� ��ȸ
//�� ���α׷�ID   : FMP01030V_T001.jsp
//�� ���α׷���   : ����ܰ� ��ǰ�� �ŷ����� ��ȸ
//�� �ۼ�����     : 2008.01.31
//�� �ۼ���       : ��Կ�
//�� �̷°���     : 2008.01.31
//-----------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//�Է� �Ķ����
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
		//HLDC�� �翬��
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sItemCode = nullToBlank(ds_cond.getString(0, "ITEM_CODE"));
		String sFmonth = nullToBlank(ds_cond.getString(0, "FROM_MONTH"));
		String sTmonth = nullToBlank(ds_cond.getString(0, "TO_MONTH"));

		//������ȸ
        sbSql.append("SELECT                             \n");
        sbSql.append("       A.CONTRACT_START  ,A.CONTRACT_END                              \n");
        sbSql.append("     , A.CONTRACT_PRICE                                \n");
        sbSql.append("     , A.SALE_PRICE                                    \n");
        sbSql.append("     , A.SALE_PRICE - A.CONTRACT_PRICE AS AMT          \n");
        sbSql.append("     , A.MARGIN_RATE                                   \n");
        sbSql.append("  FROM PO_CONTRACT_FSALE A                        \n");
        sbSql.append("     , ST_UPJANG B                                \n");
        sbSql.append("     , PO_ITEM_MST C                              \n");
        sbSql.append(" WHERE C.ITEM_CODE = '" + sItemCode + "'               \n");
        sbSql.append("   AND CONTRACT_START <= '" + sTmonth + "' || '31'     \n");
        sbSql.append("   AND NVL(CONTRACT_END,'99991231') >= '" + sFmonth + "' || '01' \n");
        sbSql.append("   AND A.UPJANG = B.AP_UNITPRICE_UPJANG                \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE                       \n");
        sbSql.append("   AND B.UPJANG = " + sUpjang + "         \n");
        sbSql.append(" ORDER BY 1                                            \n");		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();

		/**����**/
		out_dl.add(ds_list);
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
