<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리/재고관리
■ 프로그램ID   : FMP00470E_T001.jsp
■ 프로그램명   : 재고관리상품 등록(조회)
■ 작성일자     : 2008.04.24
■ 작성자       : 박은규
■ 이력관리     : 2008.04.24
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
		//DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSUBINV_CODE = nullToBlank(in_vl.getString("sSUBINV_CODE"));
		String sItem        = nullToBlank(in_vl.getString("sItem"));

		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
		
		if(!nullToBlank(sItem).equals(""))
		{
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
			String[] arrSameWord_tmp = nullToBlank(sItem).split(" ");

			sbSql_tmp.setLength(0);
            sbSql_tmp.append("/* fm/fmp/FMP00470E_T001.jsp */                                                 \n");
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
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		if ((sType.equals("재고상품")) || (sType.equals("재고복사")))
		{
			sbSql.append("SELECT C.CLASS_NAME \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , B.ITEM_NAME \n");
			sbSql.append("     , B.ITEM_SIZE \n");
			sbSql.append("     , B.PO_UOM \n");
			if (sType.equals("재고상품"))
				sbSql.append("     , '0' CHK \n");
			else
				sbSql.append("     , '1' CHK \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , A.SUBINV_CODE \n");
			sbSql.append("  FROM FMS_STOCK_ITEM A, FMS_ITEM_V B, HLDC_PO_ITEM_CLASS_HLDC_V C \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("   AND B.ITEM_CLASS3 = C.CLASS_CODE \n");
			sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + sSUBINV_CODE + "' \n");
			sbSql.append("   AND A.STOCK_YN  = 'Y' \n");			
			//sbSql.append(" ORDER BY A.ITEM_CODE \n");
		}
		else if (sType.equals("상품조회"))
		{
			sbSql.append("SELECT C.CLASS_NAME \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , B.ITEM_NAME \n");
			sbSql.append("     , B.ITEM_SIZE \n");
			sbSql.append("     , B.PO_UOM \n");
			sbSql.append("     , '0' CHK \n");
			sbSql.append("     , " + sUpjang + " AS UPJANG \n");
			sbSql.append("     , '" + sSUBINV_CODE + "' AS SUBINV_CODE \n");
			sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V C \n");
			sbSql.append("     , FMS_ITEM_V B \n");
			//sbSql.append("     ,(SELECT /*+ INDEX(A PO_TREAT_UPJANG_PK) */ \n");
			sbSql.append("     ,(SELECT \n");
			sbSql.append("              A.ITEM_CODE \n");
			sbSql.append("         FROM HLDC_PO_CONTRACT_FSALE A \n");
			sbSql.append("        WHERE A.UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + sUpjang + ") \n");
			sbSql.append("        GROUP BY A.ITEM_CODE \n");
			sbSql.append("        UNION ALL \n");
			sbSql.append("       SELECT A.ITEM_CODE \n");
			sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A \n");
			sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
			sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V \n");
			sbSql.append("               WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = " + sUpjang + ") \n");
			sbSql.append("                 AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
			sbSql.append("               GROUP BY UPJANG, ITEM_CODE) C \n");
			sbSql.append("        WHERE A.UPJANG = C.UPJANG \n");
			sbSql.append("          AND A.SDATE = C.SDATE \n");
			sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE \n");
			sbSql.append("          AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0) A \n");
			sbSql.append(" WHERE B.ITEM_CLASS3 = C.CLASS_CODE \n");
			sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("   AND NOT EXISTS (SELECT 1 FROM FMS_STOCK_ITEM Z \n");
			sbSql.append("                    WHERE Z.UPJANG = " + sUpjang + " \n");
			sbSql.append("                      AND Z.SUBINV_CODE = '" + sSUBINV_CODE + "' \n");
			sbSql.append("                      AND Z.ITEM_CODE = A.ITEM_CODE) \n");
			if (! sItem.equals("")) {
				sbSql.append("   AND (		\n");
			
				for(int i=0; i<strKeyword_ItemName.length; i++) {
					sbSql.append("   			A.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
					sbSql.append("   		OR  B.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
					if(i < strKeyword_ItemName.length-1) {
						sbSql.append("  OR \n");
					}
				}
				sbSql.append("   	 ) \n");
			}
			//sbSql.append("   AND (A.ITEM_CODE LIKE '" + sItem + "%' OR B.ITEM_NAME LIKE '%" + sItem + "%') \n");
			//sbSql.append(" ORDER BY A.ITEM_CODE \n");
		}
		else if (sType.equals("주간상품"))
		{
			sbSql.append("SELECT C.CLASS_NAME \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , B.ITEM_NAME \n");
			sbSql.append("     , B.ITEM_SIZE \n");
			sbSql.append("     , B.PO_UOM \n");
			sbSql.append("     , '1' CHK \n");
			sbSql.append("     , " + sUpjang + " AS UPJANG \n");
			sbSql.append("     , '" + sSUBINV_CODE + "' AS SUBINV_CODE \n");
			sbSql.append("  FROM FMP_WEEKLY_ITEM A, FMS_ITEM_V B, HLDC_PO_ITEM_CLASS_HLDC_V C \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("   AND B.ITEM_CLASS3 = C.CLASS_CODE \n");
			sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
			//sbSql.append(" ORDER BY A.ITEM_CODE \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\BBB.txt", ds_ListTmp);
		
		pstmt.close();
		rs.close();
		
		/**종료**/
		out_dl.add(ds_List);
		out_vl.add("fa_Rcnt", ds_List.getRowCount());
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