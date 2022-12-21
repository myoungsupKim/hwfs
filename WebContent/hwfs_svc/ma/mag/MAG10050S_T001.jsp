ek.<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ��������/������ȸ
�� ���α׷�ID   : AMG10051S_T001.jsp
�� ���α׷���   : ����庰��������(��ȸ)
�� �ۼ�����     : 2008-02-25
�� �ۼ���       : Ȳ����
�� �̷°���     :                                                                                                                                                                             
: ������ 2012-05-22 CSR#(CH201205_00127) ��û��:������(FC��ȹ��)
	���� ��ȸ ���� : ī�̽�Ʈ����ȸ���� (113228), ī�̽�Ʈ�л��� (113229), �������Ǵ����� (104663), �������Ǵ�û�����(104729), �������Ǵ�������(104728)
	�����ڵ� MA0048 �� ���ܾ��� ����
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		
		//�Է� ����Ÿ
		DataSet ds_cond     = in_dl.get("ds_cond");
	
		//�Է� �Ķ����
	
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
	
	
		String str_in_OCCUR_DATE   = nullToBlank(ds_cond.getString(0, "OCCUR_DATE"));
		String str_in_MU_CD        = nullToBlank(ds_cond.getString(0, "MU_CD"));
		String str_in_TM_CD        = nullToBlank(ds_cond.getString(0, "TM_CD"));
		String str_in_UPJANG       = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String str_in_SUB_JOB_CD   = nullToBlank(ds_cond.getString(0, "SUB_JOB_CD"));
		String str_in_LOC_CD       = nullToBlank(ds_cond.getString(0, "LOC_CD"));
		String str_in_UNIT         = nullToBlank(ds_cond.getString(0, "UNIT"));
	
		String str_in_VAT_GUBUN    = nullToBlank(ds_cond.getString(0, "VAT_GUBUN"));
		String str_in_HOMEPLUS     = nullToBlank(ds_cond.getString(0, "HOMEPLUS"));
	
	
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//Master ��ȸ###########################################################################

		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		System.out.println("str_in_HOMEPLUS:" + str_in_HOMEPLUS);
		//������ȸ

		sbSql.append("    SELECT A.OCCUR_DATE, \n");
		sbSql.append("           DECODE(TO_CHAR(TO_DATE(A.OCCUR_DATE, 'YYYYMMDD'), 'dy', 'NLS_DATE_LANGUAGE=AMERICAN'), 'mon', '��', 'tue', 'ȭ', 'wed', '��', 'thu', '��', 'fri', '��', 'sat', '��', 'sun', '��') AS OCCUR_DAY, \n");
		if (!str_in_HOMEPLUS.equals("1")){
		sbSql.append("           B.UPJANG_CD, \n");
		}
		sbSql.append("           NVL(SUM(QTY), 0) QTY, \n");
		sbSql.append("           NVL(SUM(F_AMT), 0) F_AMT, \n");
		sbSql.append("           NVL(SUM(S_AMT), 0) S_AMT, \n");
		sbSql.append("           NVL(SUM(E_AMT), 0) E_AMT, \n");
		sbSql.append("           NVL(SUM(F_AMT), 0) + NVL(SUM(S_AMT), 0) + NVL(SUM(E_AMT), 0) TOT_AMT \n");
		sbSql.append("      FROM ( \n");
		sbSql.append("            SELECT '" + str_in_OCCUR_DATE + "'||DD OCCUR_DATE \n");
		sbSql.append("              FROM ( \n");
		sbSql.append("                    SELECT DECODE(LENGTH(ROWNUM), 1, '0')||ROWNUM DD \n");
		sbSql.append("                      FROM DICT A \n");
		sbSql.append("                      WHERE ROWNUM <= 31 \n");
		sbSql.append("                   ) A \n");
		sbSql.append("            WHERE A.DD <= TO_CHAR(LAST_DAY(TO_DATE('" + str_in_OCCUR_DATE + "'||'01', 'YYYYMMDD')), 'DD') \n");
		sbSql.append("           ) A, \n");
		sbSql.append("           ( \n");
		sbSql.append("            SELECT T2.UPJANG_CD, \n");

		
		if (str_in_VAT_GUBUN.equals("EXC_VAT")){

			if(str_in_MU_CD.equals("2002")){
				sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
				sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.NET_AMT ELSE 0 END)), \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.SAL_AMT ELSE 0 END)) ), 0) F_AMT, \n");
				sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.NET_AMT ELSE 0 END)), \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
				sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114','1901') THEN T2.NET_AMT ELSE 0 END)), \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114','1901') THEN T2.SAL_AMT ELSE 0 END)) ), 0) E_AMT, \n");
			}else if(str_in_MU_CD.equals("2003")){
				sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1204','1205','1209') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
				sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.NET_AMT ELSE 0 END)), \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.SAL_AMT ELSE 0 END)) ), 0) F_AMT, \n");
				sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.NET_AMT ELSE 0 END)), \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
				sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.NET_AMT ELSE 0 END)), \n");
				sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.SAL_AMT ELSE 0 END)) ), 0) E_AMT, \n");
			}
			
		}
		else {
		
			if(str_in_MU_CD.equals("2002")){
				sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
				sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.SAL_AMT ELSE 0 END)), 0) F_AMT, \n");
				sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.SAL_AMT ELSE 0 END)), 0) S_AMT, \n");
				sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114','1901') THEN T2.SAL_AMT ELSE 0 END)), 0) E_AMT, \n");
			}else if(str_in_MU_CD.equals("2003")){
				sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1204','1205','1209') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
				sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.SAL_AMT ELSE 0 END)), 0) F_AMT, \n");
				sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.SAL_AMT ELSE 0 END)), 0) S_AMT, \n");
				sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.SAL_AMT ELSE 0 END)), 0) E_AMT, \n");
			}
 
		}

		sbSql.append("                   T2.OCCUR_DATE \n");
		sbSql.append("              FROM SLA_IF_UPJANG_SALS_MST T1, \n");
		sbSql.append("                   SLA_IF_UPJANG_SALS_DETAIL T2, \n");
		sbSql.append("                   SCO_UPJANG_MST_V T3 \n");
		sbSql.append("            WHERE  T1.OCCUR_DATE = T2.OCCUR_DATE \n");
		sbSql.append("            AND	 T1.SYS_CLASS = T2.SYS_CLASS \n");
		sbSql.append("            AND	 T1.UPJANG_CD = T2.UPJANG_CD \n");
		sbSql.append("            AND	 T1.UPJANG_CD = T3.UPJANG \n");
		sbSql.append("            AND	 T1.RECEIPT_NUM =T2.RECEIPT_NUM \n");
		if(str_in_MU_CD.equals("2002")){
			sbSql.append("            AND    T2.SYS_CLASS IN (11,16,17,19,20) \n");
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("            AND    T2.SYS_CLASS IN (12,19,20,21) \n");
		}else if(str_in_MU_CD.equals("2004")){
			sbSql.append("            AND    T2.SYS_CLASS = 13 \n");
		}
		sbSql.append("            AND	 T2.DDDD_CLOSE_YN = 'Y' \n");
		sbSql.append("            AND    T2.OCCUR_DATE   BETWEEN '" + str_in_OCCUR_DATE + "'||'01' AND '" + str_in_OCCUR_DATE + "'||'31' \n");
		
		//============================================================================================
		//(2012-05-22 �߰�) ����
		//2012-05-22 CSR#(CH201205_00127) ��û��:������(FC��ȹ��)
		//���� ��ȸ ���� : ī�̽�Ʈ����ȸ���� (113228), ī�̽�Ʈ�л��� (113229), �������Ǵ����� (104663), �������Ǵ�û�����(104729), �������Ǵ�������(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND T3.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 �߰�) ��
		//============================================================================================

		if (!str_in_UPJANG.equals(""))  {
			if (!str_in_HOMEPLUS.equals("1")){
			sbSql.append("            AND   T2.UPJANG_CD      = " + str_in_UPJANG  + " \n");
			}
	     }
		
		if (str_in_HOMEPLUS.equals("1")){
			//sbSql.append("            AND   T2.UPJANG_CD     IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y' ) \n");
			sbSql.append("            AND   T3.UPJANG     IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y' AND SET1  = " + str_in_UPJANG  + " ) \n");
		}
		
		sbSql.append("            GROUP BY T2.UPJANG_CD, T2.OCCUR_DATE, T2.VAT_CLASS  \n");
		 

		
