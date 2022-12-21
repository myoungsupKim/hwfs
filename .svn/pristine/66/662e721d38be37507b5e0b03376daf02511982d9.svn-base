<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/식단운영관리/음식물쓰레기 Loss비용관리(관리자)
■ 프로그램ID   : FSM00450V_S001.jsp
■ 프로그램명   : 조회조건 콤보구성
■ 작성일자     : 2008.04.01
■ 작성자       : 
■ 이력관리     : 2008.04.01
               박은규 2010-07-26 CSR#(37836) 요청자:이명희(메뉴개발팀)
               계열사구분 조회조건 추가
-----------------------------------------------------------------------------*/
%>
<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
			
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
						
	//		String SAUPTYPE 	= nullToBlank(in_vl.getString("SAUPTYPE"));		
	//		String TM 			= nullToBlank(in_vl.getString("TM"));
	//		String UPJANG 		= nullToBlank(in_vl.getString("UPJANG"));
	//		String FROM			= nullToBlank(in_vl.getString("FROM"));
	//		String TO			= nullToBlank(in_vl.getString("TO"));
	
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
		
		stmt 		=  conn.createStatement();

		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT ' ' CODE,' ' CODE_NAME FROM DUAL UNION SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0037'	--비용부담주체			\n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		//this.makeDataSet(rs,"output").dump();
		DataSet ds_Mgmt = this.makeDataSet(rs,"ds_Mgmt");
		out_dl.add(ds_Mgmt);
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT ' ' CODE,' ' CODE_NAME FROM DUAL UNION SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0042'	--계약관리주체			\n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		//this.makeDataSet(rs,"output").dump();
		DataSet ds_Mgmt1 = this.makeDataSet(rs,"ds_Mgmt1");
		out_dl.add(ds_Mgmt1);
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT ' ' CODE,' ' CODE_NAME FROM DUAL UNION SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0039'	--요금체계			\n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		//this.makeDataSet(rs,"output").dump();
		DataSet ds_Fee = this.makeDataSet(rs,"ds_Fee");
		out_dl.add(ds_Fee);

//============================================================================================
//(2010-07-26 추가) 시작
// 박은규 2010-07-26 CSR#(37836) 요청자:이명희(메뉴개발팀)
// 계열사구분 조회조건 추가 및 내용추가
//============================================================================================
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT ' ' CODE,' ' CODE_NAME FROM DUAL UNION SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE  WHERE GROUP_CODE = 'MA0003'	--요금체계			\n");
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		//this.makeDataSet(rs,"output").dump();
	    DataSet ds_Rel = this.makeDataSet(rs,"ds_Rel");
		out_dl.add(ds_Rel);
//============================================================================================
//(2010-07-26 추가) 끝
//============================================================================================

		this.setResultMessage(0, "OK",out_vl);
		
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
		proc_output(response,out,out_vl,out_dl);
	}
%>