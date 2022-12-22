<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 도소매관리/판매단가조회
■ 프로그램ID   : FMW00202V_T001.jsp
■ 프로그램명   : 판매단가조회
■ 작성일자     : 2011.02.09
■ 작성자       : 황승한
■ 이력관리     : 2011.02.09
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
		DataSet ds_Condput     	= in_dl.get("ds_Cond");
	
		String strUpjang       = nullToBlank(ds_Condput.getString(0, "UPJANG"));
		String strOtcustcd     = nullToBlank(ds_Condput.getString(0, "OTCUSTCD"));
		String strClass_code_s = nullToBlank(ds_Condput.getString(0, "CLASS_CODE_S"));
		
		String strDATEF		    = nullToBlank(ds_Condput.getString(0, "DATEF"));
		String strDATET		    = nullToBlank(ds_Condput.getString(0, "DATET"));
		
		//out 데이타
		DataSet ds_List;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
			
        sbSql.append("    SELECT   V.ITEM_CODE                                                                                                    \n");
        sbSql.append("           , V.OTCUSTCD                                                                                                     \n");
        sbSql.append("           , (SELECT OTCUSTNM FROM (SELECT OTCUSTCD, OTCUSTNM FROM FMW_OTCUST  WHERE (1=1)	 AND USE_YN = 'Y' AND UPJANG =  " + strUpjang + "  UNION ALL SELECT '0000' AS OTCUSTCD, '한화호텔&리조트' AS OTCUSTNM FROM DUAL) WHERE OTCUSTCD = V.OTCUSTCD) AS OTCUSTNM \n");        
        sbSql.append("           , V.UPJANG                                                                                                       \n");
        sbSql.append("           , A.HALL_NAME                                                                                                    \n");
        sbSql.append("           , V.ITEM_NAME                                                                                                    \n");
        sbSql.append("           , ROUND(V.ITEM_SIZE_BOX * V.ITEM_SIZE_BONG * NVL(V.UNIT_PRICE_BONG, 0)) AS BOX_PRICE_U                                                                                                                                                     \n");
        sbSql.append("           , NVL(V.UNIT_PRICE_BONG, 0) AS BONG_PRICE_U                                                                                                                                                                                                \n");        
        sbSql.append("           , DECODE(V.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
        sbSql.append("           , V.ITEM_CLASS3                                                                                                  \n");
        sbSql.append("           , V.ITEM_SIZE_KG                                                                                                 \n");
        sbSql.append("           , V.ITEM_SIZE_BONG                                                                                               \n");
        sbSql.append("           , V.ITEM_SIZE_BOX                                                                                                \n");
        sbSql.append("           , V.G_CONVERT_RATE                                                                                               \n");
        sbSql.append("           , V.BODY_WIDTH                                                                                                   \n");
        sbSql.append("           , V.BODY_VERTICAL                                                                                                \n");
        sbSql.append("           , V.BODY_HEIGHT                                                                                                  \n");
        sbSql.append("           , V.SALE_PRICE_BONG                                                                                              \n");       
        sbSql.append("           , V.SHELF_LIFE                                                                                                   \n");
        sbSql.append("           , V.USE_YN                                                                                                       \n");
        sbSql.append("           , DECODE(NVL(A.USE_YN, 'N'), 'Y', A.SALE_PRICE, 0) AS CURR_SALE_PRICE                                            \n");
        sbSql.append("      FROM FMW_ITEM_V V \n");
        sbSql.append("         , (SELECT A.UPJANG, A.HALL_CODE, A.HALL_NAME, B.ITEM_CODE, B.USE_YN, B.SALE_PRICE FROM FMW_HALL A, FMW_FIXED_SALE_PRICE B WHERE (A.HALL_CODE = B.HALL_CODE) AND A.UPJANG = " + strUpjang + " ) A   \n");
        sbSql.append("     WHERE (V.ITEM_CODE = A.ITEM_CODE(+))                                                                                    \n");        
        sbSql.append("       AND (DECODE(V.UPJANG, 0, " + strUpjang + ", V.UPJANG)   = " + strUpjang + ") \n");
        
        if (! strOtcustcd.equals(""))
        {
        	sbSql.append("   AND (V.OTCUSTCD = '" + strOtcustcd + "') \n");        	
        }    
        

        if (! strClass_code_s.equals(""))
        {
        	sbSql.append("   AND SUBSTR(V.ITEM_CLASS3,1,6) = SUBSTR('" + strClass_code_s + "',1,6)     \n");        	
        }

    sbSql.append(" ORDER BY A.HALL_NAME, V.ITEM_CODE, V.OTCUSTCD \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");

		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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