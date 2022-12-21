<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���ּ�/�����������ȸ
�� ���α׷�ID   : FSV00040E_T001.jsp
�� ���α׷���   : �����������ȸ
�� �ۼ�����     : 2011.04.25
�� �ۼ���       : ������
�� �̷°���     : 2011.04.25
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

		//�Է� ����Ÿ
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_CustCd     = nullToBlank(in_vl.getString("g_CustCd"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);
		if(conn != null && !conn.isClosed()) conn.close();
  		conn = getIRISConn();

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//�ֹ�������ȸ
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT DECODE(NVL(TO_CHAR(A.DELI_TIME), 'N'), 'N', '������', '�������') AS DELI_TIME                                                       \n");
        sbSql.append("     , NVL(A.DELI_COMP, '') AS DELI_COMP                                                                 \n");
        sbSql.append("     , NVL(A.INVOICE_NUM, '') AS INVOICE_NUM                                                             \n");
        if ( ds_Cond.getString(0, "BU_CD").equals(""))        
          sbSql.append("     , (SELECT Z.BU_NM FROM SC_DEPT_V Z WHERE Z.DEPT_ID = A.RC_DEPT_ID AND ROWNUM <= 1 ) AS BU_NM        \n");
        else
          sbSql.append("     , (SELECT Z.BU_NM FROM SC_DEPT_V Z WHERE Z.DEPT_ID = A.RC_DEPT_ID AND Z.BU_CD = '" + nullToBlank(ds_Cond.getString(0, "BU_CD")) + "' AND ROWNUM <= 1 ) AS BU_NM        \n");	
        sbSql.append("     , A.NEED_DATE                                                                                       \n");
        sbSql.append("     , A.ITEM_CODE                                                                                       \n");
        sbSql.append("     , A.ITEM_NAME                                                                                       \n");
        sbSql.append("     , DECODE(A.CENTER_FLAG,'N','��','�ƴϿ�') AS CENTER_FLAG                                              \n");
        sbSql.append("     , A.ITEM_SIZE                                                                                       \n");
        sbSql.append("     , A.PO_UOM                                                                                          \n");
        sbSql.append("     , REPLACE(B.UPJANGNM,'��ü�޽� ') || '(' || REPLACE(C.SUBINV_NAME,'������_') || ')' UPJANGNM           \n");
        sbSql.append("     , A.PO_QTY                                                                                          \n");
        sbSql.append("     , A.UNIT_PRICE                                                                                      \n");
        sbSql.append("     , A.PO_QTY * A.UNIT_PRICE AS GONG_PRICE                                                             \n");
        sbSql.append("     , DECODE(A.TAX_CODE,'100',ROUND(A.PO_QTY * A.UNIT_PRICE / 10,1),0) AS VAT                           \n");
        sbSql.append("     , (A.PO_QTY * A.UNIT_PRICE) + DECODE(A.TAX_CODE,'100',ROUND(A.PO_QTY * A.UNIT_PRICE / 10,1),0) AS TOTAL \n");
        sbSql.append("     , A.LINE_STATUS                                                                                     \n");
        sbSql.append("     , A.PO_ID                                                                                     	   \n");
        sbSql.append("  FROM PO_PO A                                                                                           \n");
        sbSql.append("     , ST_UPJANG B                                                                                       \n");
        sbSql.append("     , PO_SUBINVENTORY C                                                                                 \n");
        sbSql.append("     , ST_CUST D                                                                                         \n");
        sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG                                                                            \n");
        sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+)                                                                  \n");
        sbSql.append("   AND A.CUSTCD = D.CUSTCD                                                                               \n");
        sbSql.append("   AND A.ITEM_CODE > '019000000000'                                                                        \n");
        sbSql.append("   AND D.MRO_FLAG = 'N'                                                                     			   \n");
        sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SP_DATE")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "SP_DATET")) + "'                                                     \n");
        sbSql.append("   AND A.CUSTCD = '" + g_CustCd + "'                                                                     \n");
        sbSql.append("   AND A.LINE_STATUS >= '008'                                                                            \n");
        sbSql.append(" ORDER BY A.ORDER_NUM, A.NEED_DATE                                                                       \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**����**/
		out_dl.add(ds_List);
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
