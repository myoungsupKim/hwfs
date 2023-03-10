
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
		DataSet ds_list  		= in_dl.get("ds_list");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int nCnt,DelRowCnt;
	
	
		DelRowCnt = ds_list.getRemovedRowCount();
		
		if (DelRowCnt > 0)	// 1. 삭제
		{
			String strTableType = ds_list.getRemovedData(0, "TABLE_TYPE").toString();
			String strFormCD 	= ds_list.getRemovedData(0, "FORM_CD").toString();
			String strUpjang 	= ds_list.getRemovedData(0, "UPJANG").toString();
			String strDate 		= ds_list.getRemovedData(0, "CHECK_DATE").toString();
			String strClassCD	= ds_list.getRemovedData(0, "CLASS_CD").toString();
			String strSEQ		= ds_list.getRemovedData(0, "SEQ").toString();
			
			// 1. DELETE
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE \n");
			sbSql.append("  FROM FSC_SAFE_CHK_IMGE \n");
			sbSql.append(" WHERE TABLE_TYPE = '"	+	strTableType	+"' \n");
			sbSql.append("   AND FORM_CD = '"		+	strFormCD		+"' \n");
			sbSql.append("   AND UPJANG = '"		+	strUpjang		+"' \n");
			sbSql.append("   AND CHK_DD = '"	+	strDate			+"' \n");
			sbSql.append("   AND CLASS_CD = '"		+	strClassCD		+"' \n");
			sbSql.append("   AND SEQ = '"			+	strSEQ			+"' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
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