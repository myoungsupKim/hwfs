<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00720E_T001.jsp
■ 프로그램명   : 제세공과금 조회
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
		sbSql.append("SELECT '0' AS CHK                                                                       	     \n");
		sbSql.append("     , C.UPJANG                                                                         	     \n");
		sbSql.append("     , C.UPJANGNM_DISP AS UPJANG_NM                                                     	     \n");
		sbSql.append("     , A.SABUN                                                                          	     \n");
        sbSql.append("     , SCC_CRYPTO.MASKAUTH_FUN(B.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NM_KOR \n");
        sbSql.append("     , A.MED_INS                                                                        	     \n");
        sbSql.append("     , A.NAT_PES                                                                        	     \n");
        sbSql.append("     , A.ACC_INS                                                                        	     \n");
        sbSql.append("     , A.EMP_INS                                                                        	     \n");
        sbSql.append("     , A.MED_INS + A.NAT_PES + A.ACC_INS + A.EMP_INS AS SUM_INS                         	     \n");
        sbSql.append("     , A.OUT_PAY                                                                        	     \n");
        sbSql.append("     , A.ADD_PAY                                                                        	     \n");
        sbSql.append("     , A.OUT_PAY + A.ADD_PAY AS SUM_PAY 											      	     \n");
        sbSql.append("  FROM FMO_CHARGE A, FMO_PERSONAL B, FMS_UPJANG C                                              \n");
        sbSql.append(" WHERE A.SABUN = B.SABUN                                                                	     \n");
        sbSql.append("   AND A.UPJANG = C.UPJANG                                                              	     \n");
        sbSql.append("   AND A.DU_MONTH = '" + nullToBlank(ds_Cond.getString(0, "DATE")) + "'           \n");
        sbSql.append("   AND C.MAIN_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + "' \n");            
        if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
          sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'         \n");
        sbSql.append("   AND B.REG_GB = 'N'         												    \n");
        sbSql.append("   AND B.WORK_GB <> '003'         											    \n");
        sbSql.append("   AND B.PAY_GB = '001' --제세공과는 월급제인 사람만 사용함.                      \n");
        sbSql.append(" ORDER BY C.UPJANG, A.SABUN                                                       \n");       
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		ds_List = this.makeDataSet(rs,"ds_List");
		
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