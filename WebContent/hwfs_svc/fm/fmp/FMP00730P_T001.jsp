<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : 
�� ���α׷�ID   : FMP00630V_T001.jsp
�� ���α׷���   : ���λ�ǰ ��ȸ(�˾�) 
�� �ۼ�����     : 2012-10-30
�� �ۼ���       : �ڿ��
�� �̷°���     : 2012-10-30 �����ۼ�
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//������Ʈ ��ü
	PlatformRequest platformRequest = this.proc_input(request);
	
	in_vl = platformRequest.getData().getVariableList();	//�Ķ���� �޴� ��ü
	in_dl = platformRequest.getData().getDataSetList();	//�����ͼ� �޴� ��ü
	
	//�Է� ����Ÿ��
	DataSet ds_cond   	= in_dl.get("inDs_Cond");
	
	//�Է� ����Ÿ�� �� ����
	String mainUpjang 	= nullToBlank(ds_cond.getString(0, "MAINUPJANG"));
	String upjang 		= nullToBlank(ds_cond.getString(0, "UPJANG"));
	String subinv 		= nullToBlank(ds_cond.getString(0, "SUBINV"));
	String otCust 		= nullToBlank(ds_cond.getString(0, "OT_CUST"));
	String tax	 		= nullToBlank(ds_cond.getString(0, "TAX"));
	String sdate 		= nullToBlank(ds_cond.getString(0, "SDATE"));
	String edate 		= nullToBlank(ds_cond.getString(0, "EDATE"));
	
	//�׽�Ʈ ���
	System.out.println("======================");
	System.out.println(upjang +"/"+ subinv +"/"+ otCust+"/"+ sdate+"/"+ edate);
	System.out.println("======================");
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		
		
		//���޾�ü�� ��ȭ(OTCUSTCD = '0000')�� ���	
		if (otCust.equals("0000")){	
		
			sbSql.append(" SELECT UPJANGNM_DISP \n");
			sbSql.append("      , SUBINV_CODE \n");	
			sbSql.append("      , SUBINV_NAME \n");
			sbSql.append("      , TRANS_DATE \n");
			sbSql.append("      , ITEM_CODE \n");
			sbSql.append("      , ITEM_NAME	\n");
			sbSql.append("      , ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(OP_PRICE * TRANS_QTY)) AS AMOUNT \n");
			sbSql.append("      , ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * TRANS_QTY)) AS TAX \n"); 
			sbSql.append("      , ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * TRANS_QTY)) AS TOTAL	\n");
			sbSql.append("      , ORIGIN_TYPE	\n");
			sbSql.append("      , ITEM_SIZE	\n");
			sbSql.append("      , PO_UOM	\n");
			sbSql.append("      , CLASS2_NAME \n");
			sbSql.append("      , TRANS_QTY \n");
			sbSql.append("      , OP_PRICE \n");
	        sbSql.append("	\n"); 
			sbSql.append(" FROM  (	\n");
			sbSql.append("	\n"); 
			sbSql.append(" SELECT C.UPJANGNM_DISP \n");
			sbSql.append("      , A.TRANS_TYPE \n");
			sbSql.append("      , A.TRANS_QTY \n"); 
			sbSql.append("      , A.TAX_CODE	\n");                                                                                                                                                                                                                    
			sbSql.append("      , A.SUBINV_CODE	\n");                                                                                                                                                                                                                          
			sbSql.append("      , B.SUBINV_NAME	\n");                                                                                                                                                                                                                          
			sbSql.append("      , A.TRANS_DATE	\n");                                                                                                                                                                                                                           
			sbSql.append("      , A.ITEM_CODE	\n");                                                                                                                                                                                                                            
			sbSql.append("      , A.ITEM_NAME	\n");
			sbSql.append("      , A.ORIGIN_TYPE	\n");
			sbSql.append("		, A.ITEM_SIZE   \n");
			sbSql.append("		, A.TRANS_UOM AS PO_UOM \n");
			sbSql.append("      ,(SELECT C.CLASS_NAME FROM HLDC_PO_ITEM_CLASS C WHERE A.ITEM_CLASS2 = C.CLASS_CODE)\n");
			sbSql.append("         AS CLASS2_NAME \n");
			//��� FMU_OP_RATE -> FMS_TRANSACTION_V ���� ������ 20150919 ����
			/*
			sbSql.append("      , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL	\n");              
			sbSql.append("             THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE)	\n"); 
			sbSql.append("             WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL	\n");              
			sbSql.append("             THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
			sbSql.append("             ELSE A.SALE_PRICE \n");
			sbSql.append("         END AS OP_PRICE	\n");
			*/
			sbSql.append("      , DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE --��ܰ� \n");
			sbSql.append("	\n");      
			sbSql.append("   FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			sbSql.append("      , HLDC_PO_SUBINVENTORY B, FMS_UPJANG C	\n");
			/*
			sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
			sbSql.append("           FROM FMU_OP_RATE A \n");
			sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
			sbSql.append("            AND A.ITEM_TYPE = 'M' \n");
			sbSql.append("            AND A.USE_YN = 'Y'	\n");
			sbSql.append("         ) E	\n"); 
			sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
			sbSql.append("           FROM FMU_OP_RATE A \n");
			sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
			sbSql.append("            AND A.ITEM_TYPE = 'C' \n");
			sbSql.append("            AND A.USE_YN = 'Y' \n");
			sbSql.append("         ) F	\n");
			*/
			sbSql.append("  WHERE 1=1	\n");
			sbSql.append("    AND A.TRANS_UPJANG = C.UPJANG	\n");                                                                                                                                                                                                              
			sbSql.append("    AND A.TRANS_UPJANG = B.UPJANG	\n");
			sbSql.append("    AND A.SUBINV_CODE = B.SUBINV_CODE	\n");  
			/*
			sbSql.append("    AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
			sbSql.append("    AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");  
			sbSql.append("    AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)	\n"); 
			sbSql.append("    AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)	\n");
			*/
			sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");    
			if(!sdate.equals("") && !edate.equals("")){
	        	sbSql.append("   AND A.TRANS_DATE BETWEEN '"+sdate.toString()+"' AND '"+edate.toString()+"' \n");
	        }
			if(!mainUpjang.equals("")){
				sbSql.append("   AND A.TRANS_UPJANG IN (SELECT K.UPJANG FROM FMS_UPJANG K WHERE K.MAIN_UPJANG = '"+mainUpjang.toString()+"') \n");
			}
	        if(!upjang.equals("")){
	        	sbSql.append("   AND A.TRANS_UPJANG = '"+upjang.toString()+"'\n");
	        }
	        if(!subinv.equals("")){
	        	sbSql.append("   AND B.SUBINV_CODE = '"+subinv.toString()+"' \n");
	        }
	        if(!tax.equals("")){
	        	sbSql.append("   AND A.TAX_CODE = '"+tax.toString()+"'      \n");
	        }
			sbSql.append("   )	\n");  
			sbSql.append("   ORDER BY UPJANGNM_DISP, SUBINV_NAME, TRANS_DATE, ITEM_NAME 	\n");	
			
		}
		
 	    //���޾�ü�� ��ü(OTCUSTCD = '')�� ���			
	    else if (otCust.equals("")){	
	    	
	    	sbSql.append(" SELECT T.* \n");
	    	sbSql.append("   FROM ( \n");
	    	sbSql.append(" SELECT UPJANGNM_DISP \n");
			sbSql.append("      , SUBINV_CODE \n");	
			sbSql.append("      , SUBINV_NAME \n");
			sbSql.append("      , TRANS_DATE \n");
			sbSql.append("      , ITEM_CODE \n");
			sbSql.append("      , ITEM_NAME	\n");
			sbSql.append("      , ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(OP_PRICE * TRANS_QTY)) AS AMOUNT \n");
			sbSql.append("      , ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * TRANS_QTY)) AS TAX \n"); 
			sbSql.append("      , ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * TRANS_QTY)) AS TOTAL	\n");
			sbSql.append("      , ORIGIN_TYPE	\n");
			sbSql.append("      , ITEM_SIZE	\n");
			sbSql.append("      , PO_UOM	\n");
			sbSql.append("      , TRANS_QTY	\n");
			sbSql.append("      , OP_PRICE	\n");
	        sbSql.append("	\n"); 
			sbSql.append(" FROM  (	\n");
			sbSql.append("	\n"); 
			sbSql.append(" SELECT C.UPJANGNM_DISP \n");
			sbSql.append("      , A.TRANS_TYPE \n");
			sbSql.append("      , A.TRANS_QTY \n"); 
			sbSql.append("      , A.TAX_CODE	\n");                                                                                                                                                                                                                    
			sbSql.append("      , A.SUBINV_CODE	\n");                                                                                                                                                                                                                          
			sbSql.append("      , B.SUBINV_NAME	\n");                                                                                                                                                                                                                          
			sbSql.append("      , A.TRANS_DATE	\n");                                                                                                                                                                                                                           
			sbSql.append("      , A.ITEM_CODE	\n");                                                                                                                                                                                                                            
			sbSql.append("      , A.ITEM_NAME	\n");
			sbSql.append("      , A.ORIGIN_TYPE	\n");
			sbSql.append("		, A.ITEM_SIZE   \n");
			sbSql.append("		, A.TRANS_UOM AS PO_UOM \n");
			/*
			sbSql.append("      , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL	\n");              
			sbSql.append("             THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE)	\n"); 
			sbSql.append("             WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL	\n");              
			sbSql.append("             THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
			sbSql.append("             ELSE A.SALE_PRICE \n");
			sbSql.append("         END AS OP_PRICE	\n");
			*/
			sbSql.append("      , DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE --��ܰ� \n");
			sbSql.append("	\n");      
			sbSql.append("   FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			sbSql.append("      , HLDC_PO_SUBINVENTORY B, FMS_UPJANG C	\n");
			/*
			sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
			sbSql.append("           FROM FMU_OP_RATE A \n");
			sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
			sbSql.append("            AND A.ITEM_TYPE = 'M' \n");
			sbSql.append("            AND A.USE_YN = 'Y'	\n");
			sbSql.append("         ) E	\n"); 
			sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
			sbSql.append("           FROM FMU_OP_RATE A \n");
			sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
			sbSql.append("            AND A.ITEM_TYPE = 'C' \n");
			sbSql.append("            AND A.USE_YN = 'Y' \n");
			sbSql.append("         ) F	\n");                                                                                                                                       
			*/
			sbSql.append("  WHERE 1=1	\n");
			sbSql.append("    AND A.TRANS_UPJANG = C.UPJANG	\n");                                                                                                                                                                                                              
			sbSql.append("    AND A.TRANS_UPJANG = B.UPJANG	\n");
			sbSql.append("    AND A.SUBINV_CODE = B.SUBINV_CODE	\n");  
			/*
			sbSql.append("    AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
			sbSql.append("    AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");  
			sbSql.append("    AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)	\n"); 
			sbSql.append("    AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)	\n");       
			*/
			sbSql.append("    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");    
			if(!sdate.equals("") && !edate.equals("")){
	        	sbSql.append("   AND A.TRANS_DATE BETWEEN '"+sdate.toString()+"' AND '"+edate.toString()+"' \n");
	        }
			if(!mainUpjang.equals("")) {
				sbSql.append("   AND A.TRANS_UPJANG IN (SELECT K.UPJANG FROM FMS_UPJANG K WHERE K.MAIN_UPJANG = '"+mainUpjang.toString()+"') \n");
			}
	        if(!upjang.equals("")){
	        	sbSql.append("   AND A.TRANS_UPJANG = '"+upjang.toString()+"'\n");
	        }
	        if(!subinv.equals("")){
	        	sbSql.append("   AND B.SUBINV_CODE = '"+subinv.toString()+"' \n");
	        }
	        if(!tax.equals("")){
	        	sbSql.append("   AND A.TAX_CODE = '"+tax.toString()+"'      \n");
	        }
			sbSql.append("   )	\n");  
			
			sbSql.append(" UNION ALL \n");
			
			sbSql.append(" SELECT UPJANGNM_DISP \n");
	        sbSql.append("      , SUBINV_CODE \n");  
	        sbSql.append("      , SUBINV_NAME \n");
	        sbSql.append("      , NEED_DATE AS TRANS_DATE \n");
	        sbSql.append("      , ITEM_CODE \n");
	        sbSql.append("      , ITEM_NAME  \n");
	        sbSql.append("      , ROUND(OP_PRICE * PR_QTY) AS AMOUNT \n");
	        sbSql.append("      , ROUND(DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY)) AS TAX \n"); 
	        sbSql.append("      , ROUND(DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY)) AS TOTAL  \n");
	        sbSql.append("      , ORIGIN_TYPE	\n");
			sbSql.append("      , ITEM_SIZE	\n");
			sbSql.append("      , PO_UOM	\n");
			sbSql.append("      , PR_QTY	\n");
			sbSql.append("      , OP_PRICE	\n");
	            sbSql.append("  \n"); 
	        sbSql.append(" FROM  (  \n");
	        sbSql.append("  \n"); 
	        sbSql.append(" SELECT C.UPJANGNM_DISP \n");
	        sbSql.append("      , A.PR_QTY \n"); 
	        sbSql.append("      , A.TAX_CODE  \n");                                                                                                                                                                                                                    
	        sbSql.append("      , A.SUBINV_CODE  \n");                                                                                                                                                                                                                          
	        sbSql.append("      , B.SUBINV_NAME  \n");                                                                                                                                                                                                                          
	        sbSql.append("      , A.NEED_DATE  \n");                                                                                                                                                                                                                           
	        sbSql.append("      , A.ITEM_CODE  \n");                                                                                                                                                                                                                            
	        sbSql.append("      , A.ITEM_NAME  \n");
	        sbSql.append("      , A.ORIGIN_TYPE  \n");
			sbSql.append("		, A.ITEM_SIZE   \n");
			sbSql.append("		, A.PO_UOM \n");
			/*
	        sbSql.append("      , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL  \n");              
	        sbSql.append("             THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE)  \n"); 
	        sbSql.append("             WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL  \n");              
	        sbSql.append("             THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
	        sbSql.append("             ELSE A.SALE_PRICE \n");
	        sbSql.append("         END AS OP_PRICE  \n");
	        */
	        sbSql.append("      , A.OP_PRICE AS OP_PRICE \n");
	        sbSql.append("  \n");      
	        sbSql.append("   FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
	        sbSql.append("      , HLDC_PO_SUBINVENTORY B, FMS_UPJANG C  \n");
	        /*
	        sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
	        sbSql.append("           FROM FMU_OP_RATE A \n");
	        sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
	        sbSql.append("            AND A.ITEM_TYPE = 'M' \n");
	        sbSql.append("            AND A.USE_YN = 'Y'  \n");
	        sbSql.append("         ) E  \n"); 
	        sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
	        sbSql.append("           FROM FMU_OP_RATE A \n");
	        sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
	        sbSql.append("            AND A.ITEM_TYPE = 'C' \n");
	        sbSql.append("            AND A.USE_YN = 'Y' \n");
	        sbSql.append("         ) F  \n");                                                                                                                                       
	        */
	        sbSql.append("  WHERE 1=1  \n");
	        sbSql.append("    AND A.UPJANG = C.UPJANG  \n");                                                                                                                                                                                                              
	        sbSql.append("    AND A.UPJANG = B.UPJANG  \n");
	        sbSql.append("    AND A.SUBINV_CODE = B.SUBINV_CODE  \n");  
	        /*
	        sbSql.append("    AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
	        sbSql.append("    AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");  
	        sbSql.append("    AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)  \n"); 
	        sbSql.append("    AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)  \n");       
	        */
	        if(!sdate.equals("") && !edate.equals("")){
	              sbSql.append("   AND A.NEED_DATE BETWEEN '"+sdate.toString()+"' AND '"+edate.toString()+"' \n");
	            }
	        	if(!mainUpjang.equals("")){
	        		sbSql.append("   AND A.UPJANG IN (SELECT K.UPJANG FROM FMS_UPJANG K WHERE K.MAIN_UPJANG = '"+mainUpjang.toString()+"') \n");
	        	}
	            if(!upjang.equals("")){
	              sbSql.append("   AND A.UPJANG = '"+upjang.toString()+"'\n");
	            }
	            if(!subinv.equals("")){
	              sbSql.append("   AND B.SUBINV_CODE = '"+subinv.toString()+"' \n");
	            }
	            if(!tax.equals("")){
	              sbSql.append("   AND A.TAX_CODE = '"+tax.toString()+"'      \n");
	            }
	        sbSql.append("   )  \n");  
	        sbSql.append("   ) T  \n");
	        
	        sbSql.append("   ORDER BY T.UPJANGNM_DISP, T.SUBINV_NAME, T.TRANS_DATE, T.ITEM_NAME \n");  
			
	    }	
		//���޾�ü�� ��ȭ �� ���� �� ���
	    else{
	    	
	    	sbSql.append(" SELECT UPJANGNM_DISP \n");
	        sbSql.append("      , SUBINV_CODE \n");  
	        sbSql.append("      , SUBINV_NAME \n");
	        sbSql.append("      , NEED_DATE AS TRANS_DATE \n");
	        sbSql.append("      , ITEM_CODE \n");
	        sbSql.append("      , ITEM_NAME  \n");
	        sbSql.append("      , ROUND(OP_PRICE * PR_QTY) AS AMOUNT \n");
	        sbSql.append("      , ROUND(DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY)) AS TAX \n"); 
	        sbSql.append("      , ROUND(DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY)) AS TOTAL  \n");
	        sbSql.append("      , ORIGIN_TYPE  \n");
			sbSql.append("      , ITEM_SIZE	\n");
			sbSql.append("      , PO_UOM	\n");
			sbSql.append("      , PR_QTY	\n");
			sbSql.append("      , OP_PRICE	\n");
	            sbSql.append("  \n"); 
	        sbSql.append(" FROM  (  \n");
	        sbSql.append("  \n"); 
	        sbSql.append(" SELECT C.UPJANGNM_DISP \n");
	        sbSql.append("      , A.PR_QTY \n"); 
	        sbSql.append("      , A.TAX_CODE  \n");                                                                                                                                                                                                                    
	        sbSql.append("      , A.SUBINV_CODE  \n");                                                                                                                                                                                                                          
	        sbSql.append("      , B.SUBINV_NAME  \n");                                                                                                                                                                                                                          
	        sbSql.append("      , A.NEED_DATE  \n");                                                                                                                                                                                                                           
	        sbSql.append("      , A.ITEM_CODE  \n");                                                                                                                                                                                                                            
	        sbSql.append("      , A.ITEM_NAME  \n");
	        sbSql.append("      , A.ORIGIN_TYPE  \n");
			sbSql.append("      , A.ITEM_SIZE	\n");
			sbSql.append("      , A.PO_UOM	\n");
			/*
	        sbSql.append("      , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL  \n");              
	        sbSql.append("             THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE)  \n"); 
	        sbSql.append("             WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL  \n");              
	        sbSql.append("             THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
	        sbSql.append("             ELSE A.SALE_PRICE \n");
	        sbSql.append("         END AS OP_PRICE  \n"); 
	        */
	        sbSql.append("      , A.OP_PRICE AS OP_PRICE \n");
	        sbSql.append("  \n");      
	        sbSql.append("   FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
	        sbSql.append("      , HLDC_PO_SUBINVENTORY B, FMS_UPJANG C  \n");
	        /*
	        sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
	        sbSql.append("           FROM FMU_OP_RATE A \n");
	        sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
	        sbSql.append("            AND A.ITEM_TYPE = 'M' \n");
	        sbSql.append("            AND A.USE_YN = 'Y'  \n");
	        sbSql.append("         ) E  \n"); 
	        sbSql.append("      , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n"); 
	        sbSql.append("           FROM FMU_OP_RATE A \n");
	        sbSql.append("          WHERE A.UPJANG = '"+upjang.toString()+"' \n");
	        sbSql.append("            AND A.ITEM_TYPE = 'C' \n");
	        sbSql.append("            AND A.USE_YN = 'Y' \n");
	        sbSql.append("         ) F  \n");                                                                                                                                       
	        */
	        sbSql.append("  WHERE 1=1  \n");
	        sbSql.append("    AND A.UPJANG = C.UPJANG  \n");                                                                                                                                                                                                              
	        sbSql.append("    AND A.UPJANG = B.UPJANG  \n");
	        sbSql.append("    AND A.SUBINV_CODE = B.SUBINV_CODE  \n"); 
	        /*
	        sbSql.append("    AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
	        sbSql.append("    AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");  
	        sbSql.append("    AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)  \n"); 
	        sbSql.append("    AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)  \n");       
	        */
	        if(!sdate.equals("") && !edate.equals("")){
	              sbSql.append("   AND A.NEED_DATE BETWEEN '"+sdate.toString()+"' AND '"+edate.toString()+"' \n");
	            }
		        if(!mainUpjang.equals("")){
	        		sbSql.append("   AND A.UPJANG IN (SELECT K.UPJANG FROM FMS_UPJANG K WHERE K.MAIN_UPJANG = '"+mainUpjang.toString()+"') \n");
	        	}
	            if(!upjang.equals("")){
	              sbSql.append("   AND A.UPJANG = '"+upjang.toString()+"'\n");
	            }
	            if(!subinv.equals("")){
	              sbSql.append("   AND B.SUBINV_CODE = '"+subinv.toString()+"' \n");
	            }
	            if(!tax.equals("")){
	              sbSql.append("   AND A.TAX_CODE = '"+tax.toString()+"'      \n");
	            }
	        sbSql.append("   )  \n");  
	        sbSql.append("   ORDER BY UPJANGNM_DISP, SUBINV_NAME, TRANS_DATE, ITEM_NAME \n");  
	    
		
	    }
		
        //��� �Ķ���� ����
		out_vl.add("fa_Sql", sbSql.toString());
		
		//������ ����
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set���� ���� �����ͼ� ����
		ds_list = this.makeDataSet(rs, "ds_List");
		
		//��� ������ ����Ʈ�� ������ �� �߰� 
		out_dl.add(ds_list);
		
		//��� ��������Ʈ�� �޼����� ����
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
