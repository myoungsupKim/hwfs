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
//               4.입고일 기준 선택 조회 기능 추가(#CH201109_00074)
//                 - 식재영업2팀 : 이재웅
//                 - 요청일 : 2011/08/24
//                 - 요청내용 : 입고일 기준으로 선택 가능하게 조회 기능 추가 요청 
//-----------------------------------------------------------------------------*/
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
		String sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtcustcd = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSubinv_Code = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));		
		String sTax = nullToBlank(ds_cond.getString(0, "TAX_CODE"));
		String sItemName = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		String sFavor_Group = nullToBlank(ds_cond.getString(0, "FAVOR_GROUP"));
		String sChk_Date = nullToBlank(ds_cond.getString(0, "CHK_DATE"));

		//내역조회
		if (sOtcustcd.equals(""))
		{
			sbSql.append( "SELECT UPJANGNM_DISP \n");
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{
				sbSql.append( "     , TRANS_DATE  \n");  //#42709 필드 추가
				sbSql.append( "     , UPJANG  \n");				
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( "     , UPJANG  \n");				
			}			
			sbSql.append( "     , ITEM_CODE \n");				        
			sbSql.append( "     , ITEM_NAME \n");
			sbSql.append( "     , ITEM_SIZE \n");
			sbSql.append( "     , PO_UOM, TAX_CODE \n");
			sbSql.append( "     , SUM(NVL(SALE_PRICE,0)) AS SALE_PRICE  \n");
			sbSql.append( "     , SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
			sbSql.append( "     , SUM(NVL(IN_PRICE,0)) AS IN_PRICE \n");
			sbSql.append( "     , SUM(NVL(TAX_AMOUNT,0)) AS TAX_AMOUNT \n");
			sbSql.append( "     , SUM(NVL(IN_AMOUNT,0)) AS IN_AMOUNT \n");				
			sbSql.append( "  FROM \n");
			sbSql.append( "( \n");
		}
		if (sOtcustcd.equals("") || sOtcustcd.equals("0000"))		
		{			
			sbSql.append( "SELECT C.UPJANGNM_DISP \n");
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{
				sbSql.append( "     , SUBSTR(A.TRANS_DATE,1,4)||'-'||SUBSTR(A.TRANS_DATE,5,2)||'-'||SUBSTR(A.TRANS_DATE,7,2) AS TRANS_DATE \n");  //#42709 필드 추가
				sbSql.append( "     , A.TRANS_UPJANG AS UPJANG \n");
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( "     , A.TRANS_UPJANG AS UPJANG \n");				
			}			
			
			sbSql.append( "     , A.ITEM_CODE \n");
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , A.TRANS_UOM AS PO_UOM \n");				
			sbSql.append( "     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS SALE_PRICE \n");			
			sbSql.append( "     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS PR_QTY \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) AS IN_PRICE \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS TAX_AMOUNT \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS IN_AMOUNT \n");				
			sbSql.append( "  FROM PO_TRANSACTION@FCUS_TO_HLDC A,  FMS_UPJANG@FCUS_TO_FSUS C \n");
			sbSql.append( " WHERE A.TRANS_UPJANG = C.UPJANG");
			sbSql.append( "   AND A.TRANS_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append( "   AND A.SUBINV_CODE LIKE 'S10%' \n");
			if ( !sMainUpjang.equals(""))
				sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");			
			if ( !sUpjang.equals(""))								
				sbSql.append( "   AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			if ( !sSubinv_Code.equals(""))							
				sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			if ( !sTax.equals(""))							
				sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
			if ( !sItemName.equals(""))							
				sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
			if ( !sFavor_Group.equals(""))
				sbSql.append( "   AND A.ITEM_CODE IN (SELECT ITEM_CODE FROM FMP_FAVORITE WHERE UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' AND FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "') \n");

			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{
				sbSql.append( " GROUP BY A.TRANS_DATE, A.TRANS_UPJANG, C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE \n");   //#42709 필드 추가
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( " GROUP BY A.TRANS_UPJANG, C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE \n");   //#42709 필드 추가				
			}
		}
		if (sOtcustcd.equals(""))		
			sbSql.append( "  UNION ALL \n");
		if (sOtcustcd.equals("") || (! sOtcustcd.equals("0000")))		
		{			
			sbSql.append( "SELECT C.UPJANGNM_DISP \n");			
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{
				sbSql.append( "     , SUBSTR(A.NEED_DATE,1,4)||'-'||SUBSTR(A.NEED_DATE,5,2)||'-'||SUBSTR(A.NEED_DATE,7,2) AS TRANS_DATE  \n");  //#42709 필드 추가
				sbSql.append( "     , A.UPJANG  \n");
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( "     , A.UPJANG  \n");				
			}			
			sbSql.append( "     , A.ITEM_CODE \n");
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , A.PO_UOM \n");
			sbSql.append( "     , DECODE(A.TAX_CODE,'100''과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS  SALE_PRICE \n");			
			sbSql.append( "     , ROUND(SUM(A.PR_QTY)) AS PR_QTY \n");
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) AS IN_PRICE \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY)))  AS TAX_AMOUNT \n");				
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY))) AS IN_AMOUNT \n");				
			sbSql.append( "  FROM FMP_OTCUST_PR@FCUS_TO_FSUS A, FMS_UPJANG@FCUS_TO_FSUS C \n");			
			sbSql.append( " WHERE A.UPJANG = C.UPJANG" );
			sbSql.append( "   AND A.NEED_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			if ( !sMainUpjang.equals(""))
				sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");
			if ( !sUpjang.equals(""))								
				sbSql.append( "   AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			if ( !sSubinv_Code.equals(""))							
				sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			if (! sOtcustcd.equals(""))
				sbSql.append( "   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			if ( !sTax.equals(""))							
				sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
			if ( !sItemName.equals(""))							
				sbSql.append( "   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");			
			sbSql.append( "   AND A.LINE_STATUS <> '003' \n");
			if ( !sFavor_Group.equals(""))
				sbSql.append( "   AND A.ITEM_CODE IN (SELECT ITEM_CODE FROM FMP_FAVORITE WHERE UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' AND FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "') \n");
			
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{
				sbSql.append( " GROUP BY A.NEED_DATE, A.UPJANG,C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE \n");   //#42709 필드 추가
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( " GROUP BY A.UPJANG,C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE \n");   //#42709 필드 추가				
			}
		}			
		if (sOtcustcd.equals(""))
		{
			if (sChk_Date.equals("1"))  //입고일 포함하여 조회 시...
			{
				sbSql.append( ") GROUP BY TRANS_DATE, UPJANG, UPJANGNM_DISP, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX_CODE \n");  //#42709 필드 추가
			}
			else //입고일 제외하여 조회 시...
			{
				sbSql.append( ") GROUP BY UPJANG, UPJANGNM_DISP, ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, TAX_CODE \n");  //#42709 필드 추가				
			}			
		}			
			
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
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