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
		String CLASS3 	= nullToBlank(in_vl.getString("CLASS3"));
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
	    cstmt.setString(7,CLASS3);  
	    cstmt.setString(8,""); 
	    cstmt.setString(9,""); 
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
		sbSql.append("/* 대분류별 내역 */ \n");
		sbSql.append("SELECT TRANS_DATE         AS PHYSIC_DATE      -- 조사일		\n");
		sbSql.append("     , L_CLASS_NAME 		AS CLASS2_NAME 		-- 대분류 		\n");
		sbSql.append("     , M_CLASS_NAME   	AS CLASS3_NAME 		-- 중분류 		\n");
		sbSql.append("     , D_CLASS_NAME   	AS CLASS4_NAME 		-- 소분류 		\n");
		sbSql.append("     , SUM(M_STK_QTY2)   	AS ONHAND_QTY 		-- 전산재고량 	\n");
		sbSql.append("     , SUM(M_STK_PRICE2) 	AS ONHAND_MAMOUNT 	-- 전산재고금액 \n");
		sbSql.append("     , SUM(M_REAL_QTY2)   AS PHYSIC_QTY 		-- 실사량 		\n");
		sbSql.append("     , SUM(M_REAL_AMT)   	AS PHYSIC_MAMOUNT 	-- 실사금액 	\n");
		sbSql.append("     , SUM(M_REAL_VAT)   	AS PHYSIC_MVAT 		-- VAT 			\n");
		sbSql.append("     , SUM(M_USE_QTY2)    AS LOSS_QTY 		-- 사용량 		\n");
		sbSql.append("     , SUM(M_USE_AMT)   	AS LOSS_MAMOUNT 	-- 사용금액 	\n");
		sbSql.append("     , SUM(M_USE_VAT)    	AS LOSS_MVAT 		-- 사용VAT 		\n");
		sbSql.append("     , SUBINV_NAME -- 창고 \n");
		sbSql.append("  FROM FSP_ONHAND_TEMP \n");
		sbSql.append(" WHERE UPJANG = '" + UPJANG + "' \n");
		sbSql.append("  GROUP BY TRANS_DATE, SUBINV_NAME, L_CLASS_CODE, L_CLASS_NAME, M_CLASS_CODE, M_CLASS_NAME, D_CLASS_CODE, D_CLASS_NAME, TAX_CODE \n");
		sbSql.append("  ORDER BY TRANS_DATE, L_CLASS_CODE, M_CLASS_CODE \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
	
		DataSet ds_Class4 = this.makeDataSet(rs, "ds_Class4");
		out_dl.add(ds_Class4);
	
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