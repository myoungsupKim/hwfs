
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;	
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		DataSet dsPoLineStatus  	= in_dl.get("dsPoLineStatus");
		
		String p_NeedMonth 	= nullToBlank(dsPoLineStatus.getString(0, "NEED_MONTH"));	
		String p_BUDDEPT_ID = nullToBlank(dsPoLineStatus.getString(0,"BUDDEPT_ID"));
		String p_ACCTCD 	= nullToBlank(dsPoLineStatus.getString(0,"ACCTCD"));
		String p_BUD_CLS 	= nullToBlank(dsPoLineStatus.getString(0,"BUD_CLS"));
		
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		DataSet ds_out;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("SELECT /*+ INDEX(A PO_PR_I4) */ \n");
		sbSelSql.append("       B.TYPE_NAME, A.PR_DATE \n");
		sbSelSql.append("     , A.PR_NUM, A.ITEM_CODE, A.ITEM_NAME \n");
		sbSelSql.append("     , A.MARGIN_PRICE, A.PR_QTY, ROUND(A.PR_QTY * A.MARGIN_PRICE) PR_AMT \n");
		sbSelSql.append("     , C.NM_KOR \n");
		sbSelSql.append("  FROM PO_PR A, PO_TYPE B, HR_PERSONAL C \n");
		sbSelSql.append(" WHERE A.PO_TYPE = B.PO_TYPE \n");
		sbSelSql.append("   AND A.PR_SABUN = C.SABUN \n");
		sbSelSql.append("   AND A.NEED_DATE BETWEEN '" + p_NeedMonth + "' || '01' AND '" + p_NeedMonth + "' || '31' \n");
		sbSelSql.append("   AND A.BUDDEPT_ID = '" + p_BUDDEPT_ID + "' \n");
		sbSelSql.append("   AND A.ACCTCD = '" + p_ACCTCD + "' \n");
		sbSelSql.append("   AND NVL(A.BUD_CLS,' ') = NVL('" + p_BUD_CLS + "',' ') \n");
		sbSelSql.append("   AND A.LINE_STATUS = '" + dsPoLineStatus.getString(0,"PRApprove") + "' \n");
		
		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());
		
		DataSet ds_list = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_list);
		
		//FileLog.println("c:\\bbb.txt",ds_out);
		
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
			if(stmt != null) {
				try {
					stmt.close();
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