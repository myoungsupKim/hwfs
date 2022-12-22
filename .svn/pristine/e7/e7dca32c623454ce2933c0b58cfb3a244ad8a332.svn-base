<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : SCC_UPJANG_S001.jsp
■ 프로그램명   : 업장목록 가져오기
■ 작성일자     : 2013-01-17
■ 작성자       : 박용대
■ 이력관리     : 2013-01-17 최초작성
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

		//
		String kind 		= ds_list.getString(0,"UserKind");
		String Main_Upjang 	= ds_list.getString(0,"Main_Upjang");
		String Upjang 		= ds_list.getString(0,"Upjang");
		
		if(kind.equals("본사"))	//본사에 포함된 사업장만 보여주면 됨
		{
			sbSql.append("\n\n");
	        sbSql.append("SELECT A.UPJANG,                  \n");
	        sbSql.append("       A.UPJANGNM_DISP            \n");
	        sbSql.append("  FROM FMS_UPJANG A               \n");
	        sbSql.append(" WHERE A.MAIN_UPJANG = "+Main_Upjang+"  \n");
	        sbSql.append("\n\n");			
		}
		else if(kind.equals("사업장"))	//사업장 본인의 사업장만 조회
		{
			sbSql.append("\n\n");
	        sbSql.append("SELECT A.UPJANG,                     \n");
	        sbSql.append("       A.UPJANGNM_DISP               \n");
	        sbSql.append("  FROM FMS_UPJANG A                  \n");
	        sbSql.append(" WHERE A.UPJANG = "+Upjang+"         \n");
	        sbSql.append("\n\n");
		}
		else if(kind.equals("본부"))	//사업장 전체를 조회
		{
			sbSql.append("\n\n");
	        sbSql.append(" SELECT A.UPJANG,                 \n");
	        sbSql.append("       A.UPJANGNM_DISP            \n");
	        sbSql.append("  FROM FMS_UPJANG A               \n");
	        sbSql.append("\n\n");			
		}

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
