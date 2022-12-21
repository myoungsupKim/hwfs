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
		
		//�Է� �Ķ����
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
	    //out ����Ÿ
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
	
	/**����**/
	conn.commit();
	//out_vl.add("fa_Chk", "��ϵǾ����ϴ�.");
	this.setResultMessage(0, "OK", out_vl);
	   	
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