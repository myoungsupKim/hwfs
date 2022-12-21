<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ֹ�����
�� ���α׷�ID   : FMP00080P_T001.jsp
�� ���α׷���   : ��ǰ���� ���ã�� �߰�
�� �ۼ�����     : 2013.10.14
�� �ۼ���       : �ڿ��
�� �̷°���     : 
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
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//In ����Ÿ
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
	    //out ����Ÿ
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
        sbSql.append("SELECT                       \n");
        sbSql.append("	COUNT(*) COUNT             \n");
        sbSql.append(" FROM FMP_FAVORITE            \n");
        sbSql.append(" WHERE 1=1                    \n");
        sbSql.append(" AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'     \n");
        sbSql.append(" AND FAVOR_GROUP = '" + nullToBlank(ds_Cond.getString(0, "FAVOR_GROUP")) + "'     \n");
        sbSql.append(" AND ITEM_CODE = '" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "'     \n");
        sbSql.append(" AND USE_YN = 'Y'            \n");
        
out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		ds_List = this.makeDataSet(rs,"ds_List");
		
		out_dl.add(ds_List);
		//FileLog.println("c:\\ds_stock.txt",ds_stock);			
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}				
	}
	proc_output(response,out,out_vl,out_dl);
%>