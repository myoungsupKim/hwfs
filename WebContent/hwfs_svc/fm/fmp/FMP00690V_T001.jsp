<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00690V_T001.jsp
■ 프로그램명   : 사업장별 거래실적집계(장려금)
■ 작성일자     : 2008-01-31
■ 작성자       : 박은규
■ 이력관리     : 2008-01-31
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
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , A.SUBINV_CODE \n");
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
			//sbSql.append("SELECT /*+ LEADING(D A E C) USE_NL(D A E C) INDEX(A PO_TRANSACTION_PT_I10) */ \n");
			sbSql.append("SELECT  \n");
			if (sType.equals("001")){
				sbSql.append("       TO_CHAR(A.TRANS_UPJANG) AS NEED_DATE_ORI, E.SUBINV_NAME_DISP AS NEED_DATE, D.UPJANG,  E.SUBINV_CODE \n");
			}else{
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE, D.UPJANG, A.SUBINV_CODE \n");
			}	

			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_AMOUNT\n");		
			*/
			sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS OP_AMOUNT \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_NOTAX\n");		
			*/
			sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_NOTAX \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_TAX\n");		
			*/
			sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)), 0)) AS OP_TAX \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_VAT\n");
			*/
			sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_VAT \n");			
//			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
// 2009/06/01(월) 입고총합 입출고 유형 반영 수정 BY 노규완
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");			
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_TOT\n");
			*/
			sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS OP_TOT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS OP_VAT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS OP_TOT1 \n");

			//sbSql.append("  FROM HLDC_PO_TRANSACTION A, FMS_UPJANG D \n");
			//sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
			sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4 FROM (SELECT a.trans_id, a.trans_date, a.mg_date, a.source_type, a.mvt, a.trans_type,\n");
			sbSql.append("                      a.trans_qty, a.unit_price, a.trans_mprice, a.trans_mvat,  \n");  
			sbSql.append("                      a.margin_price, a.unit_amount, a.trans_mamount, a.margin_amount,\n");
			sbSql.append("                      a.margin_vat, a.trans_mu_cd, a.trans_dept_id, a.trans_upjang, \n");
			sbSql.append("                      a.subinv_code, a.acctcd, a.item_code, a.item_name, a.item_size,\n");
			sbSql.append("                      a.tax_code, a.trans_uom, a.uom_code, a.unit_rate, a.custcd,\n");
			sbSql.append("                      a.po_type, a.center_code, a.gano, a.buddept_id, a.sale_price,\n");
			sbSql.append("                     a.sale_amount, a.sale_vat, source_id, a.sal_evnt_price,\n");
			sbSql.append("                     a.sal_stra_price, a.sal_enco_price, a.sal_oper_price, '' AS remark,\n");
			sbSql.append("                      a.po_no, a.po_lno, '1' AS flag,\n");
			sbSql.append("                    DECODE (SUBSTR (a.trans_date, 1, 6),\n");
			sbSql.append("                              SUBSTR (a.mg_date, 1, 6), a.trans_date,\n");
			sbSql.append("                             a.mg_date\n");
			sbSql.append("                            ) AS trans_date2\n");
			sbSql.append("                FROM eprocusr.vo_po_transaction_sale a,\n");
			sbSql.append("                      FMS_UPJANGV B\n");
			sbSql.append("               WHERE A.TRANS_UPJANG = B.UPJANG\n");
			sbSql.append("                 AND TRANS_DATE BETWEEN  '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "'\n");
			sbSql.append("                 AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("                 AND  B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "\n");
			sbSql.append("              UNION ALL\n");
			sbSql.append("              SELECT b.trans_id              /* 자재수불번호 : M+'0000000000' : 조정분 */\n");
			sbSql.append("                               ,\n");
			sbSql.append("                    b.trans_date, b.trans_date AS mg_date, b.source_type, '조정' as mvt, b.trans_type,\n");
			sbSql.append("                    b.trans_qty, b.unit_price                               /* 사용 X */\n");
			sbSql.append("                                              ,\n");
			sbSql.append("                     b.trans_mprice                                          /* 사용 X */\n");
			sbSql.append("                                   ,\n");
			sbSql.append("                      b.trans_mvat                                            /* 사용 X */\n");
			sbSql.append("                                 ,\n");
			sbSql.append("                     b.margin_price                                          /* 사용 X */\n");
			sbSql.append("                                   ,\n");
			sbSql.append("                     b.unit_amount AS unit_amount                            /* 사용 X */\n");
			sbSql.append("                                                 ,\n");
			sbSql.append("                      b.trans_mamount AS trans_mamount                        /* 사용 X */\n");
			sbSql.append("                                                     ,\n");
			sbSql.append("                     b.margin_amount                                         /* 사용 X */\n");
			sbSql.append("                                    ,\n");
			sbSql.append("                     b.margin_vat                                            /* 사용 X */\n");
			sbSql.append("                                  ,\n");
			sbSql.append("                      b.trans_mu_cd, b.trans_dept_id,\n");
			sbSql.append("                      TO_CHAR (b.trans_upjang) AS trans_upjang, b.subinv_code, b.acctcd,\n");
			sbSql.append("                      b.item_code, b.item_name, b.item_size, b.tax_code, b.trans_uom,\n");
			sbSql.append("                      b.uom_code, NULL AS unit_rate                           /* 사용 X */\n");
			sbSql.append("                                                   ,\n");
			sbSql.append("                      TO_CHAR (b.custcd) AS custcd                            /* 매입처 */\n");
			sbSql.append("                                                  ,\n");
			sbSql.append("                      b.po_type, b.center_code, TO_CHAR (b.gano) AS gano,\n");
			sbSql.append("                      b.buddept_id                                            /* 사용 X */\n");
			sbSql.append("                                  ,\n");
			sbSql.append("                      b.sale_price, b.sale_amount, b.sale_vat, b.source_id,\n");
			sbSql.append("                      b.sale_price AS sal_evnt_price, b.sale_price AS sal_stra_price,\n");
			sbSql.append("                      b.sale_price AS sal_enco_price, b.sale_price AS sal_oper_price,\n");
			sbSql.append("                      b.remark, '' AS po_no, '' AS po_lno, '2' AS flag,\n");
			sbSql.append("                      b.trans_date AS trans_date2\n");
			sbSql.append("                 FROM fms_transaction b\n");
			sbSql.append("                 WHERE TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' )  A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANGV D \n");		
			
			/*
			sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG											\n");
		    sbSql.append("          FROM FMU_OP_RATE 																					\n");
		    sbSql.append("         WHERE 1=1 								\n");
// 		    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 								\n");
		    sbSql.append("           AND USE_YN = 'Y'																					\n");
		    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
		    sbSql.append("       ) C																									\n");
		    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG											\n");
		    sbSql.append("           FROM FMU_OP_RATE 																					\n");
		    sbSql.append("         WHERE 1=1 								\n");
// 		    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 								\n");
		    sbSql.append("            AND USE_YN = 'Y'																					\n");
		    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
		    sbSql.append("        ) CC 																									\n");
		    */
			if (sType.equals("001")){
				sbSql.append("     , FMS_SUBINVENTORY E \n");
			}	

			sbSql.append(" WHERE A.TRANS_UPJANG = D.UPJANG \n");

			//sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
			//sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			/*
			sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
	        sbSql.append("   AND A.TRANS_UPJANG = CC.UPJANG(+) \n");
	        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.ITEM_CLASS4 = CC.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
	        sbSql.append("   AND A.TRANS_DATE BETWEEN CC.SDATE(+) AND CC.EDATE(+) \n");
			*/
			if (sType.equals("001")){
				sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE \n");
			}	

			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (sType.equals("001")){
				//sbSql.append(" GROUP BY A.TRANS_UPJANG, D.UPJANGNM_DISP, E.SUBINV_NAME_DISP \n");
				sbSql.append(" GROUP BY A.TRANS_UPJANG, E.SUBINV_NAME_DISP, D.UPJANG, E.SUBINV_CODE \n");
				
				//if (!sOtCust.equals("")) {
				//	sbSql.append(" ORDER BY A.TRANS_UPJANG \n");
				//}
				
			}else{
				sbSql.append(" GROUP BY A.TRANS_DATE, D.UPJANG, A.SUBINV_CODE \n");

				//if (!sOtCust.equals("")) {
				//	sbSql.append(" ORDER BY A.TRANS_DATE \n");
				//}	
			}	
		}
		if (sOtCust.equals("")){
			sbSql.append(" UNION ALL \n");
		}	
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001")){
				sbSql.append("SELECT TO_CHAR(A.UPJANG) AS NEED_DATE_ORI, E.SUBINV_NAME_DISP AS NEED_DATE, D.UPJANG, E.SUBINV_CODE \n");
				//sbSql.append(" -- ************************************************************* \n");
			}else{
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE, D.UPJANG, A.SUBINV_CODE \n");
			}
			//sbSql.append("     , SUM(ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("               ELSE ROUND(A.PR_QTY * (A.SALE_PRICE) ) END\n");
			sbSql.append("              ) AS OP_AMOUNT\n");
			*/
			sbSql.append("         ,SUM(A.OP_AMOUNT) AS OP_AMOUNT \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_NOTAX\n");
			*/
			sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS OP_NOTAX \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE)) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * A.SALE_PRICE) END\n");
			sbSql.append("              ) AS OP_TAX\n");
			*/
			sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS OP_TAX \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_VAT\n");
			*/
			sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS OP_VAT \n");
			//sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
			/*
			sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
			sbSql.append("                    WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL\n");
			sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(CC.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL),CC.OP_PRICE))) \n");
			sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
			sbSql.append("              ) AS OP_TOT\n");
			*/
			sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS OP_TOT \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS OP_VAT1 \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS OP_TOT1 \n");

			//sbSql.append("  FROM FMP_OTCUST_PR A, FMS_UPJANG D \n");
			sbSql.append("           FROM (SELECT A.* , B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
			/*
			sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG									\n");
		    sbSql.append("          FROM FMU_OP_RATE 																					\n");
		    sbSql.append("         WHERE 1=1																							\n");
// 		    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 								\n");
		    sbSql.append("           AND USE_YN = 'Y'																					\n");
		    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
		    sbSql.append("       ) C																									\n");
		    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG									\n");
		    sbSql.append("           FROM FMU_OP_RATE 																					\n");
		    sbSql.append("         WHERE 1=1																							\n");
// 		    sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 								\n");
		    sbSql.append("            AND USE_YN = 'Y'																					\n");
		    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
		    sbSql.append("        ) CC 																									\n");
		    */
			//sbSql.append("     , FMU_OP_RATE C \n");
			if (sType.equals("001"))
				sbSql.append("     , FMS_SUBINVENTORY E \n");

			sbSql.append(" WHERE A.UPJANG = D.UPJANG \n");
			//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			//sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			/*
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = CC.UPJANG(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.ITEM_CLASS4 = CC.ITEM_CODE(+) \n");
	        sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
	        sbSql.append("   AND A.NEED_DATE BETWEEN CC.SDATE(+) AND CC.EDATE(+) \n");
			 */
			if (sType.equals("001")){
				sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE \n");
			}	

			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals("")){
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			}	
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001")){
				//sbSql.append(" GROUP BY A.UPJANG, E.SUBINV_NAME_DISP \n"); 
				sbSql.append(" GROUP BY A.UPJANG, E.SUBINV_NAME_DISP, D.UPJANG, E.SUBINV_CODE \n");
			}else{
				sbSql.append(" GROUP BY A.NEED_DATE, D.UPJANG, A.SUBINV_CODE \n");
			}	
		}
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n"); 
			sbSql.append(" GROUP BY A.NEED_DATE_ORI, A.NEED_DATE, A.UPJANG, A.SUBINV_CODE \n");
			sbSql.append(" ORDER BY A.NEED_DATE \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);
//System.out.println("ex==>@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{	System.out.println("ex==>"+ex.toString());
		ex.printStackTrace();
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
