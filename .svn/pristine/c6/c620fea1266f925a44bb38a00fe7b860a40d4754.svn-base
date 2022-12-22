<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMO00800E_T001.jsp
■ 프로그램명   : 파출부 급여내역서
■ 작성일자     : 2012-08-29
■ 작성자       : 박용대
■ 이력관리     : 2012-08-29 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);
	
	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();	//데이터셋 받는 객체

	//입력 파라미터 값 설정
	String empNo 		= in_vl.getString("g_EmpNo"); 
	
	//입력 데이타셋
	DataSet ds_cond   	= in_dl.get("ds_Cond");
	
	//입력 데이타셋 값 설정
	String upjang	= ds_cond.getString(0,"UPJANG");
	String menuCode	= ds_cond.getString(0,"MENU_CODE");
	String recipeCd	= ds_cond.getString(0,"RECIPE_CD");
	
	//테스트 출력
	System.out.println("======================");
	System.out.println(recipeCd +"/"+ menuCode +"/"+ upjang);
	System.out.println("======================");
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
		sbSql.append("\n\n");
        sbSql.append("UPDATE                        \n");
        sbSql.append(" 	FMM_RECIPE                  \n");
        sbSql.append("SET                           \n");
        sbSql.append("	  ATTR04 = 2                 \n");
        sbSql.append("	, UUSER = '"+empNo+"'          \n");
        sbSql.append("	, UDATE = SYSDATE            \n");
        sbSql.append("WHERE	UPJANG = '"+upjang+"'       \n");
        sbSql.append("AND MENU_CD = '"+menuCode+"'       \n");
        sbSql.append("AND RECIPE_CD = '"+recipeCd+"'   \n");

	    sbSql.append("\n\n");
        
	    pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();
		
	    conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);

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