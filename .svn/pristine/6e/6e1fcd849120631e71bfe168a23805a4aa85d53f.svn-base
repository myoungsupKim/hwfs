<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		// 개별식단 식수예측 리스트 조회
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		DataSet ds_input  				= in_dl.get("ds_input");
		DataSet ds_chkMenuList  	= in_dl.get("ds_chkMenuList");
	
		StringBuffer sbSelSql = new StringBuffer();
		
		int RowCnt;
		String v_Upjang,v_Subinv,v_Menudate,v_Meal,v_Corner;
		
		v_Upjang		= in_vl.getString("fa_UPJANG");
		v_Subinv		= in_vl.getString("fa_SUBINV_CODE");

		RowCnt = ds_chkMenuList.getRowCount()-1;
		
		for ( int i = RowCnt ; i >= 0 ; i-- )
		{		
			v_Menudate	= ds_chkMenuList.getString(i,"MENU_DATE");
			v_Meal  		= ds_chkMenuList.getString(i,"MEAL");
			v_Corner  	= ds_chkMenuList.getString(i,"CORNER");
			
			// 식수예측값이 있는경우 입력 리스트에서 제외시킴  
			sbSelSql.delete(0, sbSelSql.length());    
			sbSelSql.append("SELECT MENU_DATE \n");
			sbSelSql.append("  FROM FMM_MENU \n");
			sbSelSql.append(" WHERE UPJANG = '" + v_Upjang + "' \n");
			sbSelSql.append("   AND MENU_CD = '" + v_Menudate + "-" + v_Subinv + v_Meal + v_Corner + "' \n");
			sbSelSql.append("   AND EXPECT_MEAL_QTY > 0 \n");
			
			//System.out.println(sbSelSql.toString());
			pstmt = conn.prepareStatement(sbSelSql.toString());		                                                                                                                                                
			rs = pstmt.executeQuery(); 
			
			if(rs.next())	
			{
				ds_chkMenuList.removeRow(i);
			}
			
			rs.close();
			pstmt.close();
		}
		
		out_dl.add(ds_chkMenuList);
		this.setResultMessage(0, "OK",out_vl);
	   
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl); 
	} finally {
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
	}
    proc_output(response,out,out_vl,out_dl);
    
%>