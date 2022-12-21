<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : 
�� ���α׷�ID   : SCC_GET_SUBINV
�� ���α׷���   : â���� ��������
�� �ۼ�����     : 2013-08-05
�� �ۼ���       : �ڿ��
�� �̷°���     : 2013-08-05 �����ۼ�
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

		//
		String Upjang 		= ds_list.getString(0,"UPJANG");
		
		sbSql.append("\n\n");
        sbSql.append(" SELECT A.SUBINV_CODE, A.SUBINV_NAME                                               \n");
        sbSql.append("     , A.SUBINV_NAME AS SUBINV_NAME_DISP, B.SUBINV_NAME_DISP2                      \n");
        sbSql.append("     , B.STOCK_YN, B.CONSUM_YN, B.TAX_CODE, B.SUBINV_CLASS                         \n");
        sbSql.append("     , A.ACCPT_ZIP_CD, A.ACCPT_ADDR, A.ACCPT_NM, A.ACCPT_PH, A.ACCPT_HP, A.ACCPT_INFO \n");
        sbSql.append("  FROM HLDC_PO_SUBINVENTORY A, FMS_SUBINVENTORY B                                  \n");
        sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE                                               \n");
        sbSql.append("   AND A.SUBINV_CODE LIKE 'S1%'                                                    \n");
        sbSql.append("   AND A.UPJANG = '"+Upjang+"'                                                     \n");
        sbSql.append("   AND A.USE_YN = 'Y' AND B.USE_YN = 'Y'                                           \n");
        sbSql.append(" ORDER BY A.SUBINV_CODE                                                            \n");
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
