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

		DataSet ds_cond     = in_dl.get("ds_cond");

		String g_Upjang     	= nullToBlank(in_vl.getString("g_Upjang"));
		String g_UpjangNm   	= nullToBlank(in_vl.getString("g_UpjangNm"));
		String g_EmpNo      	= nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Cc_Cd      	= nullToBlank(in_vl.getString("g_Cc_Cd"));
		String str_Mu_Cd    	= nullToBlank(in_vl.getString("MU_CD"));
		String str_EXP_CD   	= nullToBlank(in_vl.getString("EXP_CD"));
		String sType        	= nullToBlank(in_vl.getString("sType"));
		String str_RQ_SABUN 	= nullToBlank(in_vl.getString("RQ_SABUN"));
		String str_SABUN    	= nullToBlank(in_vl.getString("SABUN"));
		String str_SpId			= nullToBlank(in_vl.getString("str_SpId"));
		String str_SeasonNum	= nullToBlank(in_vl.getString("str_SeasonNum"));
		String sDateFr			= nullToBlank(in_vl.getString("sDateFr"));
		String sDateTo			= nullToBlank(in_vl.getString("sDateTo"));
		String sAttr01			= nullToBlank(in_vl.getString("ATTR01"));	// 복수업장구분
		String sAttr02			= nullToBlank(in_vl.getString("ATTR02"));	// 선택업장

		String sSeasonNum 		= nullToBlank(ds_cond.getString(0, "SEASON_NUM"));
		String sSpDate			= nullToBlank(ds_cond.getString(0, "SP_DATE"));
		String sItemName		= nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		String sItemClass3		= nullToBlank(ds_cond.getString(0, "ITEM_CLASS3"));
		String sItemClass4		= nullToBlank(ds_cond.getString(0, "ITEM_CLASS4"));
		String sSpecialYn		= null;
		StringBuffer sbSql0 = new StringBuffer();
		StringBuffer sbSql = new StringBuffer();
		StringBuffer sbSql2 = new StringBuffer();

		sbSql0.delete(0, sbSql0.length());
		sbSql0.append("	SELECT DECODE(COUNT(UPJANG), 0, 'N', 'Y') AS SPECIAL_YN FROM FSP_PO_SPECIAL_UPJANG WHERE SEASON_NUM = '"+sSeasonNum+"' AND OCCUR_CC_CD = '"+g_Cc_Cd+"' \n");
		pstmt = conn.prepareStatement(sbSql0.toString());
		rs = pstmt.executeQuery();
		rs.next();
		
		sSpecialYn = rs.getString("SPECIAL_YN");
		rs.close();
		pstmt.close();
		

		
		
		
		sbSql.delete(0, sbSql.length());

		if( sType.equals("QryLst") )
		{
			sbSql.append("/* 판촉상품 주문정보 조회 */ \n");
			sbSql.append("SELECT A.SP_ID AS SP_ID \n");
			sbSql.append("     , A.SEASON_NUM AS SEASON_NUM \n");
			sbSql.append("     , A.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , C.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , C.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , A.SALE_PRICE AS SALE_PRICE \n");
			sbSql.append("     , A.PR_QTY AS PR_QTY \n");
			sbSql.append("     , A.PR_QTY AS INIT_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT AS SALE_AMOUNT \n");
			sbSql.append("     , A.DC_AMOUNT AS DC_AMOUNT \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT AS TOT_AMOUNT\n");
			sbSql.append("     , A.SALE_TYPE AS SALE_TYPE \n");
			sbSql.append("     , C.IMG_PATH AS IMAGE_PATH \n");
			sbSql.append("     , DECODE(A.CONTENT, 'Y', 'Y', 'N') AS CONTENT \n");
			sbSql.append("     , CASE WHEN LENGTH(TRIM(D.DELI_TYPE) || TRIM(D.DELI_COMP) || TRIM(D.INVOICE_NUM)) > 0 AND A.LINE_STATUS = '정산' \n");
			sbSql.append("            THEN '배송' \n");
			sbSql.append("            ELSE A.LINE_STATUS \n");
			sbSql.append("        END AS LINE_STATUS \n");
			sbSql.append("     , A.PR_SABUN AS PR_SABUN \n");
			sbSql.append("     , A.RQ_SABUN AS RQ_SABUN \n");
			sbSql.append("     , (SELECT V1.NM_KOR || ' (' || V2.MU_NM || ' ' || V2.CC_NM ||')' AS NM_KOR \n"); 
			sbSql.append("          FROM HLDC_HR_PERSONAL V1 \n");
			sbSql.append("             , HLDC_SC_DEPT_V V2 \n");
			sbSql.append("         WHERE V1.DEPT_ID = V2.DEPT_ID \n");
			sbSql.append("           AND V1.SABUN = A.RQ_SABUN) AS RQ_SABUNNM \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.RQ_TEL_ENC, '4') AS RQ_TEL\n");
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
			sbSql.append("     , A.PAY_METHOD AS PAY_METHOD \n");
			sbSql.append("     , A.INST_PERIOD AS INST_PERIOD \n");
			sbSql.append("     , A.CARD_CLASS AS CARD_CLASS \n");
			sbSql.append("     , A.CARD_COMP AS CARD_COMP \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC,'2') AS CARD_NUM \n");
			sbSql.append("     , A.VALID_THRU_MM AS VALID_THRU_MM \n");
			sbSql.append("     , A.VALID_THRU_YY AS VALID_THRU_YY \n");
			sbSql.append("     , D.DELI_TYPE AS DELI_TYPE \n");
			sbSql.append("     , D.DELI_COMP AS DELI_COMP \n");
			sbSql.append("     , D.INVOICE_NUM AS INVOICE_NUM \n");
			sbSql.append("     , A.BILL_NO AS BILL_NO \n");
			sbSql.append("     , C.MAX_ORD_QTY AS MAX_ORD_QTY \n");
			sbSql.append("     , (B.STOCK_QTY - NVL( (SELECT SUM(Z.PR_QTY) \n");
			sbSql.append("                              FROM FSP_PO_SPECIAL_SALE Z \n");
			sbSql.append("                             WHERE Z.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("                               AND Z.SEASON_NUM = '" + sSeasonNum + "' \n");
			sbSql.append("                               AND Z.LINE_STATUS <> '취소' \n");
			sbSql.append("                               AND Z.SP_TYPE = 'ING'), 0) ) AS STOCK_QTY \n");
			sbSql.append("     , B.DELI_FREE_AMT AS DELI_FREE_AMT \n");
			sbSql.append("     , B.QTY_DC_STD AS QTY_DC_STD \n");
			sbSql.append("     , B.QTY_DC_RATE AS QTY_DC_RATE \n");
			sbSql.append("     , B.AMT_DC_STD AS AMT_DC_STD \n");
			sbSql.append("     , B.AMT_DC_RATE AS AMT_DC_RATE \n");
			sbSql.append("     , A.UPJANG AS UPJANG \n");
			sbSql.append("     , (SELECT DECODE(Z.UPJANGNM, '', '', Z.UPJANGNM || '(' || A.UPJANG || ')') \n");
			sbSql.append("          FROM ST_UPJANG Z \n");
			sbSql.append("         WHERE A.UPJANG = Z.UPJANG) AS UPJANGNM \n");
			sbSql.append("     , (SELECT DECODE(UPJANG, '" + g_Upjang + "', 'Y', 'N') \n");
			sbSql.append("          FROM FSP_PO_SEASON_LIST \n");
			sbSql.append("         WHERE SID = '" + sSeasonNum + "') AS UPJANG_EDIT \n");
			sbSql.append("     , B.OPER_ORG_SN AS OPER_ORG_SN \n");
			sbSql.append("     , B.VD_SN AS VD_SN \n");
			sbSql.append("     , B.CONTRACT_START AS CONTRACT_START \n");
			sbSql.append("     , A.AR_CUSTCD \n");
			sbSql.append("     , (SELECT CUSTNM FROM ST_CUST WHERE CUSTCD = A.AR_CUSTCD) AS AR_CUSTNM \n");
			sbSql.append("     , A.DELI_EXPT_DATE \n");
			sbSql.append("     , '' AS DELI_EXPT_DATE_CAL \n");
			sbSql.append("     , C.IMG_YN AS IMG_YN \n");
			sbSql.append("     , NVL(A.CALL_YN, 'N') AS CALL_YN \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append("     , IF_FS_SP_SALE_DAILY D \n");
			sbSql.append(" WHERE A.ITEM_CODE  = B.ITEM_CODE \n");
			sbSql.append("   AND A.ITEM_CODE  = C.ITEM_CODE \n");
			sbSql.append("   AND A.SP_ID      = D.SP_ID(+) \n");
			sbSql.append("   AND B.CONTRACT_START <= A.SP_DATE  \n");
			sbSql.append("   AND A.SP_DATE    = '" + sSpDate + "' \n");
			sbSql.append("   AND A.PR_SABUN   = '" + g_EmpNo + "' \n");
			
			if ( sSpecialYn.equals("Y") ) {
				
			} else {
				sbSql.append("   AND A.UPJANG   = '" + g_Upjang + "' \n");	
			}
			
			sbSql.append("   AND A.LINE_STATUS <> '취소' \n");
			sbSql.append("   AND A.SEASON_NUM = '" + sSeasonNum + "' \n");
			sbSql.append("   AND B.SEASON_NUM = '" + sSeasonNum + "' \n");
			sbSql.append("   AND A.BU_CD = '2000' \n");
			sbSql.append(" ORDER BY A.SP_ID \n");
		}
		else if( sType.equals("QryItm") )
		{
			sbSql.append("/* 판촉상품 조회 */ \n");
			sbSql.append("SELECT B.ITEM_CODE AS ITEM_CODE \n");
			sbSql.append("     , C.ITEM_NAME AS ITEM_NAME \n");
			sbSql.append("     , C.ITEM_SIZE AS ITEM_SIZE \n");
			sbSql.append("     , DECODE(C.TAX_CODE, '100', '과세', '210', '면세', '영세') AS TAX_CODE \n");
			sbSql.append("     , B.DELI_FEE AS ITEM_DELI_FEE \n");
			sbSql.append("     , B.SALE_PRICE AS SALE_PRICE \n");
			sbSql.append("     , C.IMG_PATH AS IMAGE_PATH \n");
			sbSql.append("     , C.MAX_ORD_QTY AS MAX_ORD_QTY \n");
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
			sbSql.append("     , B.ITEM_NUM AS ITEM_NUM \n");
			sbSql.append("     , B.OPER_ORG_SN AS OPER_ORG_SN\n");
			sbSql.append("     , B.VD_SN AS VD_SN \n");
			sbSql.append("     , B.CONTRACT_START AS CONTRACT_START \n");
			sbSql.append("     , C.IMG_YN AS IMG_YN \n");
			sbSql.append("  FROM FSP_PO_SEASON_LIST A \n");
			sbSql.append("     , FSP_PO_SPECIAL_ITEM B \n");
			sbSql.append("     , HLDC_PO_ITEM_MST C \n");
			sbSql.append("     , HLDC_PO_CONTRACT_SPEC D \n");
			sbSql.append(" WHERE A.SID       = B.SEASON_NUM \n");
			sbSql.append("   AND B.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append("   AND B.ITEM_CODE = D.ITEM_CODE \n");
			sbSql.append("   AND D.OPER_ORG_SN IN ( '574', '575', '576', '577', '611', '711', '811' ) \n");
			sbSql.append("   AND A.START_DATE <= '" + sSpDate + "' \n");
			sbSql.append("   AND A.END_DATE   >= '" + sSpDate + "' \n");
			sbSql.append("   AND TO_CHAR(SYSDATE, 'YYYYMMDD') BETWEEN D.CONTRACT_START AND D.CONTRACT_END \n");
			if (! sItemClass3.equals(""))
				sbSql.append("   AND C.ITEM_CLASS3 = '" + sItemClass3 + "' \n");
			if (! sItemClass4.equals(""))
				sbSql.append("   AND C.ITEM_CLASS4 = '" + sItemClass4 + "' \n");
			sbSql.append("   AND (C.ITEM_CODE LIKE '%'||'" + sItemName + "'||'%' \n");
			sbSql.append("     OR C.ITEM_NAME LIKE '%'||'" + sItemName + "'||'%') \n");
			sbSql.append("   AND C.USE_YN = 'Y' \n");
			sbSql.append("   AND B.SEASON_NUM = '" + sSeasonNum + "' \n");
			sbSql.append("ORDER BY B.ITEM_NUM, B.ITEM_CODE \n");
		}
		else if( sType.equals("RQ_TEL") )
		{
			sbSql.append("/* 신청자 핸드폰 번호 */ \n");
			sbSql.append("SELECT V.NM_KOR AS RQ_SABUNNM \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', V.HP_NO_ENC, '4') AS RQ_TEL \n");
			sbSql.append("  FROM SCC_USERINFO V \n");
			sbSql.append(" WHERE V.SABUN = '" + nullToBlank(str_RQ_SABUN) + "' \n");
		}
		else if( sType.equals("PR_SABUN") )
		{
			sbSql.append("/* 주문자사번 EXP_CD Query */ \n");
			sbSql.append("SELECT NVL(A.EXP_CD, 'N') AS EXP_CD \n");
			sbSql.append("  FROM HLDC_HR_PERSONAL V \n");
			sbSql.append("     , HLDC_SC_DEPT_V A \n");
			sbSql.append(" WHERE V.DEPT_ID = A.DEPT_ID \n");
			sbSql.append("   AND V.SABUN = '" + nullToBlank(g_EmpNo) + "' \n");
		}
		else if( sType.equals("RQ_SABUN") )
		{
			sbSql.append("/* 신청자사번 Excel Import시 검증용 Query */ \n");
	        sbSql.append("SELECT COUNT(*) AS CNT \n");
	        sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
	        sbSql.append("     , HLDC_SC_DEPT_V B \n");
	        sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
	        sbSql.append("   AND DECODE(B.MU_CD||NVL(B.EXP_CD, 'N'), 'YAY', B.CC_CD, B.MU_CD) = DECODE('" + nullToBlank(str_Mu_Cd + str_EXP_CD) + "', 'YAY', '" + nullToBlank(g_Cc_Cd) + "', '" + nullToBlank(str_Mu_Cd) + "') \n");
	        sbSql.append("   AND A.SABUN = '" + nullToBlank(str_RQ_SABUN) + "' \n");
		}
		// 신청자업장
		else if( sType.equals("RQ_UPJANG") )
		{
			int cnt = 0;

			sbSql2.delete(0, sbSql2.length());
			sbSql2.append("SELECT COUNT(*) AS CNT \n");
			sbSql2.append("  FROM HLDC_HR_PERSONAL A \n");
			sbSql2.append("     , FSP_PO_SPECIAL_UPJANG B \n");
			sbSql2.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
			sbSql2.append("   AND A.GB_JAEJIK <> 'RA' \n");
			sbSql2.append("   AND A.SABUN = '" + str_SABUN + "' \n");
			sbSql2.append("   AND B.SEASON_NUM = '" + sSeasonNum + "' \n");

			pstmt = conn.prepareStatement(sbSql2.toString());
			rs = pstmt.executeQuery();
			rs.next();

			cnt = rs.getInt("CNT");

			rs.close();
			pstmt.close();

			// 판촉 예외부서
			if( cnt > 0  )
			{
				sbSql.append("SELECT B.UPJANG \n");
				sbSql.append("     , (SELECT UPJANGNM || '(' || UPJANG || ')' FROM ST_UPJANG WHERE UPJANG = B.UPJANG) AS UPJANGNM \n");
				sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
				sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
				sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
				sbSql.append("   AND A.GB_JAEJIK <> 'RA' \n");
				sbSql.append("   AND A.SABUN = '" + str_SABUN + "' \n");
				sbSql.append("   AND B.SEASON_NUM = '" + sSeasonNum + "' \n");
			}
			// 일반 제조
			else
			{
				sbSql2.delete(0, sbSql2.length());
				sbSql2.append("SELECT CASE WHEN C.CODE IS NULL THEN A.CST_PLNKGVRN_CLASS_CD ELSE 'SG' END AS CST_PLNKGVRN_CLASS_CD \n");
				sbSql2.append("  FROM SCC_CC A \n");
				sbSql2.append("   	left OUTER JOIN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0300') C ON A.ATTR04 = C.CODE \n");
				sbSql2.append("     , HLDC_HR_PERSONAL B \n");
				sbSql2.append(" WHERE A.CC_CD = B.CC_CD \n");
				sbSql2.append("   AND B.SABUN = '" + str_SABUN + "' \n");

				pstmt = conn.prepareStatement(sbSql2.toString());
				rs = pstmt.executeQuery();
				rs.next();

				String cstPlnkgvrnClassCd = rs.getString("CST_PLNKGVRN_CLASS_CD");

				rs.close();
				pstmt.close();

				if( cstPlnkgvrnClassCd.equals("CG") )
				{
					if ( sAttr01.equalsIgnoreCase("true") ) {
						sbSql.append("SELECT B.UPJANG \n");
						sbSql.append("     , B.UPJANGNM || '(' || B.UPJANG || ')' AS UPJANGNM \n");
						sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
						sbSql.append("     , ST_UPJANG B \n");
						sbSql.append("     , SCC_USERINFO C \n");
						sbSql.append(" WHERE A.CC_CD = B.CC_CD \n");
						sbSql.append("   AND A.GB_JAEJIK <> 'RA' \n");
						sbSql.append("   AND A.SABUN = '" + str_SABUN + "' \n");
						sbSql.append("	 AND A.SABUN = C.SABUN  \n");
						sbSql.append("	 AND B.UPJANG = C.UPJANG  \n");
					} else {
						sbSql.append("SELECT B.UPJANG \n");
						sbSql.append("     , B.UPJANGNM || '(' || B.UPJANG || ')' AS UPJANGNM \n");
						sbSql.append("  FROM FMS_USER_UPJANG A \n");
						sbSql.append("     , ST_UPJANG B \n");
						sbSql.append("     , HLDC_SC_DEPT_V C \n");
						sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
						sbSql.append("	 AND B.CC_CD = C.CC_CD  \n");
						sbSql.append("   AND A.SABUN = '" + str_SABUN + "' \n");
						
						if  ( !sAttr02.equals("") ) {
							sbSql.append("   AND B.UPJANG = '" + sAttr02 + "' \n");
						}
					}
				}
				else
				{
	                out_vl.add("v_spClose", "신청자의 판관 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}
			}
		}
		// 엑셀 업로드 신청자 조회
		else if( sType.equals("EX_USER") )
		{
			int cnt = 0;

			sbSql2.delete(0, sbSql2.length());
			sbSql2.append("SELECT COUNT(*) AS CNT \n");
			sbSql2.append("  FROM HLDC_HR_PERSONAL A \n");
			sbSql2.append("     , FSP_PO_SPECIAL_UPJANG B \n");
			sbSql2.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
			sbSql2.append("   AND A.GB_JAEJIK <> 'RA' \n");
			sbSql2.append("   AND A.SABUN = '" + str_SABUN + "' \n");
			sbSql2.append("   AND B.SEASON_NUM = '" + sSeasonNum + "' \n");

			pstmt = conn.prepareStatement(sbSql2.toString());
			rs = pstmt.executeQuery();
			rs.next();

			cnt = rs.getInt("CNT");

			rs.close();
			pstmt.close();

			// 판촉 예외부서
			if( cnt > 0  )
			{
				sbSql.append("/* 엑셀 업로드 신청자 조회 */ \n");
				sbSql.append("SELECT A.SABUN AS SABUN \n");
				sbSql.append("     , A.NM_KOR||'('||B.MU_NM||' '||B.CC_NM||')' AS NM_KOR \n");
				sbSql.append("     , TO_CHAR(C.UPJANG) AS UPJANG \n");
				sbSql.append("     , (SELECT UPJANGNM || '(' || UPJANG || ')' FROM ST_UPJANG WHERE UPJANG = C.UPJANG) AS UPJANGNM \n");
				sbSql.append("     , (SELECT SC_CRYPTO_FUN('DEC', HP_NO_ENC, '4') FROM SCC_USERINFO WHERE SABUN = '" + str_SABUN + "') AS RQ_TEL \n");
				sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
				sbSql.append("     , HLDC_SC_DEPT_V B \n");
				sbSql.append("     , FSP_PO_SPECIAL_UPJANG C \n");
				sbSql.append("     , ( \n");
				sbSql.append("        SELECT SABUN \n");
				sbSql.append("          FROM HLDC_HR_PERSONAL A \n");
				sbSql.append("             , HLDC_SC_DEPT_V B \n");
				sbSql.append("             , ST_UPJANG C \n");
				sbSql.append("         WHERE A.DEPT_ID = B.DEPT_ID \n");
				sbSql.append("           AND A.CC_CD = C.CC_CD \n");
				sbSql.append("           AND A.GB_JAEJIK <> 'RA' \n");
				sbSql.append("           AND C.UPJANG = '" + g_Upjang + "' \n");
//				sbSql.append("           AND C.CC_CD = (SELECT CC_CD FROM HLDC_HR_PERSONAL WHERE SABUN = '" + str_SABUN + "') \n");
				sbSql.append("       ) D \n");
				sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
				sbSql.append("   AND A.CC_CD = C.OCCUR_CC_CD \n");
				sbSql.append("   AND A.SABUN = D.SABUN \n");
				sbSql.append("   AND A.GB_JAEJIK <> 'RA' \n");
				sbSql.append("   AND A.SABUN = '" + str_SABUN + "' \n");
				sbSql.append("   AND C.SEASON_NUM = '" + sSeasonNum + "' \n");
			}
			else
			{
				// 제조 판관 구분 처리 후 판관인 사용자는 리턴 처리함.
				sbSql2.delete(0, sbSql2.length());
				sbSql2.append("SELECT CASE WHEN C.CODE IS NULL THEN A.CST_PLNKGVRN_CLASS_CD ELSE 'SG' END AS CST_PLNKGVRN_CLASS_CD \n");
				sbSql2.append("  FROM SCC_CC A \n");
				sbSql2.append("   	left OUTER JOIN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0300') C ON A.ATTR04 = C.CODE \n");
				sbSql2.append("     , HLDC_HR_PERSONAL B \n");
				sbSql2.append(" WHERE A.CC_CD = B.CC_CD \n");
				sbSql2.append("   AND B.SABUN = '" + str_SABUN + "' \n");

				pstmt = conn.prepareStatement(sbSql2.toString());
				rs = pstmt.executeQuery();
				rs.next();

				String cstPlnkgvrnClassCd = rs.getString("CST_PLNKGVRN_CLASS_CD");

				rs.close();
				pstmt.close();

				if( cstPlnkgvrnClassCd.equals("CG") )
				{
					sbSql.append("/* 엑셀 업로드 신청자 조회 */ \n");
					sbSql.append("SELECT A.SABUN AS SABUN \n");
					sbSql.append("     , A.NM_KOR||'('||B.MU_NM||' '||B.CC_NM||')' AS NM_KOR \n");
					sbSql.append("     , TO_CHAR(C.UPJANG) AS UPJANG \n");
					sbSql.append("     , C.UPJANGNM || '(' || C.UPJANG || ')' AS UPJANGNM \n");
					sbSql.append("     , (SELECT SC_CRYPTO_FUN('DEC', HP_NO_ENC, '4') FROM SCC_USERINFO WHERE SABUN = '" + str_SABUN + "') AS RQ_TEL \n");
					sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
					sbSql.append("     , HLDC_SC_DEPT_V B \n");
					sbSql.append("     , ST_UPJANG C \n");
					sbSql.append("     , SCC_USERINFO D \n");
					sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
					sbSql.append("   AND A.CC_CD = C.CC_CD \n");
					sbSql.append("   AND A.GB_JAEJIK <> 'RA' \n");
					sbSql.append("   AND A.SABUN = D.SABUN \n");
					sbSql.append("   AND C.UPJANG = D.UPJANG \n");
					sbSql.append("   AND A.SABUN = '" + str_SABUN + "' \n");
					sbSql.append("   AND C.UPJANG = '" + g_Upjang + "' \n");
//					sbSql.append("   AND C.CC_CD = (SELECT CC_CD FROM HLDC_HR_PERSONAL WHERE SABUN = '" + str_SABUN + "') \n");
				}
				else
				{
	                out_vl.add("v_spClose", "신청자의 판관 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}
			}
		}
		// 주문 삭제 서버 체크
		else if( sType.equals("LINE_STATUS") )
		{
			sbSql.append("/* 주문 삭제 서버 체크 */ \n");
			sbSql.append("SELECT LINE_STATUS \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE \n");
			sbSql.append(" WHERE SP_ID      = '" + str_SpId + "' \n");
			sbSql.append("   AND SEASON_NUM = '" + str_SeasonNum + "' \n");
			sbSql.append("   AND BU_CD      = '2000' \n");
		}
		// 배송예정일
		else if( sType.equals("DELI_EXPT_DATE") )
		{
			sbSql.append("/* 배송예정일 기간 조회 */ \n");
			sbSql.append("SELECT CD_SY||CD_SM||CD_SD AS DELI_EXPT_DATE \n");
			sbSql.append("     , CD_WEEK AS CD_WEEK \n");
			sbSql.append("     , HOLIDAY AS HOLIDAY \n");
			sbSql.append("  FROM SCC_CALENDA_DATA \n");
			sbSql.append(" WHERE CD_SY||CD_SM||CD_SD >= '" + sDateFr + "' \n");
			sbSql.append("   AND CD_SY||CD_SM||CD_SD <= '" + sDateTo + "' \n");
			sbSql.append(" ORDER BY CD_NO \n");
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