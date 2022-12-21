<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�������
�� ���α׷�ID   : MAO00010E_T001.jsp
�� ���α׷���   : ������ ��ϰ���(��ȸ)
�� �ۼ�����     : 2012-03-09
�� �ۼ���       : ������
�� �̷°���     : 2012-03-09 ������ - ���ʰ��� (CH201203_00081)
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
		DataSet ds_Cond     = in_dl.get("ds_cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String str_in_TRANS_DATE     = nullToBlank(ds_Cond.getString(0, "TRANS_DATE"));
		String sChkHis               = nullToBlank(ds_Cond.getString(0, "CHK_HIS"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//������ȸ
		sbSql.append(" /*  MAG10131S_T001.jsp    */ \n");
		sbSql.append("    SELECT B.CODE_NAME, \n");
		sbSql.append("           NVL(ROUND(SUM(ONHAND)),0) A, --����������\n");
		sbSql.append("           NVL(ROUND(SUM(INAMT1)),0) B, --����԰����\n");
		sbSql.append("           NVL(ROUND(SUM(INAMT2)),0) C, --���Ը���\n");
		sbSql.append("           NVL(ROUND(SUM(OUTAMT1)),0) D,--��������� \n");
		sbSql.append("           NVL(ROUND(SUM(OUTAMT2)),0) E, --�̰�����\n");
		sbSql.append("           NVL(ROUND(SUM(ONHAND) + SUM(INAMT1)  + SUM(INAMT2) - SUM(OUTAMT1) - SUM(OUTAMT2)),0) F, --�⸻������\n");
		sbSql.append("           NVL(ROUND(SUM(ONHAND2)),0) G, --�����������\n");
		sbSql.append("           NVL(ROUND(SUM(INAMT21)),0) H, --����԰�����\n");
		sbSql.append("           NVL(ROUND(SUM(INAMT22)),0) I, --��������\n");
		sbSql.append("           NVL(ROUND(SUM(OUTAMT21)),0) J, --����������\n");
		sbSql.append("           NVL(ROUND(SUM(OUTAMT22)),0) K, --�̰�����\n");		
		sbSql.append("           NVL(ROUND(SUM(ONHAND2) + SUM(INAMT21)  + SUM(INAMT22) - SUM(OUTAMT21) - SUM(OUTAMT22)),0) L, --�⸻�������\n");
		
		/*2016.01.25 ������ ���� ���ͷ� �߰� ������ ��û*/
		sbSql.append("           NVL(ROUND(SUM(ONHAND3)),0) O, --����������\n");
	    sbSql.append("           NVL(ROUND(SUM(INAMT31)),0) P, --����԰�����\n");
	    sbSql.append("           NVL(ROUND(SUM(INAMT32)),0) Q, --��������\n");
	    sbSql.append("           NVL(ROUND(SUM(OUTAMT31)),0) R, --����������\n");
	    sbSql.append("           NVL(ROUND(SUM(OUTAMT32)),0) S, --�̰�����\n");
	    
	    
		sbSql.append("           100 M, --�԰�������\n");
		sbSql.append("           200 N, --���������\n");
		sbSql.append("           300 T\n");
		sbSql.append("      FROM \n");
		sbSql.append("    ( \n");
		sbSql.append("            SELECT B.UPJANG, A.SUBINV_CODE, B.SUBINV_NAME, 0 ONHAND, 0 ONHAND2, 0 ONHAND3 \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'I', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'I002', 0, \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( UNIT_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( UNIT_AMOUNT ) ) )), 0) INAMT1, \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'I', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'I002', \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( UNIT_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( UNIT_AMOUNT ) ) ),0), 0) INAMT2, \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'O', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'O002', 0, \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( UNIT_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( UNIT_AMOUNT ) ) )), 0) OUTAMT1, \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'O', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'O002', \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( UNIT_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( UNIT_AMOUNT ) ) ),0), 0) OUTAMT2, \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'I', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'I002', 0, \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ) )), 0) INAMT21, \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'I', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'I002', \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ) ),0), 0) INAMT22, \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'O', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'O002', 0, \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ) )), 0) OUTAMT21, \n");
		sbSql.append("                   NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'O', \n");
		sbSql.append("                              DECODE( SUBSTR(TRANS_TYPE,1,4), 'O002', \n");
		sbSql.append("                                    DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ) ),0), 0) OUTAMT22 \n");
		
		/*2016.01.25 ������ ���� �� �ݿ� �ݾ� �߰� ������ ��û */
		sbSql.append("					NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'I', \n");
		sbSql.append("                      DECODE( SUBSTR(TRANS_TYPE,1,4), 'I002', 0, \n");
		sbSql.append("                              DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( ADD_INC_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( ADD_INC_AMOUNT ) ) )), 0) INAMT31, \n"); 
		sbSql.append("                  NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'I', \n");
	    sbSql.append("                      DECODE( SUBSTR(TRANS_TYPE,1,4), 'I002', \n");
	    sbSql.append("                              DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( ADD_INC_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( ADD_INC_AMOUNT ) ) ),0), 0) INAMT32, \n"); 
	    sbSql.append("                  NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'O', \n");
	    sbSql.append("                      DECODE( SUBSTR(TRANS_TYPE,1,4), 'O002', 0, \n");
	    sbSql.append("                              DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( ADD_INC_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( ADD_INC_AMOUNT ) ) )), 0) OUTAMT31,\n"); 
	    sbSql.append("                  NVL( DECODE( SUBSTR(TRANS_TYPE,1,1), 'O', \n");
	    sbSql.append("                      DECODE( SUBSTR(TRANS_TYPE,1,4), 'O002', \n");
	    sbSql.append("                              DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( ADD_INC_AMOUNT * DECODE( A.TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( ADD_INC_AMOUNT ) ) ),0), 0) OUTAMT32 \n"); 
//		if (sChkHis.equals("0"))
//		{
		/*2016.01.25 ������ ���� �� �ݿ� �ݾ� �߰� ������ ��û */
			sbSql.append("              FROM HLDC_PO_TRANSACTION_ADD_INC A, HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST C \n");
//		}
//		else
//		{
//			sbSql.append("              FROM HLDC_HIS_PO_TRANSACTION_201312 A, HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST C \n");
//		}
		sbSql.append("             WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("               AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("               AND A.TRANS_MU_CD = '2002' \n");
		sbSql.append("               AND TRANS_DATE BETWEEN '" + str_in_TRANS_DATE  + "'||'01' AND '" + str_in_TRANS_DATE  + "'||'31' \n");
		sbSql.append("               AND A.SUBINV_CODE NOT LIKE 'E%' \n");
		sbSql.append("            GROUP BY B.UPJANG, A.SUBINV_CODE, B.SUBINV_NAME, TRANS_TYPE, B.OUTVAT_FLAG, A.TAX_CODE \n");
		sbSql.append("            UNION ALL \n");
		sbSql.append("            SELECT B.UPJANG, A.SUBINV_CODE, B.SUBINV_NAME, \n");
		sbSql.append("                   NVL( DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( UNIT_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( UNIT_AMOUNT ) ), 0) AA, \n");
		sbSql.append("                   NVL( DECODE( B.OUTVAT_FLAG, 'Y', ROUND( SUM( MARGIN_AMOUNT * DECODE( TAX_CODE, '100', DECODE( MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( MARGIN_AMOUNT ) ), 0) AA, \n");
		sbSql.append("                   0, 0, 0, 0, 0, 0, 0, 0 \n");
//		if (sChkHis.equals("0"))
//		{
			sbSql.append("              FROM EPROCUSR.VO_IVT_MONTH A, HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST F \n");
//		}
//		else
//		{
//			sbSql.append("              FROM HLDC_HIS_PO_ONHAND_MONTH_2013 A, HLDC_PO_SUBINVENTORY B, HLDC_PO_ITEM_MST F \n");
//		}
		sbSql.append("             WHERE ONHAND_YM = TO_CHAR( ADD_MONTHS( TO_DATE('" + str_in_TRANS_DATE  + "', 'YYYYMM'), -1 ), 'YYYYMM') \n");
		sbSql.append("               AND A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("               AND A.ITEM_CODE = F.ITEM_CODE \n");
		sbSql.append("               AND A.SUBINV_CODE NOT LIKE 'E%' \n");
		sbSql.append("               AND EXISTS (SELECT 1 FROM HLDC_SC_DEPT X WHERE X.CC_CD = B.CC_CD AND X.MU_CD = '2002') \n");
		sbSql.append("            GROUP BY B.UPJANG, A.SUBINV_CODE, B.SUBINV_NAME, B.OUTVAT_FLAG, TAX_CODE \n");
		sbSql.append("    ) A, \n");
		sbSql.append("    ( \n");
//		sbSql.append("            SELECT UPJANG, CODE_NAME \n");     // ME4RING - ������ ������û 20151112
//		sbSql.append("              FROM HLDC_ST_UPJANG A, (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'UPJANG_KIND' AND USE_YN = 'Y') B \n");
//		sbSql.append("             WHERE A.CLASS_CD = B.CODE \n");
        sbSql.append("    SELECT A.UPJANG, B.UPJANG_GRP_NM AS CODE_NAME  \n");
        sbSql.append("      FROM HLDC_ST_UPJANG A, ( SELECT UPJANG_GRP, UPJANG_GRP_NM, UPJANG FROM EPROCUSR.VO_UPJANG_GRP WHERE USE_YN = 'Y' ) B   \n");
        sbSql.append("    WHERE A.UPJANG = B.UPJANG         \n");
        sbSql.append("    ) B \n");
		sbSql.append("    WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("    GROUP BY B.CODE_NAME \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		rs.close(); 
		pstmt.close();		
		System.out.println(ds_list.getRowCount());
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
