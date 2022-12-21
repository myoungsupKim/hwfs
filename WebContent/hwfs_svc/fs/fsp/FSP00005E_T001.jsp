<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log ���� ����
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_cond     = in_dl.get("ds_cond");

		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sSeason      = nullToBlank(in_vl.getString("nCbSeason"));
		String sStartDt		= nullToBlank(in_vl.getString("sStartDt"));
		String sEndDt		= nullToBlank(in_vl.getString("sEndDt"));
		String sItemNm		= nullToBlank(in_vl.getString("sItemNm"));

		StringBuffer sbSql = new StringBuffer();

		if( sType.equals("ItmQry") )
		{
			sbSql.append("/* ���˻�ǰ ��ȸ */ \n");
			sbSql.append("SELECT 0 AS CHK \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , C.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , DECODE(C.TAX_CODE, '100', '����', '210', '�鼼', '����') AS TAX_CODE \n");
			sbSql.append("     , A.CONTRACT_PRICE AS UNIT_PRICE  /* ���Դܰ� */ \n");
			sbSql.append("     , NVL(B.SALE_PRICE, 0) AS SALE_PRICE  /* ��ǰ�� */ \n");
			sbSql.append("     , NVL(B.SALE_PRICE, A.CONTRACT_PRICE) AS SALE_AMT  /* �ǸŰ� */ \n");
			sbSql.append("     , C.MAX_ORD_QTY AS MAX_ORD_QTY /* �������� */ \n");
			sbSql.append("     , A.CUSTCD AS CUSTCD      /* ��ü�ڵ� */ \n");
			sbSql.append("     , (SELECT D.VD_NM || DECODE(TRIM(D.BIZ_REG_NO), '', '', '(' || D.BIZ_REG_NO || ')') \n");
			sbSql.append("          FROM VO_FC_VENDOR D \n");
			sbSql.append("         WHERE TO_CHAR(A.CUSTCD) = D.VD_CD) AS CUSTNM /* ��ü�� */ \n");
			sbSql.append("     , NVL(B.QTY_DC_STD, 0) AS QTY_DC_STD  /* �������� ���ط� */ \n");
			sbSql.append("     , NVL(B.QTY_DC_RATE, 0) AS QTY_DC_RATE /* �������� �� */ \n");
			sbSql.append("     , NVL(B.AMT_DC_STD, 0) AS AMT_DC_STD  /* �ݾ����� ���ؾ� */ \n");
			sbSql.append("     , NVL(B.AMT_DC_RATE, 0) AS AMT_DC_RATE /* �ݾ����� �� */ \n");
			sbSql.append("     , NVL(B.STOCK_QTY, NVL(A.CNTR_QTY, 0)) AS STOCK_QTY  /* ������� */ \n");
			sbSql.append("     , NVL((SELECT SUM(Z.PR_QTY) \n");
			sbSql.append("              FROM FSP_PO_SPECIAL_SALE Z \n");
			sbSql.append("             WHERE Z.ITEM_CODE = A.ITEM_CODE \n");
			sbSql.append("               AND Z.SEASON_NUM = '" + sSeason + "' \n");
			sbSql.append("               AND Z.SP_TYPE = 'ING' \n");
			sbSql.append("               AND Z.LINE_STATUS <> '���'), 0) AS ORD_QTY  /* �ֹ��� */ \n");
			sbSql.append("     , C.ITEM_SIZE AS ITEM_SIZE /* �԰� */ \n");
			sbSql.append("     , B.ITEM_NUM AS ITEM_NUM /* īŻ�α� ��ȣ */ \n");
			sbSql.append("     , C.IMG_PATH AS IMAGE_PATH \n");
			sbSql.append("     , B.SEASON_NUM AS SEASON_NUM \n");
			sbSql.append("     , A.CONTRACT_START AS CONTRACT_START \n");
			sbSql.append("     , A.CONTRACT_END AS CONTRACT_END \n");
			sbSql.append("     , (SELECT DECODE(F.UPJANGNM, '', '', F.UPJANGNM || '(' || F.UPJANG || ')') \n");
			sbSql.append("          FROM FSP_PO_SEASON_LIST D \n");
			sbSql.append("             , SCO_UPJANG_MST_V F \n");
			sbSql.append("         WHERE D.UPJANG = F.UPJANG \n");
			sbSql.append("           AND D.SID = '" + sSeason + "') AS UPJANGNM \n");
			sbSql.append("     , A.OPER_ORG_SN \n");
			sbSql.append("     , A.VD_SN \n");
			sbSql.append("     , C.IMG_YN AS IMG_YN \n");
			sbSql.append("  FROM HLDC_PO_CONTRACT_SPEC A \n");
			sbSql.append("     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append("   AND A.OPER_ORG_SN IN ( '574', '575', '576', '577', '611', '711', '811' ) \n");
			sbSql.append("   AND B.SEASON_NUM(+) = '" + sSeason + "' \n");
			sbSql.append("   AND A.CONTRACT_START <= '" + sEndDt + "' \n");
			sbSql.append("   AND A.CONTRACT_END >= '" + sStartDt + "' \n");
			if( !sItemNm.equals("") )
			{
				sbSql.append("   AND (C.ITEM_CODE LIKE '%'||'" + sItemNm + "'||'%' \n");
				sbSql.append("     OR C.ITEM_NAME LIKE '%'||'" + sItemNm + "'||'%') \n");
			}
			sbSql.append(" ORDER BY B.SEASON_NUM, B.ITEM_NUM, A.ITEM_CODE \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		// jsp �α׳����
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch( Exception e ) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch( Exception e ) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch( Exception e ) {}
		}

		// jsp log ���� �ݱ�
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>