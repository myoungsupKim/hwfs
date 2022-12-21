<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ֹ�����
�� ���α׷�ID   : FMP00360R_T001.jsp
�� ���α׷���   : �ŷ����� �����ϰ����
�� �ۼ�����     : 2012-12-05
�� �ۼ���       : ������
�� �̷°���     : 2012-12-05 ������ - ���ʰ��� ()
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	CallableStatement cstmt = null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
	
		//�Է� ����Ÿ
		//DataSet ds_Cond   = in_dl.get("ds_Cond");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//�Է� �Ķ����
		String sDate        = nullToBlank(in_vl.getString("sDate"));

		//sql�� ���ۻ���
		//StringBuffer sbSql = new StringBuffer();

		//����
		cstmt = conn.prepareCall( "{call FMS_CRTCRDINFO_PRO(?, ?, ?, ?)}" );		
		
		cstmt.setString(1,sDate);
		cstmt.registerOutParameter(2, Types.VARCHAR);
		cstmt.registerOutParameter(3, Types.INTEGER);
		cstmt.registerOutParameter(4, Types.VARCHAR);

		cstmt.execute();
		//System.out.println(cstmt.getString(5));
		
		if(cstmt.getString(2).equals("FALSE"))	
		{
			conn.rollback();
			this.setResultMessage(cstmt.getInt(3), cstmt.getString(4), out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}

		/**����**/
		conn.commit();
		//this.setResultMessage(0, "OK", out_vl);
		this.setResultMessage(0, cstmt.getString(2), out_vl);
		cstmt.close();

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
		if(cstmt != null) {
			try {
				cstmt.close();
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