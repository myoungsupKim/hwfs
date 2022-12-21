<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/상품별 거래실적 조회
//■ 프로그램ID   : FMP00720V_T001.jsp
//■ 프로그램명   : 공급업체별 거래실적 조회
//■ 작성일자     : 2008.01.31
//■ 작성자       : 노규완
//■ 이력관리     : 2008.01.31
//            1.[추가수정] 변경번호(#42709)
//                     - 식재지원팀 김인영 팀장
//                     - 요청일 : 2011/05/30
//                     - 요청내용 : 본사/사업장 상품별 거래실적 조회 화면에 실제 상품의 입고일 
//                                필드를 추가 하여 사용자가 상품의 실제 입고일을 확인 할 수 있도록 요청.
//                                공급업체가 한화의 경우 : TRANS_DATE , 한화가 아닐 경우 : NEED_DATE
//                      ※화면단의 UI는 입고일 필드 및 데이터셋 필드만을 추가 하고, Query에 입고일 추가.
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

// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
	
		//내역조회
		//공급업체가 한화(OTCUSTCD = '0000')일 경우.	*************************************************************************************************		
			if (sOtcustcd.equals("0000")){
				if (sChkSum.equals("Y")){
				    sbSql.append( " SELECT SUBSTR(A.TRANS_DATE,1,4)||'-'||SUBSTR(A.TRANS_DATE,5,2)||'-'||SUBSTR(A.TRANS_DATE,7,2) TRANS_DATE \n");  //#42709 필드 추가
				}
				else {
					sbSql.append( " SELECT NULL AS TRANS_DATE \n");  //#42709 필드 추가
				}
				sbSql.append( "       ,A.ITEM_CODE \n");
				sbSql.append( "       ,A.ITEM_NAME \n");
				sbSql.append( "       ,A.ITEM_SIZE \n");
				sbSql.append( "       ,A.TRANS_UOM AS PO_UOM \n");				
				//sbSql.append( "       ,DECODE(NVL(B.OP_PRICE,0),0,ROUND((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100))),B.OP_PRICE) AS OP_PRICE \n");									  
                sbSql.append("        ,DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) AS OP_PRICE                                                                                                                                                                                                                                                                                                                          \n");
		        sbSql.append("        ,SUM(A.TRANS_QTY) AS PR_QTY                                                                                                                                                                                                                                                                                                                                                                                                                                            \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.TRANS_QTY)) AS IN_PRICE \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.TRANS_QTY))) AS TAX_AMOUNT \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 1.1, 1) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.TRANS_QTY))) AS IN_AMOUNT \n");
				sbSql.append( "  FROM PO_TRANSACTION@FCUS_TO_HLDC A, FMU_OP_RATE@FCUS_TO_FSUS B \n");
				sbSql.append( "   WHERE (1=1) \n");
				sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				sbSql.append( "   AND A.SUBINV_CODE LIKE 'S10%' \n");
				sbSql.append( "   AND A.TRANS_UPJANG = B.UPJANG(+) \n");
				if ( !sUpjang.equals("")){								
					sbSql.append( "     AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}								
				sbSql.append( "   AND A.TRANS_DATE BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
				sbSql.append( "   AND A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
				sbSql.append( "   AND B.USE_YN(+) = 'Y'\n");
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( "    AND A.TRANS_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				if (sChkSum.equals("Y")){
					sbSql.append( " GROUP BY A.TRANS_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE, B.CEIL_VAL \n");    //#42709 필드 추가
				}
				else {
					sbSql.append( " GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE, B.CEIL_VAL \n");    //#42709 필드 추가
				}
			}		
		
			//공급업체가 <전체>(OTCUSTCD = '')일 경우.	*************************************************************************************************		
			else if (sOtcustcd.equals("")){	
				if (sChkSum.equals("Y")){
					sbSql.append( "  SELECT SUBSTR(TRANS_DATE,1,4)||'-'||SUBSTR(TRANS_DATE,5,2)||'-'||SUBSTR(TRANS_DATE,7,2) AS TRANS_DATE \n");   //#42709 필드 추가
				}
				else {					
					sbSql.append( "  SELECT NULL AS TRANS_DATE \n");   //#42709 필드 추가
				}
				sbSql.append( "        ,ITEM_CODE \n");
				sbSql.append( "        ,ITEM_NAME \n");
				sbSql.append( "        ,ITEM_SIZE \n");
				sbSql.append( "        ,PO_UOM \n");
				sbSql.append( "        ,SUM(NVL(OP_PRICE,0)) AS OP_PRICE  \n");
				sbSql.append( "        ,SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
				sbSql.append( "        ,SUM(NVL(IN_PRICE,0)) AS IN_PRICE \n");
				sbSql.append( "        ,SUM(NVL(TAX_AMOUNT,0)) AS TAX_AMOUNT \n");
				sbSql.append( "        ,SUM(NVL(IN_AMOUNT,0)) AS IN_AMOUNT \n");				
				sbSql.append( " FROM (   \n");
				if (sChkSum.equals("Y")){
					sbSql.append( " SELECT A.TRANS_DATE \n");
				}
				else {
					sbSql.append( " SELECT NULL AS TRANS_DATE\n");
				}
				sbSql.append( "       ,A.ITEM_CODE  \n");
				sbSql.append( "       ,A.ITEM_NAME  \n");
				sbSql.append( "       ,A.ITEM_SIZE  \n");
				sbSql.append( "       ,A.TRANS_UOM AS PO_UOM \n");				
                sbSql.append("        ,DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) AS OP_PRICE                                                                                                                                                                                                                                                                                                                          \n");
		        sbSql.append("        ,SUM(A.TRANS_QTY) AS PR_QTY                                                                                                                                                                                                                                                                                                                                                                                                                                            \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.TRANS_QTY)) AS IN_PRICE \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.TRANS_QTY))) AS TAX_AMOUNT \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 1.1, 1) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.TRANS_QTY))) AS IN_AMOUNT \n");
				sbSql.append( "  FROM PO_TRANSACTION@FCUS_TO_HLDC A, FMU_OP_RATE@FCUS_TO_FSUS B \n");
				sbSql.append( "   WHERE (1=1) \n");
				sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				sbSql.append( "   AND A.SUBINV_CODE LIKE 'S10%' \n");
				sbSql.append( "   AND A.TRANS_UPJANG = B.UPJANG(+) \n");
				if ( !sUpjang.equals("")){								
					sbSql.append( "     AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}								
				sbSql.append( "   AND A.TRANS_DATE BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
				sbSql.append( "   AND A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
				sbSql.append( "   AND B.USE_YN(+) = 'Y'\n");
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.TRANS_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				if (sChkSum.equals("Y")){
					sbSql.append( " GROUP BY A.TRANS_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE, B.CEIL_VAL \n");  //#42709 필드 추가
				}
				else {
					sbSql.append( " GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE, B.CEIL_VAL \n");  //#42709 필드 추가
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
                sbSql.append("        ,DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) AS OP_PRICE                                                                                                                                                                                                                                                                                                                          \n");
		        sbSql.append("        ,SUM(A.PR_QTY) AS PR_QTY                                                                                                                                                                                                                                                                                                                                                                                                                                            \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.PR_QTY)) AS IN_PRICE \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.PR_QTY))) AS TAX_AMOUNT \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.PR_QTY))) AS IN_AMOUNT \n");
				sbSql.append( "    FROM FMP_OTCUST_PR@FCUS_TO_FSUS A, FMU_OP_RATE@FCUS_TO_FSUS B \n");
				sbSql.append( "   WHERE A.UPJANG = B.UPJANG(+) \n");
				if ( !sUpjang.equals("")){								
					sbSql.append( "     AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}				
				sbSql.append( "     AND A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
				sbSql.append( "     AND A.LINE_STATUS <> '003' \n");				
				sbSql.append( "     AND A.NEED_DATE BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}	
				if (sChkSum.equals("Y")){											
					sbSql.append( "   GROUP BY A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE, B.CEIL_VAL \n");  //#42709 필드 추가
					sbSql.append( "      )GROUP BY TRANS_DATE, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM  \n");  //#42709 필드 추가
				}
				else {
					sbSql.append( "   GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE, B.CEIL_VAL \n");  //#42709 필드 추가
					sbSql.append( "      )GROUP BY ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM  \n");  //#42709 필드 추가
				}
			}		
		
			//공급업체가 한화 를 제외 한 경우.	*********************************************************************************************************		
			else{
				if (sChkSum.equals("Y")){
					sbSql.append( "  SELECT SUBSTR(A.NEED_DATE,1,4)||'-'||SUBSTR(A.NEED_DATE,5,2)||'-'||SUBSTR(A.NEED_DATE,7,2) AS TRANS_DATE \n");  //#42709 필드 추가					
				}
				else {
				sbSql.append( "  SELECT NULL AS TRANS_DATE \n");  //#42709 필드 추가
				}
				sbSql.append( "        ,A.ITEM_CODE \n");
				sbSql.append( "        ,A.ITEM_NAME \n");
				sbSql.append( "        ,A.ITEM_SIZE \n");
				sbSql.append( "        ,A.PO_UOM \n");
                sbSql.append("        ,DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) AS OP_PRICE                                                                                                                                                                                                                                                                                                                          \n");
		        sbSql.append("        ,SUM(A.PR_QTY) AS PR_QTY                                                                                                                                                                                                                                                                                                                                                                                                                                            \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.PR_QTY)) AS IN_PRICE \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.PR_QTY))) AS TAX_AMOUNT \n");
		        sbSql.append("        ,SUM(ROUND(DECODE(A.TAX_CODE, '100', 1.1, 1) * ROUND(DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100), B.CEIL_VAL),B.OP_PRICE) * A.PR_QTY))) AS IN_AMOUNT \n");
				sbSql.append( "    FROM FMP_OTCUST_PR@FCUS_TO_FSUS A, FMU_OP_RATE@FCUS_TO_FSUS B \n");
				sbSql.append( "   WHERE A.UPJANG = B.UPJANG(+) \n");
				if ( !sUpjang.equals("")){								
					sbSql.append( "     AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
				}
				if ( !sOtcustcd.equals("")){							
					sbSql.append( "     AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
				}				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}				
				sbSql.append( "     AND A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
				sbSql.append( "     AND A.LINE_STATUS <> '003' \n");				
				sbSql.append( "     AND A.NEED_DATE BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				if (sChkSum.equals("Y")){
					sbSql.append( "   GROUP BY A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE, B.CEIL_VAL \n");  //#42709 필드 추가
				}
				else {
					sbSql.append( "   GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, B.OP_PRICE, A.SALE_PRICE, B.OP_RATE \n");  //#42709 필드 추가
				}
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
