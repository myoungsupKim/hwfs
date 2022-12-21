<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ܰ�����/���޾�ü����
�� ���α׷�ID   : FMU00400E_T003.jsp
�� ���α׷���   : ��� �������۽ð� ��ȸ
�� �ۼ�����     : 2015.11.11
�� �ۼ���       : �ڿ��
�� �̷°���     : 
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
	DataSet ds_cond   	= in_dl.get("inDs_Cond");
	
	//�Է� ����Ÿ�� �� ����
	String upjang 		= nullToBlank(ds_cond.getString(0, "UPJANG"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
		//sql��
		sbSql.append("\n\n");
        sbSql.append("SELECT DISTINCT SDATE ,                                                  \n");
        sbSql.append("       TO_CHAR(TO_DATE(SDATE, 'YYYYMMDD'), 'YYYY\"��\"MM\"��\"DD\"��') AS SDATE_D  \n");
        sbSql.append("  FROM FMU_OP_RATE                                                       \n");
        sbSql.append(" WHERE UPJANG = '"+upjang+"'                                             \n");
        sbSql.append("   AND SDATE <> '00000000'                                               \n");
        sbSql.append(" ORDER BY SDATE DESC                                                     \n");
	    sbSql.append("\n\n");
        
	    //�׽�Ʈ
	    System.out.println(sbSql.toString());
	    
        //��� �Ķ���� ����
		out_vl.add("fa_Sql", sbSql.toString());
		
		//������ ����
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set���� ���� �����ͼ� ����
		ds_list = this.makeDataSet(rs, "ds_List");
		
		this.accessReadLog(pageContext, ds_cond, ds_list.getRowCount());
		
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