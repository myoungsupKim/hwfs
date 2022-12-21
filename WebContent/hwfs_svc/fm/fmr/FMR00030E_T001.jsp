<%
/*
 ******************************************************************************************
 * 시스템구분: 
 * 프로그램명: FMM00030E.XML
 * 기ㅡㅡㅡ능: 
 * 작ㅡ성ㅡ자:  
 * 작성ㅡ일자: 
 * ----------------------------------------------------------------------------------------
 * HISTORY    : 
 ******************************************************************************************
 */
 %> 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;

	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 	   		= in_vl.getString("g_EmpNo");
		String RECIPE_NAME      = in_vl.getString("RECIPE_NAME");	
		String NEW_RECIPE_NAME  = in_vl.getString("NEW_RECIPE_NAME");
		String RECIPE_CD   		= in_vl.getString("RECIPE_CD");
		
		stmt 	   = conn.createStatement();                                  //실행명령 선언
		StringBuffer sbSql = new StringBuffer();				
				
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" UPDATE FMR_STD_RECIPE_MST SET RECIPE_NAME='"+NEW_RECIPE_NAME+"' ,UUSER ='"+g_EmpNo+"' ,UDATE=SYSDATE \n ");
				sbSql.append(" WHERE RECIPE_CD    = '"+ RECIPE_CD +"'                                               \n ");
				sbSql.append(" AND   RECIPE_NAME   = '"+ RECIPE_NAME +"'  \n ");
				
				stmt.execute(sbSql.toString());
				
				//트랜잭션 성공
				conn.commit();		
				this.setResultMessage(0, "OK", out_vl);
	
	} catch(Exception ex) {		
		//트랜잭션 실패
		conn.rollback();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
		this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}			
		
		if(pstmt != null) {
			try {
				stmt.close();
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