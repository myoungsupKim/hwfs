<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMO00700E_T001.jsp
■ 프로그램명   : 근태관리
■ 작성일자     : 2012-08-16
■ 작성자       : 박용대
■ 이력관리     : 2012-08-16 최초작성
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
	String sabun 		= nullToBlank(ds_cond.getString(0, "SABUN"));
	String name 		= nullToBlank(ds_cond.getString(0, "NAME"));
	String mainUpjang	= nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
	String upjang 		= nullToBlank(ds_cond.getString(0, "UPJANG"));
	String regGb 		= nullToBlank(ds_cond.getString(0, "REG_GB"));
	String iDate 		= nullToBlank(ds_cond.getString(0, "IDATE"));
	String option 		= nullToBlank(ds_cond.getString(0, "OPTION"));
	
	//테스트 출력
	System.out.println("======================");
	System.out.println(sabun +"/"+ name +"/"+ iDate);
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
        sbSql.append("SELECT A.SABUN, A.NM_KOR AS NAME, A.WORK_TMA, A.WORK_TMB, A.WORK_TMC, A.UPJANG, B.UPJANGNM_DISP , B.MAIN_UPJANG   \n");
        sbSql.append("FROM FMO_PERSONAL A, FMS_UPJANG B\n");
        sbSql.append("WHERE 1=1                                                     \n");
        sbSql.append("AND A.UPJANG = B.UPJANG(+)                                       \n");
        sbSql.append("AND A.WORK_GB <> '003'\n");
        if(!option.equals("")){
        	sbSql.append("AND A.PAY_GB = '"+option+"'\n");}
	    if(!sabun.equals("")){
	    	sbSql.append("AND SABUN LIKE '%"+sabun.toString()+"%'      \n");}
	    if(!name.equals("")){
	    	sbSql.append("AND NM_KOR LIKE '%"+name.toString()+"%'      \n");}
	    if(!mainUpjang.equals("")){
	    	sbSql.append("AND B.MAIN_UPJANG = '"+mainUpjang.toString()+"'      \n");}
	    if(!upjang.equals("")){
	    	sbSql.append("AND A.UPJANG = '"+upjang.toString()+"'      \n");}
	    if(!regGb.equals("")){
	    	sbSql.append("AND A.REG_GB = '"+regGb.toString()+"'      \n");}
	    if(!iDate.equals("")){
	    	sbSql.append("AND '"+iDate.toString()+"' BETWEEN A.WORK_SDT AND A.WORK_EDT \n");}
	    sbSql.append("\n\n");
	    
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
