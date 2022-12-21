<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00160E_T002.jsp
■ 프로그램명   : 주요상품주문 상품조회
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2008.01.21
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
		String strIndex     = nullToBlank(in_vl.getString("strIndex"));
		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
		
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
				//sbSql_tmp.append("            		KEYWORD LIKE '%' || '"+arrSameWord_tmp[i]+"' || '%'		  \n");
				sbSql_tmp.append("            		KEYWORD = '"+arrSameWord_tmp[i]+"'	  \n");
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
		
		String sUpjangGroup = null;
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT Z.SHOP_GRP_CD AS UPJANG_GRP FROM EPROCUSR.ESPSSHPORG Z WHERE Z.SYS_ID = '100' AND Z.COMP_CD = 'HFC' AND Z.SHOP_CD = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) +"' \n");
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		sUpjangGroup = rs.getString("UPJANG_GRP");
		rs.close();
		pstmt.close();
		
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		sbSql = new StringBuffer();
		String strQtyYn    = nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));
		
		//신청일자 가져오기
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT NVL((SELECT PR_DATE \n");
		sbSql.append("              FROM (SELECT PR_DATE FROM SO_PR \n"); 
		sbSql.append("                     WHERE NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
	    sbSql.append("		                 AND SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AND ROWNUM <= 1 \n");
		sbSql.append("                     UNION ALL \n");
		sbSql.append("                    SELECT PR_DATE FROM FMP_OTCUST_PR \n");
		sbSql.append("                     WHERE NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("		                 AND SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AND ROWNUM <= 1 \n");
		sbSql.append("                    ) \n");
		sbSql.append("             WHERE ROWNUM <= 1) \n");
		sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')) AS PR_DATE \n");
		sbSql.append("  FROM DUAL \n");
        
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		String sPrDate = rs.getString("PR_DATE");
		rs.close();
		pstmt.close();

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT /*주요상품 검색*/ T.* \n");
		sbSql.append("  FROM ( \n");
		
		sbSql.append("SELECT \n");
		sbSql.append("       (SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS3) AS CLASS_NAME3 \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , A.SALE_PRICE, NVL(B.DEF_QTY,0) AS PR_QTY, ROUND(A.SALE_PRICE * NVL(B.DEF_QTY,0)) AS SALE_AMOUNT \n");
		//LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
		sbSql.append("     , '002' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
		sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
		sbSql.append("     , A.OTCUSTCD \n");
		sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE \n");
		sbSql.append("     , DECODE(C.OP_RATE, NULL, D.OP_RATE, C.OP_RATE) AS OP_RATE \n");
		sbSql.append("     , ROUND(B.DEF_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                              THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("                              WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                              THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("                         ELSE A.SALE_PRICE END) AS OP_AMOUNT \n");
		sbSql.append("     , A.D_DAYS, A.D_TIMES \n");
		sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS) AS D_DAY_DISP \n");
		sbSql.append("     , A.IMAGE_PATH, DECODE(A.IMAGE_PATH,NULL,'N','Y') AS IMG_YN \n");
		sbSql.append("     , A.CONSUM_YN, A.CORN_YN, A.SPICE_YN \n");
		sbSql.append("     , A.APPLY_SD, A.VD_SN \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), '"+sPrDate+"', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS PO_STATUS \n");
		sbSql.append("     , FMP_ORDER_SCHL_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", A.CUSTCD, A.ITEM_CODE, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS FMP_STATUS \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS PO_WEEK_STATUS \n");
        //불용자재체크
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS UNUSE_YN  \n");
        //중지자재체크
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS VAL_STP_YN \n");
		sbSql.append("     , 'P' AS MOBILE_GUBUN \n");
		sbSql.append("     , A.ORIGIN_TYPE \n");
		sbSql.append("     , SCC_SOPR_AGG_FUN('" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "', A.ITEM_CODE, '1') AS MAX_SO_QTY \n");
		sbSql.append("     , A.UPJANG_GRP \n");
		//sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS ITEM_STOP \n"); // 구매불용자재체크
		
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");        
		sbSql.append("       SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("         FROM FMU_OP_RATE \n");
		sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN SDATE AND EDATE \n");
		sbSql.append("          AND USE_YN = 'Y' \n");
		sbSql.append("          AND ITEM_TYPE = 'M' \n");
		sbSql.append("       ) C \n");
		sbSql.append("      ,( \n");        
		sbSql.append("       SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("         FROM FMU_OP_RATE \n");
		sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN SDATE AND EDATE \n");
		sbSql.append("          AND USE_YN = 'Y' \n");
		sbSql.append("          AND ITEM_TYPE = 'C' \n");
		sbSql.append("       ) D \n");
		
		//sbSql.append("      , HLDC_PO_CENTER E \n");

		//주요상품
		if (strIndex.equals("1"))
		{
			sbSql.append("     ,(SELECT A.ITEM_CODE, SUM(A.PR_CNT) AS PR_CNT, 0 AS DEF_QTY \n");
			sbSql.append("         FROM (SELECT A.ITEM_CODE, COUNT(*) AS PR_CNT \n");
			sbSql.append("                 FROM SO_PR A \n");
			sbSql.append("                WHERE A.NEED_DATE BETWEEN TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-21,'YYYYMMDD') \n");
			sbSql.append("                                      AND TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-01,'YYYYMMDD') \n");
			sbSql.append("                  AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("                  AND A.SUBINV_CODE ='" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("                  AND A.LINE_STATUS NOT IN ('003','999') --신청취소 \n");
			sbSql.append("                GROUP BY A.ITEM_CODE \n");
			sbSql.append("                UNION ALL \n");
			sbSql.append("               SELECT A.ITEM_CODE, COUNT(*) AS PR_CNT \n");
			sbSql.append("                 FROM FMP_OTCUST_PR A \n");
			sbSql.append("                WHERE A.NEED_DATE BETWEEN TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-21,'YYYYMMDD') \n");
			sbSql.append("                                      AND TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-01,'YYYYMMDD') \n");
			sbSql.append("                  AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("                  AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("                  AND A.LINE_STATUS NOT IN ('003','999') --신청취소 \n");
			sbSql.append("                GROUP BY A.ITEM_CODE) A \n");
			sbSql.append("        GROUP BY A.ITEM_CODE \n");
			sbSql.append("       ) B \n");
		}
		//분류별
		else if (strIndex.equals("2"))
		{	
			sbSql.append("     ,(SELECT 0 AS DEF_QTY FROM DUAL) B \n");
		}	
		//즐겨찾기
		else if (strIndex.equals("3"))
		{
			sbSql.append("     ,(SELECT A.ITEM_CODE, A.DEF_QTY \n");
			sbSql.append("         FROM FMP_FAVORITE A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "' \n");
			sbSql.append("          AND A.USE_YN = 'Y' \n");
			sbSql.append("       ) B \n");
		}
		//지난발주
		else
		{
			sbSql.append("     ,(SELECT A.ITEM_CODE, 0 AS DEF_QTY -- A.PR_QTY AS DEF_QTY \n");
			sbSql.append("         FROM SO_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
			sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "' \n");
			sbSql.append("        UNION ALL \n");
			sbSql.append("       SELECT A.ITEM_CODE, 0 AS DEF_QTY -- A.PR_QTY AS DEF_QTY \n");
			sbSql.append("         FROM FMP_OTCUST_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
			sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
			sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "' \n");
			sbSql.append("       ) B \n");
		}
		sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
		sbSql.append("            , C.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE, C.POINT_FLAG \n");
		sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("            , DECODE(C.POINT_FLAG,'Y',DECODE(C.MIN_ORD_QTY,0,0,0.1),C.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("            , C.MAX_ORD_QTY \n");
			sbSql.append("            , DECODE(C.POINT_FLAG,'Y',DECODE(C.MULTIPLIER_QTY,0,0,0.1),C.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
   			sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		
		sbSql.append("            , '0000' AS OTCUSTCD \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
// 		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
// 		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
// 		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append(" 	            /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) ) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) AS D_DAYS \n");
		sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
		sbSql.append("            , C.IMG_PATH AS IMAGE_PATH \n");
		sbSql.append("            , C.CORN_YN, C.SPICE_YN \n");
		sbSql.append("            , A.APPLY_SD, A.VD_SN \n");
		sbSql.append("            , C.ORIGIN_TYPE \n");
		sbSql.append("            , A.UPJANG_GRP \n");
		sbSql.append("         FROM \n");
		sbSql.append("              (SELECT * \n");
		sbSql.append("                 FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("                WHERE 1=1 \n");
		
		sbSql.append("               AND (CENTER_CODE, CUSTCD, ITEM_CODE) NOT IN \n");
        sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
        sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
        sbSql.append("                       WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
        sbSql.append("                         AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
        sbSql.append("                         AND USE_YN = 'Y' \n");
        sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'), \n");
        sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
        sbSql.append("                       UNION ALL \n");
        sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
        sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
        sbSql.append("                       WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
        sbSql.append("                         AND UPJANG = -2 \n");
        sbSql.append("                         AND USE_YN = 'Y' \n");
        sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'), \n");
        sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
        sbSql.append("                       MINUS \n");
        sbSql.append("                      SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
        sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
        sbSql.append("                       WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
        sbSql.append("                         AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
        sbSql.append("                         AND USE_YN = 'Y' \n");
        sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'), \n");
        sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y')) \n");
    	
		sbSql.append("              	AND CENTER_CODE = '" + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + "' \n");
		sbSql.append("              	AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                  AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN CONTRACT_START AND NVL(CONTRACT_END, '99999999') \n");
		// 2015.07.30 구매 단가 계약 테이블 조인(금지자재체크)		
	    sbSql.append("                  AND EXISTS (SELECT 1 FROM HLDC_PO_CONTRACT_F 					\n");
	    sbSql.append("                  					WHERE CENTER_CODE = '" + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + "'			\n");
	    sbSql.append("										AND UPJANG = "+ nullToBlank(ds_cond.getString(0, "UPJANG")) +" 						\n");
	    sbSql.append("										AND ITEM_CODE = A.ITEM_CODE 				\n");
	    sbSql.append("										AND CONTRACT_PRICE > 0 						\n");
	    sbSql.append("										AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN CONTRACT_START AND CONTRACT_END	\n"); 
	    //sbSql.append("										AND UPJANG_GRP IN ( SELECT Z.SHOP_GRP_CD AS UPJANG_GRP FROM EPROCUSR.ESPSSHPORG Z WHERE Z.SYS_ID = '100' AND Z.COMP_CD = 'HFC' AND Z.SHOP_CD = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) +"' ) \n");
	    if ( !"".equals(sUpjangGroup) ) {
	    	sbSql.append("										AND UPJANG_GRP = '" + sUpjangGroup + "' \n");
	    }
	    sbSql.append("								) \n");
	    		
		sbSql.append("              ) A \n");
		sbSql.append("            , HLDC_PO_ITEM_MST C \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		sbSql.append("          AND C.ITEM_CLASS1 = 'F' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
		sbSql.append("            , C.TAX_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
		sbSql.append("            , '0' AS CENTER_CODE, C.POINT_FLAG \n");
		sbSql.append("            , A.UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		sbSql.append("            , C.OTCUSTCD \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
		sbSql.append("            , C.SIMAGE_PATH AS IMAGE_PATH \n");
		sbSql.append("            , C.CORN_YN, C.SPICE_YN \n");
		sbSql.append("            , '' AS APPLY_SD, '' AS VD_SN \n");
		sbSql.append("            , C.ORIGIN_TYPE \n");
		sbSql.append("            , '' AS UPJANG_GRP \n");
		sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("               WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "OTCUST_PRICE_UPJANG")) + " \n");
		sbSql.append("                 AND SDATE <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("               GROUP BY UPJANG, ITEM_CODE) B \n");
		sbSql.append("            , FMP_OTCUST_ITEM C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.SDATE = B.SDATE \n");
		sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("      ) A \n");
		sbSql.append(" WHERE 1 = 1 \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		//sbSql.append("   AND A.CENTER_CODE = E.CENTER_CODE \n");
		
		if (strIndex.equals("1"))
		{
			sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
			//sbSql.append("   AND A.ITEM_NAME LIKE '%'||'" + nullToBlank(ds_cond.getString(0, "ITEM_NAME")) + "'||'%' \n");
			if (! ds_cond.getString(0, "ITEM_NAME").equals("")) {
				sbSql.append("   AND (		\n");
			
				for(int i=0; i<strKeyword_ItemName.length; i++) {
					sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
					sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
					if(i < strKeyword_ItemName.length-1) {
						sbSql.append("  OR \n");
					}
				}
				sbSql.append("   	 ) \n");
			}
		}
		else if (strIndex.equals("2"))
		{
			sbSql.append("   AND A.ITEM_CLASS2 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS2")) + "',A.ITEM_CLASS2) \n");
			sbSql.append("   AND A.ITEM_CLASS3 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS3")) + "',A.ITEM_CLASS3) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS4")) + "',A.ITEM_CLASS4) \n");
			//sbSql.append("   AND A.ITEM_NAME LIKE '%'||'" + nullToBlank(ds_cond.getString(0, "ITEM_NAME")) + "'||'%' \n");
			//TODO
			if (! ds_cond.getString(0, "ITEM_NAME").equals("")) {
				sbSql.append("   AND (		\n");
			
				for(int i=0; i<strKeyword_ItemName.length; i++) {
					sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
					sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
					if(i < strKeyword_ItemName.length-1) {
						sbSql.append("  OR \n");
					}
				}
				sbSql.append("   	 ) \n");
			}
		}
		else
		{
			sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
		}
		sbSql.append("   AND A.D_DAYS <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
		sbSql.append("   AND NOT EXISTS \n");
		sbSql.append("      (SELECT 1 FROM FMP_ORD_LIMIT Z \n");
		sbSql.append("        WHERE Z.UPJANG = A.UPJANG \n");
		sbSql.append("          AND Z.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN Z.SDATE AND Z.EDATE \n");
		sbSql.append("          AND Z.USE_YN = 'Y') \n");
		
		
		if (strIndex.equals("1"))
			sbSql.append(" ORDER BY NVL(B.PR_CNT,0) DESC, A.ITEM_CODE \n");
		else
			sbSql.append(" ORDER BY A.ITEM_CODE \n");
		
		sbSql.append("      ) T \n");
		sbSql.append(" WHERE T.OTCUSTCD != '0000' OR (T.PO_STATUS = 'HK' AND T.FMP_STATUS = 'N' AND T.PO_WEEK_STATUS = 'XR') \n"); // 구매_발주가능, 식재_발주가능
        sbSql.append("   AND T.UNUSE_YN <> 'UK' \n"); // 구매 불용자재 
        sbSql.append("   AND T.VAL_STP_YN <> 'TK' \n"); // 구매 중지자재 체크
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
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
		String strIndex     = nullToBlank(in_vl.getString("strIndex"));
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String strQtyYn    = nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));

		//내역조회
		sbSql.append("SELECT /*주요상품 검색*/ (SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS3) AS CLASS_NAME3 \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , A.SALE_PRICE, NVL(B.DEF_QTY,0) AS PR_QTY, ROUND(A.SALE_PRICE * NVL(B.DEF_QTY,0)) AS SALE_AMOUNT \n");
		sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
		sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
		sbSql.append("     , A.OTCUSTCD \n");
		//sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE \n");
		//sbSql.append("     , ROUND(NVL(B.DEF_QTY,0) * DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE)) AS OP_AMOUNT \n");
		sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) * B.DEF_QTY) AS OP_AMOUNT \n");
		sbSql.append("     , A.D_DAYS, A.D_TIMES \n");
		sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS) AS D_DAY_DISP \n");
		sbSql.append("     , A.IMAGE_PATH, DECODE(A.IMAGE_PATH,NULL,'N','Y') AS IMG_YN \n");
		sbSql.append("     , A.CONSUM_YN, A.CORN_YN, A.SPICE_YN \n");
		sbSql.append("  FROM FMU_OP_RATE C \n");
		//주요상품
		if (strIndex.equals("1"))
		{
			sbSql.append("     ,(SELECT A.ITEM_CODE, SUM(A.PR_CNT) AS PR_CNT, 0 AS DEF_QTY \n");
			sbSql.append("         FROM (SELECT A.ITEM_CODE, COUNT(*) AS PR_CNT \n");
			sbSql.append("                 FROM HLDC_PO_PR A \n");
			sbSql.append("                WHERE A.NEED_DATE BETWEEN TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-21,'YYYYMMDD') \n");
			sbSql.append("                                      AND TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-01,'YYYYMMDD') \n");
			sbSql.append("                  AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("                  AND A.SUBINV_CODE ='" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("                  AND A.LINE_STATUS <> '003' --신청취소 \n");
			sbSql.append("                GROUP BY A.ITEM_CODE \n");
			sbSql.append("                UNION ALL \n");
			sbSql.append("               SELECT A.ITEM_CODE, COUNT(*) AS PR_CNT \n");
			sbSql.append("                 FROM FMP_OTCUST_PR A \n");
			sbSql.append("                WHERE A.NEED_DATE BETWEEN TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-21,'YYYYMMDD') \n");
			sbSql.append("                                      AND TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD')-01,'YYYYMMDD') \n");
			sbSql.append("                  AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("                  AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("                  AND A.LINE_STATUS <> '003' --신청취소 \n");
			sbSql.append("                GROUP BY A.ITEM_CODE) A \n");
			sbSql.append("        GROUP BY A.ITEM_CODE) B \n");
		}
		//분류별
		else if (strIndex.equals("2"))
			sbSql.append("     ,(SELECT 0 AS DEF_QTY FROM DUAL) B \n");
		//즐겨찾기
		else if (strIndex.equals("3"))
		{
			sbSql.append("     ,(SELECT A.ITEM_CODE, A.DEF_QTY \n");
			sbSql.append("         FROM FMP_FAVORITE A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "' \n");
			sbSql.append("          AND A.USE_YN = 'Y') B \n");
		}
		//지난발주
		else
		{
			sbSql.append("     ,(SELECT A.ITEM_CODE, 0 AS DEF_QTY -- A.PR_QTY AS DEF_QTY \n");
			sbSql.append("         FROM HLDC_PO_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
			sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "' \n");
			sbSql.append("        UNION ALL \n");
			sbSql.append("       SELECT A.ITEM_CODE, 0 AS DEF_QTY -- A.PR_QTY AS DEF_QTY \n");
			sbSql.append("         FROM FMP_OTCUST_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
			sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
			sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "') B \n");
		}
		sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
		sbSql.append("            , C.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE, C.POINT_FLAG \n");
		sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("            , DECODE(C.POINT_FLAG,'Y',DECODE(C.MIN_ORD_QTY,0,0,0.1),C.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("            , C.MAX_ORD_QTY \n");
			sbSql.append("            , DECODE(C.POINT_FLAG,'Y',DECODE(C.MULTIPLIER_QTY,0,0,0.1),C.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
   		sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		sbSql.append("            , '0000' AS OTCUSTCD \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
		sbSql.append("            , C.IMG_PATH AS IMAGE_PATH \n");
		sbSql.append("            , C.CORN_YN, C.SPICE_YN \n");
		sbSql.append("         FROM \n");
		sbSql.append("             (SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */  * \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE (CENTER_CODE, CUSTCD, ITEM_CODE) NOT IN \n");
		sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
		sbSql.append("                        FROM HLDC_PO_ORDER_SCHEDULE \n");
		sbSql.append("                       WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                         AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                         AND USE_YN = 'Y' \n");
		sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'), \n");
		sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
		sbSql.append("                       UNION ALL \n");
		sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
		sbSql.append("                        FROM HLDC_PO_ORDER_SCHEDULE \n");
		sbSql.append("                       WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                         AND UPJANG = -2 \n");
		sbSql.append("                         AND USE_YN = 'Y' \n");
		sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'), \n");
		sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
		sbSql.append("                       MINUS \n");
		sbSql.append("                      SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
		sbSql.append("                        FROM HLDC_PO_ORDER_SCHEDULE \n");
		sbSql.append("                       WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                         AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                         AND USE_YN = 'Y' \n");
		sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'), \n");
		sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y')) \n");
		sbSql.append("             ) A \n");
		sbSql.append("            ,(SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */ \n");
		sbSql.append("                     CENTER_CODE, UPJANG, ITEM_CODE, MAX(CONTRACT_START) AS CONTRACT_START \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                 AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                 AND ITEM_CODE > ' ' \n");
		sbSql.append("                 AND CONTRACT_START <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("               GROUP BY CENTER_CODE, UPJANG, ITEM_CODE) B \n");
		sbSql.append("            , HLDC_PO_ITEM_MST C \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("        WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("          AND A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.CONTRACT_START = B.CONTRACT_START \n");
		sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		sbSql.append("          AND C.ITEM_CODE BETWEEN '010000000000' AND '019999999999' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
		sbSql.append("            , C.TAX_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
		sbSql.append("            , 0 AS CENTER_CODE, C.POINT_FLAG \n");
		sbSql.append("            , A.UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		sbSql.append("            , C.OTCUSTCD \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
		sbSql.append("            , C.SIMAGE_PATH AS IMAGE_PATH \n");
		sbSql.append("            , C.CORN_YN, C.SPICE_YN \n");
		sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("               WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "OTCUST_PRICE_UPJANG")) + " \n");
		sbSql.append("                 AND SDATE <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("               GROUP BY UPJANG, ITEM_CODE) B \n");
		sbSql.append("            , FMP_OTCUST_ITEM C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.SDATE = B.SDATE \n");
		sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("      ) A \n");
		sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
		if (strIndex.equals("1"))
		{
			sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_NAME LIKE '%'||'" + nullToBlank(ds_cond.getString(0, "ITEM_NAME")) + "'||'%' \n");
		}
		else if (strIndex.equals("2"))
		{
			sbSql.append("   AND A.ITEM_CLASS2 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS2")) + "',A.ITEM_CLASS2) \n");
			sbSql.append("   AND A.ITEM_CLASS3 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS3")) + "',A.ITEM_CLASS3) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS4")) + "',A.ITEM_CLASS4) \n");
			sbSql.append("   AND A.ITEM_NAME LIKE '%'||'" + nullToBlank(ds_cond.getString(0, "ITEM_NAME")) + "'||'%' \n");
		}
		else
		{
			sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
		}
		sbSql.append("   AND A.D_DAYS <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
		sbSql.append("   AND NOT EXISTS \n");
		sbSql.append("      (SELECT 1 FROM FMP_ORD_LIMIT Z \n");
		sbSql.append("        WHERE Z.UPJANG = A.UPJANG \n");
		sbSql.append("          AND Z.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("          AND A.NEED_DATE BETWEEN Z.SDATE AND Z.EDATE \n");
		sbSql.append("          AND Z.USE_YN = 'Y') \n");
		if (strIndex.equals("1"))
			sbSql.append(" ORDER BY NVL(B.PR_CNT,0) DESC, A.ITEM_CODE \n");
		else
			sbSql.append(" ORDER BY A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
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

--%>
