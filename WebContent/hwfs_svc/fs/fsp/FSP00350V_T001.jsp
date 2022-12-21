<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : �޴�����/���Ű���/�԰����
�� ���α׷�ID   : FSP00350V_T001.jsp
�� ���α׷���   : ������� �����ȸ
�� �ۼ�����     : 2011-04-11
�� �ۼ���       : ������
�� �̷°���     : 2011-04-11 - �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//�Է� ����Ÿ
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sChk_        = nullToBlank(in_vl.getString("sChk_"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

/* 		//IRIS�� ����
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn(); */

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
		//��ȸ
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.NEED_DATE AS NEED_DATE                                                                                                                   \n");
        sbSql.append("     , (SELECT NVL(Z.SUBINV_NAME,'�μ��԰�') FROM PO_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE) AS SUBINV_NAME                                    \n");
        sbSql.append("     , NVL(TO_CHAR(B.MRO_PO_NO), A.ORDER_NUM) AS ORDER_NUM                                                                                                \n");
        sbSql.append("     , NVL(B.STATE, C.CODE_NAME) AS LINE_STATUS                                                                                                           \n");
        sbSql.append("     , DECODE(D.MRO_FLAG, 'Y', 'MRO�����ȸ', DECODE(NVL(TO_CHAR(A.DELI_TIME), 'N'), 'N', '������', TO_CHAR(A.DELI_TIME, 'YYYYMMDD HH:MM:SS'))) AS DELI_TIME \n");
        sbSql.append("     , NVL(A.DELI_COMP, '') AS DELI_COMP                                                                                                                  \n");
        sbSql.append("     , NVL(A.INVOICE_NUM, '') AS INVOICE_NUM                                                                                                              \n");
        sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.PO_UOM                                                                                                                 \n");
        sbSql.append("     , A.PO_QTY                                                                                                                                           \n");
        sbSql.append("     , NVL(B.SP_NAME, D.CUSTNM) AS SP_NAME                                                                                                                \n");
        sbSql.append("     , NVL(B.SP_MANAGER_NAME, D.C_PER_NAME) AS SP_MANAGER_NAME                                                                                            \n");
        //sbSql.append("     , NVL(B.SP_TEL, D.C_PER_TELNO) AS SP_TEL                                                                                                             \n");
        // ����� ��ȣȭ �ݿ�
        sbSql.append("     , NVL(B.SP_TEL, SC_CRYPTO_FUN('DEC',C_PER_TELNO_ENC ,4)) AS SP_TEL                                                                                                             \n");
        sbSql.append("     , A.PO_ID				                                                                                                             				\n");
        sbSql.append("  FROM PO_PO A, MRO_V_MRO_PO_ODT_HLDC B, PO_LINE_STATUS_V C, ST_CUST D                                                                                    \n");
        sbSql.append(" WHERE A.PO_ID = TO_NUMBER(B.PO_SEQ(+))                                                                                                                   \n");
        sbSql.append("   AND A.LINE_STATUS = C.CODE                                                                                                                             \n");
        sbSql.append("   AND A.CUSTCD = D.CUSTCD                                                                                                                                \n");        
        if (sChk_.equals("Y"))
        {
        	sbSql.append("   AND A.LINE_STATUS BETWEEN '008' AND '009'                                                                                                              \n");
        }
        else
        {
        	sbSql.append("   AND A.LINE_STATUS >= '008'                                                                                                                             \n");
        }
        sbSql.append("   AND A.ITEM_CODE NOT LIKE '01%'                                                                                                                         \n");
        sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "DATEF")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "DATET")) + "'  \n");
        sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "                                                                          \n");
        sbSql.append(" ORDER BY ORDER_NUM, SUBINV_NAME                                                                                                                          \n");
	
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);

		/**����**/
		out_dl.add(ds_List);
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