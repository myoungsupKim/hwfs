<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30010E_D001.jsp
■ 프로그램명   : 사업계획관리
■ 작성일자     : 2015-12-17
■ 작성자       : 강대성
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		String GUBUN 	= nullToBlank(ds_Cond.getString(0, "GUBUN"));
		
		
		if(GUBUN.equals("ALL"))
		{
			StringBuffer sbSql = new StringBuffer();	
			// 사업계획 완전 초기화
	        sbSql.append("DELETE FROM MAP_BIZ_LOG_MGMT  														\n");
	        sbSql.append(" WHERE YY = '2017' 			\n");
	        sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
	        
			pstmt = conn.prepareStatement(sbSql.toString());
	        pstmt.executeUpdate();
	        pstmt.close();
	        
	        //sql문 버퍼생성
			StringBuffer sbSql1 = new StringBuffer();
	     	// 사업계획 완전 초기화
	        sbSql1.append("DELETE FROM MAP_BIZ_PLAN  														\n");
	        sbSql1.append(" WHERE YY = '2017' 			\n");
	        sbSql1.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
	        
			pstmt = conn.prepareStatement(sbSql1.toString());
	        pstmt.executeUpdate();
	        pstmt.close();
	        
	        //sql문 버퍼생성
			StringBuffer sbSql2 = new StringBuffer();
	     	// 사업계획 완전 초기화
	        sbSql2.append("DELETE FROM MAP_BIZ_PLAN_DTL  														\n");
	        sbSql2.append(" WHERE YY = '2017' 			\n");
	        sbSql2.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
	        
			pstmt = conn.prepareStatement(sbSql2.toString());
	        pstmt.executeUpdate();
	        pstmt.close();
		}
		else if(GUBUN.equals("LAST"))
		{
			
			//sql문 버퍼생성
			StringBuffer sbSql = new StringBuffer();	
			// 사업계획 완전 초기화
	        sbSql.append("DELETE FROM MAP_BIZ_LOG_MGMT  														\n");
	        sbSql.append(" WHERE YY = '2017' 			\n");
	        sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
	        sbSql.append("   AND BIZ_CLASS <>'[FC] 2017년 사업계획 1차' 		\n");
	        
			pstmt = conn.prepareStatement(sbSql.toString());
	        pstmt.executeUpdate();
	        pstmt.close();
	        
	        //sql문 버퍼생성
			StringBuffer sbSql1 = new StringBuffer();
	     	// 사업계획 완전 초기화
	        sbSql1.append("DELETE FROM MAP_BIZ_PLAN  														\n");
	        sbSql1.append(" WHERE YY = '2017' 			\n");
	        sbSql1.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
	        sbSql1.append("   AND BIZ_CLASS <>'[FC] 2017년 사업계획 1차' 		\n");
	        
			pstmt = conn.prepareStatement(sbSql1.toString());
	        pstmt.executeUpdate();
	        pstmt.close();
	        
	      	//sql문 버퍼생성
			StringBuffer sbSql2 = new StringBuffer();
	     	// 사업계획 완전 초기화
	        sbSql2.append("DELETE FROM MAP_BIZ_PLAN_DTL  														\n");
	        sbSql2.append(" WHERE YY = '2017' 			\n");
	        sbSql2.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");
	        sbSql2.append("   AND BIZ_CLASS <>'[FC] 2017년 사업계획 1차' 		\n");
	        
			pstmt = conn.prepareStatement(sbSql2.toString());
	        pstmt.executeUpdate();
	        pstmt.close();
		
		}
		
		/**종료**/
        conn.commit();
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