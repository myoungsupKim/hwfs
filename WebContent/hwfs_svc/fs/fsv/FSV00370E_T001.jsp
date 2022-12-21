<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체단가견적제출
■ 프로그램ID   : FSV00370E_T001.jsp
■ 프로그램명   : 협력업체단가견적제출 견적ID 조회
■ 작성일자     : 2012.07.20
■ 작성자       : 문형광
■ 이력관리     : 2012.07.20
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
			
		String g_CustCd 		= in_vl.getString("g_CustCd");
		String vCenterCode  	= in_vl.getString("vCenterCode");
		
		
		//IRIS 접속
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();
		
		stmt =  conn.createStatement();

		DataSet ds_EstimateID;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());				
		sbSql.append("SELECT '전체' AS CODE, '전체' AS CODE_NAME, '' AS CONTRACT_START     				\n");
        sbSql.append("  FROM DUAL                                                         				\n");
        sbSql.append(" UNION ALL                                                          				\n");
        sbSql.append("SELECT ESTIMATE_ID AS CODE, REMARK AS CODE_NAME, ESTIMATE_START AS CONTRACT_START \n");
        sbSql.append("  FROM PO_ESTIMATE_MASTER                                           				\n");
        sbSql.append(" WHERE CENTER_CODE = " + vCenterCode + "                            				\n");
        sbSql.append("   AND CUSTCD = " + g_CustCd + "                                    				\n");
        sbSql.append("   AND USE_YN = 'Y'                                                 				\n");
        sbSql.append(" ORDER BY 1 DESC																	\n");
			 
 		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_EstimateID = this.makeDataSet(rs, "ds_EstimateID"); 
		/**종료**/
		out_dl.add(ds_EstimateID);
		this.setResultMessage(0, "OK", out_vl);

	    } catch(Exception ex) {
		
	    ex.printStackTrace();
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
	}
	
    proc_output(response,out,out_vl,out_dl);
%>