<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FSR00102V_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 레시피목록 및 보유수량 조회-레시피목록                                                                                                                                                 
■ 작성일자     : 2008.02.21                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008.02.21                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%     
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
		//FileLog.println("d:\\aaa.txt", ds_cond);                                                                                                                                                            
		                                                                                                                                                                                                      
	  	String strSType 			= nullToBlank(ds_input.getString(0, "STYPE"));                                                                                                                                                                                                        
		String strUpjang 			= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                           
		String strHallClass			= nullToBlank(ds_input.getString(0, "HALL_CLASS"));                                                                                                                          
		String strRecipeClass		= nullToBlank(ds_input.getString(0, "RECIPE_CLASS"));
		String strRecipeType		= nullToBlank(ds_input.getString(0, "RECIPE_TYPE"));
		String strCuisineType		= nullToBlank(ds_input.getString(0, "CUISINE_TYPE"));
		String strRecipeName		= nullToBlank(ds_input.getString(0, "RECIPE_NAME"));
		String strPriceYN			= nullToBlank(ds_input.getString(0, "PRICE_YN"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		if (strSType.equals("1"))
		{
			// 표준레시피                                                                                                                                                                       
			sbSql.delete(0, sbSql.length()); 
			sbSql.append("SELECT A.RECIPE_CLASS \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0001'AND CODE = A.RECIPE_CLASS) AS RECIPE_CLASS_NM \n");
			sbSql.append("     , A.RECIPE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0002'AND CODE = A.RECIPE_TYPE) AS RECIPE_TYPE_NM \n");
			sbSql.append("     , A.CUISINE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0003'AND CODE = A.CUISINE_TYPE) AS CUISINE_TYPE_NM \n");
			sbSql.append("     , A.RECIPE_CD \n");
			sbSql.append("     , A.RECIPE_NAME \n");
			sbSql.append("     , A.RECIPE_NAME || A.RECIPE_CD AS RECIPE_NAME2 \n");
			sbSql.append("     , A.MAIN_ITEM_CODE1 \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0006'AND CODE = A.MAIN_ITEM_CODE1) AS MAIN_ITEM_CODE1_NM \n");
			sbSql.append("     , A.RESP_NUT1 \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0004'AND CODE = A.RESP_NUT1) AS RESP_NUT1_NM \n");
			sbSql.append("     , A.RECIPE_SHAPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0008'AND CODE = A.RECIPE_SHAPE) AS RECIPE_SHAPE_NM \n");
			sbSql.append("     , A.RECIPE_TASTE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0009'AND CODE = A.RECIPE_TASTE) AS RECIPE_TASTE_NM \n");
			sbSql.append("     , A.RECIPE_FEEL \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0010'AND CODE = A.RECIPE_FEEL) AS RECIPE_FEEL_NM \n");
			sbSql.append("     , A.RECIPE_COLOR \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0007'AND CODE = A.RECIPE_COLOR) AS RECIPE_COLOR_NM \n");
			sbSql.append("     , A.RECIPE_TEMPER \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0011'AND CODE = A.RECIPE_TEMPER) AS RECIPE_TEMPER_NM \n");
			sbSql.append("     , A.CORE_TEMPER_YN \n");
			sbSql.append("     , DECODE(A.CORE_TEMPER_YN,'Y','예','N','아니오') AS CORE_TEMPER_YN_NM \n");
			sbSql.append("     , A.PHF \n");
			sbSql.append("     , DECODE(A.SPRING_YN,'Y','봄 ') || DECODE(A.SUMMER_YN,'Y','여름 ') || DECODE(A.AUTUMN_YN,'Y','가을 ') || DECODE(A.WINTER_YN,'Y','겨울') AS SEASON \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("     , SUM(ROUND( B.NEED_QTY * (NVL(F.MARGIN_PRICE,0) / G.KG_CONVERT_RATE / 1000) ) ) AS RECIPE_COST \n");
			}
			sbSql.append("  FROM FSR_STD_RECIPE_MST A \n");
			if( strPriceYN.equals("1") )
			{
				sbSql.append("     , FSR_STD_RECIPE_ITEM B \n");
				sbSql.append("     , FSI_STD_PRICE F \n");
				sbSql.append("     , ( \n");
				sbSql.append("         SELECT ITEM_CODE \n");
				sbSql.append("              , KG_CONVERT_RATE \n");
				sbSql.append("           FROM HLDC_PO_ITEM_MST \n");
				sbSql.append("          WHERE ITEM_CLASS1 = 'F' \n");
				sbSql.append("       ) G \n");
			}
			sbSql.append(" WHERE 1=1 \n");
			if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCuisineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCuisineType + "' \n");
			if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = F.ITEM_CODE(+) \n");
				sbSql.append("   AND B.ITEM_CODE = G.ITEM_CODE \n");
				sbSql.append("GROUP BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE,A.RECIPE_CD,A.RECIPE_NAME  \n");
				sbSql.append("		,A.MAIN_ITEM_CODE1,A.RESP_NUT1,A.RECIPE_SHAPE,A.RECIPE_TASTE,A.RECIPE_FEEL,A.RECIPE_COLOR,A.RECIPE_TEMPER,A.CORE_TEMPER_YN,A.PHF,A.SPRING_YN,A.SUMMER_YN,A.AUTUMN_YN,A.WINTER_YN \n");
			}
			sbSql.append("ORDER BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE,A.RECIPE_CD \n");                                                                                                                                          
		}
		else
		{
			String strSubinvCode = "";
			
			if (strPriceYN.equals("1"))
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT FSA_HALL_SUBINV_FUN(" + strUpjang + ", '" + strHallClass + "') AS SUBINV_CODE_IN FROM DUAL \n");
				
				//System.out.println(sbSelSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery(); 
				if( rs.next() )
				{
					strSubinvCode = rs.getString("SUBINV_CODE_IN");
					
					if( strSubinvCode.indexOf(",") > 0 )
					{
						String[] strSplit = strSubinvCode.split(",");
						String strTmp = "";

						for( int i = 0; i < strSplit.length; i++ )
						{
							strTmp += "'" + strSplit[i] + "',";
						}
						
						strSubinvCode = strTmp.substring(0, strTmp.length() - 1);
					}
					else
					{
						strSubinvCode = "'" + strSubinvCode + "'";
					}
				}
			}
			
			// 업장표준레시피
			sbSql.delete(0, sbSql.length()); 
			sbSql.append("SELECT A.RECIPE_CLASS \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0001'AND CODE = A.RECIPE_CLASS) AS RECIPE_CLASS_NM \n");
			sbSql.append("     , A.RECIPE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0002'AND CODE = A.RECIPE_TYPE) AS RECIPE_TYPE_NM \n");
			sbSql.append("     , A.CUISINE_TYPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0003'AND CODE = A.CUISINE_TYPE) AS CUISINE_TYPE_NM \n");
			sbSql.append("     , A.RECIPE_CD \n");
			sbSql.append("     , A.RECIPE_NAME \n");
			sbSql.append("     , A.RECIPE_NAME || A.RECIPE_CD AS RECIPE_NAME2 \n");
			sbSql.append("     , A.MAIN_ITEM_CODE1 \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0004'AND CODE = A.MAIN_ITEM_CODE1) AS MAIN_ITEM_CODE1_NM \n");
			sbSql.append("     , A.RESP_NUT1 \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0006'AND CODE = A.RESP_NUT1) AS RESP_NUT1_NM \n");
			sbSql.append("     , A.RECIPE_SHAPE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0008'AND CODE = A.RECIPE_SHAPE) AS RECIPE_SHAPE_NM \n");
			sbSql.append("     , A.RECIPE_TASTE \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0009'AND CODE = A.RECIPE_TASTE) AS RECIPE_TASTE_NM \n");
			sbSql.append("     , A.RECIPE_FEEL \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0010'AND CODE = A.RECIPE_FEEL) AS RECIPE_FEEL_NM \n");
			sbSql.append("     , A.RECIPE_COLOR \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0007'AND CODE = A.RECIPE_COLOR) AS RECIPE_COLOR_NM \n");
			sbSql.append("     , A.RECIPE_TEMPER \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE ='FS0011'AND CODE = A.RECIPE_TEMPER) AS RECIPE_TEMPER_NM \n");
			sbSql.append("     , A.CORE_TEMPER_YN \n");
			sbSql.append("     , DECODE(A.CORE_TEMPER_YN,'Y','예','아니오') AS CORE_TEMPER_YN_NM \n");
			sbSql.append("     , A.PHF \n");
			sbSql.append("     , DECODE(A.SPRING_YN,'Y','봄 ') || DECODE(A.SUMMER_YN,'Y','여름 ') || DECODE(A.AUTUMN_YN,'Y','가을 ') || DECODE(A.WINTER_YN,'Y','겨울') AS SEASON \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("     , SUM(ROUND( B.NEED_QTY * NVL(F.G_ITEM_PRICE,0) ) ) AS RECIPE_COST \n");
			}
			sbSql.append("  FROM FSR_UPJANG_RECIPE_MST A \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("     , FSR_UPJANG_RECIPE_ITEM B \n");
				sbSql.append("     , ( \n");
				sbSql.append("       SELECT /*+ ORDERED USE_NL(B E F A D) INDEX(A)*/ A.ITEM_CODE, \n");
				sbSql.append("              D.ITEM_NAME, \n");
				sbSql.append("              D.ITEM_SIZE, \n");
				sbSql.append("              D.PO_UOM, \n");
				sbSql.append("              A.CUSTCD, \n");
				sbSql.append("              DECODE(NVL(A.MARGIN_RATE, 0), 0, A.CONTRACT_PRICE, ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) AS ITEM_PRICE,  --구매단가 \n");
				sbSql.append("              KG_CONVERT_RATE, \n");
				sbSql.append("              ROUND(DECODE(NVL(A.MARGIN_RATE, 0), 0, A.CONTRACT_PRICE, ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) / KG_CONVERT_RATE / 1000, 2) AS G_ITEM_PRICE, -- G단가 \n");
				sbSql.append("              F.UPJANG \n");
				sbSql.append("         FROM HLDC_ST_UPJANG B, \n");
				sbSql.append("              HLDC_PO_SUBINVENTORY E, \n");
				sbSql.append("              HLDC_PO_UPJANG_CENTER F, \n");
				sbSql.append("              HLDC_PO_CONTRACT_F A, \n");
				sbSql.append("              HLDC_PO_ITEM_MST D \n");
				sbSql.append("        WHERE A.ITEM_CODE = D.ITEM_CODE \n");
				sbSql.append("          AND A.CENTER_CODE = F.CENTER_CODE \n");
				sbSql.append("          AND A.UPJANG = B.UPJANG \n");
				sbSql.append("          AND A.USE_YN = 'Y' \n");
				sbSql.append("          AND A.CONTRACT_PRICE > 0 \n");
				sbSql.append("          AND B.UPJANG = E.UPJANG \n");
				sbSql.append("          AND B.AP_UNITPRICE_UPJANG = F.UPJANG \n");
				sbSql.append("          AND B.UPJANG = " + strUpjang + " \n");
				sbSql.append("          AND E.SUBINV_CODE IN (" + strSubinvCode + ") \n");
				sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
				sbSql.append("       ) F \n");
			}
			sbSql.append(" WHERE A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.HALL_CLASS = '" + strHallClass + "' \n");
			if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCuisineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCuisineType + "' \n");
			if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("   AND A.UPJANG = B.UPJANG \n");
				sbSql.append("   AND A.HALL_CLASS = B.HALL_CLASS \n");
				sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
				sbSql.append("   AND B.ITEM_CODE = F.ITEM_CODE(+) \n");
				sbSql.append("GROUP BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE,A.RECIPE_CD,A.RECIPE_NAME \n");
				sbSql.append("		,A.MAIN_ITEM_CODE1,A.RESP_NUT1,A.RECIPE_SHAPE,A.RECIPE_TASTE,A.RECIPE_FEEL,A.RECIPE_COLOR,A.RECIPE_TEMPER,A.CORE_TEMPER_YN,A.PHF,A.SPRING_YN,A.SUMMER_YN,A.AUTUMN_YN,A.WINTER_YN \n");
			}
			sbSql.append("ORDER BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE,A.RECIPE_CD \n");
		}
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list"); 
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
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