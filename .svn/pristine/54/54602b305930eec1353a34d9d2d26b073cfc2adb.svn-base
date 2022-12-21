<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/상품별 거래실적 조회
//■ 프로그램ID   : FMP00780V_T001.jsp
//■ 프로그램명   : 상품 그룹별 거래실적 조회
//■ 작성일자     : 2010.12.22
//■ 작성자       : 노규완
//■ 이력관리     : 
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
		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
		
		if(!nullToBlank(ds_cond.getString(0, "ITEM_NAME")).equals(""))
		{
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
			String[] arrSameWord_tmp = nullToBlank(ds_cond.getString(0, "ITEM_NAME")).split(" ");
			
			sbSql_tmp.setLength(0);
            sbSql_tmp.append("/* fm/fmp/FMP00780V_T001.jsp */                                                 \n");
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
		String sFavorName = nullToBlank(ds_cond.getString(0, "FAVOR_NAME"));

		//내역조회
		if (sOtcustcd.equals(""))
		{
			sbSql.append( "SELECT T.UPJANG  \n");
			sbSql.append( "     , T.UPJANGNM_DISP \n");
			sbSql.append( "     , M.FAVOR_GROUP \n");
			sbSql.append( "     , N.FAVOR_NAME \n");	 		
			sbSql.append( "     , T.ITEM_CODE \n");				        
			sbSql.append( "     , T.ITEM_NAME \n");
			sbSql.append( "     , T.ITEM_SIZE \n");
			sbSql.append( "     , T.ORIGIN_TYPE \n");
			sbSql.append( "     , T.PO_UOM, T.TAX_CODE \n");
			sbSql.append( "     , SUM(NVL(T.SALE_PRICE,0)) AS SALE_PRICE  \n");
			sbSql.append( "     , SUM(NVL(T.PR_QTY,0)) AS PR_QTY \n");
			sbSql.append( "     , SUM(NVL(T.IN_PRICE,0)) AS IN_PRICE \n");
			sbSql.append( "     , SUM(NVL(T.TAX_AMOUNT,0)) AS TAX_AMOUNT \n");
			sbSql.append( "     , SUM(NVL(T.IN_AMOUNT,0)) AS IN_AMOUNT \n");				
			sbSql.append( "  FROM \n");
			sbSql.append( "( \n");
		}
		if (sOtcustcd.equals("") || sOtcustcd.equals("0000"))		
		{
			sbSql.append( "SELECT A.TRANS_UPJANG AS UPJANG \n");
			sbSql.append( "     , C.UPJANGNM_DISP \n");		
			sbSql.append( "     , '"+sFavorName+"' AS FAVOR_NAME \n");	
			sbSql.append( "     , A.ITEM_CODE \n");
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , B.ORIGIN_TYPE \n");
			sbSql.append( "     , A.TRANS_UOM AS PO_UOM \n");				
			sbSql.append( "     , DECODE(A.TAX_CODE,'100','과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS SALE_PRICE \n");			
			sbSql.append( "     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS PR_QTY \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) AS IN_PRICE \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS TAX_AMOUNT \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_PRICE * A.TRANS_QTY)) + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.TRANS_QTY)))  AS IN_AMOUNT \n");				
			sbSql.append( "  FROM FMS_TRANSACTION_V A,  HLDC_PO_ITEM_MST B, FMS_UPJANG C \n");
			sbSql.append( " WHERE A.TRANS_UPJANG = C.UPJANG");
			sbSql.append( "   AND A.ITEM_CODE = B.ITEM_CODE");
			sbSql.append( "   AND A.TRANS_DATE BETWEEN '" + sSdate + "' AND '" + sEdate + "' \n");
			sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append( "   AND A.SUBINV_CODE LIKE 'S1%' \n");
			if ( !sMainUpjang.equals(""))
				sbSql.append( "   AND C.MAIN_UPJANG = '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");			
			if ( !sUpjang.equals(""))								
				sbSql.append( "   AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
			if ( !sSubinv_Code.equals(""))							
				sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			if ( !sTax.equals(""))							
				sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
			
			
			
			if ( !sItemName.equals("")) {		
				sbSql.append("   AND (		\n");
				
				for(int i=0; i<strKeyword_ItemName.length; i++) {
					sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
					sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
					if(i < strKeyword_ItemName.length-1) {
						sbSql.append("  OR \n");
					}
				}
				sbSql.append("   	 ) \n");
				//sbSql.append( "   AND A.ITEM_NAME LIKE  '%" + sItemName + "%' \n");
			}
			
			
			
			
			if ( !sFavor_Group.equals(""))
				sbSql.append( "   AND A.ITEM_CODE IN (SELECT ITEM_CODE FROM FMP_FAVORITE WHERE UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' AND FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "') \n");
			sbSql.append( " GROUP BY A.TRANS_UPJANG, C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, B.ORIGIN_TYPE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE \n");
		}
		if (sOtcustcd.equals(""))		
			sbSql.append( "  UNION ALL \n");
		if (sOtcustcd.equals("") || (! sOtcustcd.equals("0000")))		
		{
			sbSql.append( "SELECT TO_CHAR(A.UPJANG)  \n");
			sbSql.append( "     , C.UPJANGNM_DISP \n");		
			sbSql.append( "     , '"+sFavorName+"' AS FAVOR_NAME \n");	
			sbSql.append( "     , A.ITEM_CODE \n");
			sbSql.append( "     , A.ITEM_NAME \n");
			sbSql.append( "     , A.ITEM_SIZE \n");
			sbSql.append( "     , B.ORIGIN_TYPE \n");
			sbSql.append( "     , A.PO_UOM \n");
			sbSql.append( "     , DECODE(A.TAX_CODE,'100''과세','면세') AS TAX_CODE \n");
			sbSql.append( "     , A.SALE_PRICE AS  SALE_PRICE \n");			
			sbSql.append( "     , ROUND(SUM(A.PR_QTY)) AS PR_QTY \n");
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) AS IN_PRICE \n");				
			sbSql.append( "     , ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY)))  AS TAX_AMOUNT \n");				
			sbSql.append( "     , ROUND(SUM(A.SALE_PRICE * A.PR_QTY)) + ROUND(SUM(DECODE(A.TAX_CODE, '100', 0.1, 0) * ROUND(A.SALE_PRICE * A.PR_QTY))) AS IN_AMOUNT \n");				
			sbSql.append( "  FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B, FMS_UPJANG C \n");			
			sbSql.append( " WHERE A.UPJANG = C.UPJANG" );
			sbSql.append( "   AND A.ITEM_CODE = B.ITEM_CODE");
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
			
			
			
			if ( !sItemName.equals(""))	{
				sbSql.append("   AND (		\n");
				
				for(int i=0; i<strKeyword_ItemName.length; i++) {
					sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
					sbSql.append("   		OR  A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
					if(i < strKeyword_ItemName.length-1) {
						sbSql.append("  OR \n");
					}
				}
				sbSql.append("   	 ) \n");
				//sbSql.append( "   AND A.ITEM_NAME LIKE '%" + sItemName + "%' \n");
			}
			
			
			
			sbSql.append( "   AND A.LINE_STATUS <> '003' \n");
			if ( !sFavor_Group.equals(""))
				sbSql.append( "   AND A.ITEM_CODE IN (SELECT ITEM_CODE FROM FMP_FAVORITE WHERE UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' AND FAVOR_GROUP = '" + nullToBlank(ds_cond.getString(0, "FAVOR_GROUP")) + "') \n");			
			sbSql.append( " GROUP BY A.UPJANG,C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, B.ORIGIN_TYPE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE \n");
		}			
		if (sOtcustcd.equals(""))
		{
			sbSql.append( ") T, FMP_FAVORITE M, FMP_FAVORITE_GROUP N \n");
			sbSql.append( "WHERE T.UPJANG = M.UPJANG  AND T.ITEM_CODE = M.ITEM_CODE   AND M.UPJANG = N.UPJANG   AND M.FAVOR_GROUP = N.FAVOR_GROUP \n");
			sbSql.append( "GROUP BY T.UPJANG, T.UPJANGNM_DISP, T.ITEM_CODE, T.ITEM_NAME, T.ITEM_SIZE, T.ORIGIN_TYPE, T.PO_UOM, T.TAX_CODE,M.FAVOR_GROUP, N.FAVOR_NAME\n");
			sbSql.append( "ORDER BY T.UPJANG, T.UPJANGNM_DISP, T.ITEM_CODE, T.ITEM_NAME, T.ITEM_SIZE, T.PO_UOM, T.TAX_CODE,M.FAVOR_GROUP, N.FAVOR_NAME\n");
			
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

		//내역조회
		if (sOtcustcd.equals(""))
		{
			sbSql.append( "SELECT T.UPJANG  \n");
			sbSql.append( "     , T.UPJANGNM_DISP \n");
			sbSql.append( "     , M.FAVOR_GROUP \n");
			sbSql.append( "     , N.FAVOR_NAME \n");	 		
			sbSql.append( "     , T.ITEM_CODE \n");				        
			sbSql.append( "     , T.ITEM_NAME \n");
			sbSql.append( "     , T.ITEM_SIZE \n");
			sbSql.append( "     , T.PO_UOM, T.TAX_CODE \n");
			sbSql.append( "     , SUM(NVL(T.SALE_PRICE,0)) AS SALE_PRICE  \n");
			sbSql.append( "     , SUM(NVL(T.PR_QTY,0)) AS PR_QTY \n");
			sbSql.append( "     , SUM(NVL(T.IN_PRICE,0)) AS IN_PRICE \n");
			sbSql.append( "     , SUM(NVL(T.TAX_AMOUNT,0)) AS TAX_AMOUNT \n");
			sbSql.append( "     , SUM(NVL(T.IN_AMOUNT,0)) AS IN_AMOUNT \n");				
			sbSql.append( "  FROM \n");
			sbSql.append( "( \n");
		}
		if (sOtcustcd.equals("") || sOtcustcd.equals("0000"))		
		{
			sbSql.append( "SELECT A.TRANS_UPJANG AS UPJANG \n");
			sbSql.append( "     , C.UPJANGNM_DISP \n");			
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
			sbSql.append( "  FROM HLDC_PO_TRANSACTION A,  FMS_UPJANG C \n");
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
			sbSql.append( " GROUP BY A.TRANS_UPJANG, C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.TAX_CODE, A.SALE_PRICE \n");
		}
		if (sOtcustcd.equals(""))		
			sbSql.append( "  UNION ALL \n");
		if (sOtcustcd.equals("") || (! sOtcustcd.equals("0000")))		
		{
			sbSql.append( "SELECT A.UPJANG  \n");
			sbSql.append( "     , C.UPJANGNM_DISP \n");			
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
			sbSql.append( "  FROM FMP_OTCUST_PR A, FMS_UPJANG C \n");			
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
			sbSql.append( " GROUP BY A.UPJANG,C.UPJANGNM_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE, A.SALE_PRICE \n");
		}			
		if (sOtcustcd.equals(""))		
			sbSql.append( ") T, FMP_FAVORITE M, FMP_FAVORITE_GROUP N WHERE T.UPJANG = M.UPJANG  AND T.ITEM_CODE = M.ITEM_CODE   AND M.UPJANG = N.UPJANG   AND M.FAVOR_GROUP = N.FAVOR_GROUP GROUP BY T.UPJANG, T.UPJANGNM_DISP, T.ITEM_CODE, T.ITEM_NAME, T.ITEM_SIZE, T.PO_UOM, T.TAX_CODE,M.FAVOR_GROUP, N.FAVOR_NAME\n");
					
		
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
--%>