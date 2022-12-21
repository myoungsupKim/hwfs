
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		DataSet in_ds  =  in_dl.get("FSA00023E_T001");
		stmt =  conn.createStatement();
		
		//FileLog.println("d:\\bbb.txt",in_ds);

						
		int RowCnt = in_ds.getRowCount();
		int i=0;
		StringBuffer sbSql = new StringBuffer();
		
		RowCnt = in_ds.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
   			sbSql.delete(0, sbSql.length());
			//DELETE를 수행한다. --업장표준레시피 마스터
	    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_MST											  ");
			sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
			sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
			sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
				stmt.execute(sbSql.toString());	
			
	   			sbSql.delete(0, sbSql.length());
			//DELETE를 수행한다. --업장표준레시피 품목
	    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_ITEM											  ");
			sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
			sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
			sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
				stmt.execute(sbSql.toString());	
			
				sbSql.delete(0, sbSql.length());
			//DELETE를 수행한다. --업장표준레시피 조리법
	    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_CUISINE								  ");
			sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
			sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
			sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
				stmt.execute(sbSql.toString());	
			
				sbSql.delete(0, sbSql.length());
			//DELETE를 수행한다. --업장표준레시피 특이사항
		   	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_SPECIAL								  ");
			sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
			sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
			sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
			stmt.execute(sbSql.toString());	
		}
		
	  //트랜잭션 성공
	   conn.commit();	   
	   this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
	  //트랜잭션 실패
	  conn.rollback();	  
	  
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
	}
    proc_output(response,out,out_vl,out_dl);  
%>