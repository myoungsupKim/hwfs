<%

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
		//입력 데이타
		DataSet ds_Item  		= in_dl.get("ds_Item");
//		String strCustCD		= nullToBlank(ds_Cond.getString(0, "CUSTCD"));
		String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));
		String sItem_Code       = "";
		int sRowStatus       = 0;
			
		//입력 파라메터
		//String strUpjang 		= ds_cond.getRemovedData(0, "UPJANG").toString();
		//String strOtcust        = ds_cond.getRemovedData(0, "OTCUSTCD").toString();		
		//String g_OTCUSTCD    = nullToBlank(in_vl.getString("OTCUSTCD"));	
		System.out.println(ds_Item.getRowCount());
		
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		sRowStatus = ds_Item.getRowType(0);
		
	//	System.out.println(sRowStatus);
		System.out.println(ds_Item.getString(0, "ITEM_SIZE_KG"));
		
		//rs.close();
		//pstmt.close();		
		
		//기존자료 삭제
		//sbSql.delete(0, sbSql.length());
	//	System.out.println(v_OTCUSTCD +"ddd");	

		if(sRowStatus == DataSet.ROW_TYPE_INSERTED)
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT 'OT'||LPAD(FMW_OTCUST_ITEM_S.NEXTVAL,10,'0') AS ITEM_CODE \n");
	        sbSql.append("  FROM DUAL                                                      \n");
out_vl.add("fa_Sql", sbSql.toString());
	        pstmt = conn.prepareStatement(sbSql.toString());
	        rs = pstmt.executeQuery();
			rs.next();
			sItem_Code = rs.getString("ITEM_CODE");				
			rs.close();
			pstmt.close();
			sbSql.delete(0, sbSql.length());
	        sbSql.append("INSERT INTO FMW_OTCUST_ITEM(   											\n");
	        sbSql.append("  ITEM_CODE                    											\n");
	        sbSql.append(", OTCUSTCD                     											\n");
	        sbSql.append(", UPJANG                       											\n");
	        sbSql.append(", ITEM_NAME                    											\n");
	        sbSql.append(", ITEM_CLASS3                 	 										\n");
	        sbSql.append(", ITEM_SIZE_KG                 											\n");
	        sbSql.append(", ITEM_SIZE_BONG               											\n");
	        sbSql.append(", ITEM_SIZE_BOX                											\n");
	        sbSql.append(", G_CONVERT_RATE              	 										\n");
	        sbSql.append(", BODY_WIDTH                   											\n");
	        sbSql.append(", BODY_VERTICAL                											\n");
	        sbSql.append(", BODY_HEIGHT                  											\n");
	        sbSql.append(", UNIT_PRICE_BONG               											\n");
	        sbSql.append(", SALE_PRICE_BONG              											\n");
	        sbSql.append(", TAX_CODE                     											\n");
	        sbSql.append(", SHELF_LIFE                   											\n");
	        sbSql.append(", USE_YN                       											\n");
	        sbSql.append(", CUSER                        											\n");
	        sbSql.append(", CDATE                        											\n");
	        sbSql.append(", UUSER                        											\n");
	        sbSql.append(", UDATE) VALUES(               											\n");
	        sbSql.append("  '" + sItem_Code + "'          										    \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "OTCUSTCD")) + "'         \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "UPJANG")) + "'           \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "ITEM_NAME")) + "'        \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "ITEM_CLASS3")) + "'      \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "ITEM_SIZE_KG")) + "'     \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "ITEM_SIZE_BONG")) + "'   \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "ITEM_SIZE_BOX")) + "'    \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "G_CONVERT_RATE")) + "'   \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "BODY_WIDTH")) + "'       \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "BODY_VERTICAL")) + "'    \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "BODY_HEIGHT")) + "'      \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "UNIT_PRICE_BONG")) + "'  \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "SALE_PRICE_BONG")) + "'  \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "TAX_CODE")) + "'         \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "SHELF_LIFE")) + "'       \n");
	        sbSql.append(", '" + nullToBlank(ds_Item.getString(0, "USE_YN")) + "'           \n");
	        sbSql.append(", '" + g_EmpNo + "'                             							\n");
	        sbSql.append(", SYSDATE                             									\n");
	        sbSql.append(", '" + g_EmpNo + "'                             							\n");
	        sbSql.append(", SYSDATE                             									\n");
	        sbSql.append(")                              											\n");
		}
		else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
		{
			sbSql.delete(0, sbSql.length());
	        sbSql.append("UPDATE FMW_OTCUST_ITEM   \n");
	        sbSql.append("   SET ITEM_NAME = '" + nullToBlank(ds_Item.getString(0, "ITEM_NAME")) + "'      			\n");
	        sbSql.append("     , ITEM_SIZE_KG = '" + nullToBlank(ds_Item.getString(0, "ITEM_SIZE_KG")) + "'   		\n");
	        sbSql.append("     , ITEM_SIZE_BONG = '" + nullToBlank(ds_Item.getString(0, "ITEM_SIZE_BONG")) + "' 	\n");
	        sbSql.append("     , ITEM_SIZE_BOX = '" + nullToBlank(ds_Item.getString(0, "ITEM_SIZE_BOX")) + "'  		\n");
	        sbSql.append("     , G_CONVERT_RATE = '" + nullToBlank(ds_Item.getString(0, "G_CONVERT_RATE")) + "' 	\n");
	        sbSql.append("     , BODY_WIDTH = '" + nullToBlank(ds_Item.getString(0, "BODY_WIDTH")) + "'    	 		\n");
	        sbSql.append("     , BODY_VERTICAL = '" + nullToBlank(ds_Item.getString(0, "BODY_VERTICAL")) + "'  		\n");
	        sbSql.append("     , BODY_HEIGHT = '" + nullToBlank(ds_Item.getString(0, "BODY_HEIGHT")) + "'    		\n");
	        sbSql.append("     , UNIT_PRICE_BONG = '" + nullToBlank(ds_Item.getString(0, "UNIT_PRICE_BONG")) + "'   \n");
	        sbSql.append("     , SALE_PRICE_BONG = '" + nullToBlank(ds_Item.getString(0, "SALE_PRICE_BONG")) + "'   \n");
	        sbSql.append("     , TAX_CODE = '" + nullToBlank(ds_Item.getString(0, "TAX_CODE")) + "'       			\n");
	        sbSql.append("     , SHELF_LIFE = '" + nullToBlank(ds_Item.getString(0, "SHELF_LIFE")) + "'     		\n");
	        sbSql.append("     , USE_YN = '" + nullToBlank(ds_Item.getString(0, "USE_YN")) + "'         			\n");
	        sbSql.append("     , UUSER = '" + g_EmpNo + "'          														\n");
	        sbSql.append("     , UDATE = SYSDATE          																	\n");
	        sbSql.append(" WHERE ITEM_CODE = '" + nullToBlank(ds_Item.getString(0, "ITEM_CODE")) + "'  				\n");
	        sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Item.getString(0, "UPJANG")) + "'        				\n");
	        sbSql.append("   AND OTCUSTCD = '" + nullToBlank(ds_Item.getString(0, "OTCUSTCD")) + "'       			\n");

		}
out_vl.add("fa_Sql", sbSql.toString());	
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
	    conn.commit();
	    
		//pstmt.close();
		//rs.close();
		
	    //System.out.println("E");
   	    this.setResultMessage(0, "OK",out_vl);
		
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
