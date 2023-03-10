<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/CS진단관리                                                                                                                                                              
■ 프로그램ID   : FSC00410E_T003.jsp                                                                                                                                                                    
■ 프로그램명   : 패트롤점검결과등록 - 점검결과삭제                                                                                                                                               
■ 작성일자     : 2015-02-25                                                                                                                                                                            
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
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_resultList = in_dl.get("ds_resultList");

		StringBuffer sbSql = new StringBuffer();	//sql문 버퍼생성
		
		int nCnt,DelRowCnt;
		DelRowCnt = ds_resultList.getRemovedRowCount();
		if (DelRowCnt > 0)	// 1. 삭제
		{
			String TABLE_TYPE = ds_resultList.getRemovedData(0, "TABLE_TYPE").toString();
			String FORM_CD 	  = ds_resultList.getRemovedData(0, "FORM_CD").toString();
			String UPJANG 	  = ds_resultList.getRemovedData(0, "UPJANG").toString();
			String CHK_DD     = ds_resultList.getRemovedData(0, "CHK_DD").toString();
			
			// 1. 결과마스터삭제 
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE                                   \n");
			sbSql.append("  FROM FSC_PATL_RESULT                 \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG     + "' \n");
			sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 2. 결과디테일삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE                                   \n");
			sbSql.append("  FROM FSC_PATL_RESULT_DTL                    \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG     + "' \n");
			sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 2. 파일삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE                                   \n");
			sbSql.append("  FROM FSC_PATL_CHK_IMGE               \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG     + "' \n");
			sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		ex.printStackTrace();
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