<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/구매관리/입고관리
■ 프로그램ID   : FSP00130E_T002.jsp
■ 프로그램명   : 자재입고 및 클레임등록(저장)
■ 작성일자     : 2008-03-19
■ 작성자       : 박은규
■ 이력관리     : 2008-03-19 - 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;
	PreparedStatement pstmt4 = null;
	PreparedStatement pstmt4_1 = null;
	PreparedStatement pstmt5 = null;
	PreparedStatement pstmt6 = null;
	PreparedStatement pstmt7 = null;
	PreparedStatement pstmt8 = null;
	PreparedStatement pstmt9 = null;
	PreparedStatement pstmt10 = null;
	PreparedStatement pstmt11 = null;
	Statement stmt            = null;	

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//오토커밋 강제 false
		conn.setAutoCommit(false);

		//입력 데이타
		DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sGB          = nullToBlank(in_vl.getString("sGB"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sTransDate   = nullToBlank(in_vl.getString("sTransDate"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_iud);
	
		String sTrNum       = "";
		String sCTSubinv    = "";
		String sOUTVAT      = "";
		String sLineStat    = "";
		String sMroFlag     = "";
		String sTrans_ID    = "";
		String sClaimKind   = "";
	

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//구매검수번호 가져오기
		sbSql.delete(0, sbSql.length());
//		sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(PO_TR_NUM_S.NEXTVAL,4,'0') AS TRNUM \n");
		sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(PO_TR_NUM_S.NEXTVAL,5,'0') AS TRNUM \n");
		sbSql.append("  FROM DUAL \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//jsp 로그남기기
		//logger.debug(sbSql.toString());
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 		
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();

//		if(! rs.next())
//		{
//			out_vl.add("v_ErrMsg", "구매검수번호 생성오류...\n관리자에게 연락하세요.");
//			this.setResultMessage(0, "OK", out_vl);
//			proc_output(response,out,out_vl,out_dl);
//			return;
//		}
		rs.next();
		sTrNum = rs.getString("TRNUM");
		
		rs.close();
		stmt.close();

		//배치등록
		//검수자료(센터재고품목)
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========1.검수자료(센터재고품목)======== \n");
		sbSql.append("INSERT INTO PO_TRANSACTION \n");
		sbSql.append("( TRANS_ID \n");
		sbSql.append(", TRANS_TYPE \n");
		sbSql.append(", TRANS_DATE \n");
		sbSql.append(", SOURCE_TYPE \n");
		sbSql.append(", SOURCE_ID \n");
		sbSql.append(", TRANS_MU_CD \n");
		sbSql.append(", TRANS_DEPT_ID \n");
		sbSql.append(", TRANS_UPJANG \n");
		sbSql.append(", SUBINV_CODE \n");
		sbSql.append(", BUDDEPT_ID \n");
		sbSql.append(", ACCTCD \n");
		sbSql.append(", BUD_CLS \n");
		sbSql.append(", ITEM_CODE \n");
		sbSql.append(", ITEM_NAME \n");
		sbSql.append(", ITEM_SIZE \n");
		sbSql.append(", TAX_CODE \n");
		sbSql.append(", TRANS_UOM \n");
		sbSql.append(", TRANS_QTY \n");
		sbSql.append(", TRANS_UPRICE \n");
		sbSql.append(", TRANS_UAMOUNT \n");
		sbSql.append(", TRANS_MPRICE \n");
		sbSql.append(", TRANS_MAMOUNT \n");
		sbSql.append(", SALE_PRICE \n");
		sbSql.append(", SALE_AMOUNT \n");
		sbSql.append(", UOM_CODE \n");
		sbSql.append(", UOM_QTY \n");
		sbSql.append(", UNIT_PRICE \n");
		sbSql.append(", UNIT_AMOUNT \n");
		sbSql.append(", MARGIN_PRICE \n");
		sbSql.append(", MARGIN_AMOUNT \n");
		sbSql.append(", CUSTCD \n");
		sbSql.append(", TR_NUM \n");
		sbSql.append(", SHELF_LIFE_DATE \n");
		sbSql.append(", PO_TYPE \n");
		sbSql.append(", CENTER_CODE \n");
		sbSql.append(", INVAT_FLAG \n");
		sbSql.append(", OUTVAT_FLAG \n");
		sbSql.append(", REMARK \n");
		sbSql.append(", PARENT_TRANS_ID \n");
		sbSql.append(", CREATE_BY \n");
		sbSql.append(", UPDATE_BY ) \n");
		sbSql.append("SELECT ? \n");
		sbSql.append("     , 'I002' \n");
		sbSql.append("     , A.TRANS_DATE \n");
		sbSql.append("     , 'PO' \n");
		sbSql.append("     , A.SOURCE_ID \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , NVL(?,' ') \n");
		sbSql.append("     , A.ITEM_CODE \n");
		sbSql.append("     , A.ITEM_NAME \n");
		sbSql.append("     , A.ITEM_SIZE \n");
		sbSql.append("     , A.TAX_CODE \n");
		sbSql.append("     , A.TRANS_UOM \n");
		sbSql.append("     , A.TRANS_QTY \n");
		sbSql.append("     , A.TRANS_UPRICE \n");
		sbSql.append("     , A.TRANS_UAMOUNT \n");
		sbSql.append("     , A.TRANS_MPRICE \n");
		sbSql.append("     , A.TRANS_MAMOUNT \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ROUND(? * ?) \n");
		sbSql.append("     , A.UOM_CODE \n");
		sbSql.append("     , A.UOM_QTY \n");
		sbSql.append("     , A.UNIT_PRICE \n");
		sbSql.append("     , A.UNIT_AMOUNT \n");
		sbSql.append("     , A.MARGIN_PRICE \n");
		sbSql.append("     , A.MARGIN_AMOUNT \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , NULL \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , '구매이관입고<<<'||A.SUBINV_CODE \n");
		sbSql.append("     , A.TRANS_ID \n");
		sbSql.append("     , ? \n");
		sbSql.append("     , ? \n");
		sbSql.append("  FROM PO_TRANSACTION A \n");
		sbSql.append(" WHERE A.TRANS_DATE  = ? \n");
		sbSql.append("   AND A.SUBINV_CODE = ? \n");
		sbSql.append("   AND A.ITEM_CODE   = ? \n");
		sbSql.append("   AND A.TRANS_TYPE  = 'O002' \n");
		sbSql.append("   AND A.SOURCE_ID   = ? \n");
		pstmt1 = conn.prepareStatement(sbSql.toString());

		//검수자료(비 센터재고품목)
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========1.검수자료(비 센터재고품목)======== \n");
		sbSql.append("INSERT INTO PO_TRANSACTION \n");
		sbSql.append("( TRANS_ID \n");
		sbSql.append(", TRANS_TYPE \n");
		sbSql.append(", TRANS_DATE \n");
		sbSql.append(", SOURCE_TYPE \n");
		sbSql.append(", SOURCE_ID \n");
		sbSql.append(", TRANS_MU_CD \n");
		sbSql.append(", TRANS_DEPT_ID \n");
		sbSql.append(", TRANS_UPJANG \n");
		sbSql.append(", SUBINV_CODE \n");
		sbSql.append(", BUDDEPT_ID \n");
		sbSql.append(", ACCTCD \n");
		sbSql.append(", BUD_CLS \n");
		sbSql.append(", ITEM_CODE \n");
		sbSql.append(", ITEM_NAME \n");
		sbSql.append(", ITEM_SIZE \n");
		sbSql.append(", TAX_CODE \n");
		sbSql.append(", TRANS_UOM \n");
		sbSql.append(", TRANS_QTY \n");
		sbSql.append(", TRANS_UPRICE \n");
		sbSql.append(", TRANS_UAMOUNT \n");
		sbSql.append(", TRANS_MPRICE \n");
		sbSql.append(", TRANS_MAMOUNT \n");
		sbSql.append(", SALE_PRICE \n");
		sbSql.append(", SALE_AMOUNT \n");
		sbSql.append(", UOM_CODE \n");
		sbSql.append(", UOM_QTY \n");
		sbSql.append(", UNIT_PRICE \n");
		sbSql.append(", UNIT_AMOUNT \n");
		sbSql.append(", MARGIN_PRICE \n");
		sbSql.append(", MARGIN_AMOUNT \n");
		sbSql.append(", CUSTCD \n");
		sbSql.append(", TR_NUM \n");
		sbSql.append(", SHELF_LIFE_DATE \n");
		sbSql.append(", PO_TYPE \n");
		sbSql.append(", CENTER_CODE \n");
		sbSql.append(", INVAT_FLAG \n");
		sbSql.append(", OUTVAT_FLAG \n");
		sbSql.append(", REMARK \n");
		sbSql.append(", CREATE_BY \n");
		sbSql.append(", UPDATE_BY ) VALUES \n");
		sbSql.append(" ( ? \n");
		sbSql.append(", 'I001' \n");
		sbSql.append(", ? \n");
		sbSql.append(", 'PO' \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", NVL(?,' ') \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ROUND(? * ?) \n");
		sbSql.append(", ? \n");
		sbSql.append(", ROUND(? * ?) \n");
		sbSql.append(", ? \n");
		sbSql.append(", ROUND(? * ?) \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? * ? \n");
		sbSql.append(", ? / ? \n");
		sbSql.append(", ROUND(? * ?) \n");
		sbSql.append(", ? / ? \n");
		sbSql.append(", ROUND(? * ?) \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", NULL \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? ) \n");
		pstmt2 = conn.prepareStatement(sbSql.toString());

		//센터재고인 경우 검수대기목록에서 삭제
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========센터재고 검수대기목록 삭제======== \n");
		sbSql.append("DELETE FROM PO_CENTER_TR \n");
		sbSql.append(" WHERE TRANS_ID = \n");
		sbSql.append("      (SELECT TRANS_ID FROM PO_TRANSACTION \n");
		sbSql.append("        WHERE TRANS_DATE  = ? \n");
		sbSql.append("          AND SUBINV_CODE = ? \n");
		sbSql.append("          AND ITEM_CODE   = ? \n");
		sbSql.append("          AND TRANS_TYPE  = 'O002' \n");
		sbSql.append("          AND SOURCE_ID   = ?) \n");
		pstmt3 = conn.prepareStatement(sbSql.toString());

		//========1-1.MRO INTERFACE(검수)=========
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========1-1.MRO INTERFACE(검수)======== \n");
		sbSql.append("INSERT INTO MRO_V_IHWGR_HLDC \n");
		sbSql.append("( STATUS \n");
		sbSql.append(", COMPANY_CODE \n");
		sbSql.append(", YEAR \n");
		sbSql.append(", GR_NO \n");
		sbSql.append(", GR_SEQ \n");
		sbSql.append(", PO_NO \n");
		sbSql.append(", PO_SEQ \n");
		sbSql.append(", ITEM_CODE \n");
		sbSql.append(", ITEM_NAME \n");
		sbSql.append(", SPECIFICATION \n");
		sbSql.append(", GR_QTY \n");
		sbSql.append(", UNIT_CODE \n");
		sbSql.append(", UNIT_PRICE \n");
		sbSql.append(", CURRENCY \n");
		sbSql.append(", RECEIVING_AMOUNT \n");
		sbSql.append(", GR_DATE \n");
		sbSql.append(", WA_CODE \n");
		sbSql.append(", DIVISION_CODE \n");
		sbSql.append(", DEPT_CODE \n");
		sbSql.append(", PO_STATUS \n");
		sbSql.append(", CREATE_DATE \n");
		sbSql.append(", CREATOR \n");
		sbSql.append(", CHANGE_DATE \n");
		sbSql.append(", CHANGER \n");
		sbSql.append(", INTERFACE_DATE \n");
		sbSql.append(", INTERFACE_FLAG \n");
		sbSql.append(", ERROR_REASON \n");
		sbSql.append(", ERROR_REASON_DATE \n");
		sbSql.append(", DELETE_FLAG ) \n");
		sbSql.append("VALUES \n");
		sbSql.append("( 'C' \n");
		sbSql.append(", 'HLDC' \n");
		sbSql.append(", SUBSTR(?,1,4) \n");
		sbSql.append(", ? \n");
		sbSql.append(", TO_CHAR(TO_NUMBER(?)) \n");
		sbSql.append(", ? \n");
		sbSql.append(", TO_CHAR(TO_NUMBER(?)) \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", 'KRW' \n");
		sbSql.append(", ROUND(? * ?) \n");
		sbSql.append(", TO_DATE(?,'YYYYMMDD') \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", TO_CHAR(TO_NUMBER(?)) \n");
		sbSql.append(", ? \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(", ? \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(", ? \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(", 'N' \n");
		sbSql.append(", NULL \n");
		sbSql.append(", NULL \n");
		sbSql.append(", 'N' ) \n");
		pstmt4 = conn.prepareStatement(sbSql.toString());

		//========1-1.MRO INTERFACE(전체감량)=========
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========1-1.MRO INTERFACE(전체감량)======== \n");
        sbSql.append("INSERT INTO MRO_V_IHWPO_HLDC                              \n");
        sbSql.append("( STATUS                                                  \n");
        sbSql.append(", PO_NO                                                   \n");
        sbSql.append(", PO_SEQ                                                  \n");
        sbSql.append(", ITEM_CODE                                               \n");
        sbSql.append(", ITEM_NAME                                               \n");
        sbSql.append(", SPECIFICATION                                           \n");
        sbSql.append(", MAKER_NAME                                              \n");
        sbSql.append(", MODEL_NO                                                \n");
        sbSql.append(", SP_CODE                                                 \n");
        sbSql.append(", SP_NAME                                                 \n");
        sbSql.append(", PO_DATE                                                 \n");
        sbSql.append(", REQ_DELIVERY_DATE                                       \n");
        sbSql.append(", RUSH_ORDER_FLAG                                         \n");
        sbSql.append(", PO_CREATOR_ID                                           \n");
        sbSql.append(", PO_CREATOR_NAME                                         \n");
        sbSql.append(", PO_CREATOR_TEL_NO                                       \n");
        sbSql.append(", RECEIVER_ID                                             \n");
        sbSql.append(", RECEIVER_NAME                                           \n");
        sbSql.append(", RECEIVER_TEL_NO                                         \n");
        sbSql.append(", RECEIVER_HP_NO                                          \n");
        sbSql.append(", DELIVERY_ZIP_CODE                                       \n");
        sbSql.append(", DELIVERY_ADDRESS_1                                      \n");
        sbSql.append(", DELIVERY_ADDRESS_2                                      \n");
        sbSql.append(", REQ_INFO                                                \n");
        sbSql.append(", INVEST_NO                                               \n");
        sbSql.append(", COMPANY_CODE                                            \n");
        sbSql.append(", WA_CODE                                                 \n");
        sbSql.append(", DIVISION_CODE                                           \n");
        sbSql.append(", DEPT_CODE                                               \n");
        sbSql.append(", BUDGET_WA_CODE                                          \n");
        sbSql.append(", BUDGET_DIVISION_CODE                                    \n");
        sbSql.append(", BUDGET_DEPT_CODE                                        \n");
        sbSql.append(", ACCOUNT_CODE                                            \n");
        sbSql.append(", PO_QTY                                                  \n");
        sbSql.append(", UNIT_CODE                                               \n");
        sbSql.append(", SALES_PRICE                                             \n");
        sbSql.append(", SALES_AMOUNT                                            \n");
        sbSql.append(", SALES_CURRENCY                                          \n");
        sbSql.append(", SALES_EXCHANGE_RATE                                     \n");
        sbSql.append(", CREATE_DATE                                             \n");
        sbSql.append(", CREATOR                                                 \n");
        sbSql.append(", CHANGE_DATE                                             \n");
        sbSql.append(", CHANGER                                                 \n");
        sbSql.append(", INTERFACE_DATE                                          \n");
        sbSql.append(", INTERFACE_FLAG                                          \n");
        sbSql.append(", ERROR_REASON                                            \n");
        sbSql.append(", ERROR_REASON_DATE                                       \n");
        sbSql.append(", DELETE_FLAG )                                           \n");
        sbSql.append("SELECT 'D' AS STATUS                                      \n");
        sbSql.append("     , A.PO_NO                                            \n");
        sbSql.append("     , A.PO_SEQ                                           \n");
        sbSql.append("     , A.ITEM_CODE                                        \n");
        sbSql.append("     , A.ITEM_NAME                                        \n");
        sbSql.append("     , A.SPECIFICATION                                    \n");
        sbSql.append("     , A.MAKER_NAME                                       \n");
        sbSql.append("     , A.MODEL_NO                                         \n");
        sbSql.append("     , A.SP_CODE                                          \n");
        sbSql.append("     , A.SP_NAME                                          \n");
        sbSql.append("     , A.PO_DATE                                          \n");
        sbSql.append("     , A.REQ_DELIVERY_DATE                                \n");
        sbSql.append("     , A.RUSH_ORDER_FLAG                                  \n");
        sbSql.append("     , A.PO_CREATOR_ID                                    \n");
        sbSql.append("     , A.PO_CREATOR_NAME                                  \n");
        sbSql.append("     , A.PO_CREATOR_TEL_NO                                \n");
        sbSql.append("     , A.RECEIVER_ID                                      \n");
        sbSql.append("     , A.RECEIVER_NAME                                    \n");
        sbSql.append("     , A.RECEIVER_TEL_NO                                  \n");
        sbSql.append("     , A.RECEIVER_HP_NO                                   \n");
        sbSql.append("     , A.DELIVERY_ZIP_CODE                                \n");
        sbSql.append("     , A.DELIVERY_ADDRESS_1                               \n");
        sbSql.append("     , A.DELIVERY_ADDRESS_2                               \n");
        sbSql.append("     , A.REQ_INFO                                         \n");
        sbSql.append("     , A.INVEST_NO                                        \n");
        sbSql.append("     , A.COMPANY_CODE                                     \n");
        sbSql.append("     , A.WA_CODE                                          \n");
        sbSql.append("     , A.DIVISION_CODE                                    \n");
        sbSql.append("     , A.DEPT_CODE                                        \n");
        sbSql.append("     , A.BUDGET_WA_CODE                                   \n");
        sbSql.append("     , A.BUDGET_DIVISION_CODE                             \n");
        sbSql.append("     , A.BUDGET_DEPT_CODE                                 \n");
        sbSql.append("     , A.ACCOUNT_CODE                                     \n");
        sbSql.append("     , A.PO_QTY                                           \n");
        sbSql.append("     , A.UNIT_CODE                                        \n");
        sbSql.append("     , A.SALES_PRICE                                      \n");
        sbSql.append("     , A.SALES_AMOUNT                                     \n");
        sbSql.append("     , A.SALES_CURRENCY                                   \n");
        sbSql.append("     , A.SALES_EXCHANGE_RATE                              \n");
        sbSql.append("     , SYSDATE AS CREATE_DATE                             \n");
        sbSql.append("     , ? AS CREATOR                                       \n");
        sbSql.append("     , SYSDATE AS CHANGE_DATE                             \n");
        sbSql.append("     , ? AS CHANGER                                       \n");
        sbSql.append("     , SYSDATE AS INTERFACE_DATE                          \n");
        sbSql.append("     , 'N' AS INTERFACE_FLAG                              \n");
        sbSql.append("     , NULL AS ERROR_REASON                               \n");
        sbSql.append("     , NULL AS ERROR_REASON_DATE                          \n");
        sbSql.append("     , 'N' AS DELETE_FLAG                                 \n");
        sbSql.append("  FROM MRO_V_IHWPO_HLDC A                                 \n");
        sbSql.append(" WHERE A.PO_SEQ = ?                                       \n");
        sbSql.append("   AND ROWNUM <= 1                                        \n");
		pstmt4_1 = conn.prepareStatement(sbSql.toString());

		//1-2식권인 경우 식권자동 입고처리===========================================	
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========1-2식권자동입고======== \n");
		sbSql.append("    INSERT INTO HWFS_MAS_TICKET_MST( \n");
		sbSql.append("                        TICKET_SEQ, \n");
		sbSql.append("                        TICKET_GROUP_SEQ, \n");
		sbSql.append("                        UPJANG, \n");
		sbSql.append("                        ITEM_TYPE, \n");
		sbSql.append("                        ITEM_CODE, \n");
		sbSql.append("                        TRANS_DD, \n");
		sbSql.append("                        TRANS_TYPE, \n");
		sbSql.append("                        TRANS_GUBUN, \n");
		sbSql.append("                        UPRICE, \n");
		sbSql.append("                        QTY, \n");
		sbSql.append("                        TICKET_STARTNUM, \n");
		sbSql.append("                        TICKET_ENDNUM, \n");
		sbSql.append("                        REMARK_DESC, \n");
		sbSql.append("                        AUTO_GUBUN, \n");
		sbSql.append("                        AUTO_KIND, \n");
		sbSql.append("                        SOURCE_ID, \n");
		sbSql.append("                        CUSER, \n");
		sbSql.append("                        CDATE \n");
		sbSql.append("                      ) \n");
		sbSql.append("    SELECT  HWFS_MAS_TICKET_MST_S.NEXTVAL, \n");
		sbSql.append("            HWFS_MAS_TICKET_MST_GROUP_S.NEXTVAL, \n");
		sbSql.append("            V.UPJANG, \n");
		sbSql.append("            V.ITEM_TYPE, \n");
		sbSql.append("            V.ITEM_CODE, \n");
		sbSql.append("            ?, \n");
		sbSql.append("            (SELECT TRANS_TYPE  FROM HWFS_MAS_TICKET_CODE  WHERE TRANS_GUBUN = 'II'), \n");
		sbSql.append("            'II', \n");
		sbSql.append("            NVL(V.UPRICE, 0), \n");
		sbSql.append("            NVL(?, 0), --수량 \n");
		sbSql.append("            NVL((SELECT NVL(MAX(TICKET_ENDNUM), 0) + 1 TICKET_MAXNUM  FROM HWFS_MAS_TICKET_MST WHERE (UPJANG = V.UPJANG)  AND   (ITEM_CODE   = V.ITEM_CODE)  AND   (TRANS_TYPE  = 'I')  AND   (SUBUL_YN    = 'Y')), 0) TICKET_STARTNUM,    --TICKET_STARTNUM \n");
		sbSql.append("            NVL((SELECT NVL(MAX(TICKET_ENDNUM), 0) + 1 TICKET_MAXNUM  FROM HWFS_MAS_TICKET_MST WHERE (UPJANG = V.UPJANG)  AND   (ITEM_CODE   = V.ITEM_CODE)  AND   (TRANS_TYPE  = 'I')  AND   (SUBUL_YN    = 'Y')), 0) + NVL(?, 0) - 1 TICKET_ENDNUM,    --TICKET_ENDNUM \n");
		sbSql.append("            '구매자동입고', \n");
		sbSql.append("            'Y', \n");
		sbSql.append("            '003', \n");
		sbSql.append("            ?,    --TRANS_ID \n");
		sbSql.append("            ?,    --g_EmpNo \n");
		sbSql.append("            SYSDATE \n");
		sbSql.append("      FROM HWFS_MAS_TICKET_STD V \n");
		sbSql.append("      WHERE (V.UPJANG    = ?)--UPJANG \n");
		sbSql.append("      AND   (V.ITEM_CODE = ?) --ITEM_CODE \n");
		sbSql.append("      AND   (V.USE_YN    = 'Y') \n");
		pstmt5 = conn.prepareStatement(sbSql.toString());

		//========2.PO자료수정(검수수량, 라인상태) - 부분입고인 경우==========
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========2.PO자료수정(검수수량, 라인상태, 부분입고)======== \n");
		sbSql.append("UPDATE PO_PO \n");
		sbSql.append("   SET DELIVERED_QTY = DELIVERED_QTY + ? \n");
		sbSql.append("     , LINE_STATUS = ? \n");
		sbSql.append("     , UPDATE_BY = ? \n");
		sbSql.append("     , UPDATE_DATE = SYSDATE \n");
		sbSql.append(" WHERE PO_ID = ? \n");
		pstmt6 = conn.prepareStatement(sbSql.toString());
		//========2.PO자료수정(검수수량, 라인상태) - 감량인 경우==========
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========2.PO자료수정(검수수량, 라인상태, 감량입고)======== \n");
		sbSql.append("UPDATE PO_PO \n");
		sbSql.append("   SET DELIVERED_QTY = DELIVERED_QTY + ? \n");
		sbSql.append("     , UNDELIVERED_QTY = CENTER_DELI_QTY + DIRECT_DELI_QTY - DELIVERED_QTY - ? \n");
		sbSql.append("     , LINE_STATUS = ? \n");
		sbSql.append("     , CLS_FLAG = 'Y' \n");
		sbSql.append("     , CLS_DATE = ? \n");
		sbSql.append("     , UPDATE_BY = ? \n");
		sbSql.append("     , UPDATE_DATE = SYSDATE \n");
		sbSql.append(" WHERE PO_ID = ? \n");
		pstmt7 = conn.prepareStatement(sbSql.toString());
		//========2.PO자료수정(검수수량, 라인상태) - 정상입고인 경우==========
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========2.PO자료수정(검수수량, 라인상태, 정상입고)======== \n");
		sbSql.append("UPDATE PO_PO \n");
		sbSql.append("   SET DELIVERED_QTY = DELIVERED_QTY + ? \n");
		sbSql.append("     , LINE_STATUS = ? \n");
		sbSql.append("     , CLS_FLAG = 'Y' \n");
		sbSql.append("     , CLS_DATE = ? \n");
		sbSql.append("     , UPDATE_BY = ? \n");
		sbSql.append("     , UPDATE_DATE = SYSDATE \n");
		sbSql.append(" WHERE PO_ID = ? \n");
		pstmt8 = conn.prepareStatement(sbSql.toString());
		//========2.PO자료수정(검수수량, 라인상태) - 감량조정인 경우==========
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========2.PO자료수정(검수수량, 라인상태, 감량조정)======== \n");
		sbSql.append("UPDATE PO_PO \n");
		sbSql.append("   SET DELIVERED_QTY = DELIVERED_QTY + ? \n");
		sbSql.append("     , UNDELIVERED_QTY = ? \n");
		//감량이 제로인경우...
		sbSql.append("     , LINE_STATUS = DECODE(SIGN(CENTER_DELI_QTY + DIRECT_DELI_QTY - DELIVERED_QTY - ?),1,'010',0,DECODE(SIGN(?),0,'011','012')) \n");
		//감량시점의 검수일자와 감량조정시점의 검수일자가 다를 수 있으니..다시 박아준다.
		sbSql.append("     , CLS_FLAG = DECODE(SIGN(CENTER_DELI_QTY + DIRECT_DELI_QTY - DELIVERED_QTY - ?),1,'N','Y') \n");
		sbSql.append("     , CLS_DATE = DECODE(SIGN(CENTER_DELI_QTY + DIRECT_DELI_QTY - DELIVERED_QTY - ?),1,NULL,?) \n");
		sbSql.append("     , UPDATE_BY = ? \n");
		sbSql.append("     , UPDATE_DATE = SYSDATE \n");
		sbSql.append(" WHERE PO_ID = ? \n");
		pstmt9 = conn.prepareStatement(sbSql.toString());

		//========3.PR자료수정(라인상태)==========
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========3.PR자료수정(라인상태)======== \n");
		sbSql.append("UPDATE PO_PR A \n");
		sbSql.append("   SET A.LINE_STATUS = (SELECT B.LINE_STATUS FROM PO_PO B WHERE B.PR_ID = A.PR_ID) \n");
		sbSql.append("     , A.UPDATE_BY = ? \n");
		sbSql.append("     , A.UPDATE_DATE = SYSDATE \n");
		sbSql.append(" WHERE A.PR_ID = (SELECT B.PR_ID FROM PO_PO B WHERE B.PO_ID = ?) \n");
		sbSql.append("   AND A.NEED_DATE = ? \n");
		pstmt10 = conn.prepareStatement(sbSql.toString());
		
		//========4.클레임등록==========
		//검수작업일 경우만 클레임 등록
		sbSql.delete(0, sbSql.length());
		sbSql.append("--========4.클레임등록======== \n");
		sbSql.append("INSERT INTO PO_CLAIM_LIST \n");
		sbSql.append("          (PO_ID,NEED_DATE,CENTER_CODE,UPJANG,SUBINV_CODE,CUSTCD, \n");
		sbSql.append("           ITEM_CODE,ITEM_NAME,ITEM_SIZE,PO_UOM,PO_QTY,DLVY_QTY,UNDLVY_QTY,REQ_QTY, \n");
		sbSql.append("           CLAIM_KIND,REQ_KIND, \n");
		sbSql.append("           REQ_DATE, \n");
		sbSql.append("           REQ_TIME, \n");
		sbSql.append("           CLAIM_MEMO,ETC_MEMO,PRCS_STATUS, \n");
		sbSql.append("           CREATE_DATE,CREATE_BY \n");
		sbSql.append("          ) VALUES ( \n");
		sbSql.append("  ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", ? \n");
		sbSql.append(", DECODE(?,NULL,NULL,TRIM(TO_CHAR(TO_NUMBER(?),'0000'))) \n");
		sbSql.append(", ? \n");
		sbSql.append(", NULL \n");
		sbSql.append(", '01' \n");
		sbSql.append(", SYSDATE \n");
		sbSql.append(", ? ) \n");
		pstmt11 = conn.prepareStatement(sbSql.toString());

		int iInsCnt1 = 0;
		int iInsCnt2 = 0;
		int iInsCnt3 = 0;
		int iInsCnt4 = 0;
		int iInsCnt4_1 = 0;
		int iInsCnt5 = 0;
		int iInsCnt6 = 0;
		int iInsCnt7 = 0;
		int iInsCnt8 = 0;
		int iInsCnt9 = 0;
		int iInsCnt10 = 0;
		int iInsCnt11 = 0;
		//검수자료 저장
		for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
		{
			//센터재고품목인데 검수일<>입고예정일인 경우 무시...
			sCTSubinv = nullToBlank(ds_iud.getString(i, "CT_SUBINV_CODE"));
			if ((! sCTSubinv.equals("")) && (! sTransDate.equals(sNeedDate)))
			//if ((! sCTSubinv.equals("")) && (sTransDate != sNeedDate))
			{
				continue;				
			}
			//혹시 발생할지 모르는 센터재고품목인데 정상입고가 아닌 경우는 무시...
			if (sType.equals("TranSav"))
				sLineStat = nullToBlank(ds_iud.getString(i, "LINE_STATUS"));
			if ((! sCTSubinv.equals("")) && (! sLineStat.equals("011")))
			{
				continue;				
			}

			//========4.클레임등록========== 우선적으로 클레임부터 등록
			if (sType.equals("TranSav")) //검수작업일 경우만 클레임 등록
			{
				sClaimKind = nullToBlank(ds_iud.getString(i, "CLAIM_KIND"));
				if (! sClaimKind.equals(""))
				{
					pstmt11.setString(1, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt11.setString(2, sTransDate);
					pstmt11.setString(3, nullToBlank(ds_iud.getString(i, "CENTER_CODE")));
					pstmt11.setString(4, nullToBlank(ds_iud.getString(i, "RC_UPJANG")));
					pstmt11.setString(5, nullToBlank(ds_iud.getString(i, "SUBINV_CODE")));
					pstmt11.setString(6, nullToBlank(ds_iud.getString(i, "CUSTCD")));
					pstmt11.setString(7, nullToBlank(ds_iud.getString(i, "ITEM_CODE")));
					pstmt11.setString(8, nullToBlank(ds_iud.getString(i, "ITEM_NAME")));
					pstmt11.setString(9, nullToBlank(ds_iud.getString(i, "ITEM_SIZE")));
					pstmt11.setString(10, nullToBlank(ds_iud.getString(i, "PO_UOM")));
					pstmt11.setString(11, nullToBlank(ds_iud.getString(i, "PO_QTY")));
					pstmt11.setString(12, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt11.setString(13, nullToBlank(ds_iud.getString(i, "UNDELIVERED_QTY")));
					pstmt11.setString(14, nullToBlank(ds_iud.getString(i, "REQ_QTY")));
					pstmt11.setString(15, nullToBlank(ds_iud.getString(i, "CLAIM_KIND")));
					pstmt11.setString(16, nullToBlank(ds_iud.getString(i, "REQ_KIND")));
					pstmt11.setString(17, nullToBlank(ds_iud.getString(i, "REQ_DATE")));
					pstmt11.setString(18, nullToBlank(ds_iud.getString(i, "REQ_TIME")));
					pstmt11.setString(19, nullToBlank(ds_iud.getString(i, "REQ_TIME")));
					pstmt11.setString(20, nullToBlank(ds_iud.getString(i, "CLAIM_MEMO")));
					pstmt11.setString(21, g_EmpNo);
					pstmt11.addBatch();
					iInsCnt11++;
				}
			}

			//배송중 자료는 제외...
			if (sLineStat.equals("009"))
			{
				continue;				
			}
			//========1.검수자료(입고수량이 있는 것만)==========
			if( Double.parseDouble(ds_iud.getString(i, "TRANS_QTY")) != 0 )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT PO_TRANSACTION_S.NEXTVAL AS TRANS_ID \n");
				sbSql.append("  FROM DUAL \n");
out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				//jsp 로그남기기
				//logger.debug(sbSql.toString());
				stmt = conn.createStatement();		
				rs = stmt.executeQuery(sbSql.toString());				
				//pstmt = conn.prepareStatement(sbSql.toString());
				//rs = pstmt.executeQuery();
				rs.next();
				sTrans_ID = rs.getString("TRANS_ID");
				
				rs.close();
				stmt.close();
				
				//sCTSubinv = nullToBlank(ds_iud.getString(i, "CT_SUBINV_CODE"));
				sOUTVAT   = nullToBlank(ds_iud.getString(i, "OUTVAT_FLAG"));
				sMroFlag  = nullToBlank(ds_iud.getString(i, "MRO_FLAG"));
				//센터재고인 경우 이관입고처리
				if (! sCTSubinv.equals(""))
				{
					pstmt1.setString(1, sTrans_ID);
					pstmt1.setString(2, nullToBlank(ds_iud.getString(i, "RC_MU_CD")));
					pstmt1.setString(3, nullToBlank(ds_iud.getString(i, "DEPT_ID")));
					pstmt1.setString(4, nullToBlank(ds_iud.getString(i, "RC_UPJANG")));
					pstmt1.setString(5, nullToBlank(ds_iud.getString(i, "SUBINV_CODE")));
					pstmt1.setString(6, nullToBlank(ds_iud.getString(i, "BUDDEPT_ID")));
					pstmt1.setString(7, nullToBlank(ds_iud.getString(i, "ACCTCD")));
					pstmt1.setString(8, nullToBlank(ds_iud.getString(i, "BUD_CLS")));
					pstmt1.setString(9, nullToBlank(ds_iud.getString(i, "SALE_PRICE")));
					pstmt1.setString(10, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt1.setString(11, nullToBlank(ds_iud.getString(i, "SALE_PRICE")));
					pstmt1.setString(12, nullToBlank(ds_iud.getString(i, "CUSTCD")));
					pstmt1.setString(13, sTrNum);
					pstmt1.setString(14, nullToBlank(ds_iud.getString(i, "PO_TYPE")));
					pstmt1.setString(15, nullToBlank(ds_iud.getString(i, "CENTER_CODE")));
					pstmt1.setString(16, nullToBlank(ds_iud.getString(i, "INVAT_FLAG")));
					pstmt1.setString(17, nullToBlank(ds_iud.getString(i, "OUTVAT_FLAG")));
					pstmt1.setString(18, g_EmpNo);
					pstmt1.setString(19, g_EmpNo);
					pstmt1.setString(20, sTransDate);
					if (sOUTVAT.equals("Y"))
						pstmt1.setString(21, nullToBlank(ds_iud.getString(i, "CT_SUBINV_CODE_OUTVAT")));
					else
						pstmt1.setString(21, nullToBlank(ds_iud.getString(i, "CT_SUBINV_CODE")));
					pstmt1.setString(22, nullToBlank(ds_iud.getString(i, "ITEM_CODE")));
					pstmt1.setString(23, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt1.addBatch();
					iInsCnt1++;
				}
				else
				{
					pstmt2.setString(1, sTrans_ID);
					pstmt2.setString(2, sTransDate);
					pstmt2.setString(3, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt2.setString(4, nullToBlank(ds_iud.getString(i, "RC_MU_CD")));
					pstmt2.setString(5, nullToBlank(ds_iud.getString(i, "DEPT_ID")));
					pstmt2.setString(6, nullToBlank(ds_iud.getString(i, "RC_UPJANG")));
					pstmt2.setString(7, nullToBlank(ds_iud.getString(i, "SUBINV_CODE")));
					pstmt2.setString(8, nullToBlank(ds_iud.getString(i, "BUDDEPT_ID")));
					pstmt2.setString(9, nullToBlank(ds_iud.getString(i, "ACCTCD")));
					pstmt2.setString(10, nullToBlank(ds_iud.getString(i, "BUD_CLS")));
					pstmt2.setString(11, nullToBlank(ds_iud.getString(i, "ITEM_CODE")));
					pstmt2.setString(12, nullToBlank(ds_iud.getString(i, "ITEM_NAME")));
					pstmt2.setString(13, nullToBlank(ds_iud.getString(i, "ITEM_SIZE")));
					pstmt2.setString(14, nullToBlank(ds_iud.getString(i, "TAX_CODE")));
					pstmt2.setString(15, nullToBlank(ds_iud.getString(i, "PO_UOM")));
					pstmt2.setString(16, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt2.setString(17, nullToBlank(ds_iud.getString(i, "UNIT_PRICE")));
					pstmt2.setString(18, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt2.setString(19, nullToBlank(ds_iud.getString(i, "UNIT_PRICE")));
					pstmt2.setString(20, nullToBlank(ds_iud.getString(i, "MARGIN_PRICE")));
					pstmt2.setString(21, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt2.setString(22, nullToBlank(ds_iud.getString(i, "MARGIN_PRICE")));
					pstmt2.setString(23, nullToBlank(ds_iud.getString(i, "SALE_PRICE")));
					pstmt2.setString(24, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt2.setString(25, nullToBlank(ds_iud.getString(i, "SALE_PRICE")));
					pstmt2.setString(26, nullToBlank(ds_iud.getString(i, "UOM_CODE")));
					pstmt2.setString(27, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt2.setString(28, nullToBlank(ds_iud.getString(i, "UOM_CONVERT_RATE")));
					pstmt2.setString(29, nullToBlank(ds_iud.getString(i, "UNIT_PRICE")));
					pstmt2.setString(30, nullToBlank(ds_iud.getString(i, "UOM_CONVERT_RATE")));
					pstmt2.setString(31, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt2.setString(32, nullToBlank(ds_iud.getString(i, "UNIT_PRICE")));
					pstmt2.setString(33, nullToBlank(ds_iud.getString(i, "MARGIN_PRICE")));
					pstmt2.setString(34, nullToBlank(ds_iud.getString(i, "UOM_CONVERT_RATE")));
					pstmt2.setString(35, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt2.setString(36, nullToBlank(ds_iud.getString(i, "MARGIN_PRICE")));
					pstmt2.setString(37, nullToBlank(ds_iud.getString(i, "CUSTCD")));
					pstmt2.setString(38, sTrNum);
					pstmt2.setString(39, nullToBlank(ds_iud.getString(i, "PO_TYPE")));
					pstmt2.setString(40, nullToBlank(ds_iud.getString(i, "CENTER_CODE")));
					pstmt2.setString(41, nullToBlank(ds_iud.getString(i, "INVAT_FLAG")));
					pstmt2.setString(42, nullToBlank(ds_iud.getString(i, "OUTVAT_FLAG")));
					//감량작업인 경우 비고입력
					if (sType.equals("TranSav"))
						pstmt2.setString(43, null);
					else
						pstmt2.setString(43, "감량수정분");
					pstmt2.setString(44, g_EmpNo);
					pstmt2.setString(45, g_EmpNo);
					pstmt2.addBatch();
					iInsCnt2++;
				}
	
				//센터재고인 경우 검수대기목록에서 삭제
				if (! sCTSubinv.equals(""))
				{
					pstmt3.setString(1, sTransDate);
					if (sOUTVAT.equals("Y"))
						pstmt3.setString(2, nullToBlank(ds_iud.getString(i, "CT_SUBINV_CODE_OUTVAT")));
					else
						pstmt3.setString(2, nullToBlank(ds_iud.getString(i, "CT_SUBINV_CODE")));
					pstmt3.setString(3, nullToBlank(ds_iud.getString(i, "ITEM_CODE")));
					pstmt3.setString(4, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt3.addBatch();
					iInsCnt3++;
				}			
				//========1-1.MRO INTERFACE=========
				if (sMroFlag.equals("Y"))
				{
					pstmt4.setString(1, sTransDate);
					pstmt4.setString(2, sTrNum);
					pstmt4.setString(3, sTrans_ID);
					pstmt4.setString(4, nullToBlank(ds_iud.getString(i, "ORDER_NUM")));
					pstmt4.setString(5, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt4.setString(6, nullToBlank(ds_iud.getString(i, "ITEM_CODE")));
					pstmt4.setString(7, nullToBlank(ds_iud.getString(i, "ITEM_NAME")));
					pstmt4.setString(8, nullToBlank(ds_iud.getString(i, "ITEM_SIZE")));
					pstmt4.setString(9, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt4.setString(10, nullToBlank(ds_iud.getString(i, "PO_UOM")));
					pstmt4.setString(11, nullToBlank(ds_iud.getString(i, "UNIT_PRICE")));
					pstmt4.setString(12, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt4.setString(13, nullToBlank(ds_iud.getString(i, "UNIT_PRICE")));
					pstmt4.setString(14, sTransDate);
					pstmt4.setString(15, nullToBlank(ds_iud.getString(i, "RC_MU_CD")));
					pstmt4.setString(16, nullToBlank(ds_iud.getString(i, "RC_MU_CD")));
					pstmt4.setString(17, nullToBlank(ds_iud.getString(i, "DEPT_ID")));
					//감량작업인 경우 무조건 Closing
					if (sType.equals("TranSav"))
					{
						if (nullToBlank(ds_iud.getString(i, "LINE_STATUS")).equals("010"))
							pstmt4.setString(18, "O");
						else
							pstmt4.setString(18, "C");
					}
					else
						pstmt4.setString(18, "C");
					pstmt4.setString(19, g_EmpNo);
					pstmt4.setString(20, g_EmpNo);
					pstmt4.addBatch();
					iInsCnt4++;
				}
				
				//식권인 경우 식권자동 입고처리===========================================	
				pstmt5.setString(1, sTransDate);
				pstmt5.setString(2, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
				pstmt5.setString(3, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
				pstmt5.setString(4, sTrans_ID);
				pstmt5.setString(5, g_EmpNo);
				pstmt5.setString(6, nullToBlank(ds_iud.getString(i, "RC_UPJANG")));
				pstmt5.setString(7, nullToBlank(ds_iud.getString(i, "ITEM_CODE")));
				pstmt5.addBatch();
				iInsCnt5++;
				//식권인 경우 식권자동 입고처리===========================================
			
			
			}
			//========전량감량==========
			else
			{
				//========1-1.MRO INTERFACE=========
				if ((sType.equals("TranSav")) && (nullToBlank(ds_iud.getString(i, "MRO_FLAG")).equals("Y")))
				{
					pstmt4_1.setString(1, g_EmpNo);
					pstmt4_1.setString(2, g_EmpNo);
					pstmt4_1.setString(3, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt4_1.addBatch();
					iInsCnt4_1++;
				}
			}
				
			//========2.PO자료수정(검수수량, 라인상태)==========
			if (sType.equals("TranSav"))
			{
				//부분입고
				if (!(sLineStat.equals("011") || sLineStat.equals("012")))
				{
					pstmt6.setString(1, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt6.setString(2, nullToBlank(ds_iud.getString(i, "LINE_STATUS")));
					pstmt6.setString(3, g_EmpNo);
					pstmt6.setString(4, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt6.addBatch();
					iInsCnt6++;
				}
				//감량
				else if (sLineStat.equals("012"))
				{
					pstmt7.setString(1, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt7.setString(2, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt7.setString(3, nullToBlank(ds_iud.getString(i, "LINE_STATUS")));
					pstmt7.setString(4, sTransDate);
					pstmt7.setString(5, g_EmpNo);
					pstmt7.setString(6, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt7.addBatch();
					iInsCnt7++;
				}
				//정상입고
				else
				{
					pstmt8.setString(1, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
					pstmt8.setString(2, nullToBlank(ds_iud.getString(i, "LINE_STATUS")));
					pstmt8.setString(3, sTransDate);
					pstmt8.setString(4, g_EmpNo);
					pstmt8.setString(5, nullToBlank(ds_iud.getString(i, "PO_ID")));
					pstmt8.addBatch();
					iInsCnt8++;
				}
			}
			//감량조정
			else
			{
				pstmt9.setString(1, nullToBlank(ds_iud.getString(i, "TRANS_QTY")));
				pstmt9.setString(2, nullToBlank(ds_iud.getString(i, "UNDELIVERED_QTY")));
				//감량이 제로인경우...
				pstmt9.setString(3, nullToBlank(ds_iud.getString(i, "UNDELIVERED_QTY_OLD")));
				pstmt9.setString(4, nullToBlank(ds_iud.getString(i, "UNDELIVERED_QTY")));
				//감량시점의 검수일자와 감량조정시점의 검수일자가 다를 수 있으니..다시 박아준다.
				pstmt9.setString(5, nullToBlank(ds_iud.getString(i, "UNDELIVERED_QTY_OLD")));
				pstmt9.setString(6, nullToBlank(ds_iud.getString(i, "UNDELIVERED_QTY_OLD")));
				pstmt9.setString(7, sTransDate);
				pstmt9.setString(8, g_EmpNo);
				pstmt9.setString(9, nullToBlank(ds_iud.getString(i, "PO_ID")));
				pstmt9.addBatch();
				iInsCnt9++;
			}

			//========3.PR자료수정(라인상태)==========
			pstmt10.setString(1, g_EmpNo);
			pstmt10.setString(2, nullToBlank(ds_iud.getString(i, "PO_ID")));
			pstmt10.setString(3, sNeedDate);
			pstmt10.addBatch();
			iInsCnt10++;
		}
		
		//jsp 로그남기기
		//logger.debug(pstmt1.toString());
		//logger.debug(pstmt2.toString());
		//logger.debug(pstmt3.toString());
		//logger.debug(pstmt4.toString());
		//logger.debug(pstmt4_1.toString());
		//logger.debug(pstmt5.toString());
		//logger.debug(pstmt6.toString());
		//logger.debug(pstmt7.toString());
		//logger.debug(pstmt8.toString());
		//logger.debug(pstmt9.toString());
		//logger.debug(pstmt10.toString());
		//logger.debug(pstmt11.toString());
		//배치실행
		if(iInsCnt1 > 0) pstmt1.executeBatch();
		if(iInsCnt2 > 0) pstmt2.executeBatch();
		if(iInsCnt3 > 0) pstmt3.executeBatch();
		if(iInsCnt4 > 0) pstmt4.executeBatch();
		if(iInsCnt4_1 > 0) pstmt4_1.executeBatch();
		if(iInsCnt5 > 0) pstmt5.executeBatch();
		if(iInsCnt6 > 0) pstmt6.executeBatch();
		if(iInsCnt7 > 0) pstmt7.executeBatch();
		if(iInsCnt8 > 0) pstmt8.executeBatch();
		if(iInsCnt9 > 0) pstmt9.executeBatch();
		if(iInsCnt10 > 0) pstmt10.executeBatch();
		if(iInsCnt11 > 0) pstmt11.executeBatch();

		/**종료**/
		conn.commit();
		out_vl.add("fa_TrNum", sTrNum);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
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
		if(pstmt1 != null) {
			try {
				pstmt1.close();
			}catch(Exception e) {}
		}
		if(pstmt2 != null) {
			try {
				pstmt2.close();
			}catch(Exception e) {}
		}
		if(pstmt3 != null) {
			try {
				pstmt3.close();
			}catch(Exception e) {}
		}
		if(pstmt4 != null) {
			try {
				pstmt4.close();
			}catch(Exception e) {}
		}
		if(pstmt5 != null) {
			try {
				pstmt5.close();
			}catch(Exception e) {}
		}
		if(pstmt6 != null) {
			try {
				pstmt6.close();
			}catch(Exception e) {}
		}
		if(pstmt7 != null) {
			try {
				pstmt7.close();
			}catch(Exception e) {}
		}
		if(pstmt8 != null) {
			try {
				pstmt8.close();
			}catch(Exception e) {}
		}
		if(pstmt9 != null) {
			try {
				pstmt9.close();
			}catch(Exception e) {}
		}
		if(pstmt10 != null) {
			try {
				pstmt10.close();
			}catch(Exception e) {}
		}
		if(pstmt11 != null) {
			try {
				pstmt11.close();
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