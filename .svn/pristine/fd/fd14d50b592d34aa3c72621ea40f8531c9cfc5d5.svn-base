
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
		DataSet ds_Detail  		= in_dl.get("ds_Detail");
		DataSet ds_input     	= in_dl.get("ds_input"); 
		
	  	String strTableType		= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
	  	String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		String strMsg,strClassCD,strClassType;
		int nCnt,DelRowCnt;
	
	
		DelRowCnt = ds_Detail.getRemovedRowCount();
		
		if (DelRowCnt > 0)	// 1. 삭제
		{
			strClassCD 		= ds_Detail.getRemovedData(0, "CLASS_CD").toString();
			strClassType	= ds_Detail.getRemovedData(0, "CLASS_TYPE").toString();
			
			// 1. 값체크
			sbSql.append("SELECT COUNT(*) AS CNT \n");
			sbSql.append("  FROM FSC_SAFE_RESULT_MST \n");
			sbSql.append("WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
			
			//System.out.println(sbSelSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery(); 
			rs.next();
			nCnt	= rs.getInt("CNT");
			
			rs.close();
			pstmt.close();
			
			if (nCnt > 0)
			{
				strMsg = "작성된 정검등록내역이 있습니다.\n확인해 주십시오. \n";
				this.setResultMessage(-1, strMsg ,out_vl);
				proc_output(response,out,out_vl,out_dl);
				return;
			}
			
			// 코드삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_SAFE_CLASS_MST \n");
			sbSql.append("WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
			sbSql.append("  AND CLASS_CD = '" + strClassCD + "' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 양식삭제
			if (strClassType.equals("S"))
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM FSC_SAFE_FORM_DTL \n");
				sbSql.append("WHERE TABLE_TYPE = '" + strTableType + "' \n");
				sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
				sbSql.append("  AND CLASS_CD = '" + strClassCD + "' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
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