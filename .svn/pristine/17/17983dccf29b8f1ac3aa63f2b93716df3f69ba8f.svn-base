<%
//-----------------------------------------------------------------------------
//■ 시스템명          : 식재영업/수불관리/실적관리/상품별 거래실적 조회
//■ 프로그램ID   : FMP00722V_T001.jsp
//■ 프로그램명       : 상품별 거래 실적 조회(순수 상품 별 집계) 
//■ 작성일자          : 2010.02.01
//■ 작성자              : 노규완
//■ 이력관리           : 2010.02.01
//-----------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);

		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
/***		
		if(!nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals(""))
		{
			String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
			
			sbSql_tmp.append("SELECT LISTAGG(T.ITEM_NAME, ',') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME \n");
			sbSql_tmp.append("  FROM ( SELECT KEYWORD||','||SIM_TXT AS ITEM_NAME                              \n");
			sbSql_tmp.append("              , '1' AS ITEM_GROUP                                               \n");
			sbSql_tmp.append("           FROM EPROCUSR.VO_ITEM_SIM_WORD                                       \n");
			sbSql_tmp.append("          WHERE 1=1 															  \n");
			sbSql_tmp.append("            AND  ( 															  \n");
			for(int i=0; i<arrSameWord_tmp.length; i++) {
				sbSql_tmp.append("            		KEYWORD LIKE '%' || '"+arrSameWord_tmp[i]+"' || '%'		  \n");
				if(i < arrSameWord_tmp.length-1) {
					sbSql_tmp.append("  		OR 															  \n");
				}
			}
			sbSql_tmp.append("    				) 															  \n");
			sbSql_tmp.append("       ) T                                                                      \n");
			
			out_vl.add("fa_Sql", sbSql_tmp.toString());
			
			pstmt = conn.prepareStatement(sbSql_tmp.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {				
				strKeyword += nullToBlank(rs.getString("ITEM_NAME"));
				for (int i=0; i<arrSameWord_tmp.length; i++) {
					if ( strKeyword.indexOf(arrSameWord_tmp[i]) == -1 ) { //중복제거
						if ( strKeyword.length() > 0 ) {
							strKeyword += ","; 
						}
						strKeyword += arrSameWord_tmp[i];	
					}
				}
			}				
			rs.close();
			pstmt.close();
		}
		String[] strKeyword_ItemName = strKeyword.split(",");
***/		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtcustcd = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSubinv_Code = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));		
		String sTax = nullToBlank(ds_cond.getString(0, "TAX_CODE"));
		String sItemName = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		String sFavor_Group = nullToBlank(ds_cond.getString(0, "FAVOR_GROUP"));
		String sChk_Date = nullToBlank(ds_cond.getString(0, "CHK_DATE"));	
		String sSabun = nullToBlank(ds_cond.getString(0, "SABUN"));
		String schOrderType = nullToBlank(ds_cond.getString(0, "SCH_ORDER_TYPE"));
		
		//내역조회
		if (sOtcustcd.equals(""))
		{			
			sbSql.append( "SELECT ITEM_NAME \n");
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{				
				sbSql.append( "     , TRANS_DATE  \n");				
				//sbSql.append( "     , ITEM_CODE   \n");				
			}
			/* else //입고일 제외하여 조회 시...
			{
				sbSql.append( "     , ITEM_CODE  \n");				
			}		 */
			
			sbSql.append( "     , ITEM_CODE , (SELECT WIN_ITEM_CD FROM EPROCUSR.ESMMTGL E WHERE E.ITEM_CD= ITEM_CODE AND E.SYS_ID = '100' ) AS WIN_ITEM_CD   \n");		
			
			/*원산지 추가 -> 20150528 김진희 매니저 요청*/
			sbSql.append("      , ORIGIN_TYPE \n");
			sbSql.append( "     , ITEM_SIZE \n");
			sbSql.append( "     , PO_UOM, TAX_CODE \n");
			sbSql.append( "     , ROUND(SUM(NVL(IN_PRICE,0)) / DECODE(SIGN(SUM(NVL(PR_QTY,0))), -1,SUM(NVL(PR_QTY,0)), 0, 1, 1,SUM(NVL(PR_QTY,0))),2) AS SALE_PRICE  \n");
			sbSql.append( "     , ROUND(SUM(NVL(IN_PRICE1,0)) / DECODE(SIGN(SUM(NVL(PR_QTY,0))), -1,SUM(NVL(PR_QTY,0)), 0, 1, 1,SUM(NVL(PR_QTY,0))),2) AS SALE_PRICE1  \n");
			sbSql.append( "     , SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
			sbSql.append( "     , SUM(NVL(IN_PRICE,0)) AS IN_PRICE \n");
			sbSql.append( "     , SUM(NVL(IN_PRICE1,0)) AS IN_PRICE1 \n");
			sbSql.append( "     , SUM(NVL(TAX_AMOUNT,0)) AS TAX_AMOUNT \n");
			sbSql.append( "     , SUM(NVL(TAX_AMOUNT1,0)) AS TAX_AMOUNT1 \n");
			sbSql.append( "     , SUM(NVL(IN_AMOUNT,0)) AS IN_AMOUNT \n");	
			sbSql.append( "     , SUM(NVL(IN_AMOUNT1,0)) AS IN_AMOUNT1 \n");
			sbSql.append("      , ORDER_TYPE  \n");/*주문유형*/
			sbSql.append("      ,   CASE WHEN ORDER_TYPE = 'S' THEN '일반' \n");
			sbSql.append("               WHEN ORDER_TYPE = '5' THEN '반환' \n");
			sbSql.append("               WHEN ORDER_TYPE = '6' THEN '교환' \n");
			sbSql.append("               WHEN ORDER_TYPE = '7' THEN '증정' \n");
			sbSql.append("               ELSE '기타'  \n");
			sbSql.append("           END AS ORDER_TYPE_NM   \n");     /* 주문유형명 */
			sbSql.append( "  FROM \n");
			sbSql.append( "( \n");
		}
		if (sOtcustcd.equals("") || sOtcustcd.equals("0000"))		
		{			
			sbSql.append( "SELECT C.UPJANGNM_DISP \n");
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{				
				sbSql.append( "     , SUBSTR(A.TRANS_DATE,1,4)||'-'||SUBSTR(A.TRANS_DATE,5,2)||'-'||SUBSTR(A.TRANS_DATE,7,2) AS TRANS_DATE \n");
				sbSql.append( "     , TO_CHAR(A.TRANS_UPJANG) AS UPJANG \n");				
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( "     , TO_CHAR(A.TRANS_UPJANG) AS UPJANG \n");				
			}		
			/*원산지 추가 -> 20150528 김진희 매니저 요청*/
			sbSql.append("      , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			sbSql.append( "     , A.ITEM_CODE \n");
			
				if(sbSql.indexOf("WIN_ITEM_CD") < 0) {
					sbSql.append( "  , (SELECT WIN_ITEM_CD FROM EPROCUSR.ESMMTGL E WHERE E.ITEM_CD= A.ITEM_CODE AND E.SYS_ID = '100' ) AS WIN_ITEM_CD \n " ) ; 
				}
			
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , A.TRANS_UOM AS PO_UOM \n");				
			sbSql.append( "     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS SALE_PRICE \n");		
			sbSql.append( "     , A.SAL_OPER_PRICE AS SALE_PRICE1 \n");
			sbSql.append( "     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS PR_QTY \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) AS IN_PRICE \n");		
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SAL_OPER_PRICE * A.TRANS_QTY)) AS IN_PRICE1 \n");	
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS TAX_AMOUNT \n");
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SAL_OPER_PRICE * A.TRANS_QTY)))  AS TAX_AMOUNT1 \n");
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS IN_AMOUNT \n");
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SAL_OPER_PRICE * A.TRANS_QTY)) + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SAL_OPER_PRICE * A.TRANS_QTY)))  AS IN_AMOUNT1 \n");
			sbSql.append("      ,(SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS C WHERE A.ITEM_CLASS2 = C.CLASS_CODE)\n");
			sbSql.append("         AS CLASS2_NAME \n");
			sbSql.append("      , ORDER_TYPE  \n");
			sbSql.append("        ,   CASE WHEN ORDER_TYPE = 'S' THEN '일반' \n");
			sbSql.append("                 WHEN ORDER_TYPE = '5' THEN '반환' \n");
			sbSql.append("                 WHEN ORDER_TYPE = '6' THEN '교환' \n");
			sbSql.append("                 WHEN ORDER_TYPE = '7' THEN '증정' \n");
			sbSql.append("                 ELSE '기타'  \n");
			sbSql.append("             END AS ORDER_TYPE_NM   \n");     /* 주문유형명 */
			//sbSql.append( "  FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A,  FMS_UPJANG C \n");
			//속도개선, 뷰 해체 20170504
			sbSql.append( "  FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS2, B.ITEM_CLASS4, SUBSTR(NVL(RTN.PO_TYPE, 'S'), 1, 1)  AS ORDER_TYPE /* 판매구분 */ FROM   \n");			
			sbSql.append( "               (SELECT a.pr_id, a.pr_num, a.trans_id, a.trans_date, a.mg_date, a.source_type, a.mvt, a.trans_type,\n");
			sbSql.append( "                     a.trans_qty, a.unit_price, a.trans_mprice, a.trans_mvat,  \n");
			sbSql.append( "                    a.margin_price, a.unit_amount, a.trans_mamount, a.margin_amount,\n");
			sbSql.append( "                    a.margin_vat, a.trans_mu_cd, a.trans_dept_id, a.trans_upjang, \n");
			sbSql.append( "                    a.subinv_code, a.acctcd, a.item_code, a.item_name, a.item_size,\n");
			sbSql.append( "                    a.tax_code, a.trans_uom, a.uom_code, a.unit_rate, a.custcd,\n");
			sbSql.append( "                    a.po_type, a.center_code, a.gano, a.buddept_id, a.sale_price,\n");
			sbSql.append( "                   a.sale_amount, a.sale_vat, source_id, a.sal_evnt_price,\n");
		    sbSql.append( "                    a.sal_stra_price, a.sal_enco_price, a.sal_oper_price, '' AS remark,\n");
		    sbSql.append( "                    a.po_no, a.po_lno, '1' AS flag,\n");
			/*
		    sbSql.append( "                  DECODE (SUBSTR (a.trans_date, 1, 6),\n");
			sbSql.append( "                            SUBSTR (a.mg_date, 1, 6), a.trans_date,\n");
			sbSql.append( "                           a.mg_date\n");
			sbSql.append( "                          ) AS trans_date2\n");
			*/
			sbSql.append( "                          TRANS_DATE2 \n");
			sbSql.append( "              FROM eprocusr.vo_po_transaction_sale a,\n");
			sbSql.append( "                    FMS_UPJANGV B\n");
			sbSql.append( "             WHERE A.TRANS_UPJANG = B.UPJANG\n");
			sbSql.append( "               AND TRANS_DATE2 BETWEEN  '" + sSdate + "' AND '" + sEdate + "' \n");
			sbSql.append( "               AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			   if ( !sMainUpjang.equals(""))
					sbSql.append( "   AND B.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");
				if ( !sUpjang.equals(""))								
					sbSql.append( "   AND B.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			sbSql.append( "            UNION ALL\n");
			
			
			sbSql.append( "               SELECT a.pr_id, a.pr_num, a.trans_id, a.trans_date, a.mg_date, a.source_type, a.mvt, a.trans_type,\n");
			sbSql.append( "                     a.trans_qty, a.unit_price, a.trans_mprice, a.trans_mvat,  \n");
			sbSql.append( "                    a.margin_price, a.unit_amount, a.trans_mamount, a.margin_amount,\n");
			sbSql.append( "                    a.margin_vat, a.trans_mu_cd, a.trans_dept_id, a.trans_upjang, \n");
			sbSql.append( "                    a.subinv_code, a.acctcd, a.item_code, a.item_name, a.item_size,\n");
			sbSql.append( "                    a.tax_code, a.trans_uom, a.uom_code, a.unit_rate, a.custcd,\n");
			sbSql.append( "                    a.po_type, a.center_code, a.gano, a.buddept_id, a.sale_price,\n");
			sbSql.append( "                   a.sale_amount, a.sale_vat, source_id, a.sal_evnt_price,\n");
		    sbSql.append( "                    a.sal_stra_price, a.sal_enco_price, a.sal_oper_price, '' AS remark,\n");
		    sbSql.append( "                    a.po_no, a.po_lno, '1' AS flag,\n");
			/*
		    sbSql.append( "                  DECODE (SUBSTR (a.trans_date, 1, 6),\n");
			sbSql.append( "                            SUBSTR (a.mg_date, 1, 6), a.trans_date,\n");
			sbSql.append( "                           a.mg_date\n");
			sbSql.append( "                          ) AS trans_date2\n");
			*/
			sbSql.append( "                          TRANS_DATE2 \n");
			sbSql.append( "              FROM eprocusr.vo_po_transaction_sale_rtn a,\n");
			sbSql.append( "                    FMS_UPJANGV B\n");
			sbSql.append( "             WHERE A.TRANS_UPJANG = B.UPJANG\n");
			sbSql.append( "               AND TRANS_DATE2 BETWEEN  '" + sSdate + "' AND '" + sEdate + "' \n");
			sbSql.append( "               AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			   if ( !sMainUpjang.equals(""))
					sbSql.append( "   AND B.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");
				if ( !sUpjang.equals(""))								
					sbSql.append( "   AND B.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			sbSql.append( "            UNION ALL\n");
			
			
			sbSql.append( "            SELECT to_number('') as pr_id, '' as pr_num, b.trans_id   ,\n");
			sbSql.append( "                  b.trans_date, b.trans_date AS mg_date, b.source_type, '조정' as mvt, b.trans_type,\n");
			sbSql.append( "                  b.trans_qty, b.unit_price  ,                             /* 사용 X */\n");
			sbSql.append( "                   b.trans_mprice,                                          /* 사용 X */\n");
			sbSql.append( "                    b.trans_mvat ,                                           /* 사용 X */\n");
			sbSql.append( "                   b.margin_price ,                                         /* 사용 X */\n");
			sbSql.append( "                   b.unit_amount AS unit_amount,                            /* 사용 X */\n");
			sbSql.append( "                    b.trans_mamount AS trans_mamount  ,                      /* 사용 X */\n");
			sbSql.append( "                   b.margin_amount    ,                                     /* 사용 X */\n");
			sbSql.append( "                   b.margin_vat  ,   \n");
			sbSql.append( "                    b.trans_mu_cd, b.trans_dept_id,\n");
			sbSql.append( "                   TO_CHAR (b.trans_upjang) AS trans_upjang, b.subinv_code, b.acctcd,\n");
			sbSql.append( "                    b.item_code, b.item_name, b.item_size, b.tax_code, b.trans_uom,\n");
			sbSql.append( "                    b.uom_code, NULL AS unit_rate   ,\n");
			sbSql.append( "                    TO_CHAR (b.custcd) AS custcd ,\n");
			sbSql.append( "                    b.po_type, b.center_code, TO_CHAR (b.gano) AS gano,\n");
			sbSql.append( "                    b.buddept_id    ,\n");
			sbSql.append( "                    b.sale_price, b.sale_amount, b.sale_vat, b.source_id,\n");
			sbSql.append( "                    b.sale_price AS sal_evnt_price, b.sale_price AS sal_stra_price,\n");
			sbSql.append( "                    b.sale_price AS sal_enco_price, b.sale_price AS sal_oper_price,\n");
			sbSql.append( "                    b.remark, '' AS po_no, '' AS po_lno, '2' AS flag,\n");
			sbSql.append( "                    b.trans_date AS trans_date2\n");
			sbSql.append( "               FROM fms_transaction b\n");
			sbSql.append( "               WHERE TRANS_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "')A LEFT OUTER JOIN SO_PR_RTN RTN 		  \n");	
			sbSql.append( "        																						ON A.PR_ID   = RTN.PR_ID  \n");	
			sbSql.append( "       																					   AND A.PR_NUM  = RTN.PR_NUM \n");	 		
			sbSql.append( "  , FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A,  FMS_UPJANG C \n");			
						
			sbSql.append( " WHERE A.TRANS_UPJANG = C.UPJANG");
			sbSql.append( "   AND A.TRANS_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append( "   AND A.SUBINV_CODE LIKE 'S1%' \n");
			if ( !sMainUpjang.equals(""))
				sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");			
			if ( !sUpjang.equals(""))								
				sbSql.append( "   AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			if ( !sSubinv_Code.equals(""))							
				sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			if ( !sTax.equals(""))							
				sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
			
			
			
// 			if ( !sItemName.equals("")) {							
// 				sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
// 			}	
			if ( !sItemName.equals("")) {
				sbSql.append("   AND (		\n");
/***			
				for(int i=0; i<strKeyword_ItemName.length; i++) {
					sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
					sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
					if(i < strKeyword_ItemName.length-1) {
						sbSql.append("  OR \n");
					}
				}
***/
				String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
				for(int i=0; i<arrSameWord_tmp.length; i++) {
					if ( arrSameWord_tmp[i].indexOf("F") == 0 ) {
						sbSql.append("            		A.ITEM_CODE LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
					} else {
						sbSql.append("            		A.ITEM_NAME LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");	
					}
					
					if(i < arrSameWord_tmp.length-1) {
						sbSql.append("  		OR 															  \n");
					}
				}

				sbSql.append("   	 ) \n");
				//sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
			}
			
			
			
			if ( !sFavor_Group.equals(""))
				sbSql.append( "   AND A.ITEM_CODE IN (SELECT ITEM_CODE FROM FMP_FAVORITE WHERE UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' AND FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "') \n");
			
			/* 검색 조건 : 판매구분 */
			if(!schOrderType.equals("")){
				sbSql.append( "AND ORDER_TYPE LIKE '"+schOrderType+"' || '%' \n");
			}
			
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{				
				sbSql.append( " GROUP BY A.TRANS_DATE, A.TRANS_UPJANG, C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE, A.SAL_OPER_PRICE, A.ORIGIN_TYPE, A.ITEM_CLASS2, ORDER_TYPE \n");
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( " GROUP BY A.TRANS_UPJANG, C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE, A.SAL_OPER_PRICE, A.ORIGIN_TYPE, A.ITEM_CLASS2, ORDER_TYPE \n");				
			}			
		}
		if (sOtcustcd.equals(""))		
			sbSql.append( "  UNION ALL \n");
		if (sOtcustcd.equals("") || (! sOtcustcd.equals("0000")))		
		{			
			sbSql.append( "SELECT C.UPJANGNM_DISP \n");			
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{				
				sbSql.append( "     , SUBSTR(A.NEED_DATE,1,4)||'-'||SUBSTR(A.NEED_DATE,5,2)||'-'||SUBSTR(A.NEED_DATE,7,2) AS TRANS_DATE  \n");
				sbSql.append( "     , TO_CHAR(A.UPJANG) AS UPJANG  \n");
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( "     , TO_CHAR(A.UPJANG) AS UPJANG  \n");				
			}			
			/*원산지 추가 -> 20150528 김진희 매니저 요청*/
			sbSql.append("      , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			sbSql.append( "     , A.ITEM_CODE \n");
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , A.PO_UOM \n");
			sbSql.append( "     , DECODE(A.TAX_CODE,'100''과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS  SALE_PRICE \n");		
			sbSql.append( "     , A.SALE_PRICE AS  SAL_OPER_PRICE \n");
			sbSql.append( "     , ROUND(SUM(A.PR_QTY)) AS PR_QTY \n");
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) AS IN_PRICE \n");			
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) AS IN_PRICE1 \n");		
			sbSql.append( "     , ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY)))  AS TAX_AMOUNT \n");
			sbSql.append( "     , ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY)))  AS TAX_AMOUNT1 \n");
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY))) AS IN_AMOUNT \n");
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY))) AS IN_AMOUNT1 \n");
			sbSql.append("      ,(SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS C WHERE A.ITEM_CLASS2 = C.CLASS_CODE)\n");
			sbSql.append("         AS CLASS2_NAME \n");
			sbSql.append("      , ORDER_TYPE \n");
			sbSql.append("        ,   CASE WHEN ORDER_TYPE = 'S' THEN '일반' \n");
			sbSql.append("                 WHEN ORDER_TYPE = '5' THEN '반환' \n");
			sbSql.append("                 WHEN ORDER_TYPE = '6' THEN '교환' \n");
			sbSql.append("                 WHEN ORDER_TYPE = '7' THEN '증정' \n");
			sbSql.append("                 ELSE '기타'  \n");
			sbSql.append("             END AS ORDER_TYPE_NM   \n");     /* 주문유형명 */
			sbSql.append( "  FROM (SELECT A.*, SUBSTR(NVL(RTN.PO_TYPE, 'S'), 1, 1)  AS ORDER_TYPE /* 판매구분 */ , B.ORIGIN_TYPE, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4  FROM FMP_OTCUST_PR A LEFT OUTER JOIN SO_PR_RTN RTN ON A.PR_ID = RTN.PR_ID AND A.PR_NUM = RTN.PR_NUM \n");
			sbSql.append( "  																																				    , FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG C \n");			
			sbSql.append( " WHERE A.UPJANG = C.UPJANG" );
			sbSql.append( "   AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			if ( !sMainUpjang.equals(""))
				sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");
			if ( !sUpjang.equals(""))								
				sbSql.append( "   AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			if ( !sSubinv_Code.equals(""))							
				sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			if (! sOtcustcd.equals(""))
				sbSql.append( "   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			if ( !sTax.equals(""))							
				sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
// 			if ( !sItemName.equals(""))							
// 				sbSql.append( "   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");	
			
			
			if ( !sItemName.equals("")) {
				sbSql.append("   AND (		\n");
/***			
				for(int i=0; i<strKeyword_ItemName.length; i++) {
					sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
					sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
					if(i < strKeyword_ItemName.length-1) {
						sbSql.append("  OR \n");
					}
				}
***/
				String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
				for(int i=0; i<arrSameWord_tmp.length; i++) {
					if (arrSameWord_tmp[i].indexOf("F") == 0 ) {
						sbSql.append("            		A.ITEM_CODE LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
					} else {
						sbSql.append("            		A.ITEM_NAME LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");	
					}
					
					if(i < arrSameWord_tmp.length-1) {
						sbSql.append("  		OR 															  \n");
					}
				}

				sbSql.append("   	 ) \n");
				//sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
			}
			
			
			sbSql.append( "   AND A.LINE_STATUS <> '003' \n");
			if ( !sFavor_Group.equals(""))
				sbSql.append( "   AND A.ITEM_CODE IN (SELECT ITEM_CODE FROM FMP_FAVORITE WHERE UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' AND FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "') \n");			
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{				
				sbSql.append( " GROUP BY A.NEED_DATE, A.UPJANG,C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE, A.ORIGIN_TYPE, A.ITEM_CLASS2, ORDER_TYPE \n");
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( " GROUP BY A.UPJANG,C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE, A.ORIGIN_TYPE, A.ITEM_CLASS2, ORDER_TYPE \n");				
			}
		}			
		
				
		if (sOtcustcd.equals(""))
		{
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{				
				sbSql.append( ")  \n");
			
				/* 검색 조건 : 판매구분 */
				if(!schOrderType.equals("")){
					sbSql.append( "WHERE ORDER_TYPE LIKE '"+schOrderType+"' || '%' \n");
				}
			
				sbSql.append( "GROUP BY TRANS_DATE, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX_CODE, ORIGIN_TYPE, ORDER_TYPE \n");
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( ")  \n");	
				
				/* 검색 조건 : 판매구분 */
				if(!schOrderType.equals("")){
					sbSql.append( "WHERE ORDER_TYPE LIKE '"+schOrderType+"' || '%' \n");
				}
				
				sbSql.append( "GROUP BY ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX_CODE, ORIGIN_TYPE, ORDER_TYPE \n");
			}			
		}
		
		if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
		{				
			sbSql.append(" ORDER BY TRANS_DATE, ITEM_CODE \n");
		}
		else //입고일 제외하여 조회 시...
		{
			sbSql.append(" ORDER BY ITEM_CODE \n");				
		}	
		
		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt = conn.prepareStatement("SELECT DECODE(COUNT(1), 0, 'N', 'Y') AS AUTH_YN FROM SCC_USER_ROLE_V WHERE SABUN = '"+sSabun+"' AND ROLE IN ('본사01', '본사02', '본부_CS사원', '본부_영업사원') AND ROLE_YN = 'Y' AND SYS_TYPE = 'FICS' AND MENU_ID = '2019'");		
		rs = pstmt.executeQuery(); 
		if(rs.next()) {
			out_vl.add("fv_authYn", nullToBlank(rs.getString("AUTH_YN")));	
		}
		
		pstmt.close();
		rs.close();

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