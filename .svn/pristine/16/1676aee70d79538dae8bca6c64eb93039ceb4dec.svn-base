<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : COMCODE.jsp
■ 프로그램명   : 공통코드조회
■ 작성일자     : 2012-08-17
■ 작성자       : 박용대
■ 이력관리     : 2012-08-17 최초작성 섭버젼 테스트
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);
	
	//파라미터 받는 객체	
	in_vl = platformRequest.getData().getVariableList();	
	
	//파라미터 변수를 가져옴
	String groupCd = in_vl.getString("grupCd");
	
	//테스트 출력
	System.out.println("======================");
	System.out.println(groupCd);
	System.out.println("======================");
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
        sbSql.append("SELECT CODE AS CD, CODE_NAME AS CD_NM FROM SCC_COMMON_CODE   \n");
        sbSql.append("WHERE GROUP_CODE = '"+groupCd+"'              \n");
        sbSql.append("AND SYSTEM_YN = 'Y'      \n");
        
        //출력 파라미터 셋팅
		out_vl.add("fa_Sql", sbSql.toString());
		
		//쿼리문 실행
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set으로 부터 데이터셋 생성
		ds_list = this.makeDataSet(rs, "ds_List");
		
		//출력 데이터 리스트에 데이터 셋 추가 
		out_dl.add(ds_list);
		
		//출력 변수리스트에 메세지를 저장
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
