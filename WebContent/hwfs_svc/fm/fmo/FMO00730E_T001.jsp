<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMO00730E_T001.jsp
■ 프로그램명   : 근태내역서 조회
■ 작성일자     : 2012-08-28
■ 작성자       : 박용대
■ 이력관리     : 2012-08-28 최초작성
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
	String fromDate		= ds_cond.getString(0, "FROM_DT");
	String toDate 		= ds_cond.getString(0, "TO_DT");
	String name 		= ds_cond.getString(0, "NAME");
	
	//입력 파라메터
	String p_MaskAuth     = nullToBlank(in_vl.getString("p_MaskAuth"));
	String g_PersInfoMask = nullToBlank(in_vl.getString("g_PersInfoMask"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
		sbSql.append("\n\n");
        sbSql.append("SELECT K.DL_DATE                                                                                                          \n");
        sbSql.append("     , K.SABUN                                                                                                            \n");
        sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(PE.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NAME                             \n");
        sbSql.append("     , P.PAY_GB                                                                                                           \n");
        sbSql.append("     , K.DL_GB                                                                                                            \n");
        sbSql.append("     , K.WORK_TMA                                                                                                         \n");
        sbSql.append("     , K.WORK_TMB                                                                                                         \n");
        sbSql.append("     , K.WORK_TMC                                                                                                         \n");
        sbSql.append("     , K.OTHH                                                                                                             \n");
        sbSql.append("     , K.NIGHT_OTHH                                                                                                       \n");
        sbSql.append("     , K.HOLI                                                                                                             \n");
        sbSql.append("     , K.OTHH+K.NIGHT_OTHH+K.HOLI AS TOTAL_OT                                                                             \n");
        sbSql.append("     , P.PAY_AMT                                                                                                          \n");
        sbSql.append("     , ROUND(DECODE(P.PAY_GB,'002',PAY_AMT,'001',DECODE(K.WORK_TMC, 0, 0, PAY_AMT/30/K.WORK_TMC))) AS PAY_SI /*급여를 기준에 따라 시급으로 바꿈*/      \n");
        sbSql.append("     , ROUND(DECODE(P.PAY_GB, '002', P.PAY_AMT, '001', DECODE(K.WORK_TMC, 0, 0, P.PAY_AMT/30/K.WORK_TMC)) * (OTHH+NIGHT_OTHH+HOLI) * 1.5) AS OT_PAY \n");
        sbSql.append("     , DECODE(P.PAY_GB,'002', P.PAY_AMT*K.WORK_TMC, '001', P.PAY_AMT) AS PAY_DAY/*급여기준에 따른 일자별 급여*/           \n");
        sbSql.append("     , U.UPJANG                                                                                                           \n");
        sbSql.append("     , U.MAIN_UPJANG                                                                                                      \n");
        sbSql.append(" FROM FMO_KUNTAE K, FMO_PAY P, FMO_PERSONAL PE, FMS_UPJANG U                                                              \n");
        sbSql.append("WHERE 1=1                                                                                                                 \n");
        sbSql.append("  AND P.SABUN = K.SABUN                                                                                                   \n");
        sbSql.append("  AND K.SABUN = PE.SABUN                                                                                                  \n");
        sbSql.append("  AND PE.UPJANG = U.UPJANG                                                                                                \n");
        sbSql.append("  AND K.DL_DATE BETWEEN P.WORK_SDT AND P.WORK_EDT                                                                         \n");	    
        if(!mainUpjang.equals("")){
	    	sbSql.append("  AND U.MAIN_UPJANG = '"+mainUpjang.toString()+"'                                   \n");}
	    if(!upjang.equals("")){
	    	sbSql.append("  AND U.UPJANG = '"+upjang.toString()+"'                                            \n");}
	    if(!fromDate.equals("") && !toDate.equals("")){
	    	sbSql.append("  AND K.DL_DATE BETWEEN '"+fromDate.toString()+"' AND " + "'"+toDate.toString()+"'  \n");}
	    if(!name.equals("")){
	    	sbSql.append("  AND PE.NM_KOR LIKE '%" + name.toString() +"%'                                     \n");}
	    sbSql.append("ORDER BY K.DL_DATE, P.SABUN                                                             \n");
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
