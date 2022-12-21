<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 게시판
■ 프로그램ID   : SCC80053P_T001.jsp
■ 프로그램명   : 게시대상 보기 선택
■ 작성일자     : 2012.11.20
■ 작성자       : 박용대
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);
	
	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();	//데이터셋 받는 객체
	
	//입력 데이타셋
	DataSet ds_Cond    = in_dl.get("inDs_Cond");

	String vSabun      = nullToBlank(in_vl.getString("vSabun"));
	String g_EmpNo     = nullToBlank(in_vl.getString("g_EmpNo"));	
	
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	//테스트 출력
	System.out.println("======================");
	//ds_Cond.printDataSet();
	System.out.println("======================");
	
	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
	
		//삭제
		for ( int i = 0 ; i < ds_Cond.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("\n\n");
			sbSql.append("DELETE FROM SCC_BBS_PRIV_LIST \n");
			if (! nullToBlank(ds_Cond.getString(i, "CON_ID")).equals(""))
				sbSql.append("   WHERE CON_ID = " + nullToBlank(ds_Cond.getString(i, "CON_ID")) + " \n");
	        sbSql.append("\n\n");

	        pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		
		//삽입
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$");
		System.out.println(ds_Cond.getRowCount());
		
		for ( int i = 0 ; i < ds_Cond.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("\n\n");
			sbSql.append("INSERT INTO SCC_BBS_PRIV_LIST     \n");
	        sbSql.append("     ( CON_ID                     \n");
	        sbSql.append("     , TARGET_CODE                \n");
	        sbSql.append("     , TARGET_CLASS               \n");
	        sbSql.append("     , CUSER	                    \n");
	        sbSql.append("     , CDATE                      \n");
	        sbSql.append("     , UUSER                      \n");
	        sbSql.append("     , UDATE                      \n");
	        sbSql.append("     ) VALUES (                   \n");
	        sbSql.append("      '" + nullToBlank(ds_Cond.getString(i, "CON_ID")) + "'           \n");
	        sbSql.append("     , '" + nullToBlank(ds_Cond.getString(i, "UPJANG")) + "'           \n");
	        sbSql.append("     , '" + nullToBlank(ds_Cond.getString(i, "T_CLASS")) + "'           \n");	        
	        sbSql.append("     , '" + g_EmpNo + "'                          	                         \n");
	        sbSql.append("     , SYSDATE                   										         \n");
	        sbSql.append("     , '" + g_EmpNo + "'                          					         \n");
	        sbSql.append("     , SYSDATE                  										         \n");
	        sbSql.append("     )                  										         \n");
	        sbSql.append("\n\n");

	        pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}		
		
		/**종료**/
		conn.commit();
		out_vl.add("fa_Msg", "");
		this.setResultMessage(0, "OK", out_vl);
	
	}
	catch(Exception ex)
	{
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