
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		// �Է� �����ͼ¸���Ʈ
		in_dl = platformRequest.getData().getDataSetList();
		// �Է�  ��������Ʈ
		in_vl = platformRequest.getData().getVariableList();
		
		//�Է� ����Ÿ�� ����
		DataSet ds_input     = in_dl.get("ds_input");
		
		//��� ����Ÿ�� ����
		DataSet ds_list;
	
		String RECIPE_TYPE = ds_input.getString(0,"RECIPE_TYPE");
		String UPJANG = ds_input.getString(0,"UPJANG");
		String HALL_CLASS = ds_input.getString(0,"HALL_CLASS");
		String RECIPE_CD = ds_input.getString(0,"RECIPE_CD");
		
	
		stmt 		=  conn.createStatement();                                  //������ ����
		StringBuffer sbSql = new StringBuffer();										//SQL����  ����

	
		//SQL���� clear
		sbSql.delete(0, sbSql.length());	
	
		//ǥ�ط������ϰ��
		if(RECIPE_TYPE.equals("STD"))
		{
			sbSql.append("   SELECT A.ITEM_SEQ, A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.KG_CONVERT_RATE,     \n    ");
			sbSql.append("          A.NEED_QTY                                                                          \n    ");
			sbSql.append("     FROM FSR_STD_RECIPE_ITEM A, -- KEY : RECIPE_CD, ITEM_CODE                                \n    ");
			sbSql.append("          (SELECT ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, KG_CONVERT_RATE                    \n    ");
			sbSql.append("             FROM HLDC_PO_ITEM_MST                                                            \n    ");
			sbSql.append("            WHERE ITEM_CLASS1 = 'F') C                                                       \n    ");
			sbSql.append("   WHERE A.RECIPE_CD = '"+ RECIPE_CD +"'                                                      \n    ");
			sbSql.append("     AND A.ITEM_CODE = C.ITEM_CODE(+)                                                         \n    ");
			sbSql.append("   ORDER BY A.ITEM_SEQ                                                                        \n    ");
		}
		//���巹�����ϰ��
		else
		{
			sbSql.append("   SELECT A.ITEM_SEQ, A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM, C.KG_CONVERT_RATE,     \n    ");
			sbSql.append("          A.NEED_QTY                                                                          \n    ");
			sbSql.append("     FROM FSR_UPJANG_RECIPE_ITEM  A, -- KEY : RECIPE_CD, ITEM_CODE                            \n    ");
			sbSql.append("          (SELECT ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, KG_CONVERT_RATE                    \n    ");
			sbSql.append("             FROM HLDC_PO_ITEM_MST                                                            \n    ");
			sbSql.append("            WHERE ITEM_CLASS1 = 'F') C                                                       \n    ");
			sbSql.append("   WHERE A.RECIPE_CD  = '"+ RECIPE_CD +"'                                                     \n    ");
			sbSql.append("     AND A.UPJANG     =  "+ UPJANG +"                                                         \n    ");
			sbSql.append("     AND A.HALL_CLASS = '"+ HALL_CLASS +"'                                                    \n    ");
			sbSql.append("     AND A.ITEM_CODE = C.ITEM_CODE(+)                                                         \n    ");
			sbSql.append("   ORDER BY A.ITEM_SEQ                                                                        \n    ");
		}

		//SQL���� print -->���߽ÿ����� ���
	    //System.out.println(sbSql.toString());
		//FileLog.println("d:\\sql.txt", sbSql.toString());
			
	    //SQL ����
	    pstmt = conn.prepareStatement(sbSql.toString());
		
	    //RecordSet�� ������ ���
	    rs = pstmt.executeQuery();
		
		//�����ͼ¸����
		DataSet ds_item_list = this.makeDataSet(rs, "ds_item_list"); //ds_list
	
		//FileLog.println("d:\\ds_list2.txt", ds_list);
		
		/**����**/
		out_dl.add(ds_item_list);
	
		this.setResultMessage(0, RECIPE_TYPE, out_vl);
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally {
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
		if(stmt != null) {
			try {
				stmt.close();
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