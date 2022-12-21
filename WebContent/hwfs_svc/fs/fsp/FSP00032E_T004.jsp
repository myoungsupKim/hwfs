<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/구매신청/구매신청서작성/식자재구매신청(자동)-자재추가
■ 프로그램ID   : FSP00032E_T004.jsp
■ 프로그램명   : 자재추가
■ 작성일자     : 2008-01-28
■ 작성자       : 김동표
■ 이력관리     : 2008-01-28
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
기획자재 배분 안함, 기획자재(명칭이 ▶으로 시작)인 경우 조회상단에 뜨게.
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@page import="java.math.BigDecimal"%>
<%
    Statement stmt             =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        DataSet ds_condi_popup        = in_dl.get("ds_condi_popup");

        String ITEM_CLASS4          = nullToBlank(ds_condi_popup.getString(0, "ITEM_CLASS4"));
        String PR_DATE              = nullToBlank(ds_condi_popup.getString(0, "PR_DATE"));
        String NEED_DATE            = nullToBlank(ds_condi_popup.getString(0, "NEED_DATE"));
        String SUBINV_CODE          = nullToBlank(ds_condi_popup.getString(0, "SUBINV_CODE"));
        String UPJANG               = nullToBlank(ds_condi_popup.getString(0, "UPJANG"));
        String AP_UNITPRICE_UPJANG  = nullToBlank(ds_condi_popup.getString(0, "AP_UNITPRICE_UPJANG"));
        String CENTER_CODE          = nullToBlank(ds_condi_popup.getString(0, "CENTER_CODE"));

        DataSet ds_out;
        StringBuffer sbSelSql = new StringBuffer();
        
        if(CENTER_CODE.equals(""))
        {
	        sbSelSql.delete(0, sbSelSql.length());
	        sbSelSql.append("SELECT C.CENTER_CODE                                                \n");
	        sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY A, ST_UPJANG B, HLDC_PO_UPJANG_CENTER C \n");
	        sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                          \n");
	        sbSelSql.append("   AND B.AP_UNITPRICE_UPJANG = C.UPJANG                             \n");
	        sbSelSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "'                        \n");
	
	        stmt = conn.createStatement();
	        rs = stmt.executeQuery(sbSelSql.toString());
			rs.next();
			
	        CENTER_CODE         = rs.getString("CENTER_CODE");
	        
	        rs.close();
	        stmt.close();
			
        }

        sbSelSql.delete(0, sbSelSql.length());

        sbSelSql.append("\n                                                                                                                                                                     \n");
        sbSelSql.append("SELECT                                                                                                                                               \n");
        sbSelSql.append("       A.ITEM_CODE                                                                                                                                                     \n");
        sbSelSql.append("     , A.ITEM_NAME                                                                                                                                                     \n");
        sbSelSql.append("     , A.ITEM_CLASS4                                                                                                                                                   \n");
        sbSelSql.append("     , FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, '" + NEED_DATE + "'), A.PB_YN, A.ECO_ITEM, A.MANUF_CD) AS FEATURE_NAME              \n");
        sbSelSql.append("     , A.ITEM_SIZE                                                                                                                                                     \n");
        sbSelSql.append("     , A.PO_UOM                                                                                                                                                        \n");
        sbSelSql.append("     , 0 KG_QTY                                                                                                                                                        \n");
        sbSelSql.append("     , 0 ONHAND_QTY                                                                                                                                                    \n");
        sbSelSql.append("     , 0 CANCEL_PR_QTY                                                                                                                                                 \n");
        sbSelSql.append("     , 0 PR_QTY                                                                                                                                                        \n");
        sbSelSql.append("     , 0 TOT_AMT                                                                                                                                                       \n");
        sbSelSql.append("     , A.G_ITEM_PRICE /* g당 단가 = 출하율적용단가 / Kg 환산율 / 1000 */                                                                                               \n");
        sbSelSql.append("     , A.TAX_CODE                                                                                                                                                      \n");
        sbSelSql.append("     , A.CENTER_FLAG                                                                                                                                                   \n");
        sbSelSql.append("     , A.PR_REMARK                                                                                                                                                        \n");
        sbSelSql.append("     , A.REMARK                                                                                                                                                        \n");
        sbSelSql.append("     , A.POINT_FLAG                                                                                                                                                    \n");
        sbSelSql.append("     , '" + SUBINV_CODE + "' SUBINV_CODE                                                                                                                               \n");
        sbSelSql.append("     , '" + NEED_DATE   + "' NEED_DATE                                                                                                                                 \n");
        sbSelSql.append("     , A.UPJANG                                                                                                                                                        \n");
        sbSelSql.append("     , B.DEPT_ID                                                                                                                                                       \n");
        sbSelSql.append("     , A.ACCTCD         /* 입고 계정 코드(대표) : MATERIAL_ACCTCD */                                                                                                   \n");
        sbSelSql.append("     , A.BUD_CLS        /* 예산 조직 cc 코드 : BUDCC_CD */                                                                                                             \n");
        sbSelSql.append("     , B.MU_CD                                                                                                                                                         \n");
        sbSelSql.append("     , A.INVAT_FLAG                                                                                                                                                    \n");
        sbSelSql.append("     , A.OUTVAT_FLAG                                                                                                                                                   \n");
        sbSelSql.append("     , A.MIN_ORD_QTY                                                                                                                                                   \n");
        sbSelSql.append("     , A.MAX_ORD_QTY                                                                                                                                                   \n");
        sbSelSql.append("     , A.CENTER_CODE      /* 센터코드 */                                                                                                                               \n");
        sbSelSql.append("     , A.STOCK_FLAG                                                                                                                                                    \n");
        sbSelSql.append("     , A.BARCODE                                                                                                                                                       \n");
        sbSelSql.append("     , NVL(A.MULTIPLIER_QTY, 0) AS MULTIPLIER_QTY                                                                                                                      \n");
        sbSelSql.append("     , A.BUD_CLS AS BUDDEPT_ID  /* 예산 조직 cc 코드 : BUDCC_CD - 고도화에서 부서코드가 CC로 대체됨 */                                                                 \n");
        sbSelSql.append("     , A.USE_YN                                                                                                                                                        \n");
        sbSelSql.append("     , DECODE(A.CUSTCD, NULL, 'N', 'Y') AS CONTRACT_YN                                                                                                                 \n");
        sbSelSql.append("     , NVL(TO_NUMBER(A.MARGIN_PRICE), 0) AS MARGIN_PRICE     /* 출하율적용단가 */                                                                                                 \n");
        sbSelSql.append("     , A.UNIT_PRICE       /* 구매(매입)단가 */                                                                                                                         \n");
        sbSelSql.append("     , A.CUSTCD           /* 매입거래처코드 */                                                                                                                         \n");
        sbSelSql.append("     , A.KG_CONVERT_RATE                                                                                                                                               \n");
        sbSelSql.append("     , A.MARGIN_RATE                                                                                                                                                   \n");
        sbSelSql.append("     , NVL(A.MARGIN_PRICE, 0) / KG_CONVERT_RATE / 1000 AS GRAM_PRICE                                                                                                   \n");
        sbSelSql.append("     , A.AP_UNITPRICE_UPJANG                                                                                                                                           \n");
        sbSelSql.append("     , D.RESTRICT_PERIOD                                                                                                                                               \n");
        sbSelSql.append("     , D.RESTRICT_REASON                                                                                                                                               \n");
        sbSelSql.append("     , NULL DUTY_END_DATE                                                                                                                                              \n");
        sbSelSql.append("     , 0 MIN_DUTY_QTY                                                                                                                                                  \n");
        sbSelSql.append("     , 0 DUTY_QTY                                                                                                                                                      \n");
        sbSelSql.append("     , 0 REAL_USE_QTY                                                                                                                                                  \n");
        sbSelSql.append("     , '' PR_YN                                                                                                                                                        \n");
        sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', G.OPER_ORG_SN_PURC, A.UPJANG_GRP, A.ITEM_CODE, '" + NEED_DATE +    "') = 'CK' THEN 'Y' ELSE 'N' END    \n");
        sbSelSql.append("                                                    AS SHP_MAP  /* 자재 업장군 맵핑 유효성 체크 CE : 맵핑안되어있음(사용불가), CK : 맵핑되어있음(사용가능) */          \n");
        sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) = 'UP' THEN 'Y' ELSE 'N' END                                                                     \n");
        sbSelSql.append("                                                    AS MTG_UNS      /* 자재불용체크 UK: 불용, UP:불용아님, NN: DATA NOT FOUND */                                       \n");
        sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') = 'TP' THEN 'Y' ELSE 'N' END                                                               \n");
        sbSelSql.append("                                                    AS MTG_STP      /* 자재 중지체크 TK : 중지(사용불가), TP : 중지아님(사용가능), NN: DATA NOT FOUND */               \n");
        sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', G.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', '" + NEED_DATE +    "') = 'XR' THEN 'Y' ELSE 'N' END                         \n");
        sbSelSql.append("                                                    AS REQ_WKD      /* 요일별 신청불가 체크 XE : 신청불가(사용불가), XR : 신청가능(사용가능), NN : DATA NOT FOUND */   \n");
        sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', G.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', NVL(C.D_DAY, 0), NVL(C.D_TIMES, 0), '"+ PR_DATE+"', '" +   NEED_DATE + "') = 'HK' THEN 'Y' ELSE 'N' END                            \n");
        sbSelSql.append("                                                    AS SCH          /* 수발주 스케쥴에 따른 유효성 체크 HE : 신청불가(사용불가), HK : 신청가능(사용가능), NN : DATA NOT FOUND */                   \n");
        sbSelSql.append("     , NVL(C.D_DAYS,0)  AS D_DAY                                                                                                                                    \n");
        sbSelSql.append("     , DECODE(C.D_DAYS,NULL,   0, DECODE(SIGN(TO_DATE('" + NEED_DATE + "', 'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) , 0, \n");
        sbSelSql.append("                                  DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0, 24, C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))), 1, 0, 1), 0) + NVL(C.D_DAYS, 0)) AS D_DAYS       \n");
        sbSelSql.append("     , DECODE(C.D_DAYS,NULL,   0, DECODE(C.D_TIMES, '', 24, 0, 24, C.D_TIMES)) AS D_TIMES                                                                              \n");
        sbSelSql.append("     , DECODE(C.D_DAYS,NULL,'Y', \n");
        sbSelSql.append("                       DECODE( SIGN(TO_DATE('" + NEED_DATE + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
        sbSelSql.append("                              ,-1, 'N' \n");
        sbSelSql.append("                              , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',24,0,24,C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),-1,'N',0,'N','C') \n");
        sbSelSql.append("                              , 1, 'Y' \n");
        sbSelSql.append("                       ) \n");
        sbSelSql.append("               ) \n");
        sbSelSql.append("         AS D_DAY_YN \n");
        sbSelSql.append("     , A.SPICE_YN                                                                                                                                                        \n");
        sbSelSql.append("     , A.CORN_YN                                                                                                                                                         \n");
        sbSelSql.append("     , A.IMG_PATH                                                                                                                                                        \n");
        sbSelSql.append("     , A.ORIGIN_NAT                                                                                                                                                      \n");
        sbSelSql.append("     , A.ORIGIN_TYPE                                                                                                                                                     \n");
        sbSelSql.append("     , A.VD_SN                                                                                                                                                           \n");
        sbSelSql.append("     , A.APPLY_SD                                                                                                                                                        \n");
        sbSelSql.append("     , SCC_SOPR_AGG_FUN('" + SUBINV_CODE + "', A.ITEM_CODE, 1) AS AGG_QTY                                                                                                \n");
        sbSelSql.append("     , A.UPJANG_GRP                                                                                                                                                      \n");
        sbSelSql.append("     , 0 AS IS_ENF                                                                                                                                                       \n");
        sbSelSql.append("     , CASE WHEN H.G_PRICE < A.G_ITEM_PRICE THEN 'Y' ELSE 'N' END AS CHEAP_YN                                                                                            \n");
        sbSelSql.append("  FROM (                                                                                                                                                                 \n");
        sbSelSql.append("        SELECT  C.ITEM_CODE                                                                                                                                              \n");
        sbSelSql.append("              , C.ITEM_NAME                                                                                                                                              \n");
        sbSelSql.append("              , C.ITEM_CLASS4                                                                                                                                            \n");
        sbSelSql.append("              , C.ITEM_SIZE                                                                                                                                              \n");
        sbSelSql.append("              , C.PO_UOM                                                                                                                                                 \n");
        sbSelSql.append("              , C.TAX_CODE                                                                                                                                               \n");
        sbSelSql.append("              , A.PROC_TYP_CD  AS  CENTER_FLAG                                                                                                                           \n");
        sbSelSql.append("              , '' AS PR_REMARK                                                                                                                                             \n");
        sbSelSql.append("              , '' AS REMARK                                                                                                                                             \n");
        sbSelSql.append("              , C.POINT_FLAG                                                                                                                                             \n");
        sbSelSql.append("              , B.UPJANG                                                                                                                                                 \n");
        sbSelSql.append("              , B.INVAT_FLAG                                                                                                                                             \n");
        sbSelSql.append("              , B.OUTVAT_FLAG                                                                                                                                            \n");
        sbSelSql.append("              , C.MIN_ORD_QTY                                                                                                                                            \n");
        sbSelSql.append("              , C.MAX_ORD_QTY                                                                                                                                            \n");
        sbSelSql.append("              , A.CENTER_CODE      /* 센터코드 */                                                                                                                        \n");
        sbSelSql.append("              , B.STOCK_FLAG                                                                                                                                             \n");
        sbSelSql.append("              , C.BARCODE                                                                                                                                                \n");
        sbSelSql.append("              , C.MULTIPLIER_QTY                                                                                                                                         \n");
        sbSelSql.append("              , C.USE_YN                                                                                                                                                 \n");
        sbSelSql.append("              , TO_NUMBER(DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, (ROUND((A.CONTRACT_PRICE + (A.CONTRACT_PRICE * A.MARGIN_RATE / 100)) / 10) * 10))) AS MARGIN_PRICE    \n");
        sbSelSql.append("              , A.CONTRACT_PRICE AS UNIT_PRICE       /* 구매(매입)단가 */                                                                                                \n");
        sbSelSql.append("              , ROUND(NVL(DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, ROUND((A.CONTRACT_PRICE + (A.CONTRACT_PRICE * A.MARGIN_RATE / 100)) / 10) * 10) / NVL(C.KG_CONVERT_RATE, 1) / 1000, 0), 2) AS G_ITEM_PRICE \n");
        sbSelSql.append("              , A.CUSTCD           /* 매입거래처코드 */                                                                                                                  \n");
        sbSelSql.append("              , NVL(C.KG_CONVERT_RATE, 1) KG_CONVERT_RATE                                                                                                                \n");
        sbSelSql.append("              , A.MARGIN_RATE                                                                                                                                            \n");
        sbSelSql.append("              , A.UPJANG AS AP_UNITPRICE_UPJANG                                                                                                                          \n");
        sbSelSql.append("              , C.SPICE_YN                                                                                                                                               \n");
        sbSelSql.append("              , C.CORN_YN                                                                                                                                                \n");
        sbSelSql.append("              , C.IMG_PATH                                                                                                                                               \n");
        sbSelSql.append("              , C.ORIGIN_NAT                                                                                                                                             \n");
        sbSelSql.append("              , C.ORIGIN_TYPE                                                                                                                                            \n");
        sbSelSql.append("              , B.MATERIAL_ACCTCD AS ACCTCD                                                                                                                              \n");
        sbSelSql.append("              , B.BUDCC_CD AS BUD_CLS                                                                                                                                    \n");
        sbSelSql.append("              , A.DUTY_YN                                                                                                                                                \n");
        //sbSelSql.append("              , C.PB_YN                                                                                                                                                \n");
        //PB_YN을 계약에서 가져옴 (2015.08.29)
        sbSelSql.append("              , A.PB_YN                                                                                                                                                  \n");
        sbSelSql.append("              , C.MANUF_CD                                                                                                                                               \n");
        sbSelSql.append("              , C.ECO_ITEM                                                                                                                                               \n");
        sbSelSql.append("              , A.VD_SN                                                                                                                                                  \n");
        sbSelSql.append("              , A.APPLY_SD                                                                                                                                               \n");
        sbSelSql.append("              , A.UPJANG_GRP                                                                                                                                             \n");
        sbSelSql.append("           FROM HLDC_PO_CONTRACT_F A                                                                                                                                     \n");
        sbSelSql.append("              , HLDC_PO_SUBINVENTORY B                                                                                                                                   \n");
        sbSelSql.append("              , HLDC_PO_ITEM_MST C                                                                                                                                       \n");
        sbSelSql.append("          WHERE A.UPJANG       = B.UPJANG                                                                                                                                \n");
        sbSelSql.append("            AND A.ITEM_CODE    = C.ITEM_CODE                                                                                                                             \n");
        sbSelSql.append("            AND A.CENTER_CODE  = '" + CENTER_CODE + "'                                                                                                                   \n");
        sbSelSql.append("            AND A.UPJANG       = '" + UPJANG      + "'                                                                                                                   \n");
        sbSelSql.append("            AND '" + NEED_DATE + "' BETWEEN A.CONTRACT_START(+) AND A.CONTRACT_END(+)                                                                                    \n");
        sbSelSql.append("            AND B.SUBINV_CODE  = '" + SUBINV_CODE + "'                                                                                                                   \n");
        sbSelSql.append("            AND C.ITEM_CLASS4  = '" + ITEM_CLASS4 + "'                                                                                                                   \n");
        sbSelSql.append("       ) A                                                                                                                                                               \n");
        sbSelSql.append("     , SCO_UPJANG_MST_V B                                                                                                                                                \n");
        sbSelSql.append("     ,(SELECT A.CENTER_CODE                                                                                                                                              \n");
        sbSelSql.append("            , A.ITEM_CODE                                                                                                                                                \n");
        sbSelSql.append("            ,(SELECT TO_DATE('" + NEED_DATE + "','YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')                                                                        \n");
        sbSelSql.append("                FROM (SELECT ROW_NUMBER() OVER(ORDER BY Z.CD_SY||Z.CD_SM||Z.CD_SD DESC) AS SEQ                                                                           \n");
        sbSelSql.append("                           , Z.CD_SY||Z.CD_SM||Z.CD_SD AS NONHOLI_DATE                                                                                                   \n");
        sbSelSql.append("                        FROM SCC_CALENDA_DATA Z                                                                                                                          \n");
        sbSelSql.append("                       WHERE Z.CD_SY||Z.CD_SM||Z.CD_SD < '" + NEED_DATE + "'                                                                                             \n");
        sbSelSql.append("                         AND Z.CD_SY BETWEEN TO_NUMBER(SUBSTR('" + NEED_DATE + "', 1, 4)) - 1 AND TO_NUMBER(SUBSTR('" + NEED_DATE + "', 1, 4))                           \n");
        sbSelSql.append("                      -- AND Z.HOLIDAY NOT IN (1,2) --일요일 제외한 국가 공휴일 (일요일만 체크, 그 외 공유일은 상관없음(김진희))                                         \n");
        sbSelSql.append("                         AND Z.CD_WEEK NOT IN ('일')) Z                                                                                                                  \n");
        sbSelSql.append("               WHERE Z.SEQ = A.D_DAYS ) AS D_DAYS                                                                                                                        \n");
        sbSelSql.append("             , A.D_DAYS  AS D_DAY                                                                                                                                        \n");
        sbSelSql.append("             , A.D_TIMES                                                                                                                                                 \n");
        sbSelSql.append("          FROM HLDC_PO_PREORDER_LIST A                                                                                                                                   \n");
        sbSelSql.append("         WHERE A.CENTER_CODE = '" + CENTER_CODE + "'                                                                                                                     \n");
        sbSelSql.append("       ) C                      /* 선발주 제한 */                                                                                                                        \n");
        sbSelSql.append("     , (                                                                                                                                                                 \n");
        sbSelSql.append("        SELECT UPJANG                                                                                                                                                    \n");
        sbSelSql.append("             , ITEM_CODE                                                                                                                                                 \n");
        sbSelSql.append("             , TO_CHAR(TO_DATE(RESTRICT_START, 'YYYYMMDD'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(RESTRICT_END, 'YYYYMMDD'), 'YYYY.MM.DD') AS RESTRICT_PERIOD          \n");
        sbSelSql.append("             , RESTRICT_REASON                                                                                                                                           \n");
        sbSelSql.append("          FROM FSI_RESTRICT_SET                                                                                                                                          \n");
        sbSelSql.append("         WHERE UPJANG = " + UPJANG + "                                                                                                                                   \n");
        sbSelSql.append("           AND (RESTRICT_START <= '" + NEED_DATE + "' AND RESTRICT_END >= '" + NEED_DATE + "')                                                                           \n");
        sbSelSql.append("           AND NOT (CNL_START IS NOT NULL AND CNL_START  <= '" + NEED_DATE + "' AND CNL_END      >= '" + NEED_DATE + "')                                                 \n");
        sbSelSql.append("       ) D                      /* 금지자재 */                                                                                                                           \n");
        sbSelSql.append("     , (                                                                                                                                                                 \n");
        sbSelSql.append("        SELECT                                                                                                                                                \n");
        sbSelSql.append("               CENTER_CODE                                                                                                                                               \n");
        sbSelSql.append("             , CUSTCD                                                                                                                                                    \n");
        sbSelSql.append("             , ITEM_CODE                                                                                                                                                 \n");
        sbSelSql.append("             , 'N' PR_YN                                                                                                                                                 \n");
        sbSelSql.append("          FROM HLDC_PO_ORDER_SCHEDULE Z                                                                                                                                    \n");
        sbSelSql.append("         WHERE CENTER_CODE = '" + CENTER_CODE + "'                                                                                                                       \n");
        sbSelSql.append("           AND UPJANG      = " + AP_UNITPRICE_UPJANG + "                                                                                                                 \n");
        sbSelSql.append("           AND UPJANG_TYPE = '01' /* 업장유형코드 01:직영, 02:고객 */                                                                                                    \n");
        sbSelSql.append("           AND USE_YN      = 'Y'                                                                                                                                         \n");
        sbSelSql.append("           AND DECODE(TO_CHAR(TO_DATE('" + NEED_DATE + "', 'YYYYMMDD'), 'D'), 1, SUN, 2, MON, 3, TUE, 4, WED, 5, THU, 6, FRI, 7, SAT) = 'Y'                              \n");
        sbSelSql.append("       ) F                                                                                                                                                               \n");
        sbSelSql.append("     , VO_CENTER G                                                                                                                                                       \n");
        sbSelSql.append("    , (                                                                                                                                                                  \n");
        sbSelSql.append("       SELECT ITEM_CLASS4, MIN(G_PRICE) AS G_PRICE                                                                                         \n");
        sbSelSql.append("         FROM (                                                                                                                                                          \n");
        sbSelSql.append("               SELECT C.ITEM_CLASS4                                                                                                                                      \n");
        sbSelSql.append("                    , ROUND(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, (ROUND((B.CONTRACT_PRICE + (B.CONTRACT_PRICE * B.MARGIN_RATE / 100)) / 10) * 10)) / DECODE(C.KG_CONVERT_RATE, 0, 1, C.KG_CONVERT_RATE) / 1000, 2) G_PRICE   \n");
        sbSelSql.append("                 FROM ST_UPJANG A                                                                                                                                        \n");
        sbSelSql.append("                    , HLDC_PO_CONTRACT_F B                                                                                                                               \n");
        sbSelSql.append("                    , HLDC_PO_ITEM_MST C                                                                                                                                 \n");
        sbSelSql.append("                WHERE B.ITEM_CODE = C.ITEM_CODE                                                                                                                          \n");
        sbSelSql.append("                  AND B.USE_YN    = 'Y'                                                                                                                                  \n");
        sbSelSql.append("                  AND B.CONTRACT_PRICE > 0                                                                                                                               \n");
        sbSelSql.append("                  AND B.UPJANG    = A.AP_UNITPRICE_UPJANG                                                                                                                \n");
        sbSelSql.append("                  AND '" + NEED_DATE + "' BETWEEN B.CONTRACT_START AND B.CONTRACT_END                                                                                                                \n");
        sbSelSql.append("                  AND A.UPJANG    = " + UPJANG + "                                                                                                                       \n");
        sbSelSql.append("               )                                                                                                                                                         \n");
        sbSelSql.append("        GROUP BY ITEM_CLASS4                                                                                                              \n");
        sbSelSql.append("      ) H                                                                                                                                                                \n");
        sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                                                               \n");
        sbSelSql.append("   AND A.CENTER_CODE = C.CENTER_CODE(+)                                                                                                                                  \n");
        sbSelSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE  (+)                                                                                                                                  \n");
        sbSelSql.append("   AND A.ITEM_CODE   = D.ITEM_CODE  (+)                                                                                                                                  \n");
        sbSelSql.append("   AND A.CENTER_CODE = F.CENTER_CODE(+)                                                                                                                                  \n");
        sbSelSql.append("   AND A.CUSTCD      = F.CUSTCD     (+)                                                                                                                                  \n");
        sbSelSql.append("   AND A.ITEM_CODE   = F.ITEM_CODE  (+)                                                                                                                                  \n");
        sbSelSql.append("   AND A.CENTER_CODE = G.CENTER_CODE(+)                                                                                                                                  \n");
        sbSelSql.append("   AND A.ITEM_CLASS4 = H.ITEM_CLASS4(+)                                                                                                                                  \n");
        sbSelSql.append(" ORDER BY A.ITEM_CLASS4, A.ITEM_NAME, A.ITEM_CODE                                                                                                                                                    \n");
        sbSelSql.append("\n                                                                                                                                                                       \n");
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sbSelSql.toString());

        DataSet ds_add_itam = this.makeDataSet(rs,"ds_add_itam");

        // remart 생성
        String sRemark = "";
        if(ds_add_itam.getRowCount() > 0)
        {
            for(int i=0; i < ds_add_itam.getRowCount(); i++)
            {
                BigDecimal nMagPrice = ds_add_itam.getBigDecimal(i, "MARGIN_PRICE");
                BigDecimal nPrQty    = ds_add_itam.getBigDecimal(i, "PR_QTY");

                // 계약여부
                if(ds_add_itam.getString(i, "SHP_MAP").equals("N"))
                {
                    ds_add_itam.set(i, "PR_REMARK", "단가계약 안됨");
                    ds_add_itam.set(i, "PR_YN" , "A");
                    ds_add_itam.set(i, "PR_QTY", 0);
                }
                // 불용자재
                else if(ds_add_itam.getString(i, "MTG_UNS").equals("N"))
                {
                    ds_add_itam.set(i, "PR_REMARK", "불용자재");
                    ds_add_itam.set(i, "PR_YN" , "B");
                    ds_add_itam.set(i, "PR_QTY", 0);
                }
                // 중지자재
                else if(ds_add_itam.getString(i, "MTG_STP").equals("N"))
                {
                    ds_add_itam.set(i, "PR_REMARK", "중지자재");
                    ds_add_itam.set(i, "PR_YN" , "B");
                    ds_add_itam.set(i, "PR_QTY", 0);
                }

                // 요일제한
                else if(ds_add_itam.getString(i, "REQ_WKD").equals("N"))
                {
                    ds_add_itam.set(i, "PR_REMARK", "요일제한");
                    ds_add_itam.set(i, "PR_YN" , "A");
                    ds_add_itam.set(i, "PR_QTY", 0);
                }

                else if(nullToBlank(ds_add_itam.getString(i, "RESTRICT_PERIOD")).length() > 0)
                {
                    sRemark =   "금지자재(" + ds_add_itam.getString(i,"RESTRICT_PERIOD")    +   ", " + ds_add_itam.getString(i,"RESTRICT_REASON") + ")";
                    ds_add_itam.set(i, "PR_REMARK", sRemark);
                    ds_add_itam.set(i, "PR_YN" , "C");
                    ds_add_itam.set(i, "PR_QTY", 0);
                }

                else if(ds_add_itam.getString(i, "SCH").equals("N"))
                {
                    sRemark = "수발주제한";
                    ds_add_itam.set(i, "PR_REMARK", sRemark);
                    ds_add_itam.set(i, "PR_YN" , "A");
                    ds_add_itam.set(i, "PR_QTY", 0);
                    
                }
                else
                {
                    ds_add_itam.set(i, "PR_YN" , "Y");
                }
                ds_add_itam.set(i, "TOT_AMT", nMagPrice.multiply(nPrQty));
            }
        }
        out_dl.add(ds_add_itam);

        this.setResultMessage(0, "OK",out_vl);

    } catch(Exception ex) {
        ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(),out_vl);
        } finally {
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
            if(stmt != null) {
                try {
                    stmt.close();
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