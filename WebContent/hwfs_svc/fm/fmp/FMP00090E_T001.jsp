<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�ֹ�����
�� ���α׷�ID   : FMP00090E_T001.jsp
�� ���α׷���   : �԰����� ����
�� �ۼ�����     : 2015.02.10
�� �ۼ���       : �����
�� �̷°���     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.util.Map" %> 
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt            = null;
	CallableStatement cstmt   = null;

	try	{
		
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//�Է� ����Ÿ
		DataSet ds_iud      = in_dl.get("ds_IUD");
		//�Է� �Ķ����
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sPrUpjang      = nullToBlank(in_vl.getString("sPrUpjang"));
		String sPrSabun      = nullToBlank(in_vl.getString("sPrSabun"));
		String sOrgPrNum      = nullToBlank(in_vl.getString("sOrgPrNum"));		
		//�������� ���νü� ȣ�� ���� 2017.09.04 ��ȣ��
		String OldsNeedDate = nullToBlank(in_vl.getString("OldsNeedDate"));     // �԰��� ������ ��¥
        String scrnId       = nullToBlank(in_vl.getString("scrnId"));     // ȭ��ID
		String scrnName     = nullToBlank(in_vl.getString("scrnName"));   // ȭ���
		long p_occur_amt        = 0;
		long p_occur_amt_before = 0;
		double saleAmount 		= 0;
		//�������� ���νü� ȣ�� �� 2017.09.04 ��ȣ��
		
		int sRowStatus;
		String sOtcustCD    = "";
		int iInsCnt         = 0;
		String sDocSrc      = "";
		
		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		StringBuffer sbSql2 = new StringBuffer();
		
		// 1. �ű� ���Ž�û��ȣ �� ���ι�ȣ ��������
		sbSql.delete(0, sbSql.length());

		sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0') AS PRNUM \n");
		sbSql.append("     , NVL((SELECT PR_NUM \n");
		sbSql.append("              FROM (SELECT PR_NUM FROM FMP_OTCUST_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
		sbSql.append("             WHERE ROWNUM <= 1) \n");
		sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0')) AS OTCUST_PRNUM \n");
		sbSql.append("     , '�ڵ�'||TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_APV_NUM_S.NEXTVAL,4,'0') AS PRAPPRNUM \n");
		sbSql.append("  FROM DUAL \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		String sPrNum = rs.getString("PRNUM");
		String sOtcustPrNum = rs.getString("OTCUST_PRNUM");
		String sPrApprNum = rs.getString("PRAPPRNUM");
		
		rs.close();
		pstmt.close();			
	
		// 3. SO_PR ������ ����
		for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sRowStatus = ds_iud.getRowType(i);
			sOtcustCD  = nullToBlank(ds_iud.getString(i, "OTCUSTCD"));
			sDocSrc    = nullToBlank(ds_iud.getString(i, "DOCU_SOURCE"));
			
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				if (sOtcustCD.equals("0000"))
				{
					sbSql.append("UPDATE SO_PR \n");
					sbSql.append("   SET PR_NUM = '" + sPrNum + "' \n");
					sbSql.append("     , APPROVER = '" + g_EmpNo + "' \n");
					sbSql.append("     , APPROVE_TIME = TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
					sbSql.append("     , APPROVE_NUM = '" + sPrApprNum + "' \n");
					sbSql.append("     , NEED_DATE = " + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + " \n");
					sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
					sbSql.append("     , UPDATE_DATE = SYSDATE \n");
					sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
					sbSql.append("   AND LINE_STATUS = '002' \n");
				}
				else
				{
					sbSql.append("UPDATE FMP_OTCUST_PR \n");
					sbSql.append("   SET NEED_DATE = " + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + " \n");
					sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
					sbSql.append("     , UDATE = SYSDATE \n");
					sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
					sbSql.append("   AND LINE_STATUS = '002' \n");
				}
				
				//�������� ���νü� ȣ�� ���� 2017.09.04 ��ȣ��
			 	String p_upjang_cd      = ds_iud.getString(i, "RC_UPJANG").toString();
				String p_apply_date     = sNeedDate + "|" + OldsNeedDate;  // �������԰����� + �������԰����� 
				String prId         = ds_iud.getString(i, "PR_ID").toString();

				// �߻��ݾ� ����
				saleAmount = Double.parseDouble(ds_iud.getString(i, "SALE_AMOUNT").toString());
				// ������ ���
				if (ds_iud.getString(i, "TAX_CODE").equals("100")) {
					p_occur_amt = (long) (saleAmount * 1.1);  
				} else {
					p_occur_amt = (long) saleAmount;
				}

				sbSql2.delete(0, sbSql2.length());
				
				sbSql2.setLength(0);
				sbSql2.append("\n {                             ");
				sbSql2.append("\n  CALL FCUS.FMS_CREDIT_SUM_PRO ");
				sbSql2.append("\n  (                            ");
				sbSql2.append("\n     ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n  )                            ");
				sbSql2.append("\n }                             ");
				
				cstmt = conn.prepareCall( sbSql2.toString() );
				cstmt.setString(1, p_upjang_cd);                   // (�ʼ�)�����ڵ�
				cstmt.setString(2, p_apply_date);                  // (�ʼ�)��������(���ֽ�:�԰����� �Ա�ó����: �Ա����� ������:��������)
				cstmt.setString(3, "11");                       // (�ʼ�)�߻�����(01:���Կ��� 02:����Ȯ�� 03:�ܻ�����)
				cstmt.setLong(4, p_occur_amt);             // (�ʼ�)�߻��ݾ�
				cstmt.setLong(5, p_occur_amt_before);              // (�ʼ�)�߻��ݾ�(��)
				cstmt.setString(6, "01");                       // (�ʼ�)�����ڵ�(01:�ֹ���û���� 02:���⺸�� 03:�ǸŴܰ����� 04:â�� �������� 05:�������� 06:����ȸ�� �ϸ��� 07:ä���̰�/�Ա�ó��)
				cstmt.setString(7, "SO_PR");     // (�ʼ�)�߻����̺�
				cstmt.setString(8, "PR_ID");                   // (�ʼ�)Ű��
				cstmt.setString(9, prId);                      // (�ʼ�)Ű1(�ֹ���û����(PR_NUM), ���⺸��(���ڰ����ȣ), �ǸŴܰ�����(��� ID), â�� ��������(â���ڵ� from to, �����ڵ� from to), ����ȸ�� �ϸ���(�����ڵ�, ����), ä���̰�(ä�ǹ�ȣ from to), �Ա�ó��(ä�Ǵ�ü��ȣ))
				cstmt.setString(10, "");                        // (����)Ű2(�ֹ���û����(PR_NUM), ���⺸��(���ڰ����ȣ), �ǸŴܰ�����(��� ID), â�� ��������(â���ڵ� from to, �����ڵ� from to), ����ȸ�� �ϸ���(�����ڵ�, ����), ä���̰�(ä�ǹ�ȣ from to), �Ա�ó��(ä�Ǵ�ü��ȣ))
				cstmt.setString(11, "");                        // (����)Ű2(�ֹ���û����(PR_NUM), ���⺸��(���ڰ����ȣ), �ǸŴܰ�����(��� ID), â�� ��������(â���ڵ� from to, �����ڵ� from to), ����ȸ�� �ϸ���(�����ڵ�, ����), ä���̰�(ä�ǹ�ȣ from to), �Ա�ó��(ä�Ǵ�ü��ȣ))
				cstmt.setString(12, "");                        // (����)Ű2(�ֹ���û����(PR_NUM), ���⺸��(���ڰ����ȣ), �ǸŴܰ�����(��� ID), â�� ��������(â���ڵ� from to, �����ڵ� from to), ����ȸ�� �ϸ���(�����ڵ�, ����), ä���̰�(ä�ǹ�ȣ from to), �Ա�ó��(ä�Ǵ�ü��ȣ))
				cstmt.setString(13, "");                        // (����)Ű2(�ֹ���û����(PR_NUM), ���⺸��(���ڰ����ȣ), �ǸŴܰ�����(��� ID), â�� ��������(â���ڵ� from to, �����ڵ� from to), ����ȸ�� �ϸ���(�����ڵ�, ����), ä���̰�(ä�ǹ�ȣ from to), �Ա�ó��(ä�Ǵ�ü��ȣ))
				cstmt.setString(14, scrnId);                    // ���α׷�ID
				cstmt.setString(15, scrnName);                  // ���α׷� �ѱ۸�
				cstmt.setString(16, g_EmpNo);                   // ������
				cstmt.registerOutParameter(17, Types.VARCHAR);  // ��������
				cstmt.registerOutParameter(18, Types.VARCHAR);  // �޼���
				
				cstmt.execute();
				if ( logger.isDebugWrite() ) {
					logger.debug("\n�ڡڡڡڡ� FCUS.FMS_CREDIT_SUM_PRO(���űݾ� ���� ���ν���) ���� �ڡڡڡڡ�");
					logger.debug("sPrUpjang           : [" + p_upjang_cd            + "]");
					logger.debug("sNeedDate           : [" + p_apply_date           + "]");
					logger.debug("p_occur_amt         : [" + p_occur_amt    		+ "]");
					logger.debug("p_occur_amt_before  : [" + p_occur_amt_before     + "]");
					logger.debug("prId                : [" + prId               	+ "]");
					logger.debug("scrnId              : [" + scrnId             	+ "]");
					logger.debug("scrnName            : [" + scrnName           	+ "]");
					logger.debug("g_EmpNo             : [" + g_EmpNo            	+ "]");
					logger.debug("o_rtn               : [" + cstmt.getString(17)	+ "]");
					logger.debug("o_rtnmsg            : [" + cstmt.getString(18) 	+ "]");
				}
				// ���űݾ� ���� ���ν��� ó���� �������� ���
				if ( !ValidationUtil.isEquals(cstmt.getString(17), Const.YN_Y) ) {
					conn.rollback();
					this.setResultMessage(-1, cstmt.getString(18), out_vl);
					proc_output(response,out,out_vl,out_dl);
					return;
				}		
				//�������� ���νü� ȣ�� �� 2017.09.04 ��ȣ��   
						
			}
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			iInsCnt = pstmt.executeUpdate();
			pstmt.close();
			
			if (iInsCnt <= 0){continue;}
			
			//�Ĵܹ����� ��� �Ĵ��ڷ� ������Ʈ
			if (sDocSrc.equals("07 FM(�Ĵ�)"))
			{
				
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
				sbSql.append("   SET NEED_DATE = '" + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + "' \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
				sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
				sbSql.append("   AND PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
				sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
				sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
				sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
				sbSql.append("                  AND B.UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
				sbSql.append("                  AND B.SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
				
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
			
		}
		
		//AP_UNITPRICE_UPJANG ���
		sbSql.delete(0, sbSql.length());
		
		sbSql.append("SELECT AP_UNITPRICE_UPJANG \n");
        sbSql.append("  FROM ST_UPJANG \n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_iud.getString(0, "RC_UPJANG")) + "'  \n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
		
        String sApUnitpriceUjang =  nullToBlank(rs.getString("AP_UNITPRICE_UPJANG"));        	
         
        rs.close();
        pstmt.close();  
        
		// ������ �����쿡 ���� ��ȿ�� üũ
        sbSql.delete(0, sbSql.length());
		
		sbSql.append(" SELECT A.ITEM_CODE                                                           \n");
		sbSql.append("      , A.ITEM_NAME                                                           \n");
		sbSql.append("      , A.CENTER_CODE                                                         \n");
		sbSql.append("      , A.RC_UPJANG                                                           \n");
		sbSql.append("      , A.CENTER_FLAG                                                         \n");
		sbSql.append("      , '�ܰ����� ������ �����쿡 ���� �ش��ǰ ��������' AS ITEM_VAL         \n");
		sbSql.append(" FROM  SO_PR A 	                                                            \n");
		sbSql.append(" WHERE 1=1                                                                    \n");
		sbSql.append(" AND   (CENTER_CODE, CUSTCD, ITEM_CODE) IN                                    \n");
		sbSql.append("       (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                 \n");
		sbSql.append("        FROM   FMP_ORDER_SCHEDULE                                             \n");
		sbSql.append("        WHERE  CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                    \n");
		sbSql.append("        AND    UPJANG = '" + sApUnitpriceUjang + "'                                           \n");
		sbSql.append("        AND    USE_YN = 'Y'                                                   \n");
		sbSql.append("        AND    DECODE(TO_CHAR(TO_DATE('" + sNeedDate + "','YYYYMMDD'),'D'),   \n");
		sbSql.append("                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'        \n");
		sbSql.append("        UNION ALL                                                             \n");
		sbSql.append("        (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                \n");
		sbSql.append("        FROM    FMP_ORDER_SCHEDULE                                            \n");
		sbSql.append("        WHERE   CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                   \n");
		sbSql.append("        AND     UPJANG = -2                                                   \n");
		sbSql.append("        AND     USE_YN = 'Y'                                                  \n");
		sbSql.append("        AND     DECODE(TO_CHAR(TO_DATE('" + sNeedDate + "','YYYYMMDD'),'D'),  \n");
		sbSql.append("                       1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'       \n");
		sbSql.append("        MINUS                                                                 \n");
		sbSql.append("        SELECT  CENTER_CODE, CUSTCD, ITEM_CODE                                \n");
		sbSql.append("        FROM    FMP_ORDER_SCHEDULE                                            \n");
		sbSql.append("        WHERE   CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                   \n");
		sbSql.append("        AND     UPJANG = '" + sApUnitpriceUjang + "'                                          \n");
		sbSql.append("        AND     USE_YN = 'Y'                                                  \n");
		sbSql.append("        AND     DECODE(TO_CHAR(TO_DATE('" + sNeedDate + "','YYYYMMDD'),'D'),  \n");
		sbSql.append("                       1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'))     \n");
		sbSql.append(" AND A.PR_NUM = '" + sPrNum + "'                                              \n");
		sbSql.append(" AND A.LINE_STATUS = '002' AND A.DOCU_SOURCE = '" + sDocSrc + "'              \n");
		
		stmt = conn.createStatement();
        rs = stmt.executeQuery(sbSql.toString());

        DataSet ds_save_out = this.makeDataSet(rs,"ds_save_out");
        
        if(ds_save_out.getRowCount() > 0)
        {
           this.setResultMessage(-1, "���� �Ұ� ���簡 �����մϴ�.", out_vl);
           
           conn.rollback();
           out_dl.add(ds_save_out);
           proc_output(response,out,out_vl,out_dl);
           return;
        }
        rs.close();
        stmt.close();
		
		// 4. ���Ź��� ���ռ� üũ
		sbSql.delete(0, sbSql.length());
 		
  		sbSql.append("  SELECT T.* \n");
  		sbSql.append("    FROM ( \n");
  		sbSql.append("    SELECT A.ITEM_CODE \n");
  		sbSql.append("         , A.ITEM_NAME \n");
  		sbSql.append("         , A.CENTER_CODE \n");
  		sbSql.append("         , A.RC_UPJANG \n");
  		sbSql.append("         , A.CENTER_FLAG \n");
  		sbSql.append("         , (SELECT CASE WHEN VAL_SHP_CNT IN ('CE', 'NN') THEN '���� ���屺 ���� ��ȿ�� üũ ����'	\n");
  		sbSql.append("                        WHEN VAL_UNS_CNT IN ('UK', 'NN') THEN '���� �ҿ�üũ ����' \n");
  		sbSql.append("                        WHEN VAL_STP_CNT IN ('TK', 'NN') THEN '���� ����üũ ����' \n");
  		sbSql.append("                        WHEN VAL_EVT_CNT IN ('VE', 'NN') THEN '��ȹ���� ��������üũ ����' \n");
  		sbSql.append("                        WHEN VAL_CTR_CNT IN ('SE', 'NN') THEN 'SPOT��� ����Ƚ��üũ ����' \n");
  		sbSql.append("                        WHEN VAL_REQ_CNT IN ('XE', 'NN') THEN '���Ϻ� ��û�Ұ� üũ ����'	\n");
  		sbSql.append("                        WHEN VAL_SCH_CNT IN ('HE', 'NN') THEN '������ �����쿡 ���� ��ȿ�� üũ ����' \n");
  		sbSql.append("                        WHEN A.CENTER_FLAG = 'DC' \n");
  		//sbSql.append("                             AND EPROCUSR.FC_GET_CENTER_IVT_YN('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE) \n");
  		sbSql.append("                             AND EPROCUSR.FC_GET_CENTER_IVT_YN('100', 'HFC', A.CENTER_CODE \n");
  		sbSql.append("                                                                    , A.ITEM_CODE, A.PR_QTY) = 'N' THEN 'DC���� ����üũ ����' \n");
  		sbSql.append("                   ELSE 'OK' END \n");
  		sbSql.append("              FROM TABLE(EPROCUSR.FN_ITEM_PROCURE_VALIDATE('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE) \n");
  		sbSql.append("                                                           , A.ITEM_CODE, A.VD_SN, A.APPLY_SD, A.PR_QTY, A.UPJANG_GRP, '02' \n");
  		sbSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS') \n");
  		sbSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), TO_CHAR(SYSDATE, 'YYYYMMDD'), '" + sNeedDate + "')) \n");
  		sbSql.append("           ) AS ITEM_VAL \n");
  		sbSql.append("      FROM SO_PR A \n");
  		sbSql.append("     WHERE A.PR_NUM  = '" + sPrNum + "' \n");
  		sbSql.append("       AND A.LINE_STATUS = '002') T \n");
  		sbSql.append(" WHERE T.ITEM_VAL <> 'OK' \n");
		
  		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString());

        ds_save_out = this.makeDataSet(rs,"ds_save_out");
		
        if(ds_save_out.getRowCount() > 0)
		{
			this.setResultMessage(-1, "���Ž�û �Ұ� ���簡 �����մϴ�.", out_vl);
        	conn.rollback();
        	out_dl.add(ds_save_out);
			proc_output(response,out,out_vl,out_dl);
			return;			
		}
        rs.close();
        stmt.close();
        
     	// 2. ���� ���� ������ ����
 		// ���� ���ν��� ȣ��
   		cstmt = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
   		
   		//����
   		cstmt.setString(1,"100");
   		cstmt.setString(2,"HFC");
   		cstmt.setString(3,"FR");
   		cstmt.setString(4,"MT");
   		cstmt.setString(5,sPrUpjang);
   		cstmt.setString(6,sPrSabun);
   		cstmt.setString(7,"07");
   		cstmt.setString(8,sOrgPrNum);
   		cstmt.setString(9,"D");
   		cstmt.registerOutParameter(10, Types.VARCHAR);
   		cstmt.registerOutParameter(11, Types.VARCHAR);
   		
   		cstmt.execute();
   		
   		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:"+cstmt.getString(10));
            
         if(!cstmt.getString(10).equals("S000"))
         {
             conn.rollback();
             this.setResultMessage(-1, cstmt.getString(11), out_vl);
             proc_output(response,out,out_vl,out_dl);
             return;  	 
         }
         cstmt.close();
		
		// 5. ������ SO ������ ���� ����
		// ���� ���ν��� ȣ��
   		cstmt = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
   		
   		//����
   		cstmt.setString(1,"100");
   		cstmt.setString(2,"HFC");
   		cstmt.setString(3,"FR");
   		cstmt.setString(4,"MT");
   		cstmt.setString(5,sPrUpjang);
   		cstmt.setString(6,sPrSabun);
   		cstmt.setString(7,"07");
   		cstmt.setString(8,sPrNum);
   		cstmt.setString(9,"C");
   		cstmt.registerOutParameter(10, Types.VARCHAR);
   		cstmt.registerOutParameter(11, Types.VARCHAR);
   		
   		cstmt.execute();
   		
   		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:"+cstmt.getString(10));
           
        if(!cstmt.getString(10).equals("S000"))
        {
            conn.rollback();
            this.setResultMessage(-1, cstmt.getString(11), out_vl);
            proc_output(response,out,out_vl,out_dl);
            return;
        }
        cstmt.close();
			
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
		if(cstmt != null) {
			try {
				cstmt.close();
			}catch(Exception e) {}
		}
		if(stmt != null) {
			try {
				stmt.close();
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