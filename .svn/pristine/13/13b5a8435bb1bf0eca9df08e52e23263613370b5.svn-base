<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00760E_T001.jsp
■ 프로그램명   : 급여 조회
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
		String vUpjang     = nullToBlank(in_vl.getString("vUpjang"));
		String vSabun      = nullToBlank(in_vl.getString("vSabun"));
		
		//입력 파라메터
	    String p_MaskAuth     = nullToBlank(in_vl.getString("p_MaskAuth"));
		String g_PersInfoMask = nullToBlank(in_vl.getString("g_PersInfoMask"));
		
	    //out 데이타
		DataSet ds_ListDetail;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
        sbSql.append("SELECT                                                                                         \n");
        sbSql.append("       SCC_CRYPTO.MASKAUTH_FUN(P.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NM_KOR \n");
        sbSql.append("     , A.WORK_SDT                                                                              \n");
        sbSql.append("     , A.WORK_EDT                                                                              \n");
        sbSql.append("     , A.PAY_GB                                                                                \n");
        sbSql.append("     , A.PAY_AMT                                                                               \n");
        sbSql.append("     , A.REG_PAY                                                                               \n");
        sbSql.append("     , A.REMARK                                                                                \n");
        sbSql.append("     , A.SABUN                                                                                 \n");
        sbSql.append("  FROM FMO_PAY A, FMO_PERSONAL P                                                               \n");
        sbSql.append(" WHERE 1=1                                                                                     \n");
        sbSql.append("   AND A.SABUN = P.SABUN                                                                       \n");
        sbSql.append("   AND A.UPJANG = '" + nullToBlank(vUpjang) + "'                                               \n");
        sbSql.append("   AND A.SABUN = '" + nullToBlank(vSabun) + "'                                                 \n");
        sbSql.append(" ORDER BY A.WORK_SDT                                                                           \n");        
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		ds_ListDetail = this.makeDataSet(rs,"ds_ListDetail");
		
		out_dl.add(ds_ListDetail);
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