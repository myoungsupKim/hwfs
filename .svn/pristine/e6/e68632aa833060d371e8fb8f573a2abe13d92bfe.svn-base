<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMO00700E_T001.jsp
■ 프로그램명   : 근태관리
■ 작성일자     : 2012-08-16
■ 작성자       : 박용대
■ 이력관리     : 2012-08-16 최초작성
				 [고도화]_암복호화 관련 수정_김경은
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
	String mainUpjang 	= ds_cond.getString(0, "MAIN_UPJANG");
	String upjang 		= ds_cond.getString(0, "UPJANG");
	String date 		= ds_cond.getString(0, "DATE");
	String p_MaskAuth       = nullToBlank(in_vl.getString("p_MaskAuth"));
	String g_PersInfoMask   = nullToBlank(in_vl.getString("g_PersInfoMask"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
		sbSql.append("\n\n");
	    sbSql.append("SELECT C.MAIN_UPJANG,                                                                         \n");
	    sbSql.append("       '1' AS CHK,                                                                            \n");
		sbSql.append("       B.UPJANG,                                                                              \n");
		sbSql.append("       C.UPJANGNM_DISP,                                                                       \n");
	    sbSql.append("       A.SABUN,                                                                               \n");
	    sbSql.append("       A.DL_DATE,                                                                             \n");
	    sbSql.append("       SCC_CRYPTO.MASKAUTH_FUN(B.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NAME, \n");
	    sbSql.append("       A.WORK_CONT,                                                                           \n");
	    sbSql.append("       A.WORK_REP,                                                                            \n");
	    sbSql.append("       A.WORK_TMA,                                                                            \n");
	    sbSql.append("       A.WORK_TMB,                                                                            \n");
	    sbSql.append("       A.DAY_PAY                                                                              \n");
	    sbSql.append("  FROM FMO_KUNTAE A, FMO_PERSONAL B,FMS_UPJANG C                                              \n");
	    sbSql.append(" WHERE 1 = 1                                                                                  \n");
	    sbSql.append("       AND A.SABUN = B.SABUN(+)                                                               \n");
	    sbSql.append("       AND B.UPJANG = C.UPJANG(+)                                                             \n");
	    sbSql.append("       AND B.REG_GB = 'Y'                                                                     \n");
	    if(!mainUpjang.equals("")){
    	sbSql.append("       AND C.MAIN_UPJANG = '"+mainUpjang.toString()+"' \n");}
	    if(!upjang.equals("")){
	    sbSql.append("       AND A.UPJANG = '"+upjang.toString()+"'          \n");}
	    if(!date.equals("")){
    	sbSql.append("       AND A.DL_DATE = '"+date.toString()+"'           \n");}
	    sbSql.append(" ORDER BY B.NM_KOR                    \n");
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
