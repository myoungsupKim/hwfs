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
		DataSet ds_cond     = in_dl.get("ds_Input");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//out 데이타
		DataSet ds_List;
		
		String sUpjang 	 = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sItemCode = nullToBlank(ds_cond.getString(0, "ITEM_CODE"));
		String sItemName = nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		String sOtcustcd = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
		
		if(!nullToBlank(sItemName).equals(""))
		{
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가			
			String[] arrSameWord_tmp = nullToBlank(sItemName).split(" ");
			
			sbSql_tmp.setLength(0);
            sbSql_tmp.append("/* fm/fmu/FMU00262P_S001.jsp */                                                 \n");
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
		
		sbSql.append("SELECT ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, ORIGIN_TYPE                                                                 \n");
		sbSql.append("  FROM FMS_ITEM_V                                                                                                           \n");
		sbSql.append(" WHERE 1 = 1                                                                                                                \n");
		
		if (!sUpjang.equals("")) {
			sbSql.append("   AND ITEM_CODE IN (SELECT A.ITEM_CODE                                                                                     \n");
			sbSql.append("			           FROM HLDC_PO_CONTRACT_FSALE A                                                                          \n");
			sbSql.append("			          WHERE A.UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = '"+sUpjang+"')               \n");
			sbSql.append("			          GROUP BY A.ITEM_CODE                                                                                    \n");
			sbSql.append("			          UNION ALL                                                                                               \n");
			sbSql.append("			         SELECT A.ITEM_CODE                                                                                       \n");
			sbSql.append("			           FROM FMP_OTCUST_PRICE_AVA_V A                                                                          \n");
			sbSql.append("			              ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE                                                     \n");
			sbSql.append("			                  FROM FMP_OTCUST_PRICE_AVA_V                                                                     \n");
			sbSql.append("			                 WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = '"+sUpjang+"')        \n");
			sbSql.append("			                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD')                                                    \n");
			sbSql.append("			                 GROUP BY UPJANG, ITEM_CODE) C                                                                    \n");
			sbSql.append("			          WHERE A.UPJANG = C.UPJANG                                                                               \n");
			sbSql.append("			            AND A.SDATE = C.SDATE                                                                                 \n");
			sbSql.append("			            AND A.ITEM_CODE = C.ITEM_CODE                                                                         \n");
			sbSql.append("			            AND A.USE_YN = 'Y' AND A.SALE_PRICE > 0                                                               \n");
			sbSql.append("                     )                                                                                                      \n");
		}
		/*
		if (!sItemCode.equals("")) {
			sbSql.append("   AND (		\n");
			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			 ITEM_CODE LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("   	 ) \n");
			
		}
		*/
		if (!sItemCode.equals("")) {
			sbSql.append("   AND ITEM_CODE LIKE '%' || '"+sItemCode+"'|| '%'                                                                             \n");	
		}
		
		if (!sItemName.equals("")) {
			sbSql.append("   AND (		\n");
			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			 ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("   	 ) \n");
			//sbSql.append("   AND ITEM_NAME LIKE '%' || #ITEM_NAME# || '%'                                                                             \n");
		}
		sbSql.append("   AND ITEM_CLASS1 = 'F'                                                                                                    \n");
		sbSql.append("   AND USE_YN = 'Y'                                                                                                         \n");
		sbSql.append(" ORDER BY ITEM_CODE                                                                                                         \n");
		 
		 
		//if (sGubun.equals("2")) {
		//	sbSql.append("   AND (		\n");
		//	
		//	for(int i=0; i<strKeyword_ItemName.length; i++) {
		//		sbSql.append("   			 C.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
		//		if(i < strKeyword_ItemName.length-1) {
		//			sbSql.append("  OR \n");
		//		}
		//	}
		//	sbSql.append("   	 ) \n");
		//	//sbSql.append("  AND C.ITEM_NAME LIKE '%' || '"+sItemName+"' || '%'                                                            \n");
		//}
		//sbSql.append("  ORDER BY A.ITEM_CODE                                                                                   \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
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
