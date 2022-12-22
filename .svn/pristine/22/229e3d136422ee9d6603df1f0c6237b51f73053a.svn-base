<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00760E_T001.jsp
■ 프로그램명   : 직원목록 조회
■ 작성일자     : 2012.08.21
■ 작성자       : 문형광
■ 이력관리     : [고도화]_암복호화 관련 수정_김경은
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//In 데이타
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		//입력 파라메터
		String p_MaskAuth     = nullToBlank(in_vl.getString("p_MaskAuth"));
		String g_PersInfoMask = nullToBlank(in_vl.getString("g_PersInfoMask"));
		
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT A.SABUN, B.UPJANG, B.UPJANGNM_DISP AS UPJANGNM                                                                           \n");
        sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NM_KOR                        \n");
        sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(A.JUMINNO_ENC, 1, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS JUMINNO                   \n");
        sbSql.append("     , A.SEX                                                                                                          \n");
        sbSql.append("     , A.JIK_MU                                                                                                       \n");
        sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.CODE = A.JIK_MU AND Z.GROUP_CODE = 'FM0029') AS JIK_MU_NM   \n");
        sbSql.append("     , A.WORK_GB                                                                                                      \n");
        sbSql.append("     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.CODE = A.WORK_GB AND Z.GROUP_CODE = 'FM0030') AS WORK_GB_NM \n");
        sbSql.append("     , A.PAY_GB                                                                                                       \n");
        sbSql.append("  FROM FMO_PERSONAL A, FMS_UPJANG B                                                                                   \n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                            \n");
        sbSql.append("   AND B.MAIN_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + "'                                     \n");
        sbSql.append("   AND A.REG_GB = 'N'                                                                                                 \n");
        if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
          sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                                             \n");
        if (! nullToBlank(ds_Cond.getString(0, "WORK_GB")).equals(""))
          sbSql.append("   AND A.WORK_GB = '" + nullToBlank(ds_Cond.getString(0, "WORK_GB")) + "'                                           \n");
        if (! nullToBlank(ds_Cond.getString(0, "NM_KOR")).equals(""))
            sbSql.append("   AND A.NM_KOR LIKE '%" + nullToBlank(ds_Cond.getString(0, "NM_KOR")) + "%'                                      \n");
        sbSql.append(" ORDER BY A.SABUN                                                                                                     \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		ds_List = this.makeDataSet(rs,"ds_List");
		
		this.accessReadLog(pageContext, ds_Cond, ds_List.getRowCount());
		
		out_dl.add(ds_List);
		//FileLog.println("c:\\ds_stock.txt",ds_stock);			
	   	this.setResultMessage(0, "OK",out_vl);
	   	
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);	
	    this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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