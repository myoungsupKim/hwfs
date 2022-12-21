<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리
■ 프로그램ID   : FMU00310V_T001.jsp
■ 프로그램명   : 본부/본사 제출단가조회
■ 작성일자     : 2008-04-01
■ 작성자       : 박은규
■ 이력관리     : 2008-04-01
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.append("SELECT /*+ USE_HASH(B A) */ DECODE('" + nullToBlank(ds_Cond.getString(0, "CLASS")) + "','CLASS_NAME1',DECODE(A.CONSUM_YN,'Y','소모품','식자재') \n");
		sbSql.append("                     ,'CLASS_NAME2',(SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS B WHERE B.CLASS_CODE = A.ITEM_CLASS2) \n");
		sbSql.append("                     ,'CLASS_NAME3',(SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS B WHERE B.CLASS_CODE = A.ITEM_CLASS3) \n");
		sbSql.append("                     ,'CLASS_NAME4',(SELECT B.CLASS_NAME FROM HLDC_PO_ITEM_CLASS B WHERE B.CLASS_CODE = A.ITEM_CLASS4)) AS CLASS_NAME \n");
		sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.TAX_CODE \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , NVL(B.SB_PRICE,0) AS SB_PRICE \n");
		//sbSql.append("     , 'D-'||TO_CHAR(NVL(A.D_DAYS,0) + 1) AS D_DAYS \n");
		sbSql.append(" 	     /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append("     , 'D-'||TO_CHAR(NVL(A.D_DAYS,0)) AS D_DAYS \n");
		sbSql.append("     , DECODE(A.SALE_PRICE,0,'N',A.USE_YN) AS USE_YN \n");
		sbSql.append("  FROM FMU_SB_PRICE B \n");
		sbSql.append("     ,(SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG, B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
		sbSql.append("            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' AS SDATE, A.SALE_PRICE \n");
		sbSql.append("            , K.D_DAYS, A.USE_YN \n");
		sbSql.append("         FROM HLDC_PO_ITEM_MST B \n");
		sbSql.append("            , HLDC_PO_PREORDER_LIST K \n");
		sbSql.append("            ,(SELECT /*+ DRIVING_SITE(A) INDEX_DESC(A PO_CONTRACT_FSALE_PK) */ \n");
		sbSql.append("                     A.CENTER_CODE, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append("                   , A.SALE_PRICE \n");
		sbSql.append("                   , A.USE_YN \n");
		sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A \n");
		sbSql.append("               WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                 AND A.UPJANG = (SELECT A.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG A WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                 AND A.ITEM_CODE > ' ' \n");
		sbSql.append("                 AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
    //2009.05.20 박은규, 김진희, 현재단가는 업장업체 설정되어있는 것만 조회
		sbSql.append("                 AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.UPJANG = A.UPJANG) \n");
		sbSql.append("             ) A \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+) \n");
		sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+) \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG, B.CONSUM_YN, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append("            , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
		sbSql.append("            , DECODE(B.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' AS SDATE, A.SALE_PRICE \n");
		sbSql.append("            , NVL(B.D_DAYS,0) + 1 AS D_DAYS, A.USE_YN \n");
		sbSql.append("         FROM FMP_OTCUST_ITEM B \n");
		sbSql.append("            ,(SELECT A.ITEM_CODE \n");
		sbSql.append("                   , A.SALE_PRICE \n");
		sbSql.append("                   , A.USE_YN \n");
		sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V A \n");
		sbSql.append("                   ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append("                       FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                      WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") \n");
		sbSql.append("                        AND SDATE <= '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("                      GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append("               WHERE A.UPJANG = C.UPJANG \n");
		sbSql.append("                 AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("                 AND A.SDATE  = C.SDATE) A \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("      ) A \n");
		sbSql.append(" WHERE B.UPJANG(+) = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND B.USE_YN(+) = 'Y' \n");
		String sConsum = nullToBlank(ds_Cond.getString(0, "CONSUM_YN"));
		String sItemClass2 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2"));
		String sItemClass3 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3"));
		String sItemClass4 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4"));
		String sItemCode   = nullToBlank(ds_Cond.getString(0, "ITEM_CODE"));
		if (! sConsum.equals(""))
			sbSql.append("   AND A.CONSUM_YN = '" + nullToBlank(ds_Cond.getString(0, "CONSUM_YN")) + "' \n");
		if (! sItemClass2.equals(""))
			sbSql.append("   AND A.ITEM_CLASS2 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2")) + "' \n");
		if (! sItemClass3.equals(""))
			sbSql.append("   AND A.ITEM_CLASS3 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3")) + "' \n");
		if (! sItemClass4.equals(""))
			sbSql.append("   AND A.ITEM_CLASS4 = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4")) + "' \n");
		if (! sItemCode.equals(""))
			sbSql.append("   AND (A.ITEM_CODE LIKE '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'||'%' OR A.ITEM_NAME LIKE '%'||'" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'||'%') \n");
		sbSql.append(" ORDER BY A.ITEM_CLASS4, A.ITEM_CODE \n");

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