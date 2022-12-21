<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�޽�ä�ǰ���
�� ���α׷�ID   : FMO00530V_T002.jsp
�� ���α׷���   : �Ա� �� ������Ȳ��ȸ(���Ϻ���)
�� �ۼ�����     : 2008.02.20
�� �ۼ���       : ������
�� �̷°���     : 2008.02.20
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
		String sUseYn       = nullToBlank(ds_Cond.getString(0, "USE_YN"));
		
		System.out.println("sUseYn : " + sUseYn);

		//����(����or����)���� ������ �߰���, or �����̹Ƿ� ������ ó���ؾ���
		String g_flag = "";
		if (!ds_Cond.getString(0, "UPJANG").equals("0"))
			g_flag = "u";		// ����� ����
		else
			g_flag = "m";		// ���� ����
		
		//out ����Ÿ
		DataSet ds_List, ds_ListTmp;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//����������� IN�������� �����.
		String sUpjangList = ""; 
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
		sbSql.append(" WHERE 1=1 \n");
		if  (g_flag.equals("u")) {
			sbSql.append(" AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		} else  {
			sbSql.append(" AND MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		}
		if (!sUseYn.equals(""))
		{
			sbSql.append(" AND USE_YN = '"+sUseYn+"' \n");
		}
		
		//sbSql.append("   AND HEAD_CREDIT_YN = 'Y' \n");
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		while (rs.next())
		{
			sUpjangList += ", " + rs.getString("UPJANG");
		}
		if (sUpjangList.equals(""))
			sUpjangList = "(NULL)";
		else
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
		rs.close();
		pstmt.close();
		
		//���� ���� ���� ��� ����üũ�� ���� �������� ��ȸ
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       NVL(MAX(NEED_DATE), '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') AS NEED_DATE \n");
		sbSql.append("  FROM SO_PR \n");
		sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND NEED_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND LINE_STATUS NOT IN('003', '005', '999') --��û���,���ǹݷ� \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
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
		
		//�������� ���峻����ȸ(�ӵ������ ����� �������� �ʴ´�.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* FMO00530V_T002_1.jsp */ \n");
		sbSql.append("SELECT A1.MAIN_UPJANG, DECODE(A1.MAIN_UPJANG,A1.UPJANG,'0','1') AS BON_GB \n");
		sbSql.append("     , A1.UPJANG \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NULL,' - ')||A1.UPJANGNM_DISP AS UPJANGNM_DISP \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END)) AS AMT1 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END)) AS AMT1_0 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END)) AS AMT1_1 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0)) AS AMT1_2 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(D.TR_AMT,0),NVL(D1.TR_AMT,0)) AS AMT1_3 \n");
		//sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(C.RMN_AMT,0)) AS AMT2 \n");
		//sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0)) AS AMT2 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(C0.RMN_AMT,0)) AS AMT2 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(C.RMN_AMT,0)) AS AMT2_1 \n");
		//������ �߰�
		sbSql.append("     , NVL(C1.PRE_AMT,0) AS AMT2_3 /* ������ */ \n");
		//sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");
		sbSql.append("     , A1.HEAD_CREDIT_YN AS TOT_YN \n");
		sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("             ,'YYY','�ݾ�+ȸ����' \n");
		sbSql.append("             ,'YYN','ȸ��������' \n");
		sbSql.append("             ,'YNY','�ݾ�����','������') AS CTRL \n");
		sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* ����ȸ���� */ \n");
		sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");//�����Ⱓ
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,'Y','N') AS SUM_FLAG \n");		
        
                
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN DECODE(A1.MAIN_UPJANG,A1.UPJANG,A1.CREDIT_OVER_AMOUNT) ELSE 0 END AS CREDIT_OVER_AMOUNT \n");
		sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN DECODE(A1.MAIN_UPJANG,A1.UPJANG,A1.CREDIT_OVER_AMOUNT) ELSE 0 END AS CREDIT_OVER_AMOUNT \n");		
		//sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*�ѵ��ʰ�����*/ \n");
        sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG A1 \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C.�ܻ��ܾ����� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
        sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
        sbSql.append("          FROM SLA_AR_MST M, SLA_AR_RECEIVE_DETAIL D, FMS_UPJANG B \n");
        sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
        sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        sbSql.append("           AND D.RECEIVE_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" /* ���� : �԰����� */ \n");
        sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
        sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.OCCUR_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" /* ���� : �԰����� */ \n");
        sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y' \n");  
	    sbSql.append("           AND M.UPJANG_CD = B.UPJANG \n");
        sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  ä���ܾ��� �ִ� �ڷ� ���� */ \n");
        sbSql.append("           AND M.UPJANG_CD IN " + sUpjangList + " \n");
        sbSql.append("         GROUP BY B.MAIN_UPJANG ) C \n"); 
        sbSql.append("       /************************************************************************ \n"); 
        sbSql.append("       C0.�ܻ��ܾ�����(AR) \n");  
        sbSql.append("       **************************************************************************/ \n"); 
        sbSql.append("     , (SELECT T.MAIN_UPJANG \n"); 
        sbSql.append("             , SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT \n"); 
        sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n"); 
        sbSql.append("                     , NVL(M.AR_AMT, 0) AS AR_AMT \n"); 
        sbSql.append("                     , (SELECT NVL(SUM(D.RECEIVE_AMT),0) \n"); 
        sbSql.append("                          FROM SLA_AR_RECEIVE_DETAIL D \n"); 
        sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
        sbSql.append("                           AND D.RECEIVE_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n"); 
        sbSql.append("                           AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n"); 
        sbSql.append("                  FROM SLA_AR_MST M, FMS_UPJANG B \n"); 
        sbSql.append("                 WHERE M.SYS_CLASS = '13' \n");
        sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
        sbSql.append("                   AND M.OCCUR_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n"); 
        sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n"); 
        sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n"); 
        sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n"); 
        sbSql.append("                ) T \n"); 
        sbSql.append("         GROUP BY T.MAIN_UPJANG \n"); 
        //sbSql.append("        HAVING SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) > 0) C0 \n");
        sbSql.append("        ) C0 \n");
        
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C1.�����ܾ����� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT T.MAIN_UPJANG \n");   
	    sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT \n"); 
	    sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n"); 
	    sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n"); 
	    sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0) \n"); 
	    sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D \n"); 
	    sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
	    sbSql.append("                           AND D.ALT_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n");   
	    sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n"); 
	    sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B \n");  
	    sbSql.append("                 WHERE M.SYS_CLASS = '13' \n"); 
	    sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
	    sbSql.append("                   AND M.OCCUR_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n"); 
	    sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n");  
	    sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
	    sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n");
	    sbSql.append("                ) T \n"); 
	    sbSql.append("         GROUP BY T.MAIN_UPJANG \n"); 
	    //sbSql.append("        HAVING SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) > 0) C1 \n");
	    sbSql.append("        ) C1 \n");
        
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        D.��� �̸��⸶���� �˼��ݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT X.MAIN_UPJANG \n");
        sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
        sbSql.append("          FROM ( \n");
        //sbSql.append("                  SELECT B.MAIN_UPJANG \n");
        //sbSql.append("                     , SUM(A.SAL_AMT) AS TR_AMT \n");
        //sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
        //sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
        //sbSql.append("                   AND A.SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                   AND A.TRANS_YN='N' /* ����ȸ�� �����۰� */ \n");
        //sbSql.append("                   AND B.HEAD_CREDIT_YN='Y' \n");
        //sbSql.append("                   AND A.UPJANG IN " + sUpjangList + " \n");
        //sbSql.append("                 GROUP BY B.MAIN_UPJANG \n");
        //sbSql.append("                 UNION ALL \n");
        sbSql.append("                /* D2. �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */ \n");
        sbSql.append("                SELECT C.MAIN_UPJANG \n");
        //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
        sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
        sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
        sbSql.append("                     , (SELECT UPJANG \n");
        sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
        sbSql.append("                          FROM FMS_SALES \n");
        sbSql.append("                         WHERE SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        sbSql.append("                           AND UPJANG IN " + sUpjangList + " \n");
        sbSql.append("                   		   AND TRANS_YN = 'Y' /* ����ȸ�� ���۰� */ \n");
        sbSql.append("                         GROUP BY UPJANG \n");
        sbSql.append("                        ) B \n");
        sbSql.append("                      , FMS_UPJANG C \n");
        sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
        sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
        sbSql.append("                    AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("                    AND A.MG_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                    /* ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� */ \n");
        //sbSql.append("                    AND A.TRANS_DATE>=GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+" , 'YYYYMMDD'),-1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
        sbSql.append("                    /* ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� : 2015-10-27 */ \n");
		sbSql.append("				   AND    A.MG_DATE >= DECODE(B.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
        sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
        sbSql.append("                    AND A.TRANS_UPJANG IN " + sUpjangList + " \n");
        sbSql.append("                  GROUP BY C.MAIN_UPJANG) X \n");
        sbSql.append("         GROUP BY X.MAIN_UPJANG \n");
        sbSql.append("        ) D \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       D1.��� �̸��⸶���� �˼��ݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT T.UPJANG \n"); 
        sbSql.append("             , SUM(T.TR_AMT) AS TR_AMT \n"); 
        sbSql.append("          FROM ( \n");  
        //sbSql.append("                /* �����������(FMS_SALES) �� ����ȸ�� ������ �ڷ� */ \n");  
        //sbSql.append("                SELECT B.UPJANG \n"); 
        //sbSql.append("                     , SUM(NVL(A.SAL_AMT,0)) AS TR_AMT \n"); 
        //sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");  
        //sbSql.append("                 WHERE A.UPJANG = B.UPJANG \n");  
        //sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n");  
        //sbSql.append("                   AND A.SALE_DATE <= "+strDate+" \n");  
        //sbSql.append("                   AND A.TRANS_YN = 'N' \n");   
        //sbSql.append("                   AND A.UPJANG IN " + sUpjangList + " \n");  
        //sbSql.append("                 GROUP BY B.UPJANG \n"); 
        //sbSql.append("                 UNION ALL \n"); 
        sbSql.append("                /* �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */ \n");  
        sbSql.append("                SELECT B.UPJANG \n"); 
        //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS TR_AMT \n"); 
        sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
        sbSql.append("                  FROM FMS_TRANSACTION_V A, FMS_UPJANG B \n"); 
        sbSql.append("                     , (SELECT UPJANG, MAX(SALE_DATE) AS SALE_DATE \n"); 
        sbSql.append("                          FROM FMS_SALES \n"); 
        sbSql.append("                         WHERE SALE_DATE <= "+strDate+" \n");  
        sbSql.append("                   		   AND TRANS_YN = 'Y' /* ����ȸ�� ���۰� */ \n");
        sbSql.append("                         GROUP BY UPJANG \n"); 
        sbSql.append("                        ) C \n"); 
        sbSql.append("                 WHERE A.TRANS_UPJANG = B.UPJANG \n");  
        sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n");  
        sbSql.append("                   AND A.TRANS_UPJANG = C.UPJANG(+) \n"); 
        sbSql.append("                   AND A.MG_DATE <= "+strDate+" \n");  
        sbSql.append("                   AND A.MG_DATE >= GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(C.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n"); 
        sbSql.append("                   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");  
        sbSql.append("                   AND A.TRANS_UPJANG IN " + sUpjangList + " \n");  
        sbSql.append("                 GROUP BY B.UPJANG \n"); 
        sbSql.append("                ) T \n");   
        sbSql.append("         GROUP BY T.UPJANG \n"); 
        sbSql.append("       ) D1 \n"); 
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       E.��� �̰˼� ���ֱݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , ( /* PW(��������), PC(���ֿϷ�), DL(�����) �� ���� */ \n");
        sbSql.append("         /* CENTER_DELI_QTY(�����԰����), DIRECT_DELI_QTY(���ۼ���), DELIVERED_QTY(�����԰����-�������), UNDELIVERED_QTY(���͹��԰����) */ \n");
        sbSql.append("        SELECT C.MAIN_UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
        sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
        sbSql.append("         WHERE A.RC_UPJANG = C.UPJANG \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("           AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
        sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
        sbSql.append("         GROUP BY C.MAIN_UPJANG) E \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       F.��� �̹��� �ֹ��ݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
        sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
        sbSql.append("         WHERE A.RC_UPJANG = B.UPJANG \n");
        sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("           AND A.LINE_STATUS = '001' /* ������� : 001(��û����) */ \n");
        sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
        sbSql.append("         GROUP BY B.MAIN_UPJANG)F \n");		
        sbSql.append(" WHERE A1.MAIN_UPJANG = A.UPJANG \n");
        
        if (!ds_Cond.getString(0, "MAIN_UPJANG").equals("0")) {
			sbSql.append(" AND A1.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		}
		if (!ds_Cond.getString(0, "UPJANG").equals("0")) {
			sbSql.append(" AND A1.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		}
        
        sbSql.append("   AND A.UPJANG = C.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = C0.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = C1.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = D.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A1.UPJANG = D1.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = E.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = F.MAIN_UPJANG(+) \n");
        //sbSql.append("   AND A.UPJANG = G.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A1.HEAD_CREDIT_YN = 'Y' \n");
        //sbSql.append("   AND A1.USE_YN = 'Y' \n");
    	if (!sUseYn.equals(""))
		{
			sbSql.append(" AND A1.USE_YN = '"+sUseYn+"' \n");
		}

        sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");                                             
        sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");  
		
		// 2015-03-24 �߰�
		if (g_flag.equals("u")) {
			if (!ds_Cond.getString(0, "UPJANG").equals("0")) {
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("   AND A1.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			}
		} else {
			if (!ds_Cond.getString(0, "MAIN_UPJANG").equals("0")) {
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
				sbSql.append("   AND A1.MAIN_UPJANG = A.UPJANG \n");
			}
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();
		
		//���� �� ���� ���� ����� IN�������� �����.
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
		sbSql.append(" WHERE 1=1 \n");
		//// 2015-03-24 �߰�
		if (g_flag.equals("u")) 
			sbSql.append(" AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		else
			sbSql.append(" AND MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("   AND HEAD_CREDIT_YN = 'N' \n");
		if (!sUseYn.equals(""))
		{
			sbSql.append(" AND USE_YN = '"+sUseYn+"' \n");
		}
		
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		sUpjangList = "";
		while (rs.next())
		{
			sUpjangList += ", " + rs.getString("UPJANG");
		}
		if (sUpjangList.equals(""))
			sUpjangList = "(NULL)";
		else
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
		rs.close();
		pstmt.close();
        
		//���� �� ���� ���� ��� ����üũ�� ���� �������� ��ȸ
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       MAX(NEED_DATE) AS NEED_DATE \n");
		sbSql.append("  FROM SO_PR \n");
		sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND NEED_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND LINE_STATUS NOT IN('003', '005', '999') --��û���, ���ǹݷ� \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if(rs.next()) {
			strDate = rs.getString("NEED_DATE");
			if ("".equals(strDate) || strDate == null) {
				strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
			}
		}
		else {
			strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
		}
		rs.close();
		pstmt.close();
        
		//���� �� ���� ���峻����ȸ(�ӵ������ ����� �������� �ʴ´�.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* FMO00530V_T002_2.jsp */ \n");
		sbSql.append("SELECT A.MAIN_UPJANG, '1' AS BON_GB \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , A.UPJANGNM_DISP \n");
		sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) \n");
        sbSql.append("            ELSE 0 END AS AMT1 /* �� ����å���ݾ�-���ſ���ݾ� ���� */ \n"); //AMT1            
		sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) \n");
        sbSql.append("            ELSE 0 END AS AMT1_0 /* ���űݾ� */ \n"); //AMT1_0
        sbSql.append("     , 0 AS AMT1_1 /* ���ſ���ݾ�-���ſ���ݾ� ���� */ \n");//AMT1_1
        sbSql.append("     , NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS AMT1_2 \n");
        sbSql.append("     , NVL(D.TR_AMT,0) AS AMT1_3 /* ����Ȯ�� */ \n");
        //sbSql.append("     , NVL(C.RMN_AMT,0) AS AMT2 /* �ܻ�����ܾ� */ \n");
        //sbSql.append("     , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) AS AMT2 /* �ܻ�����ܾ� */ \n");
        sbSql.append("     , NVL(C0.RMN_AMT,0) AS AMT2 /* �ܻ�����ܾ� */ \n");
        sbSql.append("     , NVL(C1.PRE_AMT,0) AS AMT2_3 /* ������ */ \n");
        sbSql.append("     , NVL(C.RMN_AMT,0) AS AMT2_1 \n");
        //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        //sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 /* ���뿩�� */ \n");
        sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 /* ���뿩�� */ \n");
        sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN /*���հ�������*/ \n");
        sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
        sbSql.append("             ,'YYY','�ݾ�+ȸ����' \n");
        sbSql.append("             ,'YYN','ȸ��������' \n");
        sbSql.append("             ,'YNY','�ݾ�����','������') AS CTRL /*��������*/ \n");
        sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* ����ȸ���� */ \n");
        sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");//�����Ⱓ
        sbSql.append("     , 'Y' AS SUM_FLAG \n");
        sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
        sbSql.append("                THEN A.CREDIT_OVER_AMOUNT \n");
        sbSql.append("                ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* �����ѵ��ʰ��� */ \n");
        
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*�ѵ��ʰ�����*/ \n");
        sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        sbSql.append("  FROM FMS_UPJANG A \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C.�ܻ��ܾ����� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT M.UPJANG_CD AS UPJANG \n");
        sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
        sbSql.append("          FROM SLA_AR_MST M, SLA_AR_RECEIVE_DETAIL D, FMS_UPJANG B \n");
        sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
        sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        sbSql.append("           AND D.RECEIVE_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" /* ���� : �԰����� */ \n");
        sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
        sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.OCCUR_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" /* ���� : �԰����� */ \n");
        sbSql.append("           AND B.HEAD_CREDIT_YN = 'N' \n");  
	    sbSql.append("           AND M.UPJANG_CD = B.UPJANG \n");
        sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  ä���ܾ��� �ִ� �ڷ� ���� */ \n");
        sbSql.append("           AND M.UPJANG_CD IN " + sUpjangList + " \n");
        sbSql.append("         GROUP BY M.UPJANG_CD ) C \n"); 
        
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C0.�����ܾ����� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT T.UPJANG \n");   
	    sbSql.append("             , SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT \n"); 
	    sbSql.append("          FROM (SELECT B.UPJANG \n"); 
	    sbSql.append("                     , NVL(M.AR_AMT, 0) AS AR_AMT \n"); 
	    sbSql.append("                     , (SELECT NVL(SUM(D.RECEIVE_AMT),0) \n"); 
	    sbSql.append("                          FROM SLA_AR_RECEIVE_DETAIL D \n"); 
	    sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
	    sbSql.append("                           AND D.RECEIVE_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n");   
	    sbSql.append("                           AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n"); 
	    sbSql.append("                  FROM SLA_AR_MST M, FMS_UPJANG B \n");  
	    sbSql.append("                 WHERE M.SYS_CLASS = '13' \n"); 
	    sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
	    sbSql.append("                   AND M.OCCUR_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n"); 
	    sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N' \n");  
	    sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
	    sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n");
	    sbSql.append("                ) T \n"); 
	    sbSql.append("         GROUP BY T.UPJANG \n"); 
	    //sbSql.append("        HAVING SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) > 0) C0 \n");
	    sbSql.append("        ) C0 \n");
        
	    sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C1.�����ܾ����� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT T.UPJANG \n");   
	    sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT \n"); 
	    sbSql.append("          FROM (SELECT B.UPJANG \n"); 
	    sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n"); 
	    sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0) \n"); 
	    sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D \n"); 
	    sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
	    sbSql.append("                           AND D.ALT_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n");   
	    sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n"); 
	    sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B \n");  
	    sbSql.append("                 WHERE M.SYS_CLASS = '13' \n"); 
	    sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
	    sbSql.append("                   AND M.OCCUR_DATE <= "+nullToBlank(ds_Cond.getString(0, "JDATE"))+" \n"); 
	    sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N' \n");  
	    sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
	    sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n");
	    sbSql.append("                ) T \n"); 
	    sbSql.append("         GROUP BY T.UPJANG \n"); 
	    //sbSql.append("        HAVING SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) > 0) C1 \n");
	    sbSql.append("        ) C1 \n");
        
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        D.��� �̸��⸶���� �˼��ݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT X.UPJANG \n");
        sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
        sbSql.append("          FROM ( \n");
        //sbSql.append("                  SELECT B.UPJANG \n");
        //sbSql.append("                     , SUM(A.SAL_AMT) AS TR_AMT \n");
        //sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
        //sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
        //sbSql.append("                   AND A.SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                   AND A.TRANS_YN='N' /* ����ȸ�� �����۰� */ \n");
        //sbSql.append("                   AND B.HEAD_CREDIT_YN='N' \n");
        //sbSql.append("                   AND A.UPJANG IN " + sUpjangList + " \n");
        //sbSql.append("                 GROUP BY B.UPJANG \n");
        //sbSql.append("                 UNION ALL \n");
        sbSql.append("                /* D2. �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */ \n");
        sbSql.append("                SELECT C.UPJANG \n");
        //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
        sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
        sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
        sbSql.append("                     , (SELECT UPJANG \n");
        sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
        sbSql.append("                          FROM FMS_SALES \n");
        sbSql.append("                         WHERE SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        sbSql.append("                           AND UPJANG IN " + sUpjangList + " \n");
        sbSql.append("                   		   AND TRANS_YN = 'Y' /* ����ȸ�� ���۰� */ \n");
        sbSql.append("                         GROUP BY UPJANG \n");
        sbSql.append("                        ) B \n");
        sbSql.append("                      , FMS_UPJANG C \n");
        sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
        sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
        sbSql.append("                    AND C.HEAD_CREDIT_YN = 'N' \n");
        sbSql.append("                    AND A.MG_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                    /* ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� */ \n");
        //sbSql.append("                    AND A.TRANS_DATE>=GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+" , 'YYYYMMDD'),-1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
        sbSql.append("                    /* ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� : 2015-10-27 */ \n");
		sbSql.append("				   AND    A.MG_DATE >= DECODE(B.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
		sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
        sbSql.append("                    AND A.TRANS_UPJANG IN " + sUpjangList + " \n");
        sbSql.append("                  GROUP BY C.UPJANG) X \n");
        sbSql.append("         GROUP BY X.UPJANG \n");
        sbSql.append("        ) D \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       E.��� �̰˼� ���ֱݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , ( /* PW(��������), PC(���ֿϷ�), DL(�����) �� ���� */ \n");
        sbSql.append("         /* CENTER_DELI_QTY(�����԰����), DIRECT_DELI_QTY(���ۼ���), DELIVERED_QTY(�����԰����-�������), UNDELIVERED_QTY(���͹��԰����) */ \n");
        sbSql.append("        SELECT C.UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
        sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
        sbSql.append("         WHERE A.RC_UPJANG = C.UPJANG \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("           AND C.HEAD_CREDIT_YN = 'N' \n");
        sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
        sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
        sbSql.append("         GROUP BY C.UPJANG) E \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       F.��� �̹��� �ֹ��ݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT B.UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
        sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
        sbSql.append("         WHERE A.RC_UPJANG = B.UPJANG \n");
        sbSql.append("           AND B.HEAD_CREDIT_YN = 'N' \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("           AND A.LINE_STATUS = '001' /* ������� : 001(��û����) */ \n");
        sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
        sbSql.append("         GROUP BY B.UPJANG) F \n");	
		sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = C0.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
        //sbSql.append("   AND A.USE_YN = 'Y' \n");
  		if (!sUseYn.equals(""))
		{
			sbSql.append(" AND A.USE_YN = '"+sUseYn+"' \n");
		}

        
		if (!ds_Cond.getString(0, "UPJANG").equals("0")) {
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		}
		if (!ds_Cond.getString(0, "MAIN_UPJANG").equals("0")) {	
			sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		}
		sbSql.append("   AND A.HEAD_CREDIT_YN = 'N' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
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

<%--
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

		//����(����or����)���� ������ �߰���, or �����̹Ƿ� ������ ó���ؾ���
		String g_flag = "";
		if (!ds_Cond.getString(0, "UPJANG").equals("0"))
			g_flag = "u";		// ����� ����
		else
			g_flag = "m";		// ���� ����
		
		System.out.println("g_flag : "+ g_flag);
		System.out.println("main_upjang : "+ ds_Cond.getString(0, "MAIN_UPJANG"));
		System.out.println("upjang : "+ ds_Cond.getString(0, "UPJANG"));
		

		//out ����Ÿ
		DataSet ds_List, ds_ListTmp;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		//����������� IN�������� �����.
		String sUpjangList = ""; 
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
		sbSql.append(" WHERE 1=1 \n");
		if  (g_flag.equals("u")) {
			sbSql.append(" AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		} else  {
			sbSql.append(" AND MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		}
		//sbSql.append("   AND HEAD_CREDIT_YN = 'Y' \n");
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		while (rs.next())
		{
			sUpjangList += ", " + rs.getString("UPJANG");
		}
		if (sUpjangList.equals(""))
			sUpjangList = "(NULL)";
		else
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
		rs.close();
		pstmt.close();

		//���� ���� ���� ��� ����üũ�� ���� �������� ��ȸ
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       NEED_DATE \n");
		sbSql.append("  FROM SO_PR \n");
		sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
		sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND LINE_STATUS <> '003' --��û��� \n");
		sbSql.append("   AND ROWNUM <= 1 \n");
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

		//�������� ���峻����ȸ(�ӵ������ ����� �������� �ʴ´�.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* FMO00530V_T002_1.jsp */ \n");
		sbSql.append("SELECT A1.MAIN_UPJANG, DECODE(A1.MAIN_UPJANG,A1.UPJANG,'0','1') AS BON_GB \n");
		sbSql.append("     , A1.UPJANG \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NULL,' - ')||A1.UPJANGNM_DISP AS UPJANGNM_DISP \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END)) AS AMT1 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END)) AS AMT1_0 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END)) AS AMT1_1 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0)) AS AMT1_2 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(D.TR_AMT,0)) AS AMT1_3 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,NVL(C.RMN_AMT,0)) AS AMT2 \n");
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,(CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");
		sbSql.append("     , A1.HEAD_CREDIT_YN AS TOT_YN \n");
		sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("             ,'YYY','�ݾ�+ȸ����' \n");
		sbSql.append("             ,'YYN','ȸ��������' \n");
		sbSql.append("             ,'YNY','�ݾ�����','������') AS CTRL \n");
		sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* ����ȸ���� */ \n");
		sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");//�����Ⱓ
		sbSql.append("     , DECODE(A1.MAIN_UPJANG,A1.UPJANG,'Y','N') AS SUM_FLAG \n");		
		sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
        sbSql.append("           THEN A.CREDIT_OVER_AMOUNT \n");
        sbSql.append("           ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* �����ѵ��ʰ��� */ \n");
        sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*�ѵ��ʰ�����*/ \n");
        
		// 2009-04-06 �߰� ����. ���� : �����ѵ��ʰ��� ���� �����ѵ��ʰ����� ������ ���� ���� �߰� �� �κ�. BY ��Կ�.		
		//sbSql.append("      ,(CASE WHEN NVL(A1.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN DECODE(A1.MAIN_UPJANG,A1.UPJANG,A.CREDIT_OVER_AMOUNT) ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		// 2009-06-16 �߰� ����. ���� : �����ѵ��ʰ� �ݾ� ������ �ʵ�  �߰� �� �κ�. BY ��Կ�. �����ȣ : #28264
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG A1 \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C.�ܻ��ܾ����� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT C.MAIN_UPJANG \n");
        sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
        sbSql.append("          FROM SLA_AR_MST M \n");
        sbSql.append("             , SLA_AR_RECEIVE_DETAIL D \n");
        sbSql.append("             , FMS_UPJANG C \n");
        sbSql.append("         WHERE M.UPJANG_CD = C.UPJANG \n");
        sbSql.append("           AND M.SYS_CLASS = '13' \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        sbSql.append("           AND D.RECEIVE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
        sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  ä���ܾ��� �ִ� �ڷ� ���� */ \n");
        sbSql.append("         GROUP BY C.MAIN_UPJANG) C \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C1.�����ܾ����� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT C.MAIN_UPJANG \n");
        sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        sbSql.append("             , SUM(NVL(M.OCCUR_AMT,0)-NVL(D.APPLY_AMT,0)) AS PRE_AMT \n");
        sbSql.append("          FROM SLA_ADVANCE_MST M \n");
        sbSql.append("             , SLA_ADVANCE_ALT_DETAIL D \n");
        sbSql.append("             , FMS_UPJANG C \n");
        sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
        sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" \n");
        sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.UPJANG_CD = C.UPJANG \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND D.ALT_DATE <= "+strDate+" \n");
        sbSql.append("           AND M.ADVANCE_NUM = D.ADVANCE_NUM \n");
        sbSql.append("           AND NVL(M.OCCUR_AMT,0)-NVL(D.APPLY_AMT,0) > 0 /*  �����ܾ��� �ִ� �ڷ� ���� */ \n");
        sbSql.append("         GROUP BY C.MAIN_UPJANG) C1 \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        D.��� �̸��⸶���� �˼��ݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT X.MAIN_UPJANG \n");
        sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
        sbSql.append("          FROM ( \n");
        //sbSql.append("                 SELECT B.MAIN_UPJANG \n");
        //sbSql.append("                     , SUM(A.NET_AMT) AS TR_AMT \n");
        //sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
        //sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
        //sbSql.append("                   AND A.SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                   AND A.TRANS_YN='N' /* ����ȸ�� �����۰� */ \n");
        //sbSql.append("                   --AND B.HEAD_CREDIT_YN='Y' \n");
        //sbSql.append("                 GROUP BY B.MAIN_UPJANG \n");
        //sbSql.append("                 UNION ALL \n");
        sbSql.append("                /* D2. �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */ \n");
        sbSql.append("                SELECT C.MAIN_UPJANG \n");
        //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
        sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
        sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
        sbSql.append("                     , (SELECT B.MAIN_UPJANG UPJANG \n");
        sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
        sbSql.append("                          FROM FMS_SALES A, FMS_UPJANG B \n");
        sbSql.append("                         WHERE A.UPJANG = B.UPJANG \n");
        sbSql.append("                           --AND B.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("                           AND SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        sbSql.append("                         GROUP BY B.MAIN_UPJANG \n");
        sbSql.append("                        ) B \n");
        sbSql.append("                      , FMS_UPJANG C \n");
        sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
        sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("                    AND A.MG_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                    /* ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� */ \n");
        //sbSql.append("                    AND A.TRANS_DATE>=GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+" , 'YYYYMMDD'),-1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
        sbSql.append("                    /* ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� : 2015-10-27 */ \n");
		sbSql.append("				   AND    A.MG_DATE >= DECODE(B.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
        sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
        sbSql.append("                  GROUP BY C.MAIN_UPJANG) X \n");
        sbSql.append("         GROUP BY X.MAIN_UPJANG \n");
        sbSql.append("        ) D \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       E.��� �̰˼� ���ֱݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , ( /* PW(��������), PC(���ֿϷ�), DL(�����) �� ���� */ \n");
        sbSql.append("         /* CENTER_DELI_QTY(�����԰����), DIRECT_DELI_QTY(���ۼ���), DELIVERED_QTY(�����԰����-�������), UNDELIVERED_QTY(���͹��԰����) */ \n");
        sbSql.append("        SELECT C.MAIN_UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
        sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
        sbSql.append("         WHERE A.PR_UPJANG = C.UPJANG \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
        sbSql.append("         GROUP BY C.MAIN_UPJANG) E \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       F.��� �̹��� �ֹ��ݾ� \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
        sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
        sbSql.append("         WHERE A.PR_UPJANG = B.UPJANG \n");
        sbSql.append("           --AND B.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("           AND A.LINE_STATUS IN('001','007') /* ������� : 001(��û����), 007(���ǽ���) */ \n");
        sbSql.append("         GROUP BY B.MAIN_UPJANG)F \n");		
        sbSql.append(" WHERE A1.MAIN_UPJANG = A.UPJANG \n");
        
        if (!ds_Cond.getString(0, "MAIN_UPJANG").equals("0")) {
			sbSql.append(" AND A1.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		}
		if (!ds_Cond.getString(0, "UPJANG").equals("0")) {
			sbSql.append(" AND A1.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		}
        
        sbSql.append("   AND A.UPJANG = C.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = C1.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = D.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = E.MAIN_UPJANG(+) \n");
        sbSql.append("   AND A.UPJANG = F.MAIN_UPJANG(+) \n");
        //sbSql.append("   AND A.UPJANG = G.MAIN_UPJANG(+) \n");
        sbSql.append("   --AND A1.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("   AND A1.USE_YN = 'Y' \n");			
        sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");                                             
        sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");  
		
		// 2015-03-24 �߰�
		if (g_flag.equals("u")) {
			if (!ds_Cond.getString(0, "UPJANG").equals("0")) {
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("   AND A1.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			}
		} else {
			if (!ds_Cond.getString(0, "MAIN_UPJANG").equals("0")) {
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
				sbSql.append("   AND A1.MAIN_UPJANG = A.UPJANG \n");
			}
		}
		sbSql.append("   --AND A1.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("   AND A1.USE_YN = 'Y' \n");
		//sbSql.append("   AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		//sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
		//sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
			sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		{
			sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
			sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
			sbSql.append("                  AND Y.UPJANG = A.UPJANG \n");
			sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		}
		
		
		//sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG Z \n");
		//sbSql.append("       --B.���ſ������� \n");
		//sbSql.append("     ,(SELECT SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
		//sbSql.append("            , SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
		//sbSql.append("         FROM FMS_CREDIT_EXT A \n");
		//sbSql.append("        WHERE 1=1 \n");
		//// 2015-03-24 �߰�
		//if (g_flag.equals("u")) 
		//	sbSql.append("        AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		//else 
		//	sbSql.append("        AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		//sbSql.append("          AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
		//sbSql.append("          AND A.APPR_YN = 'Y') B \n");
		//sbSql.append("       --C.�ܻ��ܾ����� \n");
		//sbSql.append("     ,(SELECT SUM((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) AS RMN_AMT \n");
		//sbSql.append("         FROM HLDC_FM_BILL A \n");
		//sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
		//sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//sbSql.append("                 AND B.UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("               GROUP BY C.BILL_ID) B \n");
		//sbSql.append("        WHERE A.BILL_ID = B.BILL_ID(+) \n");
		//sbSql.append("          AND A.UPJANG IN " + sUpjangList + " \n");
		////sbSql.append("          AND A.BILL_DATE <= '" + strDate + "' \n");		
		//// 2009-07-28 �߰� ����. ���� : �ܻ�/���� �������� ���� �� ���� ������ �����Ͱ� ���� �� �� �����͸� �ҷ� ���� ���ϹǷ� , ��ȸ���� ������ ���� ������ �ش�. BY ��Կ�. 
		////sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
		//// (#29877)2009-08-18 �߰� ���� ����. 
		//// ���� : �ܻ�/���� �ܾ��� ���� ��� ��  ��츦 ��� �Ͽ� ����(ADD_MONTHS(��¥,1))�� ���Ͽ� �ְ� 2��ġ ���� ���� ���� ���� by ��Կ�.
		////       ���� ȭ�� : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001
		//sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");
		//// (#29877)2009-08-18 �߰� ���� ��.
		//sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		//sbSql.append("          AND A.DCGUBUN = '1' \n");
		//sbSql.append("          AND A.ACCTCD = '1110411' \n");
		//sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) != 0) C \n");
		//sbSql.append("       --C1.�����ܾ����� \n");
		//sbSql.append("     ,(SELECT SUM(A.AMOUNT - NVL(B.USE_AMT,0)) AS PRE_AMT \n");
		//sbSql.append("            , MIN(A.RECEIPT_DATE) AS L_RECEIPT_DATE \n");
		//sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
		//sbSql.append("            ,(SELECT C.RECEIPT_ID, SUM(C.AMOUNT) AS USE_AMT \n");
		//sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//sbSql.append("                 AND B.UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("               GROUP BY C.RECEIPT_ID) B \n");
		//sbSql.append("        WHERE A.RECEIPT_ID = B.RECEIPT_ID(+) \n");
		//sbSql.append("          AND A.UPJANG IN " + sUpjangList + " \n");
		////sbSql.append("          AND A.RECEIPT_DATE <= '" + strDate + "' \n");
		//// 2009-07-28 �߰� ����. ���� : �ܻ�/���� �������� ���� �� ���� ������ �����Ͱ� ���� �� �� �����͸� �ҷ� ���� ���ϹǷ� , ��ȸ���� ������ ���� ������ �ش�. BY ��Կ�. 
		////sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
		//// (#29877)2009-08-18 �߰� ���� ����. 
		//// ���� : �ܻ�/���� �ܾ��� ���� ��� ��  ��츦 ��� �Ͽ� ����(ADD_MONTHS(��¥,1))�� ���Ͽ� �ְ� 2��ġ ���� ���� ���� ���� by ��Կ�.
		////       ���� ȭ�� : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001
		//sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");
		//// (#29877)2009-08-18 �߰� ���� ��.
		//sbSql.append("          AND A.DCGUBUN = '2' \n");
		//sbSql.append("          AND A.ACCTCD = '2110441' \n");
		//sbSql.append("          --AND A.GANO > 0 --������� ��ǥȭ ��Ų �͸� �����Ϸ��� �ּ�����. \n");
		//sbSql.append("          AND (A.AMOUNT - NVL(B.USE_AMT,0)) != 0) C1 \n");
		//sbSql.append("       --D.��� �̸��⸶���� �˼��ݾ� \n");
		//sbSql.append("     ,(SELECT SUM(TR_AMT) AS TR_AMT \n");
		//sbSql.append("         FROM (SELECT \n");
		////sbSql.append("                      SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                      SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_TRANSACTION_V \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		//sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("                UNION ALL \n");
		//sbSql.append("               SELECT \n");
		////sbSql.append("                      SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                      SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_TRANSACTION_V \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("              ) \n");
		//sbSql.append("      ) D \n");
		//sbSql.append("       --E.��� �̰˼� ���ֱݾ� \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
		//sbSql.append("         FROM HLDC_PO_PO A \n");
		//sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("      ) E \n");
		//sbSql.append("       --F.��� �̹��� �ֹ��ݾ� \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
		//sbSql.append("         FROM SO_PR A \n");
		//sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("      ) F \n");
		////���庰 ���Կ���/Ȯ����
		//sbSql.append("       --���庰 ���Կ���/Ȯ����-- \n");
		//sbSql.append("       --D.��� �̸��⸶���� �˼��ݾ� \n");
		//sbSql.append("     ,(SELECT UPJANG, SUM(TR_AMT) AS TR_AMT \n");
		//sbSql.append("         FROM (SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_TRANSACTION_V \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		//sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("                UNION ALL \n");
		//sbSql.append("               SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_TRANSACTION_V \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("              ) \n");
		//sbSql.append("        GROUP BY UPJANG \n");
		//sbSql.append("      ) D_1 \n");
		//sbSql.append("       --E.��� �̰˼� ���ֱݾ� \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              RC_UPJANG AS UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
		//sbSql.append("         FROM HLDC_PO_PO A \n");
		//sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//sbSql.append("      ) E_1 \n");
		//sbSql.append("       --F.��� �̹��� �ֹ��ݾ� \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              RC_UPJANG AS UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
		//sbSql.append("         FROM SO_PR A \n");
		//sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//sbSql.append("      ) F_1 \n");
		////
		//sbSql.append(" WHERE Z.UPJANG = D_1.UPJANG(+) \n");
		//sbSql.append("   AND Z.UPJANG = E_1.UPJANG(+) \n");
		//sbSql.append("   AND Z.UPJANG = F_1.UPJANG(+) \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();
		
		//���� �� ���� ���� ����� IN�������� �����.
		//sbSql.delete(0,sbSql.length());
		//sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
		//sbSql.append(" WHERE 1=1 \n");
		//// 2015-03-24 �߰�
		//if (g_flag.equals("u")) 
		//	sbSql.append(" AND UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		//else
		//	sbSql.append(" AND MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		//sbSql.append("   AND HEAD_CREDIT_YN = 'N' \n");
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		//sUpjangList = "";
		//while (rs.next())
		//{
		//	sUpjangList += ", " + rs.getString("UPJANG");
		//}
		//if (sUpjangList.equals(""))
		//	sUpjangList = "(NULL)";
		//else
		//	sUpjangList = "(" + sUpjangList.substring(1) + ")";
		//rs.close();
		//pstmt.close();
        //
		////���� �� ���� ���� ��� ����üũ�� ���� �������� ��ȸ
		//sbSql.delete(0,sbSql.length());
		//sbSql.append("SELECT \n");
		//sbSql.append("       NEED_DATE \n");
		//sbSql.append("  FROM SO_PR \n");
		//sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
		//sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		//sbSql.append("   AND LINE_STATUS <> '003' --��û��� \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
//out_vl//.add("fa_Sql", sbSql.toString());
		////System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		//if(rs.next())
		//	strDate = rs.getString("NEED_DATE");
		//else
		//	strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
		//rs.close();
		//pstmt.close();
        //
		////���� �� ���� ���峻����ȸ(�ӵ������ ����� �������� �ʴ´�.)
		//sbSql.delete(0,sbSql.length());
		//sbSql.append("/* FMO00530V_T002_2.jsp */ \n");
		//sbSql.append("SELECT A.MAIN_UPJANG, '1' AS BON_GB \n");
		//sbSql.append("     , A.UPJANG \n");
		//sbSql.append("     , A.UPJANGNM_DISP \n");
		//sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        //sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) \n");
        //sbSql.append("       ELSE 0 \n");
        //sbSql.append("       END AS AMT1 /* �� ����å���ݾ�-���ſ���ݾ� ���� */ \n"); //AMT1            
		//sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        //sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) \n");
        //sbSql.append("       ELSE 0 \n");
        //sbSql.append("       END AS AMT1_0 /* ���űݾ� */ \n"); //AMT1_0
        //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        //sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) \n");
        //sbSql.append("       ELSE 0 \n");
        //sbSql.append("       END AS AMT1_1 /* ���ſ���ݾ�-���ſ���ݾ� ���� */ \n");//AMT1_1
        //sbSql.append("     , NVL(F.PR_AMT,0) + NVL(E.PO_AMT, 0) AS AMT1_2 /* ���Կ���(��û) */ \n");
        //sbSql.append("     , NVL(D.TR_AMT,0) AS AMT1_3 /* ����Ȯ�� */ \n");
        //sbSql.append("     , NVL(C.RMN_AMT,0) AS AMT2 /* �ܻ�����ܾ� */ \n");
        //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        //sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 /* ���뿩�� */ \n");
        //sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN /*���հ�������*/ \n");
        //sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
        //sbSql.append("          ,'YYY','�ݾ�+ȸ����' \n");
        //sbSql.append("          ,'YYN','ȸ��������' \n");
        //sbSql.append("          ,'YNY','�ݾ�����','������') AS CTRL /*��������*/ \n");
        //sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* ����ȸ���� */ \n");
        //sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");//�����Ⱓ
        //sbSql.append("     , 'Y' AS SUM_FLAG \n");
        //sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
        //sbSql.append("           THEN A.CREDIT_OVER_AMOUNT \n");
        //sbSql.append("           ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* �����ѵ��ʰ��� */ \n");
        //sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*�ѵ��ʰ�����*/ \n");
        //
        //sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG A1 \n");
        //sbSql.append("       /************************************************************************ \n");
        //sbSql.append("        C.�ܻ��ܾ����� \n");
        //sbSql.append("       **************************************************************************/ \n");
        //sbSql.append("     , (SELECT C.MAIN_UPJANG \n");
        //sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        //sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
        //sbSql.append("          FROM SLA_AR_MST M \n");
        //sbSql.append("             , SLA_AR_RECEIVE_DETAIL D \n");
        //sbSql.append("             , FMS_UPJANG C \n");
        //sbSql.append("         WHERE M.UPJANG_CD = C.UPJANG \n");
        //sbSql.append("           AND M.SYS_CLASS = '13' \n");
        //sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        //sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        //sbSql.append("           AND D.RECEIVE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
        //sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        //sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  ä���ܾ��� �ִ� �ڷ� ���� */ \n");
        //sbSql.append("         GROUP BY C.MAIN_UPJANG) C \n");
        //sbSql.append("       /************************************************************************ \n");
        //sbSql.append("        C1.�����ܾ����� \n");
        //sbSql.append("       **************************************************************************/ \n");
        //sbSql.append("     , (SELECT C.MAIN_UPJANG \n");
        //sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        //sbSql.append("             , SUM(NVL(M.OCCUR_AMT,0)-NVL(D.APPLY_AMT,0)) AS PRE_AMT \n");
        //sbSql.append("          FROM SLA_ADVANCE_MST M \n");
        //sbSql.append("             , SLA_ADVANCE_ALT_DETAIL D \n");
        //sbSql.append("             , FMS_UPJANG C \n");
        //sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
        //sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        //sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" \n");
        //sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        //sbSql.append("           AND M.UPJANG_CD = C.UPJANG \n");
        //sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        //sbSql.append("           AND D.ALT_DATE <= "+strDate+" \n");
        //sbSql.append("           AND M.ADVANCE_NUM = D.ADVANCE_NUM \n");
        //sbSql.append("           AND NVL(M.OCCUR_AMT,0)-NVL(D.APPLY_AMT,0) > 0 /*  �����ܾ��� �ִ� �ڷ� ���� */ \n");
        //sbSql.append("         GROUP BY C.MAIN_UPJANG) C1 \n");
        //sbSql.append("       /************************************************************************ \n");
        //sbSql.append("        D.��� �̸��⸶���� �˼��ݾ� \n");
        //sbSql.append("       **************************************************************************/ \n");
        //sbSql.append("     , (SELECT X.MAIN_UPJANG \n");
        //sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
        //sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n");
        //sbSql.append("                     , SUM(A.NET_AMT) AS TR_AMT \n");
        //sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
        //sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
        //sbSql.append("                   AND A.SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                   AND A.TRANS_YN='N' /* ����ȸ�� �����۰� */ \n");
        //sbSql.append("                   AND B.HEAD_CREDIT_YN='Y' \n");
        //sbSql.append("                 GROUP BY B.MAIN_UPJANG \n");
        //sbSql.append("                 UNION ALL \n");
        //sbSql.append("                /* D2. �����������(FMS_SALES)�� ������������ ���Ŀ��� �������� ���� */ \n");
        //sbSql.append("                SELECT C.MAIN_UPJANG \n");
        //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
        //sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
        //sbSql.append("                     , (SELECT B.MAIN_UPJANG UPJANG \n");
        //sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
        //sbSql.append("                          FROM FMS_SALES A, FMS_UPJANG B \n");
        //sbSql.append("                         WHERE A.UPJANG = B.UPJANG \n");
        //sbSql.append("                           AND B.HEAD_CREDIT_YN = 'Y' \n");
        //sbSql.append("                           AND SALE_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                         GROUP BY B.MAIN_UPJANG \n");
        //sbSql.append("                        ) B \n");
        //sbSql.append("                      , FMS_UPJANG C \n");
        //sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
        //sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
        //sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        //sbSql.append("                    AND A.TRANS_DATE <= "+strDate+" /* ���� : �԰����� */ \n");
        //sbSql.append("                    /* ���庰 ������������ ���� ~ �������ڱ����� ���� : ���� ���������� ������ �������� ��� 1���� ������ ���� */ \n");
        //sbSql.append("                    AND A.TRANS_DATE>=GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+" , 'YYYYMMDD'),-1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
        //sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
        //sbSql.append("                  GROUP BY C.MAIN_UPJANG) X \n");
        //sbSql.append("         GROUP BY X.MAIN_UPJANG \n");
        //sbSql.append("        ) D \n");
        //sbSql.append("       /************************************************************************ \n");
        //sbSql.append("       E.��� �̰˼� ���ֱݾ� \n");
        //sbSql.append("       **************************************************************************/ \n");
        //sbSql.append("     , ( /* PW(��������), PC(���ֿϷ�), DL(�����) �� ���� */ \n");
        //sbSql.append("         /* CENTER_DELI_QTY(�����԰����), DIRECT_DELI_QTY(���ۼ���), DELIVERED_QTY(�����԰����-�������), UNDELIVERED_QTY(���͹��԰����) */ \n");
        //sbSql.append("        SELECT C.MAIN_UPJANG \n");
        //sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
        //sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
        //sbSql.append("         WHERE A.PR_UPJANG = C.UPJANG \n");
        //sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        //sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        //sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
        //sbSql.append("         GROUP BY C.MAIN_UPJANG) E \n");
        //sbSql.append("       /************************************************************************ \n");
        //sbSql.append("       F.��� �̹��� �ֹ��ݾ� \n");
        //sbSql.append("       **************************************************************************/ \n");
        //sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
        //sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
        //sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
        //sbSql.append("         WHERE A.PR_UPJANG = B.UPJANG \n");
        //sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y' \n");
        //sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        //sbSql.append("           AND A.LINE_STATUS IN('001','007') /* ������� : 001(��û����), 007(���ǽ���) */ \n");
        //sbSql.append("         GROUP BY B.MAIN_UPJANG) F \n");
        //
		////sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) AS AMT1 \n");
		////sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) AS AMT1_0 \n");
		////sbSql.append("     , NVL(B.CREDIT_EXT_AMOUNT,0) AS AMT1_1 \n");
		////sbSql.append("     , NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS AMT1_2 \n");
		////sbSql.append("     , NVL(D.TR_AMT,0) AS AMT1_3 \n");
		////sbSql.append("     , NVL(C.RMN_AMT,0) AS AMT2 \n");
		////sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 \n");
		////sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN \n");
		////sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		////sbSql.append("             ,'YYY','�ݾ�+ȸ����' \n");
		////sbSql.append("             ,'YYN','ȸ��������' \n");
		////sbSql.append("             ,'YNY','�ݾ�����','������') AS CTRL \n");
		////sbSql.append("     , A.CREDIT_TURN_DAYS + NVL(B.CREDIT_EXT_DAYS,0) AS CREDIT_TURN_DAYS \n");
		////sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");
		////sbSql.append("     , 'Y' AS SUM_FLAG \n");
//		////sbSql.append("     , A.CREDIT_OVER_AMOUNT \n");
		////
		////// 2009-04-06 �߰� ����. ���� : �����ѵ��ʰ��� ���� �����ѵ��ʰ����� ������ ���� ���� �߰� �� �κ�. BY ��Կ�. 
		////sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN A.CREDIT_OVER_AMOUNT ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		////// 2009-06-16 �߰� ����. ���� : �����ѵ��ʰ� �ݾ� ������ �ʵ�  �߰� �� �κ�. BY ��Կ�. �����ȣ : #28264
		////sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		//////sbSql.append("      ,A.CREDIT_OVER_END \n");
		//
		//// sbSql.append("  FROM FMS_UPJANG A \n");
		//// sbSql.append("       --B.���ſ������� \n");
		//// sbSql.append("     ,(SELECT B.UPJANG, SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
		//// sbSql.append("            , SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
		//// sbSql.append("         FROM FMS_CREDIT_EXT A, FMS_UPJANG B \n");
		//// sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//// // 2015-03-24 �߰�
		//// if (g_flag.equals("u")) 
		//// 	sbSql.append("          AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		//// else
		//// 	sbSql.append("          AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		//// sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		//// sbSql.append("          AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
		//// sbSql.append("          AND A.APPR_YN = 'Y' \n");
		//// sbSql.append("        GROUP BY B.UPJANG) B \n");
		//// sbSql.append("       --C.�ܻ��ܾ����� \n");
		//// sbSql.append("     ,(SELECT A.UPJANG, SUM((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) AS RMN_AMT \n");
		//// sbSql.append("         FROM HLDC_FM_BILL A \n");
		//// sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
		//// sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//// sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//// sbSql.append("                 AND B.UPJANG IN " + sUpjangList + " \n");
		//// sbSql.append("               GROUP BY C.BILL_ID) B \n");
		//// sbSql.append("        WHERE A.BILL_ID = B.BILL_ID(+) \n");
		//// sbSql.append("          AND A.UPJANG IN " + sUpjangList + " \n");
		//// //sbSql.append("          AND A.BILL_DATE <= '" + strDate + "' \n");
		//// // 2009-07-28 �߰� ����. ���� : �ܻ�/���� �������� ���� �� ���� ������ �����Ͱ� ���� �� �� �����͸� �ҷ� ���� ���ϹǷ� , ��ȸ���� ������ ���� ������ �ش�. BY ��Կ�. 
		//// //sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
		//// // (#29877)2009-08-18 �߰� ���� ����. 
		//// // ���� : �ܻ�/���� �ܾ��� ���� ��� ��  ��츦 ��� �Ͽ� ����(ADD_MONTHS(��¥,1))�� ���Ͽ� �ְ� 2��ġ ���� ���� ���� ���� by ��Կ�.
		//// //       ���� ȭ�� : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001
		//// sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");		
		//// // (#29877)2009-08-18 �߰� ���� ��.
		//// 
		//// sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		//// sbSql.append("          AND A.DCGUBUN = '1' \n");
		//// sbSql.append("          AND A.ACCTCD = '1110411' \n");
		//// sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) != 0 \n");
		//// sbSql.append("        GROUP BY A.UPJANG) C \n");
		//// sbSql.append("       --C1.�����ܾ����� \n");
		//// sbSql.append("     ,(SELECT A.UPJANG, SUM(A.AMOUNT - NVL(B.USE_AMT,0)) AS PRE_AMT \n");
		//// sbSql.append("            , MIN(A.RECEIPT_DATE) AS L_RECEIPT_DATE \n");
		//// sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
		//// sbSql.append("            ,(SELECT C.RECEIPT_ID, SUM(C.AMOUNT) AS USE_AMT \n");
		//// sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//// sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//// sbSql.append("                 AND B.UPJANG IN " + sUpjangList + " \n");
		//// sbSql.append("               GROUP BY C.RECEIPT_ID) B \n");
		//// sbSql.append("        WHERE A.RECEIPT_ID = B.RECEIPT_ID(+) \n");
		//// sbSql.append("          AND A.UPJANG IN " + sUpjangList + " \n");
		//// //sbSql.append("          AND A.RECEIPT_DATE <= '" + strDate + "' \n");
		//// // 2009-07-28 �߰� ����. ���� : �ܻ�/���� �������� ���� �� ���� ������ �����Ͱ� ���� �� �� �����͸� �ҷ� ���� ���ϹǷ� , ��ȸ���� ������ ���� ������ �ش�. BY ��Կ�. 
		//// //sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
		//// // (#29877)2009-08-18 �߰� ���� ����. 
		//// // ���� : �ܻ�/���� �ܾ��� ���� ��� ��  ��츦 ��� �Ͽ� ����(ADD_MONTHS(��¥,1))�� ���Ͽ� �ְ� 2��ġ ���� ���� ���� ���� by ��Կ�.
		//// //       ���� ȭ�� : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001
		//// sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");		
		//// // (#29877)2009-08-18 �߰� ���� ��.
		//// sbSql.append("          AND A.DCGUBUN = '2' \n");
		//// sbSql.append("          AND A.ACCTCD = '2110441' \n");
		//// sbSql.append("          --AND A.GANO > 0 --������� ��ǥȭ ��Ų �͸� �����Ϸ��� �ּ�����. \n");
		//// sbSql.append("          AND (A.AMOUNT - NVL(B.USE_AMT,0)) != 0 \n");
		//// sbSql.append("        GROUP BY A.UPJANG) C1 \n");
		//// sbSql.append("       --D.��� �̸��⸶���� �˼��ݾ� \n");
		//// sbSql.append("     ,(SELECT UPJANG, SUM(TR_AMT) AS TR_AMT \n");
		//// sbSql.append("         FROM (SELECT \n");
		//// sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		//// //sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//// sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//// sbSql.append("                 FROM FMS_TRANSACTION_V \n");
		//// sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		//// sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		//// //sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//// sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//// sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
		//// sbSql.append("                  AND GANO = -1 \n");
		//// //sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//// sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//// sbSql.append("                UNION ALL \n");
		//// sbSql.append("               SELECT \n");
		//// sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		//// //sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//// sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//// sbSql.append("                 FROM FMS_TRANSACTION_V \n");
		//// sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		//// //sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//// sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//// sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
		//// sbSql.append("                  AND GANO = -1 \n");
		//// //sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//// sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//// sbSql.append("              ) \n");
		//// sbSql.append("        GROUP BY UPJANG ) D \n");
		//// sbSql.append("       --E.��� �̰˼� ���ֱݾ� \n");
		//// sbSql.append("     ,(SELECT \n");
		//// sbSql.append("              A.RC_UPJANG AS UPJANG \n");
		//// sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
		//// sbSql.append("         FROM HLDC_PO_PO A \n");
		//// sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//// sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
		//// sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		//// //sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//// sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//// sbSql.append("      ) E \n");
		//// sbSql.append("       --F.��� �̹��� �ֹ��ݾ� \n");
		//// sbSql.append("     ,(SELECT \n");
		//// sbSql.append("              A.RC_UPJANG AS UPJANG \n");
		//// sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
		//// sbSql.append("         FROM SO_PR A \n");
		//// sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//// sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
		//// sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
		//// //sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//// sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//// sbSql.append("      ) F \n");
		////sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
		////sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
		////sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		////sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		////sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
		//
		//sbSql.append(" WHERE A.UPJANG = C.MAIN_UPJANG(+) \n");
        //sbSql.append("   AND A.UPJANG = C1.MAIN_UPJANG(+) \n");
        //sbSql.append("   AND A.UPJANG = D.MAIN_UPJANG(+) \n");
        //sbSql.append("   AND A.UPJANG = E.MAIN_UPJANG(+) \n");
        //sbSql.append("   AND A.UPJANG = F.MAIN_UPJANG(+) \n");
        //
		//// 2015-03-24 �߰�
		//if (g_flag.equals("u")) { 
		//	if (!ds_Cond.getString(0, "UPJANG").equals("0")) {
		//		sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		//	}
		//}	
		//else {
		//	if (!ds_Cond.getString(0, "MAIN_UPJANG").equals("0")) {	
		//		sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		//	}
		//}
		//sbSql.append("   AND A.HEAD_CREDIT_YN = 'N' \n");
		//if (!nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))
		//	sbSql.append("   AND A.USE_YN = '"+ds_Cond.getString(0, "USE_YN")+"' \n");
		////sbSql.append("   AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		////sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
		////sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = A.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}
		//
//out_vl//.add("fa_Sql", sbSql.toString());
		////System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());		
		//rs = pstmt.executeQuery(); 
		//ds_ListTmp = this.makeDataSet(rs, "ds_ListTmp");
		//rs.close();
		//pstmt.close();

		/**����**/
		//out_dl.add(ds_ListTmp);
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

--%>
