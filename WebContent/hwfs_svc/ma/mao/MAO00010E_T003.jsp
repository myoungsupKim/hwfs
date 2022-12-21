<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�������
�� ���α׷�ID   : MAO00010E_T003.jsp
�� ���α׷���   : �������� ����Ÿ ��������
�� �ۼ�����     : 2012-03-09
�� �ۼ���       : ������
�� �̷°���     : 2012-03-09 ������ - ���ʰ��� (CH201203_00081)
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
		//DataSet ds_List   = in_dl.get("ds_List");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String fDate        = nullToBlank(in_vl.getString("fDate"));
		String tDate        = nullToBlank(in_vl.getString("tDate"));

		//sql�� ���ۻ���
		//StringBuffer sbSql = new StringBuffer();

		//����
		cstmt = conn.prepareCall( "{call FMB_SETSALEDATA_PRO(?, ?, ?, ?, ?, ?, ?)}" );		
		
		cstmt.setString(1,fDate);
		cstmt.setString(2,tDate);
	    cstmt.setString(3,"");
	    cstmt.setString(4,g_EmpNo);
		cstmt.registerOutParameter(5, Types.VARCHAR);
		cstmt.registerOutParameter(6, Types.INTEGER);
		cstmt.registerOutParameter(7, Types.VARCHAR);

		cstmt.execute();
		//System.out.println(cstmt.getString(5));
		
		if(cstmt.getString(5).equals("FALSE"))	
		{
			conn.rollback();
			this.setResultMessage(-1, cstmt.getString(7), out_vl);
			//throw new Exception();
			proc_output(response,out,out_vl,out_dl);
			return;			
		}

		/**����**/
		conn.commit();
		//this.setResultMessage(0, "OK", out_vl);
		this.setResultMessage(0, cstmt.getString(6), out_vl);
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