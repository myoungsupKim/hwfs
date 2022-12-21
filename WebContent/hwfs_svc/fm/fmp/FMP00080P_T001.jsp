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
        sbSql.append(" FROM FMP_FAVORITE_GROUP     \n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'     \n");
        if ( "D".equals(nullToBlank(ds_Cond.getString(0, "MODE"))) ) {
        	sbSql.append(" AND FAVOR_GROUP IN (SELECT FAVOR_GROUP 				 \n");
        	sbSql.append(" 								FROM FMP_FAVORITE 		  \n");
        	sbSql.append(" 								WHERE UPJANG = "+nullToBlank(ds_Cond.getString(0, "UPJANG"))+" \n");
        	sbSql.append(" 								AND ITEM_CODE = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "' )    \n");
        }
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