<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00030V_T001.jsp
■ 프로그램명   : 사업장 단가조회
■ 작성일자     : 2008-03-31
■ 작성자       : 박은규
■ 이력관리     : [고도화]_운영율 관련 수정_김경은
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String strKeyword	= "";
		
		//out 데이타
		DataSet ds_List;
		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		if(!nullToBlank(ds_Cond.getString(0, "ITEM_CODE")).equals(""))
		{
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가			
			String[] arrSameWord_tmp = nullToBlank(ds_Cond.getString(0, "ITEM_CODE")).split(" ");
			
			sbSql_tmp.setLength(0);
            sbSql_tmp.append("/* fm/fmu/FMU00030V_T001.jsp */                                                 \n");
			sbSql_tmp.append("SELECT LISTAGG(T.ITEM_NAME, ',') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME \n");
			sbSql_tmp.append("  FROM ( SELECT KEYWORD||','||SIM_TXT AS ITEM_NAME                              \n");
			sbSql_tmp.append("              , '1' AS ITEM_GROUP                                               \n");
			sbSql_tmp.append("           FROM EPROCUSR.VO_ITEM_SIM_WORD                                       \n");
			sbSql_tmp.append("          WHERE 1=1 															  \n");
			sbSql_tmp.append("            AND  ( 															  \n");
			for(int i=0; i<arrSameWord_tmp.length; i++) {
				sbSql_tmp.append("            		KEYWORD LIKE :KEYWORD" + i + "	                          \n");
				if(i < arrSameWord_tmp.length-1) {
					sbSql_tmp.append("  		OR 															  \n");
				}
			}
			sbSql_tmp.append("    				) 															  \n");
			sbSql_tmp.append("       ) T                                                                      \n");
			
			out_vl.add("fa_Sql", sbSql_tmp.toString());
			
			npstmt = new NamedParameterStatement(conn, sbSql_tmp.toString());
            for ( int i = 0; i < arrSameWord_tmp.length; i++ ) {
		        npstmt.setString("KEYWORD" + i, "%" + arrSameWord_tmp[i] + "%");
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
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT DECODE('" + nullToBlank(ds_Cond.getString(0, "CLASS")) + "','CLASS_NAME1',DECODE(A.CONSUM_YN,'Y','소모품','식자재') \n");
		sbSql.append("                     ,'CLASS_NAME2',(SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS2) \n");
		sbSql.append("                     ,'CLASS_NAME3',(SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS3) \n");
		sbSql.append("                     ,'CLASS_NAME4',(SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS4)) AS CLASS_NAME \n");
		sbSql.append("     , A.ITEM_CLASS4, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");		
		sbSql.append( "    , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");              
        sbSql.append( "       	  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
        sbSql.append( "     	  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
        sbSql.append( "     	  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
        sbSql.append( "     	  ELSE A.SALE_PRICE \n");
        sbSql.append( "      END AS OP_PRICE \n");
		sbSql.append( "    , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");              
        sbSql.append( "       	  THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICEB + (A.SALE_PRICEB * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n"); 
        sbSql.append( "     	  WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
        sbSql.append( "     	  THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICEB + (A.SALE_PRICEB * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
        sbSql.append( "     	  ELSE A.SALE_PRICEB \n");
        sbSql.append( "      END AS OP_PRICEB \n");
		//sbSql.append("     , 'D-'||TO_CHAR(NVL(A.D_DAYS,0) + 1) AS D_DAYS \n");
		sbSql.append(" 	     /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append("     , 'D-'||TO_CHAR(NVL(A.D_DAYS,0)) AS D_DAYS \n");
		sbSql.append("  FROM \n");
		sbSql.append("      (SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG, B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
		sbSql.append("            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("            , A.SALE_PRICE, A.SALE_PRICEB \n");
		sbSql.append("            , K.D_DAYS \n");
		sbSql.append("         FROM HLDC_PO_ITEM_MST B \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("            ,(SELECT A.CENTER_CODE, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("                   , SUM(A.SALE_PRICE) AS SALE_PRICE, SUM(A.SALE_PRICEB) AS SALE_PRICEB \n");
		sbSql.append("                FROM (SELECT \n");
		sbSql.append("                             A.CENTER_CODE, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("                           , A.SALE_PRICE, 0 AS SALE_PRICEB \n");
		sbSql.append("                        FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
		sbSql.append("                       WHERE 1=1 \n");
		sbSql.append("                         AND A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                         AND A.CENTER_CODE = (SELECT Q.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER Q WHERE Q.UPJANG = B.UPJANG) \n");
		sbSql.append("                         AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		//sbSql.append("                        FROM HLDC_PO_CONTRACT_FSALE A \n");
		//sbSql.append("                       WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		//sbSql.append("                         AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG A WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		//sbSql.append("                         AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                         AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
    	sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0 \n");
		sbSql.append("                       UNION ALL \n");
		sbSql.append("                      SELECT \n");
		sbSql.append("                             A.CENTER_CODE, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("                           , 0 AS SALE_PRICE, A.SALE_PRICE AS SALE_PRICEB \n");
		sbSql.append("                        FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
		sbSql.append("                       WHERE 1=1 \n");
		sbSql.append("                         AND A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                         AND A.CENTER_CODE = (SELECT Q.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER Q WHERE Q.UPJANG = B.UPJANG) \n");
		sbSql.append("                         AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		//sbSql.append("                        FROM HLDC_PO_CONTRACT_FSALE A \n");
		//sbSql.append("                       WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		//sbSql.append("                         AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG A WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		//sbSql.append("                         AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                         AND '" + nullToBlank(ds_Cond.getString(0, "SDATEB")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
    	sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0) A \n");
		sbSql.append("               GROUP BY A.CENTER_CODE, A.UPJANG, A.ITEM_CODE) A \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG, B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
		sbSql.append("            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("            , A.SALE_PRICE, A.SALE_PRICEB \n");
		sbSql.append("            , NVL(B.D_DAYS,0) + 1 AS D_DAYS \n");
		sbSql.append("         FROM FMP_OTCUST_ITEM B \n");
		sbSql.append("            ,(SELECT A.ITEM_CODE \n");
		sbSql.append("                   , SUM(A.SALE_PRICE) AS SALE_PRICE, SUM(A.SALE_PRICEB) AS SALE_PRICEB \n");
		sbSql.append("                FROM (SELECT A.ITEM_CODE \n");
		sbSql.append("                           , A.SALE_PRICE, 0 AS SALE_PRICEB \n");
		sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                           ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                               FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                              WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                                AND SDATE <= '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("                              GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("                       WHERE A.UPJANG = C.UPJANG \n");
		sbSql.append("                         AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                         AND A.SDATE  = C.SDATE \n");
		sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0 \n");
		sbSql.append("                       UNION ALL \n");
		sbSql.append("                      SELECT A.ITEM_CODE \n");
		sbSql.append("                           , 0 AS SALE_PRICE, A.SALE_PRICE AS SALE_PRICEB \n");
		sbSql.append("                        FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                           ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                               FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                              WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                                AND SDATE <= '" + nullToBlank(ds_Cond.getString(0, "SDATEB")) + "' \n");
		sbSql.append("                              GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("                       WHERE A.UPJANG = C.UPJANG \n");
		sbSql.append("                         AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                         AND A.SDATE  = C.SDATE \n");
		sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0) A \n");
		sbSql.append("               GROUP BY A.ITEM_CODE) A \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("      ) A \n");
		sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG									\n");
	    sbSql.append("          FROM FMU_OP_RATE 																					\n");
	    sbSql.append("         WHERE USE_YN = 'Y'																					\n");
	    sbSql.append("           AND ITEM_TYPE = 'M' AND SDATE <> '00000000' 																				\n");
	    ///////////////////////////////////////////속도저하로 인한 UPJANG 조회 조건 추가(20151007-이규훈)
	    sbSql.append("           AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "									\n");
	    sbSql.append("           AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN SDATE AND EDATE					\n");
	    sbSql.append("       ) C																									\n");
	    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG									\n");
	    sbSql.append("           FROM FMU_OP_RATE 																					\n");
	    sbSql.append("          WHERE USE_YN = 'Y'																					\n");
		///////////////////////////////////////////속도저하로 인한 UPJANG 조회 조건 추가(20151007-이규훈)
	    sbSql.append("            AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "									\n");
	    sbSql.append("            AND ITEM_TYPE = 'C' AND SDATE <> '00000000' 																				\n");
	    sbSql.append("            AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN SDATE AND EDATE					\n");
	    sbSql.append("        ) D 																									\n");
	    sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG 									\n");
	    sbSql.append("          FROM FMU_OP_RATE 																					\n");
	    sbSql.append("         WHERE USE_YN = 'Y'																					\n");
		///////////////////////////////////////////속도저하로 인한 UPJANG 조회 조건 추가(20151007-이규훈)
	    sbSql.append("            AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "									\n");
	    sbSql.append("           AND ITEM_TYPE = 'M' AND SDATE <> '00000000' 																				\n");
	    sbSql.append("           AND '" + nullToBlank(ds_Cond.getString(0, "SDATEB")) + "' BETWEEN SDATE AND EDATE					\n");
	    sbSql.append("       ) E																									\n");
	    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG									\n");
	    sbSql.append("           FROM FMU_OP_RATE 																					\n");
	    sbSql.append("          WHERE USE_YN = 'Y'																					\n");
		///////////////////////////////////////////속도저하로 인한 UPJANG 조회 조건 추가(20151007-이규훈)
	    sbSql.append("            AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "									\n");
	    sbSql.append("            AND ITEM_TYPE = 'C' AND SDATE <> '00000000' 																				\n");
	    sbSql.append("           AND '" + nullToBlank(ds_Cond.getString(0, "SDATEB")) + "' BETWEEN SDATE AND EDATE					\n");
	    sbSql.append("        ) F 																									\n");
		sbSql.append(" WHERE 1=1 \n");
		sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");        
        sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
        sbSql.append("   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
        
		String sItemClass2 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2"));
		String sItemClass3 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3"));
		String sItemClass4 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4"));
		String sItemCode   = nullToBlank(ds_Cond.getString(0, "ITEM_CODE"));
		
		if (! sItemClass2.equals(""))
			sbSql.append("   AND A.ITEM_CLASS2 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2")) + "' \n");
		if (! sItemClass3.equals(""))
			sbSql.append("   AND A.ITEM_CLASS3 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3")) + "' \n");
		if (! sItemClass4.equals(""))
			sbSql.append("   AND A.ITEM_CLASS4 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4")) + "' \n");
		//if (! sItemCode.equals(""))
		//	sbSql.append("   AND (A.ITEM_CODE LIKE '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'||'%' OR A.ITEM_NAME LIKE '%'||'" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'||'%') \n");
		if (! sItemCode.equals("")) {
			sbSql.append("   AND (		\n");
			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
				sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("   	 ) \n");
		}
		
		//out_vl.add("fa_Sql", sbSql.toString());
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//IRIS 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();		

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT DECODE('" + nullToBlank(ds_Cond.getString(0, "CLASS")) + "','CLASS_NAME1',DECODE(A.CONSUM_YN,'Y','소모품','식자재') \n");
		sbSql.append("                     ,'CLASS_NAME2',(SELECT B.CLASS_NAME FROM PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS2) \n");
		sbSql.append("                     ,'CLASS_NAME3',(SELECT B.CLASS_NAME FROM PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS3) \n");
		sbSql.append("                     ,'CLASS_NAME4',(SELECT B.CLASS_NAME FROM PO_ITEM_CLASS_HLDC_V B WHERE B.CLASS_CODE = A.ITEM_CLASS4)) AS CLASS_NAME \n");
		sbSql.append("     , A.ITEM_CLASS4, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");
		sbSql.append("     , DECODE(SIGN(NVL(B.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL), B.OP_PRICE) AS OP_PRICE \n");
		sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICEB + ROUND(A.SALE_PRICEB * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICEB \n");
		sbSql.append("     , 'D-'||TO_CHAR(NVL(A.D_DAYS,0) + 1) AS D_DAYS \n");
		sbSql.append("  FROM \n");

		sbSql.append("      (SELECT * FROM HWFS_FMU_OP_RATE \n");
		sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN SDATE AND EDATE \n");		
		sbSql.append("          AND USE_YN = 'Y') B \n");				

		sbSql.append("     ,(SELECT * FROM HWFS_FMU_OP_RATE \n");
		sbSql.append("        WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("          AND '" + nullToBlank(ds_Cond.getString(0, "SDATEB")) + "' BETWEEN SDATE AND EDATE \n");		
		sbSql.append("          AND USE_YN = 'Y') C \n");				
		
		sbSql.append("     ,(SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG, B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
		sbSql.append("            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("            , A.SALE_PRICE, A.SALE_PRICEB \n");
		sbSql.append("            , K.D_DAYS \n");
		sbSql.append("         FROM PO_ITEM_MST B \n");
		sbSql.append("            , PO_PREORDER_LIST K \n");
		sbSql.append("            ,(SELECT A.CENTER_CODE, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("                   , SUM(A.SALE_PRICE) AS SALE_PRICE, SUM(A.SALE_PRICEB) AS SALE_PRICEB \n");
		sbSql.append("                FROM (SELECT /*+ INDEX(A PO_CONTRACT_FSALE_I2) */ \n");
		sbSql.append("                             A.CENTER_CODE, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("                           , A.SALE_PRICE, 0 AS SALE_PRICEB \n");
		sbSql.append("                        FROM PO_CONTRACT_FSALE A \n");
		sbSql.append("                       WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM PO_UPJANG_CENTER A, ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                         AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM ST_UPJANG A WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                         AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                         AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'20201231') \n");
    //2009.05.20 박은규, 김진희, 업장업체 설정되어있는 것만 조회
		sbSql.append("                         AND EXISTS (SELECT 1 FROM PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.UPJANG = A.UPJANG) \n");
		sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0 \n");
		sbSql.append("                       UNION ALL \n");
		sbSql.append("                      SELECT /*+ INDEX(A PO_CONTRACT_FSALE_I2) */ \n");
		sbSql.append("                             A.CENTER_CODE, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("                           , 0 AS SALE_PRICE, A.SALE_PRICE AS SALE_PRICEB \n");
		sbSql.append("                        FROM PO_CONTRACT_FSALE A \n");
		sbSql.append("                       WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM PO_UPJANG_CENTER A, ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                         AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM ST_UPJANG A WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                         AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                         AND '" + nullToBlank(ds_Cond.getString(0, "SDATEB")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'20201231') \n");
    //2009.05.20 박은규, 김진희, 업장업체 설정되어있는 것만 조회
		sbSql.append("                         AND EXISTS (SELECT 1 FROM PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.UPJANG = A.UPJANG) \n");
		sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0) A \n");
		sbSql.append("               GROUP BY A.CENTER_CODE, A.UPJANG, A.ITEM_CODE) A \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG, B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
		sbSql.append("            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("            , A.SALE_PRICE, A.SALE_PRICEB \n");
		sbSql.append("            , B.D_DAYS \n");
		sbSql.append("         FROM HWFS_FMP_OTCUST_ITEM B \n");
		sbSql.append("            ,(SELECT A.ITEM_CODE \n");
		sbSql.append("                   , SUM(A.SALE_PRICE) AS SALE_PRICE, SUM(A.SALE_PRICEB) AS SALE_PRICEB \n");
		sbSql.append("                FROM (SELECT A.ITEM_CODE \n");
		sbSql.append("                           , A.SALE_PRICE, 0 AS SALE_PRICEB \n");
		sbSql.append("                        FROM HWFS_FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                           ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                               FROM HWFS_FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                              WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM HWFS_FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                                AND SDATE <= '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("                              GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("                       WHERE A.UPJANG = C.UPJANG \n");
		sbSql.append("                         AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                         AND A.SDATE  = C.SDATE \n");
		sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0 \n");
		sbSql.append("                       UNION ALL \n");
		sbSql.append("                      SELECT A.ITEM_CODE \n");
		sbSql.append("                           , 0 AS SALE_PRICE, A.SALE_PRICE AS SALE_PRICEB \n");
		sbSql.append("                        FROM HWFS_FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                           ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                               FROM HWFS_FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                              WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM HWFS_FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                                AND SDATE <= '" + nullToBlank(ds_Cond.getString(0, "SDATEB")) + "' \n");
		sbSql.append("                              GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("                       WHERE A.UPJANG = C.UPJANG \n");
		sbSql.append("                         AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                         AND A.SDATE  = C.SDATE \n");
		sbSql.append("                         AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0) A \n");
		sbSql.append("               GROUP BY A.ITEM_CODE) A \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("      ) A \n");
		sbSql.append(" WHERE A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");		
		sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		String sConsum = nullToBlank(ds_Cond.getString(0, "CONSUM_YN"));
		String sItemClass2 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2"));
		String sItemClass3 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3"));
		String sItemClass4 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4"));
		String sItemCode   = nullToBlank(ds_Cond.getString(0, "ITEM_CODE"));
		if (! sConsum.equals(""))
			sbSql.append("   AND A.CONSUM_YN = '" + nullToBlank(ds_Cond.getString(0, "CONSUM_YN")) + "' \n");
		if (! sItemClass2.equals(""))
			sbSql.append("   AND A.ITEM_CLASS2 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2")) + "' \n");
		if (! sItemClass3.equals(""))
			sbSql.append("   AND A.ITEM_CLASS3 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3")) + "' \n");
		if (! sItemClass4.equals(""))
			sbSql.append("   AND A.ITEM_CLASS4 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4")) + "' \n");
		if (! sItemCode.equals(""))
			sbSql.append("   AND (A.ITEM_CODE LIKE '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'||'%' OR A.ITEM_NAME LIKE '%'||'" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'||'%') \n");
	
		//sbSql.append(" ORDER BY A.ITEM_CLASS4, A.ITEM_CODE \n");  //2009/11/12 규완 임시 저장

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_List);

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