//***************************************************************�������*******************************************************************		
		
/* 		
		//ȣ�� �� 63 ���� ������ȸ 2010.07.26#######################################
		sbSql.append("    UNION ALL \n");		
		
		sbSql.append("            SELECT C.UPJANG, \n");
		sbSql.append("                   V.IF_DATE OCCUR_DATE, \n");
		sbSql.append("                   NVL(SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_QTY, 0)), 0) QTY, \n"); 

		//System.out.println("str_in_VAT_GUBUN:" + str_in_VAT_GUBUN);
		if (str_in_VAT_GUBUN.equals("EXC_VAT")){


			sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_AMOUNT,0)) F_AMT, \n");
			sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401023', V.SALE_AMOUNT,0)) S_AMT, \n");
			sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', 0, '401023', 0, V.SALE_AMOUNT)) E_AMT \n");
		}
		else {


			sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_AMOUNT + V.VAT_AMOUNT,0)) F_AMT, \n");
			sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401023', V.SALE_AMOUNT + V.VAT_AMOUNT,0)) S_AMT, \n");
			sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', 0, '401023', 0, V.SALE_AMOUNT + V.VAT_AMOUNT)) E_AMT \n");
		}

		sbSql.append("            FROM HLD3_IF_SC_GETSALE V, \n");
		sbSql.append("                 HLDC_SC_DEPT A, \n");		
		sbSql.append("                 SCO_UPJANG_MST_V C \n");
		sbSql.append("            WHERE (V.DEPT_ID = A.DEPT_ID)  \n");
		sbSql.append("            AND   (A.CC_CD   = C.CC_CD) \n");
		sbSql.append("            AND   (V.IF_DATE   BETWEEN '" + str_in_OCCUR_DATE + "'||'01' AND '" + str_in_OCCUR_DATE + "'||'31') \n");

		//============================================================================================
		//(2012-05-22 �߰�) ����
		//2012-05-22 CSR#(CH201205_00127) ��û��:������(FC��ȹ��)
		//���� ��ȸ ���� : ī�̽�Ʈ����ȸ���� (113228), ī�̽�Ʈ�л��� (113229), �������Ǵ����� (104663), �������Ǵ�û�����(104729), �������Ǵ�������(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND C.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 �߰�) ��
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}
		sbSql.append("            GROUP BY C.UPJANG, \n");
		sbSql.append("                     V.IF_DATE, \n");
		sbSql.append("                     V.TAX_CODE \n");		
		//ȣ�� �� 63 ���� ������ȸ 2010.07.26#######################################		
		
 */		
		sbSql.append("            ) B \n");
		sbSql.append("    WHERE A.OCCUR_DATE = B.OCCUR_DATE(+) \n");
		if (!str_in_HOMEPLUS.equals(1)){
		sbSql.append("    GROUP BY A.OCCUR_DATE, B.UPJANG_CD  \n");
		}
		sbSql.append("    ORDER BY A.OCCUR_DATE \n");




        //out_vl.add("fa_Sql", sbSql.toString());

        //System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 
		

		ds_list = this.makeDataSet(rs, "ds_list");

		rs.close();
		stmt.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**����**/
		out_dl.add(ds_list);



		//Detail1 ��ȸ###########################################################################
		//out ����Ÿ
		DataSet ds_listDetail1;
		//sql�� ���ۻ���
		sbSql.delete(0,sbSql.length());

		//������ȸ

		sbSql.append("    SELECT  \n");
		                       if (!str_in_HOMEPLUS.equals("1")){ 
		                    	   sbSql.append("   UPJANG_CD, \n");
		                       }
		if(str_in_MU_CD.equals("2002")){
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1103_310_QTY, \n");//�����ķ�����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1103_410_QTY, \n");//�����ķ�鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1104_310_QTY, \n");//������������ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1104_410_QTY, \n");//��������鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1603_310_QTY, \n");//��ʽķ�����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1603_410_QTY, \n");//��ʽķ�鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1101_310_QTY, \n");//��ǰ�Ϲݰ����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1101_410_QTY, \n");//��ǰ�Ϲݸ鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1102_310_QTY, \n");//��ǰ���۰����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1102_410_QTY, \n");//��ǰ���۸鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1602_310_QTY, \n");//��ʸ��������ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1602_410_QTY, \n");//��ʸ����鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1701_310_QTY, \n");//Ư�ǰ����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1701_410_QTY, \n");//Ư�Ǹ鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1105_310_QTY, \n");//�Ӵ�����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1105_410_QTY, \n");//�Ӵ�鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1106_310_QTY, \n");//��Ÿ�����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1106_410_QTY, \n");//��Ÿ�鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1901_310_QTY, \n");//���������ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1901_410_QTY, \n");//�����鼼�ļ�
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1204') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1103_310_QTY, \n");//�����ķ�����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1204') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1103_410_QTY, \n");//�����ķ�鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1205') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1104_310_QTY, \n");//������������ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1205') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1104_410_QTY, \n");//��������鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1201','1203','1209') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1101_310_QTY, \n");//��ǰ�Ϲݰ����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1201','1203','1209') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1101_410_QTY, \n");//��ǰ�Ϲݸ鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1102_310_QTY, \n");//��ǰ���������ļ�	: 2015.10.23 ������ �߰��� ���� ''ó��
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1102_410_QTY, \n");//��ǰ�����鼼�ļ�	: 2015.10.23 ������ �߰��� ���� ''ó��
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1902_310_QTY, \n");//��ǰ���������ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1902_410_QTY, \n");//��ǰ�����鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1701_310_QTY, \n");//��ǰ�ްԼҰ����ļ�  : 2015.10.23 �������� �߰��� ���� ''ó��
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1701_410_QTY, \n");//��ǰ�ްԼҸ鼼�ļ� : 2015.10.23 �������� �߰��� ���� ''ó�� 
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1801_310_QTY, \n");//��ǰ�ްԼҰ����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1801_410_QTY, \n");//��ǰ�ްԼҸ鼼�ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1206') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1105_310_QTY, \n");//��Ÿ�����ļ�
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1206') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1105_410_QTY, \n");//��Ÿ�鼼�ļ�
		}
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN QTY ELSE 0 END)), 0) TOT_310_QTY, \n");//�����ļ��Ұ�
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) TOT_410_QTY, \n");//�鼼�ļ��Ұ�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS = '20' THEN F_AMT ELSE 0 END)), 0) F1103_310_AMT, \n");//�����ķ�������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS <> '20' THEN F_AMT ELSE 0 END)), 0) F1103_410_AMT, \n");//�����ķ�鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109','1205') AND VAT_CLASS = '20' THEN F_AMT ELSE 0 END)), 0) F1104_310_AMT, \n");//��������������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109','1205') AND VAT_CLASS <> '20' THEN F_AMT ELSE 0 END)), 0) F1104_410_AMT, \n");//��������鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN F_AMT ELSE 0 END)), 0) F1603_310_AMT, \n");//��ʽķ�������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS <> '20' THEN F_AMT ELSE 0 END)), 0) F1603_410_AMT, \n");//��ʽķ�鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1203','1209') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1101_310_AMT, \n");//��ǰ�Ϲݰ������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1203','1209') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1101_410_AMT, \n");//��ǰ�Ϲݸ鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1801_310_AMT, \n");//������ ����		: 2015.10.23 �߰�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1801_410_AMT, \n");//������ �鼼		: 2015.10.23 �߰�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1102_310_AMT, \n");//��ǰ���۰������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1102_410_AMT, \n");//��ǰ���۸鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1902_310_AMT, \n");//��������		: 2015.10.23 �߰�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1902_410_AMT, \n");//�����鼼	: 2015.10.23 �߰�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1602_310_AMT, \n");//��ʸ����������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1602_410_AMT, \n");//��ʸ����鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1701_310_AMT, \n");//Ư�ǰ������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1701_410_AMT, \n");//Ư�Ǹ鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112','1206') AND VAT_CLASS = '20' THEN E_AMT ELSE 0 END)), 0) E1105_310_AMT, \n");//�Ӵ�������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112','1206') AND VAT_CLASS <> '20' THEN E_AMT ELSE 0 END)), 0) E1105_410_AMT, \n");//�Ӵ�鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS = '20' THEN E_AMT ELSE 0 END)), 0) E1106_310_AMT, \n");//��Ÿ�������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS <> '20' THEN E_AMT ELSE 0 END)), 0) E1106_410_AMT, \n");//��Ÿ�鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN E_AMT ELSE 0 END)), 0) E1901_310_AMT, \n");//�����������ް�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS <> '20' THEN E_AMT ELSE 0 END)), 0) E1901_410_AMT, \n");//�����鼼���ް�
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN F_AMT + S_AMT + E_AMT ELSE 0 END)), 0) TOT_310_AMT, \n");//�������ް��Ұ�
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS <> '20' THEN  F_AMT + S_AMT + E_AMT ELSE 0 END)), 0) TOT_410_AMT, \n");//�鼼���ް��Ұ�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) ELSE 0 END)), 0) F1103_310_VAT,\n");//�����ķ�ΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109','1205') AND VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) ELSE 0 END)), 0) F1104_310_VAT,\n");//��������ΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) ELSE 0 END)), 0) F1603_310_VAT,\n");//��ʽķ�ΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1209') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1101_310_VAT, \n");//��ǰ�Ϲݺΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1801_310_VAT, \n");//�ްԼ� �ΰ��� : 2015.10.23 �߰�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1102_310_VAT, \n");//��ǰ���ۺΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1902_310_VAT, \n");//���� �ΰ��� : 2015.10.23 �߰�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1602_310_VAT, \n");//��ʽ��ۺΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1701_310_VAT, \n");//Ư�Ǻΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS = '20' THEN (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) E1105_310_VAT, \n");//�Ӵ�ΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113') AND VAT_CLASS = '20' THEN (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) E1106_310_VAT, \n");//��Ÿ�ΰ���
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) E1901_310_VAT, \n");//�����ΰ���
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) + (S_AMT_TOT - S_AMT) + (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) TOT_310_VAT, \n");//�ΰ����Ұ�
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS = '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1103_310_TOT, \n");//�����ķ��������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1205') AND VAT_CLASS <> '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1103_410_TOT, \n");//�����ķ�鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS = '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1104_310_TOT, \n");//���������������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS <> '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1104_410_TOT, \n");//��������鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1603_310_TOT, \n");//��ʽķ��������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS <> '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1603_410_TOT, \n");//��ʽķ�鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1209') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1101_310_TOT, \n");//��ǰ�Ϲݰ�������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1209') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1101_410_TOT, \n");//��ǰ�Ϲݸ鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1801_310_TOT, \n");//�ްԼҰ�������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1801_410_TOT, \n");//�ްԼҰ�������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1902_310_TOT, \n");//������������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1902_410_TOT, \n");//������������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1102_310_TOT, \n");//��ǰ���۰�������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1102_410_TOT, \n");//��ǰ���۸鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1602_310_TOT, \n");//��ʽ��۰�������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1602_410_TOT, \n");//��ʽ��۸鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1701_310_TOT, \n");//Ư�ǰ�������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1701_410_TOT, \n");//Ư�Ǹ鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS = '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1105_310_TOT, \n");//�Ӵ��������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS <> '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1105_410_TOT, \n");//�Ӵ�鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS = '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1106_310_TOT, \n");//��Ÿ��������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS <> '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1106_410_TOT, \n");//��Ÿ�鼼����
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1901_310_TOT, \n");//������������
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS <> '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1901_410_TOT, \n");//�����鼼����
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN F_AMT_TOT + S_AMT_TOT + E_AMT_TOT ELSE 0 END)), 0) TOT_310_TOT, \n");//��������Ұ�
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS <> '20' THEN F_AMT_TOT + S_AMT_TOT + E_AMT_TOT ELSE 0 END)), 0) TOT_410_TOT \n");//�鼼����Ұ�
		sbSql.append("      FROM ( \n");
		sbSql.append("            SELECT T2.UPJANG_CD, \n");
		sbSql.append("                   T2.SALS_CLASS, \n");
		if(str_in_MU_CD.equals("2002")){
			sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.SAL_AMT ELSE 0 END)) ), 0) F_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114') THEN T2.SAL_AMT ELSE 0 END)) ), 0) E_AMT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.SAL_AMT ELSE 0 END)), 0)  F_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.SAL_AMT ELSE 0 END)), 0) S_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114') THEN T2.SAL_AMT ELSE 0 END)), 0) E_AMT_TOT, \n");
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1204','1205','1203','1201','1202','1209') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.SAL_AMT ELSE 0 END)) ), 0) F_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.SAL_AMT ELSE 0 END)) ), 0) E_AMT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.SAL_AMT ELSE 0 END)), 0)  F_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.SAL_AMT ELSE 0 END)), 0) S_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.SAL_AMT ELSE 0 END)), 0) E_AMT_TOT, \n");
		}
		sbSql.append("                   T2.VAT_CLASS \n");
		sbSql.append("              FROM SLA_IF_UPJANG_SALS_MST T1, \n");
		sbSql.append("                   SLA_IF_UPJANG_SALS_DETAIL T2, \n");
		sbSql.append("                   SCO_UPJANG_MST_V T3 \n");
		sbSql.append("            WHERE  T1.OCCUR_DATE = T2.OCCUR_DATE \n");
		sbSql.append("            AND	 T1.SYS_CLASS = T2.SYS_CLASS \n");
		sbSql.append("            AND	 T1.UPJANG_CD = T2.UPJANG_CD \n");
		sbSql.append("            AND	 T1.UPJANG_CD = T3.UPJANG \n");
		sbSql.append("            AND	 T1.RECEIPT_NUM =T2.RECEIPT_NUM \n");
		if(str_in_MU_CD.equals("2002")){
			sbSql.append("            AND    T2.SYS_CLASS IN (11,16,17,19,20) \n");
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("            AND    T2.SYS_CLASS IN (12,19,20,21) \n");
		}else if(str_in_MU_CD.equals("2004")){
			sbSql.append("            AND    T2.SYS_CLASS = 13 \n");
		}
		sbSql.append("            AND	 T2.DDDD_CLOSE_YN = 'Y' \n");
		sbSql.append("            AND    T2.OCCUR_DATE   BETWEEN '" + str_in_OCCUR_DATE + "'||'01' AND '" + str_in_OCCUR_DATE + "'||'31' \n");
		
		//============================================================================================
		//(2012-05-22 �߰�) ����
		//2012-05-22 CSR#(CH201205_00127) ��û��:������(FC��ȹ��)
		//���� ��ȸ ���� : ī�̽�Ʈ����ȸ���� (113228), ī�̽�Ʈ�л��� (113229), �������Ǵ����� (104663), �������Ǵ�û�����(104729), �������Ǵ�������(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		 sbSql.append("            AND T3.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 �߰�) ��
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			if (!str_in_HOMEPLUS.equals("1")){
			sbSql.append("            AND   T2.UPJANG_CD      = " + str_in_UPJANG  + " \n");
			 }
		}
		
		if (str_in_HOMEPLUS.equals("1")){
			//sbSql.append("            AND   T2.UPJANG_CD      IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y'  )  \n");
			sbSql.append("            AND   T3.UPJANG      IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y' AND SET1 =  " + str_in_UPJANG  + "   )  \n");
		}
		
		
		sbSql.append("            GROUP BY T2.UPJANG_CD, T2.SALS_CLASS, T2.VAT_CLASS \n");
		sbSql.append("            ) V \n");
		

		if (!str_in_HOMEPLUS.equals("1")){	
		sbSql.append("       GROUP BY UPJANG_CD \n");
		}

