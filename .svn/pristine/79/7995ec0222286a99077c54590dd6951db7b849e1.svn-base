<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/강제레시피                                                                                                                                                                   
■ 프로그램ID   : FSR90100E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 그룹레시피대상업장관리 등록                                                                                                                                               
■ 작성일자     : 2015-02-23                                                                                                                                                                           
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;

	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		// 입력 데이터셋리스트
		in_dl = platformRequest.getData().getDataSetList();
		// 입력  변수리스트
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 	   	  = in_vl.getString("g_EmpNo");
		String TARGET_GRP_SEQ = nullToBlank(in_vl.getString("TARGET_GRP_SEQ"));
		String GRP_SEQ        = "";
		String UPJANG      = "";
		DataSet ds_upjangList = in_dl.get("ds_upjangList");
		
		StringBuffer sbSql = new StringBuffer();				
		int RowCnt = ds_upjangList.getRowCount();

		// 삭제처리
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			GRP_SEQ    = nullToBlank(ds_upjangList.getString(i,"GRP_SEQ")); 
			UPJANG     = nullToBlank(ds_upjangList.getString(i,"UPJANG"));
			
			if(!GRP_SEQ.equals("")) {
				sbSql.delete(0, sbSql.length());	
				sbSql.append("DELETE FROM FSR_ENF_UPJANG WHERE GRP_SEQ = " + GRP_SEQ + " AND UPJANG = '" + UPJANG + "'");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		// 등록처리
		if(!TARGET_GRP_SEQ.equals("")) {
			for ( int i = 0 ; i < RowCnt ; i++ )
			{
				UPJANG  = nullToBlank(ds_upjangList.getString(i,"UPJANG"));
				
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSR_ENF_UPJANG(GRP_SEQ, UPJANG, CUSER, CDATE, UUSER, UDATE) \n");
				sbSql.append("VALUES (" + TARGET_GRP_SEQ + ", '" + UPJANG + "', '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "', SYSDATE) \n");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}		
		
		//트랜잭션 성공
		conn.commit();		
		this.setResultMessage(0, "OK", out_vl);
	
	} catch(Exception ex) {	
		ex.printStackTrace();
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