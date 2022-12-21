<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/구매관리/입고관리
■ 프로그램ID   : FSP00130E_T001.jsp
■ 프로그램명   : 자재입고 및 클레임등록(조회)
■ 작성일자     : 2008-03-17
■ 작성자       : 박은규
■ 이력관리     : 2008-03-17 - 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null; 
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sGB          = nullToBlank(in_vl.getString("sGB"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sPast        = nullToBlank(in_vl.getString("sPast"));
		String sChk_        = nullToBlank(in_vl.getString("sChk_"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//창고/부서목록 조회
		if (sType.equals("SubInvQry"))
		{
			//창고조회(자신이 관리자로 등록되어 있는 창고)
			if (sGB.equals("S"))
			{
				sbSql.append("SELECT A.SUBINV_CODE \n");
				sbSql.append("     , DECODE(A.USE_YN,'N','폐장')||A.SUBINV_CODE||' '||A.SUBINV_NAME||'('||B.UPJANGNM||')' AS SUBINV_NAME \n");
				//sbSql.append("     , A.TR_DATE_FIX_FLAG \n");
				sbSql.append("     , SUBSTR(D.CENTER_TYPE,1,2) AS CENTER_TYPE \n");
				//sbSql.append("  FROM HLDC_PO_SUBINVENTORY A, PO_ORGANIZATION A0, ST_UPJANG B \n");
				sbSql.append("  FROM HLDC_PO_SUBINVENTORY A, ST_UPJANG B \n");
				sbSql.append("     , HLDC_PO_UPJANG_CENTER C, HLDC_PO_CENTER D \n");
				//sbSql.append(" WHERE A.ORG_CODE = A0.ORG_CODE \n");
				//sbSql.append("   AND A.UPJANG = B.UPJANG \n");
				sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append("   AND B.AP_UNITPRICE_UPJANG = C.UPJANG \n");
				sbSql.append("   AND C.CENTER_CODE = D.CENTER_CODE \n");
				sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
				//sbSql.append("   AND EXISTS (SELECT 1 FROM PO_SUBINV_USER Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE AND Z.SABUN = '" + g_EmpNo + "') \n");
				sbSql.append("   AND A.USE_YN = 'Y' \n");
				//sbSql.append(" ORDER BY NVL(A0.ATTR01,'ZZZ'), A.SUBINV_CODE \n");
				sbSql.append(" ORDER BY A.SUBINV_CODE \n");
				//sbSql.append(" ORDER BY A.SUBINV_NAME \n");
			}
			//부서조회(소속부서 및 자신이 관리자로 등록되어 있는 창고의 부서)
			else
			{
				sbSql.append("SELECT A.DEPT_ID AS SUBINV_CODE \n");
				sbSql.append("     , A.DEPT_NAME AS SUBINV_NAME \n");
				sbSql.append("     , 'N' AS TR_DATE_FIX_FLAG \n");
				sbSql.append("  FROM (SELECT B.DEPT_ID \n");
				sbSql.append("             , DECODE(B.DEPT_USE,'N','(구)')||'('||B.CC_CD||')'||B.MU_NM||' '||B.CC_NM||'('||TO_CHAR(B.DEPT_ID)||')' AS DEPT_NAME \n");
				sbSql.append("             , B.DEPT_USE AS USE_YN \n");
				sbSql.append("          FROM HLDC_SC_DEPT_V B, ST_UPJANG C \n");
				//sbSql.append("             ,(SELECT A.UPJANG \n");
				//sbSql.append("                 FROM PO_SUBINVENTORY A, PO_SUBINV_USER B \n");
				//sbSql.append("                WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
				//sbSql.append("                  AND A.USE_YN = 'Y' \n");
				//sbSql.append("                  AND B.SUBINV_CODE > ' ' \n");
				//sbSql.append("                  AND B.SABUN = '" + g_EmpNo + "' \n");
				//sbSql.append("                UNION ALL \n");
				//sbSql.append("               SELECT " + g_Upjang + " AS UPJANG \n");
				//sbSql.append("                 FROM DUAL) A \n");
				sbSql.append("         WHERE C.DEPT_ID = B.DEPT_ID \n");
				//sbSql.append("           AND A.UPJANG = C.UPJANG \n");
				sbSql.append("           AND C.UPJANG = " + sUpjang + ") A \n");
				//sbSql.append("         GROUP BY B.DEPT_ID, DECODE(B.DEPT_USE,'N','(구)')||'('||B.CC_CD||')'||B.MU_NM||' '||B.CC_NM||'('||TO_CHAR(B.DEPT_ID)||')' \n");
				//sbSql.append("             , B.DEPT_USE) A \n");
				sbSql.append(" ORDER BY A.DEPT_ID \n");
				//sbSql.append(" ORDER BY A.DEPT_NAME \n");
			}
		}
		//창고마감여부 조회
		else if (sType.equals("ClsQry"))
		{
			sbSql.append("SELECT 'S' AS CLS_FLAG \n");
			sbSql.append("     , TO_CHAR(TO_DATE(A.CLS_YM,'YYYYMM'),'YYYY-MM') AS JDATE \n");
			sbSql.append("  FROM PO_CLOSING A \n");
			sbSql.append(" WHERE A.CLS_YM     >= SUBSTR('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "',1,6) \n");
			sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.CLS_FLAG    = 'Y' \n");
			sbSql.append("   AND ROWNUM        = 1 \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append("SELECT 'P' AS CLS_FLAG \n");
			sbSql.append("     , TO_CHAR(TO_DATE(A.PHYSIC_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS JDATE \n");
			sbSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
			sbSql.append(" WHERE A.PHYSIC_DATE >= '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("   AND A.SUBINV_CODE  = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			sbSql.append("   AND A.CLOSE_DATE   > ' ' \n");
			sbSql.append("   AND ROWNUM         = 1 \n");
		}
		//검수대상 조회
		else if (sType.equals("TranQry"))
		{
			sbSql.append("SELECT A.ORDER_NUM, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, C.CUSTNM \n");
			//sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS PO_QTY \n");
			sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) AS PO_QTY \n");
			//정상 입고상태로 조회
			if (sChk_.equals("0"))
			{
				sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) AS TRANS_QTY \n");
				//sbSql.append("     , 0 AS UNDELIVERED_QTY \n"); //0으로 하니 데이타셋 칼럼크기가 1로 되더라...
				sbSql.append("     , (A.UNDELIVERED_QTY - A.UNDELIVERED_QTY) AS UNDELIVERED_QTY \n");
				sbSql.append("     , '011' AS LINE_STATUS \n");
			}
			//미입고상태로 조회(센터재고인 경우 정상입고 상태이며 수정불가)
			else
			{
				//sbSql.append("     , (A.CENTER_DELI_QTY - A.CENTER_DELI_QTY) AS TRANS_QTY \n");
				//sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) AS UNDELIVERED_QTY \n");
				//sbSql.append("     , '009' AS LINE_STATUS \n");
				sbSql.append("     , DECODE(C.SUBINV_CODE,NULL,(A.CENTER_DELI_QTY - A.CENTER_DELI_QTY),(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY)) AS TRANS_QTY \n");
				sbSql.append("     , DECODE(C.SUBINV_CODE,NULL,(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY),(A.CENTER_DELI_QTY - A.CENTER_DELI_QTY)) AS UNDELIVERED_QTY \n");
				sbSql.append("     , DECODE(C.SUBINV_CODE,NULL,'009','011') AS LINE_STATUS \n");
			}
			//이상 사용자용 자료, 이하 클레임자료
			//sbSql.append("     , 0 AS REQ_QTY \n"); //0으로 하니 데이타셋 칼럼크기가 1로 되더라...
			sbSql.append("     , (A.UNDELIVERED_QTY - A.UNDELIVERED_QTY) AS REQ_QTY \n");
			sbSql.append("     , NULL AS CLAIM_KIND, NULL AS REQ_KIND \n");
			sbSql.append("     , NULL AS REQ_DATE, NULL AS REQ_TIME, NULL AS CLAIM_MEMO \n");
			//사용자가 안보는 내부자료
			sbSql.append("     , A.PO_ID, A.RC_MU_CD, J.DEPT_ID, A.RC_UPJANG, A.SUBINV_CODE, A.ACCTCD, A.BUD_CLS, A.CUSTCD, A.TAX_CODE \n");
			sbSql.append("     , A.UNIT_PRICE, A.MARGIN_PRICE \n");
			sbSql.append("     , E.UOM_CODE, E.UOM_CONVERT_RATE \n");
			sbSql.append("     , E.POINT_FLAG, E.MIN_ORD_QTY, E.MULTIPLIER_QTY \n");
			sbSql.append("     , A.PO_TYPE, A.CENTER_CODE, A.INVAT_FLAG, A.OUTVAT_FLAG, I.PAST_FLAG, I.MINUS_FLAG, I.TYPE_NAME \n");
			sbSql.append("     , A.SALE_PRICE, A.BUDDEPT_ID \n");
			sbSql.append("     , C.SUBINV_CODE AS CT_SUBINV_CODE, C.SUBINV_CODE_OUTVAT AS CT_SUBINV_CODE_OUTVAT \n");
			sbSql.append("     , C.MRO_FLAG \n");
			sbSql.append("     , NVL(Z.PO_ID,-1) AS C_PO_ID \n");
			sbSql.append("     , Z.CLAIM_KIND AS C_CLAIM_KIND \n");
			sbSql.append("     , Z.REQ_KIND AS C_REQ_KIND \n");
			sbSql.append("     , Z.REQ_DATE AS C_REQ_DATE \n");
			sbSql.append("     , Z.REQ_TIME AS C_REQ_TIME \n");
			sbSql.append("     , Z.CLAIM_MEMO AS C_CLAIM_MEMO \n");
			sbSql.append("  FROM PO_PO A, ST_CUST C, PO_ITEM_MST E, PO_TYPE I, ST_UPJANG J \n");
			sbSql.append("     , PO_CLAIM_LIST Z \n");
			sbSql.append(" WHERE A.CUSTCD       = C.CUSTCD \n");
			sbSql.append("   AND A.ITEM_CODE    = E.ITEM_CODE \n");
			sbSql.append("   AND A.PO_TYPE      = I.PO_TYPE \n");
			sbSql.append("   AND A.RC_UPJANG    = J.UPJANG \n");
			sbSql.append("   AND A.PO_ID        = Z.PO_ID(+) \n");
			sbSql.append("   AND A.PO_NUM       = Z.PO_NUM(+) \n");
			if (sGB.equals("S"))
				sbSql.append("   AND A.SUBINV_CODE  = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			else
			{
				sbSql.append("   AND A.RC_DEPT_ID   = " + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + " \n");
				sbSql.append("   AND A.SUBINV_CODE IS NULL \n");
			}
			sbSql.append("   AND A.NEED_DATE    = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("   AND ABS(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) > 0 \n");
			sbSql.append("   AND A.LINE_STATUS BETWEEN '009' AND '010' \n");
			//검수일자가 활성화되고(자기가 조정가능), 검수일자가 현재일보다 작으면 과거소급 안되는 구매유형은 제외...
			if (sPast.equals("TRUE"))
				sbSql.append("   AND I.PAST_FLAG = 'Y' \n");
		}
		//감량대상 조회
		else if (sType.equals("AdjQry"))
		{
			sbSql.append("SELECT A.ORDER_NUM, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, C.CUSTNM \n");
			sbSql.append("     ,(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS PO_QTY \n");
			sbSql.append("     , A.DELIVERED_QTY, A.UNDELIVERED_QTY \n");
			sbSql.append("     , A.UNDELIVERED_QTY AS UNDELIVERED_QTY_OLD \n");
			sbSql.append("     ,(A.UNDELIVERED_QTY - A.UNDELIVERED_QTY) AS TRANS_QTY \n");
			//사용자가 안보는 내부자료
//			sbSql.append("     , A.PO_ID, A.RC_MU_CD, B.DEPT_ID, A.RC_UPJANG, A.SUBINV_CODE, A.ACCTCD, A.BUD_CLS, A.CUSTCD, A.TAX_CODE \n");
			sbSql.append("     , A.PO_ID, K.MU_CD AS RC_MU_CD, B.DEPT_ID, A.RC_UPJANG, A.SUBINV_CODE, A.ACCTCD, A.BUD_CLS, A.CUSTCD, A.TAX_CODE \n");
			sbSql.append("     , A.UNIT_PRICE, A.MARGIN_PRICE \n");
			sbSql.append("     , E.UOM_CODE, E.UOM_CONVERT_RATE \n");
			sbSql.append("     , A.PO_TYPE, A.CENTER_CODE, A.INVAT_FLAG, A.OUTVAT_FLAG, I.PAST_FLAG \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , A.BUDDEPT_ID \n");
			sbSql.append("     , C.SUBINV_CODE AS CT_SUBINV_CODE, C.SUBINV_CODE_OUTVAT AS CT_SUBINV_CODE_OUTVAT \n");
			sbSql.append("     , C.MRO_FLAG \n");
			sbSql.append("  FROM PO_PO A, ST_CUST C, PO_PR D, PO_ITEM_MST E, PO_TYPE I, ST_UPJANG B, SC_DEPT K \n");
			sbSql.append(" WHERE A.CUSTCD      = C.CUSTCD \n");
			sbSql.append("   AND A.PR_ID       = D.PR_ID \n");
			sbSql.append("   AND A.ITEM_CODE   = E.ITEM_CODE \n");
			sbSql.append("   AND A.PO_TYPE     = I.PO_TYPE \n");
			sbSql.append("   AND B.UPJANG      = A.RC_UPJANG \n");
			sbSql.append("   AND B.DEPT_ID     = K.DEPT_ID \n");
			if (sGB.equals("S"))
			{
				sbSql.append("   AND A.SUBINV_CODE  = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				sbSql.append("   AND C.SUBINV_CODE IS NULL \n");//센터재고 제
			}
			else
			{
				sbSql.append("   AND A.RC_DEPT_ID   = " + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + " \n");
				sbSql.append("   AND A.SUBINV_CODE IS NULL \n");
			}
			sbSql.append("   AND A.NEED_DATE    = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("   AND A.UNDELIVERED_QTY > 0 \n");
			//검수일자가 활성화되고(자기가 조정가능), 검수일자가 현재일보다 작으면 과거소급 안되는 구매유형은 제외...
			if (sPast.equals("TRUE"))
				sbSql.append("   AND I.PAST_FLAG = 'Y' \n");
		}
		//창고/부서목록 조회
		else if (sType.equals("ChkSubInvQry"))
		{
			//창고조회(자신이 관리자로 등록되어 있는 창고)
			if (sGB.equals("S"))
			{
				sbSql.append("SELECT A.SUBINV_CODE \n");
				sbSql.append("     , DECODE(A.USE_YN,'N','폐장')||A.SUBINV_CODE||' '||A.SUBINV_NAME||'('||B.UPJANGNM||')' AS SUBINV_NAME \n");
				//sbSql.append("     , A.TR_DATE_FIX_FLAG \n");
				sbSql.append("     , SUBSTR(D.CENTER_TYPE,1,2) AS CENTER_TYPE \n");
				sbSql.append("     , E.MU_CD AS MU_CD \n");
				//sbSql.append("     , NVL(A0.ATTR02, 'N') AS TR_CHK \n");
				//sbSql.append("  FROM HLDC_PO_SUBINVENTORY A, PO_ORGANIZATION A0, ST_UPJANG B \n");
				//sbSql.append("     , PO_UPJANG_CENTER C, PO_CENTER D, SC_DEPT_V E \n");
				sbSql.append("  FROM HLDC_PO_SUBINVENTORY A, HLDC_ST_UPJANG B \n");
				sbSql.append("     , HLDC_PO_UPJANG_CENTER C, HLDC_PO_CENTER D, HLDC_SC_DEPT_V E \n");
				//sbSql.append(" WHERE A.ORG_CODE = A0.ORG_CODE \n");
				//sbSql.append("   AND A.UPJANG = B.UPJANG \n");
				sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
				sbSql.append("   AND B.AP_UNITPRICE_UPJANG = C.UPJANG \n");
				sbSql.append("   AND C.CENTER_CODE = D.CENTER_CODE \n");
				sbSql.append("   AND B.DEPT_ID = E.DEPT_ID \n");
				sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
				//sbSql.append("   AND EXISTS (SELECT 1 FROM PO_SUBINV_USER Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE AND Z.SABUN = '" + g_EmpNo + "') \n");
				sbSql.append("   AND A.USE_YN = 'Y' \n");
				//sbSql.append(" ORDER BY NVL(A0.ATTR01,'ZZZ'), A.SUBINV_CODE \n");
				sbSql.append(" ORDER BY A.SUBINV_CODE \n");
				//sbSql.append(" ORDER BY A.SUBINV_NAME \n");
			}
			//부서조회(소속부서 및 자신이 관리자로 등록되어 있는 창고의 부서)
			else
			{
				sbSql.append("SELECT A.DEPT_ID AS SUBINV_CODE \n");
				sbSql.append("     , A.DEPT_NAME AS SUBINV_NAME \n");				
				sbSql.append("     , 'N' AS TR_DATE_FIX_FLAG \n");
		        sbSql.append("     , A.MU_CD AS MU_CD        \n");
		        sbSql.append("     , DECODE(A.MU_CD, 'YA', 'Y', 'N') AS TR_CHK \n");
				sbSql.append("  FROM (SELECT B.DEPT_ID \n");
				sbSql.append("             , DECODE(B.DEPT_USE,'N','(구)')||'('||B.CC_CD||')'||B.MU_NM||' '||B.CC_NM||'('||TO_CHAR(B.DEPT_ID)||')' AS DEPT_NAME \n");
				sbSql.append("             , B.MU_CD AS MU_CD \n");
				sbSql.append("             , B.DEPT_USE AS USE_YN \n");
				sbSql.append("          FROM HLDC_SC_DEPT_V B, HLDC_ST_UPJANG C \n");
				sbSql.append("         WHERE C.DEPT_ID = B.DEPT_ID \n");
				sbSql.append("           AND C.UPJANG = " + sUpjang + ") A \n");
				sbSql.append(" ORDER BY A.DEPT_ID \n");
			}
		}
		
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());		
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 
		
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);
		rs.close();
		stmt.close();

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
		if(stmt != null) {
			try {
				stmt.close();
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