<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/식단작성/레시피검색및 등록
■ 프로그램ID   : FSM00060E_T008.jsp
■ 프로그램명   : 레시피수정조회-레시피ITEM조회
■ 작성일자     : 2008-03-17
■ 작성자       : 박은규
■ 이력관리     : 2008-03-17 - 최초작성(fs/fsm:FSM00060E_S008.xml 대체용)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
    try	{
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_cond     = in_dl.get("ds_cond");
        //입력 파라메터
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
        //FileLog.println("d:\\aaa.txt", ds_cond);

        //out 데이타
        DataSet ds_List;
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        sbSql.append("SELECT A.UPJANG                                                                                                          \n");           
        sbSql.append("     , A.MENU_CD                                                                                                         \n");           
        sbSql.append("     , A.RECIPE_SEQ                                                                                                      \n");           
        sbSql.append("     , A.RECIPE_TYPE                                                                                                     \n");           
        sbSql.append("     , A.CUISINE_TYPE                                                                                                    \n");           
        sbSql.append("     , A.RECIPE_CD                                                                                                       \n");           
        sbSql.append("     , A.RECIPE_NAME                                                                                                     \n");           
        sbSql.append("     , (SELECT DISUSE_RATE FROM FSI_ITEM_NUT WHERE ITEM_CODE=A.ITEM_CODE) DISUSE_RATE                                    \n");           
        sbSql.append("     , A.ITEM_CODE                                                                                                       \n");           
        sbSql.append("     , A.ITEM_NAME                                                                                                       \n");           
        sbSql.append("     , A.ITEM_SEQ    --자재순번                                                                                          \n");           
        sbSql.append("     , A.ITEM_CLASS1                                                                                                     \n");           
        sbSql.append("     , A.ITEM_CLASS2                                                                                                     \n");           
        sbSql.append("     , A.ITEM_CLASS3                                                                                                     \n");           
        sbSql.append("     , A.ITEM_CLASS4                                                                                                     \n");           
        sbSql.append("     , A.PHF                                                                                                             \n");           
        sbSql.append("     , A.FEATURE_NAME                                                                                                    \n");           
        sbSql.append("     , A.ITEM_SIZE                                                                                                       \n");           
        sbSql.append("     , A.PO_UOM                                                                                                          \n");           
        sbSql.append("     , A.EDIBLE_QTY                                                                                                      \n");           
        sbSql.append("     , A.CUT_SPEC                                                                                                        \n");           
        sbSql.append("     , A.NEED_QTY --1인량                                                                                                \n");           
        sbSql.append("     , A.EXPECT_MEAL_QTY --예상식수                                                                                      \n");           
        sbSql.append("     , A.EXPECT_SALE_QTY --** 예상판매량                                                                                 \n");           
        sbSql.append("     , ROUND(A.NEED_QTY*A.EXPECT_SALE_QTY/1000,2) TOT_QTY2 -- 행사식 총소요량                                            \n");           
        sbSql.append("     , ROUND(A.NEED_QTY*A.EXPECT_MEAL_QTY/1000,2) TOT_QTY  -- 카페테리아 이외--총소요량--1인소요량* 예상식수/1000 = 총소요량 \n");        
        sbSql.append("     , A.CUR_PRICE --1인당단가                                                                                           \n");           
        sbSql.append("     , A.ORDER_YN --발주여부                                                                                             \n");           
        sbSql.append("     , A.MARGIN_PRICE --구매단가                                                                                         \n");           
        sbSql.append("     , A.G_ITEM_PRICE -- g단가                                                                                           \n");           
        sbSql.append("     , A.MARGIN_RATE --출하율(fsm_real_recipe_item 테이블 저장시만 사용)                                                 \n");           
        sbSql.append("     , A.UNIT_PRICE --구매단가(매입단가 fsm_real_recipe_item 테이블 저장시만 사용)                                       \n");           
        sbSql.append("     , A.NEED_DATE                                                                                                       \n");           
        sbSql.append("     , NVL(LENGTH(DECODE(B.MON,'Y','Y','') || DECODE(B.TUE,'Y','Y','') || DECODE(B.WED,'Y','Y','') || DECODE(B.THU,'Y','Y','') || DECODE(B.FRI,'Y','Y','') || DECODE(B.SAT,'Y','Y','') || DECODE(B.SUN,'Y','Y','')),0) WEEK_CHK \n"); 
        sbSql.append("     , TRIM(DECODE(B.MON,'Y','월 ')||DECODE(B.TUE,'Y','화 ')||DECODE(B.WED,'Y','수 ')||DECODE(B.THU,'Y','목 ')||DECODE(B.FRI,'Y','금 ')||DECODE(B.SAT,'Y','토 ')||DECODE(B.SUN,'Y','일')) AS WEEK_DISP \n");
        sbSql.append("     , B.MON                                                                                                              \n");          
        sbSql.append("     , B.TUE                                                                                                              \n");          
        sbSql.append("     , B.WED                                                                                                              \n");          
        sbSql.append("     , B.THU                                                                                                              \n");          
        sbSql.append("     , B.FRI                                                                                                              \n");          
        sbSql.append("     , B.SAT                                                                                                              \n");          
        sbSql.append("     , B.SUN                                                                                                              \n");
        sbSql.append("     , C.RESTRICT_SEQ                                                                                                     \n");
        sbSql.append("     , C.RESTRICT_START                                                                                                   \n");          
        sbSql.append("     , C.RESTRICT_END                                                                                                     \n");          
        sbSql.append("     , C.RESTRICT_REASON                                                                                                  \n");          
        sbSql.append("     , C.RESTRICT_PERIOD                                                                                                  \n");          
        sbSql.append("     , C.CNL_START                                                                                                        \n");          
        sbSql.append("     , C.CNL_END                                                                                                          \n");          
        sbSql.append("     , C.CNL_REASON                                                                                                       \n");          
        sbSql.append("     , C.CNL_PERIOD                                                                                                       \n");          
        sbSql.append("     , 'D-' || DECODE(F.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(F.D_TIMES,'',24,0,24,F.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + F.D_DAYS + 1) D_DAYS \n");
        sbSql.append("     , DECODE(F.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(F.D_TIMES,'',24,0,24,F.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + F.D_DAYS + 1) D_DAY \n");
        sbSql.append("     , 'N' AS CHEAP_YN                                                                                                    \n");          
        sbSql.append("     , DECODE(SCC_ISHOLIDAY_FUN(A.NEED_DATE), '', 'N', 'Y') AS DAY_COLOR                                                  \n");
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS MTG_UNS -- 불용자재체크                                                                                \n"); 
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') AS MTG_STP -- 중지자재체크(Q-STOP)                          \n");
        sbSql.append("     , FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.NEED_DATE), A.PB_YN, A.ECO_ITEM, A.MANUF_CD) AS FEATURE_ICON    /* 자재특성 */  \n");
        sbSql.append("  FROM (                                                                                                                  \n");          
        sbSql.append("       SELECT A.RECIPE_SEQ                                                                                                \n");          
        sbSql.append("            , A.RECIPE_TYPE                                                                                               \n");          
        sbSql.append("            , A.CUISINE_TYPE                                                                                              \n");          
        sbSql.append("            , A.MENU_CD                                                                                                   \n");          
        sbSql.append("            , A.RECIPE_CD                                                                                                 \n");          
        sbSql.append("            , A.RECIPE_NAME                                                                                               \n");          
        sbSql.append("            , A.ITEM_CODE                                                                                                 \n");          
        sbSql.append("            , A.ITEM_NAME                                                                                                 \n");          
        sbSql.append("            , A.FEATURE_NAME                                                                                              \n");          
        sbSql.append("            , A.ITEM_SIZE                                                                                                 \n");          
        sbSql.append("            , A.PO_UOM                                                                                                    \n");          
        sbSql.append("            , A.EDIBLE_QTY                                                                                                \n");          
        sbSql.append("            , A.CUT_SPEC                                                                                                  \n");          
        sbSql.append("            , A.NEED_QTY                                                                                                  \n");          
        sbSql.append("            , A.ITEM_SEQ                                                                                                  \n");          
        sbSql.append("            , A.PHF                                                                                                       \n");          
        sbSql.append("            , A.EXPECT_MEAL_QTY                                                                                           \n");          
        sbSql.append("            , NVL(ROUND( (A.NEED_QTY * NVL(A.G_ITEM_PRICE,0))),0) CUR_PRICE                                               \n");          
        sbSql.append("            , A.ORDER_YN                                                                                                  \n");          
        sbSql.append("            , A.MARGIN_PRICE                                                                                              \n");          
        sbSql.append("            , A.G_ITEM_PRICE                                                                                              \n");          
        sbSql.append("            , A.MARGIN_RATE                                                                                               \n");          
        sbSql.append("            , A.UNIT_PRICE                                                                                                \n");          
        sbSql.append("            , A.NEED_DATE                                                                                                 \n");          
        sbSql.append("            , B.CUSTCD                                                                                                    \n");          
        sbSql.append("            , B.CENTER_CODE                                                                                               \n");
        sbSql.append("            , B.PB_YN                                                                                               \n");
        sbSql.append("            , A.UPJANG                                                                                                    \n");          
        sbSql.append("            , A.EXPECT_SALE_QTY                                                                                           \n");          
        sbSql.append("            , A.ITEM_CLASS1                                                                                               \n");          
        sbSql.append("            , A.ITEM_CLASS2                                                                                               \n");          
        sbSql.append("            , A.ITEM_CLASS3                                                                                               \n");          
        sbSql.append("            , A.ITEM_CLASS4                                                                                               \n");
        sbSql.append("            , A.ECO_ITEM                                                                                               \n");
        sbSql.append("            , A.MANUF_CD                                                                                               \n");
        sbSql.append("         FROM (                                                                                                           \n");          
        sbSql.append("              SELECT A.UPJANG                                                                                             \n");          
        sbSql.append("                   , A.MENU_CD                                                                                            \n");          
        sbSql.append("                   , A.RECIPE_SEQ                                                                                         \n");          
        sbSql.append("                   , A.RECIPE_TYPE                                                                                        \n");          
        sbSql.append("                   , A.CUISINE_TYPE                                                                                       \n");          
        sbSql.append("                   , A.RECIPE_CD                                                                                          \n");          
        sbSql.append("                   , A.RECIPE_NAME                                                                                        \n");          
        sbSql.append("                   , B.ITEM_CODE                                                                                          \n");          
        sbSql.append("                   , C.ITEM_NAME                                                                                          \n");          
        sbSql.append("                   , '' AS FEATURE_NAME                                                                                   \n");          
        sbSql.append("                   , C.ITEM_SIZE                                                                                          \n");          
        sbSql.append("                   , C.PO_UOM                                                                                             \n");          
        sbSql.append("                   , B.NEED_QTY                                                                                           \n");          
        sbSql.append("                   , B.ORDER_YN                                                                                           \n");          
        sbSql.append("                   , B.CUT_SPEC                                                                                           \n");          
        sbSql.append("                   , B.EDIBLE_QTY                                                                                         \n");          
        sbSql.append("                   , B.NEED_DATE                                                                                          \n");          
        sbSql.append("                   , E.EXPECT_MEAL_QTY                                                                                    \n");          
        sbSql.append("                   , B.ITEM_SEQ                                                                                           \n");          
        sbSql.append("                   , A.PHF                                                                                                \n");          
        sbSql.append("                   , NVL(ROUND((B.NEED_QTY * NVL((B.MARGIN_PRICE / C.KG_CONVERT_RATE / 1000),0))),0) AS PAST_PRICE,A.EXPECT_SALE_QTY   \n");
        sbSql.append("                   , B.UNIT_PRICE                                                                                         \n");          
        sbSql.append("                   , B.MARGIN_RATE                                                                                        \n");          
        sbSql.append("                   , B.MARGIN_PRICE                                                                                       \n");          
        sbSql.append("                   , C.ITEM_CLASS1                                                                                        \n");          
        sbSql.append("                   , C.ITEM_CLASS2                                                                                        \n");          
        sbSql.append("                   , C.ITEM_CLASS3                                                                                        \n");          
        sbSql.append("                   , C.ITEM_CLASS4                                                                                        \n");          
        sbSql.append("                   , C.KG_CONVERT_RATE                                                                                    \n");
        sbSql.append("                   , C.ECO_ITEM                                                                                    \n");
        sbSql.append("                   , C.MANUF_CD                                                                                    \n");
        sbSql.append("                   , ROUND(B.MARGIN_PRICE/C.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE                                       \n");          
        sbSql.append("                FROM FSM_REAL_RECIPE_MST A                                                                                \n");          
        sbSql.append("                   , FSM_REAL_RECIPE_ITEM B                                                                               \n");          
        sbSql.append("                   , HLDC_PO_ITEM_MST C                                                                                   \n");          
        sbSql.append("                   , FSM_REAL_MENU_MST E                                                                                  \n");          
        sbSql.append("               WHERE A.UPJANG = B.UPJANG                                                                                  \n");          
        sbSql.append("                 AND A.MENU_CD = B.MENU_CD                                                                                \n");          
        sbSql.append("                 AND A.RECIPE_CD = B.RECIPE_CD                                                                            \n");          
        sbSql.append("                 AND B.ITEM_CODE = C.ITEM_CODE                                                                            \n");          
        sbSql.append("                 AND C.ITEM_CLASS1 = 'F'                                                                                  \n");          
        sbSql.append("                 AND E.UPJANG = A.UPJANG                                                                                  \n");          
        sbSql.append("                 AND E.MENU_CD = A.MENU_CD                                                                                \n");          
        sbSql.append("                 AND E.UPJANG  = ?                                                                                        \n");                 
        sbSql.append("                 AND E.MENU_CD = ?                                                                                        \n");                               
        sbSql.append("              ) A                                                                                                         \n");          
        sbSql.append("            , (                                                                                                           \n");          
        sbSql.append("              SELECT A.CUSTCD                                                                                             \n");          
        sbSql.append("                   , A.UPJANG                                                                                             \n");          
        sbSql.append("                   , A.CENTER_CODE                                                                                        \n");
        sbSql.append("                   , A.ITEM_CODE                                                                                          \n");
        sbSql.append("                   , A.PB_YN                                                                                              \n");
        sbSql.append("                FROM HLDC_ST_UPJANG B                                                                                     \n");          
        sbSql.append("                   , HLDC_PO_CONTRACT_F A                                                                                 \n");          
        sbSql.append("               WHERE A.USE_YN = 'Y'                                                                                       \n");          
        sbSql.append("                 AND A.CONTRACT_PRICE > 0                                                                                 \n");          
        sbSql.append("                 AND A.UPJANG = B.AP_UNITPRICE_UPJANG                                                                     \n");          
        sbSql.append("                 AND B.UPJANG = ?                                                                                         \n");                 
        sbSql.append("                 AND ? BETWEEN A.CONTRACT_START AND A.CONTRACT_END                                                        \n");                    
        sbSql.append("              ) B    --실시간 단가조회                                                                                    \n");          
        sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                                                \n");          
        sbSql.append("       ) A                                                                                                                \n");          
        sbSql.append("     , (                                                                                                                  \n");          
        sbSql.append("       SELECT A.CENTER_CODE                                                                                               \n");          
        sbSql.append("            , A.CUSTCD                                                                                                    \n");          
        sbSql.append("            , ? UPJANG                                                                                                    \n");                 
        sbSql.append("            , A.ITEM_CODE                                                                                                 \n");          
        sbSql.append("            , A.MON                                                                                                       \n");          
        sbSql.append("            , A.TUE                                                                                                       \n");          
        sbSql.append("            , A.WED                                                                                                       \n");          
        sbSql.append("            , A.THU                                                                                                       \n");          
        sbSql.append("            , A.FRI                                                                                                       \n");          
        sbSql.append("            , A.SAT                                                                                                       \n");          
        sbSql.append("            , A.SUN                                                                                                       \n");          
        sbSql.append("         FROM HLDC_PO_ORDER_SCHEDULE A                                                                                    \n");          
        sbSql.append("        WHERE A.CENTER_CODE = (SELECT CENTER_CODE FROM HLDC_PO_UPJANG_CENTER WHERE UPJANG = ?)                            \n");                 
        sbSql.append("          AND A.UPJANG = ?                                                                                                \n");                 
        sbSql.append("          AND A.UPJANG_TYPE = '01'                                                                                        \n");          
        sbSql.append("       ) B       --요일제한                                                                                               \n");          
        sbSql.append("     , (                                                                                                                  \n");          
        sbSql.append("       SELECT A.UPJANG                                                                                                    \n");          
        sbSql.append("            , A.ITEM_CODE                                                                                                 \n");
        sbSql.append("            , A.RESTRICT_SEQ                                                                                              \n");
        sbSql.append("            , A.RESTRICT_START                                                                                            \n");          
        sbSql.append("            , A.RESTRICT_END                                                                                              \n");          
        sbSql.append("            , A.RESTRICT_REASON                                                                                           \n");          
        sbSql.append("            , TO_CHAR(TO_DATE(A.RESTRICT_START, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) || '~' || TO_CHAR(TO_DATE(A.RESTRICT_END, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) AS RESTRICT_PERIOD \n"); 
        sbSql.append("            , CNL_START                                                                                                   \n");          
        sbSql.append("            , CNL_END                                                                                                     \n");          
        sbSql.append("            , CNL_REASON                                                                                                  \n");          
        sbSql.append("            , NVL2(A.CNL_START,TO_CHAR(TO_DATE(A.CNL_START, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) || '~' || TO_CHAR(TO_DATE(A.CNL_END, 'YYYYMMDD' ) , 'YYYY.MM.DD' ),'') AS CNL_PERIOD \n"); 
        sbSql.append("         FROM FSI_RESTRICT_SET A                                                                                          \n");          
        sbSql.append("            , HLDC_PO_ITEM_MST B                                                                                          \n");          
        sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                   \n");          
        sbSql.append("          AND A.UPJANG = ?                                                                                                \n");                 
        sbSql.append("          AND (B.ITEM_CLASS2 BETWEEN 'F10' AND 'F26' OR B.ITEM_CLASS2 = 'F29')                                             \n");          
        sbSql.append("          AND ( (RESTRICT_START = ?)                                                                                      \n");                   
        sbSql.append("              OR (RESTRICT_END = ?)                                                                                       \n");                   
        sbSql.append("              OR (RESTRICT_START <= ? AND RESTRICT_END >= ?) )                                                            \n");                            
        sbSql.append("          AND NOT (                                                                                                       \n");          
        sbSql.append("                    (CNL_START IS NOT NULL) AND ((CNL_START = ?)                                                          \n");                   
        sbSql.append("                                              OR (CNL_END = ?)                                                            \n");                   
        sbSql.append("                                              OR (CNL_START <= ? AND CNL_END >= ?)                                        \n");                            
        sbSql.append("                    )                                                                                                     \n");          
        sbSql.append("              )                                                                                                           \n");          
        sbSql.append("       ) C                          --금지자재                                                                            \n");
        sbSql.append("     , HLDC_PO_PREORDER_LIST F      -- 선발주제한                                                                         \n");
        sbSql.append(" WHERE A.CENTER_CODE = B.CENTER_CODE(+)                                                                                   \n");          
        sbSql.append("   AND A.CUSTCD = B.CUSTCD(+)                                                                                             \n");          
        sbSql.append("   AND A.UPJANG = B.UPJANG(+)                                                                                             \n");          
        sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+)                                                                                       \n");          
        sbSql.append("   AND A.UPJANG = C.UPJANG(+)                                                                                             \n");          
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                       \n");
        sbSql.append("   AND A.CENTER_CODE = F.CENTER_CODE(+)                                                                                   \n");
        sbSql.append("   AND A.ITEM_CODE   = F.ITEM_CODE(+)                                                                                     \n");
        sbSql.append(" ORDER BY A.RECIPE_SEQ, A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD, A.NEED_QTY DESC                                       \n");
     
