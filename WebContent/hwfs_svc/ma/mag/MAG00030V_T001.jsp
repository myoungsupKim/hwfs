<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ��������/������Ȳ����
�� ���α׷�ID   : MAG00030V_T001.jsp
�� ���α׷���   : ���庰 Z�� ������ȸ
�� �ۼ�����     : 2013-03-04 
�� �ۼ���       : ������
�� �̷°���     : 
	1) ������ 2013-03-05 CSR#(CH201303_00014) ��û��:������(Fc��ȹ��)
	���ʰ���
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
		
		String strYear      = nullToBlank(ds_Cond.getString(0, "YYYY"));
		String strTmCd      = nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String strUpjang    = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String strUpjClss   = nullToBlank(ds_Cond.getString(0, "UPJANG_CLASS"));
		String strUpjangDtl = nullToBlank(ds_Cond.getString(0, "UPJANG_DTL"));
		String strType      = nullToBlank(in_vl.getString("strType"));
		String strExcept    = nullToBlank(in_vl.getString("strExcept"));

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������
		if (strType.equals("UpjLst"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.* FROM \n");
			sbSql.append("( \n");
			sbSql.append("SELECT 000000 AS UPJANG, '��ü' AS UPJANGNM FROM DUAL \n");
			sbSql.append(" --------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append(" --------- \n");
			sbSql.append("SELECT --+ INDEX_ASC(A SYS_C0024828) \n");
			sbSql.append("       A.UPJANG \n");
			sbSql.append("     , DECODE(A.ACC_CLOSEDATE,NULL,NULL,'(��)')||A.UPJANGNM \n");
			sbSql.append("  FROM HLDC_ST_UPJANG A, HLDC_SC_DEPT B \n");
			sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
			sbSql.append("   AND B.MU_CD = 'YA' --FC���常 ��� \n");
			sbSql.append("   AND NVL(A.CUSTCD,0) = 0 --���翵�� ���� ���ξ��常 ��� \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			if (! strUpjClss.equals(""))
				sbSql.append("   AND A.CLASS_CD = '" + strUpjClss + "' \n");
			if (strExcept.equals("Y"))
				sbSql.append("   AND SUBSTR(NVL(A.ACC_CLOSEDATE,'99999999'),1,4) >= '" + strYear + "' \n");
			sbSql.append(") A \n");
			sbSql.append(" ORDER BY A.UPJANG \n");
		}
		//������ȸ
		else
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.DATA_CLASS -- A:����, P:��ȹ \n");
			sbSql.append("     , A.CLOSE_TYPE -- 0:���� C05C:�繫Ȯ��, C05D:����Ȯ�� \n");
			sbSql.append("     , A.MGMT_ACCT_CD -- PLA10000:������(�����), PLB11000:������(����) \n");
			sbSql.append("     , ROUND(SUM(A.AMT1)/1000) AS \"_0\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '01', A.AMT1, 0))/1000) AS \"_1\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '02', A.AMT1, 0))/1000) AS \"_2\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '03', A.AMT1, 0))/1000) AS \"_3\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '04', A.AMT1, 0))/1000) AS \"_4\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '05', A.AMT1, 0))/1000) AS \"_5\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '06', A.AMT1, 0))/1000) AS \"_6\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '07', A.AMT1, 0))/1000) AS \"_7\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '08', A.AMT1, 0))/1000) AS \"_8\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '09', A.AMT1, 0))/1000) AS \"_9\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '10', A.AMT1, 0))/1000) AS \"_10\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '11', A.AMT1, 0))/1000) AS \"_11\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '12', A.AMT1, 0))/1000) AS \"_12\" \n");
			sbSql.append("  FROM MAM_MST A, HLDC_ST_UPJANG B \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.YY = '" + strYear + "' \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND A.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			if (! strUpjangDtl.equals("0"))
				sbSql.append("   AND A.UPJANG = " + strUpjangDtl + " \n");
			if (! strUpjClss.equals(""))
				sbSql.append("   AND B.CLASS_CD = '" + strUpjClss + "' \n");
			if (strExcept.equals("Y"))
				sbSql.append("   AND SUBSTR(NVL(B.ACC_CLOSEDATE,'99999999'),1,4) >= '" + strYear + "' \n");
			sbSql.append("   AND A.DATA_CLASS IN ('P','A') --�ڷᱸ��(A:����, P:��ȹ, F:����, E:����) \n");
			sbSql.append("   AND A.CLOSE_TYPE IN ('0','C05C','C05D') -- 0:���� C05C:�繫Ȯ��, C05D:����Ȯ�� \n");
			sbSql.append("   AND A.MGMT_ACCT_CD IN ('PLA10000','PLB11000') -- PLA10000:������(�����), PLB11000:������(����) \n");
			sbSql.append(" GROUP BY A.DATA_CLASS, A.CLOSE_TYPE, A.MGMT_ACCT_CD \n");
		}
		
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