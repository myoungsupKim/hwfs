<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 발주제한 상품등록
//■ 프로그램ID   : FMP00920E_T001.jsp
//■ 프로그램명   : 발주제한 상품등록
//■ 작성일자     : 2015.08.13
//■ 작성자       : 이규훈
//■ 이력관리     : 2015.08.13
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
	
		//out 데이타
		DataSet ds_list;
		
		String sGubun = nullToBlank(ds_cond.getString(0, "S_GBN"));
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sWord = nullToBlank(ds_cond.getString(0, "S_WORD"));
		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
		
		if(!nullToBlank(sWord).equals(""))
		{
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가			
			String[] arrSameWord_tmp = nullToBlank(sWord).split(" ");
			
			sbSql_tmp.setLength(0);
            sbSql_tmp.append("/* fm/fmp/FMP00920E_S003.jsp */                                                 \n");
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
		
		sbSql.append(" SELECT A.ITEM_CODE                                                                                      \n");
		sbSql.append(" 	 , C.ITEM_NAME                                                                                         \n");
		sbSql.append(" 	 , C.ITEM_SIZE                                                                                         \n");
		sbSql.append(" 	 , C.PO_UOM                                                                                            \n");
		sbSql.append(" 	 , DECODE(C.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE                                     \n");
		sbSql.append(" 	 , A.SALE_PRICE AS UNIT_PRICE	 -- 단가                                                               \n");
		sbSql.append(" 	 , '' ITEM_DESC                                                                                        \n");
		sbSql.append(" 	 , C.ORIGIN_TYPE                                                                                       \n");
		sbSql.append(" FROM FMS_ITEM_V C,                                                                                      \n");
		sbSql.append("      (                                                                                                  \n");
		sbSql.append("         SELECT '"+sUpjang+"' AS UPJANG                                                                  \n");
		sbSql.append("              , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE                                                 \n");
		sbSql.append("              , A.ITEM_CODE, A.SALE_PRICE, A.CENTER_CODE                                                 \n");
		sbSql.append("           FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG C                                               \n");
		sbSql.append("          WHERE A.UPJANG = C.AP_UNITPRICE_UPJANG                                                         \n");
		sbSql.append("            AND C.UPJANG = '"+sUpjang+"'                                                                 \n");
		sbSql.append("            AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '99999999') \n");
		sbSql.append("            AND A.SALE_PRICE > 0                                                                         \n");
		sbSql.append("            AND A.USE_YN = 'Y'                                                                           \n");
		sbSql.append("         -----------                                                                                     \n");
		sbSql.append("          UNION ALL                                                                                      \n");
		sbSql.append("         -----------                                                                                     \n");
		sbSql.append("         SELECT '"+sUpjang+"' AS UPJANG,                                                                 \n");
		sbSql.append("                TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ,                                               \n");
		sbSql.append("                A.ITEM_CODE,                                                                             \n");
		sbSql.append("                A.SALE_PRICE,                                                                            \n");
		sbSql.append("                0 CENTER_CODE                                                                            \n");
		sbSql.append("           FROM FMP_OTCUST_PRICE_AVA_V A,                                                                \n");
		sbSql.append("                (                                                                                        \n");
		sbSql.append("                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE                                            \n");
		sbSql.append("                  FROM FMP_OTCUST_PRICE_AVA_V                                                            \n");
		sbSql.append("                 WHERE UPJANG =                                                                          \n");
		sbSql.append("                       (                                                                                 \n");
		sbSql.append("                       SELECT OTCUST_PRICE_UPJANG                                                        \n");
		sbSql.append("                         FROM FMS_UPJANG                                                                 \n");
		sbSql.append("                        WHERE UPJANG = '"+sUpjang+"'                                                     \n");
		sbSql.append("                       )                                                                                 \n");
		sbSql.append("                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD')                                           \n");
		sbSql.append("                 GROUP BY UPJANG, ITEM_CODE                                                              \n");
		sbSql.append("                ) C                                                                                      \n");
		sbSql.append("          WHERE A.UPJANG = C.UPJANG                                                                      \n");
		sbSql.append("            AND A.SDATE = C.SDATE                                                                        \n");
		sbSql.append("            AND A.ITEM_CODE = C.ITEM_CODE                                                                \n");
		sbSql.append("            AND A.SDATE = C.SDATE                                                                        \n");
		sbSql.append("            AND A.SALE_PRICE > 0                                                                         \n");
		sbSql.append("            AND A.USE_YN = 'Y'                                                                           \n");
		sbSql.append("      ) A                                                                                                \n");
		sbSql.append(" WHERE A.ITEM_CODE = C.ITEM_CODE(+)                                                                      \n");
		
		if (sGubun.equals("1")) {
			sbSql.append("   AND (		\n");
			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			 A.ITEM_CODE LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("   	 ) \n");
			//sbSql.append("  AND A.ITEM_CODE LIKE '"+sWord+"' || '%'                                                            \n");
		}
		if (sGubun.equals("2")) {
			sbSql.append("   AND (		\n");
			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			 C.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("   	 ) \n");
			//sbSql.append("  AND C.ITEM_NAME LIKE '%' || '"+sWord+"' || '%'                                                            \n");
		}
		sbSql.append("  ORDER BY A.ITEM_CODE                                                                                   \n");
		
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
