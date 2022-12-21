<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/��������
�� ���α׷�ID   : FMS00200E_T002.jsp
�� ���α׷���   : D-day������ ����
�� �ۼ�����     : 2008.03.04
�� �ۼ���       : ������
�� �̷°���     : 2008.03.04
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//����Ŀ�� ���� false
		conn.setAutoCommit(false);

		//�Է� ����Ÿ
		DataSet ds_item      = in_dl.get("ds_item");
		DataSet ds_List      = in_dl.get("ds_List");
		DataSet ds_ListUpj   = in_dl.get("ds_ListUpj");
		//FileLog.println("d:\\aaa.txt", ds_list);
	
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));


		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//��������� ���...
		if (ds_ListUpj.getRowCount() == 0 )
		{
			//�����ڷ� ����
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("DELETE FROM FMP_ORDER_SCHL_LIMI_MGMT \n");
			sbSql.append(" WHERE UPJANG = -1 \n");
			sbSql.append("   AND LIMI_DD BETWEEN SUBSTR('" + nullToBlank(ds_List.getString(0, "LIMI_DD")) + "',1,6)||'01' \n");
			sbSql.append("                     AND TO_CHAR(LAST_DAY(TO_DATE(SUBSTR('" + nullToBlank(ds_List.getString(0, "LIMI_DD")) + "',1,6)||'01','YYYYMMDD')), 'YYYYMMDD') \n");
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();

			//�Է�
			for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
			{
				sbSql.delete(0, sbSql.length());

                sbSql.append("INSERT INTO FMP_ORDER_SCHL_LIMI_MGMT( \n");
                sbSql.append("       UPJANG \n");
                sbSql.append("     , OTCUSTCD \n");
                sbSql.append("     , ITEM_CODE \n");
                sbSql.append("     , WEEKDAY \n");
                sbSql.append("     , LIMI_DD \n");
                sbSql.append("     , REMARK \n");
                sbSql.append("     , USE_YN \n");
                sbSql.append("     , CUSER \n");
                sbSql.append("     , CDATE \n");
                sbSql.append("     , UUSER \n");
                sbSql.append("     , UDATE \n");
                sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  -1 \n");
				sbSql.append("	, '" + "-1" + "' \n");
				sbSql.append("	, '" + "-1" + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_List.getString(i, "WEEK")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_List.getString(i, "LIMI_DD")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_List.getString(i, "REMARK")) + "' \n");
				sbSql.append("	, SCC_YN_FUN('" + nullToBlank(ds_List.getString(i, "USE_YN")) + "','I') \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");

out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
			//conn.commit();
			//����Ŭ Ŀ���ʰ� ��������....�ݾ��ش�.
			//pstmt.close();
			//pstmt = null;
		}

		//���庰 ���
		String sChk;
		//���庰 �����ڷ� ����
		String Sql = "DELETE FROM FMP_ORDER_SCHL_LIMI_MGMT WHERE UPJANG = ?" +
		             " AND LIMI_DD BETWEEN SUBSTR(?,1,6)||'01' AND TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(?,1,6)||'01', 'YYYYMMDD')), 'YYYYMMDD') ";
		//��ġ�Լ�����
		pstmt = conn.prepareStatement(Sql.toString());
		
		for ( int iRow = 0 ; iRow < ds_ListUpj.getRowCount() ; iRow++ )
		{
			sChk = nullToBlank(ds_ListUpj.getString(iRow, "CHK"));
			
			if (sChk.equals("0")) continue;
			pstmt.setString(1, nullToBlank(ds_ListUpj.getString(iRow, "UPJANG")));
			pstmt.setString(2, nullToBlank(ds_List.getString(0, "LIMI_DD")));
			pstmt.setString(3, nullToBlank(ds_List.getString(0, "LIMI_DD")));
			//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
			pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
		}

		pstmt.executeBatch(); //��ġó��
		pstmt.close();

		//���庰 ���
		Sql = "INSERT INTO FMP_ORDER_SCHL_LIMI_MGMT(UPJANG, OTCUSTCD, ITEM_CODE, WEEKDAY, LIMI_DD, REMARK, USE_YN, CUSER, CDATE, UUSER, UDATE)" +
                "VALUES (?,?,?,?,?,?,SCC_YN_FUN(?,'I'),?,SYSDATE,?,SYSDATE) ";
		     

		//��ġ�Լ�����      
		pstmt = conn.prepareStatement(Sql.toString());
		
		for ( int iRow = 0 ; iRow < ds_ListUpj.getRowCount() ; iRow++ )
		{
			//sChk = nullToBlank(ds_ListUpj.getString(iRow, "CHK"));
			sChk = ds_ListUpj.getString(iRow, "CHK");
			if (sChk.equals("0")) continue;

			for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
			{
				if(ds_item.getRowCount() != 0)
				{
					for ( int j = 0 ; j < ds_item.getRowCount() ; j++ )
					{
						if (nullToBlank(ds_List.getString(i, "USE_YN")).equals("0")) continue;
						//�Է� 
						pstmt.setString(1, nullToBlank(ds_ListUpj.getString(iRow, "UPJANG")));
						pstmt.setString(2, nullToBlank(ds_item.getString(j, "OTCUSTCD")));
						pstmt.setString(3, nullToBlank(ds_item.getString(j, "ITEM_CODE")));
						pstmt.setString(4, nullToBlank(ds_List.getString(i, "WEEK")));
						pstmt.setString(5, nullToBlank(ds_List.getString(i, "LIMI_DD")));
						pstmt.setString(6, nullToBlank(ds_List.getString(i, "REMARK")));
						pstmt.setString(7, nullToBlank(ds_List.getString(i, "USE_YN")));
						pstmt.setString(8, g_EmpNo);
						pstmt.setString(9, g_EmpNo);
						//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
						pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
					}
				}else
				{
					if (nullToBlank(ds_List.getString(i, "USE_YN")).equals("0")) continue;
					//�Է� 
					pstmt.setString(1, nullToBlank(ds_ListUpj.getString(iRow, "UPJANG")));
					pstmt.setString(2, "-1");
					pstmt.setString(3, "-1");
					pstmt.setString(4, nullToBlank(ds_List.getString(i, "WEEK")));
					pstmt.setString(5, nullToBlank(ds_List.getString(i, "LIMI_DD")));
					pstmt.setString(6, nullToBlank(ds_List.getString(i, "REMARK")));
					pstmt.setString(7, nullToBlank(ds_List.getString(i, "USE_YN")));
					pstmt.setString(8, g_EmpNo);
					pstmt.setString(9, g_EmpNo);
					//���ʷ� sql���� ? ��ġ�� �°� ������ �����ϼ���.
					pstmt.addBatch(); //���������� ������ ���� ��ġ�߰�
				}
			}
		}
		
		pstmt.executeBatch(); //��ġó��
		pstmt.close();

		/**����**/
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