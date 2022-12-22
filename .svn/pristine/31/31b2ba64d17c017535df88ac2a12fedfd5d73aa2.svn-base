<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     :                                                                                                                                                                
■ 프로그램ID  : FSA00090E_T002.jsp                                                                                                                                                                  
■ 프로그램명   : 추가구매 승인 신청                                                                                                                                              
■ 작성일자     : 2008-07-21                                                                                                                                                                        
■ 작성자       : 박지영
■ 수정자       : 정영철
■ 이력관리     : 2015-06-10                                                                                                                                     
-----------------------------------------------------------------------------*/                                                                                                                         
%>   

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_list  		= in_dl.get("ds_del_list");
		
		stmt 		= conn.createStatement();
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int nCnt;
		
		String strUpjang	= ds_list.getString(0, "UPJANG").toString();
		String strStartDt 	= ds_list.getString(0, "START_DATE").toString();
		String strEndDt 	= ds_list.getString(0, "END_DATE").toString();
		
		// 1. 결과마스터삭제
		sbSql.delete(0, sbSql.length());
		sbSql.append("DELETE \n");
		sbSql.append("  FROM FSA_PR_CHECK \n");
		sbSql.append(" WHERE UPJANG = '" + strUpjang + "' \n");
		sbSql.append("   AND START_DATE = '" + strStartDt + "' \n");
		sbSql.append("   AND END_DATE = '" + strEndDt + "' \n");
		sbSql.append("   AND APRV_YN = 'N' \n");
		
		stmt = conn.createStatement();
		stmt.execute(sbSql.toString());
		nCnt = stmt.getUpdateCount();
		stmt.close();     
		
		if (nCnt == 0)
		{
			String strMsg = "승인된 데이터 입니다. \n확인해 주십시오.\n";
			this.setResultMessage(-1, strMsg ,out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
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