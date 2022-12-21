<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ��������/ä�ǰ���
�� ���α׷�ID   : MAK10140S_T001.jsp
�� ���α׷���   : ���翵�� ����ä�� ����Ʈ(���翵��)
�� �ۼ�����     : 2008.09.09
�� �ۼ���       : ������
�� �̷°���     : 2008.09.09
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;

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
			
		String str_in_DEPT_ID            = nullToBlank(ds_Cond.getString(0, "DEPT_ID"));
		String str_in_PART_SALES_SABUN   = nullToBlank(ds_Cond.getString(0, "PART_SALES_SABUN"));	
		String str_in_MAIN_UPJANG        = nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG"));
		String str_in_JOB                = nullToBlank(ds_Cond.getString(0, "JOB"));
		String str_in_SUBJOB             = nullToBlank(ds_Cond.getString(0, "SUB_JOB"));		
		
		String strDate                   = nullToBlank(ds_Cond.getString(0, "DATE"));
		
		
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();



		//�������� ���峻����ȸ
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT A.HEAD_CREDIT_YN, A.MAIN_UPJANG \n");
		sbSql.append("     ,(SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = A.MAIN_UPJANG) MAIN_UPJANGNM \n");
		
		sbSql.append("     , A.UPJANG  \n");
		sbSql.append("     , A.UPJANGNM_DISP \n");
		sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = A.PART_SALES_SABUN) PART_SALES_SABUNNM \n");		

		sbSql.append("     , CB.�������� AS PRE_SALE_AMT \n");
		sbSql.append("     , C0.�����ܰ� AS PRE_AMT \n");
		sbSql.append("     , C.������� AS SALE_AMT \n");
		sbSql.append("     , C1.����Ա� AS RCP_AMT \n");

		sbSql.append("     ,(NVL(C0.�����ܰ�,0) + NVL(C.�������,0) - NVL(C1.����Ա�,0)) AS RNM_AMT \n");

		sbSql.append("     , A.CREDIT_AMOUNT + NVL(B.���ſ����,0) AS CRD_AMT \n");
		sbSql.append("     , A.CREDIT_TURN_DAYS + NVL(B.���ſ�����,0) AS CRD_DAY \n");
		sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("             ,'YYY','�ݾ�+ȸ����' \n");
		sbSql.append("             ,'YYN','ȸ��������' \n");
		sbSql.append("             ,'YNY','�ݾ�����','������') AS CRD_STD \n");
		sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS CRD_PERIOD \n");	
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("       --B.���ſ������� \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS ���ſ���� \n");
		sbSql.append("            , SUM(A.CREDIT_EXT_DAYS) AS ���ſ����� \n");
		sbSql.append("         FROM FMS_CREDIT_EXT A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		if (!str_in_MAIN_UPJANG.equals(""))
			sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(str_in_MAIN_UPJANG) + " \n");
		if (!str_in_DEPT_ID.equals(""))
			sbSql.append("          AND B.DEPT_ID = '" + str_in_DEPT_ID  + "' \n");
		if (!str_in_PART_SALES_SABUN.equals(""))
			sbSql.append("          AND B.PART_SALES_SABUN = '" + str_in_PART_SALES_SABUN  + "' \n");
		if (!str_in_JOB.equals(""))
			sbSql.append("          AND B.BIZ_GROUP = '" + str_in_JOB  + "' \n");	
		if (!str_in_SUBJOB.equals(""))
			sbSql.append("          AND B.BIZ_DETAIL = '" + str_in_SUBJOB  + "' \n");		
		sbSql.append("          AND '" + strDate + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
		sbSql.append("          AND A.APPR_YN = 'Y' \n");
		sbSql.append("        GROUP BY A.UPJANG) B \n");

		sbSql.append("       --C0.�����ܰ� \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(A.BILL_AMOUNT + A.BILL_VAT - NVL(C.AMOUNT,0)) AS �����ܰ� \n");
		sbSql.append("         FROM HLDC_FM_BILL A, FMS_UPJANG B \n");
		sbSql.append("            ,(SELECT A.BILL_ID, SUM(A.AMOUNT) AS AMOUNT \n");
		sbSql.append("                FROM HLDC_FM_BILL_RECEIPT A, HLDC_FM_BILL B, HLDC_FM_RECEIPT C \n");
		sbSql.append("               WHERE A.BILL_ID = B.BILL_ID \n");
		sbSql.append("                 AND A.RECEIPT_ID = C.RECEIPT_ID \n");
		sbSql.append("                 AND B.BILL_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("                 AND C.RECEIPT_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		sbSql.append("                 AND B.CANCEL_FLAG = 'N' \n");
		sbSql.append("               GROUP BY A.BILL_ID) C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.BILL_ID = C.BILL_ID(+) \n");
		sbSql.append("          AND A.BILL_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		if (!str_in_MAIN_UPJANG.equals(""))
			sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(str_in_MAIN_UPJANG) + " \n");
		if (!str_in_DEPT_ID.equals(""))
			sbSql.append("          AND B.DEPT_ID = '" + str_in_DEPT_ID + "' \n");
		if (!str_in_PART_SALES_SABUN.equals(""))
			sbSql.append("          AND B.PART_SALES_SABUN = '" + str_in_PART_SALES_SABUN  + "' \n");
		if (!str_in_JOB.equals(""))
			sbSql.append("          AND B.BIZ_GROUP = '" + str_in_JOB  + "' \n");	
		if (!str_in_SUBJOB.equals(""))
			sbSql.append("          AND B.BIZ_DETAIL = '" + str_in_SUBJOB  + "' \n");			
		sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND A.DCGUBUN = '1' \n");
		sbSql.append("          AND A.ACCTCD = '1110411' \n");
		sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(C.AMOUNT,0)) <> 0 \n");
		sbSql.append("        GROUP BY A.UPJANG) C0 \n");

		sbSql.append("       --CB.�������� \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(A.BILL_AMOUNT + A.BILL_VAT) AS �������� \n");
		sbSql.append("         FROM HLDC_FM_BILL A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.BILL_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR('" + strDate + "',1,6)||'01', 'YYYYMMDD'), -1), 'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "', 'YYYYMMDD'), -1), 'YYYYMM')||'31' \n");
		if (!str_in_MAIN_UPJANG.equals(""))
			sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(str_in_MAIN_UPJANG) + " \n");
		if (!str_in_DEPT_ID.equals(""))
			sbSql.append("          AND B.DEPT_ID = '" + str_in_DEPT_ID  + "' \n");
		if (!str_in_PART_SALES_SABUN.equals(""))
			sbSql.append("          AND B.PART_SALES_SABUN = '" + str_in_PART_SALES_SABUN  + "' \n");
		if (!str_in_JOB.equals(""))
			sbSql.append("          AND B.BIZ_GROUP = '" + str_in_JOB  + "' \n");	
		if (!str_in_SUBJOB.equals(""))
			sbSql.append("          AND B.BIZ_DETAIL = '" + str_in_SUBJOB  + "' \n");			
		sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND A.DCGUBUN = '1' \n");
		sbSql.append("          AND A.ACCTCD = '1110411' \n");
		sbSql.append("          AND (A.BILL_AMOUNT + A.BILL_VAT) <> 0 \n");
		sbSql.append("        GROUP BY A.UPJANG) CB \n");
		
		sbSql.append("       --C.������� \n");
		sbSql.append("     ,(SELECT A.UPJANG \n");
		sbSql.append("            , SUM(A.BILL_AMOUNT + A.BILL_VAT) AS ������� \n");
		sbSql.append("         FROM HLDC_FM_BILL A, FMS_UPJANG B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.BILL_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		if (!str_in_MAIN_UPJANG.equals(""))
			sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(str_in_MAIN_UPJANG) + " \n");
		if (!str_in_DEPT_ID.equals(""))
			sbSql.append("          AND B.DEPT_ID = '" + str_in_DEPT_ID  + "' \n");
		if (!str_in_PART_SALES_SABUN.equals(""))
			sbSql.append("          AND B.PART_SALES_SABUN = '" + str_in_PART_SALES_SABUN  + "' \n");
		if (!str_in_JOB.equals(""))
			sbSql.append("          AND B.BIZ_GROUP = '" + str_in_JOB  + "' \n");	
		if (!str_in_SUBJOB.equals(""))
			sbSql.append("          AND B.BIZ_DETAIL = '" + str_in_SUBJOB  + "' \n");			
		sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		sbSql.append("          AND A.DCGUBUN = '1' \n");
		sbSql.append("          AND A.ACCTCD = '1110411' \n");
		sbSql.append("          AND (A.BILL_AMOUNT + A.BILL_VAT) <> 0 \n");
		sbSql.append("        GROUP BY A.UPJANG) C \n");

		
		sbSql.append("       --C1.����Ա� \n");
		sbSql.append("     ,(SELECT B.UPJANG, SUM(A.AMOUNT) AS ����Ա� \n");
		sbSql.append("         FROM HLDC_FM_BILL_RECEIPT A, HLDC_FM_BILL B, HLDC_FM_RECEIPT C \n");
		sbSql.append("        WHERE A.BILL_ID = B.BILL_ID \n");
		sbSql.append("          AND A.RECEIPT_ID = C.RECEIPT_ID \n");
		sbSql.append("          AND C.RECEIPT_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		sbSql.append("          AND B.CANCEL_FLAG = 'N' \n");
		sbSql.append("        GROUP BY B.UPJANG) C1 \n");

		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C0.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = CB.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
		if (!str_in_MAIN_UPJANG.equals(""))
			sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(str_in_MAIN_UPJANG) + " \n");
		if (!str_in_DEPT_ID.equals(""))
			sbSql.append("   AND A.DEPT_ID = '" + str_in_DEPT_ID  + "' \n");
		if (!str_in_PART_SALES_SABUN.equals(""))
			sbSql.append("   AND A.PART_SALES_SABUN = '" + str_in_PART_SALES_SABUN  + "' \n");
		if (!str_in_JOB.equals(""))
			sbSql.append("          AND B.BIZ_GROUP = '" + str_in_JOB  + "' \n");	
		if (!str_in_SUBJOB.equals(""))
			sbSql.append("          AND B.BIZ_DETAIL = '" + str_in_SUBJOB  + "' \n");			
		
		
		sbSql.append("   AND ( CB.�������� <> 0 OR  C0.�����ܰ� <> 0 OR C.�������  <> 0 OR C1.����Ա� <> 0 OR (NVL(C0.�����ܰ�,0) + NVL(C.�������,0) - NVL(C1.����Ա�,0)) <> 0 ");
		sbSql.append("         OR (A.CREDIT_AMOUNT + NVL(B.���ſ����,0)) <> 0 ) \n");
		
		
		sbSql.append(" ORDER BY A.MAIN_UPJANG, A.UPJANG\n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 
		
		
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		stmt.close();
		
		/**����**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
		if(stmt != null) {
			try {
				stmt.close();
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