/* 
		//ȣ�� �� 63 ���� ������ȸ 2010.07.26#######################################
		sbSql.append("    UNION ALL \n");
		
		sbSql.append("    SELECT UPJANG, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '����������' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '����������' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) F_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��ǰ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��ǰ����' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) S_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��Ÿ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��Ÿ����' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) E_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '����������' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              F_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '����������' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              F_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��ǰ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              S_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��ǰ����' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              S_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��Ÿ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��Ÿ����' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) E_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND = '310' THEN \n");
		sbSql.append("                              F_AMT + S_AMT + E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND <> '310' THEN \n");
		sbSql.append("                              F_AMT + S_AMT + E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '����������' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              (F_AMT_TOT - F_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��ǰ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              (S_AMT_TOT - S_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��Ÿ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              (E_AMT_TOT - E_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND = '310' THEN \n");
		sbSql.append("                              (F_AMT_TOT - F_AMT) + (S_AMT_TOT - S_AMT) + (E_AMT_TOT - E_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '����������' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              F_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '����������' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              F_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_410_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��ǰ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              S_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��ǰ����' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              S_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_410_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��Ÿ����' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              E_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '��Ÿ����' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              E_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) E_410_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND = '310' THEN \n");
		sbSql.append("                              F_AMT_TOT + S_AMT_TOT + E_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_310_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND <> '310' THEN \n");
		sbSql.append("                              F_AMT_TOT + S_AMT_TOT + E_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_410_TOT \n");
		sbSql.append("      FROM ( \n");
		sbSql.append("            SELECT C.UPJANG, \n");
		sbSql.append("                   DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', '����������', '401023', '��ǰ����', '��Ÿ����')  ACCT_NAME, \n");
		sbSql.append("                   DECODE(V.TAX_CODE, '100', '310', '210', '410', '220', '350') TAX_KIND, \n");
  	sbSql.append("                   NVL(SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_QTY, 0)), 0) QTY, \n"); 
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_AMOUNT,0)) F_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401023', V.SALE_AMOUNT,0)) S_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', 0, '401023', 0, V.SALE_AMOUNT)) E_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_AMOUNT + V.VAT_AMOUNT,0)) F_AMT_TOT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401023', V.SALE_AMOUNT + V.VAT_AMOUNT,0)) S_AMT_TOT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', 0, '401023', 0, V.SALE_AMOUNT + V.VAT_AMOUNT)) E_AMT_TOT \n");  	
		sbSql.append("            FROM HLD3_IF_SC_GETSALE V, \n");
		sbSql.append("                 HLDC_SC_DEPT A, \n");		
		sbSql.append("                 SCO_UPJANG_MST_V C \n");
		sbSql.append("            WHERE (V.DEPT_ID = A.DEPT_ID)  \n");
		sbSql.append("            AND   (A.CC_CD   = C.CC_CD) \n");
		sbSql.append("            AND   (V.IF_DATE   BETWEEN '" + str_in_OCCUR_DATE + "'||'01' AND '" + str_in_OCCUR_DATE + "'||'31') \n");
		
		//============================================================================================
		//(2012-05-22 �߰�) ����
		//2012-05-22 CSR#(CH201205_00127) ��û��:������(FC��ȹ��)
		//���� ��ȸ ���� : ī�̽�Ʈ����ȸ���� (113228), ī�̽�Ʈ�л��� (113229), �������Ǵ����� (104663), �������Ǵ�û�����(104729), �������Ǵ�������(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND C.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 �߰�) ��
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}
		sbSql.append("            GROUP BY C.UPJANG, \n");
		sbSql.append("                     DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', '����������', '401023', '��ǰ����', '��Ÿ����'), \n");
		sbSql.append("                     DECODE(V.TAX_CODE, '100', '310', '210', '410', '220', '350') \n");
		sbSql.append("            ) V \n");
		sbSql.append("       GROUP BY UPJANG \n");
		//ȣ�� �� 63 ���� ������ȸ 2010.07.26#######################################
 */		
		
        //out_vl.add("fa_Sql", sbSql.toString());

        //System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 		
		

		ds_listDetail1 = this.makeDataSet(rs, "ds_listDetail1");

		
		rs.close();
		stmt.close();
		
		//FileLog.println("d:\\aab.txt", ds_listDetail1);

		/**����**/
		out_dl.add(ds_listDetail1);


		//Detail2 ��ȸ###########################################################################
		//out ����Ÿ
		DataSet ds_listDetail2;
		//sql�� ���ۻ���
		sbSql.delete(0,sbSql.length());

		//������ȸ

		sbSql.append("    SELECT  \n");
		if (!str_in_HOMEPLUS.equals("1")){
		sbSql.append("           V.UPJANG_CD, V.UPJANGNM, \n");
		sbSql.append("           V.SUBINV_CODE , \n");
		}
		//sbSql.append("           (SELECT SUBINV_NAME FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = V.SUBINV_CODE) SUBINV_CODENM, \n");
		sbSql.append("           SUBINV_NAME SUBINV_CODENM, \n");
		sbSql.append("           NVL(SUM(V.QTY), 0)                   QTY, \n");
		sbSql.append("           NVL(SUM(V.F_AMT), 0) + NVL(SUM(V.S_AMT), 0) + NVL(SUM(V.E_AMT), 0) AMT, \n");
		sbSql.append("           NVL(SUM((V.F_AMT_TOT - V.F_AMT)), 0) + NVL(SUM((V.S_AMT_TOT - V.S_AMT)), 0) +  NVL(SUM((V.E_AMT_TOT - V.E_AMT)), 0) VAT, \n");
		sbSql.append("           NVL(SUM(V.F_AMT_TOT), 0) + NVL(SUM(V.S_AMT_TOT), 0) + NVL(SUM(V.E_AMT_TOT), 0) AMT_TOT \n");
		sbSql.append("      FROM ( \n");
		sbSql.append("            SELECT T2.UPJANG_CD, \n");
		sbSql.append("                   T3.UPJANGNM, \n");
		//sbSql.append("                   T1.POS_NUM SUBINV_CODE, \n");
		//���������� â���ڵ带 DETAIL���� �����;���(�����ۺ��� â���ڵ尡 �ٸ� �� ����) 2016.08.24 ��ȣ�� ����
		sbSql.append("                   CASE WHEN T1.SYS_CLASS = '20' THEN T2.WH_NUM ELSE  T1.POS_NUM END AS SUBINV_CODE, \n");
		sbSql.append("                   (SELECT SUBINV_NAME FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE  =CASE WHEN T1.SYS_CLASS = '20' THEN T2.WH_NUM ELSE  T1.POS_NUM END ) AS SUBINV_NAME, \n");
	  //sbSql.append("                   (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE (GROUP_CODE = 'MA0105') AND (CODE = V.TAX_KIND)) TAX_KINDNM, \n");
		if(str_in_MU_CD.equals("2002")){
			sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.SAL_AMT ELSE 0 END)) ), 0) F_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114') THEN T2.SAL_AMT ELSE 0 END)) ), 0) E_AMT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.SAL_AMT ELSE 0 END)), 0)  F_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.SAL_AMT ELSE 0 END)), 0) S_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114') THEN T2.SAL_AMT ELSE 0 END)), 0) E_AMT_TOT, \n");
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1204','1205','1209') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.SAL_AMT ELSE 0 END)) ), 0) F_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.SAL_AMT ELSE 0 END)) ), 0) E_AMT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1204','1205') THEN T2.SAL_AMT ELSE 0 END)), 0)  F_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.SAL_AMT ELSE 0 END)), 0) S_AMT_TOT, \n");
			sbSql.append("                   NVL(SUM((CASE WHEN SALS_CLASS IN ('1206') THEN T2.SAL_AMT ELSE 0 END)), 0) E_AMT_TOT, \n");
		}
		sbSql.append("                   T2.VAT_CLASS \n");
		sbSql.append("              FROM SLA_IF_UPJANG_SALS_MST T1, \n");
		sbSql.append("                   SLA_IF_UPJANG_SALS_DETAIL T2, \n");
		sbSql.append("                   SCO_UPJANG_MST_V T3 \n");
		sbSql.append("            WHERE  T1.OCCUR_DATE = T2.OCCUR_DATE \n");
		sbSql.append("            AND	 T1.SYS_CLASS = T2.SYS_CLASS \n");
		sbSql.append("            AND	 T1.UPJANG_CD = T2.UPJANG_CD \n");
		sbSql.append("            AND	 T1.UPJANG_CD = T3.UPJANG \n");
		sbSql.append("            AND	 T1.RECEIPT_NUM =T2.RECEIPT_NUM \n");
		if(str_in_MU_CD.equals("2002")){
			sbSql.append("            AND    T2.SYS_CLASS IN (11,16,17,19,20) \n");
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("            AND    T2.SYS_CLASS IN (12,19,20,21) \n");
		}
		sbSql.append("            AND	 T2.DDDD_CLOSE_YN = 'Y' \n");
		sbSql.append("            AND    T2.OCCUR_DATE   BETWEEN '" + str_in_OCCUR_DATE + "'||'01' AND '" + str_in_OCCUR_DATE + "'||'31' \n");
		
		//============================================================================================
		//(2012-05-22 �߰�) ����
		//2012-05-22 CSR#(CH201205_00127) ��û��:������(FC��ȹ��)
		//���� ��ȸ ���� : ī�̽�Ʈ����ȸ���� (113228), ī�̽�Ʈ�л��� (113229), �������Ǵ����� (104663), �������Ǵ�û�����(104729), �������Ǵ�������(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		  sbSql.append("            AND T3.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 �߰�) ��
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			if (!str_in_HOMEPLUS.equals("1")){
			sbSql.append("            AND   T2.UPJANG_CD      = " + str_in_UPJANG  + " \n");
			}
		}
		
 		if (str_in_HOMEPLUS.equals("1")){
		//sbSql.append("            AND   T2.UPJANG_CD      IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y'  )  \n");
 			sbSql.append("            AND   T3.UPJANG      IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y' AND SET1 =  " + str_in_UPJANG  + "  )  \n");
	    
 		}	
 		
		sbSql.append("            GROUP BY T2.UPJANG_CD, T3.UPJANGNM, T1.POS_NUM, T2.VAT_CLASS, T1.SYS_CLASS, T2.WH_NUM \n");
		sbSql.append("            ) V \n");
		
		if (str_in_HOMEPLUS.equals("1")){	
			sbSql.append("     GROUP BY  V.SUBINV_NAME \n");
		}
		else if(!str_in_HOMEPLUS.equals("1")) {
		sbSql.append("     GROUP BY V.UPJANG_CD, V.UPJANGNM, V.SUBINV_CODE ,SUBINV_NAME\n");
		}

