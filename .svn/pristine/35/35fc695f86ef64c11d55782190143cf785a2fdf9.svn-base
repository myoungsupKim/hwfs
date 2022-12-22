<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00650V_T001.jsp
■ 프로그램명   : 거래실적집계(장려금)
■ 작성일자     : 2008-08-07
■ 작성자       : 박은규
■ 이력관리     : 2008-08-07
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.NEED_DATE_ORI \n");
			sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("     , SUM(OP_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(OP_NOTAX) AS OP_NOTAX \n");
			sbSql.append("     , SUM(OP_TAX) AS OP_TAX \n");
			sbSql.append("     , SUM(OP_VAT) AS OP_VAT \n");
			sbSql.append("     , SUM(OP_TOT) AS OP_TOT \n");
			sbSql.append("     , SUM(OP_AMOUNT1) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(OP_NOTAX1) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(OP_TAX1) AS OP_TAX1 \n");
			sbSql.append("     , SUM(OP_VAT1) AS OP_VAT1 \n");
			sbSql.append("     , SUM(OP_TOT1) AS OP_TOT1 \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT \n");
			if (sType.equals("001"))
				sbSql.append("       A.TRANS_UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			else
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT1 \n");				
			// TODO
 			sbSql.append("     , SUM(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100))))) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT \n");
			sbSql.append("  FROM (SELECT A.* , B.ITEM_CLASS3, B.ITEM_CLASS4 FROM (  \n");
					
					sbSql.append("SELECT                                                                                                                                                                                                                                                                                                                                \n");
					sbSql.append("       SL.CUST_GR_DATE AS TRANS_DATE /* 판매일자 */,                                                                                                                                                                                                                                                                                      \n");
					sbSql.append("       DT.MG_DATE AS MG_DATE /* 수불일자*/,                                                                                                                                                                                                                                                                                               \n");
					sbSql.append("       CASE                                                                                                                                                                                                                                                                                                                           \n");
					sbSql.append("         WHEN SUBSTR(DT.MOVEMENT_TYP, 0, 2)='25' THEN 'FO'                                                                                                                                                                                                                                                                        \n");
					sbSql.append("         WHEN (DT.PROC_TYP_CD IS NULL                                                                                                                                                                                                                                                                                                 \n");
					sbSql.append("        AND    DT.IVT_INSP_NO IS NOT NULL) THEN '재고조정'                                                                                                                                                                                                                                                                              \n");
					sbSql.append("         WHEN (DT.PROC_TYP_CD IS NULL                                                                                                                                                                                                                                                                                                 \n");
					sbSql.append("        AND    DT.IVT_INSP_NO IS NULL ) THEN 'INV'                                                                                                                                                                                                                                                                                  \n");
					sbSql.append("         ELSE 'PO'                                                                                                                                                                                                                                                                                                                  \n");
					sbSql.append("       END AS SOURCE_TYPE /*FO, PO, INV, 재고조정*/,                                                                                                                                                                                                                                                                                      \n");
					sbSql.append("       CASE                                                                                                                                                                                                                                                                                                                           \n");
					sbSql.append("         WHEN (SUBSTR(DT.MOVEMENT_TYP, 0, 1) = '3'                                                                                                                                                                                                                                                                                  \n");
					sbSql.append("        AND    DT.GR_QTY IS NULL) THEN 'O002' /* 재고이동 - 이동출고   */                                                                                                                                                                                                                                                                   \n");
					sbSql.append("         WHEN (SUBSTR(DT.MOVEMENT_TYP, 0, 1) = '3'                                                                                                                                                                                                                                                                                  \n");
					sbSql.append("        AND    DT.GR_QTY IS NOT NULL) THEN 'I002' /*재고이동 - 이동입고  */                                                                                                                                                                                                                                                                 \n");
					sbSql.append("         WHEN (DT.MOVEMENT_TYP = '251'                                                                                                                                                                                                                                                                                              \n");
					sbSql.append("        OR     DT.MOVEMENT_TYP = '252') THEN 'O001' /* POS 매출 유형  */                                                                                                                                                                                                                                                              \n");
					sbSql.append("         WHEN (DT.MOVEMENT_TYP = '701'                                                                                                                                                                                                                                                                                              \n");
					sbSql.append("        OR     DT.MOVEMENT_TYP = '702') THEN 'O004' /* 재고실사 */                                                                                                                                                                                                                                                                    \n");
					sbSql.append("         ELSE 'I001'                                                                                                                                                                                                                                                                                                                \n");
					sbSql.append("       END AS TRANS_TYPE,                                                                                                                                                                                                                                                                                                             \n");
					sbSql.append("       CASE                                                                                                                                                                                                                                                                                                                           \n");
					sbSql.append("         WHEN (MOD(TO_NUMBER(DT.MOVEMENT_TYP), 2)=0                                                                                                                                                                                                                                                                                   \n");
					sbSql.append("        AND    DT.PROC_TYP_CD IS NOT NULL) THEN DECODE(DT.GR_QTY, NULL, DT.GI_PURC_QTY*-1, DT.GR_PURC_QTY*-1)                                                                                                                                                                                                                         \n");
					sbSql.append("         WHEN (MOD(TO_NUMBER(DT.MOVEMENT_TYP), 2)=1                                                                                                                                                                                                                                                                                   \n");
					sbSql.append("        AND    DT.PROC_TYP_CD IS NOT NULL) THEN DECODE(DT.GR_QTY, NULL, DT.GI_PURC_QTY, DT.GR_PURC_QTY)                                                                                                                                                                                                                               \n");
					sbSql.append("         WHEN (MOD(TO_NUMBER(DT.MOVEMENT_TYP), 2)=0                                                                                                                                                                                                                                                                                   \n");
					sbSql.append("        AND    DT.PROC_TYP_CD IS NULL) THEN DECODE(DT.GR_QTY, NULL, DT.GI_QTY*-1, DT.GR_QTY*-1)                                                                                                                                                                                                                                       \n");
					sbSql.append("         WHEN (MOD(TO_NUMBER(DT.MOVEMENT_TYP), 2)=1                                                                                                                                                                                                                                                                                   \n");
					sbSql.append("        AND    DT.PROC_TYP_CD IS NULL) THEN DECODE(DT.GR_QTY, NULL, DT.GI_QTY, DT.GR_QTY)                                                                                                                                                                                                                                             \n");
					sbSql.append("       END AS TRANS_QTY /*수량*/,                                                                                                                                                                                                                                                                                                       \n");
					sbSql.append("       DT.ITEM_CD AS ITEM_CODE /*품목코드*/,                                                                                                                                                                                                                                                                                              \n");
					sbSql.append("       SL.CUST_WH_CD AS SUBINV_CODE,                                                                                                                                                                                                                                                                                                  \n");
					sbSql.append("       SL.SHOP_CD AS TRANS_UPJANG /*업장코드*/,                                                                                                                                                                                                                                                                                           \n");
					sbSql.append("       DECODE(PO.DUTY_FREE_YN, '1', '100', '3', '210', '220') AS TAX_CODE /*과면세 코드*/,                                                                                                                                                                                                                                       \n");
					sbSql.append("         PO.WH_CNTR_CD AS CENTER_CODE /*센터코드*/,                                                                                                                                                                                                                                                                                       \n");
					sbSql.append("       SL.SAL_PRICE AS SALE_PRICE /*외부판매단가*/                                                                                                                                                                                                                                                                                          \n");
					sbSql.append("                                                                                                                                                                                                                                                                                                                                      \n");
					sbSql.append("FROM   EPROCUSR.ESIMGDT DT /* 수불상세 */,                                                                                                                                                                                                                                                                                                \n");
					sbSql.append("       EPROCUSR.ESPPODT PO /* 발주 상세 */,                                                                                                                                                                                                                                                                                               \n");
					sbSql.append("       EPROCUSR.ESISALP SL /* 판매단가 */                                                                                                                                                                                                                                                                                                 \n");
					sbSql.append("WHERE  SL.SYS_ID = '100'                                                                                                                                                                                                                                                                                                            \n");
					sbSql.append("AND    SL.COMP_CD = 'HFC'                                                                                                                                                                                                                                                                                                           \n");
					sbSql.append("AND    DT.SYS_ID = '100'                                                                                                                                                                                                                                                                                                            \n");
					sbSql.append("AND    DT.COMP_CD = 'HFC'                                                                                                                                                                                                                                                                                                           \n");
					sbSql.append("AND    DT.MOVEMENT_TYP NOT IN ('561', '562', '998', '999', '901', '902', '801', '802', '111', '112', '211', '212') /* 기초 , 기말 재고,배송입출고, 직송 가상입출고  제외 */                                                                                                                                                       \n");
					sbSql.append("AND    DT.STS <> 'D'                                                                                                                                                                                                                                                                                                                \n");
					sbSql.append("AND    DT.SYS_ID = PO.SYS_ID                                                                                                                                                                                                                                                                                                          \n");
					sbSql.append("AND    DT.COMP_CD = PO.COMP_CD                                                                                                                                                                                                                                                                                                        \n");
					sbSql.append("AND    DT.PO_NO = PO.PO_NO                                                                                                                                                                                                                                                                                                            \n");
					sbSql.append("AND    DT.PO_LNO = PO.PO_LNO                                                                                                                                                                                                                                                                                                          \n");
					sbSql.append("AND    DT.SYS_ID = SL.SYS_ID                                                                                                                                                                                                                                                                                                          \n");
					sbSql.append("AND    DT.COMP_CD = SL.COMP_CD                                                                                                                                                                                                                                                                                                        \n");
					sbSql.append("AND    DT.MG_NO = SL.MG_NO                                                                                                                                                                                                                                                                                                            \n");
					sbSql.append("AND    PO.SYS_ID = SL.SYS_ID                                                                                                                                                                                                                                                                                                          \n");
					sbSql.append("AND    PO.COMP_CD = SL.COMP_CD                                                                                                                                                                                                                                                                                                        \n");
					//sbSql.append("AND    SL.SHOP_CD IN (SELECT UPJANG FROM FMS_UPJANGV WHERE MAIN_UPJANG = 111747)                                                                                                                                                                                                                                                      \n");
					if (! sUpjang.equals(""))
					sbSql.append("AND   SL.SHOP_CD  = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                                                                                                                                                                                                \n");
					else
				    sbSql.append("AND   SL.SHOP_CD  IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " )                                                                                                                                                                                                                                               \n");	

					sbSql.append("AND    SL.CUST_GR_DATE   BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "'                                                                                                                                                                                                                                                                        \n");
					sbSql.append("   UNION ALL                                                                                                                                                                                                                                                                                                                          \n");
					sbSql.append("   SELECT  B.TRANS_DATE,                                                                                                                                                                                                                                                                                                              \n");
					sbSql.append("          B.TRANS_DATE AS MG_DATE,                                                                                                                                                                                                                                                                                                    \n");
					sbSql.append("          B.SOURCE_TYPE,                                                                                                                                                                                                                                                                                                              \n");
					sbSql.append("          B.TRANS_TYPE,                                                                                                                                                                                                                                                                                                               \n");
					sbSql.append("          B.TRANS_QTY,                                                                                                                                                                                                                                                                                                                \n");
					sbSql.append("          B.ITEM_CODE,                                                                                                                                                                                                                                                                                                                \n");
					sbSql.append("          B.SUBINV_CODE,                                                                                                                                                                                                                                                                                                              \n");
					sbSql.append("          TO_CHAR (B.TRANS_UPJANG) AS TRANS_UPJANG,                                                                                                                                                                                                                                                                                   \n");
					sbSql.append("          B.TAX_CODE,                                                                                                                                                                                                                                                                                                                 \n");
					sbSql.append("          B.CENTER_CODE,                                                                                                                                                                                                                                                                                                              \n");
					sbSql.append("          B.SALE_PRICE                                                                                                                                                                                                                                                                                                                \n");
					sbSql.append("     FROM FMS_TRANSACTION B                                                                                                                                                                                                                                                                                                           \n");
					sbSql.append("WHERE     B.TRANS_DATE   BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "'                                                                                                                                                                                                                                                                       \n");
					if (! sUpjang.equals(""))
					sbSql.append("AND   B.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                                                                                                                                                                                                \n");
					else
				    sbSql.append("AND   B.TRANS_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "   )                                                                                                                                                                                                                                             \n");	
					sbSql.append(")                                                                                                                                                                                                                                                                                                                                     \n");
					
					
					
					
					sbSql.append(" 		A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B \n");
			sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CODE, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_ITEM_SALE_RATE -- 자재별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("       ) D \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS4, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 세분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 7 \n");
		    sbSql.append("       ) E \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS3, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 소분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 5 \n");
		    sbSql.append("       ) F \n");
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.TRANS_UPJANG = D.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_UPJANG = E.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_UPJANG = F.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			    sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP \n");
			else
				sbSql.append(" GROUP BY A.TRANS_DATE \n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT A.UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			else
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT \n");				
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100))))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT1 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT1 \n");
			sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS3, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B\n");
			sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CODE, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_ITEM_SALE_RATE -- 자재별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("       ) D \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS4, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 세분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 7 \n");
		    sbSql.append("       ) E \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS3, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- 소분류별 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 5 \n");
		    sbSql.append("       ) F \n");
			
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		    sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		    sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			
		    if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");
			else
				sbSql.append(" GROUP BY A.NEED_DATE \n");
		}
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.NEED_DATE_ORI, A.NEED_DATE \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.NEED_DATE_ORI \n");
			sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("     , SUM(OP_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(OP_NOTAX) AS OP_NOTAX \n");
			sbSql.append("     , SUM(OP_TAX) AS OP_TAX \n");
			sbSql.append("     , SUM(OP_VAT) AS OP_VAT \n");
			sbSql.append("     , SUM(OP_TOT) AS OP_TOT \n");
			sbSql.append("     , SUM(OP_AMOUNT1) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(OP_NOTAX1) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(OP_TAX1) AS OP_TAX1 \n");
			sbSql.append("     , SUM(OP_VAT1) AS OP_VAT1 \n");
			sbSql.append("     , SUM(OP_TOT1) AS OP_TOT1 \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT \n");
			if (sType.equals("001"))
				sbSql.append("       A.TRANS_UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			else
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT \n");				
			// TODO
 			sbSql.append("     , SUM(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100))))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT1 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT1 \n");
			
		
			
			
			
/* 			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX \n");
			sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_VAT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) \n");
			sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_TOT \n");
 */			
			
/* 			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)))) AS OP_AMOUNT1 \n");			
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))))) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))),0)) AS OP_TAX1 \n");
			//부가세는 매출장려율 적용하지 않는다. 또한 합계 후 라운드
			sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_VAT1 \n");
			sbSql.append("     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))))) \n");
			sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_TOT1 \n");
 */

			//sbSql.append("  FROM HLDC_PO_TRANSACTION A, FMS_UPJANG D \n");
			sbSql.append(" FROM (SELECT A.* , B.ITEM_CLASS3, B.ITEM_CLASS4 FROM HLDC_PO_TRANSACTION A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B \n");
			//sbSql.append("     , FMU_OP_RATE C \n");
			//sbSql.append("     , HLDC_FM_SALE_RATE K \n");
			sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CODE, A.FM_SALE_RATE, A.FM_NOSALE_RATE     						\n");
				sbSql.append("   FROM FMS_ITEM_SALE_RATE A -- 자재별    													\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append(" ) D																							\n");
				sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CLASS AS ITEM_CLASS4, A.FM_SALE_RATE, A.FM_NOSALE_RATE			\n");
				sbSql.append("   FROM FMS_SALE_RATE A -- 세분류별    														\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append("    AND LENGTH(A.ITEM_CLASS) = 7																\n");
				sbSql.append(" ) E																							\n");
				sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CLASS AS ITEM_CLASS3, A.FM_SALE_RATE, A.FM_NOSALE_RATE			\n");
				sbSql.append("   FROM FMS_SALE_RATE A -- 소분류별    														\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append("    AND LENGTH(A.ITEM_CLASS) = 5																\n");
				sbSql.append(" ) F																							\n");
			//sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			//sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
			//sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			
			
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) 						\n");
		    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) 					\n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) 					\n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) 				\n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) 				\n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) 				\n");
		    
		    sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP \n");
			else
				sbSql.append(" GROUP BY A.TRANS_DATE \n");
			
		    
		    
		    
