<%
//-----------------------------------------------------------------------------
//�� �ý��۸�     : �ܰ�����/���޾�ü ����/ ���޾�ü ���ֳ��� ����(��ȸ)
//�� ���α׷�ID   : FMP00600E_T001.jsp
//�� ���α׷���   : ���޾�ü ���ֳ��� ����
//�� �ۼ�����     : 2008.02.12
//�� �ۼ���       : ��Կ�
//�� �̷°���     : 2008.02.12
//-----------------------------------------------------------------------------*/
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
	
		//�Է� ����Ÿ
		DataSet ds_cond     = in_dl.get("ds_cond");
		//�Է� �Ķ����
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);


		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));			//����		
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));				//�԰���������
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));				//�԰���������
		String sOtcust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));			//���޾�ü
		String sSubinv = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));		//�Ĵ��ڵ�

// alert���	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
			
		//������ȸ
		
		sbSql.append( " SELECT A.NEED_DATE \n");
		sbSql.append( "      , B.UPJANGNM_DISP \n");
		sbSql.append( "      , C.SUBINV_NAME_DISP \n");
		sbSql.append( "      , A.ITEM_CODE \n");
		sbSql.append( "      , A.PR_ID \n");		
		sbSql.append( "      , A.ITEM_NAME \n");
		sbSql.append( "      , A.ITEM_SIZE \n");
		sbSql.append( "      , A.PO_UOM \n");
		sbSql.append( "      , A.PR_QTY \n");
		sbSql.append( "      , A.PO_QTY \n");
		sbSql.append( "      , A.OTCUSTCD \n");	
		sbSql.append( "      , A.UPJANG \n");	
		sbSql.append( "      , A.SUBINV_CODE \n");			
		sbSql.append( "      , A.NEED_DATE AS SDATE \n");			
		sbSql.append( "      , A.SALE_PRICE \n");
		sbSql.append( "      , A.OP_PRICE \n");
		sbSql.append( "      , A.TAX_CODE \n");		
		sbSql.append( "      , ROUND(NVL(A.PO_QTY,0) * NVL(A.SALE_PRICE,0)) AS SUPPLYAMT \n");
		sbSql.append( "      , ROUND(DECODE(A.TAX_CODE, '100', (NVL(A.PO_QTY,0) * NVL(A.SALE_PRICE,0)) * 0.1, 0)) AS VAT \n");
		sbSql.append( "      , ROUND((NVL(A.PO_QTY,0) * NVL(A.SALE_PRICE,0))) + DECODE(A.TAX_CODE, '100', ROUND((NVL(A.PO_QTY,0) * NVL(A.SALE_PRICE,0)) * 0.1), 0) AS AMT_SUM \n");
		sbSql.append( "      , A.CONTENTS \n");
		sbSql.append( "      , A.ORIGIN_TYPE \n");
		sbSql.append( "      , NVL(A.ADD_FLAG, 'N') AS ADD_FLAG \n");
		sbSql.append( "   FROM (SELECT A.*, B.ORIGIN_TYPE FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B, FMS_SUBINVENTORY C \n");
		sbSql.append( "  WHERE (1=1) \n");
		sbSql.append( "    AND A.UPJANG = B.UPJANG \n");
		sbSql.append( "    AND A.LINE_STATUS NOT IN ('003','005') \n");
		sbSql.append( "    AND A.SUBINV_CODE = C.SUBINV_CODE \n");
		if ( !sUpjang.equals("")){							
			sbSql.append( "    AND A.UPJANG = '" +sUpjang+ "' \n");
		}
		if ( !sSdate.equals("")){							
			sbSql.append( "    AND A.NEED_DATE BETWEEN '"+sSdate+"' AND '"+sEdate+"' \n");
		}
		if ( !sOtcust.equals("")){							
			sbSql.append( "    AND A.OTCUSTCD = '" +sOtcust+ "' \n");
		}
		if ( !sSubinv.equals("")){							
			sbSql.append( "    AND A.SUBINV_CODE = '" +sSubinv+ "' \n");
		}
		sbSql.append( " ORDER BY A.NEED_DATE \n");		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();

		/**����**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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
