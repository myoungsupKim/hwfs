<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/상품별거래유형별실적조회
//■ 프로그램ID   : FMP00723V_T001.jsp
//■ 프로그램명   : 상품별거래유형별실적조회
//■ 작성일자     : 2008.01.31
//■ 작성자       : 노규완
//■ 이력관리     : 2022.02.18
//            1.상품별거래유형별실적조회 화면 추가
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
/***		
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
				sbSql_tmp.append("            		KEYWORD LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
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
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtcustcd = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSubinv_Code = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));		
		String sChkSum = nullToBlank(ds_cond.getString(0, "CHKSUM"));
		String schOrderType = nullToBlank(ds_cond.getString(0, "SCH_ORDER_TYPE"));
// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
	
		//내역조회
		//공급업체가 한화(OTCUSTCD = '0000')일 경우.	*************************************************************************************************		
			if (sOtcustcd.equals("0000")){
				
				
				sbSql.append( "       SELECT  SUBSTR(T.TRANS_DATE,1,4)||'-'||SUBSTR(T.TRANS_DATE,5,2)||'-'||SUBSTR(T.TRANS_DATE,7,2) TRANS_DATE \n");
				sbSql.append( "                ,ITEM_CODE, E.WIN_ITEM_CD \n");
				sbSql.append( "             ,ITEM_NAME \n");
				sbSql.append( "             ,ITEM_SIZE \n");
				sbSql.append( "             ,PO_UOM \n");
				//sbSql.append( "             ,SUM(NVL(OP_PRICE,0)) AS OP_PRICE  \n");
				//sbSql.append( "             ,ROUND(AVG(NVL(OP_PRICE,0))) AS OP_PRICE  \n");
				//sbSql.append( "             ,ROUND(SUM(ROUND(OP_PRICE * PR_QTY))/SUM(NVL(PR_QTY,0))) AS OP_PRICE  \n");
				sbSql.append( "				,DECODE(SUM(NVL(PR_QTY,0)), 0, 0, ROUND(SUM(ROUND(OP_PRICE * PR_QTY))/SUM(NVL(PR_QTY,0)))) AS OP_PRICE		\n");
				sbSql.append( "             ,SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
				sbSql.append( "             ,SUM(ROUND(OP_PRICE * PR_QTY)) AS IN_PRICE\n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY))) AS TAX_AMOUNT \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY))) AS IN_AMOUNT   \n");
				sbSql.append( "             ,TAX_CODE \n");
				/*원산지 추가 -> 20150528 김진희 매니저 요청*/
				sbSql.append( "       		,ORIGIN_TYPE \n");
				sbSql.append( "       		,ORDER_TYPE \n");
				sbSql.append( "       		,ORDER_TYPE_NM \n");
				sbSql.append( "       FROM ( \n");
				
					if (sChkSum.equals("Y")){
					    sbSql.append( " SELECT A.TRANS_DATE \n");  //#42709 필드 추가
					}
					else {
						sbSql.append( " SELECT NULL AS TRANS_DATE \n");  //#42709 필드 추가
					}
					sbSql.append( "       ,A.ITEM_CODE  \n"); 
					sbSql.append( "       ,A.ITEM_NAME  \n"); 
					sbSql.append( "       ,A.ITEM_SIZE  \n"); 
					sbSql.append( "       ,A.TRANS_UOM AS PO_UOM  	\n"); 	
					sbSql.append( "       ,A.TAX_CODE  \n"); 
		            sbSql.append( "       ,A.TRANS_TYPE \n");
		            /*
		            sbSql.append( "       ,SUM(CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");              
	                sbSql.append( "              THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
	                sbSql.append( "              WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
	                sbSql.append( "              THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
	                sbSql.append( "              ELSE A.SALE_PRICE \n");
	                sbSql.append( "          END) AS OP_PRICE \n");
		            */
					//sbSql.append( "       ,MAX(DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)) AS OP_PRICE \n");
		            //상품별일때 MAX로 가져오면 계산식이 틀려서 상품별 금액별로 가져와야함
		            /*
		            if (sChkSum.equals("Y")){
		            	sbSql.append( "       ,MAX(DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)) AS OP_PRICE \n");
		            }else{
		            	sbSql.append( "       ,(DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)) AS OP_PRICE \n");	
		            }
		            */
		            sbSql.append( "       ,(DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)) AS OP_PRICE \n");
	                //sbSql.append( "       ,SUM(A.TRANS_QTY) AS PR_QTY \n");
	                sbSql.append( "       ,A.TRANS_QTY AS PR_QTY \n");
	                /*원산지 추가 -> 20150528 김진희 매니저 요청*/
	    			sbSql.append("     , A.ORIGIN_TYPE \n");
	                
	    			sbSql.append("     , ORDER_TYPE \n");
	    			sbSql.append("      ,   CASE WHEN ORDER_TYPE = 'S' THEN '일반' \n");
	    			sbSql.append("                WHEN ORDER_TYPE = '5' THEN '반환' \n");
	    			sbSql.append("                WHEN ORDER_TYPE = '6' THEN '교환' \n");
	    			sbSql.append("                WHEN ORDER_TYPE = '7' THEN '증정' \n");
	    			sbSql.append("               ELSE '기타' \n");
	    			sbSql.append("           END AS ORDER_TYPE_NM    \n");   /* 주문유형명 */
					sbSql.append( "  FROM (SELECT A.*, SUBSTR(NVL(RTN.PO_TYPE, 'S'), 1, 1)  AS ORDER_TYPE /* 판매구분 */ , B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMS_TRANSACTION_RTN_V A LEFT OUTER JOIN SO_PR_RTN RTN \n");
					sbSql.append( "          ON   A.PR_ID   = RTN.PR_ID\n");
					sbSql.append( "         AND   A.PR_NUM  = RTN.PR_NUM, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
					/*
					sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
					sbSql.append( "       FROM FMU_OP_RATE A \n");
			        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
			        sbSql.append( "        AND A.USE_YN = 'Y' \n");
			        sbSql.append( "    ) C  \n");
			        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
			        sbSql.append( "       FROM FMU_OP_RATE A \n");
			        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
			        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
			        sbSql.append( "        AND A.USE_YN = 'Y' \n");
			        sbSql.append( "    ) D \n");
			        */			        
			        sbSql.append( "   WHERE (1=1) \n");
					sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
					sbSql.append( "   AND A.SUBINV_CODE LIKE 'S1%' \n");
					if ( !sUpjang.equals("")){								
						sbSql.append( "     AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
					}				
					if ( !sSubinv_Code.equals("")){							
						sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
					}
					/*
					sbSql.append( "   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");  
					sbSql.append( "   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
					sbSql.append( "   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
					sbSql.append( "   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
					*/
					if ( !sSdate.equals("") && !sEdate.equals("")){
						sbSql.append( "    AND A.TRANS_DATE2 BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
					}
					
					/* 검색 조건 : 판매구분 */
					if(!schOrderType.equals("")){
						sbSql.append( "AND ORDER_TYPE LIKE '"+schOrderType+"' || '%' \n");
					}
					
					if ( !nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals("")) {
						sbSql.append("   AND (		\n");
/***					
						for(int i=0; i<strKeyword_ItemName.length; i++) {
							sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
							sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
							if(i < strKeyword_ItemName.length-1) {
								sbSql.append("  OR \n");
							}
						}
***/	
						String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
						for(int i=0; i<arrSameWord_tmp.length; i++) {
							if (arrSameWord_tmp[i].indexOf("F") == 0 ) {
								sbSql.append("            		A.ITEM_CODE LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
							} else {
								sbSql.append("            		A.ITEM_NAME LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
							}
							
							if(i < arrSameWord_tmp.length-1) {
								sbSql.append("  		OR 															  \n");
							}
						}

						sbSql.append("   	 ) \n");
						//sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");

					}
					
					if (sChkSum.equals("Y")){
						//sbSql.append( " GROUP BY A.TRANS_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.TRANS_TYPE, A.ORIGIN_TYPE  \n");    //#42709 필드 추가
					}
					else {
						//sbSql.append( " GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.TRANS_TYPE, A.ORIGIN_TYPE, DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) \n");    //#42709 필드 추가
					}
				sbSql.append( " ) T, EPROCUSR.ESMMTGL E   WHERE T.ITEM_CODE = E.ITEM_CD(+) AND E.SYS_ID(+) = '100'  \n");       
				sbSql.append( " GROUP BY TRANS_DATE, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX_CODE, ORIGIN_TYPE, E.WIN_ITEM_CD, ORDER_TYPE, ORDER_TYPE_NM ");       
			}		
		
			//공급업체가 <전체>(OTCUSTCD = '')일 경우.	*************************************************************************************************		
			else if (sOtcustcd.equals("")){	
				sbSql.append( "       SELECT  SUBSTR(T.TRANS_DATE,1,4)||'-'||SUBSTR(T.TRANS_DATE,5,2)||'-'||SUBSTR(T.TRANS_DATE,7,2) TRANS_DATE \n");
				sbSql.append( "                ,ITEM_CODE, E.WIN_ITEM_CD \n");
				sbSql.append( "             ,ITEM_NAME \n");
				sbSql.append( "             ,ITEM_SIZE \n");
				sbSql.append( "             ,PO_UOM \n");
				sbSql.append( "             ,SUM(NVL(OP_PRICE,0)) AS OP_PRICE  \n");
				sbSql.append( "             ,SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
				sbSql.append( "             ,SUM(ROUND(OP_PRICE * PR_QTY)) AS IN_PRICE\n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY))) AS TAX_AMOUNT \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY))) AS IN_AMOUNT   \n");
				sbSql.append( "             ,TAX_CODE \n");
				/*원산지 추가 -> 20150528 김진희 매니저 요청*/
				sbSql.append( "       		,ORIGIN_TYPE \n");
				sbSql.append( "       		,ORDER_TYPE \n");
				sbSql.append( "       		,ORDER_TYPE_NM \n");
				
				sbSql.append( "       FROM ( \n");
				
				if (sChkSum.equals("Y")){
					sbSql.append( "  SELECT A.TRANS_DATE \n");   //#42709 필드 추가
				}
				else {
					sbSql.append( "  SELECT NULL AS TRANS_DATE \n");   //#42709 필드 추가
				}
				
				sbSql.append( "       ,A.ITEM_CODE  \n"); 
				sbSql.append( "       ,A.ITEM_NAME  \n"); 
				sbSql.append( "       ,A.ITEM_SIZE  \n"); 
				sbSql.append( "       ,A.TRANS_UOM AS PO_UOM  	\n"); 	
				sbSql.append( "       ,A.TAX_CODE    \n"); 
	            sbSql.append( "       ,A.TRANS_TYPE \n");
	            /*
	            sbSql.append( "       ,SUM(CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");              
                sbSql.append( "              THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
                sbSql.append( "              WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
                sbSql.append( "              THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
                sbSql.append( "              ELSE A.SALE_PRICE \n");
                sbSql.append( "          END) AS OP_PRICE \n");
	            */
	            
	            if (sChkSum.equals("Y")){
	            	sbSql.append( "       ,MAX(DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)) AS OP_PRICE \n");
				}
				else {
					sbSql.append( "       ,(DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)) AS OP_PRICE \n");
				}
                
                sbSql.append("        ,SUM(A.TRANS_QTY) AS PR_QTY \n");
                
                /*원산지 추가 -> 20150528 김진희 매니저 요청*/
    			sbSql.append("     , A.ORIGIN_TYPE \n");
    			sbSql.append("     , ORDER_TYPE \n");
    			sbSql.append("     , CASE WHEN ORDER_TYPE = 'S' THEN '일반' \n");
    			sbSql.append("            WHEN ORDER_TYPE = '5' THEN '반환' \n");
    			sbSql.append("            WHEN ORDER_TYPE = '6' THEN '교환' \n");
    			sbSql.append("            WHEN ORDER_TYPE = '7' THEN '증정' \n");
    			sbSql.append("            ELSE '기타' \n");
    			sbSql.append("        END AS ORDER_TYPE_NM    \n");   /* 주문유형명 */
                
                sbSql.append( "  FROM (SELECT A.*, SUBSTR(NVL(RTN.PO_TYPE, 'S'), 1, 1)  AS ORDER_TYPE /* 판매구분 */ , B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMS_TRANSACTION_RTN_V A LEFT OUTER JOIN SO_PR_RTN RTN \n");
                sbSql.append( "          ON   A.PR_ID   = RTN.PR_ID \n");
                sbSql.append( "         AND   A.PR_NUM  = RTN.PR_NUM, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A  \n");
                /*
				sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
				sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
		        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) C  \n");
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
		        sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
		        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) D \n");
		        */
		        sbSql.append( "   WHERE (1=1) \n");
				sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				sbSql.append( "   AND A.SUBINV_CODE LIKE 'S1%' \n");
				if ( !sUpjang.equals("")){								
					sbSql.append( "     AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}
				/*
				sbSql.append( "   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");  
				sbSql.append( "   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				sbSql.append( "   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				sbSql.append( "   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
				*/
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( "    AND A.TRANS_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				
				/* 검색 조건 : 판매구분 */
				if(!schOrderType.equals("")){
					sbSql.append( "AND ORDER_TYPE LIKE '"+schOrderType+"' || '%' \n");
				}
				
				if ( !nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals("")) {
					sbSql.append("   AND (		\n");
/***				
					for(int i=0; i<strKeyword_ItemName.length; i++) {
						sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
						sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
						if(i < strKeyword_ItemName.length-1) {
							sbSql.append("  OR \n");
						}
					}
***/
					String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
					for(int i=0; i<arrSameWord_tmp.length; i++) {
						if ( arrSameWord_tmp[i].indexOf("F") == 0 ) {
							sbSql.append("            		A.ITEM_CODE LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
						} else {
							sbSql.append("            		A.ITEM_NAME LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");	
						}
						
						if(i < arrSameWord_tmp.length-1) {
							sbSql.append("  		OR 															  \n");
						}
					}

					sbSql.append("   	 ) \n");
					//sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
				}
				
				if (sChkSum.equals("Y")){
					sbSql.append( " GROUP BY A.TRANS_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.TRANS_TYPE, A.ORIGIN_TYPE, ORDER_TYPE   \n");    //#42709 필드 추가
				}
				else {
					sbSql.append( " GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.TRANS_TYPE, A.ORIGIN_TYPE, DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE), ORDER_TYPE  \n");    //#42709 필드 추가
				}
				
				sbSql.append( "  UNION ALL \n");     //UNION All*************************************************
				
				
				if (sChkSum.equals("Y")){
					sbSql.append( "  SELECT A.NEED_DATE AS TRANS_DATE \n");  //#42709 필드 추가
				}
				else {
					sbSql.append( "  SELECT NULL AS TRANS_DATE \n");  //#42709 필드 추가
				}
				
		        
				sbSql.append( "        ,A.ITEM_CODE \n");
				sbSql.append( "        ,A.ITEM_NAME \n");
				sbSql.append( "        ,A.ITEM_SIZE \n");
				sbSql.append( "        ,A.PO_UOM \n");
				sbSql.append( "		   ,A.TAX_CODE \n");
	            sbSql.append( "        ,'' AS TRANS_TYPE \n"); 
	            /*
				sbSql.append( "        ,SUM(CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");               
                sbSql.append( "              THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
                sbSql.append( "              WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
                sbSql.append( "              THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
                sbSql.append( "              ELSE A.SALE_PRICE \n");
                sbSql.append( "          END) AS OP_PRICE \n");
	            */
	            sbSql.append( "        ,SUM(A.OP_PRICE) AS OP_PRICE   \n");
		        sbSql.append( "        ,SUM(A.PR_QTY) AS PR_QTY   \n");  
				
		        /*원산지 추가 -> 20150528 김진희 매니저 요청*/
    			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
    			sbSql.append("     , ORDER_TYPE \n");
    			sbSql.append("     , CASE WHEN ORDER_TYPE = 'S' THEN '일반' \n");
    			sbSql.append("            WHEN ORDER_TYPE = '5' THEN '반환' \n");
    			sbSql.append("            WHEN ORDER_TYPE = '6' THEN '교환' \n");
    			sbSql.append("            WHEN ORDER_TYPE = '7' THEN '증정' \n");
    			sbSql.append("            ELSE '기타' \n");
    			sbSql.append("        END AS ORDER_TYPE_NM    \n");   /* 주문유형명 */
                
				sbSql.append( "  FROM (SELECT A.*, SUBSTR(NVL(RTN.PO_TYPE, 'S'), 1, 1)  AS ORDER_TYPE /* 판매구분 */ , B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A LEFT OUTER JOIN SO_PR_RTN RTN \n");
				sbSql.append( "          ON   A.PR_ID   = RTN.PR_ID \n");
				sbSql.append( "         AND   A.PR_NUM  = RTN.PR_NUM, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A  \n");
				/*
				sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
				sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
		        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) C  \n");
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
		        sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
		        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) D \n");
		        */		        
		        sbSql.append( "   WHERE (1=1) \n");
				sbSql.append( "   AND A.SUBINV_CODE LIKE 'S1%' \n");
				if ( !sUpjang.equals("")){								
					sbSql.append( "     AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}
				
				/* 검색 조건 : 판매구분 */
				if(!schOrderType.equals("")){
					sbSql.append( "AND ORDER_TYPE LIKE '"+schOrderType+"' || '%' \n");
				}
				/*
				sbSql.append( "   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");  
				sbSql.append( "   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				sbSql.append( "   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				sbSql.append( "   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
				*/
				sbSql.append( "   AND A.LINE_STATUS <> '003' \n");
				
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}	
				
				if ( !nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals("")) {
					sbSql.append("   AND (		\n");
/***				
					for(int i=0; i<strKeyword_ItemName.length; i++) {
						sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
						sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
						if(i < strKeyword_ItemName.length-1) {
							sbSql.append("  OR \n");
						}
					}
***/
					String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
					for(int i=0; i<arrSameWord_tmp.length; i++) {
						if ( arrSameWord_tmp[i].indexOf("F") == 0 ) {
							sbSql.append("            		A.ITEM_CODE LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
						} else {
							sbSql.append("            		A.ITEM_NAME LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
						}
						
						if(i < arrSameWord_tmp.length-1) {
							sbSql.append("  		OR 															  \n");
						}
					}

					sbSql.append("   	 ) \n");
					//sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
				}
				
				if (sChkSum.equals("Y")){											
					sbSql.append( "   GROUP BY A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.SALE_PRICE, A.ORIGIN_TYPE,A.TAX_CODE, ORDER_TYPE  \n");  //#42709 필드 추가
					sbSql.append( "      ) T , EPROCUSR.ESMMTGL E WHERE T.ITEM_CODE = E.ITEM_CD(+) AND E.SYS_ID(+) = '100' \n");
					sbSql.append(" GROUP BY TRANS_DATE, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, ORIGIN_TYPE,TAX_CODE, E.WIN_ITEM_CD, ORDER_TYPE ,ORDER_TYPE_NM  \n");  //#42709 필드 추가
				}
				else {
					sbSql.append( "   GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.SALE_PRICE, A.ORIGIN_TYPE,A.TAX_CODE, ORDER_TYPE \n");  //#42709 필드 추가
					sbSql.append( "      ) T , EPROCUSR.ESMMTGL E WHERE T.ITEM_CODE = E.ITEM_CD(+) AND E.SYS_ID(+) = '100' \n");
					sbSql.append(" GROUP BY TRANS_DATE, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, ORIGIN_TYPE,TAX_CODE, E.WIN_ITEM_CD, ORDER_TYPE ,ORDER_TYPE_NM  \n");  //#42709 필드 추가
				}
			}				
			//공급업체가 한화 를 제외 한 경우.	*********************************************************************************************************		
			else{
				sbSql.append( "       SELECT  SUBSTR(TRANS_DATE,1,4)||'-'||SUBSTR(TRANS_DATE,5,2)||'-'||SUBSTR(TRANS_DATE,7,2) TRANS_DATE \n");
				sbSql.append( "                ,ITEM_CODE, E.WIN_ITEM_CD \n");
				sbSql.append( "             ,ITEM_NAME \n");
				sbSql.append( "             ,ITEM_SIZE \n");
				sbSql.append( "             ,PO_UOM \n");
				sbSql.append( "             ,SUM(NVL(OP_PRICE,0)) AS OP_PRICE  \n");
				sbSql.append( "             ,SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
				sbSql.append( "             ,SUM(ROUND(OP_PRICE * PR_QTY)) AS IN_PRICE\n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY))) AS TAX_AMOUNT \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY))) AS IN_AMOUNT   \n");
				sbSql.append( "             ,TAX_CODE \n");
				/*원산지 추가 -> 20150528 김진희 매니저 요청*/
				sbSql.append( "       		,ORIGIN_TYPE \n");
				sbSql.append( "       		,ORDER_TYPE \n");
				sbSql.append( "       		,ORDER_TYPE_NM \n");
				
				sbSql.append( "       FROM ( \n");
					
					if (sChkSum.equals("Y")){
						sbSql.append( "  SELECT A.NEED_DATE AS TRANS_DATE \n");  //#42709 필드 추가
					}
					else {
						sbSql.append( "  SELECT NULL AS TRANS_DATE \n");  //#42709 필드 추가
					}
					
		        
					sbSql.append( "    ,A.ITEM_CODE  \n");
			        sbSql.append( "    ,A.ITEM_NAME  \n");
			        sbSql.append( "    ,A.ITEM_SIZE  \n");
			        sbSql.append( "    ,A.PO_UOM \n");
			        sbSql.append( "    ,A.TAX_CODE \n");
			        sbSql.append( "    ,'' AS TRANS_TYPE   \n");
			        /*
			        sbSql.append( "    ,SUM(CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL      \n");         
			        sbSql.append( "               THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE)  \n");
			        sbSql.append( "               WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL               \n");
			        sbSql.append( "               THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			        sbSql.append( "               ELSE A.SALE_PRICE \n");
			        sbSql.append( "           END) AS OP_PRICE                               \n");
			        */
			        sbSql.append( "    ,SUM(A.OP_PRICE) AS OP_PRICE   \n");
			        sbSql.append( "    ,SUM(A.PR_QTY) AS PR_QTY \n");
					
			        /*원산지 추가 -> 20150528 김진희 매니저 요청*/
	    			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			        
	    			sbSql.append("     , ORDER_TYPE \n");
	    			sbSql.append("     , CASE WHEN ORDER_TYPE = 'S' THEN '일반' \n");
	    			sbSql.append("            WHEN ORDER_TYPE = '5' THEN '반환' \n");
	    			sbSql.append("            WHEN ORDER_TYPE = '6' THEN '교환' \n");
	    			sbSql.append("            WHEN ORDER_TYPE = '7' THEN '증정' \n");
	    			sbSql.append("            ELSE '기타' \n");
	    			sbSql.append("        END AS ORDER_TYPE_NM    \n");   /* 주문유형명 */
	    			
	    			sbSql.append( "  FROM (SELECT A.*, SUBSTR(NVL(RTN.PO_TYPE, 'S'), 1, 1)  AS ORDER_TYPE /* 판매구분 */ , B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A LEFT OUTER JOIN SO_PR_RTN RTN \n");
	    			sbSql.append( "          ON   A.PR_ID   = RTN.PR_ID  \n");
	    			sbSql.append( "         AND   A.PR_NUM  = RTN.PR_NUM, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A  \n");
					//sbSql.append( "  FROM FMP_OTCUST_PR A \n");
					/*
					sbSql.append( "  , (SELECT B.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
					sbSql.append( "       FROM FMU_OP_RATE A, FMS_ITEM_V B \n");
			        sbSql.append( "      WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			        sbSql.append( "        AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
			        sbSql.append( "        AND A.USE_YN = 'Y' \n");
			        sbSql.append( "    ) C  \n");
			        sbSql.append( "  , (SELECT B.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
			        sbSql.append( "       FROM FMU_OP_RATE A, FMS_ITEM_V B \n");
			        sbSql.append( "      WHERE A.ITEM_CODE = B.ITEM_CLASS4 \n");
			        sbSql.append( "        AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
			        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
			        sbSql.append( "        AND A.USE_YN = 'Y' \n");
			        sbSql.append( "    ) D \n");
			        */
			        sbSql.append( "   WHERE (1=1) \n");
					sbSql.append( "   AND A.SUBINV_CODE LIKE 'S1%' \n");
					if ( !sUpjang.equals("")){								
						sbSql.append( "     AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
					}				
					if ( !sSubinv_Code.equals("")){							
						sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
					}	
					if ( !sOtcustcd.equals("")){							
						sbSql.append( "     AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
					}
					
					/* 검색 조건 : 판매구분 */
					if(!schOrderType.equals("")){
						sbSql.append( "AND ORDER_TYPE LIKE '"+schOrderType+"' || '%' \n");
					}
					
					
					/*
					sbSql.append( "   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");  
					sbSql.append( "   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
					sbSql.append( "   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
					sbSql.append( "   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
					*/
					sbSql.append( "   AND A.LINE_STATUS <> '003' \n");
					
					if ( !sSdate.equals("") && !sEdate.equals("")){
						sbSql.append( " AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
					}
					
					if ( !nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals("")) {
						sbSql.append("   AND (		\n");
/***					
						for(int i=0; i<strKeyword_ItemName.length; i++) {
							sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
							sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i].replaceAll("'", "''") + "'||'%' \n");
							if(i < strKeyword_ItemName.length-1) {
								sbSql.append("  OR \n");
							}
						}
***/
						String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
						for(int i=0; i<arrSameWord_tmp.length; i++) {
							sbSql.append("            		A.ITEM_NAME LIKE '%' || '"+arrSameWord_tmp[i].replaceAll("'", "''") +"' || '%'		  \n");
							if(i < arrSameWord_tmp.length-1) {
								sbSql.append("  		OR 															  \n");
							}
						}

						sbSql.append("   	 ) \n");
						//sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
					}
					
					if (sChkSum.equals("Y")){
						sbSql.append( "   GROUP BY A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM,A.SALE_PRICE, A.TAX_CODE, A.ORIGIN_TYPE, ORDER_TYPE \n");  //#42709 필드 추가
					}
					else {
						sbSql.append( "   GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM,A.SALE_PRICE, A.TAX_CODE, A.ORIGIN_TYPE, ORDER_TYPE \n");  //#42709 필드 추가
					}
					
					sbSql.append( "   ) T, EPROCUSR.ESMMTGL E WHERE T.ITEM_CODE = E.ITEM_CD(+) AND E.SYS_ID(+) = '100' \n");
					sbSql.append(" GROUP BY TRANS_DATE, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, ORIGIN_TYPE, TAX_CODE, E.WIN_ITEM_CD, ORDER_TYPE ,ORDER_TYPE_NM  \n");  //#42709 필드 추가
			}
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);
%>
