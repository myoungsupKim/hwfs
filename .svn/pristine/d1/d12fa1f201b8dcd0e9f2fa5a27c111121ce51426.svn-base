<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 마감자료 > 매입결산리스트
■ 프로그램ID   : FSV00430V_T001.jsp
■ 프로그램명   : 매입결산리스트
■ 작성일자     : 2009-06-22
■ 작성자       : 박은규
■ 이력관리     : 2009-06-22 - 최초작성 박은규 CSR#(28344)
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
	String v_CenterCode = nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
	String v_CustCd     = nullToBlank(ds_Cond.getString(0, "CUSTCD"));
	String v_TrDateF    = nullToBlank(ds_Cond.getString(0, "TRANS_DATE_F"));
	String v_TrDateT    = nullToBlank(ds_Cond.getString(0, "TRANS_DATE_T"));
	String sSubinvCode = "";
	String sOnhandMonth = "";
	//IRIS DB연결
	if(conn != null && !conn.isClosed()) conn.close();
	conn = getIRISConn();
	//out 데이타
	DataSet ds_List;
	//sql문 버퍼생성
	StringBuffer sbSql = new StringBuffer();

	sbSql.delete(0, sbSql.length());
    sbSql.append("SELECT A.ATTR02 AS SUBINV_CODE    					\n");
    sbSql.append("  FROM PO_CENTER A         							\n");
    sbSql.append(" WHERE A.CENTER_CODE = '" + v_CenterCode + "'  		\n");
    sbSql.append("   AND A.USE_YN = 'Y'      							\n");
    sbSql.append("   AND A.WMS_USE = 'Y'     							\n");
	sbSql.append("   AND ROWNUM      <= 1 							\n");
out_vl.add("fa_Sql", sbSql.toString());
	pstmt = conn.prepareStatement(sbSql.toString());
	rs = pstmt.executeQuery();

	if(rs.next())
	{
		sSubinvCode = rs.getString("SUBINV_CODE");
		rs.close();
		pstmt.close();
	}
	else
	{
		rs.close();
		pstmt.close();

		out_vl.add("sSubinvCode", "연결 창코코드가 존재하지 않습니다!.");
		proc_output(response,out,out_vl,out_dl);
		//this.setResultMessage(-1, "OK", out_vl);
		return;
	}

	sbSql.delete(0, sbSql.length());
    sbSql.append("SELECT /*+ INDEX_DESC(A PO_ONHAND_MONTH_PK) */   \n");
    sbSql.append("       A.ONHAND_YM AS ONHAND_YM                  \n");
    sbSql.append("  FROM PO_ONHAND_MONTH A                         \n");
    sbSql.append(" WHERE A.ONHAND_YM < SUBSTR('" + v_TrDateF + "', 1, 6)    \n");
    sbSql.append("   AND A.SUBINV_CODE = '" + sSubinvCode + "'                \n");
    sbSql.append("   AND ROWNUM <= 1                               \n");
