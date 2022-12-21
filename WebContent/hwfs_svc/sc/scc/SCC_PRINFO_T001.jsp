<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : 
�� ���α׷�ID   : SCC_PRINFO_T002.jsp
�� ���α׷���   : ���°���
�� �ۼ�����     : 2012-08-30
�� �ۼ���       : �ڿ��
�� �̷°���     : 2012-08-30 �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//������Ʈ ��ü
	PlatformRequest platformRequest = this.proc_input(request);

	in_vl = platformRequest.getData().getVariableList();	//�Ķ���� �޴� ��ü
	in_dl = platformRequest.getData().getDataSetList();	//�����ͼ� �޴� ��ü
	
	//�Է� ����Ÿ��
	DataSet ds_list   = in_dl.get("inDs_Cond");

	//�Է� �Ķ����
	String g_EmpNo    = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	//�׽�Ʈ ���
	System.out.println("======================");
	//ds_list.printDataSet();
	System.out.println("======================");
	
	try
	{
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		String checkFlag	= "";

		sbSql.delete(0, sbSql.length());
				
		sbSql.append("\n\n");
		sbSql.append("INSERT INTO HLDC_CS_INFO_PRTC_HIST(   \n");
		sbSql.append("    USERID,                  \n");
		sbSql.append("    USERNAME,                 \n");
		sbSql.append("    SYSTEM,                 \n");
		sbSql.append("    PROGRAMID,                \n");
		sbSql.append("    ACTION,                    \n");
		sbSql.append("    IP,                \n");
		sbSql.append("    GUBUN,                    \n");
		sbSql.append("    CONTENTS,                  \n");
		//sbSql.append("    REMARK,                  \n");
		//sbSql.append("    EXCEL_EXPORT,             \n");
		sbSql.append("    CREATE_BY,                  \n");
		sbSql.append("    CREATE_DATE,                    \n");
		sbSql.append("    UPDATE_BY,                 \n");
		sbSql.append("    UPDATE_DATE                 \n");
		sbSql.append(")VALUES(                    \n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"EMPNO"))+"',\n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"NAME"))+"',\n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"SYSTEMID"))+"',\n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"PGMID"))+"',\n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"ACTION"))+"',\n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"IPADDR"))+"',\n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"GUBUN"))+"',\n");
		sbSql.append("    '"+nullToBlank(ds_list.getString(0,"CONTENTS"))+"',\n");
		//sbSql.append("    '"+nullToBlank(ds_list.getString(0,"COMP_NM"))+"',\n");
		//sbSql.append("    '"+nullToBlank(ds_list.getString(0,"COMP_TEL"))+"',\n");
		sbSql.append("    '"+g_EmpNo+"',                                                          \n");
		sbSql.append("    SYSDATE,              \n");
		sbSql.append("    '"+g_EmpNo+"',                                                          \n");
		sbSql.append("    SYSDATE               \n");
		sbSql.append(")                           \n");
		sbSql.append("\n\n");
			
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.executeUpdate();
		pstmt.close();
		
		/**����**/
		conn.commit();
		out_vl.add("fa_Msg", "");
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>
