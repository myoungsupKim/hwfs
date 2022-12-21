<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMO00800E_T001.jsp
■ 프로그램명   : 파출부 급여내역서
■ 작성일자     : 2012-08-29
■ 작성자       : 박용대
■ 이력관리     : 2012-08-29 최초작성
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
	String workGb 		= ds_cond.getString(0, "WORK_GB");
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
        sbSql.append("SELECT                                                                                                                  \n");
        sbSql.append("    A.SABUN,                                                                                                            \n");
        sbSql.append("    B.MAIN_UPJANG,                                                                                                      \n");
        sbSql.append("    B.UPJANGNM_DISP AS UPJANGNM,                                                                                        \n");
        sbSql.append("    A.UPJANG,                                                                                                           \n");
        sbSql.append("    A.WORK_GB,                                                                                                          \n");
        sbSql.append("    A.REG_GB,                                                                                                           \n");
        sbSql.append("    SCC_CRYPTO.MASKAUTH_FUN(A.JUMINNO_ENC, 1, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS JUMINNO,                       \n");
        sbSql.append("    SCC_CRYPTO.MASKAUTH_FUN(A.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NAME,                              \n");
        sbSql.append("    A.SEX,                                                                                                              \n");
        sbSql.append("    A.ADDR1,                                                                                                            \n");
        sbSql.append("    SCC_CRYPTO.MASKAUTH_FUN(A.ADDR2_ENC, 10, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS ADDR2,                          \n");
        sbSql.append("    A.ADDR_GUBUN,                                                                                                       \n");
        sbSql.append("    A.ZIP,                                                                                                              \n");
        sbSql.append("    SCC_CRYPTO.MASKAUTH_FUN(A.TEL_ENC, 9, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS TEL,                               \n");
	    sbSql.append("    SCC_CRYPTO.MASKAUTH_FUN(A.M_TEL_ENC, 8, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS M_TEL,                           \n");
        sbSql.append("    A.JIK_MU,                                                                                                           \n");
        sbSql.append("    A.PER_DTC,                                                                                                          \n");
        sbSql.append("    A.WORK_TMA,                                                                                                         \n");
        sbSql.append("    A.WORK_TMB,                                                                                                         \n");
        sbSql.append("    A.WORK_TMC,                                                                                                         \n");
        sbSql.append("    A.CONTRACT_GB,                                                                                                      \n");
        sbSql.append("    A.PAY_GB,                                                                                                           \n");
        sbSql.append("    A.WORK_SDT,                                                                                                         \n");
        sbSql.append("    A.WORK_EDT,                                                                                                         \n");
        sbSql.append("    A.BANK_A,                                                                                                           \n");
        sbSql.append("    A.BANK_B,                                                                                                           \n");
        sbSql.append("    A.BANK_C,                                                                                                           \n");
        sbSql.append("    A.NATION,                                                                                                           \n");
        sbSql.append("    A.WORK_YN,                                                                                                          \n");
        sbSql.append("    A.COMP_NM,                                                                                                          \n");
        sbSql.append("    A.COMP_TEL,                                                                                                         \n");
        sbSql.append("    A.REMARK,                                                                                                           \n");
        sbSql.append("    TO_CHAR(A.UDATE,'YYYY-MM-DD HH24:MI')||(SELECT Z.NM_KOR FROM SCC_USERINFO Z WHERE Z.SABUN = A.UUSER) AS UPDATE_INFO,\n");
        sbSql.append("    A.ADDR_KEY,															                                              \n");
	    sbSql.append("    SCC_ADDR_FUN(A.ADDR_KEY, 'YYYYNNNNNNNNNNN', '0') AS ADDR_INFO                                                    \n");
        sbSql.append("FROM FMO_PERSONAL A, FMS_UPJANG B                                                                                       \n");
        sbSql.append("WHERE 1=1                                                                                                               \n");
        sbSql.append("AND A.UPJANG = B.UPJANG(+)                                                                                              \n");
        sbSql.append("AND REG_GB = 'Y'                                                                                                        \n");
	    if(!mainUpjang.equals("")){
    	sbSql.append(" AND MAIN_UPJANG = '"+mainUpjang.toString()+"' \n");}
	    if(!upjang.equals("")){
	    sbSql.append(" AND A.UPJANG = '"+upjang.toString()+"'        \n");}
	    if(!workGb.equals("")){
		    sbSql.append(" AND A.WORK_GB = '"+workGb.toString()+"'   \n");}
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