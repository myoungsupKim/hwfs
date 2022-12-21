<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ֹ�����
�� ���α׷�ID   : FMP00135V_T001.jsp
�� ���α׷���   : �Ĵܹ��� ����ҿ䷮ ��ȸ
�� �ۼ�����     : 2008.02.11
�� �ۼ���       : ������
�� �̷°���     : 2008.02.11
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql   = new StringBuffer();
    	String strClass      = nullToBlank(ds_cond.getString(0, "CLASS_CODE"));
    	String strKind       = nullToBlank(ds_cond.getString(0, "KIND_CODE"));
    	String strMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
    	String strUpjang     = nullToBlank(ds_cond.getString(0, "UPJANG"));

		//1)�ֹ�������ȸ
		if (strKind.equals("��ǰ��"))
		{	
	        //sbSql.append("SELECT '' AS NEED_DATE, '' AS UPJANG, '' AS UPJANGNM \n");
	        sbSql.append("SELECT B.NEED_DATE, A.UPJANG \n");
	        sbSql.append("     , (SELECT UPJANGNM_DISP FROM FMS_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANGNM \n");
		}
		else
		{
	        sbSql.append("SELECT B.NEED_DATE, A.UPJANG \n");
	        sbSql.append("     , (SELECT UPJANGNM_DISP FROM FMS_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANGNM \n");
		}
        if (strClass.equals("�ߺз�"))
        {	
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS2) AS ITEM_CLASS \n");
        }	
        if (strClass.equals("�Һз�"))
        {	
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS3) AS ITEM_CLASS \n");
        }	
        if (strClass.equals("���з�"))
        {	
        	sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS4) AS ITEM_CLASS \n");
        }	

        sbSql.append("     , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
        sbSql.append("     , ROUND(SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY / 1000 / C.KG_CONVERT_RATE),2) AS DEF_QTY \n");
        sbSql.append("     , C.ORIGIN_TYPE \n");
        sbSql.append("     , A.MENU_DATE\n");
        sbSql.append("  FROM FMM_MENU A, FMM_RECIPE_ITEM B, FMS_ITEM_V C \n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
        sbSql.append("   AND A.MENU_CD = B.MENU_CD \n");
        sbSql.append("   AND B.ITEM_CODE = C.ITEM_CODE \n");
        sbSql.append("   AND B.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "FROM_DATE")) + "' AND '" +  nullToBlank(ds_cond.getString(0, "TO_DATE")) + "' \n");
        sbSql.append("   AND A.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG Z WHERE (1=1) \n");
        sbSql.append("                       AND Z.MAIN_UPJANG = " + strMainUpjang + " \n");
        if (!strUpjang.equals(""))
        {
        	sbSql.append("                   AND Z.UPJANG = " + strUpjang + " \n");
        }
        sbSql.append("                   ) \n");
		if (strKind.equals("��ǰ��"))
		{	
	        //sbSql.append(" GROUP BY \n");
			sbSql.append(" GROUP BY B.NEED_DATE, A.UPJANG, C.ORIGIN_TYPE, \n");
		}
		else
		{
	        sbSql.append(" GROUP BY B.NEED_DATE, A.UPJANG, C.ORIGIN_TYPE, \n");
		}        
        if (strClass.equals("�ߺз�"))
        {	
        	sbSql.append("     C.ITEM_CLASS2 \n");
        }	
        if (strClass.equals("�Һз�"))
        {	
        	sbSql.append("     C.ITEM_CLASS3 \n");
        }	
        if (strClass.equals("���з�"))
        {	
        	sbSql.append("     C.ITEM_CLASS4 \n");
        }	        
        sbSql.append("     , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, A.MENU_DATE \n");
        
		if (strKind.equals("��ȸ���ں�"))
		{	
	        sbSql.append(" ORDER BY 1,3,4 \n");
		}       
		if (strKind.equals("����庰"))
		{	
	        sbSql.append(" ORDER BY 3,1,4 \n");
		}	
		if (strKind.equals("��ǰ��"))
		{	
	        sbSql.append(" ORDER BY 5 \n");
		}		
		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		//FileLog.println("d:\\BBB.txt", ds_ListTmp);
		
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
