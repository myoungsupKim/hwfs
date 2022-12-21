<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : SCC_GET_SUBINV
■ 프로그램명   : 창고목록 가져오기
■ 작성일자     : 2014-04-22
■ 작성자       : 박용대
■ 이력관리     : 2014-04-22 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체(데이터셋만 받음)
	PlatformRequest platformRequest = this.proc_input(request);

	//in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();	//데이터셋 받는 객체
	
	//입력 데이타셋
	DataSet ds_list   = in_dl.get("inDs_Cond");

	//입력 파라미터(파라미터 없음)
	//String g_EmpNo    = nullToBlank(in_vl.getString("EmpNo"));
	
	//파일로그(파일로그 없음)
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	//테스트 출력(데이터 셋 출력)
	System.out.println("======================");
	//ds_list.printDataSet();
	System.out.println("======================");
	
	//로직 시작
	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//변수선언
		String sabun 		= ds_list.getString(0,"SABUN");
		
		sbSql.append("\n\n");
		sbSql.append("SELECT ROLE \n");
		sbSql.append("  FROM SCC_USER_ROLE V \n");
		sbSql.append(" WHERE V.SABUN = '" + nullToBlank(sabun) + "' \n"); 
		sbSql.append(" AND V.USE_YN = 'Y' \n");
        sbSql.append("\n\n");			

		//쿼리 실행
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set으로 부터 데이터셋 생성
		ds_list = this.makeDataSet(rs, "ds_List");
		
		//출력 데이터 리스트에 outDs_List 이름으로 데이터 셋 추가 
		out_dl.add(ds_list);
		
		//출력 변수리스트에 메세지를 저장
		this.setResultMessage(0, "OK", out_vl);		

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally	//존재하는 객체를 모두 닫아줌
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