out_vl.add("fa_Sql", sbSql.toString());
	pstmt = conn.prepareStatement(sbSql.toString());
	rs = pstmt.executeQuery();
	if(rs.next())
	{
		sOnhandMonth = rs.getString("ONHAND_YM");
	}
	else
	{
		sOnhandMonth = "000101";
	}
	rs.close();
	pstmt.close();
	//센터재고조회
	sbSql.delete(0, sbSql.length());
    sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.PO_UOM, A.ITEM_SIZE, DECODE(A.TAX_CODE,'100','과세','210','면세','영세') AS TAX_NAME                                    \n");
    sbSql.append("     , SUM(C.TRANS_QTY  / A.UOM_CONVERT_RATE) AS TRANS_QTY                                                                                                 \n");
    sbSql.append("     , SUM(C.IN_QTY / A.UOM_CONVERT_RATE) AS IN_QTY                                                                                                        \n");
    sbSql.append("     , SUM(C.OUT_QTY / A.UOM_CONVERT_RATE) AS OUT_QTY                                                                                                      \n");
    sbSql.append("     , SUM(C.TRANS_QTY / A.UOM_CONVERT_RATE) + SUM(IN_QTY / A.UOM_CONVERT_RATE) - SUM(C.OUT_QTY / A.UOM_CONVERT_RATE) AS RMN_QTY                           \n");
    sbSql.append("  FROM PO_ITEM_MST A                                                                                                                                       \n");
    sbSql.append("     , (SELECT A.ITEM_CODE                                                                                                                                 \n");
    sbSql.append("          FROM PO_CUSTOM_ITEM A                                                                                                                            \n");
    sbSql.append("             , (SELECT E.CENTER_CODE, E.CUSTCD, E.ITEM_CODE, D.CONTRACT_PRICE                                                                              \n");
    sbSql.append("                  FROM PO_CONTRACT_F D                                                                                                                     \n");
    sbSql.append("                     ,(SELECT F.CENTER_CODE, F.CUSTCD, F.ITEM_CODE, MAX(F.CONTRACT_START) AS CONTRACT_START                                                \n");
    sbSql.append("                         FROM PO_CONTRACT_F F                                                                                                              \n");
    sbSql.append("                        WHERE F.CENTER_CODE = 300001                                                                                                       \n");
    sbSql.append("                          AND F.CUSTCD = 418579                                                                                                            \n");
    sbSql.append("                          AND F.CONTRACT_START <= TO_CHAR(SYSDATE,'YYYYMMDD')                                                                              \n");
    sbSql.append("                          AND F.USE_YN = 'Y'                                                                                                               \n");
    sbSql.append("                        GROUP BY F.CENTER_CODE, F.CUSTCD, F.ITEM_CODE) E                                                                                   \n");
    sbSql.append("                 WHERE D.CENTER_CODE = E.CENTER_CODE                                                                                                       \n");
    sbSql.append("                   AND D.CUSTCD = E.CUSTCD                                                                                                                 \n");
    sbSql.append("                   AND D.ITEM_CODE = E.ITEM_CODE                                                                                                           \n");
    sbSql.append("                   AND D.CONTRACT_START = E.CONTRACT_START) C                                                                                              \n");
    sbSql.append("         WHERE A.CENTER_UPJANG = C.CENTER_CODE(+)                                                                                                          \n");
    sbSql.append("           AND A.CUSTCD = C.CUSTCD(+)                                                                                                                      \n");
    sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                                                \n");
    sbSql.append("           AND A.CENTER_UPJANG = '" + v_CenterCode + "'                                                                                                                         \n");
    sbSql.append("           AND A.CUSTCD = '" + v_CustCd + "'                                                                                                                                 \n");
    sbSql.append("           AND A.USE_TYPE = '01') B                                                                                                                        \n");
    sbSql.append("     , (SELECT ITEM_CODE                                                                                                                                   \n");
    sbSql.append("             , ONHAND_QTY    AS TRANS_QTY                                                                                                                  \n");
    sbSql.append("             , 0             AS IN_QTY                                                                                                                     \n");
    sbSql.append("             , 0             AS OUT_QTY                                                                                                                    \n");
    sbSql.append("          FROM PO_ONHAND_MONTH                                                                                                                             \n");
    sbSql.append("         WHERE ONHAND_YM   = '" + sOnhandMonth + "'                                                                                                                      \n");
    sbSql.append("           AND SUBINV_CODE = '" + sSubinvCode + "'                                                                                                                            \n");
    sbSql.append("         UNION ALL                                                                                                                                         \n");
    sbSql.append("        SELECT ITEM_CODE                                                                                                                                   \n");
    sbSql.append("             , SUM(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * UOM_QTY)       AS TRANS_QTY                                                                   \n");
    sbSql.append("             , 0             AS IN_QTY                                                                                                                     \n");
    sbSql.append("             , 0             AS OUT_QTY                                                                                                                    \n");
    sbSql.append("          FROM PO_TRANSACTION                                                                                                                              \n");
    sbSql.append("         WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND TO_CHAR(TO_DATE('" + v_TrDateF + "','YYYYMMDD') - 1,'YYYYMMDD') \n");
    sbSql.append("           AND SUBINV_CODE = '" + sSubinvCode + "'                                                                                                                            \n");
    sbSql.append("         GROUP BY ITEM_CODE                                                                                                                                \n");
    sbSql.append("         UNION ALL                                                                                                                                         \n");
    sbSql.append("        SELECT ITEM_CODE                                                                                                                                   \n");
    sbSql.append("             , 0                  AS TRANS_QTY                                                                                                             \n");
    sbSql.append("             , SUM(UOM_QTY)       AS IN_QTY                                                                                                                \n");
    sbSql.append("             , 0                  AS OUT_QTY                                                                                                               \n");
    sbSql.append("          FROM PO_TRANSACTION                                                                                                                              \n");
    sbSql.append("         WHERE TRANS_DATE BETWEEN '" + v_TrDateF + "' AND '" + v_TrDateT + "'                                                                                                \n");
    sbSql.append("           AND SUBINV_CODE = '" + sSubinvCode + "'                                                                                                                              \n");
    sbSql.append("           AND TRANS_TYPE LIKE 'I%'                                                                                                                        \n");
    sbSql.append("         GROUP BY ITEM_CODE                                                                                                                                \n");
    sbSql.append("         UNION ALL                                                                                                                                         \n");
    sbSql.append("        SELECT ITEM_CODE                                                                                                                                   \n");
    sbSql.append("             , 0                  AS TRANS_QTY                                                                                                             \n");
    sbSql.append("             , 0                  AS IN_QTY                                                                                                                \n");
    sbSql.append("             , SUM(UOM_QTY)       AS OUT_QTY                                                                                                               \n");
    sbSql.append("          FROM PO_TRANSACTION                                                                                                                              \n");
    sbSql.append("         WHERE TRANS_DATE BETWEEN '" + v_TrDateF + "' AND '" + v_TrDateT + "'                                                                                                \n");
    sbSql.append("           AND SUBINV_CODE = '" + sSubinvCode + "'                                                                                                                            \n");
    sbSql.append("           AND TRANS_TYPE LIKE 'O%'                                                                                                                        \n");
    sbSql.append("         GROUP BY ITEM_CODE) C                                                                                                                             \n");
    sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                           \n");
    sbSql.append("   AND B.ITEM_CODE = C.ITEM_CODE                                                                                                                           \n");
    sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.PO_UOM, A.ITEM_SIZE, DECODE(A.TAX_CODE,'100','과세','210','면세','영세')                                             \n");
out_vl.add("fa_Sql", sbSql.toString());
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