<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page import="java.math.BigDecimal" %>
<%
	Statement stmt          =  null;
	CallableStatement cstmt = null;
	
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		String g_EmpNo 		 = in_vl.getString("g_EmpNo");
		DataSet ds_resultMst = in_dl.get("ds_resultMst");
		
		String TABLE_TYPE  = nullToBlank(ds_resultMst.getString(0, "TABLE_TYPE")); 
		String FORM_CD     = nullToBlank(ds_resultMst.getString(0, "FORM_CD")); 
		String CUSTCD      = nullToBlank(ds_resultMst.getString(0, "CUSTCD")); 
		String CHK_DD      = nullToBlank(ds_resultMst.getString(0, "CHK_DD")); 
		String VD_SN       = nullToBlank(ds_resultMst.getString(0, "VD_SN")); 
		String SCORE       = nullToBlank(ds_resultMst.getString(0, "SCORE")); 
		String GRADE_CD    = nullToBlank(ds_resultMst.getString(0, "GRADE_CD")); 
		String CHK_RESULT  = nullToBlank(ds_resultMst.getString(0, "CHK_RESULT")); 
		String SUB_COMP_NM = nullToBlank(ds_resultMst.getString(0, "SUB_COMP_NM")); 
		
		StringBuffer sbSql = new StringBuffer();

//		 P_TABLE_TYPE      IN VARCHAR2,    /* 점검표구분 */ 
//		 P_FORM_CD         IN NUMBER,      /* 양식코드 */
//		 P_CUSTCD          IN NUMBER,      /* 업체코드 */
//		 P_CHK_DD          IN VARCHAR2,    /* 점검일 */   
//		 P_VD_SN           IN VARCHAR2,    /* 전사구매 협력사 내부키 */  
//		 P_SCORE     IN NUMBER,      /* 총점 */   
//		 P_GRADE     IN VARCHAR2,    /* 등급 */    
//		 P_RESULT    IN VARCHAR2,    /* 점검결과(적합,부적합) */  
//		 P_RET_CD          OUT VARCHAR2,
//		 P_RET_MSG         OUT VARCHAR2
		
		// 매출등록 프로시져 호출
		cstmt = conn.prepareCall( "{call EPROCUSR.SP_IF_AUDIT_CMPLT_FCUS(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );		
		int idx = 1;
		cstmt.setString(idx++, TABLE_TYPE);
	    cstmt.setBigDecimal(idx++, new BigDecimal(FORM_CD));
	    cstmt.setBigDecimal(idx++, new BigDecimal(CUSTCD));
	    cstmt.setString(idx++, CHK_DD);
	    cstmt.setString(idx++, VD_SN); 
	    cstmt.setBigDecimal(idx++, new BigDecimal(SCORE)); 
	    cstmt.setString(idx++, GRADE_CD);
	    cstmt.setString(idx++, CHK_RESULT);
		cstmt.registerOutParameter(idx++, Types.VARCHAR);  // 오류코드
		cstmt.registerOutParameter(idx++, Types.VARCHAR);  // 오류메시지
		cstmt.execute();
		
		System.out.println(cstmt.getString(10));
		if(cstmt.getString(9).equals("E"))	
		{
			conn.rollback();
			this.setResultMessage(-1, cstmt.getString(14), out_vl);
		   	proc_output(response,out,out_vl,out_dl);
		   	return;
		}

		// 구매 전송정보 수정
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FSC_CONTRT_RESULT \n");
		sbSql.append("   SET PO_SEND_YN = 'Y'  \n");
		sbSql.append("     , PO_SEND_DATE = SYSDATE  \n");
		sbSql.append("     , PO_SEND_USER = '" + g_EmpNo + "'  \n");
		sbSql.append(" WHERE TABLE_TYPE = '"  + TABLE_TYPE + "' \n");
		sbSql.append("   AND FORM_CD = '"  + FORM_CD + "' \n");
		sbSql.append("   AND CUSTCD = '"  + CUSTCD + "' \n");
		sbSql.append("   AND CHK_DD = '"  + CHK_DD + "' \n");		
		sbSql.append("   AND SUB_COMP_NM = '"  + SUB_COMP_NM + "' \n");		

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
		if(cstmt != null) {
			try {
				cstmt.close();
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