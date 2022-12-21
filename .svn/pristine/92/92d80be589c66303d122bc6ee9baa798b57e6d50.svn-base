<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 발주제한 상품등록
//■ 프로그램ID   : FMP00530V_S001.jsp
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
		
		String sUpjang 		= nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sSdate 		= nullToBlank(ds_cond.getString(0, "S_DATE"));
		String sEdate 		= nullToBlank(ds_cond.getString(0, "E_DATE"));
		String sItemName 	= nullToBlank(ds_cond.getString(0, "ITEM_NAME"));
		String sSubinvCode 	= nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		
		//sql문 버퍼생성
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
		
		if(!nullToBlank(sItemName).equals(""))
		{
			String[] arrSameWord_tmp = nullToBlank(sItemName).split(" ");
			
			sbSql_tmp.append("SELECT LISTAGG(T.ITEM_NAME, ',') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME \n");
			sbSql_tmp.append("  FROM ( SELECT KEYWORD||','||SIM_TXT AS ITEM_NAME                              \n");
			sbSql_tmp.append("              , '1' AS ITEM_GROUP                                               \n");
			sbSql_tmp.append("           FROM EPROCUSR.VO_ITEM_SIM_WORD                                       \n");
			sbSql_tmp.append("          WHERE 1=1 															  \n");
			sbSql_tmp.append("            AND  ( 															  \n");
			for(int i=0; i<arrSameWord_tmp.length; i++) {
				sbSql_tmp.append("            		KEYWORD LIKE '%' || '"+arrSameWord_tmp[i]+"' || '%'		  \n");
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
				
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();		
		
		
		sbSql.append(" SELECT TO_CHAR(TO_DATE(A.SDATE,'YYYYMMDD'),'YYYY-MM-DD') SDATE,                                       \n");
		sbSql.append("        A.ITEM_CLASS1,                                                                                 \n");
		sbSql.append("        (SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS C WHERE A.ITEM_CLASS1 = C.CLASS_CODE)             \n");
		sbSql.append("        AS CLASS1_NAME,                                                                                \n");
		sbSql.append("        A.ITEM_CLASS2,                                                                                 \n");
		sbSql.append("        (SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS C WHERE A.ITEM_CLASS2 = C.CLASS_CODE)             \n");
		sbSql.append("        AS CLASS2_NAME,                                                                                \n");
		sbSql.append("        A.ITEM_CLASS3,                                                                                 \n");
		sbSql.append("        (SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS C WHERE A.ITEM_CLASS3 = C.CLASS_CODE)             \n");
		sbSql.append("        AS CLASS3_NAME,                                                                                \n");
		sbSql.append("        A.ITEM_CLASS4,                                                                                 \n");
		sbSql.append("        (SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS C WHERE A.ITEM_CLASS4 = C.CLASS_CODE)             \n");
		sbSql.append("        AS CLASS4_NAME,                                                                                \n");
		sbSql.append("        A.SUBINV_CODE,                                                                                 \n");
		sbSql.append("        A.SUBINV_NAME,                                                                                 \n");
		sbSql.append("        A.ITEM_CODE,                                                                                   \n");
		sbSql.append("        A.ITEM_NAME,                                                                                   \n");
		sbSql.append("        A.ITEM_SIZE,                                                                                   \n");
		sbSql.append("        A.UOM_CODE,                                                                                    \n");
		sbSql.append("        A.OPPRICE,                                                                                     \n");
		sbSql.append("        A.TO_QTY,                                                                                      \n");
		sbSql.append("        A.TO_AMOUNT,                                                                                   \n");
		sbSql.append("        A.ORIGIN_TYPE,                                                                                 \n");
		sbSql.append("        ROUND(DECODE(A.TAX_CODE,'100',TO_AMOUNT * 0.1,0)) AS TAX_AMOUNT                                \n");
		sbSql.append(" FROM   (SELECT A.*, B.TAX_CODE, B.ORIGIN_TYPE, B.ITEM_CLASS1, B.ITEM_CLASS2, B.ITEM_CLASS3,           \n");
		sbSql.append(" 			      B.ITEM_CLASS4 FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A        \n");
		sbSql.append(" 	   , FMS_SUBINVENTORY C                                                                              \n");
		sbSql.append("        ,(SELECT SUBINV_CODE, ITEM_CODE                                                                \n");
		sbSql.append("            FROM FMS_STOCK_ITEM WHERE UPJANG = '"+sUpjang+"' AND STOCK_YN = 'Y' AND USE_YN = 'Y'       \n");
		sbSql.append("           UNION ALL                                                                                   \n");
		sbSql.append("          SELECT A.SUBINV_CODE                                                                         \n");
		sbSql.append("               , DECODE((SELECT COUNT(*) FROM FMS_STOCK_ITEM B                                         \n");
		sbSql.append("                         WHERE B.UPJANG = A.UPJANG                                                     \n");
		sbSql.append("                           AND B.SUBINV_CODE = A.SUBINV_CODE                                           \n");
		sbSql.append("                           AND B.STOCK_YN = 'Y' AND B.USE_YN = 'Y')                                    \n");
		sbSql.append("                       ,0,'%','X') AS ITEM_CODE                                                        \n");
		sbSql.append("            FROM FMS_SUBINVENTORY A                                                                    \n");
		sbSql.append("           WHERE A.UPJANG = '"+sUpjang+"'                                                              \n");
		sbSql.append("             AND A.STOCK_YN = 'Y'                                                                      \n");
		sbSql.append("         ) D                                                                                           \n");
		sbSql.append("       WHERE (1=1)                                                                                     \n");
		sbSql.append("      	  AND A.SUBINV_CODE = C.SUBINV_CODE AND C.STOCK_YN = 'Y'                                     \n");
		sbSql.append("           AND A.SUBINV_CODE = D.SUBINV_CODE AND A.ITEM_CODE LIKE D.ITEM_CODE                          \n");
		sbSql.append("           AND A.UPJANG = '"+sUpjang+"'                                                                \n");
		
		if (!sSubinvCode.equals("")) {
			sbSql.append("           AND A.SUBINV_CODE = '"+sSubinvCode+"'                                                   \n");
		}
				
		if (!sItemName.equals("")) {
			sbSql.append("   AND (		\n");
			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			 A.ITEM_CODE LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				sbSql.append("   		OR	 A.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("   	 ) \n");
			//sbSql.append("        AND A.ITEM_NAME LIKE '%' || #ITEM_NAME# || '%'                                                 \n");
		}
		
		sbSql.append("        AND A.SDATE BETWEEN '" + sSdate + "' AND '" + sEdate + "'                                      \n");
		sbSql.append("  ORDER BY A.SDATE, A.SUBINV_CODE, A.ITEM_CODE                                                         \n");                                                                                
		
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
