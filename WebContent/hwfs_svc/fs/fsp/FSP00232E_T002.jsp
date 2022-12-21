<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	CallableStatement cstmt = null;

	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log ���� ����
		logger.startIndividualLog(in_vl.getString("titLogId"));

		// ����Ŀ�� ���� false
		conn.setAutoCommit(false);

		DataSet ds_stockDate     = in_dl.get("ds_stockDate");

		String v_SubinvCode		= nullToBlank(in_vl.getString("v_SubinvCode"));
		String v_Date			= nullToBlank(in_vl.getString("v_Date"));
		String sDateF			= nullToBlank(in_vl.getString("v_FrDate"));
		String sDateT			= nullToBlank(in_vl.getString("v_ToDate"));
		String g_EmpNo			= nullToBlank(in_vl.getString("g_EmpNo"));

		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT CASE WHEN TO_CHAR(SYSDATE, 'YYYYMMDD') < '" + sDateT + "' \n");
		sbSql.append("            THEN 'Y' \n");
		sbSql.append("            ELSE 'N' END DATE_YN \n");
		sbSql.append("  FROM DUAL \n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
		rs.next();
		String dateYn = rs.getString("DATE_YN");

		if( dateYn.equals("Y") )
		{
			out_vl.add("v_ClsMsg", "�������ڴ� �����Ϻ��� �۰ų� ���ƾ� �մϴ�.");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		rs.close();
        pstmt.close();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* �ش� �Ⱓ ���� ���Ҹ����� �����ϴ��� üũ */ \n");
		sbSql.append("SELECT TO_CHAR(TO_DATE(A.CLS_YM, 'YYYYMM'), 'YYYY\"��\"MM\"��\"') AS CLS_YM \n");
		sbSql.append("  FROM HLDC_PO_CLOSING A \n");
		sbSql.append(" WHERE A.CLS_YM     >= SUBSTR('" + sDateF + "', 1, 6) \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append("   AND A.CLS_FLAG    = 'Y' \n");
		sbSql.append("   AND ROWNUM        = 1 \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_ClsMsg", "��â��� ���Ҹ���(" + rs.getString("CLS_YM") + ")�� \n�Ϸ�Ǿ� ���۾��� �Ұ��մϴ�!");
		   	this.setResultMessage(0, "OK", out_vl);
		   	proc_output(response, out, out_vl, out_dl);
		   	return;
		}

		rs.close();
		pstmt.close();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* �ش� �Ⱓ ���� ������簡 �����ϴ��� üũ */ \n");
		sbSql.append("SELECT TO_CHAR(TO_DATE(A.PHYSIC_DATE, 'YYYYMMDD'), 'YYYY\"��\"MM\"��\"DD\"��\"') AS PHYSIC_DATE \n");
		sbSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("      , ( SELECT DISTINCT A.* \n");
		sbSql.append("            FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("               , ( SELECT PHYSIC_DATE AS PHYSIC_DATE \n");
		sbSql.append("                        , ITEM_CODE AS ITEM_CODE \n");
		sbSql.append("                        , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
		sbSql.append("                     FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSql.append("                    WHERE PHYSIC_DATE > '" + sDateT + "' \n");
		sbSql.append("                      AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append("                    GROUP BY PHYSIC_DATE, ITEM_CODE \n");
		sbSql.append("                 ) B \n");
		sbSql.append("           WHERE A.PHYSIC_DATE = B.PHYSIC_DATE \n");
		sbSql.append("             AND A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("             AND A.UPDATE_DATE = B.UPDATE_DATE \n");
		sbSql.append("             AND A.PHYSIC_DATE > '" + sDateT + "' \n");
		sbSql.append("             AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append("        ) B \n");
		sbSql.append(" WHERE A.PHYSIC_ID   = B.PHYSIC_ID \n");
		sbSql.append("   AND A.PHYSIC_DATE = B.PHYSIC_DATE \n");
		sbSql.append("   AND A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("   AND A.PHYSIC_DATE > '" + sDateT + "' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append("   AND B.CANCEL_YN   = 'N' \n");
		sbSql.append(" ORDER BY A.PHYSIC_DATE DESC \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_ClsMsg", "��â��� �������(" + rs.getString("PHYSIC_DATE") + ")��\n �ݿ��Ǿ� ���۾��� �Ұ��մϴ�!");
		   	this.setResultMessage(0, "OK",out_vl);
		   	proc_output(response,out,out_vl,out_dl);
		   	return;
		}

		rs.close();
		pstmt.close();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* ����� ���� Ȯ�� */ \n");
		sbSql.append("SELECT TO_CHAR(TO_DATE(CLOSE_DATE, 'YYYYMMDD'), 'YYYY\"��\"MM\"��\"DD\"��\"') AS CLOSE_DATE \n");
		sbSql.append("  FROM MAS_CLOSE_MGMT \n");
		sbSql.append(" WHERE UPJANG = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + v_SubinvCode + "') \n");
		sbSql.append("   AND CLOSE_GUBUN = '004' \n");
		sbSql.append("   AND CLOSE_DATE BETWEEN '" + sDateF + "' AND '" + sDateT + "' \n");
		sbSql.append(" ORDER BY CLOSE_DATE DESC \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		if( rs.next() )
		{
			out_vl.add("v_ClsMsg", "��â��� �����(" + rs.getString("CLOSE_DATE") + ")��\n �̷���� ���۾��� �Ұ��մϴ�!");
		   	this.setResultMessage(0, "OK",out_vl);
		   	proc_output(response,out,out_vl,out_dl);
		   	return;
		}

		rs.close();
		pstmt.close();

		int useCnt = 0;	// �ݿ���� ī��Ʈ
		String s_physic_date = "";
		for( int i = 0; i < ds_stockDate.getRowCount(); i++ )
		{
			s_physic_date = nullToBlank(ds_stockDate.getString(i, "PHYSIC_DATE"));

			if( s_physic_date.equals("") )	continue;

			int stockCnt = 0;
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* ���ں� ���ǻ� ���� Ȯ�� */ \n");
			sbSql.append("SELECT COUNT(*) AS STOCK_CNT \n");
			sbSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
			sbSql.append("      , ( SELECT DISTINCT A.* \n");
			sbSql.append("            FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
			sbSql.append("               , ( SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("                        , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
			sbSql.append("                     FROM HLDC_PO_PHYSICAL_INVENTORY \n");
			sbSql.append("                    WHERE PHYSIC_DATE = '" + s_physic_date + "' \n");
			sbSql.append("                      AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbSql.append("                    GROUP BY ITEM_CODE \n");
			sbSql.append("                 ) B \n");
			sbSql.append("           WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("             AND A.UPDATE_DATE = B.UPDATE_DATE \n");
			sbSql.append("             AND A.PHYSIC_DATE = '" + s_physic_date + "' \n");
			sbSql.append("             AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbSql.append("        ) B \n");
			sbSql.append(" WHERE A.PHYSIC_ID   = B.PHYSIC_ID \n");
			sbSql.append("   AND A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("   AND A.PHYSIC_DATE = '" + s_physic_date + "' \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbSql.append("   AND B.CANCEL_YN   = 'N' \n");
			   
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			stockCnt = rs.getInt("STOCK_CNT");
			
			if( stockCnt == 0 )	continue;

			pstmt.close();
			rs.close();

			// �׷��ȣ ����
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* �׷��ȣ ���� */ \n");
			sbSql.append("SELECT FSP_PHYSICAL_INVENTORY_S.NEXTVAL AS STOCK_CNT FROM DUAL \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			int grpNo = rs.getInt("STOCK_CNT");

			pstmt.close();
			rs.close();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* ������ ���·� ������Ʈ */ \n");
			sbSql.append("MERGE INTO FSP_PHYSICAL_INVENTORY_STOCK A \n");
			sbSql.append("USING ( \n");
			sbSql.append("        SELECT A.PHYSIC_ID \n");
			sbSql.append("             , A.PHYSIC_DATE \n");
			sbSql.append("             , A.SUBINV_CODE \n");
			sbSql.append("             , A.ITEM_CODE \n");
			sbSql.append("          FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
			sbSql.append("             , (SELECT DISTINCT A.* \n");
			sbSql.append("                  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
			sbSql.append("                     , (SELECT ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("                             , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
			sbSql.append("                          FROM HLDC_PO_PHYSICAL_INVENTORY \n");
			sbSql.append("                         WHERE PHYSIC_DATE = '" + s_physic_date + "' \n");
			sbSql.append("                           AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbSql.append("                         GROUP BY ITEM_CODE) B \n");
			sbSql.append("                 WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                   AND A.UPDATE_DATE = B.UPDATE_DATE \n");
			sbSql.append("                   AND A.PHYSIC_DATE = '" + s_physic_date + "' \n");
			sbSql.append("                   AND A.SUBINV_CODE = '" + v_SubinvCode + "') B \n");
			sbSql.append("         WHERE A.PHYSIC_ID   = B.PHYSIC_ID \n");
			sbSql.append("           AND A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("           AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
			sbSql.append("           AND A.PHYSIC_DATE = '" + s_physic_date + "' \n");
			sbSql.append("           AND B.CANCEL_YN   = 'N' \n");
			sbSql.append("      ) B \n");
			sbSql.append("ON (    A.PHYSIC_DATE = B.PHYSIC_DATE \n");
			sbSql.append("    AND A.SUBINV_CODE = B.SUBINV_CODE \n");
			sbSql.append("    AND A.ITEM_CODE   = B.ITEM_CODE ) \n");
			sbSql.append("WHEN MATCHED THEN \n");
			sbSql.append("UPDATE \n");
			sbSql.append("   SET A.PHYSIC_ID = B.PHYSIC_ID \n");
			sbSql.append("     , A.STATUS = 'N' \n");
			sbSql.append("     , A.TR_TYPE = 'C' \n");
			sbSql.append("     , A.GRP_NO = '" + grpNo + "' \n");
			sbSql.append("     , A.UPDATE_DATE = SYSDATE \n");
			sbSql.append("     , A.UPDATE_BY  = '" + g_EmpNo + "' \n");
			
			
			pstmt = conn.prepareStatement(sbSql.toString());
			int rtn = pstmt.executeUpdate();

			cstmt = conn.prepareCall("{call EPROCUSR.PK_IF_FCUS_INSP_EXCUTE.PK_CANCEL_EXCUTE(?, ?, ?, ?)}");

			cstmt.setString(1, Integer.toString(grpNo));
			cstmt.setString(2, g_EmpNo);
			cstmt.registerOutParameter(3, Types.VARCHAR);
			cstmt.registerOutParameter(4, Types.VARCHAR);

			cstmt.execute();

			if( cstmt.getString(3).equals("E") )
			{
				String strMsg = "";

				if( nullToBlank(cstmt.getString(4)).equals("") )
					strMsg = "�ý��ۿ���! ���� ����ڿ��� ���� �ϼ���.";
				else
					strMsg = nullToBlank(cstmt.getString(4));

				out_vl.add("v_PO_PHYSICUPD_PRO", strMsg);
				this.setResultMessage(0, "OK", out_vl);

				conn.rollback();

				proc_output(response, out, out_vl, out_dl);
				return;
			}

			useCnt++;
		}

		if( useCnt > 0 )
		{
			conn.commit();
			this.setResultMessage(0, "OK", out_vl);			
		}
		else
		{
			out_vl.add("v_ClsMsg", "��â��� �ϰ���� �Ⱓ���� ��������� �ڷᰡ �����ϴ�.");
		   	this.setResultMessage(0, "OK",out_vl);
		   	proc_output(response,out,out_vl,out_dl);
		   	return;
		}
	}
	catch(Exception ex)
	{
		conn.rollback();

		//jsp �α׳����
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
		if( cstmt != null )
		{
			try {
				cstmt.close();
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