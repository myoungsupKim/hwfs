<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�޽�ä�ǰ���
�� ���α׷�ID   : MAK10170S_T003.jsp
�� ���α׷���   : �Ա� �� ������Ȳ��ȸ(��ü����)
�� �ۼ�����     : 2008.08.19
�� �ۼ���       : ������
�� �̷°���     : 2008.08.19
* HISTORY    : 
	  1. ���� ���� : 2009/06/12(��)  �����ȣ : #28264 �νô�Ʈ : 116727
	     ������ : ��Կ�
	     ���泻�� : ���� Grid���� �����ѵ� �ʰ��׿� ���� ���� �ѵ� �ʰ� �������� �߰�.
	     ��û�� : FS ������ ������
	  2. ���� ���� : 2009/08/18(ȭ)  �����ȣ : #29877 �νô�Ʈ : 123488
	     ������ : ��Կ�
	     ���� ���� : �ܻ�/���� �ܾ��� ���� ��� ��  ��츦 ��� �Ͽ� ����(ADD_MONTHS(��¥,1))�� ���Ͽ� 
	               �ְ� 2��ġ ���� ���� ���� ����.
	     ��û�� : FS ������ ������
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
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out ����Ÿ
		DataSet ds_List, ds_ListTmp;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//���� ���� ���� ��� ����üũ�� ���� �������� ��ȸ
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       MAX(A.NEED_DATE) AS NEED_DATE \n");
		sbSql.append("  FROM SO_PR A, FMS_UPJANG B\n");
		sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND A.SUBINV_CODE LIKE 'S1%' \n");
		sbSql.append("   AND A.LINE_STATUS NOT IN ('003', '005','999')  --��û���, ���ǹݷ� ���� \n");
		//sbSql.append("   AND B.HEAD_CREDIT_YN = 'Y' \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
		//sbSql.append("   ORDER BY A.NEED_DATE DESC \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		String strDate;
		if(rs.next())
			strDate = rs.getString("NEED_DATE");
		else
			strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
		rs.close();
		pstmt.close();

		if (nullToBlank(strDate)=="") strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));


		//�������� ���峻����ȸ(�ӵ������ ����� �������� �ʴ´�.)
		//���ſ���ݾ� ����
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* MAK10170S_T003_1.jsp */ \n");
		sbSql.append(" SELECT  /*+ optimizer_features_enable('10.2.0.5') */ \n");
		sbSql.append("       A.MAIN_UPJANG, DECODE(A.MAIN_UPJANG,A.UPJANG,'0','1') AS BON_GB \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NULL,' - ')||A.UPJANGNM_DISP AS UPJANGNM_DISP \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0)) AS AMT1 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0)) AS AMT1_0 \n");
		// 2016-01-06 : ����������, �ѿ��ž�,�⺻����å������ �������� ���ĸ� ǥ�� ����
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0)) ELSE 0 END) AS AMT1 \n");
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0)) ELSE 0 END) AS AMT1_0 \n");
		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,0) AS AMT1_1 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0),NVL(E_1.PO_AMT,0) + NVL(F_1.PR_AMT,0)) AS AMT1_2 \n");		// ���Կ���
		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0)) AS AMT1_2 \n");		// ���Կ���
		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(D.TR_AMT,0),NVL(D_1.TR_AMT,0)) AS AMT1_3 \n");		// ����Ȯ��
		//sbSql.append("	 , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0)) AS AMT2_0 \n");	// ��)�ܻ���� 
		sbSql.append("	 , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(C0.RMN_AMT,0)) AS AMT2_0 \n");	// ��)�ܻ���� 
		sbSql.append("	 , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(C1.PRE_AMT,0)) AS AMT2_3 \n");	// ������
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(C.RMN_SALS_AMT,0)) AS AMT2 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(C.RMN_SALS_AMT,0) - NVL(C.RMN_AMT,0)) AS AMT2_1 \n");  
		sbSql.append("     , 0 AS AMT2 \n");
		sbSql.append("     , 0 AS AMT2_1 \n");  
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0) - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0) + NVL(A.CREDIT_OVER_AMOUNT,0) - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");		// 2015-10-05 �ӽÿ��� �߰�
		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,CASE WHEN  '" + nullToBlank(strDate) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999')  THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END \n");
		sbSql.append("       - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");		// 2015-10-11 �ӽÿ��� ���뿩�� ����
		sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN \n");
		sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("             ,'YYY','�ݾ�+ȸ����' \n");
		sbSql.append("             ,'YYN','ȸ��������' \n");
		sbSql.append("             ,'YNY','�ݾ�����','������') AS CTRL \n");
		sbSql.append("     , A.CREDIT_TURN_DAYS AS CREDIT_TURN_DAYS \n");
		sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");
		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,'Y','N') AS SUM_FLAG \n");
		// 2009-04-06 �߰� ����. ���� : �����ѵ��ʰ��� ���� �����ѵ��ʰ����� ������ ���� ���� �߰� �� �κ�. BY ��Կ�.		
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(strDate) + "' THEN DECODE(A.MAIN_UPJANG,A.UPJANG,A.CREDIT_OVER_AMOUNT) ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		// 2015-10-06 : �ӽÿ���������, �ӽÿ����ѵ����� �������� ���ĸ� ǥ�� ����
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN DECODE(A.MAIN_UPJANG,A.UPJANG,A.CREDIT_OVER_AMOUNT) ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		// 2009-06-16 �߰� ����. ���� : �����ѵ��ʰ� �ݾ� ������ �ʵ�  �߰� �� �κ�. BY ��Կ�. #28264
		// 2015-10-06 : �ӽÿ���������, �ӽÿ����ѵ����� �������� ���ĸ� ǥ�� ����
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(strDate) + "' THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		sbSql.append("  FROM FMS_UPJANG A \n");

		// ------ ���� : �����ڵ�
		if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
		{
            sbSql.append("									INNER JOIN ST_UPJANG Y ON A.UPJANG = Y.UPJANG \n");
            sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
            sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
		}		

		//----------------------------------------------------------
		// C. �ܻ��ܾ�����
		//----------------------------------------------------------
		// 2015-10-10 : ���ݰ�꼭 ���� ��, �� �ݾ� ������ - ȭ��󿡼� ���� ��û
		/*
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("		 --C.�ܻ��ܾ�����(����) \n");
							sbSql.append("  ( SELECT MAIN_UPJANG , SUM(SALS_AMT) RMN_SALS_AMT  , SUM(AMT) RMN_AMT  FROM (\n");
							sbSql.append("     SELECT B.MAIN_UPJANG, SUM(A.SALS_AMT) SALS_AMT, 																				  \n");
							sbSql.append("     		 (SELECT SUM(AMT) FROM SLA_TAX_SHET_OCCUR_OBJ WHERE UPJANG_SALS_NUM=A.UPJANG_SALS_NUM ) AMT 									  \n");
							sbSql.append("  		  FROM SLA_UPJANG_SALS_ISRC A 																							 		  \n");
							sbSql.append("									   INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y' 													  \n");
							// ------ ���� : ��뿩��
							if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							sbSql.append("								  										     AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							// ------ ���� : �������
							if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
								sbSql.append("																		 AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							sbSql.append("								  											 AND A.UPJANG_CD = B.UPJANG \n");
							// ------ ���� : �����ڵ�
							if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							{
								sbSql.append("									INNER JOIN ST_UPJANG Y ON A.UPJANG_CD = Y.UPJANG \n");
								sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
								sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							}								
							sbSql.append("  		 WHERE A.SALS_DATE <= '" + nullToBlank(strDate) + "'												  \n");
							sbSql.append("  		       AND A.SYS_CLASS IN ('13', '14')																		  \n");
							sbSql.append("  		       AND A.RECD_STATUS='L'																							  \n");
							sbSql.append("  		 GROUP BY MAIN_UPJANG																										  \n");
							sbSql.append("  		     ,A.UPJANG_SALS_NUM)																							      \n");
							sbSql.append("  		     GROUP BY MAIN_UPJANG ) C																									  \n");
							sbSql.append("        ON A.MAIN_UPJANG = C.MAIN_UPJANG \n");
		*/							
					sbSql.append("       LEFT JOIN \n");
					sbSql.append("		 --C0.�ܻ��ܾ�����(AR) \n");
							sbSql.append("  (  \n");
							sbSql.append("  SELECT  \n");
							sbSql.append("		  S.MAIN_UPJANG   \n");
							sbSql.append("		, SUM(NVL(S.AR_AMT,0) - NVL(S.RECEIVE_AMT,0)) AS RMN_AMT \n");
							sbSql.append("  FROM \n");
								sbSql.append("      (SELECT B.MAIN_UPJANG \n");
								sbSql.append("				, NVL(M.AR_AMT,0) AS AR_AMT \n");
								sbSql.append("				, (SELECT NVL(SUM(D.RECEIVE_AMT),0) FROM SLA_AR_RECEIVE_DETAIL D WHERE D.RECD_STATUS  = 'L' \n");
								sbSql.append("								  																			 AND D.RECEIVE_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'	 \n"); // ���� : �԰����� 
								sbSql.append("								  																			 AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n");
								sbSql.append("       FROM SLA_AR_MST M  \n");
								sbSql.append("									   INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
								// ------ ���� : ��뿩��
								if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
								sbSql.append("								  											 AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
								// ------ ���� : �������
								if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
									sbSql.append("																		 AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
								sbSql.append("								  											 AND M.UPJANG_CD = B.UPJANG \n");
								// ------ ���� : �����ڵ�
								if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
								{
									sbSql.append("								 INNER JOIN ST_UPJANG Y ON M.UPJANG_CD = Y.UPJANG \n");
									sbSql.append("								 INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
									sbSql.append("																						 AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
								}		

								sbSql.append("		WHERE M.SYS_CLASS IN ('13', '14') \n");
								sbSql.append("		AND    M.RECD_STATUS = 'L' \n");
								sbSql.append("		AND    M.OCCUR_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' \n");	// ���� : �԰����� 
								sbSql.append("        ) S \n");
							sbSql.append("    GROUP BY S.MAIN_UPJANG  \n"); 
							//sbSql.append("	HAVING  SUM(NVL(S.AR_AMT,0) - NVL(S.RECEIVE_AMT,0)) > 0	\n"); //  ä���ܾ��� �ִ� �ڷ� ���� 
							sbSql.append("	) C0	\n");
		sbSql.append("        ON A.MAIN_UPJANG = C0.MAIN_UPJANG \n");

		//----------------------------------------------------------
		// C1. �����ܾ�����
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("       --C1.�����ܾ����� \n");
							sbSql.append("  (  \n");
							sbSql.append("  SELECT  \n");
							sbSql.append("		  S.MAIN_UPJANG   \n");
							sbSql.append("		, SUM(NVL(S.OCCUR_AMT,0) - NVL(S.APPLY_AMT,0)) AS PRE_AMT \n");
							sbSql.append("  FROM \n");
								sbSql.append("      (SELECT B.MAIN_UPJANG \n");
								sbSql.append("				, NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n");
								sbSql.append("				, (SELECT NVL(SUM(D.APPLY_AMT),0) FROM SLA_ADVANCE_ALT_DETAIL D WHERE D.RECD_STATUS  = 'L' \n");
								sbSql.append("								  																			 AND D.ALT_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'	 \n"); // ���� : �԰����� 
								sbSql.append("								  																			 AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n");
								sbSql.append("       FROM SLA_ADVANCE_MST M  \n");
								sbSql.append("									   INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
								// ------ ���� : ��뿩��
								if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
								sbSql.append("								  											 AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
								// ------ ���� : �������
								if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
									sbSql.append("																		 AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
								sbSql.append("								  											 AND M.UPJANG_CD = B.UPJANG \n");
								// ------ ���� : �����ڵ�
								if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
								{
									sbSql.append("								 INNER JOIN ST_UPJANG Y ON M.UPJANG_CD = Y.UPJANG \n");
									sbSql.append("								 INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
									sbSql.append("																						 AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
								}		
								sbSql.append("		WHERE M.SYS_CLASS IN ('13', '14') \n");
								sbSql.append("		AND    M.RECD_STATUS = 'L' \n");
								sbSql.append("		AND    M.OCCUR_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' \n");	// ���� : �԰����� 
								sbSql.append("       ) S \n");
								sbSql.append("    GROUP BY S.MAIN_UPJANG \n");
								//sbSql.append("	HAVING SUM(NVL(S.OCCUR_AMT,0) - NVL(S.APPLY_AMT,0)) > 0	\n"); // �����ܾ��� �ִ� �ڷ� ���� 
							sbSql.append("	) C1	\n"); 
		sbSql.append("        ON A.MAIN_UPJANG = C1.MAIN_UPJANG \n");


		//----------------------------------------------------------
		// D.��� �̸��⸶���� �˼��ݾ� : �������
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("       --D.��� �̸��⸶���� �˼��ݾ� \n");
							sbSql.append("      (SELECT X.MAIN_UPJANG \n");
							sbSql.append("				, SUM(X.TR_AMT) AS TR_AMT \n");
							sbSql.append("        FROM   \n");
							sbSql.append("				(  \n");
							//sbSql.append("			  /* D1. �����������(FMS_SALES) �� ����ȸ�� ������ �ڷ� : �ΰ��� ���� */  \n");
							//sbSql.append("               SELECT B.MAIN_UPJANG \n"); 
							//sbSql.append("						, SUM(NVL(A.SAL_AMT,0)) AS TR_AMT \n");
							//sbSql.append("				FROM FMS_SALES A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							//// ------ ���� : ��뿩��
							//if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							//sbSql.append("								  												   AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							//// ------ ���� : �������
							//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							//	sbSql.append("																			   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							//sbSql.append("								  												   AND A.UPJANG = B.UPJANG \n");
							//// ------ ���� : �����ڵ�
							//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							//{
							//	sbSql.append("											INNER JOIN ST_UPJANG Y ON A.UPJANG = Y.UPJANG \n");
							//	sbSql.append("											INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							//	sbSql.append("																						 AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							//}		
							//sbSql.append("				WHERE A.SALE_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							//sbSql.append("				AND    A.TRANS_YN = 'N'	 \n");	// ����ȸ�� �����۰� 
							//sbSql.append("				GROUP BY B.MAIN_UPJANG \n");

							//sbSql.append("				UNION ALL \n");

							sbSql.append("			  /* D2. �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */  \n");
							sbSql.append("               SELECT B.MAIN_UPJANG \n"); 
							//sbSql.append("						, SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS TR_AMT \n");
							sbSql.append("						, SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
							sbSql.append("				FROM FMS_TRANSACTION_V A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							// ------ ���� : ��뿩��
							if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							sbSql.append("								  																  AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							// ------ ���� : �������
							if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
								sbSql.append("																							  AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							sbSql.append("								  																  AND A.TRANS_UPJANG = B.UPJANG \n");
							// ------ ���� : �����ڵ�
							if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							{
								sbSql.append("														INNER JOIN ST_UPJANG Y ON A.TRANS_UPJANG = Y.UPJANG \n");
								sbSql.append("														INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
								sbSql.append("																						 AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							}		
							sbSql.append("															LEFT JOIN (  \n");
							sbSql.append("																			SELECT  \n");
							sbSql.append("					  															UPJANG \n");
							sbSql.append("																			 ,  MAX(SALE_DATE) AS SALE_DATE \n");
							sbSql.append("																			FROM   FMS_SALES \n");
							sbSql.append("																			WHERE  SALE_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							sbSql.append("				 															AND     TRANS_YN = 'Y' \n");		// ����ȸ�� ���� ����
							sbSql.append("				 															GROUP BY UPJANG \n");
							sbSql.append("																			) C ON A.TRANS_UPJANG = C.UPJANG \n");
							sbSql.append("				WHERE    A.MG_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							// ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ����
							//sbSql.append("				AND    A.TRANS_DATE >= GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(strDate) + "', 'YYYYMMDD'), -1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
							// ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� : 2015-10-27
							sbSql.append("				AND    A.MG_DATE >= DECODE(C.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(strDate) + "', 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
							sbSql.append("				AND    (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))  \n");
							sbSql.append("				GROUP BY B.MAIN_UPJANG \n");
							sbSql.append("				) X	 \n");
							sbSql.append("	GROUP BY X.MAIN_UPJANG \n");
							sbSql.append("	) D	 \n");
		sbSql.append("        ON A.MAIN_UPJANG = D.MAIN_UPJANG \n");


		//----------------------------------------------------------
		// E.��� �̰˼� ���ֱݾ� 
		//----------------------------------------------------------
		// PW(��������), PC(���ֿϷ�), DL(�����) �� ����
		// CENTER_DELI_QTY(�����԰����), DIRECT_DELI_QTY(���ۼ���), DELIVERED_QTY(�����԰����-�������), UNDELIVERED_QTY(���͹��԰����) 
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("       --E.��� �̰˼� ���ֱݾ� \n");
							sbSql.append("      (SELECT \n");
							sbSql.append("              B.MAIN_UPJANG \n");
							sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT  \n");
							sbSql.append("		FROM HLDC_PO_PO A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							// ------ ���� : ��뿩��
							if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							sbSql.append("								  										   AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							// ------ ���� : �������
							if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
								sbSql.append("																	   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							sbSql.append("						  												   AND A.RC_UPJANG = B.UPJANG \n");
							// ------ ���� : �����ڵ�
							if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							{
								sbSql.append("									INNER JOIN ST_UPJANG Y ON A.RC_UPJANG = Y.UPJANG \n");
								sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
								sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							}		
							sbSql.append("		WHERE A.NEED_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							sbSql.append("		AND     A.LINE_STATUS IN ('PW', 'PC', 'DL') \n");
							sbSql.append("        GROUP BY B.MAIN_UPJANG) E \n");
		sbSql.append("        ON A.MAIN_UPJANG = E.MAIN_UPJANG \n");


		//----------------------------------------------------------
		// F.��� �̹��� �ֹ��ݾ�  
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("       --F.��� �̹��� �ֹ��ݾ� \n");
							sbSql.append("      (SELECT \n");
							sbSql.append("              B.MAIN_UPJANG \n");
							sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
							sbSql.append("		FROM SO_PR A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							// ------ ���� : ��뿩��
							if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							sbSql.append("								  									AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							// ------ ���� : �������
							if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
								sbSql.append("															    AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							sbSql.append("						  											AND A.RC_UPJANG = B.UPJANG \n");
							// ------ ���� : �����ڵ�
							if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							{
								sbSql.append("							INNER JOIN ST_UPJANG Y ON A.RC_UPJANG = Y.UPJANG \n");
								sbSql.append("							INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
								sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							}		
							sbSql.append("		WHERE A.NEED_DATE <= '" + nullToBlank(strDate) + "'	\n");  // ���� : �԰����� 
							sbSql.append("		AND    A.LINE_STATUS IN ('001') 	\n");		// ������� : 001(��û����) 
							sbSql.append("        GROUP BY B.MAIN_UPJANG) F \n");
		sbSql.append("        ON A.MAIN_UPJANG = F.MAIN_UPJANG \n");



		//----------------------------------------------------------
		// D_1.��� �̸��⸶���� �˼��ݾ� : ��������
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("       --D_1.��� �̸��⸶���� �˼��ݾ� \n");
							sbSql.append("      (SELECT X.UPJANG \n");
							sbSql.append("				, SUM(X.TR_AMT) AS TR_AMT \n");
							sbSql.append("        FROM   \n");
							sbSql.append("				(  \n");
							//sbSql.append("			  /* D1. �����������(FMS_SALES) �� ����ȸ�� ������ �ڷ� : �ΰ������� */  \n");
							//sbSql.append("               SELECT B.UPJANG \n"); 
							//sbSql.append("						, SUM(NVL(A.SAL_AMT,0)) AS TR_AMT \n");
							//sbSql.append("				FROM FMS_SALES A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							//// ------ ���� : ��뿩��
							//if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							//sbSql.append("								  												   AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							//// ------ ���� : �������
							//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							//	sbSql.append("																			   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							//sbSql.append("								  												   AND A.UPJANG = B.UPJANG \n");
							//// ------ ���� : �����ڵ�
							//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							//{
							//	sbSql.append("										INNER JOIN ST_UPJANG Y ON A.UPJANG = Y.UPJANG \n");
							//	sbSql.append("										INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							//	sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							//}		
							//sbSql.append("				WHERE A.SALE_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							//sbSql.append("				AND    A.TRANS_YN = 'N'	 \n");	// ����ȸ�� �����۰� 
							//sbSql.append("				GROUP BY B.UPJANG \n");

							//sbSql.append("				UNION ALL \n");

							sbSql.append("			  /* D2. �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */  \n");
							sbSql.append("               SELECT B.UPJANG \n"); 
							//sbSql.append("						, SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS TR_AMT \n");
							sbSql.append("						, SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
							sbSql.append("				FROM FMS_TRANSACTION_V A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							// ------ ���� : ��뿩��
							if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							sbSql.append("								  																  AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							// ------ ���� : �������
							if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
								sbSql.append("																							  AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							sbSql.append("								  																  AND A.TRANS_UPJANG = B.UPJANG \n");
							// ------ ���� : �����ڵ�
							if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							{
								sbSql.append("														INNER JOIN ST_UPJANG Y ON A.TRANS_UPJANG = Y.UPJANG \n");
								sbSql.append("														INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
								sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							}		
							sbSql.append("															LEFT JOIN (  \n");
							sbSql.append("																			SELECT  \n");
							sbSql.append("					  															UPJANG \n");
							sbSql.append("																			 ,  MAX(SALE_DATE) AS SALE_DATE \n");
							sbSql.append("																			FROM   FMS_SALES \n");
							sbSql.append("																			WHERE  SALE_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							sbSql.append("				 															AND     TRANS_YN = 'Y' \n");		// ����ȸ�� ���� ����
							sbSql.append("				 															GROUP BY UPJANG \n");
							sbSql.append("																			) C ON A.TRANS_UPJANG = C.UPJANG \n");
							sbSql.append("				WHERE    A.MG_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							// ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ����
							//sbSql.append("				AND    A.TRANS_DATE >= GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(strDate) + "', 'YYYYMMDD'), -1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
							// ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� : 2015-10-27
							sbSql.append("				AND    A.MG_DATE >= DECODE(C.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(strDate) + "', 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
							sbSql.append("				AND    (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))  \n");
							sbSql.append("				GROUP BY B.UPJANG \n");
							sbSql.append("				) X	 \n");
							sbSql.append("	GROUP BY X.UPJANG \n");
							sbSql.append("	) D_1	 \n");
		sbSql.append("        ON A.UPJANG = D_1.UPJANG \n");

		//----------------------------------------------------------
		// E_1.��� �̰˼� ���ֱݾ�  : ����� ���� : ǥ��(X)
		//----------------------------------------------------------
		// PW(��������), PC(���ֿϷ�), DL(�����) �� ����
		// CENTER_DELI_QTY(�����԰����), DIRECT_DELI_QTY(���ۼ���), DELIVERED_QTY(�����԰����-�������), UNDELIVERED_QTY(���͹��԰����) 
		/*
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("       --E.��� �̰˼� ���ֱݾ� \n");
							sbSql.append("      (SELECT \n");
							sbSql.append("              B.UPJANG \n");
							sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT  \n");
							sbSql.append("		FROM HLDC_PO_PO A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							// ------ ���� : ��뿩��
							if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							sbSql.append("								  										   AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							// ------ ���� : �������
							if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
								sbSql.append("																	   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							sbSql.append("						  												   AND A.RC_UPJANG = B.UPJANG \n");
							// ------ ���� : �����ڵ�
							if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							{
								sbSql.append("									INNER JOIN ST_UPJANG Y ON A.RC_UPJANG = Y.UPJANG \n");
								sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
								sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							}		
							sbSql.append("		WHERE A.NEED_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
							sbSql.append("		AND     A.LINE_STATUS IN ('PW', 'PC', 'DL') \n");
							sbSql.append("        GROUP BY B.UPJANG) E_1 \n");
		sbSql.append("        ON A.UPJANG = E_1.UPJANG \n");


		//----------------------------------------------------------
		// F_1.��� �̹��� �ֹ��ݾ�  : ����� ����
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
							sbSql.append("       --F.��� �̹��� �ֹ��ݾ� \n");
							sbSql.append("      (SELECT \n");
							sbSql.append("              B.UPJANG \n");
							sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
							sbSql.append("		FROM SO_PR A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'Y'  \n");
							// ------ ���� : ��뿩��
							if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
							sbSql.append("								  									AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
							// ------ ���� : �������
							if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
								sbSql.append("																AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
							sbSql.append("						  											AND A.RC_UPJANG = B.UPJANG \n");
							// ------ ���� : �����ڵ�
							if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
							{
								sbSql.append("							INNER JOIN ST_UPJANG Y ON A.RC_UPJANG = Y.UPJANG \n");
								sbSql.append("							INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
								sbSql.append("																				   AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
							}		
							sbSql.append("		WHERE A.NEED_DATE <= '" + nullToBlank(strDate) + "'	\n");  // ���� : �԰����� 
							sbSql.append("		AND    A.LINE_STATUS IN ('001') 	\n");		// ������� : 001(��û����) 
							sbSql.append("        GROUP BY B.UPJANG) F_1 \n");
		sbSql.append("        ON A.UPJANG = F_1.UPJANG \n");
		*/

		sbSql.append("  WHERE A.HEAD_CREDIT_YN = 'Y' \n");
		// ------ ���� : ��뿩��
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
		sbSql.append("   AND A.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
			sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();
		
		//���� �� ���� ���� ��� ����üũ�� ���� �������� ��ȸ
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       MAX(A.NEED_DATE) AS NEED_DATE \n");
		sbSql.append("  FROM SO_PR A, FMS_UPJANG B\n");
		sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+15,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND A.SUBINV_CODE LIKE 'S1%' \n");
		sbSql.append("   AND A.LINE_STATUS NOT IN ('003', '005','999')  --��û���, ���ǹݷ� ���� \n");
		//sbSql.append("   AND B.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
		//sbSql.append("   ORDER BY A.NEED_DATE DESC \n");
//out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if(rs.next())
			strDate = rs.getString("NEED_DATE");
		else
			strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
		rs.close();
		pstmt.close();

		if (nullToBlank(strDate)=="") strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));


		//���� �� ���� ���峻����ȸ(�ӵ������ ����� �������� �ʴ´�.)
		//���ſ���ݾ� ���� ����
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* MAK10170S_T003_2.jsp */ \n");
		sbSql.append(" SELECT  /*+ optimizer_features_enable('10.2.0.5') */ \n");
		sbSql.append("       A.MAIN_UPJANG, '1' AS BON_GB \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , A.UPJANGNM_DISP \n");
		//sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) AS AMT1 \n");
		//sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) AS AMT1_0 \n");
		// 2016-01-06 : ����������, �ѿ��ž�,�⺻����å������ �������� ���ĸ� ǥ�� ����
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS AMT1 \n");
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS AMT1_0 \n");
		sbSql.append("     , 0 AS AMT1_1 \n");
		sbSql.append("     , NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS AMT1_2 \n");
		sbSql.append("     , NVL(D.TR_AMT,0) AS AMT1_3 \n");
		//sbSql.append("	 , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) AS AMT2_0 \n");	// ��)�ܻ���� 
		sbSql.append("	 , NVL(C0.RMN_AMT,0)  AS AMT2_0 \n");	// ��)�ܻ���� 
		sbSql.append("	 , NVL(C1.PRE_AMT,0)  AS AMT2_3 \n");	// ������
		//sbSql.append("     , NVL(C.RMN_SALS_AMT,0) AS AMT2 \n");
		//sbSql.append("     , NVL(C.RMN_SALS_AMT,0)-NVL(C.RMN_AMT,0) AS AMT2_1 \n");
		sbSql.append("     , 0 AS AMT2 \n");
		sbSql.append("     , 0 AS AMT2_1 \n");
		//sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 \n");
		//sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) + NVL(A.CREDIT_OVER_AMOUNT,0) - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 \n");		// 2015-10-05 : �ӽÿ����ѵ� �߰�
		sbSql.append("     , CASE WHEN  '" + nullToBlank(strDate) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999')  THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END \n");
		sbSql.append("       - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 \n");		// 2015-10-11 �ӽÿ��� ���뿩�� ����
		sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN \n");
		sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("             ,'YYY','�ݾ�+ȸ����' \n");
		sbSql.append("             ,'YYN','ȸ��������' \n");
		sbSql.append("             ,'YNY','�ݾ�����','������') AS CTRL \n");
		sbSql.append("     , A.CREDIT_TURN_DAYS \n");
		sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");
		sbSql.append("     , 'Y' AS SUM_FLAG \n");
		// 2009-04-06 �߰� ����. ���� : �����ѵ��ʰ��� ���� �����ѵ��ʰ����� ������ ���� ���� �߰� �� �κ�. BY ��Կ�.
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(strDate) + "' THEN A.CREDIT_OVER_AMOUNT ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		// 2015-10-06 : �ӽÿ���������, �ӽÿ����ѵ����� �������� ���ĸ� ǥ�� ����
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		// 2009-06-16 �߰� ����. ���� : �����ѵ��ʰ� �ݾ� ������ �ʵ�  �߰� �� �κ�. BY ��Կ�. #28264
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(strDate) + "' THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		// 2015-10-06 : �ӽÿ���������, �ӽÿ����ѵ����� �������� ���ĸ� ǥ�� ����
		sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		sbSql.append("  FROM FMS_UPJANG A \n");

		// ------ ���� : �����ڵ�
		if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
		{
            sbSql.append("									INNER JOIN ST_UPJANG Y ON A.UPJANG = Y.UPJANG \n");
            sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
            sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
		}		
		//----------------------------------------------------------
		// C. �ܻ��ܾ�����
		//----------------------------------------------------------
		// 2015-10-10 : ���ݰ�꼭 ���� ��, �� �ݾ� ������ - ȭ��󿡼� ���� ��û
		/*
		sbSql.append("       LEFT JOIN \n");
						sbSql.append("       --C.�ܻ��ܾ����� \n");
						sbSql.append("  ( SELECT UPJANG , SUM(SALS_AMT) RMN_SALS_AMT  , SUM(AMT) RMN_AMT  FROM (\n");
						sbSql.append("     SELECT A.UPJANG_CD UPJANG, SUM(A.SALS_AMT) SALS_AMT, 																				  \n");
						sbSql.append("     		 (SELECT SUM(AMT) FROM SLA_TAX_SHET_OCCUR_OBJ WHERE UPJANG_SALS_NUM=A.UPJANG_SALS_NUM ) AMT 									  \n");
						sbSql.append("  		  FROM SLA_UPJANG_SALS_ISRC A 																							 		  \n");
						sbSql.append("									   INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'N' 													  \n");
						// ------ ���� : ��뿩��
						if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
						sbSql.append("								  										     AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
						// ------ ���� : �������
						if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							sbSql.append("																		 AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
						sbSql.append("								  											 AND A.UPJANG_CD = B.UPJANG \n");
						// ------ ���� : �����ڵ�
						if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
						{
							sbSql.append("									INNER JOIN ST_UPJANG Y ON A.UPJANG_CD = Y.UPJANG \n");
							sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
						}								
						sbSql.append("  		 WHERE A.SALS_DATE <= '" + nullToBlank(strDate) + "'												  \n");
						sbSql.append("  		       AND A.SYS_CLASS IN ('13', '14')																					  \n");
						sbSql.append("  		       AND A.RECD_STATUS='L'																							  \n");
						sbSql.append("  		 GROUP BY UPJANG_CD																										  \n");
						sbSql.append("  		     ,A.UPJANG_SALS_NUM)																							      \n");
						sbSql.append("  		     GROUP BY UPJANG ) C																									  \n");
								 						
		sbSql.append("        ON A.UPJANG = C.UPJANG \n");
		*/		
		sbSql.append("       LEFT JOIN \n");
		sbSql.append("       --C0.�ܻ��ܾ�����(AR) \n");
						sbSql.append("  (  \n");
						sbSql.append("  SELECT  \n");
						sbSql.append("		  S.UPJANG   \n");
						sbSql.append("		, SUM(NVL(S.AR_AMT,0) - NVL(S.RECEIVE_AMT,0)) AS RMN_AMT \n");
						sbSql.append("  FROM \n");
						sbSql.append("      (SELECT B.UPJANG \n");
						sbSql.append("				, NVL(M.AR_AMT, 0) AS AR_AMT \n");
						sbSql.append("				, (SELECT NVL(SUM(D.RECEIVE_AMT),0) FROM SLA_AR_RECEIVE_DETAIL D WHERE D.RECD_STATUS  = 'L' \n");
						sbSql.append("								  																			 AND D.RECEIVE_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'	 \n"); // ���� : �԰����� 
						sbSql.append("								  																			 AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n");
						sbSql.append("       FROM SLA_AR_MST M  \n");
						sbSql.append("									   INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'N'  \n");
						// ------ ���� : ��뿩��
						if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
						sbSql.append("								  										     AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
						// ------ ���� : �������
						if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							sbSql.append("																		 AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
						sbSql.append("								  											 AND M.UPJANG_CD = B.UPJANG \n");
						// ------ ���� : �����ڵ�
						if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
						{
							sbSql.append("									INNER JOIN ST_UPJANG Y ON M.UPJANG_CD = Y.UPJANG \n");
							sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
						}		
						sbSql.append("		WHERE M.SYS_CLASS IN ('13', '14') \n");
						sbSql.append("		AND    M.RECD_STATUS = 'L' \n");
						sbSql.append("		AND    M.OCCUR_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' \n");	// ���� : �԰����� 
						sbSql.append("        ) S \n");
						sbSql.append("    GROUP BY S.UPJANG \n");
						//sbSql.append("	HAVING SUM(NVL(S.AR_AMT,0) - NVL(S.RECEIVE_AMT,0)) > 0	\n"); //  ä���ܾ��� �ִ� �ڷ� ���� 
						sbSql.append("	) C0	\n"); 
	sbSql.append("        ON A.UPJANG = C0.UPJANG \n");
		//----------------------------------------------------------
		// C1. �����ܾ�����
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
						sbSql.append("       --C1.�����ܾ����� \n");
						sbSql.append("  (  \n");
						sbSql.append("  SELECT  \n");
						sbSql.append("		  S.UPJANG   \n");
						sbSql.append("		, SUM(NVL(S.OCCUR_AMT,0) - NVL(S.APPLY_AMT,0)) AS PRE_AMT \n");
						sbSql.append("  FROM \n");
						sbSql.append("      (SELECT B.UPJANG \n");
						sbSql.append("				, NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n");
						sbSql.append("				, (SELECT NVL(SUM(D.APPLY_AMT),0) FROM SLA_ADVANCE_ALT_DETAIL D WHERE D.RECD_STATUS  = 'L' \n");
						sbSql.append("								  																			 AND D.ALT_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "'	 \n"); // ���� : �԰����� 
						sbSql.append("								  																			 AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n");
						sbSql.append("       FROM SLA_ADVANCE_MST M  \n");
						sbSql.append("									   INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'N'  \n");
						// ------ ���� : ��뿩��
						if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
						sbSql.append("								  										     AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
						// ------ ���� : �������
						if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							sbSql.append("																		 AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
						sbSql.append("								  											 AND M.UPJANG_CD = B.UPJANG \n");
						// ------ ���� : �����ڵ�
						if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
						{
							sbSql.append("									INNER JOIN ST_UPJANG Y ON M.UPJANG_CD = Y.UPJANG \n");
							sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
						}		
						sbSql.append("		WHERE M.SYS_CLASS IN ('13', '14') \n");
						sbSql.append("		AND    M.RECD_STATUS = 'L' \n");
						sbSql.append("		AND    M.OCCUR_DATE <= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' \n");	// ���� : �԰����� 
						sbSql.append("        ) S \n");
						sbSql.append("   GROUP BY S.UPJANG \n");
						//sbSql.append("	HAVING  SUM(NVL(S.OCCUR_AMT,0) - NVL(S.APPLY_AMT,0)) > 0	\n"); // �����ܾ��� �ִ� �ڷ� ���� 
						sbSql.append("	) C1	\n"); 
		sbSql.append("        ON A.UPJANG = C1.UPJANG \n");


		//----------------------------------------------------------
		// D.��� �̸��⸶���� �˼��ݾ� : �������
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
						sbSql.append("       --D.��� �̸��⸶���� �˼��ݾ� \n");
						sbSql.append("      (SELECT X.UPJANG \n");
						sbSql.append("				, SUM(X.TR_AMT) AS TR_AMT \n");
						sbSql.append("        FROM   \n");
						sbSql.append("				(  \n");
						//sbSql.append("			  /* D1. �����������(FMS_SALES) �� ����ȸ�� ������ �ڷ� : �ΰ��� ���� */  \n");
						//sbSql.append("               SELECT B.UPJANG \n"); 
						//sbSql.append("						, SUM(NVL(A.SAL_AMT,0)) AS TR_AMT \n");
						//sbSql.append("				FROM FMS_SALES A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'N'  \n");
						//// ------ ���� : ��뿩��
						//if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
						//sbSql.append("								  												   AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
						//// ------ ���� : �������
						//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
						//	sbSql.append("																			   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
						//sbSql.append("								  												   AND A.UPJANG = B.UPJANG \n");
						//// ------ ���� : �����ڵ�
						//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
						//{
						//	sbSql.append("										INNER JOIN ST_UPJANG Y ON A.UPJANG = Y.UPJANG \n");
						//	sbSql.append("										INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
						//	sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
						//}		
						//sbSql.append("				WHERE A.SALE_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
						//sbSql.append("				AND    A.TRANS_YN = 'N'	 \n");	// ����ȸ�� �����۰� 
						//sbSql.append("				GROUP BY B.UPJANG \n");

						//sbSql.append("				UNION ALL \n");

						sbSql.append("			  /* D2. �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */  \n");
						sbSql.append("               SELECT B.UPJANG \n"); 
						//sbSql.append("						, SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS TR_AMT \n");
						sbSql.append("						, SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
						sbSql.append("				FROM FMS_TRANSACTION_V A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'N'  \n");
						// ------ ���� : ��뿩��
						if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
						sbSql.append("								  																  AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
						// ------ ���� : �������
						if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							sbSql.append("																							  AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
						sbSql.append("								  																  AND A.TRANS_UPJANG = B.UPJANG \n");
						// ------ ���� : �����ڵ�
						if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
						{
							sbSql.append("														INNER JOIN ST_UPJANG Y ON A.TRANS_UPJANG = Y.UPJANG \n");
							sbSql.append("														INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
						}		
						sbSql.append("															LEFT JOIN (  \n");
						sbSql.append("																			SELECT  \n");
						sbSql.append("					  															UPJANG \n");
						sbSql.append("																			 ,  MAX(SALE_DATE) AS SALE_DATE \n");
						sbSql.append("																			FROM   FMS_SALES \n");
						sbSql.append("																			WHERE  SALE_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
						sbSql.append("				 															AND     TRANS_YN = 'Y' \n");		// ����ȸ�� ���� ����
						sbSql.append("				 															GROUP BY UPJANG \n");
						sbSql.append("																			) C ON A.TRANS_UPJANG = C.UPJANG \n");
						sbSql.append("				WHERE    A.MG_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
						// ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ����
						//sbSql.append("				AND    A.TRANS_DATE >= GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(strDate) + "', 'YYYYMMDD'), -1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
						// ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� : 2015-10-27
						sbSql.append("				AND    A.MG_DATE >= DECODE(C.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE('" + nullToBlank(strDate) + "', 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
						sbSql.append("				AND    (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))  \n");
						sbSql.append("				GROUP BY B.UPJANG \n");
						sbSql.append("				) X	 \n");
						sbSql.append("	GROUP BY X.UPJANG \n");
						sbSql.append("	) D	 \n");
		sbSql.append("        ON A.UPJANG = D.UPJANG \n");


		//----------------------------------------------------------
		// E.��� �̰˼� ���ֱݾ� 
		//----------------------------------------------------------
		// PW(��������), PC(���ֿϷ�), DL(�����) �� ����
		// CENTER_DELI_QTY(�����԰����), DIRECT_DELI_QTY(���ۼ���), DELIVERED_QTY(�����԰����-�������), UNDELIVERED_QTY(���͹��԰����) 
		sbSql.append("       LEFT JOIN \n");
						sbSql.append("       --E.��� �̰˼� ���ֱݾ� \n");
						sbSql.append("      (SELECT \n");
						sbSql.append("              B.UPJANG \n");
						sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT  \n");
						sbSql.append("		FROM HLDC_PO_PO A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'N'  \n");
						// ------ ���� : ��뿩��
						if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
						sbSql.append("								  										   AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
						// ------ ���� : �������
						if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							sbSql.append("																	   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
						sbSql.append("						  												   AND A.RC_UPJANG = B.UPJANG \n");
						// ------ ���� : �����ڵ�
						if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
						{
							sbSql.append("									INNER JOIN ST_UPJANG Y ON A.RC_UPJANG = Y.UPJANG \n");
							sbSql.append("									INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							sbSql.append("																						    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
						}		
						sbSql.append("		WHERE A.NEED_DATE <= '" + nullToBlank(strDate) + "'	\n"); // ���� : ��������
						sbSql.append("		AND     A.LINE_STATUS IN ('PW', 'PC', 'DL') \n");
						sbSql.append("        GROUP BY B.UPJANG) E \n");
		sbSql.append("        ON A.UPJANG = E.UPJANG \n");


		//----------------------------------------------------------
		// F.��� �̹��� �ֹ��ݾ�  
		//----------------------------------------------------------
		sbSql.append("       LEFT JOIN \n");
						sbSql.append("       --F.��� �̹��� �ֹ��ݾ� \n");
						sbSql.append("      (SELECT \n");
						sbSql.append("              B.UPJANG \n");
						sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
						sbSql.append("		FROM SO_PR A INNER JOIN FMS_UPJANG B  ON B.HEAD_CREDIT_YN = 'N'  \n");
						// ------ ���� : ��뿩��
						if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
						sbSql.append("								  									AND B.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
						// ------ ���� : �������
						if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
							sbSql.append("																AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
						sbSql.append("						  											AND A.RC_UPJANG = B.UPJANG \n");
						// ------ ���� : �����ڵ�
						if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))				
						{
							sbSql.append("							INNER JOIN ST_UPJANG Y ON A.RC_UPJANG = Y.UPJANG \n");
							sbSql.append("							INNER JOIN HLDC_PO_UPJANG_CENTER X ON X.CENTER_CODE = '" + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + "' \n");
							sbSql.append("																				    AND Y.AP_UNITPRICE_UPJANG = X.UPJANG \n");
						}		
						sbSql.append("		WHERE A.NEED_DATE <= '" + nullToBlank(strDate) + "'	\n");  // ���� : �԰����� 
						sbSql.append("		AND    A.LINE_STATUS IN ('001') 	\n");		// ������� : 001(��û����) 
						sbSql.append("        GROUP BY B.UPJANG) F \n");
		sbSql.append("        ON A.UPJANG = F.UPJANG \n");
		
		sbSql.append("   WHERE A.HEAD_CREDIT_YN = 'N' \n");
		// ------ ���� : ��뿩��
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
		sbSql.append("   AND A.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");
		//sbSql.append("   AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		//sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
		//sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
			sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		
//out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListTmp = this.makeDataSet(rs, "ds_ListTmp");
		rs.close();
		pstmt.close();

		/**����**/
		out_dl.add(ds_ListTmp);
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
