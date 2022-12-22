<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00130E_T001.jsp
■ 프로그램명   : 식단발주상품 조회
■ 작성일자     : 2008.02.11
■ 작성자       : 박은규
■ 이력관리     : 2008.02.11
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
		String sDocSrc      = nullToBlank(in_vl.getString("sDocSrc"));
		
		//FileLog.println("d:\\aaa.txt", ds_cond);
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
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
		
		//out 데이타
		DataSet ds_List;
    	String strQtyYn    = nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));

		//1)주문내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("\n  \n");
		sbSql.append("SELECT /*1. 주문내역조회*/ \n");
		sbSql.append("       A.* \n");
		sbSql.append("     , ROUND(B.DEF_QTY / 1000 / A.KG_CONVERT_RATE, 2) AS DEF_QTY \n");
		sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
		sbSql.append("     , DECODE(C.OP_RATE, NULL, D.OP_RATE, C.OP_RATE) AS OP_RATE \n");
		sbSql.append("     , ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                             THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("                             WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                             THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("                        ELSE A.SALE_PRICE END) AS OP_AMOUNT \n");
		sbSql.append("     , ROUND(A.PR_QTY * CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                             THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("                             WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                             THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("                        ELSE A.SALE_PRICE END) AS OP_AMOUNT_OLD \n");
		sbSql.append("     , DECODE(NVL(A.D_DAYS,0),0,'-','D-'||TO_CHAR(A.D_DAYS)) AS D_DAY_DISP \n");
		sbSql.append("     , DECODE(B.PR_ID,NULL,'N','Y') AS MENU_FLAG \n");
		sbSql.append("     , '저장' AS SAV_STAT \n");
		sbSql.append("     , 0 AS CHG_QTY \n");
		sbSql.append("     , DECODE(A.IMAGE_PATH,NULL,'N','Y') AS PIC_YN \n");
		sbSql.append("     , 'P' AS MOBILE_GUBUN \n");
		sbSql.append("     , SCC_SOPR_AGG_FUN(A.SUBINV_CODE, A.ITEM_CODE, '1') AS MAX_SO_QTY \n");
		
		
		
		
		
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), '"+sPrDate+"', '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"') AS PO_STATUS  \n");
		sbSql.append("     , FMP_ORDER_SCHL_FUN("+ nullToBlank(ds_cond.getString(0, "UPJANG")) +", A.CUSTCD, A.ITEM_CODE, '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"') AS FMP_STATUS		\n");
		sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"'), 'XR') AS PO_WEEK_STATUS		\n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS UNUSE_YN		\n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS VAL_STP_YN		\n");
		sbSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.UPJANG_GRP, A.ITEM_CODE, '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"')    = 'CK' THEN 'Y' ELSE 'N' END  AS SHP_MAP		\n");
		//sbSql.append("     , DECODE(PO_WEEK_STATUS, 'XR', '', A.ITEM_CODE) AS WEEK_ITEM_CODE		      \n");
		//sbSql.append("     , DECODE(A.DANGA_ITEM_CODE, NULL, 'NN', 'FE') AS DANGAWEEK_STATUS		\n");
		/*
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"') AS PO_WEEK_STATUS \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS UNUSE_YN \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS VAL_STP_YN \n");
		*/
		
		
		
		
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
		sbSql.append("     ,(SELECT B.PR_ID, SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY) AS DEF_QTY \n");
		sbSql.append("         FROM FMM_MENU A, FMM_RECIPE_ITEM B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND B.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND B.PR_YN = 'Y' \n");
		//식단발주 시 수량을 "0"으로 입력 후 주문 시 식단표에는 주문완료 상태로 처리된다.(PR_ID = -999 및  PR_QTY = 0 로 세팅)
		//하지만 PO_PR은 생성되지 않거나 취소처리 되므로 그런 자료는 굳이 조회할 필요가 없다.
		sbSql.append("          AND B.PR_ID > 0 \n");
		sbSql.append("        GROUP BY B.PR_ID \n");
		sbSql.append("       ) B \n");
		sbSql.append("     ,(SELECT A.PR_ID \n");
		sbSql.append("            , A.PR_NUM , A.APPROVE_NUM \n");
		sbSql.append("            , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.MARGIN_PRICE \n");
		sbSql.append("            , A.SALE_PRICE, A.PR_QTY, ROUND(A.SALE_PRICE * A.PR_QTY) AS SALE_AMOUNT \n");
		sbSql.append("            , A.LINE_STATUS \n");
		//LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("            , DECODE(A.LINE_STATUS,'004','마감전','마감') AS CLS_STATUS \n");
		//sbSql.append("            , DECODE(A.LINE_STATUS,'001','마감전','마감') AS CLS_STATUS \n");
		sbSql.append("            , CASE WHEN FMS_PO_LINESTATUS_FUN(A.PR_ID, A.PR_NUM, 'C') IN('DL', 'GC', 'IV') OR A.SO_STATUS IN('005', '007', '008') THEN '마감' ELSE '마감전' END AS CLS_STATUS \n");
		sbSql.append("            , A.SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("            , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE, B.POINT_FLAG, A.PR_UPJANG \n");
		sbSql.append("            , A.RC_UPJANG, A.INVAT_FLAG, A.OUTVAT_FLAG \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("        , DECODE(B.POINT_FLAG,'Y',DECODE(B.MIN_ORD_QTY,0,0,0.1),B.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("        , B.MAX_ORD_QTY \n");
			sbSql.append("        , DECODE(B.POINT_FLAG,'Y',DECODE(B.MULTIPLIER_QTY,0,0,0.1),B.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
			sbSql.append("        , B.MIN_ORD_QTY, B.MAX_ORD_QTY, B.MULTIPLIER_QTY \n");
		
		sbSql.append("            , B.KG_CONVERT_RATE \n");
		sbSql.append("            , '0000' AS OTCUSTCD \n");
		sbSql.append("            , B.IMG_PATH AS IMAGE_PATH \n");
		//sbSql.append("            , DECODE(A.LINE_STATUS,'005','[**발주취소**]')||A.PR_REMARK AS PR_REMARK \n");
		sbSql.append("            , A.PR_REMARK \n");
		sbSql.append("            , FMS_PO_LINESTATUS_FUN(A.PR_ID, A.PR_NUM, 'N') AS PO_LINE_STATUS \n");
		//LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("            , DECODE(A.LINE_STATUS,'004','Y','N') AS PR_POS \n");
		//sbSql.append("            , DECODE(A.LINE_STATUS,'001','Y','N') AS PR_POS \n");
		sbSql.append("            , CASE WHEN FMS_PO_LINESTATUS_FUN(A.PR_ID, A.PR_NUM, 'C') IN('DL', 'GC', 'IV') OR A.SO_STATUS IN('005', '007', '008') THEN 'N' ELSE 'Y' END AS PR_POS \n");
		sbSql.append("            , B.CORN_YN, B.CONSUM_YN, B.SPICE_YN  \n");
		//sbSql.append("            , 0 AS D_DAYS, 0 AS D_TIMES \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
// 		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
// 		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
// 		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append(" 	            /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) ) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) AS D_DAYS \n");
		sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
		sbSql.append("            , A.APPLY_SD, A.VD_SN \n");
		sbSql.append("            , B.ITEM_CLASS4 \n");
		sbSql.append("            , B.ORIGIN_TYPE \n");
		sbSql.append("            , A.UPJANG_GRP \n");
		sbSql.append("            , TO_CHAR(A.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS APPROVE_TIME \n");
		sbSql.append("            , A.CREATE_BY \n");
		sbSql.append("         FROM SO_PR A, HLDC_PO_ITEM_MST B, HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("        WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND A.DOCU_SOURCE = '" + sDocSrc + "' \n");
		sbSql.append("          AND A.LINE_STATUS NOT IN ('003','999') \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT A.PR_ID \n");
		sbSql.append("            , A.PR_NUM , '' AS APPROVE_NUM  \n");
		sbSql.append("            , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("            , A.SALE_PRICE, A.PR_QTY, A.SALE_AMOUNT \n");
		sbSql.append("            , A.LINE_STATUS \n");
		//LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("            , DECODE(A.LINE_STATUS, '004' \n");
		sbSql.append("            , DECODE(A.LINE_STATUS, '002' \n");
		sbSql.append("                    , DECODE( SIGN( TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(B.D_DAYS,0) - 1) \n");
		sbSql.append("                            , 1, '마감전' \n");
		sbSql.append("                            , 0, DECODE(SIGN(DECODE(B.D_TIMES,'',2400,0,2400,TO_NUMBER(B.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'마감전','마감') \n");
		sbSql.append("                            , '마감' ) \n");
		sbSql.append("                    , '마감') AS CLS_STATUS \n");
		sbSql.append("            , A.SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("            , A.TAX_CODE, NULL AS CUSTCD, NULL AS CENTER_FLAG \n");
		sbSql.append("            , NULL AS CENTER_CODE, B.POINT_FLAG, A.UPJANG AS PR_UPJANG \n");
		sbSql.append("            , A.UPJANG AS RC_UPJANG, NULL AS INVAT_FLAG, NULL AS OUTVAT_FLAG \n");
		sbSql.append("            , B.MIN_ORD_QTY, B.MAX_ORD_QTY, B.MULTIPLIER_QTY \n");
		sbSql.append("            , B.KG_CONVERT_RATE \n");
		sbSql.append("            , B.OTCUSTCD AS OTCUSTCD \n");
		sbSql.append("            , B.SIMAGE_PATH AS IMAGE_PATH \n");
		sbSql.append("            , A.CONTENTS AS PR_REMARK \n");
		sbSql.append("            , '발주완료' AS PO_LINE_STATUS \n");
		//LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("            , DECODE(A.LINE_STATUS, '004' \n");
		sbSql.append("            , DECODE(A.LINE_STATUS, '002' \n");
		sbSql.append("                    , DECODE( SIGN( TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(B.D_DAYS,0) - 1) \n");
		sbSql.append("                            , 1, 'Y' \n");
		sbSql.append("                            , 0, DECODE(SIGN(DECODE(B.D_TIMES,'',2400,0,2400,TO_NUMBER(B.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'Y','N') \n");
		sbSql.append("                            , 'N' ) \n");
		sbSql.append("                    , 'N') AS PR_POS \n");
		sbSql.append("            , B.CORN_YN, B.CONSUM_YN, B.SPICE_YN \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(B.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(B.D_TIMES,'',2400,0,2400,TO_NUMBER(B.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(B.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(B.D_TIMES,'',2400,0,2400,TO_NUMBER(B.D_TIMES)) AS D_TIMES \n");
		sbSql.append("            , '' AS APPLY_SD, '' AS VD_SN \n");
		sbSql.append("            , B.ITEM_CLASS4 \n");
		sbSql.append("            , B.ORIGIN_TYPE \n");
		sbSql.append("            , '' AS UPJANG_GRP \n");
		sbSql.append("            , TO_CHAR(A.CDATE, 'YYYY-MM-DD HH24:MI:SS') AS APPROVE_TIME \n");
		sbSql.append("            , A.CUSER AS CREATE_BY \n");
		sbSql.append("         FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B \n");
		sbSql.append("        WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND A.DOCU_SOURCE = '" + sDocSrc + "' \n");
		sbSql.append("          AND A.LINE_STATUS NOT IN ('003','999') \n");
		sbSql.append("       ) A \n");
		sbSql.append(" WHERE A.PR_ID = B.PR_ID(+) \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append(" ORDER BY A.PR_ID \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();
		
		//out 데이타
		DataSet ds_ListTmp;
		
		//sql문 버퍼RESET
		sbSql.delete(0, sbSql.length());
		//2)식단내역조회
		sbSql.append("SELECT /*2. 식단내역조회*/ T.* \n");
		sbSql.append("     , CASE WHEN T.PO_STATUS != 'HK' AND T.OTCUSTCD = '0000' THEN '구매 스케줄제한' \n");
		sbSql.append("            WHEN T.FMP_STATUS != 'N' AND T.OTCUSTCD = '0000' THEN '영업 스케줄제한' \n");
		sbSql.append("            WHEN T.ITEM_STOP != 'TP' AND T.OTCUSTCD = '0000' THEN '구매 불용자재' \n");
		sbSql.append("            WHEN T.PO_WEEK_STATUS != 'XR' AND T.OTCUSTCD = '0000' THEN '요일통제상품' \n");
		sbSql.append("            ELSE T.PR_REMARK_CHK END AS PR_REMARK \n");
		sbSql.append("     , CASE WHEN T.PO_STATUS != 'HK' AND T.OTCUSTCD = '0000' THEN 'N' \n");
		sbSql.append("            WHEN T.FMP_STATUS != 'N' AND T.OTCUSTCD = '0000' THEN 'N' \n");
		sbSql.append("            WHEN T.ITEM_STOP != 'TP' AND T.OTCUSTCD = '0000' THEN 'N' \n");
		sbSql.append("            WHEN T.PO_WEEK_STATUS != 'XR' AND T.OTCUSTCD = '0000' THEN 'N' \n");
		sbSql.append("            ELSE T.PR_POS_CHK END AS PR_POS \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.UNIT_PRICE, B.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , B.SALE_PRICE, A.DEF_QTY, 0 AS PR_QTY \n");
		sbSql.append("     , 0 AS SALE_AMOUNT \n");
		//LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS \n");
		sbSql.append("     , '002' AS LINE_STATUS, '마감전' AS CLS_STATUS \n");
		sbSql.append("     , '' AS PO_LINE_STATUS \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, B.CUSTCD, B.CENTER_FLAG \n");
		sbSql.append("     , B.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
		sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
		sbSql.append("     , A.OTCUSTCD \n");
		sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("       ELSE B.SALE_PRICE END AS OP_PRICE --운영단가 \n");
		sbSql.append("     , DECODE(C.OP_RATE, NULL, D.OP_RATE, C.OP_RATE) AS OP_RATE \n");
		sbSql.append("     , 0 AS OP_AMOUNT \n");
		sbSql.append("     , 0 AS OP_AMOUNT_OLD \n");
		sbSql.append("     , B.D_DAYS, B.D_TIMES \n");
		sbSql.append("     , DECODE(NVL(B.D_DAYS,0),0,'-','D-'||TO_CHAR(B.D_DAYS)) AS D_DAY_DISP \n");
		sbSql.append("     , A.KG_CONVERT_RATE \n");
		sbSql.append("     , A.IMAGE_PATH \n");
		sbSql.append("     , E.ITEM_CODE AS LIMIT_ITEM, E.LIMIT_REASON \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'계약안됨',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'D-'||TO_CHAR(B.D_DAYS),F.FEATURE_NAME),'주문불가('||E.LIMIT_REASON||')')) AS PR_REMARK_CHK \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) AS PR_POS_CHK \n");
		sbSql.append("     ,(SELECT X.MENU_ORD_YN \n");
		sbSql.append("         FROM FMP_WEEKLY_ITEM X \n");
		sbSql.append("        WHERE X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND X.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("          AND NVL(DECODE(TO_CHAR(SYSDATE,'D'),1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT),'Y') = 'Y' \n");
		sbSql.append("          AND X.USE_YN = 'Y') MENU_ORD_YN \n");
		sbSql.append("     , 'Y' AS MENU_FLAG \n");
		sbSql.append("     , A.CONSUM_YN, A.CORN_YN, A.SPICE_YN \n");
		sbSql.append("     , NULL AS SAV_STAT \n");
		sbSql.append("     , A.CHG_QTY \n");
		sbSql.append("     , DECODE(A.IMAGE_PATH,NULL,'N','Y') AS PIC_YN \n");
		sbSql.append("     , B.APPLY_SD, B.VD_SN \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = B.CENTER_CODE), B.ITEM_CODE, B.VD_SN, '02', FMS_PREORDER_FUN(B.CENTER_CODE,B.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(B.CENTER_CODE,B.ITEM_CODE,'D_TIMES'), '"+sPrDate+"', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS PO_STATUS \n");
		sbSql.append("     , FMP_ORDER_SCHL_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", B.CUSTCD, B.ITEM_CODE, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS FMP_STATUS \n");
		sbSql.append("     , 'P' AS MOBILE_GUBUN \n");
		sbSql.append("     , A.ORIGIN_TYPE \n");
		sbSql.append("     , SCC_SOPR_AGG_FUN('" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "', A.ITEM_CODE, '1') AS MAX_SO_QTY \n");
		sbSql.append("     , B.UPJANG_GRP \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS ITEM_STOP \n"); // 구매불용자재체크
		sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = B.CENTER_CODE), A.ITEM_CODE, B.VD_SN, '02', '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"'), 'XR') AS PO_WEEK_STATUS		\n");
		sbSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = B.CENTER_CODE), B.UPJANG_GRP, A.ITEM_CODE, '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"')    = 'CK' THEN 'Y' ELSE 'N' END  AS SHP_MAP		\n");
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
		sbSql.append("     , FMP_ORD_LIMIT E \n");
		//sbSql.append("     , HLDC_PO_CENTER F \n");
		sbSql.append("     ,(SELECT A.UPJANG, B.NEED_DATE \n");
		sbSql.append("            , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("        , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MIN_ORD_QTY,0,0,0.1),C.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("        , C.MAX_ORD_QTY \n");
			sbSql.append("        , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MULTIPLIER_QTY,0,0,0.1),C.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
  			sbSql.append("        , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		
		sbSql.append("            , C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH \n");
		sbSql.append("            , C.CONSUM_YN, C.CORN_YN, C.SPICE_YN \n");
		sbSql.append("            , DECODE(NVL(B.ATTR01,'N'),'N', ROUND(SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY / 1000 / C.KG_CONVERT_RATE),2), 0) AS DEF_QTY \n");
		sbSql.append("            , COUNT(DECODE(NVL(B.PR_YN,'N'),'N',1,0)) AS CHG_QTY \n");
		sbSql.append("            , C.ITEM_CLASS4 \n");
		sbSql.append("            , C.ORIGIN_TYPE \n");
		sbSql.append("         FROM FMM_MENU A, FMM_RECIPE_ITEM B, FMS_ITEM_V C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD = B.MENU_CD \n");
		//식단발주에서 주문제외로 들어온 상품은 표시하지 않는다.
		sbSql.append("          AND NVL(B.ATTR01,'N') = 'N' --주문제외로 들어온 상품은 표시하지 않음. \n");
		sbSql.append("          AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("          AND B.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND B.PR_YN = 'N' \n");
		sbSql.append("        GROUP BY A.UPJANG, B.NEED_DATE, B.ATTR01 \n");
		sbSql.append("               , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		sbSql.append("               , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY, C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH, C.CONSUM_YN, C.CORN_YN, C.SPICE_YN, C.ITEM_CLASS4, C.ORIGIN_TYPE \n");
		sbSql.append("       ) A \n");
		sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE \n");
		sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
// 		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
// 		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
// 		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
        sbSql.append(" 	            /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) ) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) AS D_DAYS \n");
		sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
		//sbSql.append("            ,(SELECT A.CODE_NAME FROM SCC_COMMON_CODE A WHERE A.GROUP_CODE = 'FS0033' AND A.CODE = O.ITEM_FEATURE) AS FEATURE_NAME \n");
		//sbSql.append("	    	  , FMS_ITEM_FEATURE_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "', A.ITEM_CODE, 'N') AS FEATURE_NAME --자재특성 \n");
		
		sbSql.append("            , A.APPLY_SD, A.VD_SN \n");
		sbSql.append("            , A.UPJANG_GRP \n");
		sbSql.append("         FROM \n");
		
		sbSql.append("             (SELECT * \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE 1=1 \n");
		
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
    	
		// 2015.07.30 구매 단가 계약 테이블 조인(금지자재체크) 식단에 등록된 자재는 우선 나오게 처리		
		//sbSql.append("                 AND EXISTS (SELECT 1 FROM HLDC_PO_CONTRACT_F WHERE CENTER_CODE = A.CENTER_CODE AND UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND CONTRACT_PRICE > 0) \n");
		sbSql.append("             	   AND CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("             	   AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                 AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN CONTRACT_START AND NVL(CONTRACT_END, '99999999') \n");
		sbSql.append("             ) A \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("        WHERE A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
		sbSql.append("            , '0' AS CENTER_CODE \n");
		sbSql.append("            , A.UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
		//sbSql.append("            , NULL AS FEATURE_NAME \n");
		sbSql.append("            , '' AS APPLY_SD, '' AS VD_SN \n");
		sbSql.append("            , '' AS UPJANG_GRP \n");
		sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("               WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "OTCUST_PRICE_UPJANG")) + " \n");
		sbSql.append("                 AND SDATE <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("               GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("              ) B \n");
		sbSql.append("            , FMP_OTCUST_ITEM C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.SDATE = B.SDATE \n");
		sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		sbSql.append("      ) B \n");
		sbSql.append("    , (SELECT A.ITEM_CODE \n");
		sbSql.append("              , CASE WHEN B.DUTY_YN = 'Y' THEN '기획자재' \n");
		sbSql.append("                     WHEN A.MANUF_CD IS NOT NULL THEN '전처리' \n");
		sbSql.append("                     WHEN B.PB_YN = 'Y' THEN 'PB상품' \n");
		sbSql.append("                     WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN '친환경' \n");
		sbSql.append("                     ELSE '' \n");
		sbSql.append("                 END AS FEATURE_NAME \n");
		sbSql.append("              , CASE WHEN B.DUTY_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon11.png' \n");
		sbSql.append("                     WHEN A.MANUF_CD IS NOT NULL THEN 'theme://Images/new/grd_WF_Icon10.png' \n");
		sbSql.append("                     WHEN B.PB_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon09.png' \n");
		sbSql.append("                     WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN 'theme://Images/new/grd_WF_Icon08.png' \n");
		sbSql.append("                     ELSE '' \n");
		sbSql.append("                 END AS FEATURE_ICON \n");
		sbSql.append("           FROM EPROCUSR.MV_ITEM_MST3 A, EPROCUSR.VO_CONTRACT_F B \n");
		sbSql.append("          WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("            AND A.USE_YN = 'Y' \n");
		sbSql.append("            AND B.UPJANG(+) = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("            AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN B.CONTRACT_START(+) AND B.CONTRACT_END(+) \n");
		sbSql.append("      ) F \n");   
		sbSql.append(" WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
		//sbSql.append("   AND B.CENTER_CODE = F.CENTER_CODE \n");
		sbSql.append(" ORDER BY DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) DESC \n");
		sbSql.append("        , A.ITEM_CODE \n");
		sbSql.append("      ) T \n");
		//sbSql.append(" WHERE T.OTCUSTCD != '0000' OR (T.PO_STATUS = 'HK' AND T.FMP_STATUS = 'N') \n"); // 구매_발주가능, 식재_발주가능
		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListTmp = this.makeDataSet(rs, "ds_ListTmp");
		
		pstmt.close();
		rs.close();
				
		//out 데이타(삭제된 데이터 조회 2010.07.09)
		DataSet ds_ListDel;
		//sql문 버퍼RESET
		sbSql.delete(0, sbSql.length());

		//3)삭제내역조회
		sbSql.append("SELECT /*3. 삭제내역조회*/ T.* \n");
		sbSql.append("     , CASE WHEN T.PO_STATUS != 'HK' THEN '구매 스케줄제한' \n");
		sbSql.append("            WHEN T.FMP_STATUS != 'N' THEN '영업 스케줄제한' \n");
		sbSql.append("            WHEN T.ITEM_STOP != 'TP' THEN '구매 불용자재' \n");
		sbSql.append("            WHEN T.PO_WEEK_STATUS != 'XR' AND T.OTCUSTCD = '0000' THEN '요일통제상품' \n");
		sbSql.append("            ELSE T.PR_REMARK_CHK END AS PR_REMARK \n");
		sbSql.append("     , CASE WHEN T.PO_STATUS != 'HK' THEN 'N' \n");
		sbSql.append("            WHEN T.FMP_STATUS != 'N' THEN 'N' \n");
		sbSql.append("            WHEN T.ITEM_STOP != 'TP' THEN 'N' \n");
		sbSql.append("            WHEN T.PO_WEEK_STATUS != 'XR' AND T.OTCUSTCD = '0000' THEN 'N' \n");
		sbSql.append("            ELSE T.PR_POS_CHK END AS PR_POS \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.UNIT_PRICE, B.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , B.SALE_PRICE, A.DEF_QTY, 0 AS PR_QTY \n");
		sbSql.append("     , 0 AS SALE_AMOUNT \n");
		//LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS \n");
		sbSql.append("     , '002' AS LINE_STATUS, '마감전' AS CLS_STATUS \n");
		sbSql.append("     , '' AS PO_LINE_STATUS \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, B.CUSTCD, B.CENTER_FLAG \n");
		sbSql.append("     , B.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
		sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
		sbSql.append("     , A.OTCUSTCD \n");
		sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(B.SALE_PRICE + (B.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("       ELSE B.SALE_PRICE END AS OP_PRICE --운영단가 \n");
		sbSql.append("     , DECODE(C.OP_RATE, NULL, D.OP_RATE, C.OP_RATE) AS OP_RATE \n");
		sbSql.append("     , 0 AS OP_AMOUNT \n");
		sbSql.append("     , 0 AS OP_AMOUNT_OLD \n");
		sbSql.append("     , B.D_DAYS, B.D_TIMES \n");
		sbSql.append("     , DECODE(NVL(B.D_DAYS,0),0,'-','D-'||TO_CHAR(B.D_DAYS)) AS D_DAY_DISP \n");
		sbSql.append("     , A.KG_CONVERT_RATE \n");
		sbSql.append("     , A.IMAGE_PATH \n");
		sbSql.append("     , E.ITEM_CODE AS LIMIT_ITEM, E.LIMIT_REASON \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'계약안됨',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'D-'||TO_CHAR(B.D_DAYS),F.FEATURE_NAME),'주문불가('||E.LIMIT_REASON||')')) AS PR_REMARK_CHK \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) AS PR_POS_CHK \n");
		sbSql.append("     ,(SELECT X.MENU_ORD_YN \n");
		sbSql.append("         FROM FMP_WEEKLY_ITEM X \n");
		sbSql.append("        WHERE X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND X.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("          AND NVL(DECODE(TO_CHAR(SYSDATE,'D'),1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT),'Y') = 'Y' \n");
		sbSql.append("          AND X.USE_YN = 'Y') MENU_ORD_YN \n");
		sbSql.append("     , 'Y' AS MENU_FLAG \n");
		sbSql.append("     , A.CONSUM_YN, A.CORN_YN, A.SPICE_YN \n");
		sbSql.append("     , NULL AS SAV_STAT \n");
		sbSql.append("     , A.CHG_QTY \n");
		sbSql.append("     , B.APPLY_SD, B.VD_SN \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = B.CENTER_CODE), B.ITEM_CODE, B.VD_SN, '02', FMS_PREORDER_FUN(B.CENTER_CODE,B.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(B.CENTER_CODE,B.ITEM_CODE,'D_TIMES'), '"+sPrDate+"', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS PO_STATUS \n");
		sbSql.append("     , FMP_ORDER_SCHL_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", B.CUSTCD, B.ITEM_CODE, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS FMP_STATUS \n");
		sbSql.append("     , 'P' AS MOBILE_GUBUN \n");
		sbSql.append("     , A.ORIGIN_TYPE \n");
		sbSql.append("     , SCC_SOPR_AGG_FUN('" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "', A.ITEM_CODE, '1') AS MAX_SO_QTY \n");
		sbSql.append("     , B.UPJANG_GRP \n");
		sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS ITEM_STOP \n"); // 구매불용자재체크
		sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = B.CENTER_CODE), A.ITEM_CODE, B.VD_SN, '02', '"+ nullToBlank(ds_cond.getString(0, "NEED_DATE")) +"'), 'XR') AS PO_WEEK_STATUS		\n");
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
		sbSql.append("     , FMP_ORD_LIMIT E \n");
		//sbSql.append("     , HLDC_PO_CENTER F \n");
		sbSql.append("     ,(SELECT A.UPJANG, B.NEED_DATE \n");
		sbSql.append("            , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("        , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MIN_ORD_QTY,0,0,0.1),C.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("        , C.MAX_ORD_QTY \n");
			sbSql.append("        , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MULTIPLIER_QTY,0,0,0.1),C.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
  			sbSql.append("        , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		
		sbSql.append("            , C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH \n");
		sbSql.append("            , C.CONSUM_YN, C.CORN_YN, C.SPICE_YN \n");
		sbSql.append("            , ROUND(SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY / 1000 / C.KG_CONVERT_RATE),2) AS DEF_QTY \n");
		sbSql.append("            , COUNT(DECODE(NVL(B.PR_YN,'N'),'N',1,0)) AS CHG_QTY \n");
		sbSql.append("            , C.ITEM_CLASS4 \n");
		sbSql.append("            , C.ORIGIN_TYPE \n");
		sbSql.append("         FROM FMM_MENU A, FMM_RECIPE_ITEM B, FMS_ITEM_V C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("          AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("          AND B.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND B.PR_YN = 'Y' \n");
		sbSql.append("          AND B.PR_ID = -999 \n");
		sbSql.append("        GROUP BY A.UPJANG, B.NEED_DATE \n");
		sbSql.append("               , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		sbSql.append("               , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY, C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH, C.CONSUM_YN, C.CORN_YN, C.SPICE_YN, C.ITEM_CLASS4, C.ORIGIN_TYPE \n");
		sbSql.append("       ) A \n");
		sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE \n");
		sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
// 		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
// 		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
// 		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
        sbSql.append(" 	            /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) ) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) AS D_DAYS \n");
		sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
		//sbSql.append("            ,(SELECT A.CODE_NAME FROM SCC_COMMON_CODE A WHERE A.GROUP_CODE = 'FS0033' AND A.CODE = O.ITEM_FEATURE) AS FEATURE_NAME \n");
		sbSql.append("            , A.APPLY_SD, A.VD_SN \n");
		sbSql.append("            , A.UPJANG_GRP \n");
		sbSql.append("         FROM \n");
		sbSql.append("             (SELECT * \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE 1=1 \n");
		// 2015.07.30 구매 단가 계약 테이블 조인(금지자재체크) 식단에 등록된 자재는 우선 나오게 처리	
		//sbSql.append("                 AND EXISTS (SELECT 1 FROM HLDC_PO_CONTRACT_F WHERE CENTER_CODE = A.CENTER_CODE AND UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND CONTRACT_PRICE > 0) \n");
		sbSql.append("                 AND CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("             	   AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                 AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN CONTRACT_START AND NVL(CONTRACT_END, '99999999') \n");
		sbSql.append("             ) A \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("        WHERE A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
		sbSql.append("            , '0' AS CENTER_CODE \n");
		sbSql.append("            , A.UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
		//sbSql.append("            , NULL AS FEATURE_NAME \n");
		sbSql.append("            , '' AS APPLY_SD, '' AS VD_SN \n");
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
		sbSql.append("      ) B \n");
		sbSql.append("    , (SELECT A.ITEM_CODE \n");
		sbSql.append("              , CASE WHEN B.DUTY_YN = 'Y' THEN '기획자재' \n");
		sbSql.append("                     WHEN A.MANUF_CD IS NOT NULL THEN '전처리' \n");
		sbSql.append("                     WHEN B.PB_YN = 'Y' THEN 'PB상품' \n");
		sbSql.append("                     WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN '친환경' \n");
		sbSql.append("                     ELSE '' \n");
		sbSql.append("                 END AS FEATURE_NAME \n");
		sbSql.append("              , CASE WHEN B.DUTY_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon11.png' \n");
		sbSql.append("                     WHEN A.MANUF_CD IS NOT NULL THEN 'theme://Images/new/grd_WF_Icon10.png' \n");
		sbSql.append("                     WHEN B.PB_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon09.png' \n");
		sbSql.append("                     WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN 'theme://Images/new/grd_WF_Icon08.png' \n");
		sbSql.append("                     ELSE '' \n");
		sbSql.append("                 END AS FEATURE_ICON \n");
		sbSql.append("           FROM EPROCUSR.MV_ITEM_MST3 A, EPROCUSR.VO_CONTRACT_F B \n");
		sbSql.append("          WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("            AND A.USE_YN = 'Y' \n");
		sbSql.append("            AND B.UPJANG(+) = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("            AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN B.CONTRACT_START(+) AND B.CONTRACT_END(+) \n");
		sbSql.append("      ) F \n"); 
		sbSql.append(" WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = F.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
		//sbSql.append("   AND B.CENTER_CODE = F.CENTER_CODE \n");
		sbSql.append(" ORDER BY DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) DESC \n");
		sbSql.append("        , A.ITEM_CODE \n");
		
		sbSql.append("      ) T \n");
		//sbSql.append(" WHERE T.OTCUSTCD != '0000' OR (T.PO_STATUS = 'HK' AND T.FMP_STATUS = 'N') \n"); // 구매_발주가능, 식재_발주가능
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListDel = this.makeDataSet(rs, "ds_ListDel");
		
		pstmt.close();
		rs.close();
		
		/**종료**/
		out_dl.add(ds_List);
		out_dl.add(ds_ListTmp);
		out_dl.add(ds_ListDel);
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
		String sDocSrc      = nullToBlank(in_vl.getString("sDocSrc"));
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
    	String strQtyYn    = nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));

		//1)주문내역조회
		sbSql.append("\n  \n");
		sbSql.append("SELECT /*1.주문내역조회*/A.* \n");
		sbSql.append("     , ROUND(B.DEF_QTY / 1000 / A.KG_CONVERT_RATE, 2) AS DEF_QTY \n");

		//sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
		//sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
		//sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT_OLD \n");

		sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , ROUND(A.PR_QTY * DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE)) AS OP_AMOUNT \n");
		sbSql.append("     , ROUND(A.PR_QTY * DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE)) AS OP_AMOUNT_OLD \n");
		
		//sbSql.append("     , 0 AS D_DAYS, 0 AS D_TIMES, NULL AS D_DAY_DISP \n");
		//sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS) AS D_DAY_DISP \n");
		sbSql.append("     , DECODE(NVL(A.D_DAYS,0),0,'-','D-'||TO_CHAR(A.D_DAYS)) AS D_DAY_DISP \n");
		sbSql.append("     , DECODE(B.PR_ID,NULL,'N','Y') AS MENU_FLAG \n");
		sbSql.append("     , '저장' AS SAV_STAT \n");
		sbSql.append("     , 0 AS CHG_QTY \n");
		sbSql.append("     , DECODE(A.IMAGE_PATH,NULL,'N','Y') AS PIC_YN \n");
		sbSql.append("  FROM FMU_OP_RATE C \n");
		sbSql.append("     ,(SELECT B.PR_ID, SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY) AS DEF_QTY \n");
		sbSql.append("         FROM FMM_MENU A, FMM_RECIPE_ITEM B \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		//sbSql.append("          AND A.MENU_CD LIKE '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "-" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND B.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND B.PR_YN = 'Y' \n");
		//식단발주 시 수량을 "0"으로 입력 후 주문 시 식단표에는 주문완료 상태로 처리된다.(PR_ID = -999 및  PR_QTY = 0 로 세팅)
		//하지만 PO_PR은 생성되지 않거나 취소처리 되므로 그런 자료는 굳이 조회할 필요가 없다.
		sbSql.append("          AND B.PR_ID > 0 \n");
		sbSql.append("        GROUP BY B.PR_ID) B \n");
		sbSql.append(",( \n");
		sbSql.append("SELECT A.PR_ID \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.MARGIN_PRICE \n");
		sbSql.append("     , A.SALE_PRICE, A.PR_QTY, ROUND(A.SALE_PRICE * A.PR_QTY) AS SALE_AMOUNT \n");
		sbSql.append("     , A.LINE_STATUS \n");
		sbSql.append("     , DECODE(A.LINE_STATUS,'004','마감전','마감') AS CLS_STATUS \n");
		sbSql.append("     , A.SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("     , A.CENTER_CODE, B.POINT_FLAG, A.PR_UPJANG \n");
		sbSql.append("     , A.RC_UPJANG, A.INVAT_FLAG, A.OUTVAT_FLAG \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("     , DECODE(B.POINT_FLAG,'Y',DECODE(B.MIN_ORD_QTY,0,0,0.1),B.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("     , B.MAX_ORD_QTY \n");
			sbSql.append("     , DECODE(B.POINT_FLAG,'Y',DECODE(B.MULTIPLIER_QTY,0,0,0.1),B.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
			sbSql.append("     , B.MIN_ORD_QTY, B.MAX_ORD_QTY, B.MULTIPLIER_QTY \n");
		sbSql.append("     , B.KG_CONVERT_RATE \n");
		sbSql.append("     , '0000' AS OTCUSTCD \n");
		sbSql.append("     , B.IMG_PATH AS IMAGE_PATH \n");
		sbSql.append("     , DECODE(A.LINE_STATUS,'005','[**발주취소**]')||A.PR_REMARK AS PR_REMARK \n");
		sbSql.append("     , DECODE(A.LINE_STATUS,'004','Y','N') AS PR_POS \n");
		sbSql.append("     , B.CORN_YN, B.CONSUM_YN, B.SPICE_YN  \n");
		sbSql.append("     , 0 AS D_DAYS, 0 AS D_TIMES \n");
		sbSql.append("  FROM HLDC_PO_PR A, HLDC_PO_ITEM_MST B \n");
		sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("   AND A.DOCU_SOURCE = '" + sDocSrc + "' \n");
		sbSql.append("   AND A.LINE_STATUS <> '003' \n");
		sbSql.append("----------- \n");
		sbSql.append(" UNION ALL \n");
		sbSql.append("----------- \n");
		sbSql.append("SELECT A.PR_ID \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , A.SALE_PRICE, A.PR_QTY, A.SALE_AMOUNT \n");
		sbSql.append("     , A.LINE_STATUS \n");
		//sbSql.append("     , DECODE(A.LINE_STATUS,'004','마감전','마감') AS CLS_STATUS \n");
		sbSql.append("     , DECODE(A.LINE_STATUS, '004' \n");
		sbSql.append("             , DECODE( SIGN( TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(B.D_DAYS,0) - 1) \n");
		sbSql.append("                     , 1, '마감전' \n");
		sbSql.append("                     , 0, DECODE(SIGN(DECODE(B.D_TIMES,'',2400,0,2400,TO_NUMBER(B.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'마감전','마감') \n");
		sbSql.append("                     , '마감' ) \n");
		sbSql.append("             , '마감') AS CLS_STATUS \n");
		sbSql.append("     , A.SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, NULL AS CUSTCD, NULL AS CENTER_FLAG \n");
		sbSql.append("     , NULL AS CENTER_CODE, B.POINT_FLAG, A.UPJANG AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, NULL AS INVAT_FLAG, NULL AS OUTVAT_FLAG \n");
		sbSql.append("     , B.MIN_ORD_QTY, B.MAX_ORD_QTY, B.MULTIPLIER_QTY \n");
		sbSql.append("     , B.KG_CONVERT_RATE \n");
		sbSql.append("     , B.OTCUSTCD AS OTCUSTCD \n");
		sbSql.append("     , B.SIMAGE_PATH AS IMAGE_PATH \n");
		sbSql.append("     , A.CONTENTS AS PR_REMARK \n");
		//sbSql.append("     , DECODE(A.LINE_STATUS,'004','Y','N') AS PR_POS \n");
		sbSql.append("     , DECODE(A.LINE_STATUS, '004' \n");
		sbSql.append("             , DECODE( SIGN( TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(B.D_DAYS,0) - 1) \n");
		sbSql.append("                     , 1, 'Y' \n");
		sbSql.append("                     , 0, DECODE(SIGN(DECODE(B.D_TIMES,'',2400,0,2400,TO_NUMBER(B.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'Y','N') \n");
		sbSql.append("                     , 'N' ) \n");
		sbSql.append("             , 'N') AS PR_POS \n");
		sbSql.append("     , B.CORN_YN, B.CONSUM_YN, B.SPICE_YN \n");
		sbSql.append("     , NVL(B.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("     , DECODE(B.D_TIMES,'',2400,0,2400,TO_NUMBER(B.D_TIMES)) AS D_TIMES \n");
		sbSql.append("  FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B \n");
		sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("   AND A.DOCU_SOURCE = '" + sDocSrc + "' \n");
		sbSql.append("   AND A.LINE_STATUS <> '003' \n");
		sbSql.append(") A \n");
		sbSql.append(" WHERE A.PR_ID = B.PR_ID(+) \n");
		sbSql.append("   AND A.RC_UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
		sbSql.append(" ORDER BY A.PR_ID \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();
		//FileLog.println("d:\\aaa.txt", ds_List);

		//out 데이타
		DataSet ds_ListTmp;
		//sql문 버퍼RESET
		sbSql.delete(0, sbSql.length());

		//2)식단내역조회
		sbSql.append("SELECT /*2 식단내역조회*/ A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.UNIT_PRICE, B.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , B.SALE_PRICE, A.DEF_QTY, 0 AS PR_QTY \n");
		sbSql.append("     , 0 AS SALE_AMOUNT \n");
		sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, B.CUSTCD, B.CENTER_FLAG \n");
		sbSql.append("     , B.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
		sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
		sbSql.append("     , A.OTCUSTCD \n");
		//sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(B.SALE_PRICE + ROUND(B.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((B.SALE_PRICE + ROUND(B.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , 0 AS OP_AMOUNT \n");
		sbSql.append("     , 0 AS OP_AMOUNT_OLD \n");
		sbSql.append("     , B.D_DAYS, B.D_TIMES \n");
		//sbSql.append("     , 'D-'||TO_CHAR(B.D_DAYS) AS D_DAY_DISP \n");
		sbSql.append("     , DECODE(NVL(B.D_DAYS,0),0,'-','D-'||TO_CHAR(B.D_DAYS)) AS D_DAY_DISP \n");
		sbSql.append("     , A.KG_CONVERT_RATE \n");
		sbSql.append("     , A.IMAGE_PATH \n");
		sbSql.append("     , E.ITEM_CODE AS LIMIT_ITEM, E.LIMIT_REASON \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'계약안됨',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'D-'||TO_CHAR(B.D_DAYS),B.FEATURE_NAME),'주문불가('||E.LIMIT_REASON||')')) AS PR_REMARK \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) AS PR_POS \n");

		sbSql.append("     ,(SELECT X.MENU_ORD_YN \n");
		sbSql.append("         FROM FMP_WEEKLY_ITEM X \n");
		sbSql.append("        WHERE X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND X.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("          AND NVL(DECODE(TO_CHAR(SYSDATE,'D'),1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT),'Y') = 'Y' \n");
		sbSql.append("          AND X.USE_YN = 'Y') MENU_ORD_YN \n");

		sbSql.append("     , 'Y' AS MENU_FLAG \n");
		sbSql.append("     , A.CONSUM_YN, A.CORN_YN, A.SPICE_YN \n");
		sbSql.append("     , NULL AS SAV_STAT \n");
		sbSql.append("     , A.CHG_QTY \n");
		sbSql.append("     , DECODE(A.IMAGE_PATH,NULL,'N','Y') AS PIC_YN \n");
		sbSql.append("  FROM FMU_OP_RATE C, FMP_ORD_LIMIT E \n");
		sbSql.append("     ,(SELECT A.UPJANG, B.NEED_DATE \n");
		sbSql.append("            , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("            , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MIN_ORD_QTY,0,0,0.1),C.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("            , C.MAX_ORD_QTY \n");
			sbSql.append("            , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MULTIPLIER_QTY,0,0,0.1),C.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
  			sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		sbSql.append("            , C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH \n");
		sbSql.append("            , C.CONSUM_YN, C.CORN_YN, C.SPICE_YN \n");
		//sbSql.append("            , ROUND(SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY / 1000 / C.KG_CONVERT_RATE),2) AS DEF_QTY \n");
		sbSql.append("            , DECODE(NVL(B.ATTR01,'N'),'N', ROUND(SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY / 1000 / C.KG_CONVERT_RATE),2), 0) AS DEF_QTY \n");
		sbSql.append("            , COUNT(DECODE(NVL(B.PR_YN,'N'),'N',1,0)) AS CHG_QTY \n");
		sbSql.append("         FROM FMM_MENU A, FMM_RECIPE_ITEM B, FMS_ITEM_V C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD = B.MENU_CD \n");
		//식단발주에서 주문제외로 들어온 상품은 표시하지 않는다.
		sbSql.append("          AND NVL(B.ATTR01,'N') = 'N' --주문제외로 들어온 상품은 표시하지 않음. \n");
		sbSql.append("          AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		//sbSql.append("          AND A.MENU_CD LIKE '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "-" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("          AND B.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND B.PR_YN = 'N' \n");
		sbSql.append("        GROUP BY A.UPJANG, B.NEED_DATE, B.ATTR01 \n");
		sbSql.append("               , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		sbSql.append("               , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY, C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH, C.CONSUM_YN, C.CORN_YN, C.SPICE_YN) A \n");
		sbSql.append("     ,(SELECT /*+ LEADING(B A) USE_HASH(B A) USE_NL(C) USE_NL(K) USE_NL(O) */  " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE \n");
		sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
		sbSql.append("            ,(SELECT A.CODE_NAME FROM SCC_COMMON_CODE A WHERE A.GROUP_CODE = 'FS0033' AND A.CODE = O.ITEM_FEATURE) AS FEATURE_NAME \n");
		sbSql.append("         FROM \n");
		sbSql.append("             (SELECT /*+ INDEX(A PO_CONTRACT_FSALE_I2) */ * \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE (CENTER_CODE, CUSTCD, ITEM_CODE) NOT IN \n");
		sbSql.append("                     (SELECT /*+ UNNEST HASH_AJ */ CENTER_CODE, CUSTCD, ITEM_CODE \n");
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
		sbSql.append("             			   AND CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("             			   AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                         AND CONTRACT_START <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("                         AND EXISTS (\n");
		sbSql.append("                                     SELECT /*+ UNNEST HASH_AJ  */ 1\n");
		sbSql.append("                                     FROM HLDC_PO_TREAT_UPJANG X\n");
		sbSql.append("                                     WHERE X.ITEM_CODE = A.ITEM_CODE\n");
		sbSql.append("                                     AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("             ) A \n");
		sbSql.append("            ,(SELECT /*+ INDEX(A PO_CONTRACT_FSALE_I2) */ \n");
		sbSql.append("                     CENTER_CODE, UPJANG, ITEM_CODE, MAX(CONTRACT_START) AS CONTRACT_START \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                 AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                 AND ITEM_CODE > ' ' \n");
		sbSql.append("                 AND CONTRACT_START <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("                         AND EXISTS (\n");
		sbSql.append("                                     SELECT /*+ UNNEST HASH_AJ  */ 1\n");
		sbSql.append("                                     FROM HLDC_PO_TREAT_UPJANG X\n");
		sbSql.append("                                     WHERE X.ITEM_CODE = A.ITEM_CODE\n");
		sbSql.append("                                     AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("               GROUP BY CENTER_CODE, UPJANG, ITEM_CODE) B \n");
		sbSql.append("            ,(SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.ITEM_FEATURE \n");
		sbSql.append("                FROM FSI_ITEM_FEATURE A \n");
		sbSql.append("                   ,(SELECT CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
		sbSql.append("                       FROM FSI_ITEM_FEATURE \n");
		sbSql.append("                      WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                        AND APPLY_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),1)-1,'YYYYMMDD') \n");
		sbSql.append("                      GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE) B \n");
		sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("                 AND A.CUSTCD = B.CUSTCD \n");
		sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                 AND A.APPLY_DATE= B.APPLY_DATE) O \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("        WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("          AND A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.CONTRACT_START = B.CONTRACT_START \n");
		sbSql.append("          AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("          AND A.CENTER_CODE = O.CENTER_CODE(+) \n");
		sbSql.append("          AND A.CUSTCD = O.CUSTCD(+) \n");
		sbSql.append("          AND A.ITEM_CODE = O.ITEM_CODE(+) \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
		sbSql.append("            , 0 AS CENTER_CODE \n");
		sbSql.append("            , A.UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
		sbSql.append("            , NULL AS FEATURE_NAME \n");
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
		sbSql.append("      ) B \n");
		sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
		sbSql.append(" ORDER BY DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) DESC \n");
		sbSql.append("        , A.ITEM_CODE \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListTmp = this.makeDataSet(rs, "ds_ListTmp");
		
		pstmt.close();
		rs.close();
		//FileLog.println("d:\\BBB.txt", ds_ListTmp);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		//out 데이타(삭제된 데이터 조회 2010.07.09)
		DataSet ds_ListDel;
		//sql문 버퍼RESET
		sbSql.delete(0, sbSql.length());

		//3)삭제내역조회
		sbSql.append("SELECT /*삭제내역조회*/A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.UNIT_PRICE, B.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , B.SALE_PRICE, A.DEF_QTY, 0 AS PR_QTY \n");
		sbSql.append("     , 0 AS SALE_AMOUNT \n");
		sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, B.CUSTCD, B.CENTER_FLAG \n");
		sbSql.append("     , B.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
		sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
		sbSql.append("     , A.OTCUSTCD \n");
		//sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(B.SALE_PRICE + ROUND(B.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((B.SALE_PRICE + ROUND(B.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , 0 AS OP_AMOUNT \n");
		sbSql.append("     , 0 AS OP_AMOUNT_OLD \n");
		sbSql.append("     , B.D_DAYS, B.D_TIMES \n");
		//sbSql.append("     , 'D-'||TO_CHAR(B.D_DAYS) AS D_DAY_DISP \n");
		sbSql.append("     , DECODE(NVL(B.D_DAYS,0),0,'-','D-'||TO_CHAR(B.D_DAYS)) AS D_DAY_DISP \n");
		sbSql.append("     , A.KG_CONVERT_RATE \n");
		sbSql.append("     , A.IMAGE_PATH \n");
		sbSql.append("     , E.ITEM_CODE AS LIMIT_ITEM, E.LIMIT_REASON \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'계약안됨',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'D-'||TO_CHAR(B.D_DAYS),B.FEATURE_NAME),'주문불가('||E.LIMIT_REASON||')')) AS PR_REMARK \n");
		sbSql.append("     , DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) AS PR_POS \n");
		sbSql.append("     ,(SELECT X.MENU_ORD_YN \n");
		sbSql.append("         FROM FMP_WEEKLY_ITEM X \n");
		sbSql.append("        WHERE X.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND X.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("          AND NVL(DECODE(TO_CHAR(SYSDATE,'D'),1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT),'Y') = 'Y' \n");
		sbSql.append("          AND X.USE_YN = 'Y') MENU_ORD_YN \n");

		sbSql.append("     , 'Y' AS MENU_FLAG \n");
		sbSql.append("     , A.CONSUM_YN, A.CORN_YN, A.SPICE_YN \n");
		sbSql.append("     , NULL AS SAV_STAT \n");
		sbSql.append("     , A.CHG_QTY \n");
		sbSql.append("  FROM FMU_OP_RATE C, FMP_ORD_LIMIT E \n");
		sbSql.append("     ,(SELECT A.UPJANG, B.NEED_DATE \n");
		sbSql.append("            , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		//수량통제 안하는 업장의 경우 소숫점발주가 Y이면 무조건 최소발주량/발주승수량을 무조건 0.1로 세팅하여 조회
		if (strQtyYn.equals("N"))
		{
			sbSql.append("            , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MIN_ORD_QTY,0,0,0.1),C.MIN_ORD_QTY) AS MIN_ORD_QTY \n");
			sbSql.append("            , C.MAX_ORD_QTY \n");
			sbSql.append("            , DECODE(C.OTCUSTCD||C.POINT_FLAG,'0000Y',DECODE(C.MULTIPLIER_QTY,0,0,0.1),C.MULTIPLIER_QTY) AS MULTIPLIER_QTY \n");
		}
		else
  			sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
		sbSql.append("            , C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH \n");
		sbSql.append("            , C.CONSUM_YN, C.CORN_YN, C.SPICE_YN \n");
		sbSql.append("            , ROUND(SUM(A.EXPECT_MEAL_QTY * B.NEED_QTY / 1000 / C.KG_CONVERT_RATE),2) AS DEF_QTY \n");
		sbSql.append("            , COUNT(DECODE(NVL(B.PR_YN,'N'),'N',1,0)) AS CHG_QTY \n");
		sbSql.append("         FROM FMM_MENU A, FMM_RECIPE_ITEM B, FMS_ITEM_V C \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("          AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		//sbSql.append("          AND A.MENU_CD LIKE '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "-" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
		sbSql.append("          AND B.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("          AND B.PR_YN = 'Y' \n");
		sbSql.append("          AND B.PR_ID = -999 \n");
		sbSql.append("        GROUP BY A.UPJANG, B.NEED_DATE \n");
		sbSql.append("               , B.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.TAX_CODE, C.POINT_FLAG \n");
		sbSql.append("               , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY, C.OTCUSTCD, C.KG_CONVERT_RATE, C.IMAGE_PATH, C.CONSUM_YN, C.CORN_YN, C.SPICE_YN) A \n");
		sbSql.append("     ,(SELECT /*+ LEADING(B A) USE_HASH(B A) USE_NL(C) USE_NL(K) USE_NL(O) */ " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE \n");
		sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
		sbSql.append("            ,(SELECT A.CODE_NAME FROM SCC_COMMON_CODE A WHERE A.GROUP_CODE = 'FS0033' AND A.CODE = O.ITEM_FEATURE) AS FEATURE_NAME \n");
		sbSql.append("         FROM \n");
		sbSql.append("             (SELECT /*+ INDEX(A PO_CONTRACT_FSALE_I2) */ * \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE (CENTER_CODE, CUSTCD, ITEM_CODE) NOT IN \n");
		sbSql.append("                     (SELECT /*+ UNNEST HASH_AJ */ CENTER_CODE, CUSTCD, ITEM_CODE \n");
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
		sbSql.append("             			   AND CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("             			   AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                         AND CONTRACT_START <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("                         AND EXISTS (\n");
		sbSql.append("                                     SELECT /*+ UNNEST HASH_AJ  */ 1\n");
		sbSql.append("                                     FROM HLDC_PO_TREAT_UPJANG X\n");
		sbSql.append("                                     WHERE X.ITEM_CODE = A.ITEM_CODE\n");
		sbSql.append("                                     AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("             ) A \n");
		sbSql.append("            ,(SELECT /*+ DRIVING_SITE(A) INDEX(A PO_CONTRACT_FSALE_PK) */ \n");
		sbSql.append("                     CENTER_CODE, UPJANG, ITEM_CODE, MAX(CONTRACT_START) AS CONTRACT_START \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                 AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                 AND ITEM_CODE > ' ' \n");
		sbSql.append("                 AND CONTRACT_START <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("                         AND EXISTS (\n");
		sbSql.append("                                     SELECT /*+ UNNEST HASH_AJ  */ 1\n");
		sbSql.append("                                     FROM HLDC_PO_TREAT_UPJANG X\n");
		sbSql.append("                                     WHERE X.ITEM_CODE = A.ITEM_CODE\n");
		sbSql.append("                                     AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("               GROUP BY CENTER_CODE, UPJANG, ITEM_CODE) B \n");
		sbSql.append("            ,(SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.ITEM_FEATURE \n");
		sbSql.append("                FROM FSI_ITEM_FEATURE A \n");
		sbSql.append("                   ,(SELECT CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
		sbSql.append("                       FROM FSI_ITEM_FEATURE \n");
		sbSql.append("                      WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                        AND APPLY_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD'),1)-1,'YYYYMMDD') \n");
		sbSql.append("                      GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE) B \n");
		sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("                 AND A.CUSTCD = B.CUSTCD \n");
		sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                 AND A.APPLY_DATE= B.APPLY_DATE) O \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("        WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("          AND A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.CONTRACT_START = B.CONTRACT_START \n");
		sbSql.append("          AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("          AND A.CENTER_CODE = O.CENTER_CODE(+) \n");
		sbSql.append("          AND A.CUSTCD = O.CUSTCD(+) \n");
		sbSql.append("          AND A.ITEM_CODE = O.ITEM_CODE(+) \n");
		sbSql.append("       ----------- \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       ----------- \n");
		sbSql.append("       SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , A.ITEM_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
		sbSql.append("            , 0 AS CENTER_CODE \n");
		sbSql.append("            , A.UNIT_PRICE \n");
		sbSql.append("            , A.SALE_PRICE \n");
		sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
		sbSql.append("            , DECODE( SIGN(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
		sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
		sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
		sbSql.append("            , NULL AS FEATURE_NAME \n");
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
		sbSql.append("      ) B \n");
		sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
		sbSql.append(" ORDER BY DECODE(B.ITEM_CODE,NULL,'N',DECODE(E.ITEM_CODE,NULL,DECODE(SIGN(B.D_DAYS-(TO_DATE(A.NEED_DATE,'YYYYMMDD')-TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'))),1,'N','Y'),'N')) DESC \n");
		sbSql.append("        , A.ITEM_CODE \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListDel = this.makeDataSet(rs, "ds_ListDel");
		
		pstmt.close();
		rs.close();
		//FileLog.println("d:\\BBB.txt", ds_ListTmp);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		/**종료**/
		out_dl.add(ds_List);
		out_dl.add(ds_ListTmp);
		out_dl.add(ds_ListDel);
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
