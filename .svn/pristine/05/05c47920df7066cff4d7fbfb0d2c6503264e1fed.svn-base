<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00400E_T002.jsp
■ 프로그램명   : 자재이력관리(저장)
■ 작성일자     : 2008-07-01
■ 작성자       : 박은규
■ 이력관리     : 2008-07-01 - 최초작성 박은규 CSR#(28344)
                2009-07-24 박은규 CSR#(29350) 요청자:김경운(구매지원팀)
                축산법률 규정변경에 따른 관리항목 변경
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_list  		= in_dl.get("ds_list");
		DataSet ds_input     	= in_dl.get("ds_input"); 
		
		String strCnterCode 		= nullToBlank(ds_input.getString(0, "CENTER_CODE"));                                                                                                                                                                                                        
		String strCustCD			= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String g_EmpNo 				= in_vl.getString("g_EmpNo");
		
		if(conn != null && !conn.isClosed()) conn.close();
				
		conn = getIRISConn();
		
		stmt 		= conn.createStatement();
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		// 2. HIST_ID유무에 따라 UPDATE/INSERT
		// 2.1 HIST_ID 유무체크
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT HIST_ID \n");
		sbSql.append("  FROM PO_ITEM_HIST \n");
		sbSql.append(" WHERE CENTER_CODE = '" +	strCnterCode + "' \n");
		sbSql.append("   AND CUSTCD      = '" +	strCustCD + "' \n");
		sbSql.append("   AND ITEM_CODE   = '" +	nullToBlank(ds_list.getString(0,"ITEM_CODE")) +"' \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery(); 
		
		if(rs.next())	// UPDATE
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE PO_ITEM_HIST \n");
			sbSql.append("SET ITEM_FEATURE = '"			+	nullToBlank(ds_list.getString(0,"ITEM_FEATURE"))			+"' \n");
			sbSql.append("	, NUT_INFO = '"			    +	nullToBlank(ds_list.getString(0,"NUT_INFO"))			    +"' \n");
			sbSql.append("	, MARKET_TREND = '"			+	nullToBlank(ds_list.getString(0,"MARKET_TREND"))			+"' \n");
			sbSql.append("	, DOCU_FILE1 = '"			+	nullToBlank(ds_list.getString(0,"DOCU_FILE1"))				+"' \n");
			sbSql.append("	, DOCU_FILE2 = '"			+	nullToBlank(ds_list.getString(0,"DOCU_FILE2"))				+"' \n");
			sbSql.append("	, DOCU_FILE3 = '"			+	nullToBlank(ds_list.getString(0,"DOCU_FILE3"))				+"' \n");
			sbSql.append("	, DOCU_FILE4 = '"			+	nullToBlank(ds_list.getString(0,"DOCU_FILE4"))				+"' \n");
			sbSql.append("	, DOCU_FILE5 = '"			+	nullToBlank(ds_list.getString(0,"DOCU_FILE5"))				+"' \n");
			sbSql.append("	, SDOCU_FILE1 = '"			+	nullToBlank(ds_list.getString(0,"SDOCU_FILE1"))				+"' \n");
			sbSql.append("	, SDOCU_FILE2 = '"			+	nullToBlank(ds_list.getString(0,"SDOCU_FILE2"))				+"' \n");
			sbSql.append("	, SDOCU_FILE3 = '"			+	nullToBlank(ds_list.getString(0,"SDOCU_FILE3"))				+"' \n");
			sbSql.append("	, SDOCU_FILE4 = '"			+	nullToBlank(ds_list.getString(0,"SDOCU_FILE4"))				+"' \n");
			sbSql.append("	, SDOCU_FILE5 = '"			+	nullToBlank(ds_list.getString(0,"SDOCU_FILE5"))				+"' \n");
			sbSql.append("	, SDOCU_FILE_SIZE1 = '"		+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE1"))		+"' \n");
			sbSql.append("	, SDOCU_FILE_SIZE2 = '"		+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE2"))		+"' \n");
			sbSql.append("	, SDOCU_FILE_SIZE3 = '"		+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE3"))		+"' \n");
			sbSql.append("	, SDOCU_FILE_SIZE4 = '"		+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE4"))		+"' \n");
			sbSql.append("	, SDOCU_FILE_SIZE5 = '"		+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE5"))		+"' \n");
			sbSql.append("	, APRV_YN = 'Y' \n");
			sbSql.append("	, USE_YN = 'Y' \n");
			//2008.12.18 박은규 : 원재료등급/생산년도/전처리작업일/세부원산지/부위명/개체식별번호/포장단위 추가
//============================================================================================
//(2009-07-24 추가) 시작
// 2009-07-24 박은규 CSR#(29350) 요청자:김경운(구매지원팀)
// 축산법률 규정변경에 따른 관리항목 변경
//============================================================================================
			sbSql.append("	, ORIGIN_QUALITY = '"		+	nullToBlank(ds_list.getString(0,"ORIGIN_QUALITY"))		    +"' \n");
			sbSql.append("	, ORIGIN_INFO = '"		    +	nullToBlank(ds_list.getString(0,"ORIGIN_INFO"))		        +"' \n");
			sbSql.append("	, PRODUCT_YEAR = '"		    +	nullToBlank(ds_list.getString(0,"PRODUCT_YEAR"))	        +"' \n");
			sbSql.append("	, BOXING_QTY = NVL('"		+	nullToBlank(ds_list.getString(0,"BOXING_QTY"))				+"',0) \n");
			sbSql.append("	, PREJOB_DATE = '"		    +	nullToBlank(ds_list.getString(0,"PREJOB_DATE"))				+"' \n");
			sbSql.append("	, PART_NAME = '"		    +	nullToBlank(ds_list.getString(0,"PART_NAME"))				+"' \n");
			sbSql.append("	, BLNUMBER = '"			    +	nullToBlank(ds_list.getString(0,"BLNUMBER"))				+"' \n");
			sbSql.append("	, ITEM_GRADE = '"			+	nullToBlank(ds_list.getString(0,"ITEM_GRADE"))				+"' \n");
			sbSql.append("	, IDNUMBER = '"			    +	nullToBlank(ds_list.getString(0,"IDNUMBER"))				+"' \n");
			sbSql.append("	, CONF_NUM = '"			    +	nullToBlank(ds_list.getString(0,"CONF_NUM"))				+"' \n");
			sbSql.append("	, BUTCH_NAME = '"			+	nullToBlank(ds_list.getString(0,"BUTCH_NAME"))				+"' \n");
			sbSql.append("	, ITEM_PRT_NAME = '"		+	nullToBlank(ds_list.getString(0,"ITEM_PRT_NAME"))			+"' \n");
			sbSql.append("	, MATERIAL_INFO = '"		+	nullToBlank(ds_list.getString(0,"MATERIAL_INFO"))			+"' \n");
			sbSql.append("	, LIFEDAY_INFO = '"			+	nullToBlank(ds_list.getString(0,"LIFEDAY_INFO"))			+"' \n");
			sbSql.append("	, KEEPING_METHOD = '"		+	nullToBlank(ds_list.getString(0,"KEEPING_METHOD"))			+"' \n");
			sbSql.append("	, ATTENTION_INFO = '"		+	nullToBlank(ds_list.getString(0,"ATTENTION_INFO"))			+"' \n");
			sbSql.append("	, IMPORT_NUM = '"			+	nullToBlank(ds_list.getString(0,"IMPORT_NUM"))				+"' \n");
			sbSql.append("	, PRODUCT_NAME = '"			+	nullToBlank(ds_list.getString(0,"PRODUCT_NAME"))			+"' \n");
//============================================================================================
//(2009-07-24 추가) 끝
//============================================================================================
			sbSql.append("	, UPDATE_DATE = SYSDATE \n");
			sbSql.append("	, UPDATE_BY = '" 		+ 	g_EmpNo + "' \n");
			sbSql.append(" WHERE CENTER_CODE = '" +	strCnterCode + "' \n");
			sbSql.append("   AND CUSTCD      = '" +	strCustCD + "' \n");
			sbSql.append("   AND ITEM_CODE   = '" +	nullToBlank(ds_list.getString(0,"ITEM_CODE")) +"' \n");
		}
		else							
		{
			// INSERT
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO PO_ITEM_HIST( \n");
			sbSql.append("	  HIST_ID \n");       		//1
			sbSql.append("	, CENTER_CODE \n");   		//2
			sbSql.append("	, CUSTCD \n");        		//3
			sbSql.append("	, ITEM_CODE \n");     		//4
			sbSql.append("	, ITEM_FEATURE \n");  		//5
			sbSql.append("	, NUT_INFO \n");      		//6
			sbSql.append("	, MARKET_TREND \n");  		//7
			sbSql.append("	, DOCU_FILE1 \n");    		//8
			sbSql.append("	, DOCU_FILE2 \n");    		//9
			sbSql.append("	, DOCU_FILE3 \n");    		//10
			sbSql.append("	, DOCU_FILE4 \n");    		//11
			sbSql.append("	, DOCU_FILE5 \n");    		//12
			sbSql.append("	, SDOCU_FILE1 \n");   		//13
			sbSql.append("	, SDOCU_FILE2 \n");   		//14
			sbSql.append("	, SDOCU_FILE3 \n");   		//15
			sbSql.append("	, SDOCU_FILE4 \n");   		//16
			sbSql.append("	, SDOCU_FILE5 \n");   		//17
			sbSql.append("	, SDOCU_FILE_SIZE1 \n");  	//18
			sbSql.append("	, SDOCU_FILE_SIZE2 \n");  	//19
			sbSql.append("	, SDOCU_FILE_SIZE3 \n");  	//20
			sbSql.append("	, SDOCU_FILE_SIZE4 \n");  	//21
			sbSql.append("	, SDOCU_FILE_SIZE5 \n");  	//22
			sbSql.append("	, APRV_YN \n");           	//23
			sbSql.append("	, USE_YN \n");            	//24
			//2008.12.18 박은규 : 원재료등급/생산년도/전처리작업일/세부원산지/부위명/개체식별번호/포장단위 추가
			sbSql.append("	, ORIGIN_QUALITY \n");    	//25
			sbSql.append("	, ORIGIN_INFO \n");       	//26
			sbSql.append("	, PRODUCT_YEAR \n");      	//27
			sbSql.append("	, BOXING_QTY \n");        	//28
			sbSql.append("	, PREJOB_DATE \n");       	//29
			sbSql.append("	, PART_NAME \n");         	//30
			sbSql.append("	, BLNUMBER \n");          	//31
			sbSql.append("	, ITEM_GRADE \n");        	//32
			sbSql.append("	, IDNUMBER \n");          	//33
			sbSql.append("	, CONF_NUM \n");          	//34
			sbSql.append("	, BUTCH_NAME \n");        	//35
			sbSql.append("	, ITEM_PRT_NAME \n");     	//36
			sbSql.append("	, MATERIAL_INFO \n");     	//37
			sbSql.append("	, LIFEDAY_INFO \n");      	//38
			sbSql.append("	, KEEPING_METHOD \n");    	//39
			sbSql.append("	, ATTENTION_INFO \n");    	//40
			sbSql.append("	, IMPORT_NUM \n");        	//41
			sbSql.append("	, PRODUCT_NAME \n");        //42
			sbSql.append("	, CREATE_DATE \n");			//43
			sbSql.append("	, CREATE_BY \n");			//44
			sbSql.append("	, UPDATE_DATE \n");			//45
			sbSql.append("	, UPDATE_BY \n");			//46
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	  PO_ITEM_HIST_S.NEXTVAL \n");
			sbSql.append("	, '"	+	strCnterCode												    + "' \n");
			sbSql.append("	, '"	+	strCustCD														+ "' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"ITEM_CODE"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"ITEM_FEATURE"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"NUT_INFO"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"MARKET_TREND"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"DOCU_FILE1"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"DOCU_FILE2"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"DOCU_FILE3"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"DOCU_FILE4"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"DOCU_FILE5"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE1"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE2"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE3"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE4"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE5"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE1"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE2"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE3"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE4"))	+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"SDOCU_FILE_SIZE5"))	+"' \n");
			sbSql.append("	, 'Y' 																			\n");
			sbSql.append("	, 'Y' 																			\n");
			//2008.12.18 박은규 : 원재료등급/생산년도/전처리작업일/세부원산지/부위명/개체식별번호/포장단위 추가
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"ORIGIN_QUALITY"))	    +"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"ORIGIN_INFO"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"PRODUCT_YEAR"))		+"' \n");
			sbSql.append("	, NVL('"		+	nullToBlank(ds_list.getString(0,"BOXING_QTY"))	+"',0) \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"PREJOB_DATE"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"PART_NAME"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"BLNUMBER"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"ITEM_GRADE"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"IDNUMBER"))			+"'	 \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"CONF_NUM"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"BUTCH_NAME"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"ITEM_PRT_NAME"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"MATERIAL_INFO"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"LIFEDAY_INFO"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"KEEPING_METHOD"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"ATTENTION_INFO"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"IMPORT_NUM"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_list.getString(0,"PRODUCT_NAME"))		+"' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append("	, '" + g_EmpNo + "' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append("	, '" + g_EmpNo + "' \n");
			sbSql.append(" ) \n");
		}
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		stmt.execute(sbSql.toString());
		
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
			conn.rollback();
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
			if(stmt != null) {
				try {
					stmt.close();
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