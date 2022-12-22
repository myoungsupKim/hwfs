<%@page import="com.sz.util.AppDataUtility"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		String SAUPTYPE 	= nullToBlank(in_vl.getString("SAUPTYPE"));
		String TM 			= nullToBlank(in_vl.getString("TM"));
		String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));
		String FROM			= nullToBlank(in_vl.getString("FROM"));
		String TO			= nullToBlank(in_vl.getString("TO"));
		String CHK_CLOSE	= nullToBlank(in_vl.getString("CHK_CLOSE"));
		String MU_CD		= nullToBlank(in_vl.getString("MU_CD"));
		String CLASS_1		= nullToBlank(in_vl.getString("CLASS_1"));


		StringBuffer sbSql = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 사업장 재고등록현황 */ \n");
 		sbSql.append("SELECT /*+ USE_HASH(A B) */ A.TM_NAME \n");
 		sbSql.append("     , A.JOB_NAME \n");
		sbSql.append("     , A.SUB_JOB_NAME \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , A.UPJANGNM \n");
		sbSql.append("     , A.SUBINV_CODE \n");
		sbSql.append("     , A.SUBINV_NAME \n");
		sbSql.append("     , A.YYYYMMDD \n");
		sbSql.append("     , NVL2(A.CLOSE_DATE, '1', '') CLOSE_GBN \n");
