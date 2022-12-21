<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FSR00103V_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 레시피목록 및 보유수량 조회-레시피목록(상세)                                                                                                                                                 
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
			sbSql.append("     , B.ITEM_CODE \n");
			sbSql.append("     , G.ITEM_NAME \n");
			sbSql.append("     , G.ITEM_SIZE	 \n");
			sbSql.append("     , G.ORIGIN_NAT \n");
			sbSql.append("     , B.ITEM_SEQ \n");
			sbSql.append("     , B.NEED_QTY \n");
			sbSql.append("     , B.CUT_SPEC  --커팅규격 \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017' AND CODE = B.CUT_SPEC) CUT_SPEC_NAME \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("     , ROUND( B.NEED_QTY * (NVL(F.MARGIN_PRICE,0) / G.KG_CONVERT_RATE / 1000) ) AS ITEM_COST \n");
			}
			sbSql.append("  FROM FMR_STD_RECIPE_MST A \n");
			sbSql.append("     , FMR_STD_RECIPE_ITEM B \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("     , FMI_STD_PRICE F \n");
			}
			sbSql.append("     , ( \n");
			sbSql.append("         SELECT ITEM_CODE, \n");
			sbSql.append("                ITEM_NAME, \n");
			sbSql.append("                ORIGIN_NAT, \n");
			sbSql.append("                ITEM_SIZE, \n");
			sbSql.append("                KG_CONVERT_RATE \n");
			sbSql.append("           FROM HLDC_PO_ITEM_MST \n");
			sbSql.append("          WHERE ITEM_CLASS1 = 'F' \n");
			sbSql.append("       ) G \n");
			sbSql.append(" WHERE 1=1 \n");
			sbSql.append("   AND A.RECIPE_CLASS != 'H' \n");
			if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCuisineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCuisineType + "' \n");
			if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("   AND B.ITEM_CODE = G.ITEM_CODE \n");
			if (strPriceYN.equals("1"))
			{
				
				sbSql.append("   AND B.ITEM_CODE = F.ITEM_CODE(+) \n");
			}
			sbSql.append("ORDER BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE,A.RECIPE_CD,B.ITEM_SEQ,B.ITEM_CODE \n");                                                                                                                                          
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
				rs.next();
				
				strSubinvCode = rs.getString("SUBINV_CODE_IN");
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
			sbSql.append("     , B.ITEM_CODE \n");
			sbSql.append("     , G.ITEM_NAME \n");
			sbSql.append("     , B.NEED_QTY \n");
			sbSql.append("     , B.CUT_SPEC  --커팅규격 \n");
			sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017' AND CODE = B.CUT_SPEC) CUT_SPEC_NAME \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("     , ROUND( B.NEED_QTY * NVL(F.G_ITEM_PRICE,0) )  AS ITEM_COST \n");
			}
			sbSql.append("  FROM FSR_UPJANG_RECIPE_MST A \n");
			sbSql.append("     , FSR_UPJANG_RECIPE_ITEM B \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("     , ( \n");
				sbSql.append("       SELECT /*+ ORDERED USE_NL(B E F C A D) INDEX(C)*/ A.ITEM_CODE, \n");
				sbSql.append("              D.ITEM_NAME, \n");
				sbSql.append("              D.ITEM_SIZE, \n");
				sbSql.append("              D.PO_UOM, \n");
				sbSql.append("              A.CUSTCD, \n");
				sbSql.append("              DECODE(C.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 1) * (C.MARGIN_RATE+100) / 100 ) / 10) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (C.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) ) AS ITEM_PRICE,  --구매단가 \n");
				sbSql.append("              KG_CONVERT_RATE, \n");
				sbSql.append("              ROUND((DECODE(C.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 1) * (C.MARGIN_RATE+100) / 100 ) / 10) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (C.MARGIN_RATE+100) / 100 ) / 10) * 10 ) ) ) )/KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE, -- G단가 \n");
				sbSql.append("              F.UPJANG \n");
				sbSql.append("         FROM HLDC_ST_UPJANG B, \n");
				sbSql.append("              VO_SUBINVENTORY E, \n");
                sbSql.append("              VO_CENTER_UPJANG F, \n");
                sbSql.append("              HLDC_PO_TREAT_UPJANG C, \n");
                sbSql.append("              HLDC_PO_CONTRACT_F A, \n");
                sbSql.append("              HLDC_PO_ITEM_MST D \n");
				sbSql.append("        WHERE A.CENTER_CODE = C.CENTER_CODE \n");
				sbSql.append("          AND A.CUSTCD = C.CUSTCD \n");
				sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
				sbSql.append("          AND A.ITEM_CODE = D.ITEM_CODE \n");
				sbSql.append("          AND A.CENTER_CODE = F.CENTER_CODE \n");
				sbSql.append("          AND A.USE_YN = 'Y' \n");
				sbSql.append("          AND A.CONTRACT_PRICE > 0 \n");
				sbSql.append("          AND C.UPJANG = B.AP_UNITPRICE_UPJANG \n");
				sbSql.append("          AND B.UPJANG = E.UPJANG \n");
				sbSql.append("          AND C.USE_YN = 'Y' \n");
				sbSql.append("          AND B.AP_UNITPRICE_UPJANG = F.UPJANG \n");
				sbSql.append("          AND B.UPJANG = " + strUpjang + " \n");
				sbSql.append("          AND E.SUBINV_CODE  IN (" + strSubinvCode + ")  \n");
				sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
				sbSql.append("       ) F \n");
			}

			sbSql.append("     , ( \n");
			sbSql.append("         SELECT ITEM_CODE, \n");
			sbSql.append("                ITEM_NAME, \n");
			sbSql.append("                KG_CONVERT_RATE \n");
			sbSql.append("           FROM HLDC_PO_ITEM_MST \n");
			sbSql.append("          WHERE ITEM_CLASS1 = 'F' \n");
			sbSql.append("       ) G \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.HALL_CLASS = B.HALL_CLASS \n");
			sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			sbSql.append("   AND A.HALL_CLASS = '" + strHallClass + "' \n");
			if (strRecipeClass.length() != 0)	sbSql.append("   AND A.RECIPE_CLASS = '" + strRecipeClass + "' \n");
			if (strRecipeType.length() != 0)	sbSql.append("   AND A.RECIPE_TYPE = '" + strRecipeType + "' \n");
			if (strCuisineType.length() != 0)	sbSql.append("   AND A.CUISINE_TYPE = '" + strCuisineType + "' \n");
			if (strRecipeName.length() != 0)	sbSql.append("   AND A.RECIPE_NAME LIKE '%' || '" + strRecipeName + "' || '%' \n");
			sbSql.append("   AND A.RECIPE_CD = B.RECIPE_CD \n");
			sbSql.append("   AND B.ITEM_CODE = G.ITEM_CODE \n");
			if (strPriceYN.equals("1"))
			{
				sbSql.append("   AND B.ITEM_CODE = F.ITEM_CODE(+) \n");
			}
			sbSql.append("ORDER BY A.RECIPE_CLASS,A.RECIPE_TYPE,A.CUISINE_TYPE,A.RECIPE_CD,B.ITEM_SEQ,B.ITEM_CODE \n");
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