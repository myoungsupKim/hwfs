<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ű���/��ǰ��������
�� ���α׷�ID   : FMP00840V_T001.jsp
�� ���α׷���   : ��ǰ�̷���ȸ
�� �ۼ�����     : 2008-04-10
�� �ۼ���       : ������
�� �̷°���     : 2008-04-10
               2009-07-24 ������ CSR#(29350) ��û��:����(����������)
               ������ �������濡 ���� �����׸� ����
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
		DataSet ds_List;
		
		//sql�� ���ۻ���
		StringBuffer sbSql_tmp = new StringBuffer();
		sbSql_tmp.delete(0,sbSql_tmp.length());
		
		String strKeyword	= "";
		
		if(!nullToBlank(ds_Cond.getString(0, "ITEM_CODE")).equals(""))
		{
// [�ӵ����� Project ����] 2017. 8. 28. �ֹ��� ���� ���� ���ε���� �߰�			
			String[] arrSameWord_tmp = nullToBlank(ds_Cond.getString(0, "ITEM_CODE")).split(" ");

			sbSql_tmp.setLength(0);
            sbSql_tmp.append("/* fm/fmp/FMP00840V_T001.jsp */                                                 \n");
			sbSql_tmp.append("SELECT LISTAGG(T.ITEM_NAME, ',') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME \n");
			sbSql_tmp.append("  FROM ( SELECT KEYWORD||','||SIM_TXT AS ITEM_NAME                              \n");
			sbSql_tmp.append("              , '1' AS ITEM_GROUP                                               \n");
			sbSql_tmp.append("           FROM EPROCUSR.VO_ITEM_SIM_WORD                                       \n");
			sbSql_tmp.append("          WHERE 1=1 															  \n");
			sbSql_tmp.append("            AND  ( 															  \n");
			for(int i=0; i<arrSameWord_tmp.length; i++) {
				sbSql_tmp.append("            		KEYWORD LIKE :KEYWORD" + i + "	                          \n");
				if(i < arrSameWord_tmp.length-1) {
					sbSql_tmp.append("  		OR 															  \n");
				}
			}
			sbSql_tmp.append("    				) 															  \n");
			sbSql_tmp.append("       ) T                                                                      \n");
			
			out_vl.add("fa_Sql", sbSql_tmp.toString());
			
			npstmt = new NamedParameterStatement(conn, sbSql_tmp.toString());
            for ( int i = 0; i < arrSameWord_tmp.length; i++ ) {
		        npstmt.setString("KEYWORD" + i, "%" + arrSameWord_tmp[i] + "%");
            }
	        rs = npstmt.executeQuery();
			
			if(rs.next()) {				
				strKeyword += nullToBlank(rs.getString("ITEM_NAME"));
				for (int i=0; i<arrSameWord_tmp.length; i++) {
					if ( strKeyword.indexOf(arrSameWord_tmp[i]) == -1 ) { //�ߺ�����
						if ( strKeyword.length() > 0 ) {
							strKeyword += ","; 
						}
						strKeyword += arrSameWord_tmp[i];	
					}
				}
			}			
			npstmt.close();
	        rs.close();
	        sbSql_tmp.setLength(0);
// [�ӵ����� Project ����] 2017. 8. 28. �ֹ���
		}
		String[] strKeyword_ItemName = strKeyword.split(",");
		
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		String sItemClass2 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2"));
		String sItemClass3 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3"));
		String sItemClass4 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4"));
		String sItemCode   = nullToBlank(ds_Cond.getString(0, "ITEM_CODE"));
		
		//������ȸ
		
		sbSql.append("SELECT A.ITEM_CODE \n");  
		sbSql.append("     , C.ITEM_NAME \n"); 
		sbSql.append("     , C.PO_UOM \n"); 
		sbSql.append("     , C.ITEM_SIZE \n"); 
		sbSql.append("     , DECODE(C.TAX_CODE,'100','����','�鼼') AS TAX_CODE --���鼼 \n"); 
		sbSql.append("     , C.KEEPING_TYPE --������� \n"); 
		sbSql.append("     , C.ORIGIN_TYPE  --������ \n"); 
		//sbSql.append("     , DECODE(NVL(D.D_DAYS,0), 0, '����', 'D-'||(D.D_DAYS+1)||' '||DECODE(NVL(D.D_TIMES,0),0,NULL,D.D_TIMES||'��')) D_DAY --�������� \n"); 
		sbSql.append(" 	     /* ���� D_DAYS ���(���� +1 ����) */ \n");
		sbSql.append("     , DECODE(NVL(D.D_DAYS,0), 0, '����', 'D-'||D.D_DAYS||' '||DECODE(NVL(D.D_TIMES,0),0,NULL,D.D_TIMES||'��')) D_DAY --�������� \n");
		sbSql.append("     , B.PART_NAME \n");
		sbSql.append("     , B.BLNUMBER \n"); 
		sbSql.append("     , B.ITEM_GRADE \n");
		sbSql.append("     , B.IDNUMBER \n");
		sbSql.append("     , B.CONF_NUM \n");
		sbSql.append("     , B.BUTCH_NAME \n"); 
		sbSql.append("     , B.MATERIAL_INFO \n");
		sbSql.append("     , B.LIFEDAY_INFO \n"); 
		sbSql.append("     , B.ATTENTION_INFO \n"); 
		sbSql.append("     -- HLDC_PO_PO_HIST�信 ���ǵ��� ���� �÷� \n");
		sbSql.append("     --, B.ORIGIN_QUALITY \n");
		sbSql.append("     --, B.ORIGIN_INFO \n");
		sbSql.append("     --, B.PRODUCT_YEAR \n");
		sbSql.append("     --, B.BOXING_QTY \n"); 
		sbSql.append("     --, B.PREJOB_DATE \n");
		sbSql.append("     --, B.ITEM_FEATURE  --����Ư�� \n"); 
		sbSql.append("     --, NVL2(B.DOCU_FILE1,'Y','N') DOCU_YN -- �����ڷ� \n"); 
		sbSql.append("     --, B.NUT_INFO --��������� \n"); 
		sbSql.append("     --, B.MARKET_TREND --���嵿�� \n"); 
		
		sbSql.append("     --, B.DOCU_FILE1 \n"); 
		sbSql.append("     --, B.DOCU_FILE2 \n"); 
		sbSql.append("     --, B.DOCU_FILE3 \n"); 
		sbSql.append("     --, B.DOCU_FILE4 \n"); 
		sbSql.append("     --, B.DOCU_FILE5 \n"); 
		sbSql.append("     --, B.SDOCU_FILE1 \n"); 
		sbSql.append("     --, B.SDOCU_FILE2 \n"); 
		sbSql.append("     --, B.SDOCU_FILE3 \n"); 
		sbSql.append("     --, B.SDOCU_FILE4 \n"); 
		sbSql.append("     --, B.SDOCU_FILE5 \n"); 
		sbSql.append("     --, B.SDOCU_FILE_SIZE1 \n"); 
		sbSql.append("     --, B.SDOCU_FILE_SIZE2 \n"); 
		sbSql.append("     --, B.SDOCU_FILE_SIZE3 \n"); 
		sbSql.append("     --, B.SDOCU_FILE_SIZE4 \n"); 
		sbSql.append("     --, B.SDOCU_FILE_SIZE5 \n");
		
		sbSql.append("  FROM HLDC_PO_CUSTOM_ITEM A \n");
		sbSql.append("     , HLDC_PO_PO_HIST B \n");
		sbSql.append("     , HLDC_PO_ITEM_MST C \n");
		sbSql.append("     , HLDC_PO_PREORDER_LIST D \n");
		sbSql.append("     , (SELECT RC_UPJANG, ITEM_CODE, MAX(PO_ID) AS PO_ID \n");  
        sbSql.append("          FROM EPROCUSR.VO_PO \n");
        sbSql.append("         WHERE RC_UPJANG = " + nullToBlank(ds_Cond.getString(0,"UPJANG")) + " \n");
        sbSql.append("         GROUP BY RC_UPJANG, ITEM_CODE \n");
        sbSql.append("       ) E \n");
		
		sbSql.append(" WHERE A.CENTER_UPJANG = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0,"UPJANG")) + ") \n");
		sbSql.append("   AND A.USE_TYPE = '01' \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("   AND A.CENTER_UPJANG = D.CENTER_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND E.PO_ID = B.PO_ID(+) \n");
		
		if (! sItemClass2.equals(""))
			sbSql.append("   AND C.ITEM_CLASS2 = '" + sItemClass2 + "' \n");
		if (! sItemClass3.equals(""))
			sbSql.append("   AND C.ITEM_CLASS3 = '" + sItemClass3 + "' \n");
		if (! sItemClass4.equals(""))
			sbSql.append("   AND C.ITEM_CLASS4 = '" + sItemClass4 + "' \n");
		//if (! sItemCode.equals(""))
		//	sbSql.append("   AND (C.ITEM_CODE LIKE '" + sItemCode + "%' OR C.ITEM_NAME LIKE '%" + sItemCode + "%') \n");
		
		if (! sItemCode.equals("")) {
			sbSql.append("   AND (		\n");
			
			for(int i=0; i<strKeyword_ItemName.length; i++) {
				sbSql.append("   			C.ITEM_CODE LIKE '" + strKeyword_ItemName[i] + "'||'%' \n");
				sbSql.append("   		OR  C.ITEM_NAME LIKE '%'||'" + strKeyword_ItemName[i] + "'||'%' \n");
				if(i < strKeyword_ItemName.length-1) {
					sbSql.append("  OR \n");
				}
			}
			sbSql.append("   	 ) \n");
		}
		
		
		sbSql.append(" ORDER BY A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);
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
// [�ӵ����� Project ����] 2017. 8. 28. �ֹ��� ���� ���� ���ε���� �߰�
        if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
// [�ӵ����� Project ����] 2017. 8. 28. �ֹ���		
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
	
		//HLDC�� �翬��
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();

		String sItemClass2 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS2"));
		String sItemClass3 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS3"));
		String sItemClass4 = nullToBlank(ds_Cond.getString(0, "ITEM_CLASS4"));
		String sItemCode   = nullToBlank(ds_Cond.getString(0, "ITEM_CODE"));
		//������ȸ
		sbSql.append("SELECT B.HIST_ID \n");
		sbSql.append("     , A.ITEM_CODE \n");
		sbSql.append("     , C.ITEM_NAME \n");
		sbSql.append("     , C.PO_UOM \n");
		sbSql.append("     , C.ITEM_SIZE \n");
		sbSql.append("     , DECODE(C.TAX_CODE,'100','����','�鼼') AS TAX_CODE --���鼼 \n");
		sbSql.append("     , C.KEEPING_TYPE --������� \n");
		sbSql.append("     , C.ORIGIN_TYPE  --������ \n");
		sbSql.append("     , DECODE(NVL(D.D_DAYS,0), 0, '����', 'D-'||(D.D_DAYS+1)||' '||DECODE(NVL(D.D_TIMES,0),0,NULL,D.D_TIMES||'��')) D_DAY --�������� \n");
		sbSql.append("     , B.ITEM_FEATURE  --����Ư�� \n");
		sbSql.append("     , NVL2(B.DOCU_FILE1,'Y','N') DOCU_YN -- �����ڷ� \n");
		sbSql.append("     , B.NUT_INFO --��������� \n");
		sbSql.append("     , B.MARKET_TREND --���嵿�� \n");
		sbSql.append("     , B.APRV_YN --���ο��� \n");
		sbSql.append("     , B.DOCU_FILE1 \n");
		sbSql.append("     , B.DOCU_FILE2 \n");
		sbSql.append("     , B.DOCU_FILE3 \n");
		sbSql.append("     , B.DOCU_FILE4 \n");
		sbSql.append("     , B.DOCU_FILE5 \n");
		sbSql.append("     , B.SDOCU_FILE1 \n");
		sbSql.append("     , B.SDOCU_FILE2 \n");
		sbSql.append("     , B.SDOCU_FILE3 \n");
		sbSql.append("     , B.SDOCU_FILE4 \n");
		sbSql.append("     , B.SDOCU_FILE5 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE1 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE2 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE3 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE4 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE5 \n");
		//2008.12.18 ������ : �������/����⵵/��ó���۾���/���ο�����/������/��ü�ĺ���ȣ/������� �߰�
//============================================================================================
//(2009-07-24 �߰�) ����
// 2009-07-24 ������ CSR#(29350) ��û��:����(����������)
// ������ �������濡 ���� �����׸� ����
//============================================================================================
		sbSql.append("     , B.ORIGIN_QUALITY, B.ORIGIN_INFO, B.PRODUCT_YEAR, B.BOXING_QTY \n");
		sbSql.append("     , B.PREJOB_DATE, B.PART_NAME, B.BLNUMBER \n");
		sbSql.append("     , B.ITEM_GRADE, B.IDNUMBER, B.CONF_NUM, B.BUTCH_NAME \n");
		//
		sbSql.append("     , B.ITEM_PRT_NAME, B.MATERIAL_INFO, B.LIFEDAY_INFO \n");
		sbSql.append("     , B.KEEPING_METHOD, B.ATTENTION_INFO \n");
//============================================================================================
//(2009-07-24 �߰�) ��
//============================================================================================
		sbSql.append("  FROM PO_CUSTOM_ITEM A \n");
		sbSql.append("     , PO_ITEM_HIST B \n");
		sbSql.append("     , PO_ITEM_MST C \n");
		sbSql.append("     , PO_PREORDER_LIST D \n");
		sbSql.append(" WHERE A.CENTER_UPJANG = (SELECT A.CENTER_CODE FROM PO_UPJANG_CENTER A, ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_Cond.getString(0,"UPJANG")) + ") \n");
		sbSql.append("   AND A.CENTER_UPJANG = B.CENTER_CODE \n");
		sbSql.append("   AND A.CUSTCD = B.CUSTCD \n");
		sbSql.append("   AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("   AND A.USE_TYPE = '01' \n");
		sbSql.append("   AND B.APRV_YN = 'Y' AND B.USE_YN = 'Y' \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("   AND A.CENTER_UPJANG = D.CENTER_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		if (! sItemClass2.equals(""))
			sbSql.append("   AND C.ITEM_CLASS2 = '" + sItemClass2 + "' \n");
		if (! sItemClass3.equals(""))
			sbSql.append("   AND C.ITEM_CLASS3 = '" + sItemClass3 + "' \n");
		if (! sItemClass4.equals(""))
			sbSql.append("   AND C.ITEM_CLASS4 = '" + sItemClass4 + "' \n");
		if (! sItemCode.equals(""))
			sbSql.append("   AND (C.ITEM_CODE LIKE '" + sItemCode + "%' OR C.ITEM_NAME LIKE '%" + sItemCode + "%') \n");
		sbSql.append(" ORDER BY A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);
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

--%>