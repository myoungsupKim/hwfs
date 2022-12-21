<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMM00210E_T001.jsp
■ 프로그램명   : 레시피등록시 최근 식수 가져오는 트랜잭션
■ 작성일자     : 2012-11-30
■ 작성자       : 박용대
■ 이력관리     : 2012-11-30 최초작성
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
	String upjang 		= ds_cond.getString(0, "UPJANG");
	String subinvCode	= ds_cond.getString(0, "SUBINV_CODE");
	String meal 		= ds_cond.getString(0, "MEAL");
	String corner 		= ds_cond.getString(0, "CORNER");
	String menuDate		= ds_cond.getString(0, "MENU_DATE");
	
	//테스트 출력
	System.out.println("======================");
	System.out.println(upjang +"/"+ subinvCode +"/"+ meal +"/"+ corner);
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
        sbSql.append("SELECT *                                         \n");
        sbSql.append("  FROM (SELECT ROW_NUMBER() OVER(                \n");
        sbSql.append("                 ORDER BY MENU_DATE DESC) RNK,   \n");
        sbSql.append("               A.*                               \n");
        sbSql.append("          FROM FMM_MENU A                        \n");
        sbSql.append("         WHERE 1=1                               \n");
        sbSql.append("           AND UPJANG = '"+upjang.toString()+"'                 \n");
        sbSql.append("           AND SUBINV_CODE = '"+subinvCode.toString()+"'          \n");
        sbSql.append("           AND MEAL = '"+meal.toString()+"'                      \n");
        sbSql.append("           AND CORNER = '"+corner.toString()+"'                    \n");
        sbSql.append("           AND MENU_DATE <= '"+menuDate.toString()+"' \n");
        sbSql.append("           AND NVL(EXPECT_MEAL_QTY,0) <> 0) \n");
        sbSql.append(" WHERE RNK = '1'                                \n");
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