<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00400E_T003.jsp
■ 프로그램명   : 운영율 이전시작시간 조회
■ 작성일자     : 2015.11.11
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
	DataSet ds_cond   	= in_dl.get("inDs_Cond");
	
	//입력 데이타셋 값 설정
	String upjang 		= nullToBlank(ds_cond.getString(0, "UPJANG"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
		sbSql.append("\n\n");
        sbSql.append("SELECT DISTINCT SDATE ,                                                  \n");
        sbSql.append("       TO_CHAR(TO_DATE(SDATE, 'YYYYMMDD'), 'YYYY\"년\"MM\"월\"DD\"일') AS SDATE_D  \n");
        sbSql.append("  FROM FMU_OP_RATE                                                       \n");
        sbSql.append(" WHERE UPJANG = '"+upjang+"'                                             \n");
        sbSql.append("   AND SDATE <> '00000000'                                               \n");
        sbSql.append(" ORDER BY SDATE DESC                                                     \n");
	    sbSql.append("\n\n");
        
	    //테스트
	    System.out.println(sbSql.toString());
	    
        //출력 파라미터 셋팅
		out_vl.add("fa_Sql", sbSql.toString());
		
		//쿼리문 실행
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set으로 부터 데이터셋 생성
		ds_list = this.makeDataSet(rs, "ds_List");
		
		this.accessReadLog(pageContext, ds_cond, ds_list.getRowCount());
		
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