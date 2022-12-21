<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �޴�����/�������/��ȹ���� �����Ȳ ��ȸ
�� ���α׷�ID   : FSI00091V_T001.jsp
�� ���α׷���   : ���纰 �����Ȳ��ȸ-�󼼳���
�� �ۼ�����     : 2008.02.12
�� �ۼ���       : ������
�� �̷°���     : 2008.02.12
1)������ 2012-11-05 CSR#(CH201210_00143) ��û��:������(FS��ȹ��)
��ȸ���ǿ� ����, �� ���� �߰�
������ �׸����, FS����θ� ��ȸ(���翵��, �ܽ� �� ����)
��û��,�԰� ��� ��ȸ
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
		DataSet ds_input     = in_dl.get("ds_input");
	
		//FileLog.println("d:\\aaa.txt", ds_input);
		
		/*
		ds_input.SetColumn(0,"DUTY_SEQ",ds_list.GetColumn(nRow,"DUTY_SEQ"));
		ds_input.SetColumn(0,"ITEM_CODE",ds_list.GetColumn(nRow,"ITEM_CODE"));
		ds_input.SetColumn(0,"START_DATE",ds_list.GetColumn(nRow,"START_DATE"));
		ds_input.SetColumn(0,"END_DATE",ds_list.GetColumn(nRow,"END_DATE"));
		*/
	
		String strDutySEQ 	= nullToBlank(ds_input.getString(0, "DUTY_SEQ"));
		String strItemCode	= nullToBlank(ds_input.getString(0, "ITEM_CODE"));
		String strStartDate	= nullToBlank(ds_input.getString(0, "START_DATE"));
		String strEndDate	= nullToBlank(ds_input.getString(0, "END_DATE"));
		//============================================================================================
		//(2012-11-05 �߰�) ����
		// ������ 2012-11-05 CSR#(CH201210_00143) ��û��:������(FS��ȹ��)
		// ��ȸ���ǿ� ����, �� ���� �߰�
		//============================================================================================
		String strCustCd    = nullToBlank(ds_input.getString(0, "CUSTCD"));
		String strCenterCode= nullToBlank(ds_input.getString(0, "CENTER_CODE"));
		String strTmCd		= nullToBlank(ds_input.getString(0, "TM_CD"));
		//============================================================================================
		//(2012-11-05 �߰�) ��
		//============================================================================================
		String strExcept	= in_vl.getString("strExcept");

		//out ����Ÿ
		DataSet ds_list;

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//sbSql.append("-- ���纰 �����Ȳ ��ȸ ������ \n");
		sbSql.append("SELECT \n");
		sbSql.append("       C.TM_CD, \n");
		sbSql.append("       C.TM_NAME, \n");
		sbSql.append("       C.JOB_CD, \n");
		sbSql.append("       C.JOB_NAME, \n");
		sbSql.append("       C.SUB_JOB_CD, \n");
		sbSql.append("       C.SUB_JOB_NAME, \n");
		sbSql.append("       C.UPJANG, \n");
		sbSql.append("       C.UPJANGNM, \n");
		if (strExcept.equals("TRUE"))
			sbSql.append("       NVL(NEED_QTY,0) NEED_QTY, --�Ĵܵ�Ϸ�  [����] \n");
		else
			sbSql.append("       NULL AS NEED_QTY, --�Ĵܵ�Ϸ�  [����] \n");
		//sbSql.append("       NVL(PR_QTY,0) PR_QTY, --��û�� \n");
		sbSql.append("       NVL(TRANS_QTY,0) TRANS_QTY --�԰� \n");
		//============================================================================================
		//(2012-11-05 ����) ����
		// ������ 2012-11-05 CSR#(CH201210_00143) ��û��:������(FS��ȹ��)
		// ������ �׸����
		//============================================================================================
		//sbSql.append("       F.DUTY_QTY, --������ \n");
		//sbSql.append("       DECODE(DUTY_QTY, 0, 0, ROUND(NVL(PR_QTY,0) / DUTY_QTY * 100,2)) PR_RATE, --��û���� \n");
		//sbSql.append("       DECODE(DUTY_QTY, 0, 0, ROUND(NVL(TRANS_QTY,0) / DUTY_QTY * 100,2)) TRANS_RATE --�԰���� \n");
		//============================================================================================
		//(2012-11-05 ����) ��
		//============================================================================================
		sbSql.append("  FROM \n");
		//sbSql.append("       FSI_DUTY_MST A \n");
		//sbSql.append("      ,HLDC_PO_ITEM_MST B  --[����] \n");
		sbSql.append("       MAC_UPJANG_V C \n");
		sbSql.append("      ,(SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0045' AND USE_YN = 'Y') C1 \n");
		if (strExcept.equals("TRUE"))
		{
			sbSql.append("      ,( \n");
			sbSql.append("        SELECT A.UPJANG, B.ITEM_CODE \n");
			sbSql.append("              ,SUM(ROUND(B.NEED_QTY*DECODE(D.CAFE_YN,'Y',C.EXPECT_SALE_QTY,DECODE(D.CATER_YN,'Y',C.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))/E.KG_CONVERT_RATE/1000,2)) NEED_QTY \n");
			sbSql.append("          FROM FSM_REAL_MENU_MST A \n");
			sbSql.append("              ,FSM_REAL_RECIPE_ITEM B \n");
			sbSql.append("              ,FSM_REAL_RECIPE_MST C \n");
			sbSql.append("              ,FSA_HALL_MST D \n");
			sbSql.append("              ,HLDC_PO_ITEM_MST E \n");
			sbSql.append("         WHERE A.UPJANG = C.UPJANG \n");
			sbSql.append("           AND A.MENU_CD = C.MENU_CD \n");
			sbSql.append("           AND C.UPJANG = B.UPJANG \n");
			sbSql.append("           AND C.MENU_CD = B.MENU_CD \n");
			sbSql.append("           AND C.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("           AND A.UPJANG = D.UPJANG \n");
			sbSql.append("           AND A.HALL_CD = D.HALL_CD \n");
			sbSql.append("           AND B.ITEM_CODE = E.ITEM_CODE \n");
			sbSql.append("           AND B.NEED_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
			sbSql.append("           AND B.ITEM_CODE = '" + strItemCode + "' \n");
			//sbSql.append("           AND EXISTS (SELECT 1 FROM FSI_DUTY_SET C WHERE C.UPJANG = A.UPJANG AND C.DUTY_SEQ = '" + strDutySEQ + "') \n");
			sbSql.append("         GROUP BY A.UPJANG, B.ITEM_CODE \n");
			sbSql.append("       ) D \n");
		}
		sbSql.append("      ,(SELECT CENTER_CODE, CUSTCD, ITEM_CODE, UPJANG \n");
		//sbSql.append("             , SUM(DUTY_QTY) AS DUTY_QTY \n");
		sbSql.append("             , SUM(PR_QTY) AS PR_QTY \n");
		sbSql.append("             , SUM(TRANS_QTY) AS TRANS_QTY \n");
		sbSql.append("          FROM \n");
		sbSql.append("( \n");
/*
		sbSql.append("        SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, B.UPJANG AS UPJANG \n");
		sbSql.append("             , B.DUTY_QTY \n");
		sbSql.append("             , 0 PR_QTY \n");
		sbSql.append("             , 0 AS TRANS_QTY \n");
		sbSql.append("          FROM FSI_DUTY_MST A, FSI_DUTY_SET B \n");
		sbSql.append("         WHERE A.DUTY_SEQ = B.DUTY_SEQ \n");
		sbSql.append("           AND A.DUTY_SEQ = " + strDutySEQ + " \n");
		sbSql.append("         UNION ALL \n");
*/
/*
		sbSql.append("        SELECT CENTER_CODE, CUSTCD, ITEM_CODE, RC_UPJANG AS UPJANG \n");
		sbSql.append("             , 0 DUTY_QTY \n");
		sbSql.append("             , SUM(PR_QTY) PR_QTY \n");
		sbSql.append("             , 0 AS TRANS_QTY \n");
		sbSql.append("          FROM HLDC_PO_PR \n");
		sbSql.append("         WHERE RC_MU_CD = 'YA' \n");
		sbSql.append("           AND LINE_STATUS >= '004' \n");
		sbSql.append("           AND SUBINV_CODE LIKE 'C%' \n");
		sbSql.append("           AND ITEM_CODE = '" + strItemCode + "'  -- [INPUT:������.ITEM_CODE] \n");
		sbSql.append("           AND NEED_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
		if (! strCenterCode.equals(""))
			sbSql.append("           AND CENTER_CODE = " + strCenterCode + " \n");
		sbSql.append("           AND CUSTCD = " + strCustCd + " \n");
		sbSql.append("         GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE, RC_UPJANG \n");
		sbSql.append("         UNION ALL \n");
*/
		sbSql.append("        SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.TRANS_UPJANG AS UPJANG\n");
		sbSql.append("             , 0 DUTY_QTY \n");
		sbSql.append("             , 0 AS PR_QTY \n");
		sbSql.append("             , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("         WHERE A.TRANS_MU_CD = '2002' \n");
		sbSql.append("           AND A.SUBINV_CODE LIKE 'C%' \n");
		//TRANS_TYPE = 'I001':�����԰�(PO)/��ǰ���(INV)  OR  SOURCE_TYE = 'PO':�����μ��԰�/���͹ݼ��̰����
		//sbSql.append("           AND TRANS_TYPE = 'I001' \n");
		sbSql.append("           AND (A.TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		sbSql.append("           AND A.ITEM_CODE = '" + strItemCode + "' \n");
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + strStartDate + "' AND '" + strEndDate + "' \n");
		if (! strCenterCode.equals(""))
			sbSql.append("           AND A.CENTER_CODE = " + strCenterCode + " \n");
		sbSql.append("           AND A.CUSTCD = " + strCustCd + " \n");
		sbSql.append("         GROUP BY A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.TRANS_UPJANG \n");
		sbSql.append(") \n");
		sbSql.append("         GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE, UPJANG \n");
		sbSql.append("       ) F \n");
		//sbSql.append(" WHERE F.UPJANG      = C.UPJANG \n");
		//sbSql.append("   AND F.UPJANG      = D.UPJANG(+) \n");
		//sbSql.append("   AND F.ITEM_CODE   = D.ITEM_CODE(+) \n");
		//sbSql.append("   AND A.ITEM_CODE   = B.ITEM_CODE --[����] \n");
		//sbSql.append("   AND A.ITEM_CODE   = F.ITEM_CODE(+) \n");
		//sbSql.append("   AND A.CENTER_CODE = F.CENTER_CODE(+) \n");
		//sbSql.append("   AND A.CUSTCD      = F.CUSTCD(+) \n");
		//sbSql.append("   AND A.DUTY_SEQ    = " + strDutySEQ + " \n");
		sbSql.append(" WHERE C.TM_CD = C1.CODE \n");
		if (! strTmCd.equals(""))
			sbSql.append("   AND C.TM_CD = '" + strTmCd + "' \n");
		if (strExcept.equals("TRUE"))
			sbSql.append("   AND C.UPJANG = D.UPJANG(+) \n");
		sbSql.append("   AND C.UPJANG = F.UPJANG(+) \n");
		sbSql.append("   AND C.OPEN_DATE <= '" + strEndDate + "' \n");
		sbSql.append("   AND NVL(C.CLOSE_DATE,'99999999') >= '" + strStartDate + "' \n");
		sbSql.append(" ORDER BY C.TM_CD, C.JOB_CD, C.JOB_CD, C.UPJANG \n");

out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_Detail = this.makeDataSet(rs, "ds_Detail");
		
		rs.close();
		pstmt.close();

		/**����**/
		out_dl.add(ds_Detail);
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