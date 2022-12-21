/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00400E_T003.jsp
■ 프로그램명   : 자재이력관리(삭제)
■ 작성일자     : 2008-07-01
■ 작성자       : 박은규
■ 이력관리     : 2008-07-01 - 최초작성 박은규 CSR#(28344)
                2009-07-24 박은규 CSR#(29350) 요청자:김경운(구매지원팀)
                축산법률 규정변경에 따른 관리항목 변경
-----------------------------------------------------------------------------*/

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_list  		= in_dl.get("ds_list");
		DataSet ds_input     	= in_dl.get("ds_input"); 
		
		String strCnterCode 		= nullToBlank(ds_input.getString(0, "CENTER_CODE"));                                                                                                                                                                                                        
		String strCustCD			= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String g_EmpNo 				= in_vl.getString("g_EmpNo");
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		= conn.createStatement();
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		String strHistID;
		int DelRowCnt;

		DelRowCnt = ds_list.getRemovedRowCount();

		if (DelRowCnt > 0)	// 1. 삭제
		{
			System.out.println("DelRowCnt : " + DelRowCnt);
				sbSql.delete(0, sbSql.length());
/*
				sbSql.append("UPDATE PO_ITEM_HIST \n");
				sbSql.append("SET APRV_YN = 'N' \n");
				sbSql.append("	, USE_YN = 'N' \n");
				sbSql.append("	, UPDATE_DATE = SYSDATE \n");
				sbSql.append("	, UPDATE_BY = '" + g_EmpNo + "' \n");
				sbSql.append(" WHERE CENTER_CODE = '" 	+	strCnterCode + "' \n");
				sbSql.append("   AND CUSTCD      = '" 	+	strCustCD + "' \n");
				sbSql.append("   AND ITEM_CODE   = '"	+	ds_list.getRemovedData(0, "ITEM_CODE").toString()	+"' \n");
*/
				sbSql.append("DELETE FROM PO_ITEM_HIST \n");
				//sbSql.append(" WHERE HIST_ID = " + ds_list.getRemovedData(0, "HIST_ID").toString() + " \n");
				sbSql.append(" WHERE CENTER_CODE = '" 	+	strCnterCode + "' \n");
				sbSql.append("   AND CUSTCD      = '" 	+	strCustCD + "' \n");
				sbSql.append("   AND ITEM_CODE   = '"	+	ds_list.getRemovedData(0, "ITEM_CODE").toString()	+"' \n");
		}
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		stmt.execute(sbSql.toString());
		
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
			conn.rollback();
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