/* 
		//ȣ�� �� 63 ���� ������ȸ 2010.07.26#######################################
		sbSql.append("    UNION ALL \n");		
				
		sbSql.append("    SELECT V.UPJANG, \n");
		sbSql.append("           (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = V.UPJANG) UPJANGNM, \n");
		sbSql.append("           V.SUBINV_CODE, \n");
		sbSql.append("           (SELECT SUBINV_NAME FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = V.SUBINV_CODE) SUBINV_CODENM, \n");
		sbSql.append("           NVL(SUM(V.QTY), 0)                   QTY, \n");
		sbSql.append("           NVL(SUM(V.F_AMT), 0) + NVL(SUM(V.S_AMT), 0) + NVL(SUM(V.E_AMT), 0) AMT, \n");
		sbSql.append("           NVL(SUM((V.F_AMT_TOT - V.F_AMT)), 0) + NVL(SUM((V.S_AMT_TOT - V.S_AMT)), 0) +  NVL(SUM((V.E_AMT_TOT - V.E_AMT)), 0) VAT, \n");
		sbSql.append("           NVL(SUM(V.F_AMT_TOT), 0) + NVL(SUM(V.S_AMT_TOT), 0) + NVL(SUM(V.E_AMT_TOT), 0) AMT_TOT \n");
		sbSql.append("      FROM ( \n");
		sbSql.append("            SELECT C.UPJANG, \n");
		sbSql.append("                   '' SUBINV_CODE, \n");
		sbSql.append("                   V.TAX_CODE TAX_KIND, \n");
		sbSql.append("                   DECODE(V.TAX_CODE, '100', '����', '210', '�鼼', '220', '����') TAX_KINDNM, \n");
		sbSql.append("                   NVL(SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_QTY, 0)), 0) QTY, \n"); 
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_AMOUNT,0)) F_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401023', V.SALE_AMOUNT,0)) S_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', 0, '401023', 0, V.SALE_AMOUNT)) E_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_AMOUNT + V.VAT_AMOUNT,0)) F_AMT_TOT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401023', V.SALE_AMOUNT + V.VAT_AMOUNT,0)) S_AMT_TOT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', 0, '401023', 0, V.SALE_AMOUNT + V.VAT_AMOUNT)) E_AMT_TOT \n");  	
		sbSql.append("            FROM HLD3_IF_SC_GETSALE V, \n");
		sbSql.append("                 HLDC_SC_DEPT A, \n");		
		sbSql.append("                 SCO_UPJANG_MST_V C \n");
		sbSql.append("            WHERE (V.DEPT_ID = A.DEPT_ID)  \n");
		sbSql.append("            AND   (A.CC_CD   = C.CC_CD) \n");
		sbSql.append("            AND   (V.IF_DATE   BETWEEN '" + str_in_OCCUR_DATE + "'||'01' AND '" + str_in_OCCUR_DATE + "'||'31') \n");
		
		//============================================================================================
		//(2012-05-22 �߰�) ����
		//2012-05-22 CSR#(CH201205_00127) ��û��:������(FC��ȹ��)
		//���� ��ȸ ���� : ī�̽�Ʈ����ȸ���� (113228), ī�̽�Ʈ�л��� (113229), �������Ǵ����� (104663), �������Ǵ�û�����(104729), �������Ǵ�������(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND C.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 �߰�) ��
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}
		sbSql.append("            GROUP BY C.UPJANG, \n");
		sbSql.append("                     V.TAX_CODE \n");
		sbSql.append("            ) V \n");
		sbSql.append("     GROUP BY V.UPJANG, \n");
		sbSql.append("              V.SUBINV_CODE \n");
		//ȣ�� �� 63 ���� ������ȸ 2010.07.26#######################################		
 */		
        //out_vl.add("fa_Sql", sbSql.toString());

        //System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 		

		ds_listDetail2 = this.makeDataSet(rs, "ds_listDetail2");

		//FileLog.println("d:\\aac.txt", ds_listDetail2);
		
		rs.close();
		stmt.close();		

		/**����**/
		out_dl.add(ds_listDetail2);



		this.setResultMessage(0, "OK", out_vl);

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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>