<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �޴�����/�������/��ȹ���� �����Ȳ ��ȸ
�� ���α׷�ID   : FSI00091V_T001.jsp
�� ���α׷���   : ���纰 �����Ȳ��ȸ
�� �ۼ�����     : 2008.02.12
�� �ۼ���       : ������
�� �̷°���     : 2008.02.12
1)������ 2012-11-05 CSR#(CH201210_00143) ��û��:������(FS��ȹ��)
��ȸ�Ⱓ�� ���ڼ������� ����(���Ͽ� ��)
��ȸ���ǿ� ����, �� ���� �߰�
�ǹ���->������ ��Ī����, ������ �׸����, FS����θ� ��ȸ(���翵��, �ܽ� �� ����)
��ܿ� ��û���(��û��-������), �԰���(�԰�-������) �߰�
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
	
		//FileLog.println("d:\\aaa.txt", ds_cond);
		
	
		String strFromDt 	= nullToBlank(ds_input.getString(0, "FROM_DT"));
		String strToDt		= nullToBlank(ds_input.getString(0, "TO_DT"));
		//============================================================================================
		//(2012-11-05 �߰�) ����
		// ������ 2012-11-05 CSR#(CH201210_00143) ��û��:������(FS��ȹ��)
		// ��ȸ���ǿ� ����, �� ���� �߰�
		//============================================================================================
		String strCenterCode= nullToBlank(ds_input.getString(0, "CENTER_CODE"));
		String strTmCd		= nullToBlank(ds_input.getString(0, "TM_CD"));
		//============================================================================================
		//(2012-11-05 �߰�) ��
		//============================================================================================

		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		sbSql.append("WITH PRTR_TBL AS                                                                                                                         \n");
		sbSql.append("(                                                                                                                                        \n");
		sbSql.append("     SELECT /*+ ORDERED USE_NL(B A) */                                                                                                   \n");
		sbSql.append("            A.CENTER_CODE                                                                                                                \n");
		sbSql.append("          , A.CUSTCD                                                                                                                     \n");
		sbSql.append("          , A.ITEM_CODE                                                                                                                  \n");
		sbSql.append("          , B.START_DATE                                                                                                                 \n");
		sbSql.append("          , A.TRANS_UPJANG AS UPJANG                                                                                                     \n");
		sbSql.append("          , 0 AS PR_QTY                                                                                                                  \n");
		sbSql.append("          , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY AS TRANS_QTY                                                         \n");
		sbSql.append("       FROM FSI_DUTY_MST B                                                                                                               \n");
		sbSql.append("          , HLDC_PO_TRANSACTION A                                                                                                        \n");
		sbSql.append("          , MAC_UPJANG_V C                                                                                                               \n");
		sbSql.append("      WHERE A.CENTER_CODE = B.CENTER_CODE                                                                                                \n");
		sbSql.append("        AND A.CUSTCD = B.CUSTCD                                                                                                          \n");
		sbSql.append("        AND A.ITEM_CODE = B.ITEM_CODE                                                                                                    \n");
		sbSql.append("        AND A.TRANS_DATE BETWEEN GREATEST(B.START_DATE, ?) AND LEAST(B.END_DATE, ?)                                                      \n");
		sbSql.append("        AND B.START_DATE <= ? AND B.END_DATE >= ?                                                                                        \n");
		sbSql.append("        AND A.TRANS_MU_CD = '2002'                                                                                                       \n");
		sbSql.append("        AND A.SUBINV_CODE LIKE 'C%'                                                                                                      \n");
		sbSql.append("        AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))                                               \n");
		sbSql.append("        AND A.TRANS_UPJANG = C.UPJANG                                                                                                    \n");
        
		if (!strCenterCode.equals(""))
		{
			sbSql.append("   AND A.CENTER_CODE = ?                                                                                                             \n");
		}
		
		if (!strTmCd.equals(""))
		{
			sbSql.append("   AND C.TM_CD = ?                                                                                                                   \n");
		}
		
		sbSql.append(")                                                                                                                                        \n");
		sbSql.append("SELECT TO_CHAR(A.CDATE,'YYYYMMDD') CDATE                                                                                                 \n");
		sbSql.append("     , A.CENTER_CODE                                                                                                                     \n");
		sbSql.append("     , (SELECT Z.CENTER_NAME FROM HLDC_PO_CENTER Z WHERE Z.CENTER_CODE = A.CENTER_CODE) AS CENTER_NAME                                   \n");
		sbSql.append("     , A.CUSTCD                                                                                                                          \n");
		sbSql.append("     , (SELECT Z.VD_NM FROM VO_FC_VENDOR Z WHERE Z.VD_CD = A.CUSTCD) AS CUSTNM                                                         \n");
		sbSql.append("     , A.ITEM_CODE                                                                                                                       \n");
		sbSql.append("     , B.ITEM_NAME                                                                                                                       \n");
		sbSql.append("     , B.ITEM_SIZE                                                                                                                       \n");
		sbSql.append("     , B.PO_UOM                                                                                                                          \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.START_DATE,'YYYYMMDD'),'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(A.END_DATE,'YYYYMMDD'),'YYYY.MM.DD') AS PERIOD   \n");
		sbSql.append("     , GREATEST(A.START_DATE, ?) AS START_DATE                                                                                           \n");
		sbSql.append("     , LEAST(A.END_DATE, ?) AS END_DATE                                                                                                  \n");
		sbSql.append("     , A.LIMIT_DUTY_QTY                                                                                                                  \n");
		sbSql.append("     , NVL(SUM(TRANS_QTY),0) AS TRANS_QTY                                                                                                \n");
		sbSql.append("     , NVL(SUM(TRANS_QTY),0) - A.LIMIT_DUTY_QTY AS TRANS_DIFF                                                                            \n");
		sbSql.append("     , DECODE(A.LIMIT_DUTY_QTY, 0, 0, ROUND(NVL(SUM(TRANS_QTY),0) / A.LIMIT_DUTY_QTY * 100, 2)) AS TRANS_RATE                            \n");
		sbSql.append("  FROM FSI_DUTY_MST A                                                                                                                    \n");
		sbSql.append("     , HLDC_PO_ITEM_MST B                                                                                                                \n");
		sbSql.append("     , (SELECT A.*, C.TM_CD                                                                                                              \n");
		sbSql.append("          FROM PRTR_TBL A, HLDC_ST_UPJANG B, HLDC_SC_DEPT C                                                                              \n");
		sbSql.append("             ,(SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0045' AND USE_YN = 'Y') D                                          \n");
		sbSql.append("         WHERE A.UPJANG = B.UPJANG                                                                                                       \n");
		sbSql.append("           AND B.DEPT_ID = C.DEPT_ID                                                                                                     \n");
		sbSql.append("           AND C.TM_CD = D.CODE                                                                                                          \n");
		sbSql.append("       ) E                                                                                                                               \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                         \n");
		sbSql.append("   AND A.CENTER_CODE = E.CENTER_CODE(+)                                                                                                  \n");
		sbSql.append("   AND A.CUSTCD = E.CUSTCD(+)                                                                                                            \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+)                                                                                                      \n");
		sbSql.append("   AND A.START_DATE = E.START_DATE(+)                                                                                                    \n");
		sbSql.append("   AND A.START_DATE <= ? AND A.END_DATE >= ?                                                                                             \n");
		
		if (!strCenterCode.equals("")) {
			sbSql.append("   AND A.CENTER_CODE = ?                                                                                                             \n");
		}
		
		if (!strTmCd.equals("")) {
			sbSql.append("   AND E.TM_CD = ?                                                                                                                   \n");
		}
		
		sbSql.append(" GROUP BY A.CDATE                                                                                                                        \n");
		sbSql.append("        , A.CENTER_CODE                                                                                                                  \n");
		sbSql.append("        , A.CUSTCD                                                                                                                       \n");
		sbSql.append("        , A.ITEM_CODE                                                                                                                    \n");
		sbSql.append("        , B.ITEM_NAME                                                                                                                    \n");
		sbSql.append("        , B.ITEM_SIZE                                                                                                                    \n");
		sbSql.append("        , B.PO_UOM                                                                                                                       \n");
		sbSql.append("        , A.START_DATE                                                                                                                   \n");
		sbSql.append("        , A.END_DATE                                                                                                                     \n");
		sbSql.append("        , A.LIMIT_DUTY_QTY 		                                                                                                       \n");
		
        out_vl.add("fa_Sql", sbSql.toString());
        
		pstmt = conn.prepareStatement(sbSql.toString());
		int idx = 1;
		pstmt.setString(idx++, strFromDt);
		pstmt.setString(idx++, strToDt);
		pstmt.setString(idx++, strToDt);
		pstmt.setString(idx++, strFromDt);
		
		if (!strCenterCode.equals("")) {
		    pstmt.setString(idx++, strCenterCode);
		}
		
		if (!strTmCd.equals("")) {		
			pstmt.setString(idx++, strTmCd);
		}
		
		pstmt.setString(idx++, strFromDt);
		pstmt.setString(idx++, strToDt);
		pstmt.setString(idx++, strToDt);
		pstmt.setString(idx++, strFromDt);
		
		if (!strCenterCode.equals("")) {
		    pstmt.setString(idx++, strCenterCode);
		}
		
		if (!strTmCd.equals("")) {		
			pstmt.setString(idx++, strTmCd);
		}
		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		pstmt.close();

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