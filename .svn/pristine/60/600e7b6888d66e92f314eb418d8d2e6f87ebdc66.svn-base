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
		
		String BIG_CODE		= in_vl.getString("BIG_CODE");	
		String MID_CODE		= in_vl.getString("MID_CODE");	
		String SMALL_CODE	= in_vl.getString("SMALL_CODE");	
		String CODE_NAME	= in_vl.getString("CODE_NAME");	
		String UPJANG		= in_vl.getString("UPJANG");	
		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
/***		
		if(!nullToBlank(CODE_NAME).equals(""))
		{
			String[] arrSameWord_tmp = nullToBlank(CODE_NAME).split(" ");
			
			sbSql_tmp.append("SELECT LISTAGG(T.ITEM_NAME, ',') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME \n");
			sbSql_tmp.append("  FROM ( SELECT KEYWORD||','||SIM_TXT AS ITEM_NAME                              \n");
			sbSql_tmp.append("              , '1' AS ITEM_GROUP                                               \n");
			sbSql_tmp.append("           FROM EPROCUSR.VO_ITEM_SIM_WORD                                       \n");
			sbSql_tmp.append("          WHERE 1=1 															  \n");
			sbSql_tmp.append("            AND  ( 															  \n");
			for(int i=0; i<arrSameWord_tmp.length; i++) {
				sbSql_tmp.append("            		KEYWORD LIKE '%' || '"+arrSameWord_tmp[i]+"' || '%'		  \n");
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
***/		
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT AA.ITEM_CODE, --자재코드 \n");
		sbSql.append("       AA.ITEM_NAME, --자재명 \n");
		sbSql.append("       AA.ITEM_SIZE, --규격 \n");
		sbSql.append("       AA.PO_UOM, --단위 \n");
		sbSql.append("       nvl(BB.OP_PRICE,0) MARGIN_PRICE, --단가 \n");
		sbSql.append("       DECODE(NVL(BB.OP_PRICE,0),0,'Y','N') RESTRICT_YN, --발주불가상태(금지) \n");
		sbSql.append("       AA.DISUSE_RATE, --폐기율 \n");
		sbSql.append("       ROUND(NVL(BB.OP_PRICE,0) / AA.KG_CONVERT_RATE / 1000,2) GRAM_PRICE, --g당단가 \n");
		sbSql.append("       AA.KG_CONVERT_RATE, --kg환산율 \n");
		sbSql.append("       AA.CAL, --100g당 에너지 \n");
		sbSql.append("	     CC.FEATURE_NAME, --자재특성 \n");
		sbSql.append("	     CC.FEATURE_ICON, --자재특성 \n");
		//sbSql.append("	     FMS_ITEM_FEATURE_FUN("+UPJANG+", TO_CHAR(SYSDATE, 'YYYYMMDD'), AA.ITEM_CODE, 'I') AS FEATURE_NAME, --자재특성 \n");
		sbSql.append("	     BB.ORIGIN_TYPE	--원산지 \n");
		sbSql.append("  FROM \n");
		sbSql.append("      ( \n");
		sbSql.append("      SELECT A.ITEM_CODE,A.ITEM_NAME,A.ITEM_SIZE,A.PO_UOM,A.KG_CONVERT_RATE \n");
		sbSql.append("             ,B.CAL, B.WATER, B.PROT, B.FAT, B.CARBO, B.FIBER, B.ASH, B.CA, B.P \n");
		sbSql.append("             ,B.FE, B.NA, B.K, B.VITA_A, B.RETIN, B.B_CAROT, B.THIA, B.RIBO, B.NIACIN \n");
		sbSql.append("             , B.VITA_C, B.CHOLE, B.DISUSE_RATE \n");
		sbSql.append("      FROM (SELECT B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE, B.KG_CONVERT_RATE, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("              FROM HLDC_PO_ITEM_MST B, HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("             WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("               AND B.ITEM_CLASS1 = 'F' \n");
		sbSql.append("               AND A.UPJANG = (SELECT C.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG C WHERE C.UPJANG = "+UPJANG+") \n");
		sbSql.append("               AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
		sbSql.append("               AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("             UNION ALL \n");
		sbSql.append("            SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.KG_CONVERT_RATE, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append("              FROM FMP_OTCUST_ITEM A, FMP_OTCUST_PRICE_AVA_V B \n");
		sbSql.append("                 ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                     FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                    WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = "+UPJANG+") \n");
		sbSql.append("                      AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                    GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("             WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("               AND B.UPJANG = C.UPJANG \n");
		sbSql.append("               AND B.SDATE = C.SDATE \n");
		sbSql.append("               AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("               AND A.USE_YN = 'Y' AND B.USE_YN = 'Y') A, \n");
		sbSql.append("           (SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("              FROM FMP_ITEM_NUT WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("             UNION ALL \n");
		sbSql.append("           (  SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("		                              FROM	FSI_ITEM_NUT \n");
		sbSql.append("		                             WHERE ITEM_CODE IN \n");
		sbSql.append("	                                  ( \n");
		sbSql.append("	                                   SELECT ITEM_CODE \n");
		sbSql.append("	                                   FROM FSI_ITEM_NUT \n");
		sbSql.append("                                       MINUS \n");
		sbSql.append("	                                   SELECT ITEM_CODE \n");
		sbSql.append("		                               FROM FMP_ITEM_NUT \n");
		sbSql.append("	                                   WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                                       )   )  ) B \n");
		
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		if(!BIG_CODE.equals(""))
		{
		sbSql.append("           AND A.ITEM_CLASS2 ='"+BIG_CODE+"' \n");
		}
		if(!MID_CODE.equals(""))
		{
		sbSql.append("           AND A.ITEM_CLASS3 ='"+MID_CODE+"' \n");
		}
		if(!SMALL_CODE.equals(""))
		{
		sbSql.append("           AND A.ITEM_CLASS4 ='"+SMALL_CODE+"' \n");
		}
		if(!CODE_NAME.equals(""))
		{
			sbSql.append("   AND (		\n");
/***			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
				sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
***/

			String[] arrSameWord_tmp = nullToBlank(CODE_NAME).split(" ");
			for(int i=0; i<arrSameWord_tmp.length; i++) {
				sbSql.append("            		A.ITEM_NAME LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
				if(i < arrSameWord_tmp.length-1) {
					sbSql.append("  		OR 															  \n");
				}
			}

			sbSql.append("   	 ) \n");
		//sbSql.append("           AND A.ITEM_NAME  LIKE '%'||'"+CODE_NAME+"'||'%' \n");
		}
		sbSql.append("      ) AA, \n");
		sbSql.append("  	( \n");
		sbSql.append("		SELECT \n");
		sbSql.append("		       A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.ORIGIN_TYPE, \n");
		
		sbSql.append("             NVL(NVL(C.OP_RATE, D.OP_RATE), 0) AS OP_RATE, --운영율             \n");
		sbSql.append("             CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
		sbSql.append("                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("                  ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)                        \n");
		
		sbSql.append("		  FROM \n");
		sbSql.append("		     ( \n");
		sbSql.append("			SELECT  \n");
		sbSql.append("					"+UPJANG+" AS UPJANG, \n");
		sbSql.append("				TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("				A.ITEM_CODE, \n");
		sbSql.append("				A.SALE_PRICE \n");
		sbSql.append("			 FROM   HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
		sbSql.append("			 WHERE  A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("			 AND    B.UPJANG = "+UPJANG+" \n");
		sbSql.append("			 AND    A.ITEM_CODE > ' ' \n");
		sbSql.append("			 AND    TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("			 AND    A.SALE_PRICE > 0 \n");
		sbSql.append("			 AND    A.USE_YN = 'Y' \n");
				
		sbSql.append("		     ----------- \n");
		sbSql.append("		      UNION ALL \n");
		sbSql.append("		     ----------- \n");
		sbSql.append("		     SELECT "+UPJANG+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
		sbSql.append("		       FROM FMP_OTCUST_PRICE_AVA_V A , \n");
		sbSql.append("			    ( \n");
		sbSql.append("			    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("			      FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("			     WHERE UPJANG = \n");
		sbSql.append("				   ( \n");
		sbSql.append("				   SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("				     FROM FMS_UPJANG \n");
		sbSql.append("				    WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("				   ) \n");
		sbSql.append("			       AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("			     GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("			    ) B \n");
		sbSql.append("		      WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("			AND A.SDATE = B.SDATE \n");
		sbSql.append("			AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("			AND A.SALE_PRICE > 0 \n");
		sbSql.append("			AND A.USE_YN = 'Y' \n");
		sbSql.append("		     ) A, \n");
		sbSql.append("           FMS_ITEM_V B, \n");
		
		sbSql.append("           ( \n");   
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'M' \n");
		sbSql.append("           ) C, \n");
		sbSql.append("           ( \n");        
		sbSql.append("             SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("               FROM FMU_OP_RATE \n");
		sbSql.append("              WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("                AND USE_YN = 'Y' \n");
		sbSql.append("                AND ITEM_TYPE = 'C' \n");
		sbSql.append("           ) D \n");
		
		sbSql.append("      WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("        AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("        AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		
		if(!BIG_CODE.equals(""))
		{
		sbSql.append("           AND B.ITEM_CLASS2 ='"+BIG_CODE+"' \n");
		}
		if(!MID_CODE.equals(""))
		{
		sbSql.append("           AND B.ITEM_CLASS3 ='"+MID_CODE+"' \n");
		}
		if(!SMALL_CODE.equals(""))
		{
		sbSql.append("           AND B.ITEM_CLASS4 ='"+SMALL_CODE+"' \n");
		}
		sbSql.append("	) BB, \n");
// 		sbSql.append("	( \n");
// 		sbSql.append("	SELECT  ITEM_CODE, \n");
// 		sbSql.append("			(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = ITEM_FEATURE) AS FEATURE_NAME \n");
// 		sbSql.append("	FROM    FSI_ITEM_FEATURE \n");
// 		sbSql.append("	WHERE   (ITEM_CODE, CDATE) IN ( \n");
// 		sbSql.append("								  SELECT ITEM_CODE, MAX(CDATE) AS CDATE \n");
// 		sbSql.append("								  FROM   FSI_ITEM_FEATURE \n");
// 		sbSql.append("								  WHERE (1=1) \n");
// 		sbSql.append("								  AND  (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
// 		sbSql.append("												   SELECT CENTER_CODE, \n");
// 		sbSql.append("														  CUSTCD, \n");
// 		sbSql.append("														  ITEM_CODE, \n");
// 		sbSql.append("														  MAX(APPLY_DATE) AS APPLY_DATE \n");
// 		sbSql.append("													FROM  FSI_ITEM_FEATURE \n");
// 		sbSql.append("													WHERE  CENTER_CODE  = '300001' \n");
// 		sbSql.append("													AND APPLY_DATE  BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD')  \n");
// 		sbSql.append("																	AND   TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
// 		sbSql.append("													GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 		sbSql.append("													) \n");
// 		sbSql.append("									GROUP BY ITEM_CODE \n");
// 		sbSql.append("									) \n");
// 		sbSql.append("	) CC \n");
        sbSql.append("(SELECT A.ITEM_CODE \n"); 
        sbSql.append("      , CASE WHEN B.DUTY_YN = 'Y' THEN '기획자재' \n"); 
        sbSql.append("             WHEN A.MANUF_CD IS NOT NULL THEN '전처리' \n"); 
        sbSql.append("             WHEN B.PB_YN = 'Y' THEN 'PB상품' \n"); 
        sbSql.append("             WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN '친환경' \n"); 
        sbSql.append("             ELSE '' \n"); 
        sbSql.append("         END AS FEATURE_NAME \n"); 
        sbSql.append("      , CASE WHEN B.DUTY_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon11.png' \n"); 
        sbSql.append("             WHEN A.MANUF_CD IS NOT NULL THEN 'theme://Images/new/grd_WF_Icon10.png' \n"); 
        sbSql.append("             WHEN B.PB_YN = 'Y' THEN 'theme://Images/new/grd_WF_Icon09.png' \n"); 
        sbSql.append("             WHEN A.ECO_ITEM IN ('유기농','무농약','저농약','무항생제') THEN 'theme://Images/new/grd_WF_Icon08.png' \n"); 
        sbSql.append("             ELSE '' \n"); 
        sbSql.append("         END AS FEATURE_ICON \n"); 
        sbSql.append("   FROM EPROCUSR.MV_ITEM_MST3 A, EPROCUSR.VO_CONTRACT_F B \n"); 
        sbSql.append("  WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n"); 
        sbSql.append("    AND A.USE_YN = 'Y' \n"); 
        sbSql.append("    AND B.UPJANG(+) = "+UPJANG+" \n"); 
        sbSql.append("    AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN B.CONTRACT_START(+) AND B.CONTRACT_END(+) \n"); 
        sbSql.append(") CC \n"); 
		sbSql.append("WHERE AA.ITEM_CODE=BB.ITEM_CODE(+) \n");
		sbSql.append("AND	(NVL(BB.OP_PRICE,0) > 0 OR AA.ITEM_CODE ='010708010198') --조리용물 예외 처리   \n");
 		sbSql.append("AND	AA.ITEM_CODE=CC.ITEM_CODE(+) \n");

		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_ListItem = this.makeDataSet(rs,"ds_ListItem");
		out_dl.add(ds_ListItem);
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
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
	//	System.out.println("==>FMM00010E_S020 \n");
		String BIG_CODE		= in_vl.getString("BIG_CODE");	
		String MID_CODE		= in_vl.getString("MID_CODE");	
		String SMALL_CODE	= in_vl.getString("SMALL_CODE");	
		String CODE_NAME	= in_vl.getString("CODE_NAME");	
		String UPJANG		= in_vl.getString("UPJANG");	
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
	
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		//운영율 설정조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT FMS_OPRATEINFO_FUN('" + UPJANG + "') AS OP_LEN FROM DUAL \n");
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();
		rs.next();
		String strOpLen = rs.getString("OP_LEN");
		rs.close();
		pstmt.close();

		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT AA.ITEM_CODE,    --자재코드 \n");
		sbSql.append("       AA.ITEM_NAME,    --자재명 \n");
		sbSql.append("       AA.ITEM_SIZE,    --규격 \n");
		sbSql.append("       AA.PO_UOM,       --단위 \n");
		sbSql.append("       nvl(BB.OP_PRICE,0) MARGIN_PRICE,  --단가 \n");
		sbSql.append("       DECODE(NVL(BB.OP_PRICE,0),0,'Y','N') RESTRICT_YN,    --발주불가상태(금지) \n");
		sbSql.append("       AA.DISUSE_RATE,                  --폐기율 \n");
		sbSql.append("       ROUND(NVL(BB.OP_PRICE,0) / AA.KG_CONVERT_RATE / 1000,2) GRAM_PRICE,--g당단가 \n");
		sbSql.append("       AA.KG_CONVERT_RATE,      --kg환산율 \n");
		sbSql.append("       AA.CAL,                   --100g당 에너지 \n");
		sbSql.append("	   CC.FEATURE_NAME			--자재특성 \n");
		sbSql.append("  FROM \n");
		sbSql.append("      ( \n");
		sbSql.append("      SELECT A.ITEM_CODE,A.ITEM_NAME,A.ITEM_SIZE,A.PO_UOM,A.KG_CONVERT_RATE \n");
		sbSql.append("             ,B.CAL, B.WATER, B.PROT, B.FAT, B.CARBO, B.FIBER, B.ASH, B.CA, B.P \n");
		sbSql.append("             ,B.FE, B.NA, B.K, B.VITA_A, B.RETIN, B.B_CAROT, B.THIA, B.RIBO, B.NIACIN \n");
		sbSql.append("             , B.VITA_C, B.CHOLE, B.DISUSE_RATE \n");
		sbSql.append("      FROM (SELECT B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE,B.KG_CONVERT_RATE \n");
		sbSql.append("              FROM HLDC_PO_ITEM_MST B, HLDC_PO_TREAT_UPJANG A \n");
		sbSql.append("             WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("               AND B.ITEM_CODE BETWEEN '010000000000' AND '019999999999' \n");
		sbSql.append("               AND A.UPJANG = (SELECT C.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG C WHERE C.UPJANG = "+UPJANG+") \n");
		sbSql.append("               AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
		sbSql.append("             UNION ALL \n");
		sbSql.append("            SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE,A.KG_CONVERT_RATE \n");
		sbSql.append("              FROM FMP_OTCUST_ITEM A, FMP_OTCUST_PRICE_AVA_V B \n");
		sbSql.append("                 ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                     FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                    WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = "+UPJANG+") \n");
		sbSql.append("                      AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                    GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("             WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("               AND B.UPJANG = C.UPJANG \n");
		sbSql.append("               AND B.SDATE = C.SDATE \n");
		sbSql.append("               AND B.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("               AND A.USE_YN = 'Y' AND B.USE_YN = 'Y') A, \n");
		sbSql.append("           (SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("              FROM FMP_ITEM_NUT WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("             UNION ALL \n");
		
		sbSql.append("           (  SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("		                              FROM	FSI_ITEM_NUT \n");
		sbSql.append("		                             WHERE ITEM_CODE IN \n");
		sbSql.append("	                                  ( \n");
		sbSql.append("	                                   SELECT ITEM_CODE \n");
		sbSql.append("	                                   FROM FSI_ITEM_NUT \n");
		sbSql.append("                                       MINUS \n");
		sbSql.append("	                                   SELECT ITEM_CODE \n");
		sbSql.append("		                               FROM FMP_ITEM_NUT \n");
		sbSql.append("	                                   WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                                       )   )  ) B \n");
		
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		if(!BIG_CODE.equals("0000"))
		{
		sbSql.append("           AND SUBSTR(A.ITEM_CODE,1,4)='"+BIG_CODE+"' \n");
		}
		if(!MID_CODE.equals("0000"))
		{
		sbSql.append("           AND SUBSTR(A.ITEM_CODE,1,6)='"+MID_CODE+"' \n");
		}
		if(!SMALL_CODE.equals("0000"))
		{
		sbSql.append("           AND SUBSTR(A.ITEM_CODE,1,8)='"+SMALL_CODE+"' \n");
		}
		if(!CODE_NAME.equals(""))
		{
		sbSql.append("           AND A.ITEM_NAME  LIKE '%'||'"+CODE_NAME+"'||'%' \n");
		}
		sbSql.append("      ) AA, \n");
		sbSql.append("  	( \n");
		sbSql.append("		SELECT /*+-- ORDERED USE_HASH (A C) */ \n");
		sbSql.append("		       A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, NVL(C.OP_RATE,0) AS OP_RATE,                  --운영율 \n");
		sbSql.append("		       DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE --운영단가(1인원가) \n");
		sbSql.append("		  FROM \n");
		sbSql.append("		     ( \n");
		sbSql.append("			SELECT  /*+ INDEX(A PO_CONTRACT_FSALE_PK)*/ \n");
		sbSql.append("					"+UPJANG+" AS UPJANG, \n");
		sbSql.append("				TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , \n");
		sbSql.append("				A.ITEM_CODE, \n");
		sbSql.append("				A.SALE_PRICE \n");
		sbSql.append("			 FROM   HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("			 WHERE  A.CENTER_CODE = (SELECT A.CENTER_CODE \n");
		sbSql.append("				 FROM   HLDC_PO_UPJANG_CENTER A, \n");
		sbSql.append("					HLDC_ST_UPJANG B \n");
		sbSql.append("				 WHERE  A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("				 AND    B.UPJANG = "+UPJANG+") \n");
		sbSql.append("			 AND    A.UPJANG = (SELECT AP_UNITPRICE_UPJANG \n");
		sbSql.append("				 FROM   HLDC_ST_UPJANG \n");
		sbSql.append("				 WHERE  UPJANG = "+UPJANG+") \n");
		sbSql.append("			 AND    A.ITEM_CODE > ' ' \n");
		sbSql.append("			 AND    TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '20201231') \n");
		sbSql.append("			 AND    A.SALE_PRICE > 0 \n");
		sbSql.append("			 AND    A.USE_YN = 'Y' \n");
		sbSql.append("			 AND    EXISTS (SELECT 1 \n");
		sbSql.append("				 FROM   HLDC_PO_TREAT_UPJANG X \n");
		sbSql.append("				 WHERE  X.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("				 AND    X.UPJANG = A.UPJANG) \n");		
		
		sbSql.append("		     ----------- \n");
		sbSql.append("		      UNION ALL \n");
		sbSql.append("		     ----------- \n");
		sbSql.append("		     SELECT "+UPJANG+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE \n");
		sbSql.append("		       FROM FMP_OTCUST_PRICE_AVA_V A , \n");
		sbSql.append("			    ( \n");
		sbSql.append("			    SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("			      FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("			     WHERE UPJANG = \n");
		sbSql.append("				   ( \n");
		sbSql.append("				   SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("				     FROM FMS_UPJANG \n");
		sbSql.append("				    WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("				   ) \n");
		sbSql.append("			       AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("			     GROUP BY UPJANG, ITEM_CODE \n");
		sbSql.append("			    ) B \n");
		sbSql.append("		      WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("			AND A.SDATE = B.SDATE \n");
		sbSql.append("			AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("			AND A.SALE_PRICE > 0 \n");
		sbSql.append("			AND A.USE_YN = 'Y' \n");
		sbSql.append("		     ) A, \n");
		sbSql.append("		     ( \n");
		sbSql.append("		     SELECT A.ITEM_CODE, OP_RATE, OP_PRICE, A.CEIL_VAL \n");
		sbSql.append("		       FROM FMU_OP_RATE A \n");
		sbSql.append("		      WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("			AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE \n");
		sbSql.append("			AND A.USE_YN = 'Y' \n");
		sbSql.append("		     ) C \n");
//		sbSql.append("		WHERE A.ITEM_CODE = C.ITEM_CODE(+) \n");
		//sbSql.append("		WHERE A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append("      WHERE SUBSTR(A.ITEM_CODE,1," + strOpLen + ") = C.ITEM_CODE(+) \n");
		if(!BIG_CODE.equals("0000"))
		{
		sbSql.append("           AND SUBSTR(A.ITEM_CODE,1,4)='"+BIG_CODE+"' \n");
		}
		if(!MID_CODE.equals("0000"))
		{
		sbSql.append("           AND SUBSTR(A.ITEM_CODE,1,6)='"+MID_CODE+"' \n");
		}
		if(!SMALL_CODE.equals("0000"))
		{
		sbSql.append("           AND SUBSTR(A.ITEM_CODE,1,8)='"+SMALL_CODE+"' \n");
		}
		sbSql.append("	) BB, \n");
		sbSql.append("	( \n");
		sbSql.append("	SELECT  ITEM_CODE, \n");
		sbSql.append("			(SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0033' AND CODE = ITEM_FEATURE) AS FEATURE_NAME \n");
		sbSql.append("	FROM    FSI_ITEM_FEATURE \n");
		sbSql.append("	WHERE   (ITEM_CODE, CDATE) IN ( \n");
		sbSql.append("								  SELECT ITEM_CODE, MAX(CDATE) AS CDATE \n");
		sbSql.append("								  FROM   FSI_ITEM_FEATURE \n");
		sbSql.append("								  WHERE (1=1) \n");
		sbSql.append("								  AND  (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN ( \n");
		sbSql.append("												   SELECT CENTER_CODE, \n");
		sbSql.append("														  CUSTCD, \n");
		sbSql.append("														  ITEM_CODE, \n");
		sbSql.append("														  MAX(APPLY_DATE) AS APPLY_DATE \n");
		sbSql.append("													FROM  FSI_ITEM_FEATURE \n");
		sbSql.append("													WHERE  CENTER_CODE  = '300001' \n");
		sbSql.append("													AND APPLY_DATE  BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD')  \n");
		sbSql.append("																	AND   TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD') \n");
		sbSql.append("													GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
		sbSql.append("													) \n");
		sbSql.append("									GROUP BY ITEM_CODE \n");
		sbSql.append("									) \n");
		sbSql.append("	) CC \n");
		sbSql.append("WHERE AA.ITEM_CODE=BB.ITEM_CODE(+) \n");
		sbSql.append("AND	(NVL(BB.OP_PRICE,0) > 0 OR AA.ITEM_CODE ='010708010198') --조리용물 예외 처리   \n");
		sbSql.append("AND	AA.ITEM_CODE=CC.ITEM_CODE(+) \n");

		System.out.println(sbSql);
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_ListItem = this.makeDataSet(rs,"ds_ListItem");
		out_dl.add(ds_ListItem);
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