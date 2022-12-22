<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
//	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_input     	= in_dl.get("ds_input");

	  	String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strSubinvCode	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));
		String strDt			= nullToBlank(ds_input.getString(0, "DATE3"));

//		if(conn != null && !conn.isClosed()) conn.close();
//		conn = getIRISConn();
//		stmt 		=  conn.createStatement();

		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		// 식자재사용패턴조회-전년동월
		sbSql.delete(0, sbSql.length());
		sbSql.append("\n");
		sbSql.append("SELECT A.CLASS_CODE AS CLASS_CODE1 -- 대분류 \n");
		sbSql.append("     , B.CLASS_CODE AS CLASS_CODE2 -- 대분류 \n");
		sbSql.append("     , A.CLASS_NAME AS CLASS_NAME1 -- 대분류 \n");
		sbSql.append("     , B.CLASS_NAME AS CLASS_NAME2 -- 중분류 \n");
		sbSql.append("     , ROUND(SUM(D.AMT01)) AS AMT01 -- 전년 \n");
		sbSql.append("     , ROUND(SUM(D.AMT02)) AS AMT02 -- 당년 \n");
		sbSql.append("     , ROUND(SUM(D.AMT02)-SUM(D.AMT01)) AS AMT03 -- 차이 \n");
		sbSql.append("     , 0 RATE01, 0 RATE02, 0 RATE03 \n");
		sbSql.append("     , A.CLASS_CODE AS PL_UP_CD \n");
		sbSql.append("     , B.CLASS_CODE AS PL_CD \n");
		sbSql.append("     , '0' BL_SHOW \n");
		sbSql.append("     , 2 LEVEL_NO \n");
		sbSql.append("     , '+' BL_PLUS \n");
		sbSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("     , HLDC_PO_ITEM_CLASS_HLDC_V B \n");
		sbSql.append("     , HLDC_PO_ITEM_MST C \n");
		sbSql.append("     , ( \n");
		sbSql.append("         SELECT A.ITEM_CODE \n");
		sbSql.append("              , SUM(MARGIN_AMOUNT) AMT01 \n");
		sbSql.append("              , 0 AMT02 \n");
		sbSql.append("           FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("              , HLDC_PO_ITEM_MST B \n");
		sbSql.append("          WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("            AND TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDt + "','YYYYMM'),-12),'YYYYMM') || '01' AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDt + "','YYYYMM'),-12),'YYYYMM') || '31' -- [기간] \n");

		if (strSubinvCode.length() != 0)
		{
			sbSql.append("            AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
		}

		sbSql.append("            AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
		sbSql.append("            AND B.ITEM_CLASS1 = 'F' \n");
		sbSql.append("            AND TRANS_TYPE LIKE 'O%' \n");
		// 인수를 제외할 경우
		//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
		sbSql.append("         GROUP BY A.ITEM_CODE \n");
		sbSql.append("         UNION ALL \n");
		sbSql.append("         SELECT A.ITEM_CODE \n");
		sbSql.append("              , 0 AMT01 \n");
		sbSql.append("              , SUM(MARGIN_AMOUNT) AMT02 \n");
		sbSql.append("           FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("              , HLDC_PO_ITEM_MST B \n");
		sbSql.append("          WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("            AND TRANS_DATE BETWEEN '" + strDt + "' || '01' AND '" + strDt + "' || '31' -- [기간] \n");

		if( strSubinvCode.length() != 0 )
		{
			sbSql.append("            AND SUBINV_CODE = '" + strSubinvCode + "'    -- [창고 지정] \n");
		}

		sbSql.append("            AND TRANS_UPJANG = " + strUpjang + " -- [업장지정] \n");
		sbSql.append("            AND B.ITEM_CLASS1 = 'F' \n");
		sbSql.append("            AND TRANS_TYPE LIKE 'O%' \n");
		// 이관을 제외할 경우
		//sbSql.append("           AND TRANS_TYPE <> 'O002' \n");
		sbSql.append("         GROUP BY A.ITEM_CODE \n");
		sbSql.append("       ) D \n");
		sbSql.append("  WHERE D.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("    AND C.ITEM_CLASS2 = A.CLASS_CODE \n");
		sbSql.append("    AND C.ITEM_CLASS3 = B.CLASS_CODE  \n");
		sbSql.append("GROUP BY A.CLASS_CODE, B.CLASS_CODE, A.CLASS_NAME, B.CLASS_NAME \n");
		sbSql.append("ORDER BY A.CLASS_CODE, B.CLASS_CODE \n");

		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_list");

		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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
//			if(stmt != null) {
//				try {
//					stmt.close();
//				}catch(Exception e) {}
//			}
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