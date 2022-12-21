<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/폐식용유관리/수거업장등록
■ 프로그램ID   : MAS50021P_T001.jsp
■ 프로그램명   : 수거업장등록
■ 작성일자     : 2015.02.04
■ 작성자       : 김경은
■ 이력관리     : 2015.02.04
최초 작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//입력 데이타
		DataSet ds_mapList   = in_dl.get("ds_mapList");
		//입력 파라메터
		String g_Upjang      = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo       = nullToBlank(in_vl.getString("g_EmpNo"));
		String strCustCd     = nullToBlank(in_vl.getString("strCustCd"));
		String strContractDd = nullToBlank(in_vl.getString("strContractDd"));
		
		conn.setAutoCommit(false);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//기존 데이터 삭제
		sbSql.delete(0, sbSql.length());
        sbSql.append("DELETE MAS_DC_OIL_UPJANG \n");
        sbSql.append(" WHERE CUSTCD = " + strCustCd + " \n");
        sbSql.append("   AND CONTRACT_DD = " + strContractDd + " \n");
        
        out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();
		conn.commit();
		
		for ( int iRow = 0 ; iRow < ds_mapList.getRowCount() ; iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO MAS_DC_OIL_UPJANG                                  \n");
			sbSql.append("( CUSTCD                                                       \n");
			sbSql.append(", UPJANG                                                       \n");
			sbSql.append(", CONTRACT_DD                                                  \n");
			sbSql.append(", CUSER                                                        \n");
			sbSql.append(", CDATE                                                        \n");
			sbSql.append(", UUSER                                                        \n");
			sbSql.append(", UDATE                                                        \n");
			sbSql.append(")                                                              \n");
			sbSql.append("VALUES                                                         \n");
			sbSql.append("( '" + strCustCd + "'                                          \n");
			sbSql.append(", '" + nullToBlank(ds_mapList.getString(iRow, "UPJANG")) + "'  \n");
			sbSql.append(", '" + strContractDd + "'                                      \n");
			sbSql.append(", '" + g_EmpNo + "'                                            \n");
			sbSql.append(", SYSDATE                                                      \n");
			sbSql.append(", '" + g_EmpNo + "'                                            \n");
			sbSql.append(", SYSDATE                                                      \n");
			sbSql.append(")                                                              \n");
			
			//out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}	

		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		conn.rollback();
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
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
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>