//		sbSql.append("     , UPPER(A.OP_YN) \n");
		//sbSql.append("     , DECODE(UPPER(A.OP_YN), 'N', '#', 'Y', DECODE(B.PHYSIC_DATE, NULL, 'N', 'Y')) STOCK_YN \n");
		sbSql.append("     , DECODE(B.PHYSIC_DATE, NULL, 'N', 'Y') STOCK_YN \n");
		//sbSql.append("     , nvl(DECODE(UPPER(A.OP_YN), 'N', 0, 'Y', DECODE(B.PHYSIC_DATE, NULL, 1, 0)), 0) STOCK_CNT \n");
		sbSql.append("     , nvl(DECODE(B.PHYSIC_DATE, NULL, 1, 0), 0) STOCK_CNT \n");
		sbSql.append("     , A.COLOR \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT A.TM_CD \n");
		sbSql.append("             , A.TM_NAME \n");
		sbSql.append("             , A.JOB_NAME \n");
		sbSql.append("             , A.SUB_JOB_NAME \n");
		sbSql.append("             , A.UPJANG \n");
		sbSql.append("             , A.UPJANGNM \n");
		sbSql.append("             , A.SUBINV_CODE \n");
		sbSql.append("             , A.SUBINV_NAME \n");
		sbSql.append("             , A.YYYYMMDD \n");
		sbSql.append("             , C.OP_YN \n");
		sbSql.append("             , A.COLOR \n");
		sbSql.append("             , CLOSE_DATE \n");
		sbSql.append("          FROM ( \n");
		sbSql.append("                SELECT B.TM_CD \n");
		sbSql.append("                     , B.TM_NAME \n");
		sbSql.append("                     , B.JOB_NAME \n");
		sbSql.append("                     , B.SUB_JOB_NAME \n");
		sbSql.append("                     , B.UPJANG \n");
		sbSql.append("                     , B.UPJANGNM \n");
		sbSql.append("                     , C.SUBINV_CODE \n");
		sbSql.append("                     , C.SUBINV_NAME \n");
		sbSql.append("                     , CD_SY || CD_SM || CD_SD YYYYMMDD \n");
		sbSql.append("                     , DECODE(HOLIDAY, 1, 'RED', 2, 'RED', DECODE(CD_WEEK, '일', 'RED', '토', 'BLUE', 'WHITE')) COLOR \n");
		sbSql.append("                     , B.CLOSE_DATE  \n");
		sbSql.append("                  FROM SCC_CALENDA_DATA A \n");
		sbSql.append("                     , FSA_UPJANG_V B \n");
		sbSql.append("                     , HLDC_PO_SUBINVENTORY C \n");
		sbSql.append("                 WHERE B.UPJANG = C.UPJANG \n");
		sbSql.append("                   AND CD_SY || CD_SM || CD_SD BETWEEN '" + FROM + "' AND '" + TO + "' \n");
		sbSql.append("                   AND B.SAUP_TYPE <> '004' \n");
		if( !MU_CD.equals("") )
		{
			sbSql.append("                   AND B.MU_CD = '" + MU_CD + "'  --사업부 \n");
		}
		if( !SAUPTYPE.equals("") )
		{
			sbSql.append("                   AND B.TM_CD = '" + SAUPTYPE + "'  --운영부서 \n");
		}
		if( !TM.equals("") )
		{
			sbSql.append("                   AND B.LEADER_SABUN = '" + TM + "'  --리더 \n");
		}
		if( !UPJANG.equals("") )
		{
			sbSql.append("                   AND B.UPJANG = '" + UPJANG + "'  --업장 \n");
		}
		if( CHK_CLOSE.equals("Y") )
		{
			sbSql.append("                   AND B.CLOSE_DATE IS NULL \n");
		}
		// F : 식자재, G : 상품 
		if( CLASS_1.equals("F") )
		{
			sbSql.append("                   AND C.SUBINV_CODE LIKE 'C%' \n");
		}
		else
		{
			sbSql.append("                   AND C.SUBINV_CODE LIKE 'A%' \n");
		}

		sbSql.append("                   AND C.STOCK_FLAG = 'Y' \n");
		sbSql.append("                   AND C.USE_YN = 'Y' \n");
		sbSql.append("               ) A \n");
		sbSql.append("             , MAF_OP_CALENDAR C \n");
		sbSql.append("         WHERE A.YYYYMMDD = C.OP_DATE(+) \n");
		sbSql.append("           AND A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("       ) A \n");
		sbSql.append("     , ( \n");
		sbSql.append("        SELECT A.UPJANG \n"); 
		sbSql.append("             , B.SUBINV_CODE \n");
		sbSql.append("             , B.PHYSIC_DATE \n");
		sbSql.append("          FROM HLDC_PO_SUBINVENTORY A \n");
		sbSql.append("             , FSP_PHYSICAL_INVENTORY_STOCK B \n");
		sbSql.append("         WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("           AND B.PHYSIC_DATE BETWEEN '" + FROM + "' AND '" + TO + "' \n");

		// F : 식자재, G : 상품 
		if( CLASS_1.equals("F") )
		{
			sbSql.append("           AND B.SUBINV_CODE LIKE 'C%' \n");
		}
		else
		{
			sbSql.append("           AND B.SUBINV_CODE LIKE 'A%' \n");
		}

		sbSql.append("           AND B.TR_TYPE = 'I' \n");
		sbSql.append("         GROUP BY A.UPJANG, B.SUBINV_CODE, B.PHYSIC_DATE \n");
		sbSql.append("       ) B \n");
/*
		sbSql.append("     , ( \n");
		sbSql.append("        SELECT DISTINCT A.UPJANG \n");
		sbSql.append("             , B.PHYSIC_DATE \n");
		sbSql.append("          FROM HLDC_PO_SUBINVENTORY A \n");
		sbSql.append("             , HLDC_PO_PHYSICAL_INVENTORY B \n");
*/
/*
		sbSql.append("             , ( \n");
		sbSql.append("                SELECT PHYSIC_ID \n");
		sbSql.append("                  FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSql.append("                 WHERE PHYSIC_DATE BETWEEN '" + FROM + "' AND '" + TO + "' \n");
		sbSql.append("                   AND SUBINV_CODE LIKE 'C%' \n");
		sbSql.append("                GROUP BY PHYSIC_ID, PHYSIC_DATE \n");
		sbSql.append("               HAVING COUNT(1) = 1 \n");
		sbSql.append("               ) C \n");
*/
/*
		sbSql.append("             , ( \n");
		sbSql.append("                SELECT DISTINCT A.* \n");
		sbSql.append("                  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSql.append("                     , (SELECT PHYSIC_DATE \n");
		sbSql.append("                             , SUBINV_CODE \n");
		sbSql.append("                             , ITEM_CODE \n");
		sbSql.append("                             , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
		sbSql.append("                          FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSql.append("                         WHERE PHYSIC_DATE BETWEEN '" + FROM + "' AND '" + TO + "' \n");
		sbSql.append("                           AND SUBINV_CODE LIKE 'C%' \n");
		sbSql.append("                         GROUP BY PHYSIC_DATE, SUBINV_CODE, ITEM_CODE) B \n");
		sbSql.append("                 WHERE A.PHYSIC_DATE = B.PHYSIC_DATE \n"); 
		sbSql.append("                   AND A.SUBINV_CODE = B.SUBINV_CODE \n"); 
		sbSql.append("                   AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                   AND A.UPDATE_DATE = B.UPDATE_DATE \n");  
		sbSql.append("               ) C \n");
		sbSql.append("         WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("           AND B.PHYSIC_ID   = C.PHYSIC_ID \n");
		sbSql.append("           AND B.ITEM_CODE   = C.ITEM_CODE \n");
		sbSql.append("           AND C.CANCEL_YN   = 'N' \n");
		sbSql.append("       ) B \n");
*/
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.SUBINV_CODE = B.SUBINV_CODE(+) \n");
		sbSql.append("   AND A.YYYYMMDD = B.PHYSIC_DATE(+) \n");
		sbSql.append(" ORDER BY TM_NAME, JOB_NAME, SUB_JOB_NAME, CLOSE_DATE DESC, UPJANGNM \n");
		sbSql.append("        , CASE WHEN SUBSTR(SUBINV_CODE, 0, 1) = 'C' THEN 0 \n");
		sbSql.append("               WHEN SUBSTR(SUBINV_CODE, 0, 1) = 'E' THEN 1 \n");
		sbSql.append("               WHEN SUBSTR(SUBINV_CODE, 0, 1) = 'A' THEN 2 \n");
		sbSql.append("               ELSE 4 END, SUBINV_CODE, YYYYMMDD \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		DataSet ds_List = this.makeDataSet(rs, "ds_List");
		out_dl.add(ds_List);

	   	this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		// jsp 로그남기기
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

		// jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>