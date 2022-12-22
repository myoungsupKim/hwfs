<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00082E_T001.jsp
■ 프로그램명   : 주문상품 조회
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2008.01.21
                 2021.07.13 [PJT]주문채널통합
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try	{
    	
    	
    	long _startTime = (new Timestamp(System.currentTimeMillis())).getTime();
    			
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_cond      = in_dl.get("ds_Cond");
        DataSet ds_Barcode   = in_dl.get("ds_Barcode"); //[PJT]주문채널통합
        //입력 파라메터
        String g_Upjang      = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo       = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_SystemId    = nullToBlank(in_vl.getString("g_SystemId"));
        //로그인한 사업장의 설정이 아닌 주문등록하는 사업장의 설정에 따름
        //String Holiday_YN   = nullToBlank(in_vl.getString("Holiday_YN"));
        String strIndex      = nullToBlank(in_vl.getString("strIndex"));
        String strOnly       = nullToBlank(in_vl.getString("strOnly"));
        String sType         = nullToBlank(in_vl.getString("sType"));
        //String strThreeMonth = nullToBlank(in_vl.getString("strThreeMonth"));
        String nMonth = nullToBlank(in_vl.getString("nMonth"));		// 최근 n개월
        String strWeekendTimeCheck = nullToBlank(in_vl.getString("strWeekendTimeCheck"));


        //바인드 변수를 위한 변수 할당
        int iBind = 1;
        String bindString[] = new String[100];


        //sql문 버퍼생성
        StringBuffer sbSql_tmp = new StringBuffer();
        sbSql_tmp.delete(0,sbSql_tmp.length());

        String strKeyword	= "";
        String strKeywordGbn	= nullToBlank(ds_cond.getString(0, "GBN")); //[PJT]주문채널통합
        
        StringBuffer sbSearchLog = new StringBuffer();
		
        //[PJT]주문채널통합
        //상품명 검색 
        if("ITEM_NAME".equals(strKeywordGbn) && !nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals(""))
        {
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
            String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");

            sbSql_tmp.setLength(0);
            sbSql_tmp.append("/* fm/fmp/FMP00082E_T001.jsp */                                                 \n");
            sbSql_tmp.append("SELECT LISTAGG(T.ITEM_NAME, ',') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME \n");
            sbSql_tmp.append("  FROM ( SELECT KEYWORD||','||SIM_TXT AS ITEM_NAME                              \n");
            sbSql_tmp.append("              , '1' AS ITEM_GROUP                                               \n");
            sbSql_tmp.append("           FROM EPROCUSR.VO_ITEM_SIM_WORD                                       \n");
            sbSql_tmp.append("          WHERE 1=1 															  \n");
            sbSql_tmp.append("            AND  ( 															  \n");
            for(int i=0; i<arrSameWord_tmp.length; i++) {
            	sbSql_tmp.append("            		KEYWORD = :KEYWORD" + i + "	                              \n");
                if(i < arrSameWord_tmp.length-1) {
                    sbSql_tmp.append("  		OR 															  \n");
                }
            }
            sbSql_tmp.append("    				) 															  \n");
            sbSql_tmp.append("       ) T                                                                      \n");

            out_vl.add("fa_Sql", sbSql_tmp.toString());
            
            npstmt = new NamedParameterStatement(conn, sbSql_tmp.toString());
            for ( int i = 0; i < arrSameWord_tmp.length; i++ ) {
		        npstmt.setString("KEYWORD" + i, arrSameWord_tmp[i]);
            }
	        rs = npstmt.executeQuery();

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
            npstmt.close();
	        rs.close();
	        sbSql_tmp.setLength(0);
// [속도개선 Project 시작] 2017. 8. 28. 최범주
        }
        String[] strKeyword_ItemName = strKeyword.split(",");

        //out 데이타
        DataSet ds_list;
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        String strQtyYn    = nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));
        String strItemName    = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
        String Holiday_YN = "";

        //D-1상품 휴일 체크 무시 유무_Y면:일요일 체크 안하고 일요일 발주 가능
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT HOLIDAY_CHK_YN \n");
        sbSql.append("  FROM FMS_UPJANG A \n");
        sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        if (rs != null && rs.next() ) {
             Holiday_YN = rs.getString("HOLIDAY_CHK_YN");
        }
        if (rs != null) rs.close();
        pstmt.close();

        //신청일자 가져오기
        sbSql.delete(0, sbSql.length());
        /*
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
        */
        
        /*위에는 이상하다.
          상품을 조회하고 수발주 체크를 위해 발주가 난 상품이 있을경우 
          기존 신청일을 가져와서 수발주 체크를 한다
          현재 일자를 보고 수발주 체크를 해야지
          수발주 체크 함수인 EPROCUSR.FN_ITEM_PROCURE_SCH의 9번째 인자가 주문일자임이 확신하면
          현재일자를 넣는것이 맞음
          2015.12.30 박용대
        */
        sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD') AS PR_DATE FROM DUAL\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        String sPrDate = rs.getString("PR_DATE");
        rs.close();
        pstmt.close();
        
        //일요일 월요일 발주 가능 상품 제한 
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS HOLI_ORDER_YN \n");
        sbSql.append("  FROM SCC_COMMON_CODE A \n");
        sbSql.append(" WHERE A.GROUP_CODE = 'WEEKEND_TIME' \n");
        sbSql.append("   AND A.SET1 = 'Y' \n");
        sbSql.append("   AND TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD'), 'D') = A.CODE \n");
        sbSql.append("   AND SUBSTR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDDHH24MI'), 9) BETWEEN A.SET2 AND A.SET3 \n");
        sbSql.append("   AND (TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD'), 'D') = 7 AND TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD')+2 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n"); 
        sbSql.append("       OR (TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD'), 'D') = 1 AND TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD')+1 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n");
        
        /*
        sbSql.append("SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS HOLI_ORDER_YN \n");
        sbSql.append("  FROM DUAL \n");
        sbSql.append(" WHERE TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "', 'YYYYMMDD'), 'D') = 2 -- 입고예정일이 월요일 \n");
        sbSql.append("	 AND TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'), 'YYYYMMDD')+1 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' -- 현재일(일요일)+1 = 입고예정일  \n");
        */
        
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        strWeekendTimeCheck = rs.getString("HOLI_ORDER_YN");
        rs.close();
        pstmt.close();        
                
        //START_공휴일 발주 가능 상품 제한_20151214
        if(strWeekendTimeCheck.equals("N"))
        {
        	sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS HOLI_ORDER_YN \n");
            sbSql.append("  FROM SCC_COMMON_CODE A \n");
            sbSql.append(" WHERE A.GROUP_CODE = 'HOLIDAY_TIME' \n");
            //sbSql.append("   AND SET1 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
            sbSql.append("   AND EXISTS (SELECT SET1 FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'HOLIDAY_TIME' AND SET1 = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n");
            sbSql.append("   AND TO_CHAR(SYSDATE, 'YYYYMMDD') = CODE \n");
            /*
            초기만들때 D-DAY1일만을 고려한 설계임 따라서 연속적인 공휴일은 막을수가 없음
            저장할때 공유일로 지정한 다음날짜를 set1에 저장하는데 그날짜가 입고일이면
            무조건 막는 로직. 이러면 이틀 연속 공휴일도 제한 가능함
            */
            
            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            rs.next();
            strWeekendTimeCheck = rs.getString("HOLI_ORDER_YN");
            rs.close();
            pstmt.close();	
        }        
        //END_공휴일 발주 가능 상품 제한_20151214

        //내역조회
        sbSql.delete(0, sbSql.length());

        sbSql.append("SELECT ROUND(DECODE(M.TAX_CODE, 100, M.OP_PRICE*1.1, M.OP_PRICE)) AS OP_PRICE_TAX, M.* \n");		
        sbSql.append("		, DECODE(M.EXC_GUBUN,'1',DECODE(M.BRAND_YN, 'Y', M.ORDER_YN, DECODE(M.MART_YN, 'Y', M.ORDER_YN, '')),'2', DECODE(M.BRAND_YN, 'Y', M.ORDER_YN, ''), '3', DECODE(M.MART_YN, 'Y', M.ORDER_YN, ''),'') AS EXCEPTION_ORDER \n");
        sbSql.append("		, DECODE((SELECT 1 FROM FMP_ORD_LIMIT Z  \n");
        sbSql.append("        WHERE Z.UPJANG = M.RC_UPJANG \n");
        sbSql.append("          AND Z.ITEM_CODE = M.ITEM_CODE \n");
        sbSql.append("          AND M.NEED_DATE BETWEEN Z.SDATE AND Z.EDATE \n");
        sbSql.append("          AND Z.USE_YN = 'Y' ),1,'Y','') AS LIMIT_ORDER \n");
        
        sbSql.append("		FROM ( \n");
        sbSql.append("SELECT /* [2018031601 임시] 아이템 검색-FMP00082E_T001_renewbind.jsp*/ \n");
        //sbSql.append("       T.*, SCC_SOPR_AGG_FUN( ? , T.ITEM_CODE, '1') AS MAX_SO_QTY, SCC_SOPR_AGG_FUN( ? , T.ITEM_CODE, '3') AS TOT_SO_AMT \n");
        
        sbSql.append("       T.ITEM_CODE, T.ITEM_NAME, T.ITEM_SIZE, T.PO_UOM, T.UNIT_PRICE                             \n");
        sbSql.append("     , T.MARGIN_PRICE, T.SALE_PRICE, T.PR_QTY, T.LINE_STATUS                      \n");
        sbSql.append("     , T.CLS_STATUS, T.PR_REMARK, T.SUBINV_CODE, T.NEED_DATE, T.PRE_NEED_DATE                    \n");
        sbSql.append("     , T.TAX_CODE, T.CUSTCD, T.CENTER_FLAG, T.CENTER_CODE, T.POINT_FLAG                          \n");
        sbSql.append("     , T.PR_UPJANG, T.RC_UPJANG, T.INVAT_FLAG, T.OUTVAT_FLAG, T.MIN_ORD_QTY                      \n");
        sbSql.append("     , T.MAX_ORD_QTY, T.MULTIPLIER_QTY, T.OTCUSTCD                                               \n");
        sbSql.append("     , T.OP_RATE                                                                                 \n");
        
        //[PJT]주문채널통합 재정의 필요 한 컬럼정보
        //sbSql.append("       , T.OP_PRICE, T.OP_AMOUNT, T.G_PRICE                                                        \n");
        sbSql.append("     , T.D_DAYS, T.D_TIMES, T.D_DAY_DISP, T.OTCUSTNM                                             \n");
        sbSql.append("     , T.KG_CONVERT_RATE, T.FEATURE_NAME_CHK, T.IMAGE_PATH, T.IMAGE_YN, T.CONSUM_YN              \n");
        sbSql.append("     , T.PR_ID, T.KEEPING_TYPE, T.APPLY_SD, T.VD_SN, T.ORIGIN_TYPE                               \n");
        sbSql.append("     , T.MOBILE_GUBUN, T.UPJANG_GRP, T.PO_STATUS, T.UNUSE_YN, T.VAL_STP_YN                       \n");
        sbSql.append("     , T.FMP_STATUS, T.PO_WEEK_STATUS, T.DANGA_ITEM_CODE, T.UOM_CONVERT_RATE, T.TOT_WGHT         \n");
        sbSql.append("     , T.FAVOR_GROUP_FLAG, T.WIN_ITEM_CD                                                         \n");
        
        sbSql.append("     , SCC_SOPR_AGG_FUN( ? , T.ITEM_CODE, '1') AS MAX_SO_QTY, SCC_SOPR_AGG_FUN( ? , T.ITEM_CODE, '3') AS TOT_SO_AMT \n");
      	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        //sbSql.append("     , DECODE(T.FEATURE_NAME_CHK, NULL, U.FEATURE_NAME, T.FEATURE_NAME_CHK||U.FEATURE_NAME) AS FEATURE_NAME \n");
        //sbSql.append("     , U.FEATURE_ICON \n");
        sbSql.append("     , DECODE(T.PO_WEEK_STATUS, 'XR', '', T.ITEM_CODE) AS WEEK_ITEM_CODE \n");
        sbSql.append("     , DECODE(T.DANGA_ITEM_CODE, NULL, 'NN', 'FE') AS DANGAWEEK_STATUS \n");
        
        //[PJT]주문채널통합
        sbSql.append("     , NVL(FN_GET_BOX_QTY_FUN(T.ITEM_CODE, (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = T.CENTER_CODE), T.VD_SN, T.CENTER_FLAG), 0) AS BOX_QTY \n"); //BOX입수량
        
        sbSql.append("     , CASE WHEN T.CC_OP_PRICE IS NOT NULL OR T.CC_OP_RATE IS NOT NULL \n");
        sbSql.append("            THEN DECODE(SIGN(NVL(T.CC_OP_PRICE,0) ),0, SCC_CEIL(T.SALE_PRICE + (T.SALE_PRICE * NVL(T.CC_OP_RATE,0) / 100),T.CC_CEIL_VAL), T.CC_OP_PRICE) \n");
        sbSql.append("            WHEN (T.DD_OP_PRICE IS NOT NULL OR T.DD_OP_RATE IS NOT NULL) AND T.CENTER_CODE <> '0' \n");
        sbSql.append("            THEN DECODE(SIGN(NVL(T.DD_OP_PRICE,0) ),0, SCC_CEIL(T.SALE_PRICE + (T.SALE_PRICE * NVL(T.DD_OP_RATE,0) / 100),T.DD_CEIL_VAL), T.DD_OP_PRICE) \n");
        sbSql.append("       ELSE T.SALE_PRICE END AS OP_PRICE \n");
        
        sbSql.append("     , ROUND(CASE WHEN T.CC_OP_PRICE IS NOT NULL OR T.CC_OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(T.CC_OP_PRICE,0) ),0, SCC_CEIL(T.SALE_PRICE + (T.SALE_PRICE * NVL(T.CC_OP_RATE,0) / 100),T.CC_CEIL_VAL), T.CC_OP_PRICE) \n");
        sbSql.append("                  WHEN (T.DD_OP_PRICE IS NOT NULL OR T.DD_OP_RATE IS NOT NULL) AND T.CENTER_CODE <> '0' \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(T.DD_OP_PRICE,0) ),0, SCC_CEIL(T.SALE_PRICE + (T.SALE_PRICE * NVL(T.DD_OP_RATE,0) / 100),T.DD_CEIL_VAL), T.DD_OP_PRICE) \n");
        sbSql.append("             ELSE T.SALE_PRICE END * T.PR_QTY) AS OP_AMOUNT \n");
        sbSql.append("     , ROUND(CASE WHEN T.CC_OP_PRICE IS NOT NULL OR T.CC_OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(T.CC_OP_PRICE,0) ),0, SCC_CEIL(T.SALE_PRICE + (T.SALE_PRICE * NVL(T.CC_OP_RATE,0) / 100),T.CC_CEIL_VAL), T.CC_OP_PRICE) \n");
        sbSql.append("                  WHEN (T.DD_OP_PRICE IS NOT NULL OR T.DD_OP_RATE IS NOT NULL) AND T.CENTER_CODE <> '0' \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(T.DD_OP_PRICE,0) ),0, SCC_CEIL(T.SALE_PRICE + (T.SALE_PRICE * NVL(T.DD_OP_RATE,0) / 100),T.DD_CEIL_VAL), T.DD_OP_PRICE) \n");
        sbSql.append("             ELSE T.SALE_PRICE END / T.KG_CONVERT_RATE / 1000,1) AS G_PRICE \n");
        sbSql.append("     , 0 AS OP_AMOUNT_OLD \n");
        sbSql.append("     , CASE WHEN T.EVENT_ID IS NOT NULL                                            \n");
        sbSql.append("            THEN 'theme://Images/new/grd_WF_Icon06.png'                            \n");
        sbSql.append("            ELSE U.FEATURE_ICON                                                    \n");
        sbSql.append("        END AS FEATURE_ICON                                                        \n");
        sbSql.append("     , DECODE(T.FEATURE_NAME_CHK, NULL,                                            \n");
        sbSql.append("                    ( CASE WHEN T.EVENT_ID IS NOT NULL                             \n");
        sbSql.append("                           THEN '특가행사'                                         \n");
        sbSql.append("                           ELSE U.FEATURE_NAME                                     \n");
        sbSql.append("                       END )                                                       \n");
        sbSql.append("                    , T.FEATURE_NAME_CHK||U.FEATURE_NAME) AS FEATURE_NAME          \n");
        
        sbSql.append("     , ROUND(T.SALE_PRICE * T.PR_QTY) AS SALE_AMOUNT                               \n");
        sbSql.append("     , T.EVENT_ID                                                                  \n");
        sbSql.append("     , T.EVENT_DATE                                                                  \n");
        sbSql.append("     , T.SALE_PRICE_ORG                                                            \n");
        sbSql.append("     , T.EVENT_PRICE                                                               \n");
        
        //sbSql.append("     , DECODE(T.FEATURE_NAME_CHK, NULL, U.FEATURE_NAME, T.FEATURE_NAME_CHK||U.FEATURE_NAME) AS FEATURE_NAME ");
        // 화면용 컬럼정보
        sbSql.append("     , 0.0 AS  PR_BOX_QTY                                                          \n");
        sbSql.append("     , 0.0 AS  PR_PC_QTY                                                           \n");
        sbSql.append("     , T.RTN_YN                                                           \n");
        
        
        // 품목검색조건 (0:전체 n:최근n개월)
        if ( !nMonth.equals("0") )	
        {
        	sbSql.append("     , Y.PR_REMARK_RECENT ");
        }
     
        //전자구매 수발주제어 예외관리 추가 2022.05.06
        sbSql.append(", NVL((SELECT 'Y' FROM FMS_UPJANG WHERE UPJANG = ? AND DEPT_ID IN ( /* 브랜드유통사업장만 */   \n");
        sbSql.append("      																SELECT CC_CD  	    \n");
        sbSql.append("        																FROM HLDC_SC_DEPT_V	\n");
        sbSql.append("       																WHERE BU_CD = '2000'\n");
        sbSql.append("          															AND MU_CD = '2004'  \n");
		sbSql.append("          															AND TM_CD LIKE 'CI%'  \n");
		sbSql.append("                   												 )				        \n");
		sbSql.append("),'') AS BRAND_YN																			\n");
		bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
		
		sbSql.append(", NVL((SELECT 'Y' FROM FMS_UPJANG WHERE UPJANG = ? AND DEPT_ID IN ( /* 마트사업장 */   \n");
        sbSql.append("      																SELECT CC_CD  	    \n");
        sbSql.append("        																FROM HLDC_SC_DEPT_V	\n");
        sbSql.append("       																WHERE BU_CD = '2000'\n");
        sbSql.append("          															AND MU_CD = '2004'  \n");
		sbSql.append("          															AND DEPT_ID IN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'BRAND_UPJANG_POP_ETC') \n");
		sbSql.append("                   												 )				        \n");
		sbSql.append("),'') AS MART_YN																			\n");
		bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
		
		sbSql.append(", NVL((SELECT EXC_GUBUN FROM EXC_ITEM_MST WHERE ITEM_CODE = T.ITEM_CODE),'') AS EXC_GUBUN \n");
		sbSql.append(", NVL((SELECT ORDER_YN FROM EXC_ITEM_MST WHERE ITEM_CODE = T.ITEM_CODE),'') AS ORDER_YN  \n");
        
        sbSql.append("  FROM ( \n");

        sbSql.append("SELECT A.ITEM_CODE, REPLACE(REPLACE(A.ITEM_NAME, chr(10),''), chr(13),'') AS ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
        sbSql.append("     , B.DEF_QTY AS PR_QTY \n");
        //LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
        sbSql.append("     , '002' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
        sbSql.append("     , ? AS SUBINV_CODE, A.NEED_DATE, B.PRE_NEED_DATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
        sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, ? AS PR_UPJANG \n");
        bindString[iBind++] = g_Upjang;
        sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
         sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
        sbSql.append("     , A.OTCUSTCD \n");
        
        
        //[PJT]주문채널통합
        sbSql.append("     , CC.OP_PRICE AS CC_OP_PRICE, CC.OP_RATE AS CC_OP_RATE, CC.CEIL_VAL AS CC_CEIL_VAL \n");
        sbSql.append("     , DD.OP_PRICE AS DD_OP_PRICE, DD.OP_RATE AS DD_OP_RATE, DD.CEIL_VAL AS DD_CEIL_VAL \n");
        sbSql.append("     , DECODE(CC.OP_RATE, NULL,DECODE(A.CENTER_CODE, '0', 0, DD.OP_RATE), CC.OP_RATE) AS OP_RATE \n");
        
        sbSql.append("     ,  A.SALE_PRICE_ORG                                                        \n");
        sbSql.append("     ,  A.EVENT_PRICE                                                         \n");
        //[20220607009 - 1]단가 금액 관계없이 최근 입력한 단가로 적용 요청 2022.10.26 (AND A.EVENT_PRICE < A.SALE_PRICE_ORG 제거)
        sbSql.append("     , CASE WHEN A.EVENT_PRICE > 0											  \n");
        sbSql.append("            THEN A.EVENT_PRICE                                                  \n");
        sbSql.append("            ELSE A.SALE_PRICE_ORG                                               \n");
        sbSql.append("        END AS SALE_PRICE                                                       \n");
        sbSql.append("     , CASE WHEN A.EVENT_PRICE > 0  											  \n");
        sbSql.append("            THEN A.EVENT_ID                                                     \n");
        sbSql.append("            ELSE NULL                                                           \n");
        sbSql.append("        END AS EVENT_ID                                                         \n");
        sbSql.append("     , CASE WHEN A.EVENT_PRICE > 0 											  \n");
        sbSql.append("            THEN A.EVENT_DATE                                                     \n");
        sbSql.append("            ELSE NULL                                                           \n");
        sbSql.append("        END AS EVENT_DATE                                                         \n");

        
        //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음.
        //if (g_SystemId.equals("SPOON"))
        if (Holiday_YN.equals("Y"))
        {
            sbSql.append("     , A.D_DAYS, A.D_TIMES \n");
            sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS) AS D_DAY_DISP \n");
        }
        else
        {
        /////////////////////////////////////////////////////////////////20151008 튜닝쿼리 추가
// 			sbSql.append("     , FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS) AS D_DAYS \n");
            //sbSql.append("     , TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "', 'YYYYMMDD') - TO_DATE(KK.NONHOLI_DATE, 'YYYYMMDD') AS D_DAYS \n");
            sbSql.append("     , DECODE(A.CENTER_CODE, '0', A.D_DAYS, FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS')) AS D_DAYS \n");
            sbSql.append("     , A.D_TIMES \n");
            // 2015.07.06 김진희매니져요청사항 D-Day만 표시 sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS))||' '||TRIM(TO_CHAR(A.D_TIMES,'0000')) AS D_DAY_DISP \n");
// 			sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS)) AS D_DAY_DISP \n");
        /////////////////////////////////////////////////////////////////20151008 튜닝쿼리 추가
            //sbSql.append("     , 'D-'||TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "', 'YYYYMMDD') - TO_DATE(KK.NONHOLI_DATE, 'YYYYMMDD')) AS D_DAY_DISP \n");
            sbSql.append("     , 'D-'||DECODE(A.CENTER_CODE, '0', A.D_DAYS, FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS')) AS D_DAY_DISP \n");
        }
        //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음.  //2010-12-30 로직 추가 BY 노규완

        sbSql.append("     , D.OTCUSTNM, A.KG_CONVERT_RATE \n");

         if (strOnly.equals("TRUE"))
             sbSql.append("     , NULL AS FEATURE_NAME_CHK \n");
         else
             sbSql.append("     , DECODE(A.WEEK_ITEM_CODE,NULL,NULL,'(요일통제)')||DECODE(E.ITEM_CODE,NULL,NULL,'(주문통제)') AS FEATURE_NAME_CHK \n");

        sbSql.append("     , A.IMAGE_PATH, DECODE(A.IMAGE_PATH,NULL,'N','Y') AS IMAGE_YN \n");

        if (! strOnly.equals("TRUE"))
            sbSql.append("     , E.ITEM_CODE AS LIMIT_ITEM, E.LIMIT_REASON \n");

// 		sbSql.append("     , A.WEEK_ITEM_CODE \n");
        sbSql.append("     , A.CONSUM_YN, B.PR_ID, A.KEEPING_TYPE \n");
        sbSql.append("     , A.APPLY_SD, A.VD_SN \n");
        sbSql.append("     , A.ORIGIN_TYPE \n");
        sbSql.append("     , 'P' AS MOBILE_GUBUN \n");
        //sbSql.append("     , SCC_SOPR_AGG_FUN( ? , A.ITEM_CODE, '1') AS MAX_SO_QTY \n");
        //bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        //sbSql.append("     , SCC_SOPR_AGG_FUN( ? , A.ITEM_CODE, '3') AS TOT_SO_AMT \n");
        //bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        sbSql.append("     , A.UPJANG_GRP \n");
        //sbSql.append("     , CASE WHEN A.PO_STATUS = 'HK' AND A.FMP_STATUS = 'N' THEN '' ELSE A.ITEM_CODE END AS WEEK_ITEM_CODE \n");
        //sbSql.append("     , A.PO_STATUS \n");
        //sbSql.append("     , A.FMP_STATUS \n");
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), ? , ? ), 'HK') AS PO_STATUS \n");
        bindString[iBind++] = sPrDate;
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        //불용자재체크
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS UNUSE_YN  \n");
        //중지자재체크
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS VAL_STP_YN \n");
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', FMP_ORDER_SCHL_FUN(? , A.CUSTCD, A.ITEM_CODE, ?), 'N') AS FMP_STATUS \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', ?), 'XR') AS PO_WEEK_STATUS , DANGA_ITEM_CODE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("     , A.UOM_CONVERT_RATE \n");
        sbSql.append("     , '' AS TOT_WGHT \n");
        sbSql.append("     , (SELECT MAX(Z.FAVOR_GROUP) FROM FMP_FAVORITE Z WHERE Z.UPJANG = A.UPJANG AND Z.ITEM_CODE = A.ITEM_CODE AND Z.USE_YN = 'Y') AS FAVOR_GROUP_FLAG \n");
        
        //[PJT]주문채널통합
        sbSql.append("     , A.WIN_ITEM_CD \n"); 
        sbSql.append("     , A.RTN_YN \n");

        
        
        if(strIndex.equals("2")){
        	sbSql.append("     , B.CDATE \n");
        }

        //sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS ITEM_STOP \n"); // 구매불용자재체크

        sbSql.append("  FROM \n");

        sbSql.append("       ( \n");
        sbSql.append("       SELECT * \n");
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("          AND ? BETWEEN SDATE AND EDATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND USE_YN = 'Y' \n");
        sbSql.append("          AND ITEM_TYPE = 'M' \n");
        sbSql.append("       ) CC \n");
        sbSql.append("      ,( \n");
        sbSql.append("       SELECT * \n");
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("          AND ? BETWEEN SDATE AND EDATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND USE_YN = 'Y' \n");
        sbSql.append("          AND ITEM_TYPE = 'C' \n");
        sbSql.append("       ) DD \n");

        //sbSql.append("     , FMP_OTHER_CUST D , FMP_OTCUST_LINK F, HLDC_PO_CENTER G \n");
        sbSql.append("     , FMP_OTHER_CUST D , FMP_OTCUST_LINK F \n");

        if (! strOnly.equals("TRUE"))
            sbSql.append("     , FMP_ORD_LIMIT E \n");

        //상품조회
        if (strIndex.equals("1"))
            sbSql.append("     ,(SELECT 0 AS DEF_QTY, '' AS PR_ID, '' AS PRE_NEED_DATE  FROM DUAL) B \n");

        //즐겨찾기
        else if (strIndex.equals("2"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.DEF_QTY , '' AS PR_ID, '' AS PRE_NEED_DATE, A.CDATE \n");
            sbSql.append("         FROM FMP_FAVORITE A \n");
            sbSql.append("        WHERE A.UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
            sbSql.append("          AND A.FAVOR_GROUP = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "FAVOR_GROUP"));
            sbSql.append("          AND A.USE_YN = 'Y') B \n");
        }
        //주간발주
        else if (strIndex.equals("3"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.DEF_QTY, '' AS PR_ID, '' AS PRE_NEED_DATE \n");
            sbSql.append("         FROM FMP_WEEKLY_ITEM A \n");
            sbSql.append("        WHERE A.UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
            sbSql.append("          AND NVL(DECODE(TO_CHAR(SYSDATE,'D'),1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT),'Y') = 'Y' \n");
            sbSql.append("          AND A.USE_YN = 'Y') B \n");
        }
        //지난발주
        else if (strIndex.equals("4"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM SO_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATEP"));
            sbSql.append("          AND A.RC_UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANGP"));
            sbSql.append("          AND A.SUBINV_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODEP"));
            sbSql.append("        UNION ALL \n");
            sbSql.append("       SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM FMP_OTCUST_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATEP"));
            sbSql.append("          AND A.UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANGP"));
            sbSql.append("          AND A.SUBINV_CODE = ? ) B \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODEP"));
        }
        //최근3개월발주
        else if (strIndex.equals("5"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM SO_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN ADD_MONTHS( ? , -3) AND ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATET"));
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATET"));
            sbSql.append("          AND A.RC_UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANGT"));
            sbSql.append("          AND A.SUBINV_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODET"));
            sbSql.append("        UNION ALL \n");
            sbSql.append("       SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM FMP_OTCUST_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN ADD_MONTHS(? , -3) AND ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATET"));
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATET"));
            sbSql.append("          AND A.UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANGT"));
            sbSql.append("          AND A.SUBINV_CODE = ? ) B \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODET"));
        }

        sbSql.append("     ,(SELECT ? AS UPJANG \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("            , ? AS NEED_DATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
        //sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
        // 제조사 정보 빼고 표시
        sbSql.append("            , A.ITEM_CODE \n");
        sbSql.append("            , REPLACE(C.ITEM_NAME, ' '||C.MAKER, '') AS ITEM_NAME \n");
        sbSql.append("            , C.ITEM_SIZE, C.PO_UOM \n");
        
        sbSql.append("            , C.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
        sbSql.append("            , A.CENTER_CODE, C.POINT_FLAG \n");
        sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE \n");
        
        //[PJT]주문채널통합
        sbSql.append("            , A.SALE_PRICE AS SALE_PRICE_ORG \n");
        sbSql.append("            , FMS_EVENT_INFO_FUN(?, A.ITEM_CODE, ?, '0000', 'ID') AS EVENT_ID \n"); 
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        
        sbSql.append("            , FMS_EVENT_INFO_FUN(?, A.ITEM_CODE, ?, '0000', 'DATE') AS EVENT_DATE \n"); 
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        
        sbSql.append("            , NVL(FMS_EVENT_INFO_FUN(?, A.ITEM_CODE, ?, '0000', 'PRICE'),0) AS EVENT_PRICE \n"); 
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));

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
         sbSql.append("            , DECODE( SIGN(TO_DATE( ? ,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) ) \n");
         bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
         sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) \n");
         sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) AS D_DAYS \n");
        sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES \n");
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            , C.IMG_PATH AS IMAGE_PATH \n");
        sbSql.append("            , A.DANGA_ITEM_CODE, A.WEEK_ITEM_CODE, C.KEEPING_TYPE \n");
        sbSql.append("            , A.APPLY_SD, A.VD_SN \n");
        sbSql.append("            , C.ORIGIN_TYPE \n");
        sbSql.append("            , A.UPJANG_GRP \n");
        sbSql.append("            , C.UOM_CONVERT_RATE \n");
        sbSql.append("            , D.WIN_ITEM_CD \n"); //[PJT]주문채널통합
        sbSql.append("            , NVL((SELECT 'Y' FROM RTN_ITEM_MST X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.USE_YN = 'Y'), 'N') AS RTN_YN \n");
        //sbSql.append("            , EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), '"+sPrDate+"', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS PO_STATUS \n");
        //sbSql.append("            , FMP_ORDER_SCHL_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", A.CUSTCD, A.ITEM_CODE, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS FMP_STATUS \n");
        sbSql.append("         FROM \n");
         
        // 수발주 스케쥴따라(-2:전체,단가업장별) 주문가능한 상품을 나타내준다.
        if (strOnly.equals("TRUE"))
        {
        	sbSql.append("             (SELECT /*+ NO_MERGE(A) */ A.*, NULL AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE \n");
	        
            sbSql.append("               FROM (SELECT * \n");
            sbSql.append("               FROM FCUS.HLDC_PO_CONTRACT_FSALE A \n");
            sbSql.append("               WHERE A.CENTER_CODE = ?  \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("               AND A.UPJANG = ?  \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("               AND ? BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999')) A \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("               WHERE 1=1 \n");
        	sbSql.append("               AND (CENTER_CODE, CUSTCD, ITEM_CODE) NOT IN \n");
            sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE( ? ,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       UNION ALL \n");
            sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = -2 \n");
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE( ? ,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       MINUS \n");
            sbSql.append("                      SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE( ? ,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y')) \n");
            //sbSql.append("                     AND EXISTS (SELECT 1 FROM HLDC_PO_CONTRACT_F2 WHERE CENTER_CODE = A.CENTER_CODE AND UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND CONTRACT_PRICE > 0 AND ? BETWEEN CONTRACT_START AND CONTRACT_END) \n");
        	//bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("					AND EXISTS (	\n");
            sbSql.append("								SELECT 1 FROM EPROCUSR.VO_CONTRACT_F3 	\n");
            sbSql.append("									WHERE CENTER_CODE = ? 				\n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("									AND ITEM_CODE = A.ITEM_CODE			\n");
            sbSql.append("									AND CONTRACT_PRICE > 0 				\n");
            sbSql.append("									AND ? BETWEEN CONTRACT_START AND CONTRACT_END	\n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("									AND UPJANG_GRP = (		\n");
            sbSql.append("												SELECT Z.SHOP_GRP_CD AS UPJANG_GRP FROM EPROCUSR.ESPSSHPORG Z WHERE Z.SYS_ID = '100' AND Z.COMP_CD = 'HFC' AND Z.SHOP_CD = ? 	\n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
            sbSql.append("												) \n");
            sbSql.append("								) \n");
        }
        else
        {
        	sbSql.append("             (SELECT /*+ NO_MERGE(A) */ A.*, B.ITEM_CODE AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE \n");
            //sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
            sbSql.append("               FROM (SELECT * \n");
            sbSql.append("               FROM FCUS.HLDC_PO_CONTRACT_FSALE A \n");
            sbSql.append("               WHERE A.CENTER_CODE = ?  \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("               AND A.UPJANG = ?  \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("               AND ? BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999')) A \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                   , (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE( ? ,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       UNION ALL \n");
            sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = -2 \n");
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE( ? ,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
            sbSql.append("                       MINUS \n");
            sbSql.append("                      SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
            sbSql.append("                        FROM FMP_ORDER_SCHEDULE \n");
            sbSql.append("                       WHERE CENTER_CODE = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("                         AND UPJANG = ? \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
            sbSql.append("                         AND USE_YN = 'Y' \n");
            sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE( ? ,'YYYYMMDD'),'D'), \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y') \n");
            sbSql.append("                     ) B \n");
            sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE(+) \n");
            sbSql.append("                 AND A.CUSTCD = B.CUSTCD(+) \n");
            sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
            //sbSql.append("                     AND EXISTS (SELECT 1 FROM HLDC_PO_CONTRACT_F WHERE CENTER_CODE = A.CENTER_CODE AND UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND CONTRACT_PRICE > 0 AND ? BETWEEN CONTRACT_START AND CONTRACT_END) \n");
            sbSql.append("					AND EXISTS (	\n");
            sbSql.append("								SELECT 1 FROM EPROCUSR.VO_CONTRACT_F3 	\n");
            sbSql.append("									WHERE CENTER_CODE = ? 				\n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
            sbSql.append("									AND ITEM_CODE = A.ITEM_CODE			\n");
            sbSql.append("									AND CONTRACT_PRICE > 0 				\n");
            sbSql.append("									AND ? BETWEEN CONTRACT_START AND CONTRACT_END	\n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            sbSql.append("									AND UPJANG_GRP = (		\n");
            sbSql.append("												SELECT Z.SHOP_GRP_CD AS UPJANG_GRP FROM EPROCUSR.ESPSSHPORG Z WHERE Z.SYS_ID = '100' AND Z.COMP_CD = 'HFC' AND Z.SHOP_CD = ? 	\n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
            sbSql.append("												) \n");
            sbSql.append("								) \n");
        }
    	//sbSql.append("              	   AND A.CENTER_CODE = ? \n");
    	//bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
    	//sbSql.append("              	   AND A.UPJANG = ? \n");
    	//bindString[iBind++] = nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG"));
    	//sbSql.append("                     AND ? BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
    	//bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        // 2015.07.30 구매 단가 계약 테이블 조인(금지자재체크)
        sbSql.append("             ) A \n");
        sbSql.append("            , HLDC_PO_ITEM_MST C \n");
        sbSql.append("            , EPROCUSR.ESMMTGL D \n");//[PJT]주문채널통합
        sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
        // FICS 주말 발주 제한 자재
        if (strWeekendTimeCheck.equals("Y")){
            sbSql.append("            , FMS_WEEKEND_ITEM L \n");
        }
        sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE \n");
        sbSql.append("          AND A.SALE_PRICE > 0 \n");
        sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
        sbSql.append("          AND C.ITEM_CLASS1 = 'F' \n");
        sbSql.append("          AND C.CONSUM_YN = NVL( ? ,C.CONSUM_YN) \n");
        sbSql.append("          AND A.ITEM_CODE   = D.ITEM_CD(+) \n");//[PJT]주문채널통합
        sbSql.append("          AND D.SYS_ID      = '100' \n"); //[PJT]주문채널통합
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CONSUM_YN"));
        sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
        sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
        // FICS 주말 발주 제한 자재
        if (strWeekendTimeCheck.equals("Y")){
            sbSql.append("          AND A.ITEM_CODE = L.ITEM_CODE \n");
            sbSql.append("          AND A.CENTER_CODE = L.CENTER_CODE \n");
            sbSql.append("          AND L.USE_YN = 'Y' \n");
        }
        sbSql.append("       ----------- \n");
        sbSql.append("        UNION ALL \n");
        sbSql.append("       ----------- \n");
        sbSql.append("       SELECT ? AS UPJANG, ? AS NEED_DATE \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
        sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
        sbSql.append("            , C.TAX_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG \n");
        sbSql.append("            , '0' AS CENTER_CODE, C.POINT_FLAG \n");
        sbSql.append("            , A.UNIT_PRICE \n");
        //[PJT]주문채널통합
        sbSql.append("            , A.SALE_PRICE AS SALE_PRICE_ORG \n");
        
        sbSql.append("            , FMS_EVENT_INFO_FUN(?, A.ITEM_CODE, ?, '0000', 'ID') AS EVENT_ID \n"); 
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        
        sbSql.append("            , FMS_EVENT_INFO_FUN(?, A.ITEM_CODE, ?, '0000', 'DATE') AS EVENT_DATE \n"); 
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        
        sbSql.append("            , NVL(FMS_EVENT_INFO_FUN(?, A.ITEM_CODE, ?, '0000', 'PRICE'),0) AS EVENT_PRICE \n"); 
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        
        sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY \n");
        sbSql.append("            , C.OTCUSTCD \n");
        sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가 \n");
        sbSql.append("            , DECODE( SIGN(TO_DATE( ? ,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1) \n");
        sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS \n");
        sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES \n");
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            , C.SIMAGE_PATH AS IMAGE_PATH \n");
        sbSql.append("            , NULL AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE, C.KEEPING_TYPE \n");
        sbSql.append("            , '' AS APPLY_SD, '' AS VD_SN \n");
        sbSql.append("            , C.ORIGIN_TYPE \n");
        sbSql.append("            , '' AS UPJANG_GRP \n");
        sbSql.append("            , C.UOM_CONVERT_RATE \n");
        sbSql.append("            , D.WIN_ITEM_CD \n"); //[PJT]주문채널통합
        sbSql.append("            , NVL((SELECT 'Y' FROM RTN_ITEM_MST X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.USE_YN = 'Y'), 'N') AS RTN_YN \n");
        //sbSql.append("            , 'HK' AS PO_STATUS \n");
        //sbSql.append("            , 'N' AS FMP_STATUS \n");
        sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
        sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
        sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
        sbSql.append("               WHERE UPJANG = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "OTCUST_PRICE_UPJANG"));
        sbSql.append("                 AND SDATE <= ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("               GROUP BY UPJANG, ITEM_CODE \n");
        sbSql.append("              ) B \n");
        sbSql.append("            , FMP_OTCUST_ITEM C \n");
        sbSql.append("            , EPROCUSR.ESMMTGL D \n"); //[PJT]주문채널통합
        sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
        sbSql.append("          AND A.SDATE = B.SDATE \n");
        sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE \n");
        sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
        sbSql.append("          AND A.ITEM_CODE  = D.ITEM_CD(+) \n"); //[PJT]주문채널통합
        sbSql.append("          AND A.SALE_PRICE > 0 \n");
        sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
        sbSql.append("          AND C.CONSUM_YN = NVL( ? ,C.CONSUM_YN) \n");
        sbSql.append("          AND D.SYS_ID    = '100' \n"); //[PJT]주문채널통합
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CONSUM_YN"));
        sbSql.append("      ) A, \n");

        /////////////////////////////////////////////////////////////////20151008 튜닝쿼리 추가
        sbSql.append("      (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ \n");
        sbSql.append("             ,CD_SY||CD_SM||CD_SD AS NONHOLI_DATE \n");
        sbSql.append("         FROM SCC_CALENDA_DATA \n");
        sbSql.append("        WHERE CD_SY||CD_SM||CD_SD < ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND CD_SY BETWEEN TO_NUMBER(SUBSTR( ? ,1,4))-1 AND TO_NUMBER(SUBSTR( ? ,1,4)) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        sbSql.append("          AND CD_WEEK NOT IN ('일')) KK \n");


        sbSql.append(" WHERE A.ITEM_CODE = CC.ITEM_CODE(+) \n");
        sbSql.append("   AND A.ITEM_CLASS4 = DD.ITEM_CODE(+) \n");

        /////////////////////////////////////////////////////////////////20151008 튜닝쿼리 추가
        sbSql.append("   AND A.D_DAYS = KK.SEQ(+) \n");

        if (! strIndex.equals("1")){
            sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
        }
        //추가 20130621 지난발주 복사일 경우 취소와 미승인 건은 보여주지 않는다.
        if (strIndex.equals("4")){
            sbSql.append("   AND B.LINE_STATUS NOT IN ('003','005','999') \n");
        }
        sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD \n");

        //추가---- 20081211 분류별 조회 추가. by Noh Kyu Wan
           sbSql.append("   AND A.ITEM_CLASS2 = NVL( ? ,A.ITEM_CLASS2) \n");
           bindString[iBind++] = nullToBlank(ds_cond.getString(0, "ITEM_CLASS2"));
        sbSql.append("   AND A.ITEM_CLASS3 = NVL( ? ,A.ITEM_CLASS3) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "ITEM_CLASS3"));
        sbSql.append("   AND A.ITEM_CLASS4 = NVL( ? ,A.ITEM_CLASS4) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "ITEM_CLASS4"));

        //추가---- 20081211
        sbSql.append("   AND D.OTCUSTCD = F.OTCUSTCD  \n");

        //변경---- 20121214
        sbSql.append("   AND F.UPJANG = ((SELECT Z.MAIN_UPJANG FROM FMS_UPJANG Z WHERE UPJANG = ? )) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("   AND F.USE_YN = 'Y'  \n");

        if (! strOnly.equals("TRUE"))
        {
            sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
            sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
            sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
            sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
        }

        String strType = "";
        
        
        //[PJT]주문채널통합
        if("ITEM_NAME".equals(strKeywordGbn)){
        String[] elements  = strItemName.split(":");
        if ( elements.length == 2 ) {
            if ( strItemName.indexOf("기획:") > -1 ) {
            	strType = "DUTY_YN";
            	strItemName = elements[1].toString();
            	
            }/* else if ( strItemName.toUpperCase().indexOf("PB:") > -1 ) {
            	strType = "PB_YN";
            	strItemName = elements[1].toString();
            }*/
           } else if ( elements.length == 1 ){
           	if ( strItemName.indexOf("기획:") > -1 ) {
            	strType = "DUTY_YN";
            	strItemName = "";
            	
            }/* else if ( strItemName.toUpperCase().indexOf("PB:") > -1 ) {
            	strType = "PB_YN";
            	strItemName = "";
            }*/
              }
        }
        
        if (! strItemName.equals(""))
        {
            
            //[PJT]주문채널통합
            if("88".equals(strKeywordGbn)){
                
                sbSql.append("   AND A.WIN_ITEM_CD LIKE '%'|| ? \n");
                bindString[iBind++] = strItemName;
            }else if("ITEM_CODE".equals(strKeywordGbn)){
                
                sbSql.append("   AND A.ITEM_CODE LIKE '%'||?||'%' \n");
                bindString[iBind++] = strItemName;
                
            }else if("ITEM_NAME".equals(strKeywordGbn)){
                
                sbSql.append("   AND (		\n");
//                 sbSql.append("   		A.ITEM_CODE LIKE '%'||?||'%' \n");
//                 bindString[iBind++] = strItemName;
//                sbSql.append("   	OR  A.ITEM_SIZE LIKE '%'||?||'%' \n");
                sbSql.append("   	  A.ITEM_SIZE LIKE '%'||?||'%' \n");
                bindString[iBind++] = strItemName;
                
                sbSql.append(" OR  A.ITEM_NAME LIKE '%'||?||'%' \n");	
                bindString[iBind++] = strItemName;
                
                for ( int ii=0; ii<strKeyword_ItemName.length; ii++ ) {
                    sbSql.append(" OR  A.ITEM_NAME LIKE '%'||?||'%' \n");	
                    bindString[iBind++] = strKeyword_ItemName[ii];
                }
                
                //sbSql.append("   	OR  A.ITEM_NAME LIKE '%'||?||'%' \n");
                //bindString[iBind++] = strKeyword.replace(" ","").replace(",","%' OR A.ITEM_NAME like '%");
                //bindString[iBind++] = strItemName;
                sbSql.append("   	 ) \n");
            }
            
        }
        
        //[PJT]주문채널통합
        //88코드를 ctrl+v 했을때
        if("BARCODE".equals(strKeywordGbn) && ds_Barcode != null && ds_Barcode.getRowCount() > 0){
             
            sbSql.append("   AND (A.WIN_ITEM_CD, 0) IN ( ('empty', 0) \n");
            for(int i = 0, t = ds_Barcode.getRowCount(); i < t; i++ ){
            	sbSql.append("       , (?, 0)  \n");
            	bindString[iBind++] = ds_Barcode.getString(i, "BARCODE");
            }
            sbSql.append("                             )  \n");
        }
        
        
        
        if (strOnly.equals("TRUE"))
        {

            //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음.
            //if (g_SystemId.equals("SPOON"))
            if (Holiday_YN.equals("Y"))
            {
                sbSql.append("   AND TO_NUMBER(A.D_DAYS) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE( ? ,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
            }
            else
            {
                //원인은 모르겠으나 경인은 괜찮은데 남부의 경우 함수를 썼더니 느리더라...그래서 함수내용 그대로 구현
                //sbSql.append("   AND (FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS)) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
                sbSql.append("   AND (SELECT TO_NUMBER(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')) \n");
                sbSql.append("          FROM (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ \n");
                sbSql.append("                     , CD_SY||CD_SM||CD_SD AS NONHOLI_DATE \n");
                sbSql.append("                  FROM SCC_CALENDA_DATA \n");
                sbSql.append("                 WHERE CD_SY||CD_SM||CD_SD < ? \n");
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
                sbSql.append("                   AND CD_SY BETWEEN TO_NUMBER(SUBSTR( ? ,1,4))-1 AND TO_NUMBER(SUBSTR( ? ,1,4)) \n");
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
                bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
                sbSql.append("                   AND CD_WEEK NOT IN ('일')) Z \n");
                sbSql.append("         WHERE Z.SEQ = TO_NUMBER(A.D_DAYS)) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
            }
            //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음. by 노규완 2010-12-30
            sbSql.append("   AND NOT EXISTS \n");
            sbSql.append("      (SELECT 1 FROM FMP_ORD_LIMIT Z \n");
            sbSql.append("        WHERE Z.UPJANG = A.UPJANG \n");
            sbSql.append("          AND Z.ITEM_CODE = A.ITEM_CODE \n");
            sbSql.append("          AND A.NEED_DATE BETWEEN Z.SDATE AND Z.EDATE \n");
            sbSql.append("          AND Z.USE_YN = 'Y') \n");
        }

        sbSql.append("        ) T \n");
        sbSql.append("      , (SELECT  \n");
        sbSql.append("      			/*+ INDEX(B.MR ESPSSGPITM_PK) */ \n");
        sbSql.append("      			A.ITEM_CODE \n");
        sbSql.append("                , CASE WHEN B.DUTY_YN = 'Y' THEN '기획자재' \n");
        sbSql.append("                       WHEN A.MANUF_CD IS NOT NULL THEN '전처리' \n");
        sbSql.append("                       WHEN B.PB_YN = 'Y' THEN 'PB상품' \n");
        sbSql.append("                       WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN '친환경' \n");
        sbSql.append("                       ELSE '' \n");
        sbSql.append("                   END AS FEATURE_NAME \n");
        sbSql.append("                , CASE WHEN B.DUTY_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon11.png' \n");
        sbSql.append("                       WHEN A.MANUF_CD IS NOT NULL THEN 'theme://Images/new/grd_WF_Icon10.png' \n");
        sbSql.append("                       WHEN B.PB_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon09.png' \n");
        sbSql.append("                       WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN 'theme://Images/new/grd_WF_Icon08.png' \n");
        sbSql.append("                       ELSE '' \n");
        sbSql.append("                   END AS FEATURE_ICON \n");
        sbSql.append("             FROM EPROCUSR.MV_ITEM_MST3 A, EPROCUSR.VO_CONTRACT_F2 B \n");
        sbSql.append("            WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
        sbSql.append("              AND A.USE_YN = 'Y' \n");
        sbSql.append("              AND B.UPJANG(+) = ? \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        sbSql.append("              AND ? BETWEEN B.CONTRACT_START(+) AND B.CONTRACT_END(+) \n");
        bindString[iBind++] = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        if ( !strType.equals("") ) {
        	sbSql.append("              AND B."+strType+" = 'Y' \n");
        	sbSql.append("              AND B.CONTRACT_PRICE > 0 \n");
        	sbSql.append("              AND B.CENTER_CODE = ? \n");
        	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
        	sbSql.append("              AND B.UPJANG_GRP = ( \n");
        	sbSql.append("              						SELECT Z.SHOP_GRP_CD AS UPJANG_GRP FROM EPROCUSR.ESPSSHPORG Z WHERE Z.SYS_ID = '100' AND Z.COMP_CD = 'HFC' AND Z.SHOP_CD = ?  \n");
        	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        	sbSql.append("              					) \n");
        }
        sbSql.append("        ) U \n");

        
    	// 품목검색조건 (0:전체 n:최근n개월)
        if ( !nMonth.equals("0") )
        {
        	sbSql.append("		,( SELECT ITEM_CODE,                                                                              								\n");
        	sbSql.append("		                 PR_REMARK AS PR_REMARK_RECENT                                                          					\n");
        	sbSql.append("		         FROM    ( SELECT  ITEM_CODE,                                                         								\n");
        	sbSql.append("		                          ROW_NUMBER() OVER (PARTITION BY ITEM_CODE ORDER BY CREATE_DATE DESC) R,       								\n");
        	sbSql.append("		                          PR_REMARK                                                           								\n");
        	sbSql.append("		                 FROM     SO_PR                                                               								\n");
        	sbSql.append("		                 WHERE    RC_UPJANG = ?	  								\n");
        	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        	sbSql.append("		                 AND      TO_DATE(NEED_DATE, 'YYYYMMDD') BETWEEN ADD_MONTHS(SYSDATE, -?) AND    SYSDATE 		\n");
        	bindString[iBind++] = nMonth;
        	//sbSql.append("          			 AND	  SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODET")) + "' 						\n");
        	sbSql.append("		                 )                                                                            								\n");
        	sbSql.append("		         WHERE   R = 1                                                                        								\n");
        	sbSql.append("		                                                                                              								\n");
        	sbSql.append("		         UNION ALL                                                                            								\n");
        	sbSql.append("		                                                                                              								\n");
        	sbSql.append("		         SELECT ITEM_CODE,                                                                    								\n");
        	sbSql.append("		                PR_REMARK AS PR_REMARK_RECENT                                                           					\n");
        	sbSql.append("		         FROM   ( SELECT  ITEM_CODE,                                                          								\n");
        	sbSql.append("		                         ROW_NUMBER() OVER (PARTITION BY ITEM_CODE ORDER BY CDATE DESC) R,        								\n");
        	sbSql.append("		                         REMARK AS PR_REMARK                                                  								\n");
        	sbSql.append("		                FROM     FMP_OTCUST_PR A                                                      								\n");
        	sbSql.append("		                WHERE    TO_DATE(A.NEED_DATE, 'YYYYMMDD') BETWEEN ADD_MONTHS(SYSDATE, -?) AND    SYSDATE 		\n");
        	bindString[iBind++] = nMonth;
        	sbSql.append("		                AND      A.UPJANG = ?        								\n");
        	bindString[iBind++] = nullToBlank(ds_cond.getString(0, "UPJANG"));
        	//sbSql.append("          			AND		 A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODET")) + "'						\n");
        	sbSql.append("		                )                                                                             								\n");
        	sbSql.append("		         WHERE  R = 1                                                                         								\n");
        	sbSql.append("		         )                                                                                    								\n");
        	sbSql.append("		         Y                                                                                    								\n");
        }
     
     	if ( strType.equals("") ) {
        	sbSql.append(" WHERE T.ITEM_CODE = U.ITEM_CODE(+) \n");
     	} else {
     		sbSql.append(" WHERE T.ITEM_CODE = U.ITEM_CODE \n");
     	}
     	
     	//전자구매 수발주제어 예외관리 추가 2022.05.06
        /*if (strOnly.equals("TRUE"))
        {
            sbSql.append("   AND T.PO_STATUS = 'HK' AND T.FMP_STATUS = 'N' AND T.PO_WEEK_STATUS = 'XR' \n"); // 구매_스케줄, 식재_스케줄, 구매_요일통제
            sbSql.append("   AND T.UNUSE_YN <> 'UK' \n"); // 구매 불용자재 
            sbSql.append("   AND T.VAL_STP_YN <> 'TK' \n"); // 구매 중지자재 체크
        }*/
        

        // 최근 3개월 주문 내역 자재만 조회
        //if (strThreeMonth.equals("TRUE")) : OLD 
        // 품목검색조건 (0:전체 n:최근n개월) : TOBE
        if ( !nMonth.equals("0") )
        {
            sbSql.append("   AND SCC_SOPR_AGG_FUN( ? , T.ITEM_CODE, '3') > 0 \n");
            bindString[iBind++] = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
        	sbSql.append("   AND T.ITEM_CODE = Y.ITEM_CODE \n");
        }

        sbSql.append("   ) M \n"); //
        
        
      //전자구매 수발주제어 예외관리 추가 2022.05.06
        if (strOnly.equals("TRUE"))
        {
        	sbSql.append("   WHERE 1=1 \n");
        	sbSql.append("   AND ((M.PO_STATUS = 'HK' AND M.FMP_STATUS = 'N' AND M.PO_WEEK_STATUS = 'XR' \n"); // 구매_스케줄, 식재_스케줄, 구매_요일통제
            sbSql.append("   AND M.UNUSE_YN <> 'UK' \n"); // 구매 불용자재 
            sbSql.append("   AND M.VAL_STP_YN <> 'TK') OR DECODE(M.EXC_GUBUN,'1',DECODE(M.BRAND_YN, 'Y', M.ORDER_YN, DECODE(M.MART_YN, 'Y', M.ORDER_YN, '')),'2', DECODE(M.BRAND_YN, 'Y', M.ORDER_YN, ''), '3', DECODE(M.MART_YN, 'Y', M.ORDER_YN, ''),'') = 'Y') \n"); // 구매 중지자재 체크 & 전자구매 수발주통제 예외항목 조회
            sbSql.append("   AND NVL(DECODE(M.EXC_GUBUN,'1',DECODE(M.BRAND_YN, 'Y', M.ORDER_YN, DECODE(M.MART_YN, 'Y', M.ORDER_YN, '')),'2', DECODE(M.BRAND_YN, 'Y', M.ORDER_YN, ''), '3', DECODE(M.MART_YN, 'Y', M.ORDER_YN, ''),''),'Y') != 'N'         \n");
        }
        
        if (strIndex.equals("1")){
        	//[PJT]주문채널통합
        	sbSql.append(" ORDER BY DECODE(M.FEATURE_NAME, '특가행사', '0', 'PB상품', '1', '기획자재', '2', ''), NVL(M.TOT_SO_AMT, 0) DESC, M.ITEM_CODE \n");
        } else if (strIndex.equals("2")){
        	sbSql.append(" ORDER BY M.ITEM_CODE\n");	
        } else if (strIndex.equals("4")){
        	sbSql.append(" ORDER BY M.PR_ID\n");	
        } else {
            //[PJT]주문채널통합
            sbSql.append(" ORDER BY DECODE(M.FEATURE_NAME, '특가행사', '0', 'PB상품', '1', '기획자재', '2', ''), NVL(M.TOT_SO_AMT, 0) DESC, M.ITEM_CODE \n");
            //sbSql.append(" ORDER BY T.ITEM_CODE \n");
        }

out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        
        /*바인딩 추가*/
        for(int i = 1 ; i < iBind ; i++)
        {
        	//System.out.println(i+"=="+bindString[i]);
        	pstmt.setString(i, bindString[i]);
        }
        
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_List");
        pstmt.close();
        rs.close();

        /**종료**/
        out_dl.add(ds_list);
        iBind = 1;
        this.setResultMessage(0, "OK", out_vl);
        
        long _endTime = (new Timestamp(System.currentTimeMillis())).getTime();
        
        
        sbSearchLog.append("\n:(st");
        sbSearchLog.append("\n {");
        sbSearchLog.append("\n 	\"timestamp\" : \"" + new Timestamp(System.currentTimeMillis()) + "\"" );
        sbSearchLog.append("\n 	, \"app\" : \"" + g_SystemId + "\"" );
        sbSearchLog.append("\n 	, \"ip\" : \"" + request.getRemoteAddr() + "\"" );
        sbSearchLog.append("\n 	, \"loc\" : {\"lat\" : \"{$lat}\", \"lon\" : \"{$lon}\"" );
        sbSearchLog.append("\n 	, \"upjang\" : " + nullToBlank(ds_cond.getString(0, "UPJANG")) );
        sbSearchLog.append("\n 	, \"upjangName\" : \"{$upjangName}\"" );
        sbSearchLog.append("\n 	, \"sabun\" : \"" + g_EmpNo + "\"" );
        sbSearchLog.append("\n 	, \"needDate\" : \"" +  nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "\"" );
        sbSearchLog.append("\n 	, \"keyword gbn \" : \"" + strKeywordGbn + "\"" );
        sbSearchLog.append("\n 	, \"keyword\" : \"" + strItemName + "\"" );
        sbSearchLog.append("\n 	, \"elapsed\" : " + (_endTime - _startTime) );
        sbSearchLog.append("\n 	, \"resultCount\" : " + ds_list.getRowCount()  );
        sbSearchLog.append("\n 	, \"set01\" : \"{$set01}\"" );
        sbSearchLog.append("\n 	, \"set02\" : \"{$set02}\"" );
        sbSearchLog.append("\n }");
        sbSearchLog.append("\n:)ed");
        System.out.println(sbSearchLog);
        
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
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
        if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
// [속도개선 Project 시작] 2017. 8. 28. 최범주        
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