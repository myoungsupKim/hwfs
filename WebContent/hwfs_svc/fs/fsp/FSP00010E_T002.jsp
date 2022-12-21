<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_cond     = in_dl.get("ds_cond");
		DataSet ds_list     = in_dl.get("ds_list");

		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		int sRowStatus;
		String sSeasonNum =  nullToBlank(ds_cond.getString(0,"SEASON_NUM"));
		String sSeasonName =  nullToBlank(ds_cond.getString(0,"SEASON_NAME"));

		StringBuffer sbSql    = new StringBuffer();
		StringBuffer sbSelSql = new StringBuffer();

		for( int i = 0 ; i < ds_list.getRemovedRowCount(); i++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉상품 주문삭제 입출고 내역 저장 */ \n");
	        sbSql.append("INSERT INTO FSP_PO_SPECIAL_TRANS \n");
	        sbSql.append("( \n");
	        sbSql.append("   SEASON_NUM \n");
	        sbSql.append(" , ITEM_CODE \n");
	        sbSql.append(" , TRANS_DATE \n");
	        sbSql.append(" , INOUT \n");
	        sbSql.append(" , PRICE \n");
	        sbSql.append(" , QTY \n");
	        sbSql.append(" , AMOUNT \n");
	        sbSql.append(" , SP_ID \n");
	        sbSql.append(" , REMARK \n");
	        sbSql.append(" , CREATE_BY \n");
	        sbSql.append(" , CREATE_DATE \n");
	        sbSql.append(" , UPDATE_BY \n");
	        sbSql.append(" , UPDATE_DATE \n");
	        sbSql.append(") \n");
	        sbSql.append("SELECT SEASON_NUM \n");
	        sbSql.append("     , ITEM_CODE \n");
	        sbSql.append("     , TO_CHAR(SYSDATE, 'YYYYMMDD') AS TRANS_DATE \n");
	        sbSql.append("     , 'I' AS INOUT \n");
	        sbSql.append("     , SALE_PRICE AS PRICE \n");
	        sbSql.append("     , PR_QTY AS QTY \n");
	        sbSql.append("     , SALE_AMOUNT AS AMOUNT \n");
	        sbSql.append("     , SP_ID \n");
	        sbSql.append("     , '상품주문(취소)' AS REMARK \n");
	        sbSql.append("     , '" + g_EmpNo + "' AS CREATE_BY \n");
			sbSql.append("     , SYSDATE AS CREATE_DATE \n");
			sbSql.append("     , '" + g_EmpNo + "' AS UPDATE_BY \n");
			sbSql.append("     , SYSDATE AS UPDATE_DATE \n");
	        sbSql.append("  FROM FSP_PO_SPECIAL_SALE \n");
	        sbSql.append(" WHERE SP_ID = '" + ds_list.getRemovedData(i, "SP_ID").toString() + "' \n");
	        sbSql.append("   AND LINE_STATUS = '주문' \n");
	        sbSql.append("   AND BU_CD = '2000' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉상품 주문삭제 저장 */ \n");
			sbSql.append("UPDATE FSP_PO_SPECIAL_SALE \n");
			sbSql.append("   SET LINE_STATUS = '취소' \n");
			sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
			sbSql.append("     , UPDATE_DATE = SYSDATE \n");
			sbSql.append(" WHERE SP_ID = " + ds_list.getRemovedData(i, "SP_ID").toString() + " \n");
			sbSql.append("   AND LINE_STATUS = '주문' \n");
			sbSql.append("   AND BU_CD = '2000' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
		}

		if( pstmt != null )	pstmt.close();

		for( int i = 0 ; i < ds_list.getRowCount(); i++ )
		{
			sRowStatus = ds_list.getRowType(i);

			if( sRowStatus == DataSet.ROW_TYPE_NORMAL )	continue;

			String prQty = nullToBlank(ds_list.getString(i, "PR_QTY"));
			if( prQty.equals("") )	prQty = "0";

			if( Integer.parseInt(prQty) <= 0 )	continue;

			sbSql.delete(0, sbSql.length());

			if( sRowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.append("/* 판촉상품 주문정보 저장 */ \n");
				sbSql.append("INSERT INTO FSP_PO_SPECIAL_SALE \n");
				sbSql.append("( \n");
				sbSql.append("   SP_ID \n");
				sbSql.append(" , SEASON_NUM \n");
				sbSql.append(" , SP_TYPE \n");
				sbSql.append(" , SP_DATE \n");
				sbSql.append(" , ITEM_CODE \n");
				sbSql.append(" , SALE_PRICE \n");
				sbSql.append(" , PR_QTY \n");
				sbSql.append(" , SALE_AMOUNT \n");
				sbSql.append(" , DC_AMOUNT \n");
				sbSql.append(" , SALE_TYPE \n");
				sbSql.append(" , LINE_STATUS \n");
				sbSql.append(" , PR_SABUN \n");
				sbSql.append(" , RQ_SABUN \n");
				sbSql.append(" , RQ_TEL_ENC \n");
				sbSql.append(" , UPJANG \n");
				sbSql.append(" , SEND_NAME \n");
				sbSql.append(" , SEND_TEL_ENC \n");
				sbSql.append(" , SEND_ADDR_ENC \n");
				sbSql.append(" , RECE_NAME \n");
				sbSql.append(" , RECE_TEL_ENC \n");
				sbSql.append(" , RECE_HP_ENC \n");
				sbSql.append(" , RECE_ADDR_ENC \n");
				sbSql.append(" , AR_SAUPNO \n");
				sbSql.append(" , AR_ADDR_ENC \n");
				sbSql.append(" , AR_NAME \n");
				sbSql.append(" , AR_TEL_ENC \n");
				sbSql.append(" , AR_EMAIL_ENC \n");
				sbSql.append(" , PAY_METHOD \n");
				sbSql.append(" , INST_PERIOD \n");
				sbSql.append(" , CARD_CLASS \n");
				sbSql.append(" , CARD_COMP \n");
				sbSql.append(" , CARD_NUM_ENC \n");
				sbSql.append(" , VALID_THRU_YY \n");
				sbSql.append(" , VALID_THRU_MM \n");
				sbSql.append(" , CONTENT \n");
				sbSql.append(" , OPER_ORG_SN \n");
				sbSql.append(" , VD_SN \n");
				sbSql.append(" , CONTRACT_START \n");
				sbSql.append(" , AR_CUSTCD \n");
				sbSql.append(" , DELI_EXPT_DATE \n");
				sbSql.append(" , CALL_YN \n");
				sbSql.append(" , CREATE_DATE \n");
				sbSql.append(" , CREATE_BY \n");
				sbSql.append(" , UPDATE_DATE \n");
				sbSql.append(" , UPDATE_BY \n");
				sbSql.append(") \n");
				sbSql.append("SELECT FSP_PO_SPECIAL_SALE_S.NEXTVAL AS SP_ID \n");
				sbSql.append("     , '" + sSeasonNum + "' AS SEASON_NUM \n");
				sbSql.append("     , 'ING' AS SP_TYPE \n");
				sbSql.append("     , '" + nullToBlank(ds_cond.getString(0, "SP_DATE")) + "' AS SP_DATE \n");
				sbSql.append("     , A.ITEM_CODE \n");
				sbSql.append("     , " + nullToBlank(ds_list.getString(i, "SALE_PRICE")) + " AS SALE_PRICE \n");
				sbSql.append("     , " + nullToBlank(ds_list.getString(i, "PR_QTY")) + " AS PR_QTY \n");
				sbSql.append("     , " + nullToBlank(ds_list.getString(i, "SALE_AMOUNT")) + " AS SALE_AMOUNT \n");
				sbSql.append("     , " + nullToBlank(ds_list.getString(i, "DC_AMOUNT")) + " AS DC_AMOUNT \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "SALE_TYPE")) + "' AS SALE_TYPE \n");
				sbSql.append("     , '주문' AS LINE_STATUS \n");
				sbSql.append("     , '" + g_EmpNo + "' AS PR_SABUN \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "RQ_SABUN")) + "' AS RQ_SABUN \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RQ_TEL")) + "', '4') AS RQ_TEL_ENC \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "UPJANG")) + "' AS UPJANG \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "SEND_NAME")) + "' AS SEND_NAME \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "SEND_TEL")) + "', '4') AS SEND_TEL_ENC \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "SEND_ADDR")) + "', '6') AS SEND_ADDR_ENC \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "RECE_NAME")) + "' AS RECE_NAME \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RECE_TEL")) + "', '4') AS RECE_TEL_ENC \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RECE_HP")) + "', '4') AS RECE_HP_ENC \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RECE_ADDR")) + "', '6') AS RECE_ADDR_ENC \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "AR_SAUPNO")) + "' AS AR_SAUPNO \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "AR_ADDR")) + "', '6') AS AR_ADDR_ENC \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "AR_NAME")) + "' AS AR_NAME \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "AR_TEL")) + "', '4') AS AR_TEL_ENC \n");
				sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "AR_EMAIL")) + "', '5') AS AR_EMAIL_ENC \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "PAY_METHOD")) + "' AS PAY_METHOD \n");
				if( nullToBlank(ds_list.getString(i, "PAY_METHOD")).equals("2") )
				{
					sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "INST_PERIOD")) + "' AS INST_PERIOD \n");
					sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "CARD_CLASS")) + "' AS CLASS_CLASS \n");
					sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "CARD_COMP")) + "' AS CARD_COMP \n");
					sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "CARD_NUM")) + "','2') AS CARD_NUM_ENC \n");
					sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "VALID_THRU_YY")) + "' AS VALID_THRU_YY \n");
					sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "VALID_THRU_MM")) + "' AS VALID_THRU_MM \n");
				}
				else
				{
					sbSql.append("     , NULL AS INST_PERIOD \n");
					sbSql.append("     , NULL AS CLASS_CLASS \n");
					sbSql.append("     , NULL AS CARD_COMP \n");
					sbSql.append("     , NULL AS CARD_NUM_ENC \n");
					sbSql.append("     , NULL AS VALID_THRU_YY \n");
					sbSql.append("     , NULL AS VALID_THRU_MM \n");
				}
				sbSql.append("     , DECODE('" + nullToBlank(ds_list.getString(i, "CONTENT")) + "','Y','Y','N') AS CONTENT \n");
				sbSql.append("     , A.OPER_ORG_SN AS OPER_ORG_SN \n");
				sbSql.append("     , A.VD_SN AS VD_SN \n");
				sbSql.append("     , A.CONTRACT_START AS CONTRACT_START \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "AR_CUSTCD")) + "' AS AR_CUSTCD \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "DELI_EXPT_DATE")) + "' AS DELI_EXPT_DATE \n");
				sbSql.append("     , '" + nullToBlank(ds_list.getString(i, "CALL_YN")) + "' AS CALL_YN \n");
				sbSql.append("     , SYSDATE AS CREATE_DATE \n");
				sbSql.append("     , '" + g_EmpNo + "' AS CREATE_BY \n");
				sbSql.append("     , SYSDATE AS UPDATE_DATE \n");
				sbSql.append("     , '" + g_EmpNo + "' AS UPDATE_BY \n");
				sbSql.append("  FROM FSP_PO_SPECIAL_ITEM A \n");
				sbSql.append("     , HLDC_PO_ITEM_MST B \n");
				sbSql.append(" WHERE A.ITEM_CODE  = B.ITEM_CODE \n");
				sbSql.append("   AND A.ITEM_CODE  = '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "' \n");
				sbSql.append("   AND B.USE_YN     = 'Y' \n");
				sbSql.append("   AND A.CONTRACT_START <= TO_CHAR(SYSDATE, 'YYYYMMDD') \n");
				sbSql.append("   AND A.SEASON_NUM = '" + sSeasonNum + "' \n");
			}
			else if( sRowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				// 수정전 상태값 확인해서 주문상태가 아닌것은 제외
				String lineStatus = "";
				String itemCode = "";
				
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT LINE_STATUS, ITEM_CODE \n");
				sbSelSql.append("  FROM FSP_PO_SPECIAL_SALE \n");
				sbSelSql.append(" WHERE SP_ID      = '" + nullToBlank(ds_list.getString(i, "SP_ID")) + "' \n");
				sbSelSql.append("   AND SEASON_NUM = '" + nullToBlank(ds_list.getString(i, "SEASON_NUM")) + "' \n");
				sbSelSql.append("   AND BU_CD      = '2000' \n");

				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();

				if( rs.next() )
				{
					lineStatus = rs.getString("LINE_STATUS");
					itemCode = rs.getString("ITEM_CODE");
				}

				rs.close();
				pstmt.close();

				if( !lineStatus.equals("주문") )
				{
					//continue;
					out_vl.add("v_spClose", "");
	                this.setResultMessage(-1, "주문하신 상품["+ itemCode +"]은 이미 처리되어 변경이 불가합니다.\n변경필요시 특판팀으로 문의하세요.", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}

				sbSql.append("/* 판촉상품 주문정보 수정 */ \n");
				sbSql.append("UPDATE FSP_PO_SPECIAL_SALE \n");
				sbSql.append("   SET PR_QTY = " + nullToBlank(ds_list.getString(i, "PR_QTY")) + " \n");
				sbSql.append("     , SALE_PRICE = " + nullToBlank(ds_list.getString(i, "SALE_PRICE")) + " \n");
				sbSql.append("     , SALE_AMOUNT = " + nullToBlank(ds_list.getString(i, "SALE_AMOUNT")) + " \n");
				sbSql.append("     , DC_AMOUNT = " + nullToBlank(ds_list.getString(i, "DC_AMOUNT")) + " \n");
				sbSql.append("     , CONTENT = DECODE('" + nullToBlank(ds_list.getString(i, "CONTENT")) + "','Y', 'Y', 'N') \n");
				sbSql.append("     , SALE_TYPE = '" + nullToBlank(ds_list.getString(i, "SALE_TYPE")) + "' \n");
				sbSql.append("     , RQ_SABUN = '" + nullToBlank(ds_list.getString(i, "RQ_SABUN")) + "' \n");
				sbSql.append("     , RQ_TEL_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RQ_TEL")) + "', '4') \n");
				sbSql.append("     , SEND_NAME = '" + nullToBlank(ds_list.getString(i, "SEND_NAME")) + "' \n");
				sbSql.append("     , SEND_TEL_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "SEND_TEL")) + "', '4') \n");
				sbSql.append("     , SEND_ADDR_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "SEND_ADDR")) + "', '6') \n");
				sbSql.append("     , RECE_NAME = '" + nullToBlank(ds_list.getString(i, "RECE_NAME")) + "' \n");
				sbSql.append("     , RECE_TEL_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RECE_TEL")) + "', '4') \n");
				sbSql.append("     , RECE_HP_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RECE_HP")) + "', '4') \n");
				sbSql.append("     , RECE_ADDR_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "RECE_ADDR")) + "', '6') \n");
				sbSql.append("     , AR_SAUPNO = '" + nullToBlank(ds_list.getString(i, "AR_SAUPNO")) + "' \n");
				sbSql.append("     , AR_ADDR_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "AR_ADDR")) + "', '6') \n");
				sbSql.append("     , AR_NAME = '" + nullToBlank(ds_list.getString(i, "AR_NAME")) + "' \n");
				sbSql.append("     , AR_TEL_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "AR_TEL")) + "', '4') \n");
				sbSql.append("     , AR_EMAIL_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "AR_EMAIL")) + "', '5') \n");
				sbSql.append("     , PAY_METHOD = '" + nullToBlank(ds_list.getString(i, "PAY_METHOD")) + "' \n");
				if( nullToBlank(ds_list.getString(i, "PAY_METHOD")).equals("2") )
				{
					sbSql.append("     , INST_PERIOD = '" + nullToBlank(ds_list.getString(i, "INST_PERIOD")) + "' \n");
					sbSql.append("     , CARD_CLASS = '" + nullToBlank(ds_list.getString(i, "CARD_CLASS")) + "' \n");
					sbSql.append("     , CARD_COMP = '" + nullToBlank(ds_list.getString(i, "CARD_COMP")) + "' \n");
					sbSql.append("     , CARD_NUM_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_list.getString(i, "CARD_NUM")) + "','2') \n");
					sbSql.append("     , VALID_THRU_YY = '" + nullToBlank(ds_list.getString(i, "VALID_THRU_YY")) + "' \n");
					sbSql.append("     , VALID_THRU_MM = '" + nullToBlank(ds_list.getString(i, "VALID_THRU_MM")) + "' \n");
				}
				else
				{
					sbSql.append("     , INST_PERIOD = NULL \n");
					sbSql.append("     , CARD_CLASS = NULL \n");
					sbSql.append("     , CARD_COMP = NULL \n");
					sbSql.append("     , CARD_NUM_ENC = NULL \n");
					sbSql.append("     , VALID_THRU_YY = NULL \n");
					sbSql.append("     , VALID_THRU_MM = NULL \n");
				}
				sbSql.append("     , LINE_STATUS = DECODE(" + nullToBlank(ds_list.getString(i, "PR_QTY")) + ", 0, '취소', LINE_STATUS) \n");
				sbSql.append("     , UPJANG = '" + nullToBlank(ds_list.getString(i, "UPJANG")) + "' \n");
				sbSql.append("     , OPER_ORG_SN = '" + nullToBlank(ds_list.getString(i, "OPER_ORG_SN")) + "' \n");
				sbSql.append("     , VD_SN = '" + nullToBlank(ds_list.getString(i, "VD_SN")) + "' \n");
				sbSql.append("     , CONTRACT_START = '" + nullToBlank(ds_list.getString(i, "CONTRACT_START")) + "' \n");
				sbSql.append("     , AR_CUSTCD = '" + nullToBlank(ds_list.getString(i, "AR_CUSTCD")) + "' \n");
				sbSql.append("     , DELI_EXPT_DATE = '" + nullToBlank(ds_list.getString(i, "DELI_EXPT_DATE")) + "' \n");
				sbSql.append("     , CALL_YN = '" + nullToBlank(ds_list.getString(i, "CALL_YN")) + "' \n");
				sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
				sbSql.append("     , UPDATE_DATE = SYSDATE \n");
				sbSql.append(" WHERE SP_ID = " + nullToBlank(ds_list.getString(i, "SP_ID")) + " \n");
				sbSql.append("   AND LINE_STATUS = '주문' \n");
				sbSql.append("   AND BU_CD = '2000' \n");
			}

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();

			if( sRowStatus == DataSet.ROW_TYPE_NORMAL )	continue;

			sbSql.delete(0, sbSql.length());
			if( sRowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.append("/* 판촉상품 입출고 내역 저장 */ \n");
				sbSql.append("INSERT INTO FSP_PO_SPECIAL_TRANS \n");
				sbSql.append("( \n");
		        sbSql.append("   SEASON_NUM \n");
		        sbSql.append(" , ITEM_CODE \n");
		        sbSql.append(" , TRANS_DATE \n");
		        sbSql.append(" , INOUT \n");
		        sbSql.append(" , PRICE \n");
		        sbSql.append(" , QTY \n");
		        sbSql.append(" , AMOUNT \n");
		        sbSql.append(" , SP_ID \n");
		        sbSql.append(" , REMARK \n");
		        sbSql.append(" , CREATE_BY \n");
		        sbSql.append(" , CREATE_DATE \n");
		        sbSql.append(" , UPDATE_BY \n");
		        sbSql.append(" , UPDATE_DATE \n");
		        sbSql.append(") \n");
		        sbSql.append("VALUES \n");
		        sbSql.append("( \n");
		        sbSql.append("   '" + sSeasonNum + "' \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "' \n");
		        sbSql.append(" , TO_CHAR(SYSDATE, 'YYYYMMDD') \n");
		        sbSql.append(" , 'O' \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "SALE_PRICE")) + "' \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "PR_QTY")) + "' \n");
		        sbSql.append(" , '" + nullToBlank(ds_list.getString(i, "SALE_AMOUNT")) + "' \n");
		        sbSql.append(" , FSP_PO_SPECIAL_SALE_S.CURRVAL \n");
		        sbSql.append(" , '상품주문(주문)' \n");
		        sbSql.append(" ,  '" + g_EmpNo + "' \n");
				sbSql.append(" ,  SYSDATE \n");
				sbSql.append(" ,  '" + g_EmpNo + "' \n");
				sbSql.append(" ,  SYSDATE \n");
		        sbSql.append(") \n");
			}
			else if( sRowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				// 수정전 상태값 확인해서 주문상태가 아닌것은 제외
				String lineStatus = "";

				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT LINE_STATUS \n");
				sbSelSql.append("  FROM FSP_PO_SPECIAL_SALE \n");
				sbSelSql.append(" WHERE SP_ID      = '" + nullToBlank(ds_list.getString(i, "SP_ID")) + "' \n");
				sbSelSql.append("   AND SEASON_NUM = '" + nullToBlank(ds_list.getString(i, "SEASON_NUM")) + "' \n");
				sbSelSql.append("   AND BU_CD      = '2000' \n");

				pstmt = conn.prepareStatement(sbSelSql.toString());
				rs = pstmt.executeQuery();

				if( rs.next() )
				{
					lineStatus = rs.getString("LINE_STATUS");
				}

				rs.close();
				pstmt.close();

				if( !lineStatus.equals("주문") )
				{
					continue;
				}

				sbSql.append("/* 판촉상품 입출고 내역 수정 */ \n");
				sbSql.append("UPDATE FSP_PO_SPECIAL_TRANS \n");
				sbSql.append("   SET ITEM_CODE = '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "' \n");
				sbSql.append("     , PRICE = NVL('" + nullToBlank(ds_list.getString(i, "SALE_PRICE")) + "',0) \n");
				sbSql.append("     , QTY = NVL('" + nullToBlank(ds_list.getString(i, "PR_QTY")) + "',0) \n");
				sbSql.append("     , AMOUNT = NVL('" + nullToBlank(ds_list.getString(i, "SALE_AMOUNT")) + "',0) \n");
				sbSql.append("     , REMARK = '상품주문(수정)' \n");
				sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
				sbSql.append("     , UPDATE_DATE = SYSDATE \n");
				sbSql.append(" WHERE SP_ID = " + nullToBlank(ds_list.getString(i, "SP_ID")) + " \n");
			}

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch( Exception ex )
	{
		conn.rollback();

		// jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch( Exception e ) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch( Exception e ) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch( Exception e ) {}
		}

		// jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>