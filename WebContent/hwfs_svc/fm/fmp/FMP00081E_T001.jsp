<%  
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00081E_T001.jsp
■ 프로그램명   : 주문상품 조회(간편발주)
■ 작성일자     : 2013.08.29
■ 작성자       : 박용대
■ 이력관리     : 
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
		sbSql.append("SELECT HOLIDAY_CHK_YN \n");
		sbSql.append("     , FMS_OPRATEINFO_FUN(" + nullToBlank(ds_cond.getString(0, "UPJANG")) + ", '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') AS OP_LEN \n");
		sbSql.append("  FROM FMS_UPJANG \n");
		sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
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
		sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE \n");
		sbSql.append("     , A.SALE_PRICE, B.DEF_QTY AS PR_QTY, ROUND(A.SALE_PRICE * B.DEF_QTY) AS SALE_AMOUNT \n");
		sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK \n");
		sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' AS SUBINV_CODE, A.NEED_DATE \n");
		sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, " + g_Upjang + " AS PR_UPJANG \n");
		sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG \n");
 		sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY \n");
		sbSql.append("     , A.OTCUSTCD \n");
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
		sbSql.append("     ,(SELECT 0 AS DEF_QTY, '' AS PR_ID FROM DUAL) B \n");
		sbSql.append("     ,(SELECT " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " AS UPJANG \n");
		sbSql.append("            , '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AS NEED_DATE \n");
		sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM \n");
		sbSql.append("            , C.TAX_CODE, A.CUSTCD, A.CENTER_FLAG \n");
		sbSql.append("            , A.CENTER_CODE, C.POINT_FLAG \n");
		sbSql.append("            , A.UNIT_PRICE AS UNIT_PRICE \n");
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
			sbSql.append("             (  SELECT     A.UPJANG, A.NEED_DATE, A.ITEM_CODE, A.CUSTCD, A.CENTER_FLAG, A.CENTER_CODE, A.UNIT_PRICE, A.SALE_PRICE, NULL AS WEEK_ITEM_CODE \n");
			sbSql.append("                FROM FMP_SPD_ORD A \n");
			sbSql.append("                 WHERE NOT EXISTS (SELECT 1 \n");
			sbSql.append("                    FROM (SELECT CENTER_CODE, CUSTCD, ITEM_CODE \n");
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
			sbSql.append("                      ) A10 \n");
			sbSql.append("                  WHERE A10.CENTER_CODE = A.CENTER_CODE \n");
			sbSql.append("                    AND A10.CUSTCD      = A.CUSTCD \n");
			sbSql.append("                    AND A10.ITEM_CODE   = A.ITEM_CODE \n");
			sbSql.append("                  ) \n");
			sbSql.append("             ) A \n");
		}
		else
		{
			sbSql.append("             (SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */ \n");
			sbSql.append("                     A.UPJANG, A.NEED_DATE, A.ITEM_CODE, A.CUSTCD, A.CENTER_FLAG, A.CENTER_CODE, A.UNIT_PRICE, A.SALE_PRICE, B.ITEM_CODE AS WEEK_ITEM_CODE \n");
			sbSql.append("                FROM FMP_SPD_ORD A \n");
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
			sbSql.append("             ) A \n");
		}
		sbSql.append("            ,(SELECT  \n");
		//sbSql.append("                     CENTER_CODE, UPJANG, ITEM_CODE, MAX(CONTRACT_START) AS CONTRACT_START \n");
		sbSql.append("                     CENTER_CODE, UPJANG, ITEM_CODE, NEED_DATE \n");
		sbSql.append("                FROM FMP_SPD_ORD A \n");
		sbSql.append("               WHERE CENTER_CODE = " + nullToBlank(ds_cond.getString(0, "CENTER_CODE")) + " \n");
		sbSql.append("                 AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + " \n");
		sbSql.append("                 AND ITEM_CODE > ' ' \n");
		sbSql.append("                 AND NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
		sbSql.append("                      ) B \n");
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
		sbSql.append("          AND A.NEED_DATE = B.NEED_DATE \n");		
		sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("          AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND UPJANG = " + nullToBlank(ds_cond.getString(0, "AP_UNITPRICE_UPJANG")) + ") \n");
		sbSql.append("          AND A.SALE_PRICE > 0 \n");
		sbSql.append("          AND C.USE_YN = 'Y' \n");
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

%>
