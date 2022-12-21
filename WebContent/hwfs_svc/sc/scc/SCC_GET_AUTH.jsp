<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : 
�� ���α׷�ID   : SCC_GET_SUBINV
�� ���α׷���   : â���� ��������
�� �ۼ�����     : 2014-04-22
�� �ۼ���       : �ڿ��
�� �̷°���     : 2014-04-22 �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//������Ʈ ��ü(�����ͼ¸� ����)
	PlatformRequest platformRequest = this.proc_input(request);

	//in_vl = platformRequest.getData().getVariableList();	//�Ķ���� �޴� ��ü
	in_dl = platformRequest.getData().getDataSetList();	//�����ͼ� �޴� ��ü
	
	//�Է� ����Ÿ��
	DataSet ds_list   = in_dl.get("inDs_Cond");

	//�Է� �Ķ����(�Ķ���� ����)
	//String g_EmpNo    = nullToBlank(in_vl.getString("EmpNo"));
	
	//���Ϸα�(���Ϸα� ����)
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	//�׽�Ʈ ���(������ �� ���)
	System.out.println("======================");
	//ds_list.printDataSet();
	System.out.println("======================");
	
	//���� ����
	try
	{
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//��������
		String sabun 		= ds_list.getString(0,"SABUN");
		
		sbSql.append("\n\n");
		sbSql.append("SELECT ROLE \n");
		sbSql.append("  FROM SCC_USER_ROLE V \n");
		sbSql.append(" WHERE V.SABUN = '" + nullToBlank(sabun) + "' \n"); 
		sbSql.append(" AND V.USE_YN = 'Y' \n");
        sbSql.append("\n\n");			

		//���� ����
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set���� ���� �����ͼ� ����
		ds_list = this.makeDataSet(rs, "ds_List");
		
		//��� ������ ����Ʈ�� outDs_List �̸����� ������ �� �߰� 
		out_dl.add(ds_list);
		
		//��� ��������Ʈ�� �޼����� ����
		this.setResultMessage(0, "OK", out_vl);		

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally	//�����ϴ� ��ü�� ��� �ݾ���
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