/* 			sbSql.append("   AND A.SUBINV_CODE = K.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN K.SDATE(+) AND K.EDATE(+) \n");
			sbSql.append("   AND SUBSTR(A.ITEM_CODE,1,8) = K.ITEM_CLASS(+) \n");
			sbSql.append("   AND K.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP \n");
			else
				sbSql.append(" GROUP BY A.TRANS_DATE \n"); */
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT A.UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			else
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT \n");				
			
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100))))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT1 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT1 \n");
 
/* 			sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_VAT \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) \n");
			sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  *******************			
//			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))))) AS OP_AMOUNT1 \n");
//			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100)))))) AS OP_NOTAX1 \n");
//			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100)))),0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)))) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))))) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))),0)) AS OP_TAX1 \n");			
//**************  FM_NOSALE_RATE 추가에 따른 변경  *******************
			//부가세는 매출장려율 적용하지 않는다. 또한 합계 후 라운드
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_VAT1 \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  *******************
//			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))))) \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)))) \n");
//**************  FM_NOSALE_RATE 추가에 따른 변경  *******************
			sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT1 \n");
			//sbSql.append("     , SUM(ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
			//sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			//sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			//sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS OP_VAT1 \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS OP_TOT1 \n");*/
			sbSql.append("  FROM (SELECT B.ITEM_CLASS3, A.* FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B\n");
			//sbSql.append("     , FMU_OP_RATE C \n");
			
			//sbSql.append("     , HLDC_FM_SALE_RATE K \n");
			sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CODE, A.FM_SALE_RATE, A.FM_NOSALE_RATE     						\n");
				sbSql.append("   FROM FMS_ITEM_SALE_RATE A -- 자재별    													\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append(" ) D																							\n");
				sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CLASS AS ITEM_CLASS4, A.FM_SALE_RATE, A.FM_NOSALE_RATE			\n");
				sbSql.append("   FROM FMS_SALE_RATE A -- 세분류별    														\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append("    AND LENGTH(A.ITEM_CLASS) = 7																\n");
				sbSql.append(" ) E																							\n");
				sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CLASS AS ITEM_CLASS3, A.FM_SALE_RATE, A.FM_NOSALE_RATE			\n");
				sbSql.append("   FROM FMS_SALE_RATE A -- 소분류별    														\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append("    AND LENGTH(A.ITEM_CLASS) = 5																\n");
				sbSql.append(" ) F																							\n");
				
			//sbSql.append(" WHERE A.UPJANG = D.UPJANG \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");

			
			
			//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			//sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			//sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE \n");   //20090901 주석 처리
			
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) 						\n");
		    //sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) 					\n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) 					\n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) 				\n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) 				\n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) 				\n");
		    
		    sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			
		    if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");
			else
				sbSql.append(" GROUP BY A.NEED_DATE \n");
			
			
			
			
/* 			sbSql.append("   AND A.SUBINV_CODE = K.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS3 = K.ITEM_CLASS(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN K.SDATE(+) AND K.EDATE(+) \n");			
			sbSql.append("   AND K.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.UPJANG, D.UPJANGNM_DISP \n");
			else
				sbSql.append(" GROUP BY A.NEED_DATE \n"); */
		}
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.NEED_DATE_ORI, A.NEED_DATE \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

--%>