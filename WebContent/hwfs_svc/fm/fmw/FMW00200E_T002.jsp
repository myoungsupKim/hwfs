<%
//*-----------------------------------------------------------------------------
//�� �ý��۸�     : ���ҸŰ���/�Ǹų��� �ϰ�ó��
//�� ���α׷�ID   : FMW00200E_T003.jsp
//�� ���α׷���   : �Ǹų��� �ϰ�ó��(��ǥ����)
//�� �ۼ�����     : 2011.01.20
//�� �ۼ���       : �ͼ���
//�� �̷°���     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		// log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//����Ŀ�� ���� false
		conn.setAutoCommit(false);		

		//�Է� ����Ÿ
		//DataSet ds_input     	= in_dl.get("ds_input");

		String v_TRANS_NUM          = nullToBlank(in_vl.getString("TRANS_NUM"));

		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		 
		//rs.close();
		//pstmt.close();		
		
		//�����ڷ� ����
		//sbSql.delete(0, sbSql.length());
		System.out.println(v_TRANS_NUM + "SSSS");	
 
        sbSql.append("DELETE FROM FMW_PO_TRANSACTION  \n");
        sbSql.append("WHERE TRANS_NUM =  '" + v_TRANS_NUM + "'         \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeQuery();

		pstmt.close();	
		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
		
	}		
	catch(Exception ex)
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp �α׳����
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>
