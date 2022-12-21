<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : FS�Ĵ�/���Ű��� / ���ã��
�� ���α׷�ID   : FSP90020E_S003.jsp
�� ���α׷���   : ���ã�� �����ȸ
�� �ۼ�����     : 2015-07-08
�� �ۼ���       : ����ö
�� �̷°���     : 2015-07-08 ����ö �����ۼ�
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
		DataSet ds_input     	= in_dl.get("ds_cond");
	
		String UPJANG 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String FAVOR_GROUP	= nullToBlank(ds_input.getString(0, "FAVOR_GROUP"));
		
		//out ����Ÿ
		DataSet ds_out;

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //������ȸ		
		
        sbSql.append("\n                                                                                                         \n");
        sbSql.append("SELECT A.UPJANG                            /* ������ڵ�   */                                                \n");
        sbSql.append("    , A.FAVOR_GROUP                        /* ���ã��׷� */                                                \n");
        sbSql.append("    , B.ITEM_CODE                          /* �����ڵ�     */                                                \n");
        sbSql.append("    , B.ITEM_NAME                          /* �����       */                                                \n");
        sbSql.append("    , B.ITEM_SIZE                          /* �԰�         */                                                \n");
        sbSql.append("    , B.ORIGIN_TYPE                        /* ����������   */                                                \n");
        sbSql.append("    , B.ORIGIN_NAT                         /* ����������   */                                                \n");
        sbSql.append("    , B.PO_UOM                             /* ����         */                                                \n");
        sbSql.append("    , C.CONTRACT_PRICE_M   AS UNIT_PRICE   /* �����ܰ�     */                                                \n");
        sbSql.append("    , ''                   AS ITEM_DESC    /* ��������     */                                                \n");
        sbSql.append("    , A.REMARK                             /* ���         */                                                \n");
        sbSql.append("    , A.USE_YN                             /* �������     */                                                \n");
        sbSql.append("    , A.CUSER                              /* �����Է���   */                                                \n");
        sbSql.append("    , A.UUSER                              /* ������       */                                                \n");
        sbSql.append("    , '1'                  AS CHK          /* üũ         */                                                \n");
        sbSql.append("  FROM FSP_FAVORITE      A                                                                                 \n");
        sbSql.append("    , HLDC_PO_ITEM_MST   B                                                                                 \n");
        sbSql.append("    , HLDC_PO_CONTRACT_F C                                                                                 \n");
        sbSql.append(" WHERE A.ITEM_CODE         =   B.ITEM_CODE                                                                 \n");
        sbSql.append("   AND A.UPJANG            =   "  + UPJANG      + "                                                        \n");
        sbSql.append("   AND A.FAVOR_GROUP       =   '" + FAVOR_GROUP + "'                                                       \n");
        sbSql.append("   AND A.USE_YN            =   'Y'                                                                         \n");
        sbSql.append("   AND B.ITEM_CODE         =   C.ITEM_CODE                                                                 \n");
        sbSql.append("   AND A.UPJANG            =   C.UPJANG                                                                    \n");
        // ���ã���ǰ��� ȭ�� ��ȸ �� ���縸 ��ȸ(2018-11-28,���ʽ�)
        // sbSql.append("   AND B.ITEM_CLASS1       =   'F'                                                                         \n");
        sbSql.append("   AND B.USE_YN            =   'Y'                                                                         \n");
        sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START    AND NVL(C.CONTRACT_END, '99991231')         \n");
        sbSql.append("   AND C.USE_YN            =   'Y'                                                                         \n");
        sbSql.append("   AND C.CONTRACT_PRICE_M  > 0                                                                             \n");
        sbSql.append(" ORDER BY B.ITEM_CODE, B.ITEM_NAME                                                                         \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_out = this.makeDataSet(rs, "ds_out"); //ds_list

		rs.close();
		pstmt.close();		
		
		/**����**/
		out_dl.add(ds_out);
		//this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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