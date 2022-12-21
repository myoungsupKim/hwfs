
<%@page import="com.google.gson.internal.bind.BigDecimalTypeAdapter"%>
<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/구매신청/구매신청서작성/식자재구매신청(자동)
■ 프로그램ID   : FSP00032E_T002.jsp
■ 프로그램명   : 자재추가
■ 작성일자     : 2015-06-01
■ 작성자       : 정영철
■ 이력관리     :
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@page import="java.math.BigDecimal"%>

<%
    Statement stmt =  null;
    try {
            PlatformRequest platformRequest = this.proc_input(request);
            in_vl = platformRequest.getData().getVariableList();
            in_dl = platformRequest.getData().getDataSetList();

            //jsp log 서비스 시작
            logger.startIndividualLog(in_vl.getString("titLogId"));

            DataSet ds_condi               = in_dl.get("ds_condi");

            String TYPE         = nullToBlank(ds_condi.getString(0, "TYPE"));		// 자제 조회
            String PR_NUM       = nullToBlank(ds_condi.getString(0, "PR_NUM"));
            String PR_DATE      = nullToBlank(ds_condi.getString(0, "PR_DATE"));
            String NEED_DATE    = nullToBlank(ds_condi.getString(0, "NEED_DATE"));
            String SUBINV_CODE  = nullToBlank(ds_condi.getString(0, "SUBINV_CODE"));
            String SORT_TYPE    = nullToBlank(ds_condi.getString(0, "SORT_TYPE"));

            DataSet ds_info, ds_out;
            StringBuffer sbSelSql = new StringBuffer();

            sbSelSql.delete(0, sbSelSql.length());
            sbSelSql.append("SELECT A.UPJANG                                                                                \n");
            sbSelSql.append("     , B.AP_UNITPRICE_UPJANG                                                                   \n");
            sbSelSql.append("     , c.CENTER_CODE                                                                           \n");
            sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY A                                                                  \n");
            sbSelSql.append("     , ST_UPJANG B                                                                             \n");
            sbSelSql.append("     , HLDC_PO_UPJANG_CENTER C                                                                 \n");
            sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                     \n");
            sbSelSql.append("   AND B.AP_UNITPRICE_UPJANG = C.UPJANG                                                        \n");
            sbSelSql.append("   AND SUBINV_CODE = '" + SUBINV_CODE + "'                                                     \n");

            stmt = conn.createStatement();
            rs = stmt.executeQuery(sbSelSql.toString());

            ds_info = this.makeDataSet(rs,"ds_info");

            rs.close();
            stmt.close();

            String UPJANG              = ds_info.getString(0,"UPJANG");
            String CENTER_CODE         = ds_info.getString(0,"CENTER_CODE");
            String AP_UNITPRICE_UPJANG = ds_info.getString(0,"AP_UNITPRICE_UPJANG");

            if(nullToBlank(UPJANG).equals(""))
            {
                    out_vl.add("v_out", "창고에 업장이 연결되지 않았습니다.\n구매관리자에게 연락하세요.");
                    this.setResultMessage(0, "OK",out_vl);
                    return;
            }
            else if(nullToBlank(AP_UNITPRICE_UPJANG).equals(""))
            {
                    out_vl.add("v_out", "단가계약업장이 연결되지 않았습니다.\n구매관리자에게 연락하세요.");
                    this.setResultMessage(0, "OK",out_vl);
                    return;
            }
            else if(nullToBlank(CENTER_CODE).equals(""))
            {
                    out_vl.add("v_out", "센터에 업장이 연결되지 않았습니다.\n구매관리자에게 연락하세요.");
                    this.setResultMessage(0, "OK",out_vl);
                    return;
            }

            sbSelSql.delete(0, sbSelSql.length());
            sbSelSql.append("\n                                                                                                                                                                     \n");
            sbSelSql.append("SELECT                                                                                                                                                              \n");
            sbSelSql.append("       '' AS PR_NUM                                                                                                                                                    \n");
            sbSelSql.append("     , '' AS PR_ID                                                                                                                                                     \n");
            sbSelSql.append("     , A.ITEM_CODE                                                                                                                                                     \n");
            sbSelSql.append("     , A.ITEM_NAME                                                                                                                                                     \n");
            sbSelSql.append("     , A.ITEM_CLASS4                                                                                                                                                   \n");
            sbSelSql.append("     , FN_ITEM_FEATURE_ICON(A.DUTY_YN, A.PB_YN, A.ECO_ITEM, A.MANUF_CD) AS FEATURE_NAME                                                                                \n");
            sbSelSql.append("     , A.ITEM_SIZE                                                                                                                                                     \n");
            sbSelSql.append("     , A.PO_UOM                                                                                                                                                        \n");
            sbSelSql.append("     , ROUND(NVL(A.EXPECT_GRAM_QTY / 1000 / A.KG_CONVERT_RATE, 2), 2) KG_QTY                                                                                           \n");
            sbSelSql.append("     , FSP_TRANS_QTY_FUN('" + PR_DATE + "', A.SUBINV_CODE, A.ITEM_CODE) AS ONHAND_QTY                                                                                  \n");
            sbSelSql.append("     , 0 AS CANCEL_PR_QTY                                                                                                                                              \n");
            sbSelSql.append("     , NVL(LEAST(                                                                                                                                                      \n");
            sbSelSql.append("             DECODE(NVL(A.MAX_ORD_QTY, 0), 0, 9999999999999, A.MAX_ORD_QTY),                                                                                           \n");
            sbSelSql.append("             DECODE(SIGN(SCC_CEIL(A.EXPECT_GRAM_QTY / 1000 / A.KG_CONVERT_RATE, -1) - A.MIN_ORD_QTY), -1,                                                              \n");
            sbSelSql.append("             DECODE(A.POINT_FLAG, 'N', CEIL(A.MIN_ORD_QTY), A.MIN_ORD_QTY),                                                                                            \n");
            sbSelSql.append("             DECODE(A.POINT_FLAG, 'N', CEIL(A.EXPECT_GRAM_QTY / 1000 / A.KG_CONVERT_RATE),                                                                             \n");
            sbSelSql.append("             DECODE(A.MULTIPLIER_QTY, 0, SCC_CEIL(A.EXPECT_GRAM_QTY / 1000 / A.KG_CONVERT_RATE,-1),                                                                    \n");
            sbSelSql.append("                    CASE WHEN MOD(SCC_CEIL(A.EXPECT_GRAM_QTY / 1000 / A.KG_CONVERT_RATE, -1), A.MULTIPLIER_QTY) > 0 THEN                                               \n");
            sbSelSql.append("                              (TRUNC(SCC_CEIL(A.EXPECT_GRAM_QTY / 1000 / A.KG_CONVERT_RATE,-1) / A.MULTIPLIER_QTY) * A.MULTIPLIER_QTY) + A.MULTIPLIER_QTY              \n");
            sbSelSql.append("                         ELSE                                                                                                                                          \n");
            sbSelSql.append("                              SCC_CEIL(A.EXPECT_GRAM_QTY / 1000 / A.KG_CONVERT_RATE, -1)                                                                               \n");
            sbSelSql.append("                    END) ) ) ), 0) AS PR_QTY                                                                                                                               \n");
            sbSelSql.append("     , 0 AS TOT_AMT       /* TOT_AMT = MARGIN_PRICE * PR_QTY (화면에서 계산) */                                                                                        \n");
            sbSelSql.append("     , NVL(A.G_ITEM_PRICE, 0) AS G_ITEM_PRICE /* g당 단가 = 출하율적용단가 / Kg 환산율 / 1000 */                                                                                               \n");
            sbSelSql.append("     , A.TAX_CODE                                                                                                                                                      \n");
            sbSelSql.append("     , A.CENTER_FLAG                                                                                                                                                   \n");
            sbSelSql.append("     , A.PR_REMARK                                                                                                                                                        \n");
            sbSelSql.append("     , A.REMARK                                                                                                                                                        \n");
            sbSelSql.append("     , A.POINT_FLAG                                                                                                                                                    \n");
            sbSelSql.append("     , A.SUBINV_CODE                                                                                                                                                   \n");
            sbSelSql.append("     , A.NEED_DATE                                                                                                                                                     \n");
            sbSelSql.append("     , A.UPJANG                                                                                                                                                        \n");
            sbSelSql.append("     , B.DEPT_ID                                                                                                                                                       \n");
            sbSelSql.append("     , A.ACCTCD         /* 입고 계정 코드(대표) : MATERIAL_ACCTCD */                                                                                                   \n");
            sbSelSql.append("     , A.BUD_CLS        /* 예산 조직 cc 코드 : BUDCC_CD */                                                                                                             \n");
            sbSelSql.append("     , B.MU_CD                                                                                                                                                         \n");
            sbSelSql.append("     , A.INVAT_FLAG                                                                                                                                                    \n");
            sbSelSql.append("     , A.OUTVAT_FLAG                                                                                                                                                   \n");
            sbSelSql.append("     , A.MIN_ORD_QTY AS MIN_ORD_QTY                                                                                                                                    \n");
            sbSelSql.append("     , A.MAX_ORD_QTY AS MAX_ORD_QTY                                                                                                                                    \n");
            sbSelSql.append("     , A.CENTER_CODE      /* 센터코드 */                                                                                                                               \n");
            sbSelSql.append("     , A.STOCK_FLAG                                                                                                                                                    \n");
            sbSelSql.append("     , A.BARCODE                                                                                                                                                       \n");
            sbSelSql.append("     , NVL(A.MULTIPLIER_QTY, 0) AS MULTIPLIER_QTY                                                                                                                      \n");
            sbSelSql.append("     , A.BUD_CLS AS BUDDEPT_ID  /* 예산 조직 cc 코드 : BUDCC_CD - 고도화에서 부서코드가 CC로 대체됨 */                                                                 \n");
            sbSelSql.append("     , A.USE_YN                                                                                                                                                        \n");
            sbSelSql.append("     , NVL(TO_NUMBER(DECODE(A.MARGIN_RATE, 0, A.UNIT_PRICE, (ROUND((A.UNIT_PRICE + (A.UNIT_PRICE * A.MARGIN_RATE / 100)) / 10) * 10))), 0)  AS MARGIN_PRICE /* 출하율적용단가 */  \n");
            sbSelSql.append("     , NVL(A.UNIT_PRICE, 0) AS UNIT_PRICE       /* 구매(매입)단가 */                                                                                                                         \n");
            sbSelSql.append("     , A.CUSTCD           /* 매입거래처코드 */                                                                                                                         \n");
            sbSelSql.append("     , NVL(A.KG_CONVERT_RATE, 0) AS KG_CONVERT_RATE                                                                                                                                              \n");
            sbSelSql.append("     , NVL(A.MARGIN_RATE, 0) AS MARGIN_RATE                                                                                                                            \n");
            sbSelSql.append("     , A.AP_UNITPRICE_UPJANG                                                                                                                                           \n");
            sbSelSql.append("     , D.RESTRICT_PERIOD                                                                                                                                               \n");
            sbSelSql.append("     , D.RESTRICT_REASON                                                                                                                                               \n");
            sbSelSql.append("     , NULL DUTY_END_DATE                                                                                                                                              \n");
            sbSelSql.append("     , 0 MIN_DUTY_QTY                                                                                                                                                  \n");
            sbSelSql.append("     , 0 DUTY_QTY                                                                                                                                                      \n");
            sbSelSql.append("     , 0 REAL_USE_QTY                                                                                                                                                  \n");
            sbSelSql.append("     , '' PR_YN                                                                                                                                                        \n");
            sbSelSql.append("     , 'N' DUP_YN                                                                                                                                                        \n");
            sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', F.OPER_ORG_SN_PURC, A.UPJANG_GRP, A.ITEM_CODE, A.NEED_DATE)    = 'CK' THEN 'Y' ELSE 'N' END            \n");
            sbSelSql.append("                                                    AS SHP_MAP  /* 자재 업장군 맵핑 유효성 체크 CE : 맵핑안되어있음(사용불가), CK : 맵핑되어있음(사용가능) */          \n");
            sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) = 'UP' THEN 'Y' ELSE 'N' END                                                                     \n");
            sbSelSql.append("                                                    AS MTG_UNS      /* 자재불용체크 UK: 불용, UP:불용아님, NN: DATA NOT FOUND */                                       \n");
            sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') = 'TP' THEN 'Y' ELSE 'N' END                                                               \n");
            sbSelSql.append("                                                    AS MTG_STP      /* 자재 중지체크 TK : 중지(사용불가), TP : 중지아님(사용가능), NN: DATA NOT FOUND */               \n");
            sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', A.NEED_DATE) = 'XR' THEN 'Y' ELSE 'N' END                                 \n");
            sbSelSql.append("                                                    AS REQ_WKD      /* 요일별 신청불가 체크 XE : 신청불가(사용불가), XR : 신청가능(사용가능), NN : DATA NOT FOUND */   \n");
            sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', NVL(C.D_DAY, 0), NVL(C.D_TIMES, 0), '"+ PR_DATE+"', A.NEED_DATE) = 'HK' THEN 'Y' ELSE 'N' END \n");
            sbSelSql.append("                                                    AS SCH          /* 수발주 스케쥴에 따른 유효성 체크 HE : 신청불가(사용불가), HK : 신청가능(사용가능), NN : DATA NOT FOUND */   \n");
            sbSelSql.append("     , NVL(C.D_DAYS, 0) AS D_DAY                                                                                                                                       \n");
            sbSelSql.append("	  ,	''	AS D_DAY_TXT																																		\n");
            sbSelSql.append("     , DECODE(C.D_DAYS,NULL,   0, DECODE(SIGN(TO_DATE(A.NEED_DATE, 'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') - NVL(C.D_DAYS,0) ) , 0,          \n");
            sbSelSql.append("                                  DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0, 24, C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))), 1, 0, 1), 0) + NVL(C.D_DAYS, 0) ) AS D_DAYS       \n");
            sbSelSql.append("     , DECODE(C.D_DAYS,NULL,   0, DECODE(C.D_TIMES, '', 24, 0, 24, C.D_TIMES)) AS D_TIMES                                                                              \n");
            sbSelSql.append("     , A.SPICE_YN                                                                                                                                                      \n");
            sbSelSql.append("     , A.CORN_YN                                                                                                                                                       \n");
            sbSelSql.append("     , A.IMG_PATH                                                                                                                                                      \n");
            sbSelSql.append("     , A.ORIGIN_NAT                                                                                                                                                    \n");
            sbSelSql.append("     , A.ORIGIN_TYPE                                                                                                                                                   \n");
            sbSelSql.append("     , A.VD_SN                                                                                                                                                         \n");
            sbSelSql.append("     , A.APPLY_SD                                                                                                                                                      \n");
            sbSelSql.append("     , 'P'   AS MOBILE_GUBUN                                                                                                                                           \n");
            sbSelSql.append("     , SCC_SOPR_AGG_FUN(A.SUBINV_CODE, A.ITEM_CODE, 1) AS AGG_QTY                                                                                                      \n");
            sbSelSql.append("     , A.UPJANG_GRP                                                                                                                                                    \n");
            sbSelSql.append("     , NVL(A.IS_ENF, 0) AS IS_ENF                                                                                                                                      \n");
            sbSelSql.append("     , NVL(A.IS_REC, 0) AS IS_REC                                                                                                                                      \n");
            sbSelSql.append("     , CASE WHEN G.G_PRICE < A.G_ITEM_PRICE THEN 'Y' ELSE 'N' END AS CHEAP_YN                                                                                          \n");
            sbSelSql.append("     , '001' AS LINE_STATUS                                                                                            \n");
            
            //20180510 김호석 담당MD 추가		
    		sbSelSql.append("\n     ,(SELECT MAX(DD.USR_NM)   ");
    		sbSelSql.append("\n				FROM EPROCUSR.ESPINFO AA  ");
    		sbSelSql.append("\n     			LEFT OUTER JOIN EPROCUSR.ESMVDOG BB ON AA.SYS_ID = BB.SYS_ID AND AA.COMP_CD = BB.COMP_CD AND AA.VD_SN = BB.VD_SN "); 
    		sbSelSql.append("\n     											    AND BB.OPER_ORG_SN = '414' --FC부문만  ");
    		sbSelSql.append("\n     			INNER JOIN EPROCUSR.ESPSWHC CC ON AA.SYS_ID = CC.SYS_ID AND AA.COMP_CD = CC.COMP_CD AND AA.PURC_OPER_ORG_SN = CC.OPER_ORG_SN_PURC "); 
    		sbSelSql.append("\n     		  	INNER JOIN EPROCUSR.ESAUSER DD ON DD.SYS_ID = '100' AND DD.COMP_CD = 'HFC' AND BB.HFC_CHR_ID = DD.USR_ID  AND DD.STS <> 'D' ");
    		sbSelSql.append("\n     					WHERE AA.SYS_ID = '100' AND AA.COMP_CD = 'HFC' AND A.NEED_DATE BETWEEN AA.APPLY_SD AND AA.APPLY_ED  --계약 기간 "); 
    		sbSelSql.append("\n     						   AND AA.STS <> 'D'  "); 
    		sbSelSql.append("\n     					       AND BB.VD_SN = A.VD_SN  ");
    		sbSelSql.append("\n     					       AND AA.ITEM_CD = A.ITEM_CODE ");
    		sbSelSql.append("\n    							   AND CC.WH_CNTR_CD = A.CENTER_CODE ");
    		sbSelSql.append("\n       ) AS MD_NAME	/*담당MD*/ ");
    		//20180510 김호석 담당MD 추가
            
            sbSelSql.append("  FROM (                                                                                                                                                               \n");
            sbSelSql.append("        SELECT /*+ USE_HASH(A C) */ A.ITEM_CODE                        AS ITEM_CODE                                                                                                         \n");
            sbSelSql.append("             , A.UPJANG                                                                                                                                                \n");
            sbSelSql.append("             , A.UPJANG                           AS AP_UNITPRICE_UPJANG                                                                                               \n");
            sbSelSql.append("             , A.IS_ENF                                                                                                                                                \n");
            sbSelSql.append("             , A.IS_REC                                                                                                                                                \n");
            sbSelSql.append("             , A.NEED_DATE                                                                                                                                             \n");
            sbSelSql.append("             , A.CAFE_YN                                                                                                                                               \n");
            sbSelSql.append("             , A.SUBINV_CODE                                                                                                                                           \n");
            sbSelSql.append("             , A.EXPECT_GRAM_QTY                                                                                                                                       \n");
            sbSelSql.append("             , C.PROC_TYP_CD                      AS CENTER_FLAG                                                                                                       \n");
            sbSelSql.append("             , C.CENTER_CODE                      AS CENTER_CODE      /* 센터코드 */                                                                                   \n");
            sbSelSql.append("             , C.CONTRACT_PRICE                   AS UNIT_PRICE        /* 구매(매입)단가 */                                                                            \n");
            sbSelSql.append("             , ROUND(NVL(DECODE(C.MARGIN_RATE, 0, C.CONTRACT_PRICE, ROUND((C.CONTRACT_PRICE + (C.CONTRACT_PRICE * C.MARGIN_RATE / 100)) / 10) * 10) / NVL(D.KG_CONVERT_RATE, 1) / 1000, 0), 2) AS G_ITEM_PRICE \n");
            sbSelSql.append("             , C.CUSTCD                                                                                                                                                \n");
            sbSelSql.append("             , C.MARGIN_RATE                                                                                                                                           \n");
            sbSelSql.append("             , C.DUTY_YN                                                                                                                                               \n");
            sbSelSql.append("             , C.PB_YN                                                                                                                                                 \n");
            sbSelSql.append("             , C.VD_SN                                                                                                                                                 \n");
            sbSelSql.append("             , C.APPLY_SD                                                                                                                                              \n");
            sbSelSql.append("             , C.UPJANG_GRP                                                                                                                                            \n");
            sbSelSql.append("             , D.ITEM_CLASS4                                                                                                                                           \n");
            sbSelSql.append("             , D.ITEM_NAME                                                                                                                                             \n");
            sbSelSql.append("             , D.ITEM_SIZE                                                                                                                                             \n");
            sbSelSql.append("             , D.PO_UOM                                                                                                                                                \n");
            sbSelSql.append("             , D.POINT_FLAG                                                                                                                                            \n");
            sbSelSql.append("             , D.TAX_CODE                                                                                                                                              \n");
            sbSelSql.append("             , NVL(D.MIN_ORD_QTY, 0) AS MIN_ORD_QTY                                                                                                                    \n");
            sbSelSql.append("             , NVL(D.MAX_ORD_QTY, 0) AS MAX_ORD_QTY                                                                                                                    \n");
            sbSelSql.append("             , D.BARCODE                                                                                                                                               \n");
            sbSelSql.append("             , D.MULTIPLIER_QTY                                                                                                                                        \n");
            sbSelSql.append("             , D.USE_YN                                                                                                                                                \n");
            sbSelSql.append("             , NVL(D.KG_CONVERT_RATE, 1)          AS KG_CONVERT_RATE                                                                                                   \n");
            sbSelSql.append("             , D.SPICE_YN                                                                                                                                              \n");
            sbSelSql.append("             , D.CORN_YN                                                                                                                                               \n");
            sbSelSql.append("             , D.IMG_PATH                                                                                                                                              \n");
            sbSelSql.append("             , D.ORIGIN_NAT                                                                                                                                            \n");
            sbSelSql.append("             , D.ORIGIN_TYPE                                                                                                                                           \n");
            sbSelSql.append("             , D.MANUF_CD                                                                                                                                              \n");
            sbSelSql.append("             , D.ECO_ITEM                                                                                                                                              \n");
            sbSelSql.append("             , ''                                 AS PR_REMARK                                                                                                            \n");
            sbSelSql.append("             , ''                                 AS REMARK                                                                                                            \n");
            sbSelSql.append("             , E.INVAT_FLAG                                                                                                                                            \n");
            sbSelSql.append("             , E.OUTVAT_FLAG                                                                                                                                           \n");
            sbSelSql.append("             , E.STOCK_FLAG                                                                                                                                            \n");
            sbSelSql.append("             , E.MATERIAL_ACCTCD                  AS ACCTCD                                                                                                            \n");
            sbSelSql.append("             , E.BUDCC_CD                         AS BUD_CLS                                                                                                           \n");
            sbSelSql.append("        FROM                                                                                                                                                           \n");
            sbSelSql.append("             (                                                                                                                                                         \n");
            sbSelSql.append("              SELECT /*+ ORDERED INDEX(ID FSM_REAL_RECIPE_ITEM_IDX01) */                                                                                               \n");
            sbSelSql.append("                     ID.ITEM_CODE                                                                                                                                      \n");
            sbSelSql.append("                   , ID.UPJANG                                                                                                                                         \n");
            sbSelSql.append("                   , MAX(ID.ATTR10)  AS IS_ENF  /* 그룹레시피 필수자재 여부 */                                                                                         \n");
            sbSelSql.append("                   , MAX(ID.ATTR02)  AS IS_REC  /* 권장메뉴 대표자재 여부 */                                                                                           \n");
            sbSelSql.append("                   , ID.NEED_DATE                                                                                                                                      \n");
            sbSelSql.append("                   , MAX(IB.CAFE_YN) AS CAFE_YN                                                                                                                        \n");
            sbSelSql.append("                   , IB.SUBINV_CODE                                                                                                                                    \n");
            sbSelSql.append("                   , SUM(DECODE(IB.CATER_YN, 'Y', IC.EXPECT_SALE_QTY, DECODE(IB.CAFE_YN, 'Y', IC.EXPECT_SALE_QTY, IA.EXPECT_MEAL_QTY)) * ID.NEED_QTY)                  \n");
            sbSelSql.append("                                     AS EXPECT_GRAM_QTY                                                                                                                \n");
            sbSelSql.append("                FROM FSM_REAL_RECIPE_ITEM ID                                                                                                                           \n");
            sbSelSql.append("                   , FSM_REAL_RECIPE_MST  IC                                                                                                                           \n");
            sbSelSql.append("                   , FSM_REAL_MENU_MST    IA                                                                                                                           \n");
            sbSelSql.append("                   , FSA_HALL_MST         IB                                                                                                                           \n");
            sbSelSql.append("               WHERE IA.UPJANG      = IB.UPJANG                                                                                                                        \n");
            sbSelSql.append("                 AND IA.HALL_CD     = IB.HALL_CD                                                                                                                       \n");
            sbSelSql.append("                 AND IA.SUBINV_CODE = IB.SUBINV_CODE                                                                                                                   \n");
            sbSelSql.append("                 AND IA.SUBINV_CODE = '" + SUBINV_CODE + "'                                                                                                            \n");
            sbSelSql.append("                 AND IA.UPJANG      = IC.UPJANG                                                                                                                        \n");
            sbSelSql.append("                 AND IA.MENU_CD     = IC.MENU_CD                                                                                                                       \n");
            sbSelSql.append("                 AND ID.UPJANG      = IC.UPJANG                                                                                                                        \n");
            sbSelSql.append("                 AND ID.MENU_CD     = IC.MENU_CD                                                                                                                       \n");
            sbSelSql.append("                 AND ID.RECIPE_CD   = IC.RECIPE_CD                                                                                                                     \n");
            sbSelSql.append("                 AND ID.NEED_DATE   = '" + NEED_DATE + "'                                                                                                              \n");
            sbSelSql.append("                 AND ID.UPJANG      = "  + UPJANG    + "                                                                                                               \n");
            sbSelSql.append("                 AND ID.ORDER_YN    = 'N'                                                                                                                              \n");
            sbSelSql.append("               GROUP BY ID.ITEM_CODE                                                                                                                                   \n");
            sbSelSql.append("                      , ID.UPJANG                                                                                                                                      \n");
            sbSelSql.append("                      , ID.NEED_DATE                                                                                                                                   \n");
            sbSelSql.append("                      , IB.SUBINV_CODE                                                                                                                                 \n");
            sbSelSql.append("             ) A                                                                                                                                                       \n");
            sbSelSql.append("           , (                                                                                                                                                         \n");
            sbSelSql.append("              SELECT ITEM_CODE                                                                                                                                         \n");
            sbSelSql.append("                   , PROC_TYP_CD                                                                                                                                       \n");
            sbSelSql.append("                   , CENTER_CODE                                                                                                                                       \n");
            sbSelSql.append("                   , CONTRACT_PRICE                                                                                                                                    \n");
            sbSelSql.append("                   , CUSTCD                                                                                                                                            \n");
            sbSelSql.append("                   , MARGIN_RATE                                                                                                                                       \n");
            sbSelSql.append("                   , DUTY_YN                                                                                                                                           \n");
            sbSelSql.append("                   , PB_YN                                                                                                                                             \n");
            sbSelSql.append("                   , VD_SN                                                                                                                                             \n");
            sbSelSql.append("                   , APPLY_SD                                                                                                                                          \n");
            sbSelSql.append("                   , UPJANG_GRP                                                                                                                                        \n");
            sbSelSql.append("                FROM HLDC_PO_CONTRACT_F                                                                                                                                \n");
            sbSelSql.append("               WHERE CENTER_CODE = " + CENTER_CODE + "                                                                                                                 \n");
            sbSelSql.append("                 AND UPJANG = "  + UPJANG    + "                                                                                                                       \n");
            sbSelSql.append("                 AND '" + NEED_DATE + "' BETWEEN CONTRACT_START AND CONTRACT_END                                                                                       \n");
            sbSelSql.append("                 AND USE_YN = 'Y'                                                                                                                                      \n");
            sbSelSql.append("                 AND USE_TYPE = '01'                                                                                                                                   \n");
            sbSelSql.append("             ) C                                                                                                                                                       \n");
            sbSelSql.append("           , HLDC_PO_ITEM_MST     D                                                                                                                                    \n");
            sbSelSql.append("           , HLDC_PO_SUBINVENTORY E                                                                                                                                    \n");
            sbSelSql.append("       WHERE A.ITEM_CODE   = C.ITEM_CODE (+)                                                                                                                           \n");
            sbSelSql.append("         AND A.ITEM_CODE   = D.ITEM_CODE                                                                                                                               \n");
            sbSelSql.append("         AND A.UPJANG      = E.UPJANG                                                                                                                                  \n");
            sbSelSql.append("         AND A.SUBINV_CODE = E.SUBINV_CODE                                                                                                                             \n");

            if (!PR_NUM.equals(""))       //수정의 경우 이미 삭제한 자재에 대한 레피시 자재는 다시 불러오지 않는다. 2008/09/24 박은규 이명희
                    sbSelSql.append("                   AND NOT EXISTS (SELECT 1 FROM SO_PR_MENU_LOG Z WHERE Z.PR_NUM = '" + PR_NUM + "' AND Z.ITEM_CODE = A.ITEM_CODE)                             \n");

            if(TYPE.equals("CANCEL_UPDATE"))   //취소재작성의 경우 취소목록에 있는건 다시 부르지 않는다. 2008/10/21 박은규 이명희
                    sbSelSql.append("                   AND NOT EXISTS (SELECT 1 FROM SO_PR Z WHERE Z.PR_NUM = '" + PR_NUM + "' AND Z.ITEM_CODE = A.ITEM_CODE)                                      \n");

            sbSelSql.append("       ) A                                                                                                                                                             \n");
            sbSelSql.append("     , SCO_UPJANG_MST_V B                                                                                                                                              \n");
            sbSelSql.append("     ,(SELECT A.CENTER_CODE                                                                                                                                            \n");
            sbSelSql.append("            , A.ITEM_CODE                                                                                                                                              \n");
            sbSelSql.append("            ,(SELECT TO_DATE('" + NEED_DATE + "','YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')                                                                      \n");
            sbSelSql.append("                FROM (SELECT ROW_NUMBER() OVER(ORDER BY Z.CD_SY||Z.CD_SM||Z.CD_SD DESC) AS SEQ                                                                         \n");
            sbSelSql.append("                           , Z.CD_SY||Z.CD_SM||Z.CD_SD AS NONHOLI_DATE                                                                                                 \n");
            sbSelSql.append("                        FROM SCC_CALENDA_DATA Z                                                                                                                        \n");
            sbSelSql.append("                       WHERE Z.CD_SY||Z.CD_SM||Z.CD_SD < '" + NEED_DATE + "'                                                                                           \n");
            sbSelSql.append("                         AND Z.CD_SY BETWEEN TO_NUMBER(SUBSTR('" + NEED_DATE + "', 1, 4)) - 1 AND TO_NUMBER(SUBSTR('" + NEED_DATE + "', 1, 4))                         \n");
            sbSelSql.append("                      -- AND Z.HOLIDAY NOT IN (1,2) --일요일 제외한 국가 공휴일 (일요일만 체크, 그 외 공유일은 상관없음(김진희))                                       \n");
            sbSelSql.append("                         AND Z.CD_WEEK NOT IN ('일')) Z                                                                                                                \n");
            sbSelSql.append("               WHERE Z.SEQ = A.D_DAYS ) AS D_DAYS                                                                                                                      \n");
            sbSelSql.append("             , A.D_DAYS  AS D_DAY                                                                                                                                      \n");
            sbSelSql.append("             , A.D_TIMES                                                                                                                                               \n");
            sbSelSql.append("          FROM HLDC_PO_PREORDER_LIST A                                                                                                                                 \n");
            sbSelSql.append("         WHERE A.CENTER_CODE = " + CENTER_CODE + "                                                                                                                     \n");
            sbSelSql.append("       ) C                      /* 선발주 제한 */                                                                                                                      \n");
            sbSelSql.append("     , (                                                                                                                                                               \n");
            sbSelSql.append("        SELECT UPJANG                                                                                                                                                  \n");
            sbSelSql.append("             , ITEM_CODE                                                                                                                                               \n");
            sbSelSql.append("             , TO_CHAR(TO_DATE(RESTRICT_START, 'YYYYMMDD'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(RESTRICT_END, 'YYYYMMDD'), 'YYYY.MM.DD') AS RESTRICT_PERIOD        \n");
            sbSelSql.append("             , RESTRICT_REASON                                                                                                                                         \n");
            sbSelSql.append("          FROM FSI_RESTRICT_SET                                                                                                                                        \n");
            sbSelSql.append("         WHERE UPJANG = " + UPJANG + "                                                                                                                                 \n");
            sbSelSql.append("           AND (RESTRICT_START <= '" + NEED_DATE + "' AND RESTRICT_END >= '" + NEED_DATE + "')                                                                         \n");
            sbSelSql.append("           AND NOT (CNL_START IS NOT NULL AND CNL_START  <= '" + NEED_DATE + "' AND CNL_END      >= '" + NEED_DATE + "')                                               \n");
            sbSelSql.append("           AND USE_YN = 'Y'                                                                                                                         					\n");
            sbSelSql.append("       ) D                      /* 금지자재 */                                                                                                                         \n");
            sbSelSql.append("    , VO_CENTER F                                                                                                                                                      \n");
            sbSelSql.append("    , (                                                                                                                                                                                                                            \n");
            sbSelSql.append("       SELECT ITEM_CLASS4, MIN(G_PRICE) AS G_PRICE                                                                                                                                                   \n");
            sbSelSql.append("         FROM (                                                                                                                                                                                                                    \n");
            sbSelSql.append("               SELECT C.ITEM_CLASS4                                                                                                                                                                                                \n");
            sbSelSql.append("                    , ROUND(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, (ROUND((B.CONTRACT_PRICE + (B.CONTRACT_PRICE * B.MARGIN_RATE / 100)) / 10) * 10)) / DECODE(C.KG_CONVERT_RATE, 0, 1, C.KG_CONVERT_RATE) / 1000, 2) G_PRICE   \n");
            sbSelSql.append("                 FROM ST_UPJANG A                                                                                                                                                                                                  \n");
            sbSelSql.append("                    , HLDC_PO_CONTRACT_F B                                                                                                                                                                                         \n");
            sbSelSql.append("                    , HLDC_PO_ITEM_MST C                                                                                                                                                                                           \n");
            sbSelSql.append("                WHERE B.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                    \n");
            sbSelSql.append("                  AND B.USE_YN    = 'Y'                                                                                                                                                                                            \n");
            sbSelSql.append("                  AND B.CONTRACT_PRICE > 0                                                                                                                                                                                         \n");
            sbSelSql.append("                  AND B.UPJANG    = A.AP_UNITPRICE_UPJANG                                                                                                                                                                          \n");
            sbSelSql.append("                  AND A.UPJANG    = " + UPJANG + "                                                                                                                                                                                 \n");
            sbSelSql.append("                  AND '" + NEED_DATE + "' BETWEEN B.CONTRACT_START AND B.CONTRACT_END                                                                                                                                                                                 \n");
            sbSelSql.append("               )                                                                                                                                                                                                                   \n");
            sbSelSql.append("        GROUP BY ITEM_CLASS4                                                                                                                                           \n");
            sbSelSql.append("      ) G                                                                                                                                                              \n");
            sbSelSql.append(" WHERE 1=1                                                                                                                                                             \n");
            sbSelSql.append("   AND A.UPJANG      = " + UPJANG + "                                                                                                                                  \n");
            sbSelSql.append("   AND A.UPJANG      = B.UPJANG                                                                                                                                        \n");
            sbSelSql.append("   AND A.CENTER_CODE = C.CENTER_CODE(+)                                                                                                                                \n");
            sbSelSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE  (+)                                                                                                                                \n");
            sbSelSql.append("   AND A.ITEM_CODE   = D.ITEM_CODE  (+)                                                                                                                                \n");
            sbSelSql.append("   AND A.UPJANG      = D.UPJANG     (+)                                                                                                                                \n");
            sbSelSql.append("   AND A.CENTER_CODE = F.CENTER_CODE(+)                                                                                                                                \n");
            sbSelSql.append("   AND A.ITEM_CLASS4 = G.ITEM_CLASS4(+)                                                                                                                                \n");
            sbSelSql.append("   AND A.ITEM_CODE NOT IN (                                                                                                                                            \n");
            sbSelSql.append("   	     SELECT ITEM_CODE                                                                                                                                           \n");
            sbSelSql.append("   	       FROM SO_PR                                                                                                                                               \n");
            sbSelSql.append("   	      WHERE ORG_PR_NUM  = '" + PR_NUM + "'                                                                                                                      \n");
            sbSelSql.append("   	        AND LINE_STATUS NOT IN('999', '003', 'PD')                                                                                                              \n");
            sbSelSql.append("   	   )                                                                                                                                                            \n");
            sbSelSql.append(" ORDER BY A.ITEM_CLASS4, A.ITEM_NAME, A.ITEM_CODE                                                                                                                      \n");
            sbSelSql.append("\n                                                                                                                                                                     \n");
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sbSelSql.toString());

            DataSet ds_pr_itemTmp = this.makeDataSet(rs,"ds_pr_itemTmp");

            // remart 생성
            String sRemark = "";
            if(ds_pr_itemTmp.getRowCount() > 0)
            {
                for(int i=0; i < ds_pr_itemTmp.getRowCount(); i++)
                {

                        BigDecimal nMagPrice  = ds_pr_itemTmp.getBigDecimal(i, "MARGIN_PRICE");
                        BigDecimal nPrQty = ds_pr_itemTmp.getBigDecimal(i, "PR_QTY");

                    // 계약여부
                    if(ds_pr_itemTmp.getString(i, "SHP_MAP").equals("N"))
                    {
                        ds_pr_itemTmp.set(i, "PR_REMARK", "단가계약 안됨");
                        ds_pr_itemTmp.set(i, "PR_YN" , "A");
                        ds_pr_itemTmp.set(i, "PR_QTY", 0);
                    }
                    // 불용자재
                    else if(ds_pr_itemTmp.getString(i, "MTG_UNS").equals("N"))
                    {
                        ds_pr_itemTmp.set(i, "PR_REMARK", "불용자재");
                        ds_pr_itemTmp.set(i, "PR_YN" , "B");
                        ds_pr_itemTmp.set(i, "PR_QTY", 0);
                    }
                    // 중지자재
                    else if(ds_pr_itemTmp.getString(i, "MTG_STP").equals("N"))
                    {
                        ds_pr_itemTmp.set(i, "PR_REMARK", "중지자재");
                        ds_pr_itemTmp.set(i, "PR_YN" , "B");
                        ds_pr_itemTmp.set(i, "PR_QTY", 0);
                    }

                    // 요일제한
                    else if(ds_pr_itemTmp.getString(i, "REQ_WKD").equals("N"))
                    {
                        ds_pr_itemTmp.set(i, "PR_REMARK", "요일제한");
                        ds_pr_itemTmp.set(i, "PR_YN" , "A");
                        ds_pr_itemTmp.set(i, "PR_QTY", 0);
                    }

                    else if(nullToBlank(ds_pr_itemTmp.getString(i, "RESTRICT_PERIOD")).length() > 0)
                    {
                        sRemark =   "금지자재(" + ds_pr_itemTmp.getString(i,"RESTRICT_PERIOD")  +   ", " + ds_pr_itemTmp.getString(i,"RESTRICT_REASON") + ")";
                        ds_pr_itemTmp.set(i, "PR_REMARK", sRemark);
                        ds_pr_itemTmp.set(i, "PR_YN" , "C");
                        ds_pr_itemTmp.set(i, "PR_QTY", 0);
                    }

                    else if(ds_pr_itemTmp.getString(i, "SCH").equals("N"))
                    {
                        sRemark = "수발주제한";
                        ds_pr_itemTmp.set(i, "PR_REMARK", sRemark);
                        ds_pr_itemTmp.set(i, "PR_YN" , "A");
                        ds_pr_itemTmp.set(i, "PR_QTY", 0);
                    }
                    else
                    {
                        ds_pr_itemTmp.set(i, "PR_YN" , "Y");
                    }


                    ds_pr_itemTmp.set(i, "TOT_AMT", nMagPrice.multiply(nPrQty));
                }
            }

            rs.close();
            stmt.close();

            out_dl.add(ds_pr_itemTmp);

            // 식단조회시 중복자재 목록조회
            sbSelSql.delete(0, sbSelSql.length());
            sbSelSql.append("SELECT A.ITEM_CODE                                                                \n");
            sbSelSql.append("     , A.UPJANG                                                                   \n");
            sbSelSql.append("     , A.IS_ENF                                                                   \n");
            sbSelSql.append("     , A.NEED_DATE                                                                \n");
            sbSelSql.append("     , A.SUBINV_CODE                                                              \n");
            sbSelSql.append("     , ROUND(NVL(A.EXPECT_GRAM_QTY / 1000 / C.KG_CONVERT_RATE, 2), 2) AS KG_QTY   \n");
            sbSelSql.append("  FROM (                                                                          \n");
            sbSelSql.append("        SELECT /*+ ORDERED INDEX(ID FSM_REAL_RECIPE_ITEM_IDX01) */                \n");
            sbSelSql.append("               ID.ITEM_CODE                                                       \n");
            sbSelSql.append("             , ID.UPJANG                                                          \n");
            sbSelSql.append("             , MAX(ID.ATTR10)  AS IS_ENF  /* 그룹레시피 필수자재 여부 */                     \n");
            sbSelSql.append("             , ID.NEED_DATE                                                       \n");
            sbSelSql.append("             , MAX(IB.CAFE_YN) AS CAFE_YN                                         \n");
            sbSelSql.append("             , IB.SUBINV_CODE                                                     \n");
            sbSelSql.append("             , SUM(DECODE(IB.CATER_YN, 'Y', IC.EXPECT_SALE_QTY, DECODE(IB.CAFE_YN, 'Y', IC.EXPECT_SALE_QTY, IA.EXPECT_MEAL_QTY)) * ID.NEED_QTY)  \n");
            sbSelSql.append("                               AS EXPECT_GRAM_QTY                                 \n");
            sbSelSql.append("          FROM FSM_REAL_RECIPE_ITEM ID                                            \n");
            sbSelSql.append("             , FSM_REAL_RECIPE_MST  IC                                            \n");
            sbSelSql.append("             , FSM_REAL_MENU_MST    IA                                            \n");
            sbSelSql.append("             , FSA_HALL_MST         IB                                            \n");
            sbSelSql.append("         WHERE IA.UPJANG      = IB.UPJANG                                         \n");
            sbSelSql.append("           AND IA.HALL_CD     = IB.HALL_CD                                        \n");
            sbSelSql.append("           AND IA.SUBINV_CODE = IB.SUBINV_CODE                                    \n");
            sbSelSql.append("           AND IA.SUBINV_CODE = '" + SUBINV_CODE + "'                             \n");
            sbSelSql.append("           AND IA.UPJANG      = IC.UPJANG                                         \n");
            sbSelSql.append("           AND IA.MENU_CD     = IC.MENU_CD                                        \n");
            sbSelSql.append("           AND ID.UPJANG      = IC.UPJANG                                         \n");
            sbSelSql.append("           AND ID.MENU_CD     = IC.MENU_CD                                        \n");
            sbSelSql.append("           AND ID.RECIPE_CD   = IC.RECIPE_CD                                      \n");
            sbSelSql.append("           AND ID.NEED_DATE   = '" + NEED_DATE + "'                               \n");
            sbSelSql.append("           AND ID.UPJANG      = "  + UPJANG    + "                                \n");
            sbSelSql.append("           AND ID.ORDER_YN    = 'N'                                               \n");
            sbSelSql.append("         GROUP BY ID.ITEM_CODE                                                    \n");
            sbSelSql.append("                , ID.UPJANG                                                       \n");
            sbSelSql.append("                , ID.NEED_DATE                                                    \n");
            sbSelSql.append("                , IB.SUBINV_CODE                                                  \n");
            sbSelSql.append("       ) A                                                                        \n");
            sbSelSql.append("     , (                                                                          \n");
            sbSelSql.append("           SELECT ITEM_CODE                                                       \n");
            sbSelSql.append("            FROM SO_PR                                                            \n");
            sbSelSql.append("           WHERE ORG_PR_NUM  = '" + PR_NUM + "'                                   \n");
            sbSelSql.append("             AND LINE_STATUS NOT IN('999', '003', 'PD')                           \n");
            sbSelSql.append("       ) B                                                                        \n");
            sbSelSql.append("     , HLDC_PO_ITEM_MST C                                                         \n");
            sbSelSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                  \n");
            sbSelSql.append("   AND A.ITEM_CODE = C.ITEM_CODE                                                  \n");

            stmt = conn.createStatement();
            rs = stmt.executeQuery(sbSelSql.toString());

            DataSet ds_dup_item = this.makeDataSet(rs,"ds_dup_item");
            out_dl.add(ds_dup_item);

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