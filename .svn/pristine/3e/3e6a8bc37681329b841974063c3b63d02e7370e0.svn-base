<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS구매관리/특판상품마감
■ 프로그램ID   : FSP00016E_T001.jsp
■ 프로그램명   : 특판상품조회
■ 작성일자     : 2010.06.14
■ 작성자       : 박은규
■ 이력관리     : 2010.06.14
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Deptid     = nullToBlank(in_vl.getString("g_Deptid"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//1)주문내역조회
		if (sType.equals("QryItm"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("\n");
			sbSql.append("SELECT A.SP_ID AS SP_ID \n");
			sbSql.append("     , A.SP_DATE AS SP_DATE \n");
			sbSql.append("     , TO_CHAR(PAY_TIME, 'YYYYMMDD') AS PAY_TIME \n");
			sbSql.append("     , TO_CHAR(CANCEL_TIME, 'YYYYMMDD') AS CANCEL_TIME \n");
			sbSql.append("     , (SELECT NM_KOR \n");
			sbSql.append("         FROM HLDC_HR_PERSONAL \n");
			sbSql.append("        WHERE SABUN = A.PAY_SABUN) AS PAY_SABUN_NM \n");
			sbSql.append("     , (SELECT NM_KOR \n");
			sbSql.append("         FROM HLDC_HR_PERSONAL \n");
			sbSql.append("        WHERE SABUN = A.CANCEL_SABUN) AS CANCEL_SABUN_NM \n");
			sbSql.append("     , E.NM_KOR AS PR_SABUN_NM \n");
			sbSql.append("     , E.MU_NM AS PR_SAUBN_MU_NM \n");
			sbSql.append("     , E.TM_NM AS PR_SABUN_TM_NM \n");
			sbSql.append("     , E.CC_NM AS PR_SABUN_CC_NM \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , C.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , C.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , A.SALE_PRICE AS SALE_PRICE \n");
			sbSql.append("     , A.PR_QTY AS PR_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT AS SALE_AMOUNT \n");
			sbSql.append("     , A.DC_AMOUNT AS DC_AMOUNT \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT AS TOT_AMOUNT\n");
			sbSql.append("     , A.SALE_TYPE AS SALE_TYPE \n");
			sbSql.append("     , C.IMG_PATH AS IMAGE_PATH \n");
			sbSql.append("     , A.CONTENT AS CONTENT \n");
			sbSql.append("     , CASE WHEN LENGTH(TRIM(I.DELI_TYPE) || TRIM(I.DELI_COMP) || TRIM(I.INVOICE_NUM)) > 0 AND A.LINE_STATUS = '정산' \n");
			sbSql.append("            THEN '배송' \n");
			sbSql.append("            ELSE A.LINE_STATUS \n");
			sbSql.append("        END AS LINE_STATUS \n");
			sbSql.append("     , A.PR_SABUN AS PR_SABUN \n");
			sbSql.append("     , A.RQ_SABUN AS RQ_SABUN \n");
			sbSql.append("     , (SELECT V1.NM_KOR||' ('||V2.MU_NM||' '||V2.CC_NM||')' AS NM_KOR \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL V1 \n");
			sbSql.append("     	       , HLDC_SC_DEPT_V V2 \n");
			sbSql.append("     	   WHERE V1.DEPT_ID = V2.DEPT_ID \n");
			sbSql.append("     	     AND V1.SABUN = A.RQ_SABUN) AS RQ_SABUNNM \n");
			sbSql.append("     , (SELECT V2.TM_NM AS NM_KOR \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL V1 \n");
			sbSql.append("             , HLDC_SC_DEPT_V V2 \n");
			sbSql.append("         WHERE V1.DEPT_ID = V2.DEPT_ID \n");
			sbSql.append("           AND V1.SABUN = A.RQ_SABUN) AS RQ_SABUN_TEAMNM \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RQ_TEL_ENC, '4') RQ_TEL \n");
			sbSql.append("     , A.SEND_NAME AS SEND_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.SEND_TEL_ENC, '4') AS SEND_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.SEND_ADDR_ENC, '6') AS SEND_ADDR \n");
			sbSql.append("     , A.RECE_NAME AS RECE_NAME\n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_TEL_ENC, '4') AS RECE_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_HP_ENC, '4') AS RECE_HP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_ADDR_ENC, '6') AS RECE_ADDR \n");
			sbSql.append("     , A.AR_SAUPNO AS AR_SAUPNO \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_ADDR_ENC, '6') AS AR_ADDR \n");
			sbSql.append("     , A.AR_NAME AS AR_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_TEL_ENC, '4') AS AR_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_EMAIL_ENC, '5') AS AR_EMAIL \n");
			sbSql.append("     , DECODE( TRIM(REPLACE(A.AR_SAUPNO, '-', '')), NULL, '', (SELECT MAX(VD_NM) FROM VO_FC_VENDOR WHERE BIZ_REG_NO = TRIM(REPLACE(A.AR_SAUPNO, '-', '')))) AR_SAUPNONM \n");
			sbSql.append("     , A.PAY_METHOD AS PAY_METHOD \n");
			sbSql.append("     , A.INST_PERIOD AS INST_PERIOD \n");
			sbSql.append("     , A.CARD_COMP AS CARD_COMP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC, '2') AS CARD_NUM \n");
			sbSql.append("     , A.VALID_THRU_MM AS VALID_THRU_MM \n");
			sbSql.append("     , A.VALID_THRU_YY AS VALID_THRU_YY \n");
			sbSql.append("     , I.DELI_TYPE AS DELI_TYPE \n");
			sbSql.append("     , I.DELI_COMP AS DELI_COMP \n");
			sbSql.append("     , I.INVOICE_NUM AS INVOICE_NUM \n");
			sbSql.append("     , A.BILL_NO AS BILL_NO \n");
			sbSql.append("     , C.MAX_ORD_QTY AS MAX_ORD_QTY \n");
			sbSql.append("     , (B.STOCK_QTY - NVL((SELECT SUM(Z.PR_QTY) \n");
			sbSql.append("                             FROM FSP_PO_SPECIAL_SALE Z \n");
			sbSql.append("                            WHERE Z.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                              AND Z.SEASON_NUM = '" + nullToBlank(ds_Cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("                              AND Z.SP_TYPE = 'ING' \n");
			sbSql.append("                              AND Z.LINE_STATUS <> '취소'), 0)) AS STOCK_QTY \n");
			sbSql.append("     , B.QTY_DC_STD AS QTY_DC_STD \n");
			sbSql.append("     , B.QTY_DC_RATE AS QTY_DC_RATE \n");
			sbSql.append("     , B.AMT_DC_STD AS AMT_DC_STD \n");
			sbSql.append("     , B.AMT_DC_RATE AS AMT_DC_RATE \n");
			sbSql.append("     , (SELECT Z.UPJANGNM || '(' || Z.UPJANG || ')' FROM ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANG \n");
			sbSql.append("     , A.REMARK AS REMARK \n");
			sbSql.append("     , A.AR_CUSTCD \n");
			sbSql.append("     , (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = A.AR_CUSTCD) AS AR_CUSTNM \n");
			sbSql.append("     , A.DELI_EXPT_DATE \n");
			sbSql.append("     , C.IMG_YN AS IMG_YN \n");
			sbSql.append("     , A.CALL_YN AS CALL_YN \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append("     , IF_FS_SP_SALE_DAILY I \n");
			sbSql.append("     ,( \n");
			sbSql.append("       SELECT A.SABUN \n");
			sbSql.append("            , A.NM_KOR \n");
			sbSql.append("            , B.MU_CD \n");
			sbSql.append("            , B.MU_NM \n");
			sbSql.append("            , B.CC_CD \n");
			sbSql.append("            , B.CC_NM \n");
			sbSql.append("            , B.TM_CD \n");
			sbSql.append("            , B.TM_NM \n");
			sbSql.append("         FROM HLDC_HR_PERSONAL A \n");
			sbSql.append("            , HLDC_SC_DEPT_V B \n");
			sbSql.append("        WHERE A.CC_CD = B.CC_CD \n");
			sbSql.append("       ) E \n");
			sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE \n");
			sbSql.append("   AND PR_SABUN      = E.SABUN \n");
			sbSql.append("   AND A.SP_ID       = I.SP_ID(+) \n");
	        sbSql.append("   AND A.SEASON_NUM  = '" + nullToBlank(ds_Cond.getString(0, "SEASON_NUM")) + "' \n");
	        sbSql.append("   AND B.SEASON_NUM  = '" + nullToBlank(ds_Cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("   AND A.SP_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SP_DATE")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "SP_DATET")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "STATUS")).equals("") )
	        {
	        	if( nullToBlank(ds_Cond.getString(0, "STATUS")).equals("'배송'") )
	        		sbSql.append("   AND (A.LINE_STATUS = '정산' AND LENGTH(TRIM(I.DELI_TYPE) || TRIM(I.DELI_COMP) || TRIM(I.INVOICE_NUM)) > 0) \n");
	        	else
		        	sbSql.append("   AND A.LINE_STATUS IN (" + nullToBlank(ds_Cond.getString(0, "STATUS")) + ") \n");	        	
	        }


	        if( !nullToBlank(ds_Cond.getString(0, "BILL_NO")).equals("") )
	        	sbSql.append("   AND A.BILL_NO LIKE '%" + nullToBlank(ds_Cond.getString(0, "BILL_NO")) + "%' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "PR_SABUN_MU")).equals("") )
	        	sbSql.append("   AND E.MU_CD       = '" + nullToBlank(ds_Cond.getString(0, "PR_SABUN_MU")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "CUSTCD")).equals("") )
	        	sbSql.append("   AND B.CUSTCD      = " + nullToBlank(ds_Cond.getString(0, "CUSTCD")) + " \n");

	        if( !nullToBlank(ds_Cond.getString(0, "ITEM_CODE")).equals("") )
	        	sbSql.append("   AND B.ITEM_CODE   = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "PR_SABUN_CC_CD")).equals("") )
	        	sbSql.append("   AND E.CC_CD       = '" + nullToBlank(ds_Cond.getString(0, "PR_SABUN_CC_CD")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "SALE_TYPE")).equals("") )
	        	sbSql.append("   AND A.SALE_TYPE   = '" + nullToBlank(ds_Cond.getString(0, "SALE_TYPE")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "PR_SABUN")).equals("") )
	        	sbSql.append("   AND A.PR_SABUN    = '" + nullToBlank(ds_Cond.getString(0, "PR_SABUN")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "RQ_SABUN")).equals("") )
	        	sbSql.append("   AND A.RQ_SABUN    = '" + nullToBlank(ds_Cond.getString(0, "RQ_SABUN")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "SP_ID")).equals("") )
	        	sbSql.append("   AND A.SP_ID       = '" + nullToBlank(ds_Cond.getString(0, "SP_ID")) + "' \n");

	        sbSql.append("   AND A.BU_CD       = '" + nullToBlank(ds_Cond.getString(0, "BU_CD")) + "' \n");
			sbSql.append(" ORDER BY DECODE(A.LINE_STATUS, '취소', 'B', 'A'), A.SP_DATE, A.SP_ID \n");
		}
		else if (sType.equals("QryItmAuth"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("\n");
			sbSql.append("SELECT A.SP_ID AS SP_ID \n");
			sbSql.append("     , A.SP_DATE AS SP_DATE \n");
			sbSql.append("     , TO_CHAR(PAY_TIME, 'YYYYMMDD') AS PAY_TIME \n");
			sbSql.append("     , TO_CHAR(CANCEL_TIME, 'YYYYMMDD') AS CANCEL_TIME \n");
			sbSql.append("     , (SELECT NM_KOR \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL \n");
			sbSql.append("         WHERE SABUN = A.PAY_SABUN) AS PAY_SABUN_NM \n");
			sbSql.append("     , (SELECT NM_KOR \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL \n");
			sbSql.append("         WHERE SABUN = A.CANCEL_SABUN) AS CANCEL_SABUN_NM \n");
			sbSql.append("     , E.BU_CD AS PR_BU_CD \n");
			sbSql.append("     , E.BU_NM AS PR_BU_NM \n");
			sbSql.append("     , E.MU_CD AS PR_MU_CD \n");
			sbSql.append("     , E.MU_NM AS PR_MU_NM \n");
			sbSql.append("     , E.MU_NM AS PR_SAUBN_MU_NM \n");
			sbSql.append("     , E.TM_NM AS PR_SABUN_TM_NM \n");
			sbSql.append("     , E.CC_NM AS PR_SABUN_CC_NM \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , C.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , C.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , A.SALE_PRICE AS SALE_PRICE \n");
			sbSql.append("     , CASE WHEN F.CONTRACT_PRICE IS NULL THEN (B.UNIT_PRICE * A.PR_QTY) ELSE (F.CONTRACT_PRICE * A.PR_QTY) END AS UNIT_AMOUNT \n");
			sbSql.append("     , A.PR_QTY AS PR_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT AS SALE_AMOUNT \n");
			sbSql.append("     , A.DC_AMOUNT + A.ADM_DC_AMOUNT AS DC_AMOUNT \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS TOT_AMOUNT\n");
			//sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT - (DECODE(C.TAX_CODE, '100', 0.1, 0)*A.SALE_PRICE*A.PR_QTY) AS TOT_AMOUNT_NO_VAT \n");
			//sbSql.append("     , (DECODE(C.TAX_CODE, '100', 0.1, 0)*A.SALE_PRICE*A.PR_QTY) AS TOT_VAT \n");
			sbSql.append("     , CASE WHEN C.TAX_CODE = '100' THEN (A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT) - (ROUND((A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT) - (A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT)/1.1)) \n");
			sbSql.append("     		ELSE (A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT) END AS TOT_AMOUNT_NO_VAT \n");
			sbSql.append("     , CASE WHEN C.TAX_CODE = '100' THEN ROUND((A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT) - (A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT)/1.1) \n");
			sbSql.append("			ELSE 0 END AS TOT_VAT  \n");
			sbSql.append("     , A.SALE_TYPE AS SALE_TYPE\n");
			sbSql.append("     , C.IMG_PATH AS IMAGE_PATH \n");
			sbSql.append("     , C.IMG_YN AS IMG_YN \n");
			sbSql.append("     , A.CONTENT AS CONTENT \n");
			sbSql.append("     , CASE WHEN LENGTH(TRIM(I.DELI_TYPE) || TRIM(I.DELI_COMP) || TRIM(I.INVOICE_NUM)) > 0 AND A.LINE_STATUS = '정산' \n");
			sbSql.append("            THEN '배송' \n");
			sbSql.append("            ELSE A.LINE_STATUS \n");
			sbSql.append("        END AS LINE_STATUS \n");
			sbSql.append("     , A.PR_SABUN AS PR_SABUN \n");
			sbSql.append("     , A.RQ_SABUN AS RQ_SABUN \n");
			sbSql.append("     , (SELECT V1.NM_KOR||' ('||V2.MU_NM||' '||V2.CC_NM||')' AS NM_KOR \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL V1 \n");
			sbSql.append("             , HLDC_SC_DEPT_V V2 \n");
			sbSql.append("         WHERE V1.DEPT_ID = V2.DEPT_ID \n");
			sbSql.append("           AND V1.SABUN = A.RQ_SABUN) AS RQ_SABUNNM \n");
			sbSql.append("     , (SELECT V2.TM_NM AS NM_KOR \n");
			sbSql.append("          FROM HLDC_HR_PERSONAL V1 \n");
			sbSql.append("             , HLDC_SC_DEPT_V V2 \n");
			sbSql.append("         WHERE V1.DEPT_ID = V2.DEPT_ID \n");
			sbSql.append("           AND V1.SABUN = A.RQ_SABUN) AS RQ_SABUN_TEAMNM \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RQ_TEL_ENC, '4') AS RQ_TEL \n");
			sbSql.append("     , A.SEND_NAME AS SEND_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.SEND_TEL_ENC, '4') AS SEND_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.SEND_ADDR_ENC, '6') AS SEND_ADDR \n");
			sbSql.append("     , A.RECE_NAME AS RECE_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_TEL_ENC, '4') AS RECE_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_HP_ENC, '4') AS RECE_HP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RECE_ADDR_ENC, '6') AS RECE_ADDR \n");
			sbSql.append("     , A.AR_SAUPNO AS AR_SAUPNO \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_ADDR_ENC, '6') AS AR_ADDR \n");
			sbSql.append("     , A.AR_NAME AS AR_NAME \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_TEL_ENC, '4') AS AR_TEL \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.AR_EMAIL_ENC, '5') AS AR_EMAIL \n");
			sbSql.append("     , DECODE(TRIM(REPLACE(A.AR_SAUPNO, '-', '')), NULL, '', (SELECT MAX(VD_NM) FROM VO_FC_VENDOR WHERE BIZ_REG_NO = TRIM(REPLACE(A.AR_SAUPNO, '-', '')))) AR_SAUPNONM \n");
			sbSql.append("     , A.PAY_METHOD AS PAY_METHOD \n");
			sbSql.append("     , A.INST_PERIOD AS INST_PERIOD \n");
			sbSql.append("     , A.CARD_COMP AS CARD_COMP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC,'2') AS CARD_NUM \n");
			sbSql.append("     , A.VALID_THRU_MM AS VALID_THRU_MM \n");
			sbSql.append("     , A.VALID_THRU_YY AS VALID_THRU_YY \n");
			sbSql.append("     , I.DELI_TYPE AS DELI_TYPE \n");
			sbSql.append("     , I.DELI_COMP AS DELI_COMP \n");
			sbSql.append("     , I.INVOICE_NUM AS INVOICE_NUM \n");
			sbSql.append("     , A.BILL_NO AS BILL_NO \n");
			sbSql.append("     , C.MAX_ORD_QTY AS MAX_ORD_QTY \n");
			sbSql.append("     , (B.STOCK_QTY - NVL((SELECT SUM(Z.PR_QTY) \n");
			sbSql.append("                             FROM FSP_PO_SPECIAL_SALE Z \n");
			sbSql.append("                            WHERE Z.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                              AND Z.SEASON_NUM = '" + nullToBlank(ds_Cond.getString(0, "SEASON_NUM")) + "' \n");
			sbSql.append("                              AND Z.SP_TYPE = 'ING' \n");
			sbSql.append("                              AND Z.LINE_STATUS <> '취소'), 0)) AS STOCK_QTY \n");
			sbSql.append("     , B.QTY_DC_STD AS QTY_DC_STD \n");
			sbSql.append("     , B.QTY_DC_RATE AS QTY_DC_RATE \n");
			sbSql.append("     , B.AMT_DC_STD AS AMT_DC_STD \n");
			sbSql.append("     , B.AMT_DC_RATE AS AMT_DC_RATE \n");
			sbSql.append("     , (SELECT Z.UPJANGNM || '(' || Z.UPJANG || ')' FROM ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG) AS UPJANG \n");
			sbSql.append("     , A.REMARK AS REMARK \n");
			sbSql.append("     , A.AR_CUSTCD \n");
			sbSql.append("     , (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = A.AR_CUSTCD) AS AR_CUSTNM \n");
			sbSql.append("     , A.DELI_EXPT_DATE \n");
			sbSql.append("     , A.CALL_YN AS CALL_YN \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append("     , IF_FS_SP_SALE_DAILY I \n");
			sbSql.append("     ,( \n");
			sbSql.append("       SELECT A.SABUN \n");
			sbSql.append("            , A.NM_KOR \n");
			sbSql.append("            , B.MU_CD \n");
			sbSql.append("            , B.MU_NM \n");
			sbSql.append("            , B.BU_CD \n");
			sbSql.append("            , B.BU_NM \n");
			sbSql.append("            , B.CC_CD \n");
			sbSql.append("            , B.CC_NM \n");
			sbSql.append("            , B.TM_CD \n");
			sbSql.append("            , B.TM_NM \n");
			sbSql.append("         FROM HLDC_HR_PERSONAL A \n");
			sbSql.append("            , HLDC_SC_DEPT_V B \n");
			sbSql.append("        WHERE A.CC_CD = B.CC_CD \n");
			sbSql.append("       ) E \n");
			sbSql.append("     , HLDC_PO_CONTRACT_SPEC F \n");
			sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE \n");
			sbSql.append("   AND A.ITEM_CODE   = F.ITEM_CODE(+) \n");
			sbSql.append("   AND PR_SABUN      = E.SABUN \n");
			sbSql.append("   AND A.SP_ID       = I.SP_ID(+) \n");
	        sbSql.append("   AND A.SEASON_NUM  = '" + nullToBlank(ds_Cond.getString(0, "SEASON_NUM")) + "' \n");
	        sbSql.append("   AND B.SEASON_NUM  = '" + nullToBlank(ds_Cond.getString(0, "SEASON_NUM")) + "' \n");
	        
	        if( !nullToBlank(ds_Cond.getString(0, "UPJANG")).equals("") ) {
	        	sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
	        }
	        if ( nullToBlank(ds_Cond.getString(0, "DT_GNB")).equals("OP") ) {
	        	sbSql.append("   AND A.RECEIPT_DATE BETWEEN TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SP_DATE")) + "000000','YYYYMMDDHH24MISS') AND TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SP_DATET")) + "235959', 'YYYYMMDDHH24MISS') \n");
	        } else {
	        	sbSql.append("   AND A.SP_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SP_DATE")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "SP_DATET")) + "' \n");	
	        }
	        

	        if( !nullToBlank(ds_Cond.getString(0, "STATUS")).equals("") )
	        {
	        	if( nullToBlank(ds_Cond.getString(0, "STATUS")).equals("'배송'") )
	        		sbSql.append("   AND (A.LINE_STATUS = '정산' AND LENGTH(TRIM(I.DELI_TYPE) || TRIM(I.DELI_COMP) || TRIM(I.INVOICE_NUM)) > 0) \n");
	        	else
		        	sbSql.append("   AND A.LINE_STATUS IN (" + nullToBlank(ds_Cond.getString(0, "STATUS")) + ") \n");	        	
	        }

	        if ( !nullToBlank(ds_Cond.getString(0, "BILL_NO")).equals("") )
	        	sbSql.append("   AND A.BILL_NO LIKE '%" + nullToBlank(ds_Cond.getString(0, "BILL_NO")) + "%' \n");

	        if (! nullToBlank(ds_Cond.getString(0, "PR_SABUN_MU")).equals(""))
			    sbSql.append("   AND E.MU_CD       = '" + nullToBlank(ds_Cond.getString(0, "PR_SABUN_MU")) + "' \n");

	        if( !nullToBlank(ds_Cond.getString(0, "CUSTCD")).equals("") )
				sbSql.append("   AND B.CUSTCD      = " + nullToBlank(ds_Cond.getString(0, "CUSTCD")) + " \n");

	        if( !nullToBlank(ds_Cond.getString(0, "ITEM_CODE")).equals("") )
				sbSql.append("   AND B.ITEM_CODE   = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "' \n");

	        if (! nullToBlank(ds_Cond.getString(0, "PR_SABUN_CC_CD")).equals(""))
			    sbSql.append("   AND E.CC_CD       = '" + nullToBlank(ds_Cond.getString(0, "PR_SABUN_CC_CD")) + "'    \n");

	        if ( !nullToBlank(ds_Cond.getString(0, "SALE_TYPE")).equals("") )
				sbSql.append("   AND A.SALE_TYPE   = '" + nullToBlank(ds_Cond.getString(0, "SALE_TYPE")) + "' \n");

	        if ( !nullToBlank(ds_Cond.getString(0, "PR_SABUN")).equals("") )
			    sbSql.append("   AND A.PR_SABUN    = '" + nullToBlank(ds_Cond.getString(0, "PR_SABUN")) + "' \n");

	        if ( !nullToBlank(ds_Cond.getString(0, "RQ_SABUN")).equals("") )
				sbSql.append("   AND A.RQ_SABUN    = '" + nullToBlank(ds_Cond.getString(0, "RQ_SABUN")) + "' \n");

			if( !nullToBlank(ds_Cond.getString(0, "SP_ID")).equals("") )
				sbSql.append("   AND A.SP_ID       = '" + nullToBlank(ds_Cond.getString(0, "SP_ID")) + "' \n");

			sbSql.append("   AND A.BU_CD       = '" + nullToBlank(ds_Cond.getString(0, "BU_CD")) + "' \n");
			sbSql.append(" ORDER BY DECODE(A.LINE_STATUS, '취소', 'B', 'A'), " + ds_Cond.getString(0, "SORT") + ", A.SP_DATE, A.SP_ID \n");
		}
		//특판관리자 권한여부
		else if( sType.equals("SPECIAL_AUTH") )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("\n");
			sbSql.append("SELECT COUNT(*) CNT \n");
			sbSql.append("  FROM SCC_USER_ROLE V \n");
			sbSql.append(" WHERE V.SYS_TYPE  = 'FS시스템' \n");
			sbSql.append("   AND V.ROLE      = '특판관리자' \n");
			sbSql.append("   AND V.SABUN     = '" + nullToBlank(g_EmpNo) + "' \n");
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch(Exception e) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch(Exception e) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch(Exception e) {}
		}
		//jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>