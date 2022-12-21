<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : 
�� ���α׷�ID   : COMCODE.jsp
�� ���α׷���   : �����ڵ���ȸ
�� �ۼ�����     : 2012-08-17
�� �ۼ���       : �ڿ��
�� �̷°���     : 2012-08-17 �����ۼ� ������ �׽�Ʈ
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	
	//������Ʈ ��ü
	PlatformRequest platformRequest = this.proc_input(request);
	
	//�Ķ���� �޴� ��ü	
	in_vl = platformRequest.getData().getVariableList();	
	
	//�Ķ���� ������ ������
	String groupCd = in_vl.getString("grupCd");
	
	//�׽�Ʈ ���
	System.out.println("======================");
	System.out.println(groupCd);
	System.out.println("======================");
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
		//sql��
        sbSql.append("SELECT CODE AS CD, CODE_NAME AS CD_NM FROM SCC_COMMON_CODE   \n");
        sbSql.append("WHERE GROUP_CODE = '"+groupCd+"'              \n");
        sbSql.append("AND SYSTEM_YN = 'Y'      \n");
        
        //��� �Ķ���� ����
		out_vl.add("fa_Sql", sbSql.toString());
		
		//������ ����
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set���� ���� �����ͼ� ����
		ds_list = this.makeDataSet(rs, "ds_List");
		
		//��� ������ ����Ʈ�� ������ �� �߰� 
		out_dl.add(ds_list);
		
		//��� ��������Ʈ�� �޼����� ����
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
