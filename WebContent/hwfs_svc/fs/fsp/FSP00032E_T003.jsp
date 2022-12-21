
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		String p_PoType 		= in_vl.getString("p_PoType");	
		String p_PRCancel 		= in_vl.getString("p_PRCancel");
		String p_PRApprove 		= in_vl.getString("p_PRApprove");
		String p_SubinvCode 	= in_vl.getString("p_SubinvCode");
		String p_NeedDate 		= in_vl.getString("p_NeedDate");			
	
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		// ����â��, �����԰��Ͽ� �̹� ��û�� ������ �ִ� �� Ȯ��
		sbSelSql.append("SELECT 'Y' \n");
		sbSelSql.append("  FROM PO_PR \n");
		sbSelSql.append(" WHERE SUBINV_CODE = '" + p_SubinvCode + "' \n");
		sbSelSql.append("   AND NEED_DATE = '" + p_NeedDate + "' \n");
		sbSelSql.append("   AND PO_TYPE = '" + p_PoType + "' \n");
		sbSelSql.append("   AND LINE_STATUS >= '" + p_PRApprove + "' \n");
		sbSelSql.append("   AND ROWNUM = 1 \n");
		
		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());		
		
		String strPrYN;
		
		if(rs.next())
			strPrYN = rs.getString(0);
		else
			strPrYN = "N";
		
		rs.close();
		stmt.close();
		
		out_vl.add("v_PrYN", strPrYN);
		
		sbSelSql.delete(0, sbSelSql.length());
		
		// ����â��, �����԰��Ϸ� ��û���� �ۼ��Ǿ��ٰ� ��ҵ� ���� �ִ��� Ȯ��
		sbSelSql.append("SELECT 'Y' \n");
		sbSelSql.append("  FROM PO_PR \n");
		sbSelSql.append(" WHERE SUBINV_CODE = '" + p_SubinvCode + "' \n");
		sbSelSql.append("   AND NEED_DATE = '" + p_NeedDate + "' \n");
		sbSelSql.append("   AND PO_TYPE = '" + p_PoType + "' \n");
		sbSelSql.append("   AND LINE_STATUS = '" + p_PRCancel + "' \n");
		sbSelSql.append("   AND ROWNUM = 1 \n");

		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());		
		
		String strPrCancelYN;
		
		if(rs.next())
			strPrCancelYN = rs.getString(0);
		else
			strPrCancelYN = "N";
		
		out_vl.add("v_PrCancelYN", strPrCancelYN);
		
	   	this.setResultMessage(0, "OK",out_vl);
	   	
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp �α׳����
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
			//jsp log ���� �ݱ� 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}				
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	