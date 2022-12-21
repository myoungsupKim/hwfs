<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매신청/즐겨찾기
■ 프로그램ID   : FSP00080P_T001.jsp
■ 프로그램명   : 구매신청 즐겨찾기 추가
■ 작성일자     : 2016.05.30
■ 작성자       : 최학진
■ 이력관리     : 식재영업의 즐겨찾기 팝업과 동일한 화면 - 테이블 변경
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
		
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
        sbSql.append("SELECT                       \n");
        sbSql.append("	 FAVOR_GROUP AS FAVOR_GROUP \n");
        sbSql.append("	, UPJANG AS UPJANG          \n");
        sbSql.append("	, FAVOR_NAME AS FAVOR_NAME  \n");
        sbSql.append("	, SORT_SEQ AS SORT_SEQ      \n");
        sbSql.append("	, FAVOR_TYPE AS FAVOR_TYPE  \n");
        sbSql.append("	, CONTENTS AS CONTENTS      \n");
        sbSql.append("	, REMARK AS REMARK          \n");
        sbSql.append("	, USE_YN AS USE_YN          \n");
        sbSql.append("	, CUSER AS CUSER            \n");
        sbSql.append("	, CDATE AS CDATE            \n");
        sbSql.append("	, UUSER AS UUSER            \n");
        sbSql.append("	, UDATE AS UDATE            \n");
        sbSql.append(" FROM FSP_FAVORITE_GROUP     \n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'     \n");
        sbSql.append(" AND USE_YN = 'Y'            \n");
        sbSql.append(" ORDER BY SORT_SEQ           \n");
        
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