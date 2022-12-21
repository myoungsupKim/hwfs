<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ֹ�����
�� ���α׷�ID   : FMP00160E_T001.jsp
�� ���α׷���   : �ֹ� ����
�� �ۼ�����     : 2008.01.21
�� �ۼ���       : ������
�� �̷°���     : 2008.01.21
               2009-03-13 ������ CSR#(25270) ��û��:������(��������)
               �ֹ������� 0�� ���� �Ĵ������� ���ַ� ó��
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		//In ����Ÿ
		DataSet ds_Cond  	    = in_dl.get("ds_in");
		
		String v_Upjang         = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String v_TransDate      = nullToBlank(ds_Cond.getString(0, "DATE"));
		String v_SubinvCode     = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));	
		String v_ITEM_CODE     = nullToBlank(in_vl.getString("ITEM_CODE"));	
		String sOnhandMonth     = "000101";
        String sClsYm           = "";
		String sPhysicDate      = "";
 
	    //out ����Ÿ
		DataSet ds_Close_Check;
				
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());  
		
		//sbSql.append("SELECT DECODE(COUNT(*),0,'N','Y') CLOSE_YN         						\n");
        //sbSql.append("  FROM FMW_CLOSING    					  	\n");
        //sbSql.append(" WHERE SUBINV_CODE = '" + v_SubinvCode + "' 	\n");
        //sbSql.append("   AND CLS_YM >=  SUBSTR('" + v_TransDate + "',1,6)      	\n");
        //sbSql.append("   AND CLS_FLAG = 'Y' 						\n");
        
        
        sbSql.append("SELECT  C.CLOSE_YN , (NVL(A.TRANS_QTY,0) + NVL(B.MINUS_TRANS_QTY,0)) TRANS_QTY                            \n");
        sbSql.append("FROM (                                                     \n");
        sbSql.append("        SELECT SUM(TRANS_QTY) TRANS_QTY, '' CLOSE_YN       \n");
        sbSql.append("         FROM FMW_PO_TRANSACTION                           \n");
        sbSql.append("         WHERE SUBSTR(TRANS_DATE,1,6)||'01' <=  '" + v_TransDate + "'          \n");
        sbSql.append("           AND SUBINV_CODE ='" + v_SubinvCode + "'                    \n");
        sbSql.append("           AND TRANS_TYPE = 'O001'                         \n");
        sbSql.append("           AND ITEM_CODE = '" + v_ITEM_CODE + "'                        \n");
        sbSql.append("        ) A,                                               \n");
        sbSql.append("      (                                                     \n");
        sbSql.append("        SELECT SUM(TRANS_QTY) MINUS_TRANS_QTY, '' CLOSE_YN       \n");
        sbSql.append("         FROM FMW_PO_TRANSACTION                           \n");
        sbSql.append("         WHERE SUBSTR(TRANS_DATE,1,6)||'01' <=  '" + v_TransDate + "'           \n");
        sbSql.append("           AND SUBINV_CODE ='" + v_SubinvCode + "'                    \n");
        sbSql.append("           AND TRANS_TYPE = 'O002'                         \n");
        sbSql.append("           AND ITEM_CODE = '" + v_ITEM_CODE + "'                        \n");
        sbSql.append("        ) B,                                               \n");
        sbSql.append("    (SELECT 0 TRANS_QTY, DECODE(COUNT(*),0,'N','Y') CLOSE_YN \n");
        sbSql.append("      FROM FMW_CLOSING                                     \n");
        sbSql.append("     WHERE SUBINV_CODE = '" + v_SubinvCode + "'                       \n");
        sbSql.append("       AND CLS_YM >=  SUBSTR('" + v_TransDate + "',1,6)               \n");
        sbSql.append("       AND CLS_FLAG = 'Y') C                               \n");

//out_vl.add("fa_Sql", sbSql.toString());		
//System.out.println(sbSql.toString());
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		//rs.next();
		//String sCLOSE_YN = rs.getString("CLOSE_YN");
		ds_Close_Check = this.makeDataSet(rs, "ds_Close_Check");  
		
		rs.close();
		pstmt.close();				
		
		/**����**/
		out_dl.add(ds_Close_Check);		
		
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