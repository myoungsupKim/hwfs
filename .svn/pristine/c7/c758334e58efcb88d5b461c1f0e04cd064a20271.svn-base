<%@page import="com.sz.util.AppDataUtility"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>

<%

	CallableStatement cstmt   = null;
	
	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));
	
		String UPJANG 	= nullToBlank(in_vl.getString("UPJANG"));
		String SUBINV 	= nullToBlank(in_vl.getString("SUBINV"));
		String FROM 	= nullToBlank(in_vl.getString("FROM"));
		String TO 		= nullToBlank(in_vl.getString("TO"));
		String ITEMGBN 	= nullToBlank(in_vl.getString("ITEMGBN"));
		String CLASS4 	= nullToBlank(in_vl.getString("CLASS4"));
		String ITEM 	= nullToBlank(in_vl.getString("ITEM"));
		String SABUN 	= nullToBlank(in_vl.getString("SABUN"));
		
		System.out.println("FSP00300V2_S001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>24:FSP_ONHAND_TEMP_PRO");	
	    // 실시간내역조회
	    cstmt = conn.prepareCall("{call FSP_ONHAND_TEMP_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
	
	    //실행
	    cstmt.setString(1,UPJANG);
	    cstmt.setString(2,SUBINV);
	    cstmt.setString(3,FROM);
	    cstmt.setString(4,TO);
	    cstmt.setString(5,ITEMGBN);
	    cstmt.setString(6,"");
	    cstmt.setString(7,"");  
	    cstmt.setString(8,CLASS4); 
	    cstmt.setString(9,ITEM); 
	    cstmt.setString(10,SABUN); 
	    cstmt.registerOutParameter(11, Types.VARCHAR);
	    cstmt.registerOutParameter(12, Types.VARCHAR);
	
	    cstmt.execute();
	
	    if(cstmt.getString(11).equals("E"))
	    {
	        conn.rollback();
	        this.setResultMessage(-1, cstmt.getString(11), out_vl);
	        proc_output(response,out,out_vl,out_dl);
	        return;
	    }
	    cstmt.close();
	    
	    StringBuffer sbSql = new StringBuffer();
		
	    sbSql.delete(0, sbSql.length());
		sbSql.append("/*자재단품별 내역*/ \n");
		sbSql.append("SELECT TRANS_DATE AS PHYSIC_DATE -- 조사일 \n");
		sbSql.append("     , ITEM_CODE AS ITEM_CODE -- 자재코드 \n");
		sbSql.append("     , ITEM_NAME AS ITEM_NAME -- 자재명 \n");
		sbSql.append("     , ITEM_SIZE AS ITEM_SIZE -- 규격 \n");
		sbSql.append("     , UOM_CODE AS UOM_CODE -- 단위(수불단위) \n");
		sbSql.append("     , PO_UOM AS PO_UOM -- 단위(구매단위) \n");
		sbSql.append("     , M_STK_PRICE2 AS MARGIN_PRICE -- 재고단가(수불단위) \n");
		sbSql.append("     , M_STK_PRICE AS MARGIN_PRICE1 -- 재고단가(구매단위) \n");
		sbSql.append("     , M_STK_QTY2 AS ONHAND_QTY -- 전산재고량(수불단위) \n");
		sbSql.append("     , M_STK_QTY AS ONHAND_QTY1 -- 전산재고량(구매단위) \n");
		sbSql.append("     , M_STK_AMT AS ONHAND_MAMOUNT -- 전산재고금액 \n");
		sbSql.append("     , M_REAL_QTY2 AS PHYSIC_QTY -- 실사량(수불단위) \n");
		sbSql.append("     , M_REAL_QTY AS PHYSIC_QTY1 -- 실사량(구매단위) \n");
		sbSql.append("     , M_REAL_AMT AS PHYSIC_MAMOUNT -- 실사금액 \n");
		sbSql.append("     , M_REAL_VAT AS PHYSIC_MVAT -- VAT \n");
		sbSql.append("     , M_USE_QTY2 AS LOSS_QTY -- 사용량(수불단위) \n");
		sbSql.append("     , M_USE_QTY AS LOSS_QTY1 -- 사용량(구매단위) \n");
		sbSql.append("     , M_USE_AMT AS LOSS_MAMOUNT -- 사용금액 \n");
		sbSql.append("     , M_USE_VAT AS LOSS_MVAT -- VAT \n");
		sbSql.append("     , TO_CHAR(SYSDATE,'YYYYMMDD') AS CLOSE_DATE -- 저장일 \n");
		sbSql.append("     , SUBINV_NAME -- 창고 \n");
		sbSql.append("  FROM FSP_ONHAND_TEMP \n");
		sbSql.append(" WHERE UPJANG = '" + UPJANG + "' \n");
		sbSql.append(" ORDER BY TRANS_DATE, ITEM_CODE \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
	
		DataSet ds_Item = this.makeDataSet(rs, "ds_Item");
		out_dl.add(ds_Item);
	
		/**종료**/
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