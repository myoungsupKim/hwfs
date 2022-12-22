<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/협력업체위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00310E_T002.jsp                                                                                                                                                                    
■ 프로그램명   : 협력업체점검결과등록 - 결과 확정                                                                                                                                               
■ 작성일자     : 2015-02-17                                                                                                                                                                            
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
		
		//데이타               
		String g_EmpNo    = in_vl.getString("g_EmpNo");
		DataSet ds_resultMst = in_dl.get("ds_resultMst");		
		
		int RowStatus;
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		
		String TABLE_TYPE = nullToBlank(ds_resultMst.getString(0, "TABLE_TYPE"));       
		String FORM_CD    = nullToBlank(ds_resultMst.getString(0, "FORM_CD"));          
		String CUSTCD     = nullToBlank(ds_resultMst.getString(0, "CUSTCD"));           
		String CHK_DD     = nullToBlank(ds_resultMst.getString(0, "CHK_DD"));    
		//2018.05.25 김명섭 하위공장명추가
		String SUB_COMP_NM = nullToBlank(ds_resultMst.getString(0, "SUB_COMP_NM"));    
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FSC_CONTRT_RESULT                 \n");
		sbSql.append("   SET CONFIRM_YN = 'Y'                  \n");
		sbSql.append("     , CONFIRM_DD = TO_CHAR(SYSDATE, 'YYYYMMDD') \n");		
		sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
		sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
		sbSql.append("   AND CUSTCD     = '" + CUSTCD     + "' \n");
		sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
		sbSql.append("   AND SUB_COMP_NM= '" + SUB_COMP_NM+ "' \n");
				
		stmt = conn.createStatement();
		stmt.execute(sbSql.toString());
		stmt.close();
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
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