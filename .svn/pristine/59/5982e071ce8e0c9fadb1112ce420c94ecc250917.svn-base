<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00080E_T001.jsp
■ 프로그램명   : 주문상품 조회
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2008.01.21
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common_ssv.jsp" %>
<%
    try	{
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_cond      = in_dl.get("ds_Cond");
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
        if (rs != null) {
             rs.next();
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
		
        
     	// UI Grid 내의 expr 로직을 쿼리로 이전
        sbSql.append("	SELECT Q.* ,                                                        \n");
        sbSql.append("	       CASE                                                         \n");
        sbSql.append("	              WHEN Q.UNUSE_YN     = 'UK'                            \n");
        sbSql.append("	              OR     Q.VAL_STP_YN = 'TK'                            \n");
        sbSql.append("	              OR     Q.PO_STATUS  = 'HE'                            \n");
        sbSql.append("	              OR     DECODE(Q.DANGA_ITEM_CODE, NULL,                \n");
        sbSql.append("	                            'NN',                                   \n");
        sbSql.append("	                            'FE') = 'FE'                            \n");
        sbSql.append("	              THEN 'theme://convertImages\\img_RC.png'              \n");
        sbSql.append("	              ELSE DECODE(Q.DAY_STATUS, '0',                        \n");
        sbSql.append("	                          'theme://convertImages\\img_RC.png',      \n");
        sbSql.append("	                          '1',                                      \n");
        sbSql.append("	                          'theme://convertImages\\img_YC.png',      \n");
        sbSql.append("	                          '2',                                      \n");
        sbSql.append("	                          'theme://convertImages\\img_GC.png',      \n");
        sbSql.append("	                          '')                                       \n");
        sbSql.append("	       END AS ROW_IMG ,                                             \n");
        sbSql.append("	       CASE                                                         \n");
        sbSql.append("	              WHEN Q.UNUSE_YN     = 'UK'                            \n");
        sbSql.append("	              OR     Q.VAL_STP_YN = 'TK'                            \n");
        sbSql.append("	              OR     Q.PO_STATUS  = 'HE'                            \n");
        sbSql.append("	              OR     Q.DAY_STATUS = '0'                             \n");
        sbSql.append("	              THEN 'thistle'                                        \n");
        sbSql.append("	              ELSE 'white'                                          \n");
        sbSql.append("	       END AS ROW_BG                                                \n");
        sbSql.append("	FROM   ( 	                                                        \n");
        
        
        
        
        
        
        
        sbSql.append("SELECT /*아이템 검색-FMP00080E_T001.jsp*/ \n");
        sbSql.append("       T.* ");
        sbSql.append("     , DECODE(T.FEATURE_NAME_CHK, NULL, U.FEATURE_NAME, T.FEATURE_NAME_CHK||U.FEATURE_NAME) AS FEATURE_NAME ");
        sbSql.append("     , U.FEATURE_ICON ");
        sbSql.append("     , DECODE(T.PO_WEEK_STATUS, 'XR', '', T.ITEM_CODE) AS WEEK_ITEM_CODE ");
        sbSql.append("     , DECODE(T.DANGA_ITEM_CODE, NULL, 'NN', 'FE') AS DANGAWEEK_STATUS ");
        
     	// 품목검색조건 (0:전체 n:최근n개월)
        if ( !nMonth.equals("0") )	
        {
        	sbSql.append("     , Y.PR_REMARK_RECENT ");
        }
     	
     	
        sbSql.append("		, CASE WHEN DECODE(T.PO_WEEK_STATUS, 'XR', '', T.ITEM_CODE) IS NOT NULL THEN '0'                                                                	\n");
        sbSql.append("		                 WHEN T.D_DAYS = '0' THEN '2'                                                                                                    	\n");           
        sbSql.append("		                 WHEN TO_CHAR(SYSDATE+T.D_DAYS, 'YYYYMMDD') > '"+nullToBlank(ds_cond.getString(0, "NEED_DATE"))+"' THEN '0'                                                                	\n");                                  
        sbSql.append("		                 WHEN TO_CHAR(SYSDATE, 'YYYYMMDD') = '"+nullToBlank(ds_cond.getString(0, "NEED_DATE"))+"' AND SYSDATE > TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD')||T.D_TIMES) THEN '0'          	\n"); 
        sbSql.append("		                 WHEN TO_CHAR(SYSDATE, 'YYYYMMDD') = '"+nullToBlank(ds_cond.getString(0, "NEED_DATE"))+"' AND SYSDATE - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD')||T.D_TIMES) <= '30' THEN '1'  	\n"); 
        sbSql.append("		            		 ELSE '2'	                                                                                                                    \n");
        sbSql.append("		        END AS DAY_STATUS	                                                                                                                        \n");
        
     	
     	
        sbSql.append("  FROM ( \n");

        sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
        sbSql.append("     , A.SALE_PRICE, B.DEF_QTY AS PR_QTY, ROUND(A.SALE_PRICE * B.DEF_QTY) AS SALE_AMOUNT \n");
        //LINE_STATUS 변경으로 상태값을 '002'로 sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
        sbSql.append("     , '002' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
        sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE, B.PRE_NEED_DATE \n");
        sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
        sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
        sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
         sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
        sbSql.append("     , A.OTCUSTCD \n");
        sbSql.append("     , CASE WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL \n");
        sbSql.append("            THEN DECODE(SIGN(NVL(CC.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL), CC.OP_PRICE) \n");
        sbSql.append("            WHEN DD.OP_PRICE IS NOT NULL OR DD.OP_RATE IS NOT NULL \n");
        sbSql.append("            THEN DECODE(SIGN(NVL(DD.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(DD.OP_RATE,0) / 100),DD.CEIL_VAL), DD.OP_PRICE) \n");
        sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE \n");
        sbSql.append("     , DECODE(CC.OP_RATE, NULL, DD.OP_RATE, CC.OP_RATE) AS OP_RATE \n");
        sbSql.append("     , ROUND(CASE WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(CC.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL), CC.OP_PRICE) \n");
        sbSql.append("                  WHEN DD.OP_PRICE IS NOT NULL OR DD.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(DD.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(DD.OP_RATE,0) / 100),DD.CEIL_VAL), DD.OP_PRICE) \n");
        sbSql.append("             ELSE A.SALE_PRICE END * B.DEF_QTY) AS OP_AMOUNT \n");
        sbSql.append("     , ROUND(CASE WHEN CC.OP_PRICE IS NOT NULL OR CC.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(CC.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(CC.OP_RATE,0) / 100),CC.CEIL_VAL), CC.OP_PRICE) \n");
        sbSql.append("                  WHEN DD.OP_PRICE IS NOT NULL OR DD.OP_RATE IS NOT NULL \n");
        sbSql.append("                  THEN DECODE(SIGN(NVL(DD.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(DD.OP_RATE,0) / 100),DD.CEIL_VAL), DD.OP_PRICE) \n");
        sbSql.append("             ELSE A.SALE_PRICE END / A.KG_CONVERT_RATE / 1000,1) AS G_PRICE \n");
        sbSql.append("     , 0 AS OP_AMOUNT_OLD \n");
        
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
            sbSql.append("     , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS') AS D_DAYS \n");
            sbSql.append("     , A.D_TIMES \n");
            // 2015.07.06 김진희매니져요청사항 D-Day만 표시 sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS))||' '||TRIM(TO_CHAR(A.D_TIMES,'0000')) AS D_DAY_DISP \n");
// 			sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS)) AS D_DAY_DISP \n");
        /////////////////////////////////////////////////////////////////20151008 튜닝쿼리 추가
            //sbSql.append("     , 'D-'||TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "', 'YYYYMMDD') - TO_DATE(KK.NONHOLI_DATE, 'YYYYMMDD')) AS D_DAY_DISP \n");
            sbSql.append("     , 'D-'||FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS') AS D_DAY_DISP \n");
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
        sbSql.append("     , SCC_SOPR_AGG_FUN('" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "', A.ITEM_CODE, '1') AS MAX_SO_QTY \n");
        sbSql.append("     , SCC_SOPR_AGG_FUN('" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "', A.ITEM_CODE, '3') AS TOT_SO_AMT \n");
        sbSql.append("     , A.UPJANG_GRP \n");
        //sbSql.append("     , CASE WHEN A.PO_STATUS = 'HK' AND A.FMP_STATUS = 'N' THEN '' ELSE A.ITEM_CODE END AS WEEK_ITEM_CODE \n");
        //sbSql.append("     , A.PO_STATUS \n");
        //sbSql.append("     , A.FMP_STATUS \n");
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), '"+sPrDate+"', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'), 'HK') AS PO_STATUS \n");
        //불용자재체크
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS UNUSE_YN  \n");
        //중지자재체크
        sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS VAL_STP_YN \n");
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', FMP_ORDER_SCHL_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", A.CUSTCD, A.ITEM_CODE, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'), 'N') AS FMP_STATUS \n");
        sbSql.append("     , DECODE(A.OTCUSTCD, '0000', EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'), 'XR') AS PO_WEEK_STATUS , DANGA_ITEM_CODE \n");
        if(strIndex.equals("2")){
        	sbSql.append(" , B.CDATE \n");
        }

        //sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '02') AS ITEM_STOP \n"); // 구매불용자재체크

        sbSql.append("  FROM \n");

        sbSql.append("       ( \n");
        sbSql.append("       SELECT * \n");
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN SDATE AND EDATE \n");
        sbSql.append("          AND USE_YN = 'Y' \n");
        sbSql.append("          AND ITEM_TYPE = 'M' \n");
        sbSql.append("       ) CC \n");
        sbSql.append("      ,( \n");
        sbSql.append("       SELECT * \n");
        sbSql.append("         FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN SDATE AND EDATE \n");
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
            sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND A.FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "' \n");
            sbSql.append("          AND A.USE_YN = 'Y') B \n");
        }
        //주간발주
        else if (strIndex.equals("3"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.DEF_QTY, '' AS PR_ID, '' AS PRE_NEED_DATE \n");
            sbSql.append("         FROM FMP_WEEKLY_ITEM A \n");
            sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND NVL(DECODE(TO_CHAR(SYSDATE,'D'),1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT),'Y') = 'Y' \n");
            sbSql.append("          AND A.USE_YN = 'Y') B \n");
        }
        //지난발주
        else if (strIndex.equals("4"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM SO_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
            sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
            sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "' \n");
            sbSql.append("        UNION ALL \n");
            sbSql.append("       SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM FMP_OTCUST_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
            sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
            sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "') B \n");
        }
        //최근3개월발주
        else if (strIndex.equals("5"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM SO_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN ADD_MONTHS('" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "', -3) AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
            sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGT")) + " \n");
            sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODET")) + "' \n");
            sbSql.append("        UNION ALL \n");
            sbSql.append("       SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS, A.NEED_DATE AS PRE_NEED_DATE \n");
            sbSql.append("         FROM FMP_OTCUST_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN ADD_MONTHS('" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "', -3) AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
            sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGT")) + " \n");
            sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODET")) + "') B \n");
        }

        sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
        sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
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
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            , C.IMG_PATH AS IMAGE_PATH \n");
        sbSql.append("            , A.DANGA_ITEM_CODE, A.WEEK_ITEM_CODE, C.KEEPING_TYPE \n");
        sbSql.append("            , A.APPLY_SD, A.VD_SN \n");
        sbSql.append("            , C.ORIGIN_TYPE \n");
        sbSql.append("            , A.UPJANG_GRP \n");
        //sbSql.append("            , EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE), A.ITEM_CODE, A.VD_SN, '02', FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS'), FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), '"+sPrDate+"', '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS PO_STATUS \n");
        //sbSql.append("            , FMP_ORDER_SCHL_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", A.CUSTCD, A.ITEM_CODE, '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS FMP_STATUS \n");
        sbSql.append("         FROM \n");
         
        // 수발주 스케쥴따라(-2:전체,단가업장별) 주문가능한 상품을 나타내준다.
        if (strOnly.equals("TRUE"))
        {
        	sbSql.append("             (SELECT A.*, NULL AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE \n");
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
        }
        else
        {
        	sbSql.append("             (SELECT A.*, B.ITEM_CODE AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE \n");
            sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
            sbSql.append("                   , (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
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
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y') \n");
            sbSql.append("                     ) B \n");
            sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE(+) \n");
            sbSql.append("                 AND A.CUSTCD = B.CUSTCD(+) \n");
            sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
        }
    	sbSql.append("              	   AND A.CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
    	sbSql.append("              	   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
    	sbSql.append("                     AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
        // 2015.07.30 구매 단가 계약 테이블 조인(금지자재체크)
    	sbSql.append("                     AND EXISTS (SELECT 1 FROM HLDC_PO_CONTRACT_F WHERE CENTER_CODE = A.CENTER_CODE AND UPJANG = A.UPJANG AND ITEM_CODE = A.ITEM_CODE AND CONTRACT_PRICE > 0 AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN CONTRACT_START AND CONTRACT_END) \n");
		sbSql.append("             ) A \n");
        sbSql.append("            , HLDC_PO_ITEM_MST C \n");
        sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
        // FICS 주말 발주 제한 자재
        if (strWeekendTimeCheck.equals("Y")){
            sbSql.append("            , FMS_WEEKEND_ITEM L \n");
        }
        sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE \n");
        sbSql.append("          AND A.SALE_PRICE > 0 \n");
        sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
        sbSql.append("          AND C.ITEM_CLASS1 = 'F' \n");
        sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
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
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            , C.SIMAGE_PATH AS IMAGE_PATH \n");
        sbSql.append("            , NULL AS DANGA_ITEM_CODE, NULL AS WEEK_ITEM_CODE, C.KEEPING_TYPE \n");
        sbSql.append("            , '' AS APPLY_SD, '' AS VD_SN \n");
        sbSql.append("            , C.ORIGIN_TYPE \n");
        sbSql.append("            , '' AS UPJANG_GRP \n");
        //sbSql.append("            , 'HK' AS PO_STATUS \n");
        //sbSql.append("            , 'N' AS FMP_STATUS \n");
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
        sbSql.append("          AND C.CONSUM_YN = NVL('" + nullToBlank(ds_cond.getString(0, "CONSUM_YN")) + "',C.CONSUM_YN) \n");
        sbSql.append("      ) A, \n");

        /////////////////////////////////////////////////////////////////20151008 튜닝쿼리 추가
        sbSql.append("      (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ \n");
        sbSql.append("             ,CD_SY||CD_SM||CD_SD AS NONHOLI_DATE \n");
        sbSql.append("         FROM SCC_CALENDA_DATA \n");
        sbSql.append("        WHERE CD_SY||CD_SM||CD_SD < '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
        sbSql.append("          AND CD_SY BETWEEN TO_NUMBER(SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,4))-1 AND TO_NUMBER(SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,4)) \n");
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
           sbSql.append("   AND A.ITEM_CLASS2 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS2")) + "',A.ITEM_CLASS2) \n");
        sbSql.append("   AND A.ITEM_CLASS3 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS3")) + "',A.ITEM_CLASS3) \n");
        sbSql.append("   AND A.ITEM_CLASS4 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS4")) + "',A.ITEM_CLASS4) \n");

        //추가---- 20081211
        sbSql.append("   AND D.OTCUSTCD = F.OTCUSTCD  \n");

        //변경---- 20121214
        sbSql.append("   AND F.UPJANG = ((SELECT Z.MAIN_UPJANG FROM FMS_UPJANG Z WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) \n");
        sbSql.append("   AND F.USE_YN = 'Y'  \n");

        if (! strOnly.equals("TRUE"))
        {
            sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
            sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
            sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
            sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
        }

        if (! strItemName.equals(""))
        {
            sbSql.append("   AND (		\n");
            for(int i=0; i<strKeyword_ItemName.length; i++) {
                sbSql.append("   		A.ITEM_CODE LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
                sbSql.append("   	OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
                sbSql.append("   	OR  A.ITEM_SIZE LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");

                if(i < strKeyword_ItemName.length-1) {
                    sbSql.append("  OR \n");
                }
            }
            sbSql.append("   	 ) \n");
        }
        if (strOnly.equals("TRUE"))
        {

            //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음.
            //if (g_SystemId.equals("SPOON"))
            if (Holiday_YN.equals("Y"))
            {
                sbSql.append("   AND TO_NUMBER(A.D_DAYS) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
            }
            else
            {
                //원인은 모르겠으나 경인은 괜찮은데 남부의 경우 함수를 썼더니 느리더라...그래서 함수내용 그대로 구현
                //sbSql.append("   AND (FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS)) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
                sbSql.append("   AND (SELECT TO_NUMBER(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')) \n");
                sbSql.append("          FROM (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ \n");
                sbSql.append("                     , CD_SY||CD_SM||CD_SD AS NONHOLI_DATE \n");
                sbSql.append("                  FROM SCC_CALENDA_DATA \n");
                sbSql.append("                 WHERE CD_SY||CD_SM||CD_SD < '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
                sbSql.append("                   AND CD_SY BETWEEN TO_NUMBER(SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,4))-1 AND TO_NUMBER(SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,4)) \n");
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
        sbSql.append("      , (SELECT /*+ INDEX(B.MR ESPSSGPITM_PK) */A.ITEM_CODE \n");
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
        sbSql.append("             FROM EPROCUSR.MV_ITEM_MST3 A, EPROCUSR.VO_CONTRACT_F B \n");
        sbSql.append("            WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
        sbSql.append("              AND A.USE_YN = 'Y' \n");
        sbSql.append("              AND B.UPJANG(+) = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("              AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN B.CONTRACT_START(+) AND B.CONTRACT_END(+) \n");
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
        	sbSql.append("		                 WHERE    RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) +"	  								\n");
        	sbSql.append("		                 AND      TO_DATE(NEED_DATE, 'YYYYMMDD') BETWEEN ADD_MONTHS(SYSDATE, -" + nMonth + ") AND    SYSDATE 		\n");
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
        	sbSql.append("		                WHERE    TO_DATE(A.NEED_DATE, 'YYYYMMDD') BETWEEN ADD_MONTHS(SYSDATE, -" + nMonth + ") AND    SYSDATE 		\n");
        	sbSql.append("		                AND      A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) +"        								\n");
        	//sbSql.append("          			AND		 A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODET")) + "'						\n");
        	sbSql.append("		                )                                                                             								\n");
        	sbSql.append("		         WHERE  R = 1                                                                         								\n");
        	sbSql.append("		         )                                                                                    								\n");
        	sbSql.append("		         Y                                                                                    								\n");
        }
     
     
        sbSql.append(" WHERE T.ITEM_CODE = U.ITEM_CODE(+) \n");
        System.out.println(strOnly);
        if (strOnly.equals("TRUE"))
        {
            sbSql.append("   AND T.PO_STATUS = 'HK' AND T.FMP_STATUS = 'N' AND T.PO_WEEK_STATUS = 'XR' \n"); // 구매_스케줄, 식재_스케줄, 구매_요일통제
            sbSql.append("   AND T.UNUSE_YN <> 'UK' \n"); // 구매 불용자재 
            sbSql.append("   AND T.VAL_STP_YN <> 'TK' \n"); // 구매 중지자재 체크
        }
        

        // 최근 3개월 주문 내역 자재만 조회
        //if (strThreeMonth.equals("TRUE")) : OLD 
        // 품목검색조건 (0:전체 n:최근n개월) : TOBE
        if ( !nMonth.equals("0") )	
        {
            sbSql.append("   AND T.TOT_SO_AMT > 0 \n");
        	sbSql.append("   AND T.ITEM_CODE = Y.ITEM_CODE \n");
        }

        if (strIndex.equals("1")){
            sbSql.append(" ORDER BY DECODE(U.FEATURE_NAME, '기획자재', '1', ''), NVL(T.TOT_SO_AMT, 0) DESC, T.ITEM_CODE \n");
        } else if (strIndex.equals("2")){
        	sbSql.append(" ORDER BY T.ITEM_CODE\n");	
        } else if (strIndex.equals("4")){
        	sbSql.append(" ORDER BY T.PR_ID\n");	
        } else {
            sbSql.append(" ORDER BY DECODE(U.FEATURE_NAME, '기획자재', '1', ''), NVL(T.TOT_SO_AMT, 0) DESC, T.ITEM_CODE \n");
            //sbSql.append(" ORDER BY T.ITEM_CODE \n");
        }

        sbSql.append(") Q	\n");
        
        
		//out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        
        long start = System.currentTimeMillis(); 
        pstmt = conn.prepareStatement(sbSql.toString());
        
        // 상품조회::전체조회시
        if (strIndex.equals("1") && strItemName.equals("")) {
        	rs.setFetchSize(1000);
        } else {
        	rs.setFetchSize(30);
        }
        
        rs = pstmt.executeQuery();
        
        ds_list = this.makeDataSet(rs, "ds_List");
        long end = System.currentTimeMillis(); 
        pstmt.close();
        rs.close();

        /**종료**/
        out_dl.add(ds_list);
        this.setResultMessage(0, "OK", out_vl);
		System.out.println("$$$"+(end-start));
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
        String g_Upjang           = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo            = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_SystemId         = nullToBlank(in_vl.getString("g_SystemId"));
        //로그인한 사업장의 설정이 아닌 주문등록하는 사업장의 설정에 따름
        //String Holiday_YN   = nullToBlank(in_vl.getString("Holiday_YN"));
        String strIndex     = nullToBlank(in_vl.getString("strIndex"));
        String strOnly      = nullToBlank(in_vl.getString("strOnly"));
        String sType        = nullToBlank(in_vl.getString("sType"));
        //FileLog.println("d:\\aaa.txt", ds_cond);

        //테스트 코드
        System.out.println("**********************************************************");
        System.out.println(strIndex+"/"+strOnly+"/"+sType);
        //strIndex = 탭번호
        //strOnly = 주문가능상품만 체크 여부
        //sType = 상품명칭, 상품코드, 상품규격
        System.out.println("**********************************************************");

        //out 데이타
        DataSet ds_list;
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        String strQtyYn    = nullToBlank(ds_cond.getString(0, "QTY_CONTROL_YN"));
        String strItemCode    = nullToBlank(ds_cond.getString(0, "ITEM_CODE"));

        //운영율 설정조회
        sbSql.delete(0, sbSql.length());
        //sbSql.append("SELECT FMS_OPRATEINFO_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") AS OP_LEN FROM DUAL \n");
        //로그인한 사업장의 설정이 아닌 주문등록하는 사업장의 설정에 따름
        //sbSql.append("SELECT /*휴일체크-FMP00080E_T001.jsp*/ HOLIDAY_CHK_YN \n");
        //sbSql.append("     --, FMS_OPRATEINFO_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS OP_LEN \n");
        //sbSql.append("  FROM FMS_UPJANG \n");
        //sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");

        //튜닝쿼리
        sbSql.append("SELECT /*+ LEADING(A V1) USE_NL(V1) */                         \n");
        sbSql.append("       HOLIDAY_CHK_YN                                          \n");
        sbSql.append("      --,FMS_OPRATEINFO_FUN(140206, '20140106') AS OP_LEN      \n");
        sbSql.append("      ,NVL(V1.OP_LEN,12) OP_LEN                                \n");
        sbSql.append("  FROM FMS_UPJANG A ,                                          \n");
        sbSql.append("  (                                                            \n");
        sbSql.append("   SELECT A.UPJANG,SDATE,EDATE, MIN(LENGTH(A.ITEM_CODE)) OP_LEN \n");
        sbSql.append("     FROM FMU_OP_RATE A                                        \n");
        sbSql.append("    WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                      \n");
        sbSql.append("      group by A.UPJANG,SDATE,EDATE                            \n");
        sbSql.append("  ) V1                                                         \n");
        sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                       \n");
        sbSql.append("   AND V1.UPJANG(+) = A.UPJANG                                 \n");
        sbSql.append("   AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN V1.SDATE(+) AND V1.EDATE(+)         \n");


        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        String strOpLen = rs.getString("OP_LEN");
        String Holiday_YN = rs.getString("HOLIDAY_CHK_YN");
        rs.close();
        pstmt.close();


//System.out.println("AAAAAAAAAAAAAAAAA=" + in_vl.getString("AAA"));
//System.out.println("BBBBBBBBBBBBBBBBB=" + Holiday_YN);

        //내역조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT /*아이템 검색-FMP00080E_T001.jsp*/ A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
        sbSql.append("     , A.SALE_PRICE, B.DEF_QTY AS PR_QTY, ROUND(A.SALE_PRICE * B.DEF_QTY) AS SALE_AMOUNT \n");
        sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
        sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
        sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
        sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
        sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
         sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
        sbSql.append("     , A.OTCUSTCD \n");
        //건든고...
        //sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE \n");
        //sbSql.append("     , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) * B.DEF_QTY) AS OP_AMOUNT \n");
        //sbSql.append("     , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE)/A.KG_CONVERT_RATE/1000,1) AS G_PRICE \n");
        sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) AS OP_PRICE \n");
        sbSql.append("     , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) * B.DEF_QTY) AS OP_AMOUNT \n");
        sbSql.append("     , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE)/A.KG_CONVERT_RATE/1000,1) AS G_PRICE \n");

        //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음.
        //if (g_SystemId.equals("SPOON"))
        if (Holiday_YN.equals("Y"))
        {
            sbSql.append("     , A.D_DAYS, A.D_TIMES \n");
            sbSql.append("     , 'D-'||TO_CHAR(A.D_DAYS) AS D_DAY_DISP \n");
        }
        else
        {
            sbSql.append("     , FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS) AS D_DAYS \n");
            sbSql.append("     , A.D_TIMES \n");
            sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS))||' '||TRIM(TO_CHAR(A.D_TIMES,'0000')) AS D_DAY_DISP \n");
        }
        //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음.  //2010-12-30 로직 추가 BY 노규완

        sbSql.append("     , D.OTCUSTNM, A.KG_CONVERT_RATE \n");

        if (strOnly.equals("TRUE"))
            sbSql.append("     , A.FEATURE_NAME \n");
        else
            sbSql.append("     , A.FEATURE_NAME||DECODE(A.WEEK_ITEM_CODE,NULL,NULL,'(요일통제)')||DECODE(E.ITEM_CODE,NULL,NULL,'(주문통제)') AS FEATURE_NAME \n");
        sbSql.append("     , A.IMAGE_PATH, DECODE(A.IMAGE_PATH,NULL,'N','Y') AS IMAGE_YN \n");
        if (! strOnly.equals("TRUE"))
            sbSql.append("     , E.ITEM_CODE AS LIMIT_ITEM, E.LIMIT_REASON \n");
        sbSql.append("     , A.WEEK_ITEM_CODE \n");
        sbSql.append("     , A.CONSUM_YN, B.PR_ID \n");
//		sbSql.append("  FROM FMU_OP_RATE C, FMP_OTHER_CUST D \n");
        sbSql.append("  FROM \n");
        sbSql.append("      (SELECT * FROM FMU_OP_RATE \n");
        sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN SDATE AND EDATE \n");
        sbSql.append("          AND ITEM_CODE > ' ' \n");
        sbSql.append("          AND USE_YN = 'Y') C \n");
        sbSql.append("     , FMP_OTHER_CUST D , FMP_OTCUST_LINK F \n");
        if (! strOnly.equals("TRUE"))
            sbSql.append("     , FMP_ORD_LIMIT E \n");
        //상품조회
        if (strIndex.equals("1"))
            sbSql.append("     ,(SELECT 0 AS DEF_QTY, '' AS PR_ID FROM DUAL) B \n");
        //즐겨찾기
        else if (strIndex.equals("2"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.DEF_QTY , '' AS PR_ID \n");
            sbSql.append("         FROM FMP_FAVORITE A \n");
            sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND A.FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "' \n");
            sbSql.append("          AND A.USE_YN = 'Y') B \n");
        }
        //주간발주
        else if (strIndex.equals("3"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.DEF_QTY, '' AS PR_ID \n");
            sbSql.append("         FROM FMP_WEEKLY_ITEM A \n");
            sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND NVL(DECODE(TO_CHAR(SYSDATE,'D'),1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT),'Y') = 'Y' \n");
            sbSql.append("          AND A.USE_YN = 'Y') B \n");
        }
        //지난발주
        else if (strIndex.equals("4"))
        {
            sbSql.append("     ,(SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS \n");
            sbSql.append("         FROM HLDC_PO_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
            sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
            sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "' \n");
            sbSql.append("        UNION ALL \n");
            sbSql.append("       SELECT A.ITEM_CODE, A.PR_ID, A.PR_QTY AS DEF_QTY, A.LINE_STATUS \n");
            sbSql.append("         FROM FMP_OTCUST_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATEP")) + "' \n");
            sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANGP")) + " \n");
            sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODEP")) + "') B \n");
        }
        sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
        sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
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
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            ,(SELECT A.CODE_NAME FROM SCC_COMMON_CODE A WHERE A.GROUP_CODE = 'FS0033' AND A.CODE = O.ITEM_FEATURE) AS FEATURE_NAME \n");
        sbSql.append("            , C.IMG_PATH AS IMAGE_PATH \n");
        sbSql.append("            , A.WEEK_ITEM_CODE \n");
        sbSql.append("         FROM \n");
        if (strOnly.equals("TRUE"))
        {
            sbSql.append("             (  SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */  A.*, NULL AS WEEK_ITEM_CODE \n");
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
        }
        else
        {
            sbSql.append("             (SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */ \n");
            sbSql.append("                     A.*, B.ITEM_CODE AS WEEK_ITEM_CODE \n");
            sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
            sbSql.append("                   , (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
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
            sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y') \n");
            sbSql.append("                     ) B \n");
            sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE(+) \n");
            sbSql.append("                 AND A.CUSTCD = B.CUSTCD(+) \n");
            sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
              sbSql.append("                 AND A.CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
              sbSql.append("                 AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
            sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
              sbSql.append("                 AND A.CONTRACT_START <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
            sbSql.append("             ) A \n");
        }
        sbSql.append("            ,(SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */ \n");
        sbSql.append("                     CENTER_CODE, UPJANG, ITEM_CODE, MAX(CONTRACT_START) AS CONTRACT_START \n");
        sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
        sbSql.append("               WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
        sbSql.append("                 AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
        sbSql.append("                 AND ITEM_CODE > ' ' \n");
        sbSql.append("                 AND CONTRACT_START <= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
        sbSql.append("               GROUP BY CENTER_CODE, UPJANG, ITEM_CODE) B \n");
        sbSql.append("            ,(SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.ITEM_FEATURE \n");
        sbSql.append("                FROM FSI_ITEM_FEATURE A \n");
        sbSql.append("                   ,(SELECT CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
        sbSql.append("                       FROM FSI_ITEM_FEATURE \n");
        sbSql.append("                      WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
        sbSql.append("                        AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
        sbSql.append("                      GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE) B \n");
        sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE \n");
        sbSql.append("                 AND A.CUSTCD = B.CUSTCD \n");
        sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE \n");
        sbSql.append("                 AND A.APPLY_DATE= B.APPLY_DATE) O \n");
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
        sbSql.append("          AND A.CENTER_CODE = O.CENTER_CODE(+) \n");
        sbSql.append("          AND A.CUSTCD = O.CUSTCD(+) \n");
        sbSql.append("          AND A.ITEM_CODE = O.ITEM_CODE(+) \n");
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
        sbSql.append("            , C.KG_CONVERT_RATE \n");
        sbSql.append("            , NULL AS FEATURE_NAME \n");
        sbSql.append("            , C.SIMAGE_PATH AS IMAGE_PATH \n");
        sbSql.append("            , NULL AS WEEK_ITEM_CODE \n");
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
/*
        sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
        sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
        sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
        sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
*/
        //sbSql.append(" WHERE A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
        sbSql.append(" WHERE SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+) \n");

        if (! strIndex.equals("1")){
            sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
        }
        //추가 20130621 지난발주 복사일 경우 취소와 미승인 건은 보여주지 않는다.
        if (strIndex.equals("4")){
            sbSql.append("   AND B.LINE_STATUS NOT IN ('003','005') \n");
        }
        sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD \n");
        //추가---- 20081211 분류별 조회 추가. by Noh Kyu Wan
           sbSql.append("   AND A.ITEM_CLASS2 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS2")) + "',A.ITEM_CLASS2) \n");
        sbSql.append("   AND A.ITEM_CLASS3 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS3")) + "',A.ITEM_CLASS3) \n");
        sbSql.append("   AND A.ITEM_CLASS4 = NVL('" + nullToBlank(ds_cond.getString(0, "ITEM_CLASS4")) + "',A.ITEM_CLASS4) \n");
        //추가---- 20081211
        sbSql.append("   AND D.OTCUSTCD = F.OTCUSTCD  \n");
        //변경---- 20121214
        //sbSql.append("   AND F.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("   AND F.UPJANG = ((SELECT Z.MAIN_UPJANG FROM FMS_UPJANG Z WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ")) \n");
        sbSql.append("   AND F.USE_YN = 'Y'  \n");
        if (! strOnly.equals("TRUE"))
        {
            sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
            sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
            sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
            sbSql.append("   AND E.USE_YN(+) = 'Y' \n");
        }
        if (! strItemCode.equals(""))
        {
            sbSql.append("   AND A.ITEM_CODE = '" + strItemCode + "' \n");
        }
        sbSql.append("   AND " + sType + " LIKE '%'||'" + nullToBlank(ds_cond.getString(0, "ITEM_NAME")) + "'||'%' \n");
        if (strOnly.equals("TRUE"))
        {

            //외식 SPOON 시스템 사용 하는 곳만 주말 발주 D-DAY 체크 하지 않음.
            //if (g_SystemId.equals("SPOON"))
            if (Holiday_YN.equals("Y"))
            {
                sbSql.append("   AND TO_NUMBER(A.D_DAYS) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
            }
            else
            {
                //원인은 모르겠으나 경인은 괜찮은데 남부의 경우 함수를 썼더니 느리더라...그래서 함수내용 그대로 구현
                //sbSql.append("   AND (FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS)) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000'))) \n");
                sbSql.append("   AND (SELECT TO_NUMBER(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')) \n");
                sbSql.append("          FROM (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ \n");
                sbSql.append("                     , CD_SY||CD_SM||CD_SD AS NONHOLI_DATE \n");
                sbSql.append("                  FROM SCC_CALENDA_DATA \n");
                sbSql.append("                 WHERE CD_SY||CD_SM||CD_SD < '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
                sbSql.append("                   AND CD_SY BETWEEN TO_NUMBER(SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,4))-1 AND TO_NUMBER(SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,4)) \n");
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
//		if (strIndex.equals("4"))
//			sbSql.append(" ORDER BY B.PR_ID \n");
//		else
//			sbSql.append(" ORDER BY A.ITEM_CODE \n");


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
