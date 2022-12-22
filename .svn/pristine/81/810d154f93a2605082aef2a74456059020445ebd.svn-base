<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/상품별 거래실적 조회
//■ 프로그램ID   : FMP01030V_T001.jsp
//■ 프로그램명   : 제출단가 상품별 거래실적 조회
//■ 작성일자     : 2008.01.31
//■ 작성자       : 노규완
//■ 이력관리     : 2008.01.31
//-----------------------------------------------------------------------------*/
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
		DataSet ds_Comment     = in_dl.get("ds_Comment");
	
		//out 데이타
		DataSet ds_list;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		String sItemCode = nullToBlank(ds_Comment.getString(0, "ITEM_CODE"));		
		
		sbSql.append("	SELECT A.ITEM_SEQ,																					   \n");
		sbSql.append("		   A.ITEM_CODE,																					   \n");
		sbSql.append("		   A.SABUN,																						   \n");
		sbSql.append("		   (SELECT Z.NM_KOR FROM SCC_USERINFO Z WHERE Z.SABUN = A.SABUN) AS NAME,	    				   \n");
		sbSql.append("		   A.ADD_INFO,																					   \n");
		sbSql.append("		   A.CUSER,																						   \n");
		sbSql.append("		   TO_CHAR(A.UDATE,'YYYY-MM-DD HH24:MI:SS') AS UDATE,											   \n");
		sbSql.append("		   A.UUSER,																						   \n");
		sbSql.append("		   A.CDATE                                       												   \n");
		sbSql.append("    FROM FMP_ITEM_ADD_INFO A                                                                             \n"); 
		sbSql.append("   WHERE ITEM_CODE      = '" + sItemCode + "'                                                            \n");
	    sbSql.append("   ORDER BY CDATE DESC 																				   \n");
	    
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_CommentList");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
