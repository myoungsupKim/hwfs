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
		DataSet ds_tableList  		= in_dl.get("ds_tableList");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		String strTableType,strFormCD,strMsg;
		int nCnt,DelRowCnt;
	
	
		DelRowCnt = ds_tableList.getRemovedRowCount();
		
		if (DelRowCnt > 0)	// 1. 삭제
		{
			strTableType = ds_tableList.getRemovedData(0, "TABLE_TYPE").toString();
			strFormCD = ds_tableList.getRemovedData(0, "FORM_CD").toString();
			
			// 1. 값체크
			sbSql.append("SELECT COUNT(*) AS CNT                    \n");
			sbSql.append("  FROM FSC_CONTRT_RESULT                  \n");
			sbSql.append("WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "'       \n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery(); 
			rs.next();
			nCnt = rs.getInt("CNT");
			
			rs.close();
			pstmt.close();
			
			if (nCnt > 0)
			{
				strMsg = "작성된 정검등록내역이 있습니다.\n확인해 주십시오. \n";
				this.setResultMessage(-1, strMsg ,out_vl);
				proc_output(response,out,out_vl,out_dl);
				return;
			}
			
			// 2. 양식마스터삭제
			// 코드삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_FORM                \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 3. 분류삭제
			// 코드삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_CLASS               \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 양식디테일삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_FORM_DTL            \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();

			// 평가항목 삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_QUST_ARTICLE        \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
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