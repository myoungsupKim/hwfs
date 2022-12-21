<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS구매관리/특판상품발주예정현황
■ 프로그램ID   : FSV00030V_T001.jsp
■ 프로그램명   : 발주조회
■ 작성일자     : 2010.06.14
■ 작성자       : 박은규
■ 이력관리     : 2010.06.14
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
		String g_CustCd     = nullToBlank(in_vl.getString("g_CustCd"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//주문내역조회
		sbSql.append("				SELECT A.SP_ID \n");
		sbSql.append("				    , A.SP_DATE \n");		
		sbSql.append("     				, A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE \n");
		sbSql.append("     				, DECODE(C.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
		sbSql.append("     				, B.DELI_FEE AS ITEM_DELI_FEE \n");
		sbSql.append("     				, A.SALE_PRICE \n");
		sbSql.append("     				, B.UNIT_PRICE \n");
		sbSql.append("     				, (A.PR_QTY * B.UNIT_PRICE) + A.DELI_FEE  AS UNIT_PRICE_AMT \n");		
		sbSql.append("     				, A.PR_QTY \n");
		sbSql.append("     				, A.SALE_AMOUNT \n");
		sbSql.append("     				, A.DELI_FEE \n");
		sbSql.append("     				, A.DC_AMOUNT \n");
		sbSql.append("     				, A.SALE_AMOUNT + A.DELI_FEE - A.DC_AMOUNT AS TOT_AMOUNT\n");
		sbSql.append("     				, A.SALE_TYPE \n");
		sbSql.append("     				, C.IMG_PATH AS IMAGE_PATH \n");
		sbSql.append("     				, A.CONTENT \n");
		sbSql.append("     				, A.LINE_STATUS \n");
		sbSql.append("     				, A.PR_SABUN \n");
		sbSql.append("     				, A.RQ_SABUN \n");
		sbSql.append("     				, (SELECT V1.NM_KOR||' ('||V2.MU_NM||' '||V2.CC_NM||')' AS NM_KOR FROM HLDC_HR_PERSONAL V1, HLDC_SC_DEPT_V V2 WHERE (V1.DEPT_ID = V2.DEPT_ID) AND (V1.SABUN = A.RQ_SABUN)) AS RQ_SABUNNM \n");
		sbSql.append("     				, A.RQ_TEL \n");			
		sbSql.append("  			    , A.SEND_NAME, A.SEND_TEL, A.SEND_POSTNO, SC_CRYPTO_FUN('DEC', A.SEND_ADDR_ENC,'6') SEND_ADDR \n");
		sbSql.append("  			    , A.RECE_NAME, A.RECE_TEL, SC_CRYPTO_FUN('DEC', A.RECE_HP_ENC,'4') RECE_HP, A.RECE_POSTNO, SC_CRYPTO_FUN('DEC', A.RECE_ADDR_ENC,'6') RECE_ADDR \n");
		sbSql.append(" 			        , A.AR_SAUPNO, A.AR_POSTNO, SC_CRYPTO_FUN('DEC', A.AR_ADDR_ENC,'6') AR_ADDR, A.AR_NAME, A.AR_TEL, SC_CRYPTO_FUN('DEC', A.AR_EMAIL_ENC,'5') AR_EMAIL \n");			  
		sbSql.append("  			    , A.PAY_METHOD, A.INST_PERIOD \n");
		sbSql.append(" 				    , A.CARD_COMP, SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC,'2') CARD_NUM \n");
		sbSql.append("     				, A.VALID_THRU_MM \n");
		sbSql.append("     				, A.VALID_THRU_YY \n");
		sbSql.append("     				, A.DELI_TYPE \n");
		sbSql.append("     				, (SELECT Z.CODE_NAME FROM HLDC_PO_CODE Z WHERE Z.GROUP_CODE = '025' AND Z.CODE = A.DELI_COMP) AS DELI_COMP \n");
		sbSql.append("    				, A.INVOICE_NUM, A.BILL_NO \n");
		sbSql.append("     				, C.MAX_ORD_QTY \n");
		//취소자료도 재고량에 포함
		//sbSql.append("     				, (B.STOCK_QTY - NVL((SELECT SUM(Z.PR_QTY) FROM HLDC_PO_SPECIAL_SALE Z WHERE Z.ITEM_CODE = B.ITEM_CODE AND Z.SP_TYPE = 'ING' AND Z.LINE_STATUS <> '취소'),0)) AS STOCK_QTY \n");
		sbSql.append("     				, (B.STOCK_QTY - NVL((SELECT SUM(Z.PR_QTY) FROM HLDC_PO_SPECIAL_SALE Z WHERE Z.ITEM_CODE = B.ITEM_CODE AND Z.SP_TYPE = 'ING' AND Z.SEASON_NUM = (SELECT MAX(SID) FROM SEASON_LIST) AND LINE_STATUS<>'취소' ),0)) AS STOCK_QTY \n");
		sbSql.append("     				, B.DELI_FREE_AMT \n");
		sbSql.append("     				, B.QTY_DC_STD \n");
		sbSql.append("     				, B.QTY_DC_RATE \n");
		sbSql.append("     				, B.AMT_DC_STD \n");
		sbSql.append("     				, B.AMT_DC_RATE \n");	
		sbSql.append("  FROM HLDC_PO_SPECIAL_SALE A, HLDC_PO_SPECIAL_ITEM B, HLDC_PO_ITEM_MST C \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("   AND A.SEASON_NUM = B.SEASON_NUM \n");
		sbSql.append("   AND A.SEASON_NUM = (SELECT MAX(SID) FROM SEASON_LIST) \n");
		sbSql.append("   AND A.SP_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SP_DATE")) + "' \n");
		sbSql.append("                     AND '" + nullToBlank(ds_Cond.getString(0, "SP_DATET")) + "' \n");
		sbSql.append("   AND B.CUSTCD = " + g_CustCd + " \n");
		if (sType.equals("TRUE"))
			sbSql.append("   AND A.LINE_STATUS = '주문' \n");
		else
			sbSql.append("   AND A.LINE_STATUS <> '취소' \n");
		sbSql.append(" ORDER BY DECODE(A.LINE_STATUS, '주문', 'A', '정산', 'B', '배송', 'C'), A.SP_DATE, A.ITEM_CODE \n");
		
	

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