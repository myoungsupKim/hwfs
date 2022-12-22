<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//String  MENU_DATE			= in_vl.getString("MENU_DATE");		
		String  UPJANG				= in_vl.getString("UPJANG");			
		String  ITEM_NAME			= in_vl.getString("ITEM_NAME");		
		String  BIG_CODE			= in_vl.getString("BIG_CODE");	
		String  MID_CODE			= in_vl.getString("MID_CODE");	
		String  SMALL_CODE			= in_vl.getString("SMALL_CODE");	
		//
		String  SUBINV_CODE			= in_vl.getString("SUBINV_CODE");	
		String  MEAL				= in_vl.getString("MEAL");	
		String  CORNER				= in_vl.getString("CORNER");	
		String  GUBUN				= in_vl.getString("GUBUN");	
		String  JDATE				= in_vl.getString("JDATE");	
		String  ITEM_CLASS4			= in_vl.getString("ITEM_CLASS4");
		String  CENTER_CODE			= in_vl.getString("CENTER_CODE");
		
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		//추가인 경우는 메뉴제공일-D_day로 입고예정일을 산정한다.
		if (GUBUN.equals("ADD"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT TO_CHAR(TO_DATE('" + JDATE + "','YYYYMMDD') - NVL(D_DAYS,0), 'YYYYMMDD') AS NEED_DATE \n");
			sbSql.append("  FROM FMS_MEAL_CORNER \n");
			sbSql.append(" WHERE SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			sbSql.append("   AND MEAL = '" + MEAL + "' \n");
			sbSql.append("   AND CORNER = '" + CORNER + "' \n");
			pstmt = conn.prepareStatement(sbSql.toString());		
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				JDATE = rs.getString("NEED_DATE");
			}
			rs.close();
			pstmt.close();
		}
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.ITEM_CODE \n");
		sbSql.append("      ,A.ITEM_NAME \n");
		sbSql.append("      ,A.OTCUSTCD \n");
		sbSql.append("      ,A.UPJANG \n");
		sbSql.append("      ,A.CENTER_CODE \n");
		sbSql.append("      ,A.CUSTCD \n");
		sbSql.append("      ,'' AS IMAGE_PATH \n");
// 		sbSql.append("      ,A.IMG_PATH AS IMAGE_PATH \n");
 		sbSql.append("      ,D.FEATURE_NAME \n");
 		sbSql.append("      ,D.FEATURE_ICON \n");
		//sbSql.append("	    ,FMS_ITEM_FEATURE_FUN("+UPJANG+", NVL('"+ JDATE +"',TO_CHAR(SYSDATE,'YYYYMMDD')), A.ITEM_CODE, 'N') AS FEATURE_NAME --자재특성 \n");
		sbSql.append("      ,A.ITEM_SIZE \n");
		sbSql.append("      ,A.PO_UOM \n");
		sbSql.append("      ,NVL(B.OP_PRICE,0) AS ITEM_PRICE \n");
		sbSql.append("      ,A.KG_CONVERT_RATE \n");
		sbSql.append("      ,NVL(B.G_ITEM_PRICE,0) AS G_ITEM_PRICE \n");
		sbSql.append("      ,B.SALE_PRICE \n");
		sbSql.append("      ,B.OP_RATE \n");
		sbSql.append(" 	     /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append("      ,DECODE(A.OTCUSTCD,'0000','D-'||DECODE(A.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(A.D_TIMES,'',24,0,24,A.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + A.D_DAYS ) \n"); 
		sbSql.append("            ,(SELECT 'D-'||DECODE(X.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(X.D_TIMES,'',24,0,24,X.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + X.D_DAYS + 1) FROM FMP_OTCUST_ITEM X WHERE X.ITEM_CODE = A.ITEM_CODE)) D_DAYS  \n");
		sbSql.append(" 	    ,NVL(LENGTH(DECODE(E.MON,'Y','Y','') || DECODE(E.TUE,'Y','Y','') || DECODE(E.WED,'Y','Y','') || DECODE(E.THU,'Y','Y','') || DECODE(E.FRI,'Y','Y','') || DECODE(E.SAT,'Y','Y','') || DECODE(E.SUN,'Y','Y','')),0) WEEK_CHK \n");
		sbSql.append(" 	    ,TRIM(DECODE(E.MON,'Y','월 ')||DECODE(E.TUE,'Y','화 ')||DECODE(E.WED,'Y','수 ')||DECODE(E.THU,'Y','목 ')||DECODE(E.FRI,'Y','금 ')||DECODE(E.SAT,'Y','토 ')||DECODE(E.SUN,'Y','일')) AS WEEK_DISP \n");     //--CSR NUM : 25577		        
		sbSql.append(" 		,E.MON \n");
		sbSql.append(" 		,E.TUE \n");
		sbSql.append(" 		,E.WED \n");
		sbSql.append(" 		,E.THU \n");
		sbSql.append(" 		,E.FRI \n");
		sbSql.append(" 		,E.SAT \n");
		sbSql.append(" 		,E.SUN \n");
		sbSql.append(" 		,A.ORIGIN_TYPE \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("	     SELECT	A.UPJANG, A.ITEM_CODE, A.ITEM_NAME,	A.ITEM_SIZE, A.PO_UOM, A.KG_CONVERT_RATE \n");
		sbSql.append("			   ,A.OTCUSTCD,A.CENTER_CODE, A.CUSTCD \n");
// 		sbSql.append("			   ,A.IMG_PATH \n");
		sbSql.append("		       ,B.CAL, B.WATER,	B.PROT, B.FAT, B.CARBO \n");
		sbSql.append("		       ,B.FIBER, B.ASH,	B.CA, B.P, B.FE \n");
		sbSql.append("		       ,B.NA, B.K, B.VITA_A, B.RETIN, B.B_CAROT \n");
		sbSql.append("		       ,B.THIA,	B.RIBO,	B.NIACIN, B.VITA_C,	B.CHOLE, B.DISUSE_RATE \n");
		sbSql.append("		       ,A.ITEM_CLASS1, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4, A.ORIGIN_TYPE \n");
		sbSql.append("		       ,A.D_DAYS, A.D_TIMES\n");
		sbSql.append("	       FROM (SELECT	A.UPJANG, B.ITEM_CODE, B.ITEM_NAME,	B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE, B.KG_CONVERT_RATE \n");
		sbSql.append("				       ,B.ITEM_CLASS1, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4, B.ORIGIN_TYPE \n");
		sbSql.append("				       ,'0000' AS OTCUSTCD, A.CENTER_CODE, A.CUSTCD \n");
		sbSql.append("				       ,C.D_DAYS, TO_CHAR(C.D_TIMES)||'00' AS D_TIMES \n");
// 		sbSql.append("				       ,B.IMG_PATH \n");
		sbSql.append("			       FROM HLDC_PO_ITEM_MST B \n");
		sbSql.append("				       ,HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("				       ,HLDC_PO_PREORDER_LIST C \n");
		sbSql.append("				       ,HLDC_ST_UPJANG D \n");
		sbSql.append("			      WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("			        AND B.ITEM_CLASS1 = 'F' \n");
		sbSql.append("			        AND A.UPJANG = D.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                  AND NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD' )) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("			        AND D.UPJANG = "+UPJANG+" \n");
		sbSql.append("			        AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
		sbSql.append("			        AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("			        AND A.CENTER_CODE = C.CENTER_CODE(+) \n");
		sbSql.append("			        AND A.SALE_PRICE > 0 \n");
		if( !CENTER_CODE.equals(""))
		{
			sbSql.append("   				AND A.CENTER_CODE = '" + CENTER_CODE +"'  \n");
		}
		sbSql.append("			      UNION ALL \n");
		sbSql.append("			      SELECT B.UPJANG, A.ITEM_CODE,	A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM,	A.TAX_CODE,	A.KG_CONVERT_RATE \n");
		sbSql.append("			      	    ,A.ITEM_CLASS1, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4, A.ORIGIN_TYPE \n");
		sbSql.append("			      	    ,A.OTCUSTCD, NULL AS CENTER_CODE, NULL AS CUSTCD, A.D_DAYS, A.D_TIMES \n");
// 		sbSql.append("			      	    ,A.SIMAGE_PATH AS IMG_PATH \n");
		sbSql.append("			       FROM FMP_OTCUST_ITEM A, \n");
		sbSql.append("			      	    FMP_OTCUST_PRICE_AVA_V B, \n");
		sbSql.append("			      	    ( \n");
		sbSql.append("			      	    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("			      	      FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("			      	     WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = "+UPJANG+") \n");
		sbSql.append("			      	       AND SDATE <= NVL('"+ JDATE +"',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("			      	    GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("			      	    ) C \n");
		sbSql.append("			      WHERE	A.ITEM_CODE	= B.ITEM_CODE \n");
		sbSql.append("			        AND	B.UPJANG	= C.UPJANG \n");
		sbSql.append("			        AND	B.SDATE		= C.SDATE \n");
		sbSql.append("			        AND	B.ITEM_CODE	= C.ITEM_CODE \n");
		sbSql.append("			        AND	A.USE_YN	= 'Y' \n");
		sbSql.append("			        AND	B.USE_YN	= 'Y' \n");
		sbSql.append("			   ) A, \n");
		sbSql.append("			  (SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("			     FROM FMP_ITEM_NUT \n");
		sbSql.append("			    WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("			    UNION ALL \n");
		sbSql.append("			   SELECT X.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("               FROM FSI_ITEM_NUT X, \n");
		sbSql.append("			         ( \n");
		sbSql.append("			          SELECT ITEM_CODE \n");
		sbSql.append("			         	FROM FSI_ITEM_NUT \n");
		sbSql.append("			           MINUS \n");
		sbSql.append("			          SELECT ITEM_CODE \n");
		sbSql.append("			         	FROM FMP_ITEM_NUT \n");
		sbSql.append("			           WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("			         ) Y \n");
		sbSql.append("			  WHERE X.ITEM_CODE = Y.ITEM_CODE \n");
		sbSql.append("		     ) B \n");
		sbSql.append("	    WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("     )A \n");
		sbSql.append("    ,( \n");
		sbSql.append("      SELECT A.UPJANG, A.ITEM_CODE, A.SALE_PRICE \n");
		sbSql.append("           , NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE --운영율 \n");
		sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("             ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) \n");
		sbSql.append("           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / A.KG_CONVERT_RATE / 1000, 2) \n");
		sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                  THEN ROUND(DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) / A.KG_CONVERT_RATE / 1000, 2) \n");
		sbSql.append("             ELSE ROUND(A.SALE_PRICE / A.KG_CONVERT_RATE / 1000, 2) END AS G_ITEM_PRICE \n");
		sbSql.append("        FROM ( \n");
		sbSql.append("              SELECT \n");
		sbSql.append("                     "+UPJANG+" AS UPJANG , \n");
		sbSql.append("                     NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE, \n");
		sbSql.append("                     A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4, C.KG_CONVERT_RATE \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C \n");
		sbSql.append("               WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                 AND B.UPJANG = "+UPJANG+" \n");
		sbSql.append("                 AND NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD' )) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("			       AND A.SALE_PRICE > 0 \n");
		sbSql.append("                 AND A.USE_YN = 'Y' \n");
		sbSql.append("                 AND A.ITEM_CODE = C.ITEM_CODE \n");
		if( !CENTER_CODE.equals(""))
		{
			sbSql.append("   				AND A.CENTER_CODE = '" + CENTER_CODE +"'  \n");
		}
		sbSql.append("             ----------- \n");
		sbSql.append("              UNION ALL \n");
		sbSql.append("             ----------- \n");
		sbSql.append("             SELECT "+UPJANG+" AS UPJANG, NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, \n");
		sbSql.append("                    C.ITEM_CLASS4, C.KG_CONVERT_RATE \n");
		sbSql.append("               FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C, \n");
		sbSql.append("                    ( \n");
		sbSql.append("                    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                      FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                     WHERE UPJANG = \n");
		sbSql.append("                           ( \n");
		sbSql.append("                           SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                             FROM FMS_UPJANG \n");
		sbSql.append("                            WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                           ) \n");
		sbSql.append("                       AND SDATE <= NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                     GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("                    ) B \n");
		sbSql.append("              WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                AND A.SDATE = B.SDATE \n");
		sbSql.append("                AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                AND A.SALE_PRICE > 0 \n");
		sbSql.append("                AND A.USE_YN = 'Y' \n");
		sbSql.append("                AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("             ) A, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'M' \n");
		sbSql.append("             ) C, \n");
		sbSql.append("             ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'C' \n");
		sbSql.append("             ) D \n");
		sbSql.append("        WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("      ) B, -- 단가, g당 단가 \n");
// 		sbSql.append("     ,( \n");
// 		sbSql.append("	     SELECT ITEM_CODE, \n");
// 		sbSql.append("		        (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = ITEM_FEATURE) AS FEATURE_NAME \n");
// 		sbSql.append("	       FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("	      WHERE (ITEM_CODE, CDATE) IN ( \n");
// 		sbSql.append("				                       SELECT ITEM_CODE, MAX(CDATE) AS CDATE \n");
// 		sbSql.append("				                         FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("				                        WHERE (1=1) \n");
// 		sbSql.append("				                          AND (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
// 		sbSql.append("											   SELECT CENTER_CODE, \n");
// 		sbSql.append("												      CUSTCD, \n");
// 		sbSql.append("												      ITEM_CODE, \n");
// 		sbSql.append("												      MAX(APPLY_DATE) AS APPLY_DATE \n");
// 		sbSql.append("											     FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("											    WHERE CENTER_CODE  = '300001' \n");
// 		sbSql.append("											      AND APPLY_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
// 		sbSql.append("											    GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 		sbSql.append("					                           ) \n");
// 		sbSql.append("					                    GROUP BY ITEM_CODE \n");
// 		sbSql.append("					                   ) \n");
// 		sbSql.append("      ) D, --자재특성 \n");
		
		sbSql.append("      (SELECT A.ITEM_CODE \n");
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
		sbSql.append("            AND B.UPJANG(+) = "+UPJANG+" \n");
		sbSql.append("            AND NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD' )) BETWEEN B.CONTRACT_START(+) AND B.CONTRACT_END(+) \n");
		sbSql.append("            AND UPJANG_GRP = (SELECT Z.SHOP_GRP_CD AS UPJANG_GRP FROM EPROCUSR.ESPSSHPORG Z WHERE Z.SYS_ID = '100' AND Z.COMP_CD = 'HFC' AND Z.SHOP_CD = '" + UPJANG +"') \n");
		sbSql.append("      ) D, \n"); 
		
		sbSql.append("      ( \n");
		sbSql.append("       SELECT A.CENTER_CODE, A.CUSTCD, "+UPJANG+" AS UPJANG, A.ITEM_CODE \n"); 
	    sbSql.append("            , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n"); 
	    //sbSql.append("         FROM HLDC_PO_ORDER_SCHEDULE A, HLDC_PO_UPJANG_CENTER B, HLDC_ST_UPJANG C \n");
	    sbSql.append("         FROM HLDC_PO_ORDER_SCHEDULE A \n");
	    sbSql.append("        WHERE A.UPJANG = "+UPJANG+" \n");
	    sbSql.append("          AND A.UPJANG_TYPE = '02' \n");
		sbSql.append("       ) E --발주제한 목록  \n");		
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
 		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CENTER_CODE = E.CENTER_CODE(+) \n");
		/*
		if( !CENTER_CODE.equals(""))
		{
		sbSql.append("   				AND A.CENTER_CODE = '" + CENTER_CODE +"'  \n");
		}
		*/
		sbSql.append("   AND A.CUSTCD = E.CUSTCD(+) \n");
		sbSql.append("   AND (A.ITEM_CODE = '010708010198' OR NVL(B.OP_PRICE,0)>0  ) \n");
		if( !BIG_CODE.equals(""))
		{
		sbSql.append("   AND A.ITEM_CLASS2 ='"+BIG_CODE+"' \n");
		}
		if( !MID_CODE.equals(""))
		{
		sbSql.append("   AND A.ITEM_CLASS3 ='"+MID_CODE+"' \n");
		}
		if( !SMALL_CODE.equals(""))
		{
		sbSql.append("   AND A.ITEM_CLASS4 ='"+SMALL_CODE+"' \n");
		}
		if( !ITEM_NAME.equals(""))
		{
		sbSql.append("   AND A.ITEM_NAME LIKE '%'|| '"+ITEM_NAME+"' ||'%' \n");
		}	
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet FMM00213P_S001 = this.makeDataSet(rs,"FMM00213P_S001");
		out_dl.add(FMM00213P_S001);

		rs.close();
		pstmt.close();
		
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
		
		//String  MENU_DATE			= in_vl.getString("MENU_DATE");		
		String  UPJANG				= in_vl.getString("UPJANG");			
		String  ITEM_NAME			= in_vl.getString("ITEM_NAME");		
		String  BIG_CODE			= in_vl.getString("BIG_CODE");	
		String  MID_CODE			= in_vl.getString("MID_CODE");	
		String  SMALL_CODE			= in_vl.getString("SMALL_CODE");	
		//
		String  SUBINV_CODE			= in_vl.getString("SUBINV_CODE");	
		String  MEAL				= in_vl.getString("MEAL");	
		String  CORNER				= in_vl.getString("CORNER");	
		String  GUBUN				= in_vl.getString("GUBUN");	
		String  JDATE				= in_vl.getString("JDATE");		
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		//추가인 경우는 메뉴제공일-D_day로 입고예정일을 산정한다.
		if (GUBUN.equals("ADD"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT TO_CHAR(TO_DATE('" + JDATE + "','YYYYMMDD') - NVL(D_DAYS,0), 'YYYYMMDD') AS NEED_DATE \n");
			sbSql.append("  FROM FMS_MEAL_CORNER \n");
			sbSql.append(" WHERE SUBINV_CODE = '" + SUBINV_CODE + "' \n");
			sbSql.append("   AND MEAL = '" + MEAL + "' \n");
			sbSql.append("   AND CORNER = '" + CORNER + "' \n");
			pstmt = conn.prepareStatement(sbSql.toString());		
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				JDATE = rs.getString("NEED_DATE");
			}
			rs.close();
			pstmt.close();
		}
		
		//운영율 설정조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT FMS_OPRATEINFO_FUN(" + UPJANG + ", NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD'))) AS OP_LEN FROM DUAL \n");
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();
		rs.next();
		String strOpLen = rs.getString("OP_LEN");
		rs.close();
		pstmt.close();

		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.ITEM_CODE \n");
		sbSql.append("      ,A.ITEM_NAME \n");
		sbSql.append("      ,A.OTCUSTCD \n");
		sbSql.append("      ,A.UPJANG \n");
		sbSql.append("      ,A.CENTER_CODE \n");
		sbSql.append("      ,A.CUSTCD \n");
		sbSql.append("      ,A.IMG_PATH AS IMAGE_PATH \n");
		sbSql.append("      ,D.FEATURE_NAME \n");
		sbSql.append("      ,A.ITEM_SIZE \n");
		sbSql.append("      ,A.PO_UOM \n");
		sbSql.append("      ,NVL(B.OP_PRICE,0) AS ITEM_PRICE \n");
		sbSql.append("      ,A.KG_CONVERT_RATE \n");
		sbSql.append("      ,NVL(B.G_ITEM_PRICE,0) AS G_ITEM_PRICE \n");
		sbSql.append("     /* ,C.RESTRICT_START \n");
		sbSql.append("      ,C.RESTRICT_END \n");
		sbSql.append("      ,C.RESTRICT_REASON \n");
		sbSql.append("      ,C.RESTRICT_PERIOD \n");
		sbSql.append("      ,C.CNL_START \n");
		sbSql.append("      ,C.CNL_END \n");
		sbSql.append("      ,C.CNL_REASON \n");
		sbSql.append("      ,C.CNL_PERIOD*/ \n");
		sbSql.append("      ,B.SALE_PRICE \n");
		sbSql.append("      ,B.OP_RATE \n");
		sbSql.append("      ,DECODE(A.OTCUSTCD,'0000','D-'||DECODE(A.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(A.D_TIMES,'',24,0,24,A.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + A.D_DAYS + 1) \n"); 
		sbSql.append("         ,(SELECT 'D-'||DECODE(X.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(X.D_TIMES,'',24,0,24,X.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + X.D_DAYS + 1) FROM FMP_OTCUST_ITEM X WHERE X.ITEM_CODE = A.ITEM_CODE)) D_DAYS  \n");
		sbSql.append(" 	    ,NVL(LENGTH(DECODE(E.MON,'Y','Y','') || DECODE(E.TUE,'Y','Y','') || DECODE(E.WED,'Y','Y','') || DECODE(E.THU,'Y','Y','') || DECODE(E.FRI,'Y','Y','') || DECODE(E.SAT,'Y','Y','') || DECODE(E.SUN,'Y','Y','')),0) WEEK_CHK \n");
		sbSql.append(" 	    ,TRIM(DECODE(E.MON,'Y','월 ')||DECODE(E.TUE,'Y','화 ')||DECODE(E.WED,'Y','수 ')||DECODE(E.THU,'Y','목 ')||DECODE(E.FRI,'Y','금 ')||DECODE(E.SAT,'Y','토 ')||DECODE(E.SUN,'Y','일')) AS WEEK_DISP \n");     //--CSR NUM : 25577		        
		sbSql.append(" 		,E.MON \n");
		sbSql.append(" 		,E.TUE \n");
		sbSql.append(" 		,E.WED \n");
		sbSql.append(" 		,E.THU \n");
		sbSql.append(" 		,E.FRI \n");
		sbSql.append(" 		,E.SAT \n");
		sbSql.append(" 		,E.SUN \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("	SELECT	A.UPJANG, A.ITEM_CODE,	A.ITEM_NAME,	A.ITEM_SIZE,	A.PO_UOM,	A.KG_CONVERT_RATE \n");
		sbSql.append("		,A.OTCUSTCD,A.CENTER_CODE, A.CUSTCD, A.IMG_PATH \n");
		sbSql.append("		,B.CAL,		B.WATER,	B.PROT,		B.FAT,		B.CARBO \n");
		sbSql.append("		,B.FIBER,	B.ASH,		B.CA,		B.P,		B.FE \n");
		sbSql.append("		,B.NA,		B.K,		B.VITA_A,	B.RETIN,	B.B_CAROT \n");
		sbSql.append("		,B.THIA,	B.RIBO,		B.NIACIN,	B.VITA_C,	B.CHOLE, B.DISUSE_RATE \n");
		sbSql.append("		,A.ITEM_CLASS1,A.ITEM_CLASS2,A.ITEM_CLASS3,A.ITEM_CLASS4 \n");
		sbSql.append("		,A.D_DAYS, A.D_TIMES\n");
		sbSql.append("	FROM (		SELECT	/*+ USE_NL(B) USE_NL(C) INDEX(B PO_ITEM_MST_PK) */ A.UPJANG, B.ITEM_CODE,	B.ITEM_NAME,	B.ITEM_SIZE,	B.PO_UOM,	B.TAX_CODE,	B.KG_CONVERT_RATE \n");
		sbSql.append("				,B.ITEM_CLASS1,B.ITEM_CLASS2,B.ITEM_CLASS3,B.ITEM_CLASS4 \n");
		sbSql.append("				,'0000' AS OTCUSTCD, A.CENTER_CODE, A.CUSTCD, B.IMG_PATH \n");
		sbSql.append("				,C.D_DAYS , TO_CHAR(C.D_TIMES)||'00' AS D_TIMES \n");
		sbSql.append("			FROM	 HLDC_PO_ITEM_MST B \n");
		sbSql.append("				    ,HLDC_PO_TREAT_UPJANG A \n");
		sbSql.append("				    ,HLDC_PO_PREORDER_LIST C \n");
		sbSql.append("			WHERE   A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("			AND B.ITEM_CODE BETWEEN '010000000000' AND '019999999999' \n");
		sbSql.append("			AND A.UPJANG = (SELECT C.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG C WHERE C.UPJANG = "+UPJANG+") \n");
		sbSql.append("			AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
		sbSql.append("			AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("			AND A.CENTER_CODE = C.CENTER_CODE(+) \n");
		sbSql.append("			UNION ALL \n");
		sbSql.append("			SELECT B.UPJANG, A.ITEM_CODE,	A.ITEM_NAME,	A.ITEM_SIZE,	A.PO_UOM,	A.TAX_CODE,	A.KG_CONVERT_RATE \n");
		sbSql.append("				 ,A.ITEM_CLASS1,A.ITEM_CLASS2,A.ITEM_CLASS3,A.ITEM_CLASS4 \n");
		sbSql.append("				 ,A.OTCUSTCD, NULL AS CENTER_CODE, NULL AS CUSTCD, A.SIMAGE_PATH AS IMG_PATH, A.D_DAYS, A.D_TIMES  \n");
		sbSql.append("			FROM	FMP_OTCUST_ITEM A, \n");
		sbSql.append("				    FMP_OTCUST_PRICE_AVA_V B, \n");
		sbSql.append("				( \n");
		sbSql.append("				SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("				FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("				WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = "+UPJANG+") \n");
		sbSql.append("				AND SDATE <= NVL('"+ JDATE +"',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("				GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("				) C \n");
		sbSql.append("			WHERE	A.ITEM_CODE	= B.ITEM_CODE \n");
		sbSql.append("			AND	B.UPJANG	= C.UPJANG \n");
		sbSql.append("			AND	B.SDATE		= C.SDATE \n");
		sbSql.append("			AND	B.ITEM_CODE	= C.ITEM_CODE \n");
		sbSql.append("			AND	A.USE_YN	= 'Y' \n");
		sbSql.append("			AND	B.USE_YN	= 'Y' \n");
		sbSql.append("			) A, \n");
		sbSql.append("			(	SELECT	ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("			FROM	FMP_ITEM_NUT \n");
		sbSql.append("			WHERE	UPJANG = "+UPJANG+" \n");
		sbSql.append("			UNION ALL \n");
		sbSql.append("			SELECT	X.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("            FROM	FSI_ITEM_NUT X, \n");
		sbSql.append("			( \n");
		sbSql.append("				SELECT	ITEM_CODE \n");
		sbSql.append("				FROM	FSI_ITEM_NUT \n");
		sbSql.append("				MINUS \n");
		sbSql.append("				SELECT	ITEM_CODE \n");
		sbSql.append("				FROM	FMP_ITEM_NUT \n");
		sbSql.append("				WHERE	UPJANG = "+UPJANG+" \n");
		sbSql.append("			) Y \n");
		sbSql.append("			WHERE X.ITEM_CODE = Y.ITEM_CODE \n");
		sbSql.append("		) B \n");
		sbSql.append("	WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("       )A \n");
		sbSql.append("     ,( \n");
		sbSql.append("              SELECT /*+ NO_MERGE(B) USE_HASH(B) */ A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("             , A.SALE_PRICE, NVL(C.OP_RATE,0) OP_RATE, DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) OP_PRICE \n");
		sbSql.append("             , ROUND(   DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE)     / KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE \n");
		sbSql.append("        FROM    \n");
		
		sbSql.append("              ( \n");
		sbSql.append("              SELECT \n");
		sbSql.append("                              	   "+UPJANG+" AS UPJANG, \n");
		sbSql.append("                                    NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) AS NEED_DATE , \n");
		sbSql.append("                                    A.ITEM_CODE, \n");
		sbSql.append("                                    A.SALE_PRICE \n");
		sbSql.append("                             FROM   HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("                             WHERE  A.CENTER_CODE = (SELECT A.CENTER_CODE \n");
		sbSql.append("                                     FROM   HLDC_PO_UPJANG_CENTER A, \n");
		sbSql.append("                                             HLDC_ST_UPJANG B \n");
		sbSql.append("                                     WHERE  A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                                     AND    B.UPJANG = "+UPJANG+") \n");
		sbSql.append("                              AND    A.UPJANG = (SELECT AP_UNITPRICE_UPJANG \n");
		sbSql.append("                                     FROM   HLDC_ST_UPJANG \n");
		sbSql.append("                                     WHERE  UPJANG = "+UPJANG+") \n");
 		sbSql.append("                             AND    A.ITEM_CODE > ' ' \n");
 		sbSql.append("                             AND    NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '20201231') \n");
 		sbSql.append("                             AND    A.SALE_PRICE > 0 \n");
 		sbSql.append("                             AND    A.USE_YN = 'Y' \n");
 		sbSql.append("                             AND    EXISTS (SELECT 1 \n");
 		sbSql.append("                                     FROM   HLDC_PO_TREAT_UPJANG X \n");
 		sbSql.append("                                     WHERE  X.ITEM_CODE = A.ITEM_CODE \n");
 		sbSql.append("                                     AND    X.UPJANG = A.UPJANG) \n");
		
		
		sbSql.append("                 ----------- \n");
		sbSql.append("                  UNION ALL \n");
		sbSql.append("                 ----------- \n");
		sbSql.append("                 SELECT "+UPJANG+" AS UPJANG \n");
		sbSql.append("                      , NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE \n");
		sbSql.append("                      , A.ITEM_CODE, A.SALE_PRICE \n");
		sbSql.append("                   FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                      ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                          FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                         WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = "+UPJANG+") \n");
		sbSql.append("                           AND SDATE <= NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                         GROUP BY UPJANG, ITEM_CODE) B \n");
		sbSql.append("                  WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                    AND A.SDATE = B.SDATE \n");
		sbSql.append("                    AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                    AND A.SALE_PRICE > 0 \n");
		sbSql.append("                    AND A.USE_YN = 'Y' \n");
		sbSql.append("                ) A, \n");
		sbSql.append("               FMS_ITEM_V B, \n");
		sbSql.append("        		 ( \n");
		sbSql.append("                SELECT A.ITEM_CODE, OP_RATE, OP_PRICE, A.CEIL_VAL \n");
		sbSql.append("                  FROM FMU_OP_RATE A \n");
		sbSql.append("                 WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                   AND NVL('"+ JDATE +"', TO_CHAR(SYSDATE,'YYYYMMDD')) BETWEEN SDATE AND EDATE \n");
		sbSql.append("                   AND A.USE_YN = 'Y' \n");
		sbSql.append("               ) C \n");
		//sbSql.append("         WHERE A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("         WHERE SUBSTR(A.ITEM_CODE,1," + strOpLen + ") = C.ITEM_CODE(+) \n");
		sbSql.append("           AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("      ) B -- 단가, g당 단가 \n");
		sbSql.append("     ,( \n");
		sbSql.append("	SELECT  ITEM_CODE, \n");
		sbSql.append("		(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = ITEM_FEATURE) AS FEATURE_NAME \n");
		sbSql.append("	FROM    FSI_ITEM_FEATURE \n");
		sbSql.append("	WHERE   (ITEM_CODE, CDATE) IN ( \n");
		sbSql.append("				      SELECT ITEM_CODE, MAX(CDATE) AS CDATE \n");
		sbSql.append("				      FROM   FSI_ITEM_FEATURE \n");
		sbSql.append("				      WHERE (1=1) \n");
		sbSql.append("				      AND  (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
		sbSql.append("											   SELECT CENTER_CODE, \n");
		sbSql.append("												  CUSTCD, \n");
		sbSql.append("												  ITEM_CODE, \n");
		sbSql.append("												  MAX(APPLY_DATE) AS APPLY_DATE \n");
		sbSql.append("											    FROM  FSI_ITEM_FEATURE \n");
		sbSql.append("											    WHERE  CENTER_CODE  = '300001' \n");
		sbSql.append("											    AND  APPLY_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
		sbSql.append("											    GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
		sbSql.append("					) \n");
		sbSql.append("					GROUP BY ITEM_CODE \n");
		sbSql.append("					) \n");
		sbSql.append("      ) D, --자재특성 \n");
		sbSql.append("        ( \n");
		sbSql.append("              SELECT A.CENTER_CODE, A.CUSTCD, "+UPJANG+" UPJANG, A.ITEM_CODE \n");
		sbSql.append("                  , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n");
		sbSql.append("               FROM HLDC_PO_ORDER_SCHEDULE A \n");
		sbSql.append("                  ,(SELECT CENTER_CODE, CUSTCD, MAX(UPJANG) AS UPJANG \n");
		sbSql.append("                      FROM HLDC_PO_ORDER_SCHEDULE \n");
		sbSql.append("                     WHERE CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = "+UPJANG+") \n");
		sbSql.append("                       AND UPJANG IN (-2,(SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = "+UPJANG+")) \n");
		sbSql.append("                     GROUP BY CENTER_CODE, CUSTCD) B \n");
		sbSql.append("              WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("                AND A.CUSTCD = B.CUSTCD \n");
		sbSql.append("                AND A.UPJANG = B.UPJANG \n");
		sbSql.append("        ) E --발주제한 목록  \n");		
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CENTER_CODE = E.CENTER_CODE(+) \n");
		sbSql.append("   AND A.CUSTCD = E.CUSTCD(+) \n");
		sbSql.append("   AND (A.ITEM_CODE = '010708010198' OR NVL(B.OP_PRICE,0)>0  ) \n");
		if( !BIG_CODE.equals(""))
		{
		sbSql.append("   AND A.ITEM_CLASS2 ='"+BIG_CODE+"' || '0000' \n");
		}
		if( !MID_CODE.equals(""))
		{
		sbSql.append("   AND A.ITEM_CLASS3 ='"+MID_CODE+"' || '00' \n");
		}
		if( !SMALL_CODE.equals(""))
		{
		sbSql.append("   AND A.ITEM_CLASS4 ='"+SMALL_CODE+"' \n");
		}
		if( !ITEM_NAME.equals(""))
		{
		sbSql.append("   AND A.ITEM_NAME LIKE '%'|| '"+ITEM_NAME+"' ||'%' \n");
		}		
		
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet FMM00213P_S001 = this.makeDataSet(rs,"FMM00213P_S001");
		out_dl.add(FMM00213P_S001);

		rs.close();
		pstmt.close();
		
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