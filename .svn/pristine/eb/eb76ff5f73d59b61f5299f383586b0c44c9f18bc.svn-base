<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00080P_T001.jsp
■ 프로그램명   : 상품발주 즐겨찾기 추가
■ 작성일자     : 2013.10.14
■ 작성자       : 박용대
■ 이력관리     : 
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
		
		//입력 파라미터
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
        sbSql.append("INSERT INTO FMP_FAVORITE(   \n");
        sbSql.append("  UPJANG                    \n");
        sbSql.append("  ,FAVOR_GROUP              \n");
        sbSql.append("  ,ITEM_CODE                \n");
        sbSql.append("  ,DEF_QTY                  \n");
        sbSql.append("  ,MON                      \n");
        sbSql.append("  ,TUE                      \n");
        sbSql.append("  ,WED                      \n");
        sbSql.append("  ,THU                      \n");
        sbSql.append("  ,FRI                      \n");
        sbSql.append("  ,SAT                      \n");
        sbSql.append("  ,SUN                      \n");
        sbSql.append("  ,REMARK                   \n");
        sbSql.append("  ,USE_YN                   \n");
        sbSql.append("  ,CUSER                    \n");
        sbSql.append("  ,CDATE                    \n");
        sbSql.append("  ,UUSER                    \n");
        sbSql.append("  ,UDATE                    \n");
        sbSql.append(")VALUES(                    \n");
        sbSql.append("  '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                  \n");
        sbSql.append("  ,'" + nullToBlank(ds_Cond.getString(0, "FAVOR_GROUP")) + "'              \n");
        sbSql.append("  ,'" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'           \n");
        sbSql.append("  ,'0'                      \n");
        sbSql.append("  ,'N'                      \n");
        sbSql.append("  ,'N'                      \n");
        sbSql.append("  ,'N'                      \n");
        sbSql.append("  ,'N'                      \n");
        sbSql.append("  ,'N'                      \n");
        sbSql.append("  ,'N'                      \n");
        sbSql.append("  ,'N'                      \n");
        sbSql.append("  ,''                       \n");
        sbSql.append("  ,'Y'                      \n");
        sbSql.append("  ,'"+ g_EmpNo +"'              \n");
        sbSql.append("  ,SYSDATE                  \n");
        sbSql.append("  ,'"+ g_EmpNo +"'              \n");
        sbSql.append("  ,SYSDATE                  \n");
        sbSql.append(")                           \n");
        
out_vl.add("fa_Sql", sbSql.toString());
	//System.out.println(sbSql.toString());
	pstmt = conn.prepareStatement(sbSql.toString());
	pstmt.executeUpdate();
	pstmt.close();
	
	/**종료**/
	conn.commit();
	//out_vl.add("fa_Chk", "등록되었습니다.");
	this.setResultMessage(0, "OK", out_vl);
	   	
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
//		if(stmt != null) {
//			try {
//				stmt.close();
//			}catch(Exception e) {}
//		}
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