/*
        sbSql.append("SELECT A.UPJANG                                                                                                                     \n");
        sbSql.append("     , A.MENU_CD                                                                                                                    \n");
        sbSql.append("     , A.RECIPE_SEQ                                                                                                                 \n");
        sbSql.append("     , A.RECIPE_TYPE                                                                                                                \n");
        sbSql.append("     , A.CUISINE_TYPE                                                                                                               \n");
        sbSql.append("     , A.RECIPE_CD                                                                                                                  \n");
        sbSql.append("     , A.RECIPE_NAME                                                                                                                \n");
        sbSql.append("     , (SELECT DISUSE_RATE FROM FSI_ITEM_NUT WHERE ITEM_CODE=A.ITEM_CODE) DISUSE_RATE                                               \n");
        sbSql.append("     , A.ITEM_CODE                                                                                                                  \n");
        sbSql.append("     , A.ITEM_NAME                                                                                                                  \n");
        sbSql.append("     , A.ITEM_SEQ    --자재순번                                                                                                     \n");
        sbSql.append("     , A.ITEM_CLASS1                                                                                                                \n");
        sbSql.append("     , A.ITEM_CLASS2                                                                                                                \n");
        sbSql.append("     , A.ITEM_CLASS3                                                                                                                \n");
        sbSql.append("     , A.ITEM_CLASS4                                                                                                                \n");
        sbSql.append("     , A.PHF                                                                                                                        \n");
        sbSql.append("     , A.FEATURE_NAME                                                                                                               \n");
        sbSql.append("     , A.ITEM_SIZE                                                                                                                  \n");
        sbSql.append("     , A.PO_UOM                                                                                                                     \n");
        sbSql.append("     , A.EDIBLE_QTY                                                                                                                 \n");
        sbSql.append("     , A.CUT_SPEC                                                                                                                   \n");
        sbSql.append("     , A.NEED_QTY --1인량                                                                                                           \n");
        sbSql.append("     , A.EXPECT_MEAL_QTY --예상식수                                                                                                 \n");
        sbSql.append("     , A.EXPECT_SALE_QTY --** 예상판매량                                                                                            \n");
        sbSql.append("     , ROUND(A.NEED_QTY*A.EXPECT_SALE_QTY/1000,2) TOT_QTY2 -- 행사식 총소요량                                                       \n");
        sbSql.append("     , ROUND(A.NEED_QTY*A.EXPECT_MEAL_QTY/1000,2) TOT_QTY  -- 카페테리아 이외--총소요량--1인소요량* 예상식수/1000 = 총소요량        \n");
        sbSql.append("     , A.CUR_PRICE --1인당단가                                                                                                      \n");
        sbSql.append("     , A.ORDER_YN --발주여부                                                                                                        \n");
        sbSql.append("     , A.MARGIN_PRICE --구매단가                                                                                                    \n");
        sbSql.append("     , A.G_ITEM_PRICE -- g단가                                                                                                      \n");
        sbSql.append("     , A.MARGIN_RATE --출하율(fsm_real_recipe_item 테이블 저장시만 사용)                                                            \n");
        sbSql.append("     , A.UNIT_PRICE --구매단가(매입단가 fsm_real_recipe_item 테이블 저장시만 사용)                                                  \n");
        sbSql.append("     , A.NEED_DATE                                                                                                                  \n");
        sbSql.append("     , NVL(LENGTH(DECODE(B.MON,'Y','Y','') || DECODE(B.TUE,'Y','Y','') || DECODE(B.WED,'Y','Y','') || DECODE(B.THU,'Y','Y','') || DECODE(B.FRI,'Y','Y','') || DECODE(B.SAT,'Y','Y','') || DECODE(B.SUN,'Y','Y','')),0) WEEK_CHK \n");                                                                           
        sbSql.append("     , TRIM(DECODE(B.MON,'Y','월 ')||DECODE(B.TUE,'Y','화 ')||DECODE(B.WED,'Y','수 ')||DECODE(B.THU,'Y','목 ')||DECODE(B.FRI,'Y','금 ')||DECODE(B.SAT,'Y','토 ')||DECODE(B.SUN,'Y','일')) AS WEEK_DISP \n");
        sbSql.append("     , B.MON                                                                                                                        \n");                                                                                                                                                                      
        sbSql.append("     , B.TUE                                                                                                                        \n");                                                                                                                                                                      
        sbSql.append("     , B.WED                                                                                                                        \n");                                                                                                                                                                      
        sbSql.append("     , B.THU                                                                                                                        \n");                                                                                                                                                                      
        sbSql.append("     , B.FRI                                                                                                                        \n");                                                                                                                                                                      
        sbSql.append("     , B.SAT                                                                                                                        \n");                                                                                                                                                                      
        sbSql.append("     , B.SUN                                                                                                                        \n");                                                                                                                                                                      
        sbSql.append("     , C.RESTRICT_START                                                                                                             \n");                                                                                                                                                                      
        sbSql.append("     , C.RESTRICT_END                                                                                                               \n");                                                                                                                                                                      
        sbSql.append("     , C.RESTRICT_REASON                                                                                                            \n");                                                                                                                                                                      
        sbSql.append("     , C.RESTRICT_PERIOD                                                                                                            \n");                                                                                                                                                                      
        sbSql.append("     , C.CNL_START                                                                                                                  \n");                                                                                                                                                                      
        sbSql.append("     , C.CNL_END                                                                                                                    \n");                                                                                                                                                                      
        sbSql.append("     , C.CNL_REASON                                                                                                                 \n");                                                                                                                                                                      
        sbSql.append("     , C.CNL_PERIOD                                                                                                                 \n");                                                                                                                                                                      
        sbSql.append("     , 'D-' || DECODE(A.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(A.D_TIMES,'',24,0,24,A.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + A.D_DAYS + 1) D_DAYS \n");                                                                                                                                           
        sbSql.append("     , DECODE(A.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(A.D_TIMES,'',24,0,24,A.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + A.D_DAYS + 1) D_DAY \n");                                                                                                                                                    
        sbSql.append("     , 'N' AS CHEAP_YN                                                                                                              \n");                                                                                                                                                                      
        sbSql.append("     , DECODE(SCC_ISHOLIDAY_FUN(A.NEED_DATE), '', 'N', 'Y') AS DAY_COLOR                                                            \n");               
        sbSql.append("  FROM (                                                                                                                            \n");                                                                                                                                                                      
        sbSql.append("       SELECT A.RECIPE_SEQ                                                                                                          \n");                                                                                                                                                                     
        sbSql.append("            , A.RECIPE_TYPE                                                                                                         \n");                                                                                                                                                                     
        sbSql.append("            , A.CUISINE_TYPE                                                                                                        \n");                                                                                                                                                                     
        sbSql.append("            , A.MENU_CD                                                                                                             \n");                                                                                                                                                                                    
        sbSql.append("            , A.RECIPE_CD                                                                                                           \n");                                                                                                                                                                     
        sbSql.append("            , A.RECIPE_NAME                                                                                                         \n");                                                                                                                                                                     
        sbSql.append("            , A.ITEM_CODE                                                                                                           \n");                                                                                                                                                                     
        sbSql.append("            , A.ITEM_NAME                                                                                                           \n");                                                                                                                                                                     
        sbSql.append("            , A.FEATURE_NAME                                                                                                        \n");                                                                                                                                                                     
        sbSql.append("            , A.ITEM_SIZE                                                                                                           \n");                                                                                                                                                                     
        sbSql.append("            , A.PO_UOM                                                                                                              \n");                                                                                                                                                                     
        sbSql.append("            , A.EDIBLE_QTY                                                                                                          \n");                                                                                                                                                                     
        sbSql.append("            , A.CUT_SPEC                                                                                                            \n");                                                                                                                                                                     
        sbSql.append("            , A.NEED_QTY                                                                                                            \n");                                                                                                                                                                     
        sbSql.append("            , A.ITEM_SEQ                                                                                                            \n");                                                                                                                                                                                    
        sbSql.append("            , A.PHF                                                                                                                 \n");                                                                                                                                                                                    
        sbSql.append("            , A.EXPECT_MEAL_QTY                                                                                                     \n");                                                                                                                                                                     
        sbSql.append("            , NVL(ROUND( (A.NEED_QTY * NVL(A.G_ITEM_PRICE,0))),0) CUR_PRICE                                                         \n");                                                                                                                                                                     
        sbSql.append("            , A.ORDER_YN                                                                                                            \n");                                                                                                                                                                     
        sbSql.append("            , A.MARGIN_PRICE                                                                                                        \n");                                                                                                                                                                     
        sbSql.append("            , A.G_ITEM_PRICE                                                                                                        \n");                                                                                                                                                                     
        sbSql.append("            , A.MARGIN_RATE                                                                                                         \n");                                                                                                                                                                     
        sbSql.append("            , A.UNIT_PRICE                                                                                                          \n");                                                                                                                                                                     
        sbSql.append("            , A.NEED_DATE                                                                                                           \n");                                                                                                                                                                     
        sbSql.append("            , B.CUSTCD                                                                                                              \n");                                                                                                                                                                     
        sbSql.append("            , B.CENTER_CODE                                                                                                         \n");                                                                                                                                                                     
        sbSql.append("            , A.UPJANG                                                                                                              \n");                                                                                                                                                                     
        sbSql.append("            , A.EXPECT_SALE_QTY                                                                                                     \n");                                                                                                                                                                            
        sbSql.append("            , A.ITEM_CLASS1                                                                                                         \n");                                                                                                                                                                        
        sbSql.append("            , A.ITEM_CLASS2                                                                                                         \n");                                                                                                                                                                        
        sbSql.append("            , A.ITEM_CLASS3                                                                                                         \n");                                                                                                                                                                        
        sbSql.append("            , A.ITEM_CLASS4                                                                                                         \n");
        sbSql.append("            , B.D_DAYS                                                                                                              \n");
        sbSql.append("            , B.D_TIMES                                                                                                             \n");                                                                                                                                                                                                                     
        sbSql.append("         FROM (                                                                                                                     \n");                                                                                                                                                                     
        sbSql.append("              SELECT A.UPJANG                                                                                                       \n");
        sbSql.append("                   , A.MENU_CD                                                                                                      \n");
        sbSql.append("                   , A.RECIPE_SEQ                                                                                                   \n");
        sbSql.append("                   , A.RECIPE_TYPE                                                                                                  \n");
        sbSql.append("                   , A.CUISINE_TYPE                                                                                                 \n");
        sbSql.append("                   , A.RECIPE_CD                                                                                                    \n");
        sbSql.append("                   , A.RECIPE_NAME                                                                                                  \n");
        sbSql.append("                   , B.ITEM_CODE                                                                                                    \n");
        sbSql.append("                   , C.ITEM_NAME                                                                                                    \n");
        sbSql.append("                   , '' AS FEATURE_NAME                                                                                             \n");
        sbSql.append("                   , C.ITEM_SIZE                                                                                                    \n");
        sbSql.append("                   , C.PO_UOM                                                                                                       \n");
        sbSql.append("                   , B.NEED_QTY                                                                                                     \n");
        sbSql.append("                   , B.ORDER_YN                                                                                                     \n");
        sbSql.append("                   , B.CUT_SPEC                                                                                                     \n");
        sbSql.append("                   , B.EDIBLE_QTY                                                                                                   \n");
        sbSql.append("                   , B.NEED_DATE                                                                                                    \n");
        sbSql.append("                   , E.EXPECT_MEAL_QTY                                                                                              \n");
        sbSql.append("                   , B.ITEM_SEQ                                                                                                     \n");
        sbSql.append("                   , A.PHF                                                                                                          \n");
        sbSql.append("                   , NVL(ROUND((B.NEED_QTY * NVL((B.MARGIN_PRICE / C.KG_CONVERT_RATE / 1000),0))),0) AS PAST_PRICE,A.EXPECT_SALE_QTY\n");
        sbSql.append("                   , B.UNIT_PRICE                                                                                                   \n");
        sbSql.append("                   , B.MARGIN_RATE                                                                                                  \n");
        sbSql.append("                   , B.MARGIN_PRICE                                                                                                 \n");
        sbSql.append("                   , C.ITEM_CLASS1                                                                                                  \n");
        sbSql.append("                   , C.ITEM_CLASS2                                                                                                  \n");
        sbSql.append("                   , C.ITEM_CLASS3                                                                                                  \n");
        sbSql.append("                   , C.ITEM_CLASS4                                                                                                  \n");
        sbSql.append("                   , C.KG_CONVERT_RATE                                                                                              \n");
        sbSql.append("                   , ROUND(B.MARGIN_PRICE/C.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE                                                 \n");                                                                                                                     
        sbSql.append("                FROM FSM_REAL_RECIPE_MST A                                                                                          \n");                                                                                                                                                                   
        sbSql.append("                   , FSM_REAL_RECIPE_ITEM B                                                                                         \n");                                                                                                                                                                   
        sbSql.append("                   , HLDC_PO_ITEM_MST C                                                                                             \n");                                                                                                                                                                   
        sbSql.append("                   , FSM_REAL_MENU_MST E                                                                                            \n");                                                                                                                                                                   
        sbSql.append("               WHERE A.UPJANG = B.UPJANG                                                                                            \n");                                                                                                                                                                   
        sbSql.append("                 AND A.MENU_CD = B.MENU_CD                                                                                          \n");                                                                                                                                                                   
        sbSql.append("                 AND A.RECIPE_CD = B.RECIPE_CD                                                                                      \n");                                                                                                                                                                   
        sbSql.append("                 AND B.ITEM_CODE = C.ITEM_CODE                                                                                      \n");                                                                                                                                                                   
        sbSql.append("                 AND C.ITEM_CLASS1 = 'F'                                                                                            \n");                                                                                                                                 
        sbSql.append("                 AND E.UPJANG = A.UPJANG                                                                                            \n");                                                                                                                                                                   
        sbSql.append("                 AND E.MENU_CD = A.MENU_CD                                                                                          \n");                                                                                                                                                                   
        sbSql.append("                 AND E.UPJANG  = ?                                                                                                  \n");                                                                                                                                                                   
        sbSql.append("                 AND E.MENU_CD = ?                                                                                                  \n");                                                                                                                                                                               
        sbSql.append("              ) A                                                                                                                   \n");                                                                                                                                                                     
        sbSql.append("            , (                                                                                                                     \n");                                                                                                                                                                     
        sbSql.append("              SELECT A.ITEM_CODE                                                                                                    \n");                                                                                                                                       
        sbSql.append("                   , D.ITEM_NAME                                                                                                    \n");                                                                                                                                                                                         
        sbSql.append("                   , D.ITEM_SIZE                                                                                                    \n");                                                                                                                                                                                         
        sbSql.append("                   , D.PO_UOM                                                                                                       \n");                                                                                                                                                                                         
        sbSql.append("                   , A.CUSTCD                                                                                                       \n");                                                                                                                                                                                         
        sbSql.append("                   , DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 1) * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) ) AS ITEM_PRICE \n");                             
        sbSql.append("                   , KG_CONVERT_RATE                                                                                                \n");                                                                                                                                                                                         
        sbSql.append("                   , ROUND((DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 1) * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) ) )/KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE \n"); 
        sbSql.append("                   , A.UPJANG                                                                                                       \n");                                                                                                                                                                                       
        sbSql.append("                   , A.CENTER_CODE                                                                                                  \n");                                                                                                                                                                                       
        sbSql.append("                   , A.CONTRACT_PRICE                                                                                               \n");                                                                                                                                                                                       
        sbSql.append("                   , A.MARGIN_RATE                                                                                                  \n");
        sbSql.append("                   , F.D_DAYS                                                                                                       \n");
        sbSql.append("                   , F.D_TIMES                                                                                                      \n");                                                                                                                                                                                                  
        sbSql.append("                FROM HLDC_ST_UPJANG B                                                                                               \n");                                                                                                                                                                                       
        sbSql.append("                   , HLDC_PO_SUBINVENTORY E                                                                                         \n");                                                                                                                                                                                       
        sbSql.append("                   , HLDC_PO_CONTRACT_F A                                                                                           \n");                                                                                                                                                                                       
        sbSql.append("                   , HLDC_PO_ITEM_MST D                                                                                             \n");
        sbSql.append("                   , HLDC_PO_PREORDER_LIST F             -- 선발주제한                                                              \n");                                                                                                                                                                                                                      
        sbSql.append("               WHERE A.ITEM_CODE = D.ITEM_CODE                                                                                      \n");                                                                                                                                                                                        
        sbSql.append("                 AND A.USE_YN = 'Y'                                                                                                 \n");                                                                                                                                                                                        
        sbSql.append("                 AND A.CONTRACT_PRICE > 0                                                                                           \n");                                                                                                                                                                                        
        sbSql.append("                 AND A.UPJANG = B.AP_UNITPRICE_UPJANG                                                                               \n");                                                                                                                                                                                        
        sbSql.append("                 AND B.UPJANG = E.UPJANG                                                                                            \n");                                                                                                                                                                                        
        sbSql.append("                 AND B.UPJANG = ?  --[업장코드]                                                                                     \n");                                                                                                                                                                                        
        sbSql.append("                 AND E.SUBINV_CODE = ?  --[창고코드] FSM_REAL_MENU_MST.SUBINV_CODE 사용(우선적용), FSA_HALL_MST.SUBINV_CODE 사용    \n");                                                                                                                                                                                  
        sbSql.append("                 AND ? BETWEEN A.CONTRACT_START AND A.CONTRACT_END  --[메뉴일자]                                                    \n");
        sbSql.append("                 AND A.CENTER_CODE = F.CENTER_CODE(+)                                                                               \n");
        sbSql.append("                 AND A.ITEM_CODE   = F.ITEM_CODE(+)                                                                                 \n");                                                                                                                                 
        sbSql.append("              ) B    --실시간 단가조회                                                                                              \n");                                                                                                                                                                    
        sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                                                          \n");                                                                                                                                                                    
        sbSql.append("       ) A                                                                                                                          \n");                                                                                                                                                                      
        sbSql.append("     , (                                                                                                                            \n");                                                                                                                                                                      
        sbSql.append("       SELECT A.CENTER_CODE                                                                                                         \n");
        sbSql.append("            , A.CUSTCD                                                                                                              \n");
        sbSql.append("            , ? UPJANG                                                                                                              \n");
        sbSql.append("            , A.ITEM_CODE                                                                                                           \n");
        sbSql.append("            , A.MON                                                                                                                 \n");
        sbSql.append("            , A.TUE                                                                                                                 \n");
        sbSql.append("            , A.WED                                                                                                                 \n");
        sbSql.append("            , A.THU                                                                                                                 \n");
        sbSql.append("            , A.FRI                                                                                                                 \n");
        sbSql.append("            , A.SAT                                                                                                                 \n");
        sbSql.append("            , A.SUN                                                                                                                 \n");                                                                   
        sbSql.append("         FROM HLDC_PO_ORDER_SCHEDULE A                                                                                              \n");                                                                                                                                                                    
        sbSql.append("        WHERE A.CENTER_CODE = (SELECT CENTER_CODE FROM HLDC_PO_UPJANG_CENTER WHERE UPJANG = ?)                                      \n");                                                                                                                                                                                                                             
        sbSql.append("          AND A.UPJANG = ?                                                                                                          \n");                                                                                                                                                               
        sbSql.append("          AND A.UPJANG_TYPE = '01'                                                                                                  \n");                                                                                                                                                               
        sbSql.append("       ) B       --요일제한                                                                                                         \n");                                                                                                                                                                      
        sbSql.append("     , (                                                                                                                            \n");                                                                                                                                                                      
        sbSql.append("       SELECT A.UPJANG                                                                                                              \n");                                                                                                                                                                    
        sbSql.append("            , A.ITEM_CODE                                                                                                           \n");                                                                                                                                                                    
        sbSql.append("            , A.RESTRICT_START                                                                                                      \n");                                                                                                                                                                    
        sbSql.append("            , A.RESTRICT_END                                                                                                        \n");                                                                                                                                                                    
        sbSql.append("            , A.RESTRICT_REASON                                                                                                     \n");                                                                                                                                                                    
        sbSql.append("            , TO_CHAR(TO_DATE(A.RESTRICT_START, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) || '~' || TO_CHAR(TO_DATE(A.RESTRICT_END, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) AS RESTRICT_PERIOD \n");                                                                                                                                 
        sbSql.append("            , CNL_START                                                                                                             \n");                                                                                                                                                                    
        sbSql.append("            , CNL_END                                                                                                               \n");                                                                                                                                                                    
        sbSql.append("            , CNL_REASON                                                                                                            \n");                                                                                                                                                                    
        sbSql.append("            , NVL2(A.CNL_START,TO_CHAR(TO_DATE(A.CNL_START, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) || '~' || TO_CHAR(TO_DATE(A.CNL_END, 'YYYYMMDD' ) , 'YYYY.MM.DD' ),'') AS CNL_PERIOD \n");                                                                                                                           
        sbSql.append("         FROM FSI_RESTRICT_SET A                                                                                                    \n");                                                                                                                                                                    
        sbSql.append("            , HLDC_PO_ITEM_MST B                                                                                                    \n");                                                                                                                                                                    
        sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                             \n");                                                                                                                                                                    
        sbSql.append("          AND A.UPJANG = ?                                                                                                          \n");                                                                                                                                                                    
        sbSql.append("          AND B.ITEM_CLASS2 BETWEEN 'F10' AND 'F26'                                                                                 \n");                                                                                                                                                  
        sbSql.append("          AND ( (RESTRICT_START = ?)                                                                                                \n");                                                                                                                                             
        sbSql.append("              OR (RESTRICT_END = ?)                                                                                                 \n");                                                                                                                                             
        sbSql.append("              OR (RESTRICT_START <= ? AND RESTRICT_END >= ?) )                                                                      \n");                                                                                                                                                            
        sbSql.append("          AND NOT (                                                                                                                 \n");                                                                                                                                                                    
        sbSql.append("                    (CNL_START IS NOT NULL) AND ((CNL_START = ?)                                                                    \n");                                                                                                                                            
        sbSql.append("                                              OR (CNL_END = ?)                                                                      \n");                                                                                                                                            
        sbSql.append("                                              OR (CNL_START <= ? AND CNL_END >= ?)                                                  \n");                                                                                                                                                           
        sbSql.append("                    )                                                                                                               \n");                                                                                                                                                                    
        sbSql.append("              )                                                                                                                     \n");                                                                                                                                                                
        sbSql.append("       ) C          --금지자재                                                                                                      \n");                                                                                                                                                                      
        sbSql.append(" WHERE A.CENTER_CODE = B.CENTER_CODE(+)                                                                                             \n");                                                                                                                                                                     
        sbSql.append("   AND A.CUSTCD = B.CUSTCD(+)                                                                                                       \n");                                                                                                                                                                     
        sbSql.append("   AND A.UPJANG = B.UPJANG(+)                                                                                                       \n");                                                                                                                                                                     
        sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+)                                                                                                 \n");                                                                                                                                                                     
        sbSql.append("   AND A.UPJANG = C.UPJANG(+)                                                                                                       \n");                                                                                                                                                                     
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                                 \n");                                                                                                                                                                     
        sbSql.append(" ORDER BY A.RECIPE_SEQ, A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD, A.NEED_QTY DESC                                                 \n");
*/
        pstmt = conn.prepareStatement(sbSql.toString());
        int idx = 1;
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "UPJANG")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_CD")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "UPJANG")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "UPJANG")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "UPJANG")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "UPJANG")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "UPJANG")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        pstmt.setString(idx++, nullToBlank(ds_cond.getString(0, "MENU_DATE")));
        rs = pstmt.executeQuery();

        ds_List = this.makeDataSet(rs, "ds_List");
        rs.close();

        /**종료**/
        out_dl.add(ds_List);
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