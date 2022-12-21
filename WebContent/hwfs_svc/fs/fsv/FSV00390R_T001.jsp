<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 발주서 > 배송분류표
■ 프로그램ID   : FSV00390R_T001.jsp
■ 프로그램명   : 배송분류표 출력(조회)
■ 작성일자     : 2008-08-28
■ 작성자       : 박은규
■ 이력관리     : 2008-08-28 - 최초작성
               2009-06-02 박은규 Incident#(115984) 요청자:박량우(경인물류센터)
               라벨수량,체크박스,출력여부 추가
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_CustCd     = nullToBlank(in_vl.getString("g_CustCd"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));

		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//집계조회
		if (sType.equals("HdrQry"))
		{
			sbSql.append("SELECT A.CENTER_CODE, REPLACE(C.CENTER_NAME,'센터','') CENTER_NAME \n");
			
			sbSql.append("     , (SELECT Z.CODE_NAME FROM PO_CODE Z WHERE Z.CODE = NVL(A.ORDER_SEQ,'000') AND Z.GROUP_CODE = '012') AS ORDER_CODE \n");
			sbSql.append("     , A.ORDER_NUM \n");
			
			sbSql.append("     , DECODE(A.CENTER_FLAG,'N','Y') AS CENTER_FLAG \n");
			sbSql.append("     , MAX(A.ITEM_NAME)||DECODE(SIGN(COUNT(*) - 1),1,' 외 '||TO_CHAR(COUNT(*) - 1)||'종') AS ITEM_NAME \n");
			sbSql.append("     , SUM(ROUND(A.UNIT_PRICE * (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY))) AS AMOUNT \n");
			sbSql.append("     , NVL(B.PRT_FLAG,'N') AS PRT_FLAG \n");
			sbSql.append("     , TO_CHAR(B.PRT_TIME,'YYYY-MM-DD HH24:MI') AS PRT_TIME \n");
			sbSql.append("     , '0' AS CHK \n");
			
			sbSql.append("     , A.ORDER_QTY AS PRE_ORD_QTY \n");
			
			sbSql.append("     , MAX(ROUND(A.ORDER_QTY * A.UNIT_PRICE)) AS PRE_ORDER_AMT \n");

			sbSql.append("  FROM PO_PO A, PO_CENTER C \n");
			sbSql.append("     ,(SELECT * FROM PO_ORDER_PRT \n");
			sbSql.append("        WHERE CUSTCD = '" + g_CustCd + "' \n");
			sbSql.append("          AND NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "') B \n");
			sbSql.append(" WHERE A.ORDER_NUM = B.ORDER_NUM(+) \n");
			sbSql.append("   AND A.NEED_DATE = B.NEED_DATE(+) \n");
			sbSql.append("   AND A.CENTER_CODE = C.CENTER_CODE \n");
			sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("   AND A.CUSTCD = '" + g_CustCd + "' \n");
			sbSql.append("   AND A.LINE_STATUS >= '008' \n");
			sbSql.append("   AND (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) <> 0 \n");
			sbSql.append(" GROUP BY A.CENTER_CODE, C.CENTER_NAME, A.ORDER_SEQ, A.ORDER_NUM, A.CENTER_FLAG, B.PRT_FLAG, B.PRT_TIME, A.ORDER_QTY \n");
		}
		//상세조회
		else if (sType.equals("DtlQry"))
		{
			//sbSql.append("SELECT PO_GETREGION_FUN(A.RC_UPJANG,A.SUBINV_CODE) AS REGION_NAME \n");
			//sbSql.append("SELECT PO_GETREGION_FUN(A.RC_UPJANG,A.NEED_DATE) AS REGION_NAME \n");
			
			sbSql.append("SELECT PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE) AS REGION_NAME \n");
			sbSql.append("     , (SELECT Z.REMARK FROM PO_CODE Z WHERE Z.CODE = NVL(A.ORDER_SEQ,'000') AND Z.GROUP_CODE = '012') AS ORDER_CODE \n");
			sbSql.append("     , A.RC_UPJANG AS UPJANG \n");			
			sbSql.append("     , TRIM(REPLACE(B.UPJANGNM, '단체급식'))||'('||C.SUBINV_NAME||')' AS UPJANGNM \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE \n");			
			sbSql.append("     , (SELECT Z.KEEPING_TYPE FROM PO_ITEM_MST Z WHERE Z.ITEM_CODE = A.ITEM_CODE) AS KEEPING_TYPE                         \n");
			sbSql.append("     ,(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS ORD_QTY \n");
			sbSql.append("     , A.PO_UOM \n");			
			sbSql.append("     , A.UNIT_PRICE \n");			
			sbSql.append("     , A.ORDER_QTY AS PRE_ORD_QTY \n");			
			sbSql.append("     , ROUND(A.UNIT_PRICE * (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY)) AS ORD_AMT \n");
			sbSql.append("     , A.PR_REMARK \n");
//============================================================================================
//(2009-06-02 추가) 시작
// 2009-06-02 박은규 Incident#(115984) 요청자:박량우(경인물류센터)
// 라벨수량,체크박스,출력여부 추가
//============================================================================================
			sbSql.append("     , '1' AS CHK \n");
			sbSql.append("     , DECODE(NVL(D.BOXING_QTY,0),0,1,CEIL((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY)/D.BOXING_QTY)) AS LABEL_CNT \n");
			sbSql.append("     , NVL((SELECT Z.USE_YN FROM PO_ORDERLINE_PRT Z WHERE Z.PO_ID = A.PO_ID),'N') AS PRT_FLAG \n");
			sbSql.append("     , (SELECT TO_CHAR(Z.UPDATE_DATE,'YYYY-MM-DD HH24:MI') FROM PO_ORDERLINE_PRT Z WHERE Z.PO_ID = A.PO_ID) AS PRT_TIME \n");
			sbSql.append("     , TO_CHAR(A.PO_ID) AS PO_ID \n");
//============================================================================================
//(2009-06-02 추가) 끝
//============================================================================================
			sbSql.append("     , DECODE(MOD(TO_NUMBER(PO_GETREGION_FUN(C.SHIP_ID,A.NEED_DATE,'3')),2), 0, 'Y', 'N') AS CLASSIFY \n");
			sbSql.append("     , TRIM(TO_CHAR(A.PO_ID,'0000000000')) \n");
			sbSql.append("           || REPLACE(TRIM(TO_CHAR(\n");
			sbSql.append("                            DECODE( DECODE(NVL(F.BOXING_QTY,0),0,1,CEIL((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY)/F.BOXING_QTY))\n");
			sbSql.append("                                  , TO_NUMBER(G.CODE_NAME), DECODE(MOD(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY,NVL(F.BOXING_QTY,0)),0,NVL(F.BOXING_QTY,0),MOD(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY,NVL(F.BOXING_QTY,0)))\n");
			sbSql.append("                                  , NVL(F.BOXING_QTY,0)\n");
			sbSql.append("                               )\n");
			sbSql.append("                           ,'0000.0')),'.') AS BARCODE\n");
			sbSql.append("  FROM PO_PO A, ST_UPJANG B, PO_SUBINVENTORY C \n");
			sbSql.append("     , PO_ITEM_HIST D \n");
			sbSql.append("     , PO_ITEM_HIST F, (SELECT * FROM PO_CODE WHERE GROUP_CODE  = 'CNT') G\n");
			sbSql.append(" WHERE A.RC_UPJANG   = B.UPJANG \n");
			sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
			sbSql.append("   --- \n");
			sbSql.append("   AND A.CENTER_CODE = D.CENTER_CODE(+) \n");
			sbSql.append("   AND A.CUSTCD = D.CUSTCD(+) \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
			sbSql.append("   --- \n");
			sbSql.append("   AND A.CENTER_CODE = F.CENTER_CODE(+) \n");
			sbSql.append("   AND A.CUSTCD      = F.CUSTCD(+) \n");
			sbSql.append("   AND A.ITEM_CODE   = F.ITEM_CODE(+) \n");
			sbSql.append("   AND G.CODE = '00001'\n");
			//바코드는 배송 단위에 따라 달라지는데 예를 들어 33Kg을 주문했는데 배송단위가 10이면
			//나머지 3kg의 배송에 대해선 바코드가 달라진다. 그러나 여기전 나머지의 다른 바코드는 무시하기로 함.
			//그래서 G.CODE = '00001' 인 것만 바코드로 출력함.
			sbSql.append("   --- \n");
			sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' \n");
			sbSql.append("   AND (A.CENTER_CODE,A.ORDER_NUM) IN (" + nullToBlank(ds_Cond.getString(0, "ORDER_NUM")) + ") \n");
			//sbSql.append("   AND A.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + " \n");
			sbSql.append("   AND A.CUSTCD = '" + g_CustCd + "' \n");
			if (! nullToBlank(ds_Cond.getString(0, "ITEM_NAME")).equals(""))
				sbSql.append("   AND A.ITEM_NAME LIKE '%" + nullToBlank(ds_Cond.getString(0, "ITEM_NAME")) + "%' \n");
//			sbSql.append("   AND A.LINE_STATUS = DECODE(A.CENTER_FLAG,'Y','008','009') \n");
			sbSql.append("   AND A.LINE_STATUS >= '008' \n");
			sbSql.append("   AND (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) <> 0 \n");
			sbSql.append(" ORDER BY " + nullToBlank(ds_Cond.getString(0, "ORDER_TYPE")) + " \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 
		
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		stmt.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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