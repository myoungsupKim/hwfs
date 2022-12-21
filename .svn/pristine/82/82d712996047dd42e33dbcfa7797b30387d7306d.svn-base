
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_condi    = in_dl.get("ds_condi");

        String TYPE         = nullToBlank(ds_condi.getString(0, "TYPE"));
        String PR_NUM       = nullToBlank(ds_condi.getString(0, "PR_NUM"));
        String NEED_DATE    = nullToBlank(ds_condi.getString(0, "NEED_DATE"));
        String PR_DATE      = nullToBlank(ds_condi.getString(0, "PR_DATE"));
        String SUBINV_CODE  = nullToBlank(ds_condi.getString(0, "SUBINV_CODE"));

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

        // 신청리스트 조회
        sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("\n                                                                                                                                                                                 \n");
        sbSelSql.append("SELECT A.ITEM_CODE                                                                                                                                                                 \n");
        sbSelSql.append("     , A.ITEM_NAME                                                                                                                                                                 \n");
        sbSelSql.append("     , A.ITEM_CLASS4                                                                                                                                                               \n");
        sbSelSql.append("     , A.PR_NUM                                                                                                                                                                \n");
        sbSelSql.append("     , A.ORG_PR_NUM                                                                                                                                                                \n");
        sbSelSql.append("     , A.PR_ID                                                                                                                                                                \n");
        sbSelSql.append("	  ,	A.DUTY_YN												     /* 기획 */																											\n");
		sbSelSql.append("	  ,	A.PB_YN												         /* PB상품 */																										\n");
		sbSelSql.append("	  ,	A.ECO_ITEM												     /* 친환경 */																										\n");
		sbSelSql.append("     , FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.NEED_DATE), A.PB_YN, A.ECO_ITEM, A.MANUF_CD) AS FEATURE_NAME																									 	\n");
        sbSelSql.append("     , A.ITEM_SIZE                                                                                                                                                                 \n");
        sbSelSql.append("     , A.PO_UOM                                                                                                                                                                    \n");
        sbSelSql.append("     , 0 KG_QTY                                                                                                                                                                    \n");
        sbSelSql.append("     , 0 AS CANCEL_PR_QTY                                                                                                                                                          \n");
        sbSelSql.append("     , ROUND(A.MARGIN_PRICE / A.KG_CONVERT_RATE / 1000,2) G_PRICE                                                                                                                  \n");
        sbSelSql.append("     , A.PR_QTY                                                                                                                                                                    \n");
        sbSelSql.append("     , A.PR_AMT                                                                                                                                                                    \n");
        sbSelSql.append("     , A.TAX_CODE                                                                                                                                                                  \n");
        sbSelSql.append("     , A.CENTER_FLAG                                                                                                                                                               \n");
        sbSelSql.append("     , A.PR_REMARK                                                                                                                                                                    \n");
        sbSelSql.append("     , A.REMARK                                                                                                                                                                    \n");
        sbSelSql.append("     , A.POINT_FLAG                                                                                                                                                                \n");
        sbSelSql.append("     , A.SUBINV_CODE                                                                                                                                                      \n");
        sbSelSql.append("     , A.NEED_DATE                                                                                                                                                        \n");
        sbSelSql.append("     , A.UPJANG                                                                                                                                                                    \n");
        sbSelSql.append("     , B.DEPT_ID                                                                                                                                                                   \n");
        sbSelSql.append("     , A.ACCTCD         /* 입고 계정 코드(대표) : MATERIAL_ACCTCD */                                                                                                               \n");
        sbSelSql.append("     , A.BUD_CLS        /* 예산 조직 cc 코드 : BUDCC_CD */                                                                                                                         \n");
        sbSelSql.append("     , B.MU_CD                                                                                                                                                                     \n");
        sbSelSql.append("     , A.INVAT_FLAG                                                                                                                                                                \n");
        sbSelSql.append("     , A.OUTVAT_FLAG                                                                                                                                                               \n");
        sbSelSql.append("     , A.MIN_ORD_QTY                                                                                                                                                               \n");
        sbSelSql.append("     , A.MAX_ORD_QTY                                                                                                                                                               \n");
        sbSelSql.append("     , A.CENTER_CODE      /* 센터코드 */                                                                                                                                           \n");
        sbSelSql.append("     , A.STOCK_FLAG                                                                                                                                                                \n");
        sbSelSql.append("     , A.BARCODE                                                                                                                                                                   \n");
        sbSelSql.append("     , A.KEEPING_TYPE                                                                                                                                                              \n");
        sbSelSql.append("     , NVL(A.MULTIPLIER_QTY, 0)  AS MULTIPLIER_QTY                                                                                                                                                          \n");
        sbSelSql.append("     , A.BUD_CLS AS BUDDEPT_ID  /* 예산 조직 cc 코드 : BUDCC_CD - 고도화에서 부서코드가 CC로 대체됨 */                                                                             \n");
        sbSelSql.append("     , DECODE(A.CUSTCD, NULL, 'N', 'Y') AS CONTRACT_YN                                                                                                                             \n");
        sbSelSql.append("     , NVL(A.MARGIN_PRICE, 0) AS MARGIN_PRICE     /* 출하율적용단가 */                                                                                                             \n");
        sbSelSql.append("     , A.UNIT_PRICE       /* 구매(매입)단가 */                                                                                                                                     \n");
        sbSelSql.append("     , A.CUSTCD           /* 매입거래처코드 */                                                                                                                                     \n");
        sbSelSql.append("     , 'N' CHEAP_YN                                                                                                                                                                \n");
        sbSelSql.append("     , A.KG_CONVERT_RATE                                                                                                                                                           \n");
        sbSelSql.append("     , A.UPJANG AS AP_UNITPRICE_UPJANG                                                                                                                                             \n");
        sbSelSql.append("     , D.RESTRICT_PERIOD                                                                                                                                                           \n");
        sbSelSql.append("     , D.RESTRICT_REASON                                                                                                                                                           \n");
        sbSelSql.append("     , NULL DUTY_END_DATE                                                                                                                                                          \n");
        sbSelSql.append("     , 0 MIN_DUTY_QTY                                                                                                                                                              \n");
        sbSelSql.append("     , 0 DUTY_QTY                                                                                                                                                                  \n");
        sbSelSql.append("     , 0 REAL_USE_QTY                                                                                                                                                              \n");
        sbSelSql.append("     , DECODE(EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '02', NVL(C.D_DAY, 0), NVL(C.D_TIMES, 0), '"+ PR_DATE+"', '"+NEED_DATE+"'), 'HE', 'N', '') AS PR_YN \n");
        //구매신청(자동)처럼 유효성 문구 추가 및 수정/삭제 불가처리하기 위한 필드 추가 2018.04.02 김호석(이혜은, 윤지혜, 염병문)
        sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', F.OPER_ORG_SN_PURC, A.UPJANG_GRP, A.ITEM_CODE,	'" + NEED_DATE +	"')	= 'CK' THEN	'Y'	ELSE 'N' END	\n");
		sbSelSql.append("													 AS	SHP_MAP	 /*	자재 업장군	맵핑 유효성	체크 CE	: 맵핑안되어있음(사용불가),	CK : 맵핑되어있음(사용가능)	*/			\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) = 'UP' THEN 'Y' ELSE	'N'	END																		\n");
		sbSelSql.append("													 AS	MTG_UNS		 /*	자재불용체크 UK: 불용, UP:불용아님,	NN:	DATA NOT FOUND */										\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') = 'TP'	THEN 'Y' ELSE 'N' END																\n");
		sbSelSql.append("													 AS	MTG_STP		 /*	자재 중지체크 TK : 중지(사용불가), TP :	중지아님(사용가능),	NN:	DATA NOT FOUND */				\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', '" + NEED_DATE +    "') = 'XR' THEN 'Y' ELSE	'N'	END							\n");
		sbSelSql.append("													 AS	REQ_WKD		 /*	요일별 신청불가	체크 XE	: 신청불가(사용불가), XR : 신청가능(사용가능), NN :	DATA NOT FOUND */	\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', NVL(C.D_DAY, 0), NVL(C.D_TIMES, 0), TO_CHAR(SYSDATE, 'YYYYMMDD'), '"	+	NEED_DATE +	"')	= 'HK' THEN	'Y'	ELSE 'N' END	\n");
		sbSelSql.append("													 AS	SCH			 /*	수발주 스케쥴에	따른 유효성	체크 HE	: 신청불가(사용불가), HK : 신청가능(사용가능), NN :	DATA NOT FOUND */										\n");
		        
        sbSelSql.append("     , NVL(C.D_DAYS,0) + 1 AS D_DAY                                                                                                                                                \n");
        sbSelSql.append("     , DECODE(C.D_DAYS,NULL,   0, DECODE(SIGN(TO_DATE('20150705', 'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) , 0,                      \n");
        sbSelSql.append("                                  DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0, 24, C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))), 1, 0, 1), 0) + NVL(C.D_DAYS, 0) + 1) AS D_DAYS   \n");
        sbSelSql.append("     , DECODE(C.D_DAYS,NULL,   0, DECODE(C.D_TIMES, '', 24, 0, 24, C.D_TIMES)) AS D_TIMES                                                                                          \n");
        sbSelSql.append("     , DECODE(C.D_DAYS,NULL, 'Y', DECODE(SIGN(TO_DATE('20150705', 'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') - NVL(C.D_DAYS,0)) ,-1, 'N', 0,              \n");
        sbSelSql.append("                                  DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0, 24, C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'))), -1, 'N', 0, 'N', 'C'), 1, 'Y'))    AS D_DAY_YN   \n");
        sbSelSql.append("     , A.SPICE_YN                                                                                                                                                                  \n");
        sbSelSql.append("     , A.CORN_YN                                                                                                                                                                   \n");
        sbSelSql.append("     , A.IMG_PATH                                                                                                                                                                  \n");
        sbSelSql.append("     , A.ORIGIN_NAT                                                                                                                                                                \n");
        sbSelSql.append("     , A.ORIGIN_TYPE                                                                                                                                                               \n");
        sbSelSql.append("     , A.VD_SN                                                                                                                                                                     \n");
        sbSelSql.append("     , A.APPLY_SD                                                                                                                                                                  \n");
        sbSelSql.append("     , A.MOBILE_GUBUN                                                                                                                                                                   \n");
        sbSelSql.append("     , G.REASON_CD                                                                                                                                                                   \n");
        sbSelSql.append("     , G.PR_REASON                                                                                                                                                                   \n");
        sbSelSql.append("     , A.UPJANG_GRP                                                                                                                                                                    \n");
        sbSelSql.append("     , CASE A.LINE_STATUS WHEN '002' 																																					\n");
        sbSelSql.append("        THEN CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID ) > 1												\n");
        sbSelSql.append("        THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )							\n");
        sbSelSql.append("                 ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID )												\n");
        sbSelSql.append("            END																																										\n");
        sbSelSql.append("           ELSE A.LINE_STATUS																																							\n");
        sbSelSql.append("           END LINE_STATUS									/* 구매진행상황코드 */       																								\n");
        sbSelSql.append("  FROM (                                                                                                                                                                           \n");
        sbSelSql.append("        SELECT  /*+ PUSH_PRED(C) PUSH_PRED(D) */ B.ITEM_CODE                                                                                                                                                \n");
        sbSelSql.append("              , B.ITEM_NAME                                                                                                                                                \n");
        sbSelSql.append("              , B.ITEM_CLASS4                                                                                                                                              \n");
        sbSelSql.append("              , B.ITEM_SIZE                                                                                                                                                \n");
        sbSelSql.append("              , A.PR_NUM                                                                                                                                                    \n");
        sbSelSql.append("              , A.ORG_PR_NUM                                                                                                                                                    \n");
        sbSelSql.append("              , A.PR_ID                                                                                                                                                    \n");
        sbSelSql.append("              , B.PO_UOM                                                                                                                                                   \n");
        sbSelSql.append("              , A.MARGIN_PRICE                                                                                                                                             \n");
        sbSelSql.append("              , NVL(B.KG_CONVERT_RATE, 1) AS KG_CONVERT_RATE                                                                                                               \n");
        sbSelSql.append("              , 0 AS G_PRICE                                                                                                                                               \n");
        sbSelSql.append("              , A.PR_QTY                                                                                                                                                   \n");
        sbSelSql.append("              , (A.MARGIN_PRICE * A.PR_QTY) AS PR_AMT                                                                                                                      \n");
        sbSelSql.append("              , A.SUBINV_CODE                                                                                                                                              \n");
        sbSelSql.append("              , A.NEED_DATE                                                                                                                                                \n");
        sbSelSql.append("              , A.PR_REMARK AS PR_REMARK                                                                                                                                      \n");
        sbSelSql.append("              , A.REMARK AS REMARK                                                                                                                                      \n");
        sbSelSql.append("              , A.UNIT_PRICE       /* 구매(매입)단가 */                                                                                                                    \n");
        sbSelSql.append("              , B.TAX_CODE                                                                                                                                                 \n");
        sbSelSql.append("              , A.CUSTCD           /* 매입거래처코드 */                                                                                                                    \n");
        sbSelSql.append("              , D.PROC_TYP_CD AS CENTER_FLAG                                                                                                                                              \n");
        sbSelSql.append("              , A.CENTER_CODE                                                                                                                                              \n");
        sbSelSql.append("              , B.POINT_FLAG                                                                                                                                               \n");
        sbSelSql.append("              , B.IMG_PATH                                                                                                                                                 \n");
        sbSelSql.append("              , B.MIN_ORD_QTY                                                                                                                                              \n");
        sbSelSql.append("              , B.MAX_ORD_QTY                                                                                                                                              \n");
        sbSelSql.append("              , B.BARCODE                                                                                                                                                  \n");
        sbSelSql.append("              , B.MULTIPLIER_QTY                                                                                                                                           \n");
        sbSelSql.append("              , B.KEEPING_TYPE                                                                                                                                             \n");
        sbSelSql.append("              , A.RC_UPJANG  AS UPJANG                                                                                                                                     \n");
        sbSelSql.append("              , A.RC_DEPT_ID AS DEPT_ID                                                                                                                                    \n");
        sbSelSql.append("              , A.ACCTCD                                                                                                                                                   \n");
        sbSelSql.append("              , A.BUD_CLS                                                                                                                                                  \n");
        sbSelSql.append("              , A.RC_MU_CD  AS MU_CD                                                                                                                                       \n");
        sbSelSql.append("              , A.INVAT_FLAG                                                                                                                                               \n");
        sbSelSql.append("              , A.OUTVAT_FLAG                                                                                                                                              \n");
        sbSelSql.append("              , C.STOCK_FLAG                                                                                                                                               \n");
        sbSelSql.append("              , A.BUDDEPT_ID                                                                                                                                               \n");
        sbSelSql.append("              , B.ORIGIN_NAT                                                                                                                                               \n");
        sbSelSql.append("              , B.ORIGIN_TYPE                                                                                                                                              \n");
        sbSelSql.append("              , B.SPICE_YN                                                                                                                                                 \n");
        sbSelSql.append("              , B.CORN_YN                                                                                                                                                  \n");
        sbSelSql.append("              , D.DUTY_YN                                                                                                                                                  \n");
        //sbSelSql.append("              , B.PB_YN                                                                                                                                                    \n");
        //PB_YN을 계약에서 가져옴 (2015.08.29)
        sbSelSql.append("              , D.PB_YN                                                                                                                                                    \n");
        sbSelSql.append("              , B.MANUF_CD                                                                                                                                                 \n");        
        sbSelSql.append("              , B.ECO_ITEM                                                                                                                                                 \n");
        sbSelSql.append("              , A.VD_SN                                                                                                                                                    \n");
        sbSelSql.append("              , A.APPLY_SD                                                                                                                                                 \n");
        sbSelSql.append("              , A.MOBILE_GUBUN                                                                                                                                             \n");
        sbSelSql.append("              , A.UPJANG_GRP                                                                                                                                             \n");
        sbSelSql.append("              , A.LINE_STATUS                                                                                                                                             \n");
        sbSelSql.append("           FROM SO_PR A                                                                                                                                                    \n");
        sbSelSql.append("              , HLDC_PO_ITEM_MST B                                                                                                                                         \n");
        sbSelSql.append("              , HLDC_PO_SUBINVENTORY C                                                                                                                                     \n");
        sbSelSql.append("              , HLDC_PO_CONTRACT_F D                                                                                                                                       \n");
        sbSelSql.append("          WHERE A.ITEM_CODE   = B.ITEM_CODE                                                                                                                                \n");
        sbSelSql.append("            AND A.SUBINV_CODE = C.SUBINV_CODE (+)                                                                                                                          \n");
        sbSelSql.append("            AND A.ITEM_CODE   = D.ITEM_CODE   (+)                                                                                                                          \n");
        sbSelSql.append("            AND A.RC_UPJANG   = D.UPJANG      (+)                                                                                                                          \n");
        //sbSelSql.append("		    AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN D.CONTRACT_START(+) AND D.CONTRACT_END(+)																							\n");
        sbSelSql.append("		    AND '" + NEED_DATE + "' BETWEEN D.CONTRACT_START(+) AND D.CONTRACT_END(+)																							\n");
        if(TYPE.equals("CANCEL_UPDATE"))
        	sbSelSql.append("            AND A.LINE_STATUS NOT IN('999', 'PD')                                                                                                                         \n");
        else
        	sbSelSql.append("            AND A.LINE_STATUS NOT IN('999', '003', 'PD')                                                                                                                         \n");
        sbSelSql.append("                AND A.ORG_PR_NUM  = '" + PR_NUM + "'                                                                                                                           \n");
        sbSelSql.append("       ) A                                                                                                                                                                         \n");
        sbSelSql.append("     , SCO_UPJANG_MST_V B                                                                                                                                                          \n");
        sbSelSql.append("     ,(SELECT A.CENTER_CODE                                                                                                                                                        \n");
        sbSelSql.append("            , A.ITEM_CODE , A.D_DAYS AS D_DAY                                                                                                                                                         \n");
        sbSelSql.append("            ,(SELECT TO_DATE('" + NEED_DATE + "','YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')                                                                                  \n");
        sbSelSql.append("                FROM (SELECT ROW_NUMBER() OVER(ORDER BY Z.CD_SY||Z.CD_SM||Z.CD_SD DESC) AS SEQ                                                                                     \n");
        sbSelSql.append("                           , Z.CD_SY||Z.CD_SM||Z.CD_SD AS NONHOLI_DATE                                                                                                             \n");
        sbSelSql.append("                        FROM SCC_CALENDA_DATA Z                                                                                                                                    \n");
        sbSelSql.append("                       WHERE Z.CD_SY||Z.CD_SM||Z.CD_SD < '" + NEED_DATE + "'                                                                                                       \n");
        sbSelSql.append("                         AND Z.CD_SY BETWEEN TO_NUMBER(SUBSTR('" + NEED_DATE + "', 1, 4)) - 1 AND TO_NUMBER(SUBSTR('" + NEED_DATE + "', 1, 4))                                     \n");
        sbSelSql.append("                      -- AND Z.HOLIDAY NOT IN (1,2) --일요일 제외한 국가 공휴일 (일요일만 체크, 그 외 공유일은 상관없음(김진희))                                                   \n");
        sbSelSql.append("                         AND Z.CD_WEEK NOT IN ('일')) Z                                                                                                                            \n");
        sbSelSql.append("               WHERE Z.SEQ = A.D_DAYS ) AS D_DAYS                                                                                                                                  \n");
        sbSelSql.append("             , A.D_TIMES                                                                                                                                                           \n");
        sbSelSql.append("          FROM HLDC_PO_PREORDER_LIST A                                                                                                                                             \n");
        sbSelSql.append("         WHERE A.CENTER_CODE = " + CENTER_CODE + "                                                                                                                                 \n");
        sbSelSql.append("       ) C                      /* 선발주 제한 */                                                                                                                                  \n");
        sbSelSql.append("     , (                                                                                                                                                                           \n");
        sbSelSql.append("        SELECT UPJANG                                                                                                                                                              \n");
        sbSelSql.append("             , ITEM_CODE                                                                                                                                                           \n");
        sbSelSql.append("             , TO_CHAR(TO_DATE(RESTRICT_START, 'YYYYMMDD'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(RESTRICT_END, 'YYYYMMDD'), 'YYYY.MM.DD') AS RESTRICT_PERIOD                    \n");
        sbSelSql.append("             , RESTRICT_REASON                                                                                                                                                     \n");
        sbSelSql.append("          FROM FSI_RESTRICT_SET                                                                                                                                                    \n");
        sbSelSql.append("         WHERE UPJANG = " + UPJANG + "                                                                                                                                             \n");
        sbSelSql.append("           AND (RESTRICT_START <= '" + NEED_DATE + "' AND RESTRICT_END >= '" + NEED_DATE + "')                                                                                     \n");
        sbSelSql.append("           AND NOT (CNL_START IS NOT NULL AND CNL_START  <= '" + NEED_DATE + "' AND CNL_END      >= '" + NEED_DATE + "')                                                                                     \n");
        sbSelSql.append("       ) D                      /* 금지자재 */                                                                                                                                     \n");
        sbSelSql.append("     , VO_CENTER F                                                                                                                                                                     \n");
        sbSelSql.append("     , SO_PR_REASON G                                                                                                                                                                         \n");
        sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                                                                         \n");
        sbSelSql.append("   AND A.CENTER_CODE = C.CENTER_CODE(+)                                                                                                                                            \n");
        sbSelSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE  (+)                                                                                                                                            \n");
        sbSelSql.append("   AND A.ITEM_CODE   = D.ITEM_CODE  (+)                                                                                                                                            \n");
        sbSelSql.append("	AND	A.CENTER_CODE =	F.CENTER_CODE (+)																																				\n");
        sbSelSql.append("   AND A.ORG_PR_NUM  = G.PR_NUM     (+)                                                                                                                                            \n");
        //정렬조건 추가(유효성 체크된 자재를 맨위로 나오게 변경) 2018.04.02 김호석(이혜은, 윤지혜, 염병문)
        sbSelSql.append(" ORDER BY SHP_MAP, SHP_MAP, MTG_STP, SCH, REQ_WKD, A.ITEM_CLASS4, A.ITEM_NAME, A.ITEM_CODE                                                                                                                                                              \n");

        sbSelSql.append("\n                                                                                                                                                                                 \n");

        stmt = conn.createStatement();
        rs = stmt.executeQuery(sbSelSql.toString());

        DataSet ds_pr_item = this.makeDataSet(rs,"ds_pr_item");
        
     	// remart 생성 
     	//구매신청(자동)처럼 유효성 문구 추가 및 수정/삭제 불가처리하기 위한 필드 추가 2018.04.02 김호석(이혜은, 윤지혜, 염병문)
        String sRemark = "";
        if(ds_pr_item.getRowCount() > 0)
        {
        	for(int i=0; i < ds_pr_item.getRowCount(); i++)
        	{
        	
        		// 계약여부
        		if(ds_pr_item.getString(i, "SHP_MAP").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "단가계약 안됨");
        			ds_pr_item.set(i, "PR_YN" , "A");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}
        		// 불용자재
        		else if(ds_pr_item.getString(i, "MTG_UNS").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "불용자재");
        			ds_pr_item.set(i, "PR_YN" , "B");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}
        		// 중지자재
        		else if(ds_pr_item.getString(i, "MTG_STP").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "중지자재");
        			ds_pr_item.set(i, "PR_YN" , "B");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}

        		// 요일제한
        		else if(ds_pr_item.getString(i, "REQ_WKD").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "요일제한");
        			ds_pr_item.set(i, "PR_YN" , "A");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}

         		else if(nullToBlank(ds_pr_item.getString(i, "RESTRICT_PERIOD")).length() > 0)
        		{
        			sRemark =	"금지자재("	+ ds_pr_item.getString(i,"RESTRICT_PERIOD")	+	", " + ds_pr_item.getString(i,"RESTRICT_REASON") + ")";
        			ds_pr_item.set(i, "PR_REMARK", sRemark);
        			ds_pr_item.set(i, "PR_YN" , "C");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}

        		else if(ds_pr_item.getString(i, "SCH").equals("N"))
        		{
        			sRemark = "수발주 제한";
        			ds_pr_item.set(i, "PR_REMARK", sRemark);
        			//ds_pr_item.set(i, "PR_REMARK", "");
        			//ds_pr_item.set(i, "PR_YN" , "A");
        			//수정 못하게 하기 위해 Y값이 아닌 값으로 부여하며 자재삭제 시 수발주제한만 삭제 못하게 막기 위해 D로 독립된 값을 부여 2018.03.27 김호석(이혜은 과장 요청)
        			//유효성 자재는 전부 삭제 못하게 막음 2018.04.02
        			ds_pr_item.set(i, "PR_YN" , "D");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}
        		else
        		{
        			ds_pr_item.set(i, "PR_YN" , "Y");
        		}

        	}
        }

        rs.close();
        stmt.close();

        out_dl.add(ds_pr_item);

        this.setResultMessage(0, "OK",out_vl);

    } catch(Exception ex) {
        //ex.printStackTrace();
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