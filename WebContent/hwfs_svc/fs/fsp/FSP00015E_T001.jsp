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

		DataSet ds_cond = in_dl.get("ds_cond");

		String g_Upjang		= nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo		= nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Deptid		= nullToBlank(in_vl.getString("g_Deptid"));
		String sType		= nullToBlank(in_vl.getString("sType"));
		String sSpId		= nullToBlank(in_vl.getString("sSpId"));
		String sSeasonNum	= nullToBlank(in_vl.getString("sSeasonNum"));
		String sRqSabun     = nullToBlank(in_vl.getString("sRqSabun"));
		String v_auth1		= nullToBlank(in_vl.getString("v_auth1"));
		String v_auth2		= nullToBlank(in_vl.getString("v_auth2"));
		String sUpjang		= nullToBlank(in_vl.getString("sUpjang"));
		String spUpjangYn   = nullToBlank(in_vl.getString("spUpjangYn"));
		String sChgUpjang	= nullToBlank(in_vl.getString("sChgUpjang"));

		StringBuffer sbSql = new StringBuffer();

		// 마감내역 조회
		if( sType.equals("QryLst") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 마감내역 조회 */ \n");
	        sbSql.append("SELECT '0' AS CHK \n");
	        sbSql.append("     , V.SP_DATE \n");
	        sbSql.append("     , MAX(V.SP_DATE2) AS SP_DATE2 \n");
	        sbSql.append("     , V.PR_SABUN \n");
	        sbSql.append("     , (SELECT Z.NM_KOR || ' ' || Z.SABUN \n");
	        sbSql.append("          FROM HLDC_HR_PERSONAL Z \n");
	        sbSql.append("         WHERE Z.SABUN = V.PR_SABUN) AS PR_SABUNNM \n");
	        sbSql.append("     , V.RQ_SABUN \n");
	        sbSql.append("     , (SELECT Z.NM_KOR || ' ' || Z.SABUN \n");
	        sbSql.append("          FROM HLDC_HR_PERSONAL Z \n");
	        sbSql.append("         WHERE Z.SABUN = V.RQ_SABUN) AS RQ_SABUNNM \n");
	        sbSql.append("     , (SELECT V2.MU_NM || ' ' || V2.CC_NM \n");
	        sbSql.append("          FROM HLDC_HR_PERSONAL V1 \n");
	        sbSql.append("             , HLDC_SC_DEPT_V V2 \n");
	        sbSql.append("         WHERE V1.DEPT_ID = V2.DEPT_ID \n");
	        sbSql.append("           AND V1.SABUN = V.RQ_SABUN) AS RQ_SABUN_CC_NM \n");
	        sbSql.append("     , V.PAY_METHOD \n");
	        sbSql.append("     , V.CARD_COMP \n");
	        sbSql.append("     , V.CARD_NUM \n");
	        sbSql.append("     , V.INST_PERIOD \n");
	        sbSql.append("     , V.TAX_CODE \n");
	        sbSql.append("     , DECODE(V.TAX_CODE, NULL, '', DECODE(V.TAX_CODE, '과세', '1', '면세', '2')) AS TAX_CODE_GBN \n");
	        sbSql.append("     , V.BILL_NO \n");
	        sbSql.append("     , NVL(SUM(V.PR_QTY), 0) AS PR_QTY \n");
	        sbSql.append("     , NVL(SUM(V.SALE_AMOUNT), 0) AS SALE_AMOUNT \n");
	        sbSql.append("     , NVL(SUM(V.DC_AMOUNT), 0) AS DC_AMOUNT \n");
	        sbSql.append("     , NVL(SUM(V.TOT_AMOUNT), 0) AS TOT_AMOUNT \n");
	        if( nullToBlank(ds_cond.getString(0, "STATUS")).equals("'주문'") )
	        {
	        	sbSql.append("     , V.LINE_STATUS AS LINE_STATUS \n");
	        	sbSql.append("     , '' AS PAY_TIME \n");
	        }
	        // 취소의 경우(정산, 배달완료분) GROUP BY에서 STATUS 제외
	        else {

	        	sbSql.append("     , '' AS LINE_STATUS \n");
	        	sbSql.append("     , V.PAY_TIME AS PAY_TIME \n");
	        }
	        sbSql.append("     , V.CARD_MM \n");
	        sbSql.append("     , V.CARD_YY \n");
	        sbSql.append("     , (SELECT A.UPJANGNM \n");
	        sbSql.append("          FROM ST_UPJANG A \n");
	        sbSql.append("         WHERE A.UPJANG = V.UPJANG) AS UPJANGNM \n");
	        sbSql.append("     , V.CARD_CLASS \n");
	        sbSql.append("     , DECODE(V.CARD_CLASS, NULL, '', DECODE(V.CARD_CLASS, '신용', '1', '체크', '2')) AS CARD_CLASS_GBN \n");
	        sbSql.append("     , V.APPRV_NUM \n");
	        sbSql.append("     , V.FRNC_STOR_NUM \n");
	        sbSql.append("     , V.CARD_MM || V.CARD_YY AS CARD_YYMM \n");
	        sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' AS SEASON_NUM \n");
	        sbSql.append("  FROM ( \n");
	        sbSql.append("        SELECT A.SP_DATE \n");
	        sbSql.append("             , CONCAT(A.SP_DATE, TO_CHAR(A.CREATE_DATE,'HH24MISS')) AS SP_DATE2 \n");
	        sbSql.append("             , A.PR_SABUN \n");
	        sbSql.append("             , A.RQ_SABUN \n");
	        sbSql.append("             , A.PAY_METHOD \n");
	        sbSql.append("             , A.CARD_COMP \n");
	        sbSql.append("             , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC ,'2') AS CARD_NUM \n");
	        sbSql.append("             , A.INST_PERIOD \n");
	        sbSql.append("             , DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
	        sbSql.append("             , A.BILL_NO \n");
	        sbSql.append("             , A.PR_QTY AS PR_QTY \n");
	        sbSql.append("             , A.SALE_AMOUNT AS SALE_AMOUNT \n");
			sbSql.append("             , (A.DC_AMOUNT + A.ADM_DC_AMOUNT) AS DC_AMOUNT \n");
			sbSql.append("             , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS TOT_AMOUNT \n");
	        sbSql.append("             , A.LINE_STATUS AS LINE_STATUS \n");
	        sbSql.append("             , A.VALID_THRU_MM AS CARD_MM  \n");
	        sbSql.append("             , A.VALID_THRU_YY AS CARD_YY  \n");
	        sbSql.append("             , A.UPJANG \n");
	        sbSql.append("             , A.CARD_CLASS \n");
	        sbSql.append("             , A.APPRV_NUM \n");
	        sbSql.append("             , A.FRNC_STOR_NUM \n");
			sbSql.append("             , A.VALID_THRU_MM \n");
			sbSql.append("             , A.VALID_THRU_YY \n");
			sbSql.append("             , TO_CHAR(A.PAY_TIME, 'YYYYMMDD') AS PAY_TIME \n");
			sbSql.append("          FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("             , FSP_PO_SPECIAL_ITEM B \n");
	        sbSql.append("             , HLDC_PO_ITEM_MST C \n");
	        sbSql.append("         WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
	        sbSql.append("           AND A.ITEM_CODE   = C.ITEM_CODE \n");
	        sbSql.append("           AND A.SEASON_NUM  = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
	        sbSql.append("           AND B.SEASON_NUM  = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("           AND A.SP_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "START_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "END_DATE")) + "' \n");
	        sbSql.append("           AND A.LINE_STATUS IN (" + nullToBlank(ds_cond.getString(0, "STATUS")) + ") \n");
	        if( !nullToBlank(ds_cond.getString(0, "BILL_NO")).equals("") )
	        {
	        	sbSql.append("           AND A.BILL_NO LIKE '%" + nullToBlank(ds_cond.getString(0, "BILL_NO")) + "%' \n");
	        }
	        sbSql.append("           AND A.BU_CD = '2000' \n");
	        // 판촉 귀속부서
	        if( spUpjangYn.equals("Y") )
	        {
	        	sbSql.append("           AND EXISTS( SELECT 'X' \n");
	        	sbSql.append("                         FROM FSP_PO_SPECIAL_UPJANG SU \n");
	        	sbSql.append("                        WHERE SU.UPJANG = A.UPJANG \n");
	        	sbSql.append("                          AND SU.SEASON_NUM = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
	        	sbSql.append("                          AND SU.UPJANG = '" + g_Upjang + "' \n");
	        	sbSql.append("                     ) \n");
	        }
	        // 그 외 제조부서
	        else
	        {
	        	sbSql.append("           AND EXISTS( SELECT 'X' \n");
	        	sbSql.append("                         FROM HLDC_HR_PERSONAL HR \n");
	        	sbSql.append("                            , HLDC_SC_DEPT_V SC \n");
	        	sbSql.append("                            , ST_UPJANG ST \n");
	        	sbSql.append("                        WHERE HR.DEPT_ID = SC.DEPT_ID \n");
	        	sbSql.append("                          AND HR.CC_CD = ST.CC_CD \n");
	        	sbSql.append("                          AND A.RQ_SABUN = HR.SABUN \n");
	        	sbSql.append("                          AND HR.GB_JAEJIK <> 'RA' \n");
	        	sbSql.append("                          AND ST.UPJANG = '" + g_Upjang + "' \n");
	        	sbSql.append("                     ) \n");
	        }
	        sbSql.append("       ) V \n");
	        if( nullToBlank(ds_cond.getString(0, "STATUS")).equals("'주문'") )
	        {
		        sbSql.append(" GROUP BY V.SP_DATE, V.PR_SABUN, V.RQ_SABUN, V.PAY_METHOD, V.CARD_CLASS, V.CARD_COMP, V.CARD_NUM, V.INST_PERIOD, V.TAX_CODE, V.BILL_NO, V.APPRV_NUM, V.FRNC_STOR_NUM, V.LINE_STATUS, V.CARD_MM, V.CARD_YY, V.UPJANG \n");
		        sbSql.append(" ORDER BY V.SP_DATE, V.PR_SABUN, V.RQ_SABUN, V.PAY_METHOD, V.CARD_CLASS, V.CARD_COMP, V.CARD_NUM, V.INST_PERIOD, V.TAX_CODE, V.BILL_NO, V.APPRV_NUM, V.FRNC_STOR_NUM, V.LINE_STATUS, V.CARD_MM, V.CARD_YY, V.UPJANG \n");
	        }
	        //취소의 경우(정산, 배달완료분) GROUP BY에서 STATUS 제외
	        else
	        {
		        sbSql.append(" GROUP BY V.SP_DATE, V.PR_SABUN, V.RQ_SABUN, V.PAY_METHOD, V.CARD_CLASS, V.CARD_COMP, V.CARD_NUM, V.INST_PERIOD, V.TAX_CODE, V.BILL_NO, V.APPRV_NUM, V.FRNC_STOR_NUM, V.CARD_MM, V.CARD_YY, V.UPJANG, V.PAY_TIME \n");
		        sbSql.append(" ORDER BY V.SP_DATE, V.PR_SABUN, V.RQ_SABUN, V.PAY_METHOD, V.CARD_CLASS, V.CARD_COMP, V.CARD_NUM, V.INST_PERIOD, V.TAX_CODE, V.BILL_NO, V.APPRV_NUM, V.FRNC_STOR_NUM, V.CARD_MM, V.CARD_YY, V.UPJANG, V.PAY_TIME \n");
	        }
		}
		// 마감내역 조회 - 관리자 화면
		else if( sType.equals("QryLstAdm")  )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 마감내역 조회 */ \n");
			sbSql.append("SELECT '0' AS CHK \n");
			sbSql.append("     , C.MU_CD \n");
			sbSql.append("     , C.MU_NM \n");
			sbSql.append("     , C.TM_CD \n");
			sbSql.append("     , C.TM_NM \n");
			sbSql.append("     , A.SP_DATE \n");
			sbSql.append("     , A.SP_DATE2 \n");
			sbSql.append("     , A.PR_SABUN \n");
			sbSql.append("     , (SELECT Z.NM_KOR || ' ' || Z.SABUN \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL Z \n");
			sbSql.append("         WHERE Z.SABUN = A.PR_SABUN) AS PR_SABUNNM \n");
			sbSql.append("     , A.RQ_SABUN \n");
			sbSql.append("     , B.NM_KOR || ' ' || B.SABUN AS RQ_SABUNNM \n");
			sbSql.append("     , C.MU_NM || ' ' || C.CC_NM AS RQ_SABUN_CC_NM \n");
			//sbSql.append("     , D.UPJANG \n");
			sbSql.append("     , A.UPJANG \n");
			//sbSql.append("     , (SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = D.UPJANG) AS UPJANGNM \n");
			sbSql.append("     , (SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANGNM \n");
			sbSql.append("     , A.PAY_METHOD \n");
			sbSql.append("     , A.CARD_COMP \n");
			sbSql.append("     , A.CARD_NUM \n");
			sbSql.append("     , A.INST_PERIOD \n");
			sbSql.append("     , A.TAX_CODE \n");
			sbSql.append("     , DECODE(A.TAX_CODE, NULL, '', DECODE(A.TAX_CODE, '과세', '1', '면세', '2')) AS TAX_CODE_GBN \n");
			sbSql.append("     , A.BILL_NO \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT \n");
			sbSql.append("     , A.DC_AMOUNT \n");
			sbSql.append("     , A.TOT_AMOUNT \n");
			sbSql.append("     , A.LINE_STATUS \n");
			sbSql.append("     , A.PAY_TIME \n");
			sbSql.append("     , A.CARD_MM \n");
			sbSql.append("     , A.CARD_YY \n");
			sbSql.append("     , A.CARD_CLASS \n");
			sbSql.append("     , DECODE(A.CARD_CLASS, NULL, '', DECODE(A.CARD_CLASS, '신용', '1', '체크', '2')) AS CARD_CLASS_GBN \n");
			sbSql.append("     , A.APPRV_NUM \n");
			sbSql.append("     , A.FRNC_STOR_NUM \n");
			sbSql.append("     , A.CARD_MM || A.CARD_YY AS CARD_YYMM \n");
			sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' AS SEASON_NUM \n");
			sbSql.append("  FROM ( \n");
			sbSql.append("        SELECT V.SP_DATE \n");
			sbSql.append("             , MAX(V.SP_DATE2) AS SP_DATE2 \n");
			sbSql.append("             , V.PR_SABUN \n");
			sbSql.append("             , V.RQ_SABUN \n");
			sbSql.append("             , V.PAY_METHOD \n");
			sbSql.append("             , V.CARD_COMP \n");
			sbSql.append("             , V.CARD_NUM \n");
			sbSql.append("             , V.INST_PERIOD \n");
			sbSql.append("             , V.TAX_CODE \n");
			sbSql.append("             , V.BILL_NO \n");
			sbSql.append("             , NVL(SUM(V.PR_QTY), 0) AS PR_QTY \n");
			sbSql.append("             , NVL(SUM(V.SALE_AMOUNT), 0) AS SALE_AMOUNT \n");
			sbSql.append("             , NVL(SUM(V.DC_AMOUNT), 0) AS DC_AMOUNT \n");
			sbSql.append("             , NVL(SUM(V.TOT_AMOUNT), 0) AS TOT_AMOUNT \n");
			if( nullToBlank(ds_cond.getString(0, "STATUS")).equals("'주문'") )
			{
			    sbSql.append("             , V.LINE_STATUS \n");
			    sbSql.append("             , '' AS PAY_TIME \n");
			}
			// 취소의 경우(정산, 배달완료분) GROUP BY에서 STATUS 제외
			else {

			    sbSql.append("             , '' AS LINE_STATUS \n");
			    sbSql.append("             , V.PAY_TIME \n");
			}
			sbSql.append("             , V.CARD_MM \n");
			sbSql.append("             , V.CARD_YY \n");
			sbSql.append("             , V.CARD_CLASS \n");
			sbSql.append("             , V.APPRV_NUM \n");
			sbSql.append("             , V.FRNC_STOR_NUM \n");
			sbSql.append("             , V.UPJANG \n");
			sbSql.append("          FROM ( \n");
			sbSql.append("                SELECT A.SP_DATE \n");
			sbSql.append("                     , CONCAT(A.SP_DATE, TO_CHAR(A.CREATE_DATE,'HH24MISS')) AS SP_DATE2 \n");
			sbSql.append("                     , A.PR_SABUN \n");
			sbSql.append("                     , A.RQ_SABUN \n");
			sbSql.append("                     , A.PAY_METHOD \n");
			sbSql.append("                     , A.CARD_COMP \n");
			sbSql.append("                     , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC ,'2') AS CARD_NUM \n");
			sbSql.append("                     , A.INST_PERIOD \n");
			sbSql.append("                     , DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("                     , A.BILL_NO \n");
			sbSql.append("                     , A.PR_QTY AS PR_QTY \n");
			sbSql.append("                     , A.SALE_AMOUNT AS SALE_AMOUNT \n");
			sbSql.append("                     , (A.DC_AMOUNT + A.ADM_DC_AMOUNT) AS DC_AMOUNT \n");
			sbSql.append("                     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS TOT_AMOUNT \n");
			sbSql.append("                     , A.LINE_STATUS AS LINE_STATUS \n");
			sbSql.append("                     , A.VALID_THRU_MM AS CARD_MM  \n");
			sbSql.append("                     , A.VALID_THRU_YY AS CARD_YY  \n");
			sbSql.append("                     , A.UPJANG \n");
			sbSql.append("                     , A.CARD_CLASS \n");
			sbSql.append("                     , A.APPRV_NUM \n");
			sbSql.append("                     , A.FRNC_STOR_NUM \n");
			sbSql.append("                     , A.VALID_THRU_MM \n");
			sbSql.append("                     , A.VALID_THRU_YY \n");
			sbSql.append("                     , TO_CHAR(A.PAY_TIME, 'YYYYMMDD') AS PAY_TIME \n");
			sbSql.append("                  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("                     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("                     , HLDC_PO_ITEM_MST C \n");
			sbSql.append("                 WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("                   AND A.ITEM_CODE   = C.ITEM_CODE \n");
			sbSql.append("                   AND A.SEASON_NUM  = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("                   AND B.SEASON_NUM  = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("                   AND A.SP_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "START_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "END_DATE")) + "' \n");
			sbSql.append("                   AND A.LINE_STATUS IN (" + nullToBlank(ds_cond.getString(0, "STATUS")) + ") \n");
			if( !nullToBlank(ds_cond.getString(0, "BILL_NO")).equals("") )
			{
			    sbSql.append("                   AND A.BILL_NO LIKE '%" + nullToBlank(ds_cond.getString(0, "BILL_NO")) + "%' \n");
			}
			sbSql.append("                   AND A.BU_CD = '2000' \n");
			sbSql.append("               ) V \n");
			if( nullToBlank(ds_cond.getString(0, "STATUS")).equals("'주문'") )
			{
			    sbSql.append("         GROUP BY V.SP_DATE, V.PR_SABUN, V.RQ_SABUN, V.PAY_METHOD, V.CARD_CLASS, V.CARD_COMP, V.CARD_NUM, V.INST_PERIOD, V.TAX_CODE, V.BILL_NO, V.APPRV_NUM, V.FRNC_STOR_NUM, V.LINE_STATUS, V.CARD_MM, V.CARD_YY, V.UPJANG \n");
			}
			//취소의 경우(정산, 배달완료분) GROUP BY에서 STATUS 제외
			else
			{
			    sbSql.append("         GROUP BY V.SP_DATE, V.PR_SABUN, V.RQ_SABUN, V.PAY_METHOD, V.CARD_CLASS, V.CARD_COMP, V.CARD_NUM, V.INST_PERIOD, V.TAX_CODE, V.BILL_NO, V.APPRV_NUM, V.FRNC_STOR_NUM, V.CARD_MM, V.CARD_YY, V.UPJANG, V.PAY_TIME \n");
			}
			sbSql.append("       ) A \n");
			if( nullToBlank(ds_cond.getString(0, "SP_CHK")).equals("Y") )
			{
				sbSql.append("     , HLDC_HR_PERSONAL B \n");
				sbSql.append("     , HLDC_SC_DEPT_V C \n");
				sbSql.append("     , FSP_PO_SPECIAL_UPJANG D \n");
				sbSql.append(" WHERE A.RQ_SABUN = B.SABUN \n");
				sbSql.append("   AND B.DEPT_ID = C.DEPT_ID \n");
				sbSql.append("   AND B.CC_CD = D.OCCUR_CC_CD \n");
				sbSql.append("   AND B.GB_JAEJIK <> 'RA' \n");
				sbSql.append("   AND D.SEASON_NUM = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
			}
			else
			{
				sbSql.append("     , HLDC_HR_PERSONAL B \n");
				sbSql.append("     , HLDC_SC_DEPT_V C \n");
				//sbSql.append("     , ST_UPJANG D \n");
				sbSql.append(" WHERE A.RQ_SABUN = B.SABUN \n");
				sbSql.append("   AND B.DEPT_ID = C.DEPT_ID \n");
				//sbSql.append("   AND B.CC_CD = D.CC_CD \n");
				sbSql.append("   AND B.GB_JAEJIK <> 'RA' \n");
				if( !nullToBlank(ds_cond.getString(0, "MU")).equals("") )
					sbSql.append("   AND C.MU_CD = '" + nullToBlank(ds_cond.getString(0, "MU")) + "' \n");
				if( !nullToBlank(ds_cond.getString(0, "TM")).equals("") )
					sbSql.append("   AND C.TM_CD = '" + nullToBlank(ds_cond.getString(0, "TM")) + "' \n");
				if( !nullToBlank(ds_cond.getString(0, "UPJANG")).equals("") )
					//sbSql.append("   AND D.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
					sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			}
			if( nullToBlank(ds_cond.getString(0, "STATUS")).equals("'주문'") )
			{
			    sbSql.append(" ORDER BY A.SP_DATE, A.PR_SABUN, A.RQ_SABUN, A.PAY_METHOD, A.CARD_CLASS, A.CARD_COMP, A.CARD_NUM, A.INST_PERIOD, A.TAX_CODE, A.BILL_NO, A.APPRV_NUM, A.FRNC_STOR_NUM, A.LINE_STATUS, A.CARD_MM, A.CARD_YY, A.UPJANG \n");
			}
			//취소의 경우(정산, 배달완료분) GROUP BY에서 STATUS 제외
			else
			{
			    sbSql.append(" ORDER BY A.SP_DATE, A.PR_SABUN, A.RQ_SABUN, A.PAY_METHOD, A.CARD_CLASS, A.CARD_COMP, A.CARD_NUM, A.INST_PERIOD, A.TAX_CODE, A.BILL_NO, A.APPRV_NUM, A.FRNC_STOR_NUM, A.CARD_MM, A.CARD_YY, A.UPJANG, A.PAY_TIME \n");
			}
			
		}
		else if( sType.equals("QryItm") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 주문내역 상세조회 */ \n");
			sbSql.append("SELECT A.SP_ID \n");
			sbSql.append("     , A.SEASON_NUM \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , C.ITEM_NAME \n");
			sbSql.append("     , C.ITEM_SIZE \n");
			sbSql.append("     , DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , DECODE(C.TAX_CODE, NULL, '', DECODE(C.TAX_CODE, '100', '1', '210', '2')) AS TAX_CODE_GBN \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT \n");
			sbSql.append("     , (A.DC_AMOUNT + A.ADM_DC_AMOUNT) AS TOT_DC_AMOUNT \n");
			sbSql.append("     , A.DC_AMOUNT \n");
			sbSql.append("     , A.ADM_DC_AMOUNT \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS TOT_AMOUNT \n");
			sbSql.append("     , A.SALE_TYPE \n");
			sbSql.append("     , C.IMG_PATH AS IMAGE_PATH \n");
			sbSql.append("     , A.CONTENT \n");
			sbSql.append("     , CASE WHEN LENGTH(TRIM(F.DELI_TYPE) || TRIM(F.DELI_COMP) || TRIM(F.INVOICE_NUM)) > 0 AND A.LINE_STATUS = '정산' \n");
			sbSql.append("            THEN '배송' \n");
			sbSql.append("            ELSE A.LINE_STATUS \n");
			sbSql.append("        END AS LINE_STATUS \n");
			sbSql.append("     , A.PR_SABUN \n");
			sbSql.append("     , A.RQ_SABUN \n");
			sbSql.append("     , (SELECT V1.NM_KOR||' ('||V2.MU_NM||' '||V2.CC_NM||')' AS NM_KOR \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL V1 \n");
			sbSql.append("		       , HLDC_SC_DEPT_V V2 \n");
			sbSql.append("         WHERE V1.DEPT_ID = V2.DEPT_ID \n");
			sbSql.append("		     AND V1.SABUN = A.RQ_SABUN) AS RQ_SABUNNM \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RQ_TEL_ENC, '4') AS RQ_TEL \n");
			sbSql.append("     , A.SEND_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.SEND_TEL_ENC, '4') AS SEND_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.SEND_ADDR_ENC, '6') AS SEND_ADDR \n");
			sbSql.append("     , A.RECE_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_TEL_ENC, '4') AS RECE_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_HP_ENC, '4') AS RECE_HP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_ADDR_ENC, '6') AS RECE_ADDR \n");
			sbSql.append("     , A.AR_CUSTCD \n");
			sbSql.append("     , (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = A.AR_CUSTCD) AS AR_CUSTNM \n");
			sbSql.append("     , A.AR_SAUPNO \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_ADDR_ENC, '6') AS AR_ADDR \n");
			sbSql.append("     , A.AR_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC',A.AR_TEL_ENC, '4') AS AR_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_EMAIL_ENC, '5') AS AR_EMAIL \n");
			sbSql.append("     , DECODE(TRIM(REPLACE(A.AR_SAUPNO, '-', '')), NULL, '', (SELECT MAX(VD_NM) FROM VO_FC_VENDOR WHERE BIZ_REG_NO = TRIM(REPLACE(A.AR_SAUPNO, '-', '')))) AS AR_SAUPNONM \n");
			sbSql.append("     , A.PAY_METHOD \n");
			sbSql.append("     , A.INST_PERIOD \n");
			sbSql.append("     , A.CARD_CLASS \n");
			sbSql.append("     , DECODE(A.CARD_CLASS, NULL, '', DECODE(A.CARD_CLASS, '신용', '1', '체크', '2')) AS CARD_CLASS_GBN \n");
			sbSql.append("     , A.CARD_COMP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC, '2') AS CARD_NUM \n");
			sbSql.append("     , A.VALID_THRU_MM \n");
			sbSql.append("     , A.VALID_THRU_YY \n");
			sbSql.append("     , A.VALID_THRU_YY || A.VALID_THRU_MM AS CARD_YYMM \n");
			sbSql.append("     , F.DELI_TYPE \n");
			sbSql.append("     , F.DELI_COMP \n");
			sbSql.append("     , F.INVOICE_NUM \n");
			sbSql.append("     , A.BILL_NO \n");
			sbSql.append("     , C.MAX_ORD_QTY \n");
			sbSql.append("     , (B.STOCK_QTY - NVL( (SELECT SUM(Z.PR_QTY) \n");
			sbSql.append("                              FROM FSP_PO_SPECIAL_SALE Z \n");
			sbSql.append("                              WHERE Z.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                                AND Z.SEASON_NUM = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("                                AND Z.LINE_STATUS <> '취소' \n");
			sbSql.append("                                AND Z.SP_TYPE = 'ING'), 0) ) AS STOCK_QTY \n");
			sbSql.append("     , B.DELI_FREE_AMT \n");
			sbSql.append("     , B.QTY_DC_STD \n");
			sbSql.append("     , B.QTY_DC_RATE \n");
			sbSql.append("     , B.AMT_DC_STD \n");
			sbSql.append("     , B.AMT_DC_RATE \n");
			sbSql.append("     , 'N' AS EDIT_YN \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , (SELECT DECODE(Z.UPJANGNM, '', '', Z.UPJANGNM || '(' || A.UPJANG || ')') \n");
			sbSql.append("          FROM SCO_UPJANG_MST_V Z \n");
			sbSql.append("         WHERE A.UPJANG = Z.UPJANG) AS UPJANGNM \n");
			sbSql.append("     , TO_CHAR(A.PAY_TIME, 'YYYYMMDD') AS PAY_TIME \n");
			sbSql.append("     , A.RECEIPT_NUM \n");
			sbSql.append("     , A.FRNC_STOR_NUM \n");
			sbSql.append("     , A.DELI_EXPT_DATE \n");
			sbSql.append("     , C.IMG_YN \n");
			sbSql.append("     , A.APPRV_NUM \n");
			sbSql.append("     , A.PR_QTY AS ORG_PR_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT AS ORG_SALE_AMOUNT \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS ORG_TOT_AMOUNT \n");
			sbSql.append("     , A.SALE_TYPE AS ORG_SALE_TYPE \n");
			sbSql.append("     , A.PAY_METHOD AS ORG_PAY_METHOD \n");
			sbSql.append("     , A.CARD_COMP AS ORG_CARD_COMP \n");
			sbSql.append("     , A.INST_PERIOD AS ORG_INST_PERIOD \n");
			sbSql.append("     , A.CARD_CLASS AS ORG_CARD_CLASS \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC, '2') AS ORG_CARD_NUM \n");
			sbSql.append("     , A.VALID_THRU_MM AS ORG_VALID_THRU_MM \n");
			sbSql.append("     , A.VALID_THRU_YY AS ORG_VALID_THRU_YY \n");
			sbSql.append("     , A.VALID_THRU_YY || A.VALID_THRU_MM AS ORG_CARD_YYMM \n");
			sbSql.append("     , A.APPRV_NUM AS ORG_APPRV_NUM \n");
			sbSql.append("     , A.FRNC_STOR_NUM AS ORG_FRNC_STOR_NUM \n");
			sbSql.append("     , A.AR_CUSTCD AS ORG_AR_CUSTCD \n");
			sbSql.append("     , NVL(A.IF_FLAG, 'N') AS IF_FLAG \n");
			sbSql.append("     , A.CALL_YN AS CALL_YN \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append("     , IF_FS_SP_SALE_DAILY F \n");
			sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE \n");
			sbSql.append("   AND A.SP_ID       = F.SP_ID(+) \n");
	        sbSql.append("   AND A.SEASON_NUM  = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
	        sbSql.append("   AND B.SEASON_NUM  = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("   AND A.SP_DATE     = '" + nullToBlank(ds_cond.getString(0, "START_DATE")) + "' \n");
			sbSql.append("   AND A.PR_SABUN    = '" + nullToBlank(ds_cond.getString(0, "PR_SABUN")) + "' \n");
			sbSql.append("   AND A.RQ_SABUN    = '" + nullToBlank(ds_cond.getString(0, "RQ_SABUN")) + "' \n");
			sbSql.append("   AND A.PAY_METHOD  = '" + nullToBlank(ds_cond.getString(0, "PAY_METHOD")) + "' \n");
			sbSql.append("   AND DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') = '" + nullToBlank(ds_cond.getString(0, "TAX_CODE")) + "' \n");
			if( !nullToBlank(ds_cond.getString(0, "CARD_COMP")).equals("") )
			{
				sbSql.append("   AND A.CARD_COMP   = '" + nullToBlank(ds_cond.getString(0, "CARD_COMP")) + "' \n");
			}
			if( !nullToBlank(ds_cond.getString(0, "CARD_CLASS")).equals("") )
			{
				sbSql.append("   AND A.CARD_CLASS   = '" + nullToBlank(ds_cond.getString(0, "CARD_CLASS")) + "' \n");
			}
			if( !nullToBlank(ds_cond.getString(0, "CARD_NUM")).equals("") )
			{
				sbSql.append("   AND SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC,'2') = '" + nullToBlank(ds_cond.getString(0, "CARD_NUM")) + "' \n");
			}
			if( !nullToBlank(ds_cond.getString(0, "INST_PERIOD")).equals("") )
			{
				sbSql.append("   AND A.INST_PERIOD = '" + nullToBlank(ds_cond.getString(0, "INST_PERIOD")) + "' \n");
			}
	        if( !nullToBlank(ds_cond.getString(0, "STATUS")).equals("'주문'") &&  !nullToBlank(ds_cond.getString(0, "BILL_NO")).equals("") )
	        {
				sbSql.append("   AND A.BILL_NO        = '" + nullToBlank(ds_cond.getString(0, "BILL_NO")) + "' \n");
	        }
			sbSql.append("   AND A.LINE_STATUS IN (" + nullToBlank(ds_cond.getString(0, "STATUS")) + ") \n");
			sbSql.append("   AND A.BU_CD       = '2000' \n");
			sbSql.append(" ORDER BY A.SP_ID \n");
    	}
		else if( sType.equals("QryItm2") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 결제자 구매정보 */ \n");
			sbSql.append("SELECT A.AR_SAUPNO \n");
			sbSql.append("     , (SELECT MAX(VD_NM) \n");
			sbSql.append("          FROM VO_FC_VENDOR \n");
			sbSql.append("         WHERE BIZ_REG_NO = TRIM(REPLACE(A.AR_SAUPNO, '-', ''))) AS AR_SAUPNONM \n");
			sbSql.append("     , A.AR_NAME \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , (SELECT Z.ITEM_NAME \n");
			sbSql.append("          FROM HLDC_PO_ITEM_MST Z \n");
			sbSql.append("         WHERE Z.ITEM_CODE = A.ITEM_CODE) AS ITEM_NAME \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT - A.DC_AMOUNT) AS TOT_AMOUNT \n");
			sbSql.append("     , (SELECT IMG_YN FROM HLDC_PO_ITEM_MST B WHERE B.ITEM_CODE = A.ITEM_CODE) AS IMG_YN  \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append(" WHERE 1 = 1 \n");
			sbSql.append("   AND A.SP_DATE     = '" + nullToBlank(ds_cond.getString(0, "START_DATE")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '취소' \n");
	        sbSql.append("   AND A.SEASON_NUM  = '" + nullToBlank(ds_cond.getString(0, "SEASON_NUM")) + "' \n");
	        sbSql.append("   AND A.PR_SABUN    = '" + nullToBlank(ds_cond.getString(0, "PR_SABUN")) + "' \n");
	        sbSql.append("   AND A.RQ_SABUN    = '" + nullToBlank(ds_cond.getString(0, "RQ_SABUN")) + "' \n");
	        sbSql.append("   AND A.PAY_METHOD  = '" + nullToBlank(ds_cond.getString(0, "PAY_METHOD")) + "' \n");
			if( !nullToBlank(ds_cond.getString(0, "CARD_COMP")).equals("") )
			{
				sbSql.append("   AND A.CARD_COMP = '" + nullToBlank(ds_cond.getString(0, "CARD_COMP")) + "' \n");
			}
			if( !nullToBlank(ds_cond.getString(0, "CARD_CLASS")).equals("") )
			{
				sbSql.append("   AND A.CARD_CLASS = '" + nullToBlank(ds_cond.getString(0, "CARD_CLASS")) + "' \n");
			}
			if( !nullToBlank(ds_cond.getString(0, "CARD_NUM")).equals("") )
			{
				sbSql.append("   AND SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC, '2') = '" + nullToBlank(ds_cond.getString(0, "CARD_NUM")) + "' \n");
			}
			if( !nullToBlank(ds_cond.getString(0, "INST_PERIOD")).equals("") )
			{
				sbSql.append("   AND A.INST_PERIOD = '" + nullToBlank(ds_cond.getString(0, "INST_PERIOD")) + "' \n");
			}
	        if( !nullToBlank(ds_cond.getString(0, "STATUS")).equals("'주문'") && !nullToBlank(ds_cond.getString(0, "BILL_NO")).equals("") )
	        {
				sbSql.append("   AND A.BILL_NO = '" + nullToBlank(ds_cond.getString(0, "BILL_NO")) + "' \n");
	        }
			sbSql.append("   AND A.LINE_STATUS IN (" + nullToBlank(ds_cond.getString(0, "STATUS")) + ") \n");
			sbSql.append("   AND EXISTS (SELECT 'X' \n");
			sbSql.append("                 FROM HLDC_PO_ITEM_MST Z \n");
			sbSql.append("                WHERE A.ITEM_CODE = Z.ITEM_CODE \n");
			sbSql.append("                  AND DECODE(Z.TAX_CODE, '100', '과세', '210', '면세', '영세') = '" + nullToBlank(ds_cond.getString(0, "TAX_CODE")) + "') \n");
			sbSql.append("   AND A.BU_CD       = '2000' \n");
			sbSql.append(" GROUP BY A.AR_SAUPNO, A.AR_NAME, A.ITEM_CODE \n");
			sbSql.append(" ORDER BY NVL(A.AR_SAUPNO, ' ') DESC, NVL(A.AR_NAME, ' ') DESC, A.ITEM_CODE \n");
		}
		else if( sType.equals("OrdLst") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 주문변경 - 주문내역 조회 */ \n");
			sbSql.append("SELECT A.SP_ID \n");
			sbSql.append("     , A.SEASON_NUM \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , C.ITEM_NAME \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT \n");
			sbSql.append("     , A.DC_AMOUNT \n");
			sbSql.append("     , A.ADM_DC_AMOUNT \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS TOT_AMOUNT \n");
			sbSql.append("     , A.SALE_TYPE \n");
			sbSql.append("     , A.LINE_STATUS \n");
			sbSql.append("     , A.PAY_METHOD \n");
			sbSql.append("     , A.INST_PERIOD \n");
			sbSql.append("     , A.CARD_CLASS \n");
			sbSql.append("     , A.CARD_COMP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC, '2') CARD_NUM \n");
			sbSql.append("     , A.VALID_THRU_MM \n");
			sbSql.append("     , A.VALID_THRU_YY \n");
			sbSql.append("     , (B.STOCK_QTY - NVL( (SELECT SUM(Z.PR_QTY) \n");
			sbSql.append("                              FROM FSP_PO_SPECIAL_SALE Z \n");
			sbSql.append("                             WHERE Z.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                               AND Z.SEASON_NUM = '" + sSeasonNum + "' \n");
			sbSql.append("                               AND Z.LINE_STATUS <> '취소' \n");
			sbSql.append("                               AND Z.SP_TYPE = 'ING'), 0) ) AS STOCK_QTY \n");
			sbSql.append("     , B.QTY_DC_STD AS QTY_DC_STD \n");
			sbSql.append("     , B.QTY_DC_RATE AS QTY_DC_RATE \n");
			sbSql.append("     , B.AMT_DC_STD AS AMT_DC_STD \n");
			sbSql.append("     , B.AMT_DC_RATE AS AMT_DC_RATE \n");
			sbSql.append("     , A.AR_CUSTCD \n");
			sbSql.append("     , (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = A.AR_CUSTCD) AS AR_CUSTNM \n");
			sbSql.append("     , A.AR_SAUPNO \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_ADDR_ENC, '6') AS AR_ADDR \n");
			sbSql.append("     , A.AR_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC',A.AR_TEL_ENC, '4') AS AR_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_EMAIL_ENC, '5') AS AR_EMAIL \n");
			sbSql.append("     , A.APPRV_NUM \n");
			sbSql.append("     , A.FRNC_STOR_NUM \n");
			sbSql.append("     , A.RECE_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_TEL_ENC, '4') AS RECE_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_HP_ENC, '4') AS RECE_HP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_ADDR_ENC, '6') AS RECE_ADDR \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append(" WHERE A.ITEM_CODE  = B.ITEM_CODE \n");
			sbSql.append("   AND A.SEASON_NUM = B.SEASON_NUM \n");
			sbSql.append("   AND A.ITEM_CODE  = C.ITEM_CODE \n");
	        sbSql.append("   AND A.SP_ID      = '" + sSpId + "' \n");
	        sbSql.append("   AND A.BU_CD      = '2000' \n");
		}
		else if( sType.equals("QryCard") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 카드 가맹점 조회 */ \n");
			sbSql.append("SELECT A.FRNC_STOR_NUM AS FRNC_STOR_NUM \n");
			sbSql.append("     , A.UPJANG_CD AS UPJANG_CD \n");
			sbSql.append("     , C.UPJANGNM AS UPJANG_NM \n");
			sbSql.append("     , A.CARD_CLASS AS CARD_CLASS \n");
			sbSql.append("     , A.CMIS_RATE AS CMIS_RATE \n");
			sbSql.append("     , A.RECEIVE_CYCLE AS RECEIVE_CYCLE \n");
			sbSql.append("     , A.BUYCPNY_CD AS BUYCPNY_CD \n");
			sbSql.append("     , B.BUYCPNY_NM AS BUYCPNY_NM \n");
			sbSql.append("     , A.RECD_STATUS AS RECD_STATUS \n");
			sbSql.append("     , A.CUSER AS CUSER \n");
			sbSql.append("     , A.CDATE AS CDATE \n");
			sbSql.append("     , A.UUSER AS UUSER \n");
			sbSql.append("     , A.UDATE AS UDATE \n");
			sbSql.append("  FROM SLA_FRNC_STOR_MGMT A \n");
			sbSql.append("	   , SLA_BUY_CPNY_MGMT B \n");
			sbSql.append("	   , ST_UPJANG C \n");
			sbSql.append(" WHERE A.BUYCPNY_CD = B.BUYCPNY_CD(+) \n");
			sbSql.append("   AND A.UPJANG_CD = C.UPJANG(+) \n");
			sbSql.append("   AND A.UPJANG_CD = '" + sUpjang + "' \n");
			sbSql.append(" ORDER BY A.FRNC_STOR_NUM ASC \n");
		}
		else if( sType.equals("spUpjang") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉 귀속부서 여부 조회 */ \n");
			sbSql.append("SELECT CASE WHEN COUNT(*) > 0 THEN 'Y' ELSE 'N' END AS SP_UPJANG \n");
			sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
			sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
			sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
			sbSql.append("   AND A.GB_JAEJIK <> 'RA' \n");
			sbSql.append("   AND A.SABUN = '" + g_EmpNo + "' \n");
			sbSql.append("   AND B.SEASON_NUM = '" + sSeasonNum + "' \n");
		}
		else if( sType.equals("spUpjangAdm") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉 귀속부서 여부 조회 - 관리자 */ \n");
			sbSql.append("SELECT CASE WHEN COUNT(*) > 0 THEN 'Y' ELSE 'N' END AS SP_UPJANG \n");
			sbSql.append("  FROM ST_UPJANG A \n");
			sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
			sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
			sbSql.append("   AND A.UPJANG = '" + sChgUpjang + "' \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_list = this.makeDataSet(rs, "ds_list");

		out_dl.add(ds_list);
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