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
		DataSet ds_input     	= in_dl.get("ds_cond");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strFavorGroup			= nullToBlank(ds_input.getString(0, "FAVOR_GROUP"));
		
		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
		
		sbSql.append("\n  SELECT ");
		sbSql.append("\n  	     A.UPJANG ");
		sbSql.append("\n  	   , A.FAVOR_GROUP ");
		sbSql.append("\n  	   , A.ITEM_CODE ");
		sbSql.append("\n       , NVL(B.ITEM_NAME, C.ITEM_NAME) AS ITEM_NAME ");
		sbSql.append("\n  	   , B.ITEM_SIZE ");
		sbSql.append("\n       , B.PO_UOM ");
		sbSql.append("\n       , B.OP_PRICE AS UNIT_PRICE ");
		sbSql.append("\n       , '' AS ITEM_DESC ");
		sbSql.append("\n  	   , A.REMARK ");
		sbSql.append("\n  	   , A.USE_YN ");
		sbSql.append("\n       , A.CUSER ");
		sbSql.append("\n       , A.UUSER ");
		sbSql.append("\n       , '1' AS CHK ");
		sbSql.append("\n       , B.ORIGIN_TYPE ");
		sbSql.append("\n       , DECODE(B.ITEM_CODE, NULL, '계약안됨', '') AS RMK ");
		sbSql.append("\n    FROM FMP_FAVORITE A ");
		sbSql.append("\n       , ( ");
		sbSql.append("\n          SELECT ");
		sbSql.append("\n                 A.UPJANG, A.ITEM_CODE ");
		sbSql.append("\n               , A.SALE_PRICE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.ORIGIN_TYPE ");
		sbSql.append("\n               , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
    	sbSql.append("\n                      THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
    	sbSql.append("\n                      WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
    	sbSql.append("\n                      THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
    	sbSql.append("\n                 ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 ");
		sbSql.append("\n            FROM ( ");
		sbSql.append("\n                  SELECT ");
		sbSql.append("\n                  		  "+strUpjang+" AS UPJANG, ");
		sbSql.append("\n                  		  TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE , ");
		sbSql.append("\n                          A.ITEM_CODE, ");
		sbSql.append("\n                          A.SALE_PRICE, ");
		sbSql.append("\n                          B.ITEM_CLASS4, ");
		sbSql.append("\n                          B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE, B.ORIGIN_TYPE");
		sbSql.append("\n                     FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B, HLDC_ST_UPJANG C ");
		sbSql.append("\n                    WHERE A.ITEM_CODE = B.ITEM_CODE ");
		sbSql.append("\n                      AND A.UPJANG = C.AP_UNITPRICE_UPJANG ");
		sbSql.append("\n                      AND C.UPJANG = "+strUpjang+" ");
		sbSql.append("\n                      AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') ");
		sbSql.append("\n                      AND A.SALE_PRICE > 0 ");
		sbSql.append("\n                      AND A.USE_YN = 'Y' ");
		sbSql.append("\n                      AND B.ITEM_CLASS4 LIKE 'F%' ");
		sbSql.append("\n                   ----------- ");
		sbSql.append("\n                    UNION ALL ");
		sbSql.append("\n                   ----------- ");
		sbSql.append("\n                   SELECT "+strUpjang+" AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, ");
		sbSql.append("\n                          B.ITEM_CLASS4, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE, B.ORIGIN_TYPE ");
		sbSql.append("\n                     FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B, ");
		sbSql.append("\n                          ( ");
		sbSql.append("\n                          SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
		sbSql.append("\n                            FROM FMP_OTCUST_PRICE_AVA_V ");
		sbSql.append("\n                           WHERE UPJANG = ");
		sbSql.append("\n                                 ( ");
		sbSql.append("\n                                 SELECT OTCUST_PRICE_UPJANG ");
		sbSql.append("\n                                   FROM FMS_UPJANG ");
		sbSql.append("\n                                  WHERE UPJANG = "+strUpjang+" ");
		sbSql.append("\n                                 ) ");
		sbSql.append("\n                             AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
		sbSql.append("\n                           GROUP BY UPJANG, ITEM_CODE ");
		sbSql.append("\n                          ) C ");
		sbSql.append("\n                    WHERE A.ITEM_CODE = B.ITEM_CODE ");
		sbSql.append("\n                      AND A.UPJANG = C.UPJANG ");
		sbSql.append("\n                      AND A.SDATE = C.SDATE ");
		sbSql.append("\n                      AND A.ITEM_CODE = C.ITEM_CODE ");
		sbSql.append("\n                      AND A.SDATE = C.SDATE ");
		sbSql.append("\n                      AND A.SALE_PRICE > 0 ");
		sbSql.append("\n                      AND A.USE_YN = 'Y' ");
		sbSql.append("\n                 ) A, ");
		sbSql.append("\n                 ( ");        
		sbSql.append("\n                 SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL ");
		sbSql.append("\n                   FROM FMU_OP_RATE ");
		sbSql.append("\n                  WHERE UPJANG = "+strUpjang+" ");
		sbSql.append("\n                    AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE ");
		sbSql.append("\n                    AND USE_YN = 'Y' ");
		sbSql.append("\n                    AND ITEM_TYPE = 'M' ");
		sbSql.append("\n                 ) C, ");
		sbSql.append("\n                 ( ");        
		sbSql.append("\n                 SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL ");
		sbSql.append("\n                   FROM FMU_OP_RATE ");
		sbSql.append("\n                  WHERE UPJANG = "+strUpjang+" ");
		sbSql.append("\n                    AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN SDATE AND EDATE ");
		sbSql.append("\n                    AND USE_YN = 'Y' ");
		sbSql.append("\n                    AND ITEM_TYPE = 'C' ");
		sbSql.append("\n                 ) D ");
		sbSql.append("\n           WHERE A.ITEM_CODE = C.ITEM_CODE(+) ");
		sbSql.append("\n             AND A.ITEM_CLASS4 = D.ITEM_CODE(+) ");
		sbSql.append("\n         ) B ");
		sbSql.append("\n       , FMS_ITEM_V C ");
		sbSql.append("\n   WHERE A.ITEM_CODE = B.ITEM_CODE(+) ");
		sbSql.append("\n     AND A.ITEM_CODE = C.ITEM_CODE(+) ");
		sbSql.append("\n  	 AND A.UPJANG = '" + strUpjang + "' ");
		sbSql.append("\n     AND A.FAVOR_GROUP = '" + strFavorGroup + "' ");
		sbSql.append("\n   ORDER BY B.ITEM_CODE ");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_list"); //ds_list

		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_list);
		//this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
		DataSet ds_input     	= in_dl.get("ds_cond");
	
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strFavorGroup			= nullToBlank(ds_input.getString(0, "FAVOR_GROUP"));
		//String strMenuDate		= nullToBlank(ds_input.getString(0, "MENU_DATE"));
	

		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
		
		sbSql.append("\n  SELECT                                                                                                                                           ");
		sbSql.append("\n  	 M.UPJANG AS UPJANG                                                                                                                            ");
		sbSql.append("\n  	, FAVOR_GROUP AS FAVOR_GROUP                                                                                                                   ");
		sbSql.append("\n  	, M.ITEM_CODE AS ITEM_CODE                                                                                                                     ");
		sbSql.append("\n      , ITEM_NAME AS ITEM_NAME                                                                                                                     ");
		sbSql.append("\n  	, ITEM_SIZE AS ITEM_SIZE                                                                                                                       ");
		sbSql.append("\n      , PO_UOM AS PO_UOM                                                                                                                           ");
		sbSql.append("\n      , UNIT_PRICE                                                                                                                                 ");
		sbSql.append("\n      , ITEM_DESC                                                                                                                                  ");
		sbSql.append("\n  	, M.REMARK AS REMARK                                                                                                                           ");
		sbSql.append("\n  	, M.USE_YN AS USE_YN                                                                                                                           ");
		sbSql.append("\n    , M.CUSER AS CUSER                                                                                                                             ");
		sbSql.append("\n    , M.UUSER AS UUSER                                                                                                                             ");
		sbSql.append("\n    , '1' AS CHK                                                                                                                                   ");
		sbSql.append("\n   FROM FMP_FAVORITE M, (                                                                                                                          ");
		sbSql.append("\n   	  SELECT A.ITEM_CODE                                                                                                                           ");
		sbSql.append("\n  			 , A.ITEM_NAME                                                                                                                             ");
		sbSql.append("\n  			 , A.ITEM_SIZE                                                                                                                             ");
		sbSql.append("\n  			 , A.PO_UOM                                                                                                                                ");
		sbSql.append("\n  			 , A.TAX_CODE                                                                                                                              ");
		sbSql.append("\n  		     , DECODE(SIGN(NVL(B.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL), B.OP_PRICE) AS UNIT_PRICE	 -- 단가     ");
		sbSql.append("\n  			 , '' ITEM_DESC                                                                                                                            ");
		sbSql.append("\n  		  FROM FMU_OP_RATE B		 -- 운영 단가율 테이블                                                                                               ");
		sbSql.append("\n  		     ,(SELECT                                                                                                                                ");
		sbSql.append("\n  		              '" + strUpjang + "' AS UPJANG                                                                                                             ");
		sbSql.append("\n  		            , A.ITEM_CODE                                                                                                                    ");
		sbSql.append("\n  					, B.ITEM_NAME                                                                                                                          ");
		sbSql.append("\n  					, B.ITEM_SIZE                                                                                                                          ");
		sbSql.append("\n  					, B.PO_UOM                                                                                                                             ");
		sbSql.append("\n  		            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE                                                                ");
		sbSql.append("\n  		            , A.SALE_PRICE                                                                                                                   ");
		sbSql.append("\n  					, A.SDATE                                                                                                                              ");
		sbSql.append("\n  		         FROM HLDC_PO_ITEM_MST B                                                                                                             ");
		sbSql.append("\n  		            , HLDC_PO_PREORDER_LIST K                                                                                                        ");
		sbSql.append("\n  		            ,(SELECT A.CENTER_CODE                                                                                                           ");
		sbSql.append("\n  							 , A.UPJANG                                                                                                                        ");
		sbSql.append("\n  							 , A.ITEM_CODE                                                                                                                     ");
		sbSql.append("\n  		                     , SUM(A.SALE_PRICE) AS SALE_PRICE                                                                                       ");
		sbSql.append("\n  		                     , MAX(A.SDATE) AS SDATE                                                                                                 ");
		sbSql.append("\n  		                FROM (SELECT A.CENTER_CODE                                                                                                   ");
		sbSql.append("\n  							 		, A.UPJANG                                                                                                                     ");
		sbSql.append("\n  									, A.ITEM_CODE                                                                                                                  ");
		sbSql.append("\n  		                            , A.SALE_PRICE                                                                                                   ");
		sbSql.append("\n  		                            , A.CONTRACT_START AS SDATE                                                                                      ");
		sbSql.append("\n  		                        FROM HLDC_PO_CONTRACT_FSALE A                                                                                        ");
		sbSql.append("\n  		                           ,(SELECT                                                                                                          ");
		sbSql.append("\n  								   			A.CENTER_CODE                                                                                                            ");
		sbSql.append("\n  											, A.UPJANG                                                                                                                 ");
		sbSql.append("\n  											, A.ITEM_CODE                                                                                                              ");
		sbSql.append("\n  											, MAX(A.CONTRACT_START) AS CONTRACT_START                                                                                  ");
		sbSql.append("\n  		                              FROM HLDC_PO_CONTRACT_FSALE A                                                                                  ");
		sbSql.append("\n  		                              WHERE A.CENTER_CODE =                                                                                          ");
		sbSql.append("\n  									  		(SELECT A.CENTER_CODE                                                                                                    ");
		sbSql.append("\n  											 FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B                                                                            ");
		sbSql.append("\n  											 WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = '" + strUpjang + "')    ");
		sbSql.append("\n  		                                AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG A WHERE A.UPJANG = '" + strUpjang + "')                ");
		sbSql.append("\n  		                                AND A.ITEM_CODE > ' '                                                                                        ");
		//sbSql.append("\n  		                                AND A.CONTRACT_START <= TO_CHAR(SYSDATE, 'YYYYMMDD')                                                         ");
		sbSql.append("\n  		                              GROUP BY A.CENTER_CODE, A.UPJANG, A.ITEM_CODE) C                                                               ");
		sbSql.append("\n  		                       WHERE A.CENTER_CODE = C.CENTER_CODE                                                                                   ");
		sbSql.append("\n  		                         AND A.UPJANG = C.UPJANG                                                                                             ");
		sbSql.append("\n  		                         AND A.ITEM_CODE = C.ITEM_CODE                                                                                       ");
		sbSql.append("\n  		                         AND A.CONTRACT_START = C.CONTRACT_START ) A                                                                         ");
		sbSql.append("\n  		               GROUP BY A.CENTER_CODE, A.UPJANG, A.ITEM_CODE) A                                                                              ");
		sbSql.append("\n  		        WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                      ");
		sbSql.append("\n  		          AND A.CENTER_CODE = K.CENTER_CODE(+)                                                                                               ");
		sbSql.append("\n  		          AND A.ITEM_CODE = K.ITEM_CODE(+)                                                                                                   ");
		sbSql.append("\n  		       UNION ALL                                                                                                                             ");
		sbSql.append("\n  		       SELECT                                                                                                                                ");
		sbSql.append("\n  			   		  '" + strUpjang + "' AS UPJANG                                                                                                                 ");
		sbSql.append("\n  					, A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM                                                                                      ");
		sbSql.append("\n  		            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE                                                                ");
		sbSql.append("\n  		            , A.SALE_PRICE                                                                                                                   ");
		sbSql.append("\n  					, A.SDATE                                                                                                                              ");
		sbSql.append("\n  		         FROM FMP_OTCUST_ITEM B                                                                                                              ");
		sbSql.append("\n  		            ,(SELECT A.ITEM_CODE                                                                                                             ");
		sbSql.append("\n  		                   , SUM(A.SALE_PRICE) AS SALE_PRICE                                                                                         ");
		sbSql.append("\n  		                   , MAX(A.SDATE) AS SDATE                                                                                                   ");
		sbSql.append("\n  		                FROM (SELECT A.ITEM_CODE                                                                                                     ");
		sbSql.append("\n  		                           , A.SALE_PRICE                                                                                                    ");
		sbSql.append("\n  		                           , A.SDATE                                                                                                         ");
		sbSql.append("\n  		                        FROM FMP_OTCUST_PRICE_AVA_V A                                                                                              ");
		sbSql.append("\n  		                           ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE                                                                   ");
		sbSql.append("\n  		                               FROM FMP_OTCUST_PRICE_AVA_V                                                                                         ");
		sbSql.append("\n  		                              WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = '" + strUpjang + "')                            ");
		//sbSql.append("\n  		                                AND SDATE <= TO_CHAR(SYSDATE, 'YYYYMMDD')                                                                    ");
		sbSql.append("\n  		                              GROUP BY UPJANG, ITEM_CODE) C                                                                                  ");
		sbSql.append("\n  		                       WHERE A.UPJANG = C.UPJANG                                                                                             ");
		sbSql.append("\n  		                         AND A.ITEM_CODE = C.ITEM_CODE                                                                                       ");
		sbSql.append("\n  		                         AND A.SDATE  = C.SDATE ) A                                                                                          ");
		sbSql.append("\n  		               GROUP BY A.ITEM_CODE) A                                                                                                       ");
		sbSql.append("\n  		        WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                      ");
		sbSql.append("\n  		      ) A                                                                                                                                    ");
		sbSql.append("\n  		 WHERE A.UPJANG = B.UPJANG(+)                                                                                                                ");
		sbSql.append("\n  		   AND A.SDATE BETWEEN B.SDATE(+) AND B.EDATE(+)                                                                                             ");
		sbSql.append("\n  		   AND A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999'                                                                                                          ");
		sbSql.append("\n   ) V                                                                                                                                             ");
		sbSql.append("\n   WHERE                                                                                                                                           ");
		sbSql.append("\n  	   V.ITEM_CODE = M.ITEM_CODE                                                                                                                   ");
		sbSql.append("\n  	   AND M.UPJANG = '" + strUpjang + "'                                                                                                                     ");
		sbSql.append("\n                   AND M.FAVOR_GROUP = '" + strFavorGroup + "'                                                                                               ");

		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_list"); //ds_list

		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_list);
		//this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
