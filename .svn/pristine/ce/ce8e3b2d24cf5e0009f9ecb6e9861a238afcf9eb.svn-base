<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00790E_T001.jsp
■ 프로그램명   : 직원관리
■ 작성일자     : 2012-08-21
■ 작성자       : 문형광
■ 이력관리     : [고도화]_암복호화 관련 수정_김경은
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_Cond    = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang       = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo        = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_ViewNm       = nullToBlank(ds_Cond.getString(0, "VIEW_NM"));
		String p_MaskAuth     = nullToBlank(in_vl.getString("p_MaskAuth"));
		String g_PersInfoMask = nullToBlank(in_vl.getString("g_PersInfoMask"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		sbSql.append("SELECT A.SABUN                                                                                                             \n");
		sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') NM_KOR                                \n");                                                
	    sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.JUMINNO_ENC, 1, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') JUMINNO                           \n");
	    sbSql.append("     , SUBSTR(SC_CRYPTO_FUN('DEC', A.JUMINNO_ENC , '1'),0,6) BIRTH                                                         \n");
	    sbSql.append("     , A.ZIP                                                                                                               \n");
	    sbSql.append("     , A.ADDR1                                                                                                             \n");
	    sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.ADDR2_ENC, 10, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') ADDR2                              \n");
	    sbSql.append("     , A.ADDR_GUBUN                                                                                                        \n");
	    sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.TEL_ENC, 9, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') TEL                                   \n");
	    sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.M_TEL_ENC, 8, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') M_TEL                               \n");
		sbSql.append("     , A.SEX                                                                                                               \n");
		sbSql.append("     , A.JIK_MU                                                                                                            \n");
		sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.CODE = A.JIK_MU AND Z.GROUP_CODE = 'FM0029') JIK_MU_NM           \n");
		sbSql.append("     , A.WORK_TMA                                                                                                          \n");
		sbSql.append("     , A.WORK_TMB                                                                                                          \n");
		sbSql.append("     , A.WORK_TMC                                                                                                          \n");
		sbSql.append("     , A.CONTRACT_GB                                                                                                       \n");
		sbSql.append("     , A.PER_DTC                                                                                                           \n");
		sbSql.append("     , A.WORK_SDT                                                                                                          \n");
		sbSql.append("     , A.WORK_EDT                                                                                                          \n");
		sbSql.append("     , A.BANK_A                                                                                                            \n");
		sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.BANK_B, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') BANK_B                                \n");
		sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.BANK_C_ENC, 6, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') BANK_C                             \n");
		sbSql.append("     , A.WORK_GB                                                                                                           \n");
		sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.CODE = A.WORK_GB AND Z.GROUP_CODE = 'FM0030') AS WORK_GB_NM      \n");
		sbSql.append("     , A.PAY_GB                                                                                                            \n");
		sbSql.append("     , TO_CHAR(A.UDATE,'YYYY-MM-DD HH24:MI')||(SELECT Z.NM_KOR FROM SCC_USERINFO Z WHERE Z.SABUN = A.UUSER) AS UPDATE_INFO \n");
		sbSql.append("     , A.REMARK                                                                                                            \n");
		sbSql.append("     , B.UPJANG                                                                                                            \n");  
	    sbSql.append("     , B.UPJANGNM_DISP AS UPJANGNM                                                                                         \n");
	    sbSql.append("     , A.ADDR_KEY															                                                 \n");
	    sbSql.append("     , SCC_ADDR_FUN(A.ADDR_KEY, 'YYYYNNNNNNNNNNN', '0') AS ADDR_INFO                                                       \n");
		sbSql.append("  FROM FMO_PERSONAL A, FMS_UPJANG B                                                                                        \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                 \n");
		sbSql.append("   AND A.REG_GB = 'N'                                                                                                      \n");
		sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + "                                            \n");
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))                                                                            
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "                                                  \n");
		if (! nullToBlank(ds_Cond.getString(0, "WORK_GB")).equals(""))                                                                           
			sbSql.append("   AND A.WORK_GB = '" + nullToBlank(ds_Cond.getString(0, "WORK_GB")) + "'                                              \n");
		if (! nullToBlank(ds_Cond.getString(0, "NM_KOR")).equals(""))                                                                            
			sbSql.append("   AND A.NM_KOR LIKE '%" + nullToBlank(ds_Cond.getString(0, "NM_KOR")) + "%'                                           \n");
		sbSql.append(" ORDER BY A.WORK_GB, A.SABUN                                                                                               \n");
		
        out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		this.accessReadLog(pageContext, ds_Cond, ds_List.getRowCount());
		
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>