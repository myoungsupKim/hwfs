<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/���Ұ���
�� ���α׷�ID   : FMP00681P_T001.jsp
�� ���α׷���   : �ŷ��������� ����ȸ
�� �ۼ�����     : 2008-08-08 
�� �ۼ���       : ������
�� �̷°���     : ���� CSR#[27433]
                     2009-05-18(��) SQL ���� BY ��Կ�
                     ���� >> ���� ��ȸ ȭ�鿡 ���� �� ������ �ܰ� ���� ǥ�� �߰�.  
   			   [����] 2009/07/22 BY ��Կ�
  			    : ���� ����� ���̺� FM_SALE_RATE ���� ��/�鼼 ��(%)�� ���� ���� �ϱ� ���� ����.
  			    DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))                     
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sWhere       = nullToBlank(in_vl.getString("sWhere"));
		
		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		//������ȸ
		sbSql.append("SELECT A.* FROM \n");
		sbSql.append("( \n");
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{

			sbSql.append("SELECT \n");
			if (sType.equals("001"))
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("       A.TRANS_UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP AS SUBINV_NAME_DISP \n");
			
			/*������ �߰� -> 20150528 ������ �Ŵ��� ��û*/
			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");
			//CSR#[27433]  ����
     		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");
			//CSR#[27433]  ����� �ܰ�
			/* 2015-11-02
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) \n");			
			sbSql.append("       * ROUND(\n");

			//sbSql.append("         CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append( "        DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) \n");
			sbSql.append("       )) AS SALE_PRICE \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) \n");
			sbSql.append("       * ROUND(A.TRANS_QTY \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append( "      * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) \n");
			sbSql.append("       )) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) \n");
			sbSql.append("       * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append( "      * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) \n");
			sbSql.append("       )) AS OP_NOTAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) \n");
			sbSql.append("       * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append( "      * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) \n");
			sbSql.append("       )) AS OP_TAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) \n");
			sbSql.append("       * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append( "      * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) \n");
			sbSql.append("       ))) AS OP_VAT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) \n");
			sbSql.append("       * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append( "      * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) \n");
			sbSql.append("       ))) AS OP_TOT \n");
			*/

			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE))) AS SALE_PRICE \n");			
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) )) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE))) AS OP_NOTAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE))) AS OP_TAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)))) AS OP_VAT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE)))) AS OP_TOT \n");
			
			//CSR#[27433]  ����ݾ�(��� ����)
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE)) AS SALE_PRICE1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_PRICE * A.TRANS_QTY)) AS OP_VAT1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_PRICE * A.TRANS_QTY)) AS OP_TOT1 \n");
			
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			//sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT + A.TRANS_QTY * A.SALE_VAT)) AS OP_VAT1 \n");
			//sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT + A.TRANS_QTY * A.SALE_VAT)) AS OP_TOT1 \n");
			
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) AS SALE_PRICE2 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT2 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX2 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX2 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT2 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT2 \n");				
			
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT2 \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))))) AS OP_NOTAX2 \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))),0)) AS OP_TAX2 \n");			
			//sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_VAT2 \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) \n");
			//sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_TOT2 \n");
			
			sbSql.append("  FROM (SELECT A.* , B.ORIGIN_TYPE, B.ITEM_CLASS3, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			sbSql.append("     , FMS_UPJANG B, FMS_SUBINVENTORY C \n");
			
			sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CODE, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_ITEM_SALE_RATE -- ���纰 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("       ) D \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS4, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- ���з��� \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 7 \n");
		    sbSql.append("       ) E \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS3, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- �Һз��� \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 5 \n");
		    sbSql.append("       ) F \n");
		    /*
		    sbSql.append("      ,( \n");   
			sbSql.append("       SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE  \n");
			sbSql.append("         FROM FMU_OP_RATE -- ���纰��� \n");
			sbSql.append("        WHERE USE_YN = 'Y' \n");
			sbSql.append("          AND ITEM_TYPE = 'M' \n");
			sbSql.append("       ) G \n");
			sbSql.append("      ,( \n");        
			sbSql.append("       SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE \n");
			sbSql.append("         FROM FMU_OP_RATE -- �з������\n");
			sbSql.append("        WHERE USE_YN = 'Y' \n");
			sbSql.append("          AND ITEM_TYPE = 'C' \n");
			sbSql.append("       ) H \n");
			*/			
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.SUBINV_CODE  = C.SUBINV_CODE \n");
			sbSql.append("   AND A.TRANS_UPJANG = D.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_UPJANG = E.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_UPJANG = F.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) \n");
		    /*
		    sbSql.append("   AND A.TRANS_UPJANG = G.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_UPJANG = H.UPJANG(+) \n");
		    sbSql.append("   AND A.TRANS_DATE BETWEEN G.SDATE(+) AND G.EDATE(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN H.SDATE(+) AND H.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = G.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = H.ITEM_CODE(+) \n");
			*/
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			/* if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n"); */
			if (sType.equals("001"))
				sbSql.append("   AND A.TRANS_UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.TRANS_DATE = REPLACE('" + sWhere + "','-') \n");
			if (sType.equals("001"))
				sbSql.append(" GROUP BY A.TRANS_DATE \n");
			else
				sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM, A.ORIGIN_TYPE\n");
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT A.UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP AS SUBINV_NAME_DISP \n");
			
			/*������ �߰� -> 20150528 ������ �Ŵ��� ��û*/
			sbSql.append("     , A.ORIGIN_TYPE AS ORIGIN_TYPE \n");
			
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			//CSR#[27433]  ����
			sbSql.append("     , SUM(ROUND(A.PR_QTY)) AS TRANS_QTY \n");			
			//CSR#[27433]  ����� �ܰ�
			
			/* 2015-11-02
			sbSql.append("     , SUM( \n");

			//sbSql.append("           CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("            THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("            WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("            THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("            ELSE A.SALE_PRICE END \n");

			sbSql.append("            DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) \n");
			sbSql.append("          ) AS SALE_PRICE \n");
			
			sbSql.append("     , SUM(ROUND(A.PR_QTY \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append("       * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) \n");
			sbSql.append("       )) AS OP_AMOUNT \n");
			
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append("       * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) \n");
			sbSql.append("       )) AS OP_NOTAX \n");
			
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append("       * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) \n");
			sbSql.append("       )) AS OP_TAX \n");
			
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append("       * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) \n");
			sbSql.append("       ))) AS OP_VAT \n");
			
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY \n");

			//sbSql.append("       * CASE WHEN G.OP_PRICE IS NOT NULL OR G.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(G.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(G.OP_RATE,0) / 100),G.CEIL_VAL), G.OP_PRICE) \n");
			//sbSql.append("              WHEN H.OP_PRICE IS NOT NULL OR H.OP_RATE IS NOT NULL \n");
			//sbSql.append("              THEN DECODE(SIGN(NVL(H.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(H.OP_RATE,0) / 100),H.CEIL_VAL), H.OP_PRICE) \n");
			//sbSql.append("              ELSE A.SALE_PRICE END \n");

			sbSql.append("       * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) \n");
			sbSql.append("       ))) AS OP_TOT \n");
			*/
			
			sbSql.append("     , SUM(DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE)) AS SALE_PRICE \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE))) AS OP_AMOUNT \n");			
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE))) AS OP_NOTAX \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE))) AS OP_TAX \n");			
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE)))) AS OP_VAT \n");			
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY ))) AS OP_TOT \n");			
			
			//CSR#[27433]  ����ݾ�(��� ����)	
			sbSql.append("     , ROUND(SUM(A.SALE_PRICE)) AS SALE_PRICE1 \n");	
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS OP_VAT1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS OP_TOT1 \n");

			sbSql.append("     , SUM(ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) AS SALE_PRICE2 \n");			
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT2 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0,1)) AS OP_NOTAX2 \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1,0)) AS OP_TAX2 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS OP_VAT2 \n");
			sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS OP_TOT2 \n");				
			
			//sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS OP_AMOUNT2 \n");
			//sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))))) AS OP_NOTAX2 \n");
			//sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))),0)) AS OP_TAX2 \n");			
			//sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_VAT2 \n");
			//sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) \n");
			//sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT2 \n");
			
			sbSql.append("  FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS3, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			sbSql.append("       , FMS_UPJANG B, FMS_SUBINVENTORY C \n");
			
			sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CODE, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_ITEM_SALE_RATE -- ���纰 \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("       ) D \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS4, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- ���з��� \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 7 \n");
		    sbSql.append("       ) E \n");
		    sbSql.append("      ,( \n");
		    sbSql.append("       SELECT UPJANG, SUBINV_CODE, ITEM_CLASS AS ITEM_CLASS3, FM_SALE_RATE, FM_NOSALE_RATE, SDATE, EDATE \n");
		    sbSql.append("         FROM FMS_SALE_RATE A -- �Һз��� \n");
			sbSql.append("        WHERE CASH_CODE = '003' \n");
		    sbSql.append("          AND (FM_SALE_RATE >= 0 OR FM_NOSALE_RATE >= 0) \n");
		    sbSql.append("          AND USE_YN = 'Y' \n");
		    sbSql.append("          AND LENGTH(ITEM_CLASS) = 5 \n");
		    sbSql.append("       ) F \n");
		    /*
		    sbSql.append("      ,( \n");   
			sbSql.append("       SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE  \n");
			sbSql.append("         FROM FMU_OP_RATE -- ���纰��� \n");
			sbSql.append("        WHERE USE_YN = 'Y' \n");
			sbSql.append("          AND ITEM_TYPE = 'M' \n");
			sbSql.append("       ) G \n");
			sbSql.append("      ,( \n");        
			sbSql.append("       SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE \n");
			sbSql.append("         FROM FMU_OP_RATE -- �з������\n");
			sbSql.append("        WHERE USE_YN = 'Y' \n");
			sbSql.append("          AND ITEM_TYPE = 'C' \n");
			sbSql.append("       ) H \n");
			*/
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.SUBINV_CODE  = C.SUBINV_CODE \n");
			sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		    sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		    sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) \n");
		    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) \n");
		    /*
		    sbSql.append("   AND A.UPJANG = G.UPJANG(+) \n");
		    sbSql.append("   AND A.UPJANG = H.UPJANG(+) \n");
		    sbSql.append("   AND A.NEED_DATE BETWEEN G.SDATE(+) AND G.EDATE(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN H.SDATE(+) AND H.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE = G.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = H.ITEM_CODE(+) \n");
			*/
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
/* 			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n"); */
			if (sType.equals("001"))
				sbSql.append("   AND A.UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.NEED_DATE = REPLACE('" + sWhere + "','-') \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			
			
			if (sType.equals("001"))
				 sbSql.append(" GROUP BY A.NEED_DATE \n");
			else
				sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");
			
			sbSql.append("     , A.SUBINV_CODE, C.SUBINV_NAME_DISP, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOMA.ORIGIN_TYPE \n");
			
		}
		sbSql.append(") A \n");
		sbSql.append(" ORDER BY A.NEED_DATE_ORI, A.SUBINV_CODE, A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**����**/
		out_dl.add(ds_list);
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		String sWhere       = nullToBlank(in_vl.getString("sWhere"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out ����Ÿ
		DataSet ds_list;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		//������ȸ
		sbSql.append("SELECT A.* FROM \n");
		sbSql.append("( \n");
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{

			sbSql.append("SELECT /*+ INDEX(A PO_TRANSACTION_PT_I8) */ \n");
			if (sType.equals("001"))
				sbSql.append("       A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("       A.TRANS_UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, D.SUBINV_NAME AS SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM AS PO_UOM \n");

			//CSR#[27433]  ����
     		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");
			//CSR#[27433]  ����� �ܰ�
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS SALE_PRICE \n");			
			
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
			
			
			//CSR#[27433]  ����ݾ�(��� ����)
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE) AS SALE_PRICE1 \n");
					
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT + A.TRANS_QTY * A.SALE_VAT)) AS OP_VAT1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT + A.TRANS_QTY * A.SALE_VAT)) AS OP_TOT1 \n");
			
			//CSR#[27433]  ����ݾ�(��� ����)
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************			
//			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))) AS SALE_PRICE2 \n");			
//			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))))) AS OP_AMOUNT2 \n");
//			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100)))))) AS OP_NOTAX2 \n");
//			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100)))),0)) AS OP_TAX2 \n");
			sbSql.append("     , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)) AS SALE_PRICE2 \n");			
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)))) AS OP_AMOUNT2 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))))) AS OP_NOTAX2 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))),0)) AS OP_TAX2 \n");			
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************			
			//�ΰ����� ��������� �������� �ʴ´�. ���� �հ� �� ����
			sbSql.append("     , ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_VAT2 \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
//			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))))) \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)))) \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
			sbSql.append("     + ROUND(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1 + A.TRANS_QTY*A.SALE_VAT,0))) AS OP_TOT2 \n");
			sbSql.append("  FROM PO_TRANSACTION A, HWFS_FMS_UPJANG B, HWFS_FMU_OP_RATE C, FM_SALE_RATE K, PO_SUBINVENTORY D \n");
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.SUBINV_CODE = K.SUBINV_CODE(+) \n");
			sbSql.append("   AND SUBSTR(A.ITEM_CODE,1,8) = K.ITEM_CLASS(+) \n");			
			sbSql.append("   AND A.TRANS_DATE BETWEEN K.SDATE(+) AND K.EDATE(+) \n");
			sbSql.append("   AND K.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append("   AND A.TRANS_UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.TRANS_DATE = REPLACE('" + sWhere + "','-') \n");
			if (sType.equals("001"))
				{sbSql.append(" GROUP BY A.TRANS_DATE,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))  \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************				
//				 sbSql.append(" ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE), DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))) \n");
				 sbSql.append(" ,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE), DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)) \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
				}
			else
				sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP \n");
			sbSql.append("     , A.SUBINV_CODE, D.SUBINV_NAME,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************			
//			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE), DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))) \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.TRANS_UOM,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE), DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)) \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			else
				sbSql.append("SELECT A.UPJANG AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE \n");
			sbSql.append("     , A.SUBINV_CODE, D.SUBINV_NAME AS SUBINV_NAME_DISP \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			//CSR#[27433]  ����
			sbSql.append("     , SUM(ROUND(A.PR_QTY)) AS TRANS_QTY \n");			
			
			//CSR#[27433]  ����� �ܰ�
			sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS SALE_PRICE \n");			
			
			sbSql.append("     , SUM(ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PR_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PR_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");

			//CSR#[27433]  ����ݾ�(��� ����)	
			sbSql.append("     , ROUND(A.SALE_PRICE) AS SALE_PRICE1 \n");	
			
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS OP_VAT1 \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS OP_TOT1 \n");
			
			//CSR#[27433]  ����ݾ�(��� ����)			
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************			
//			sbSql.append("     , ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))) AS SALE_PRICE2 \n");			
//			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))))) AS OP_AMOUNT2 \n");
//			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100)))))) AS OP_NOTAX2 \n");
//			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100)))),0)) AS OP_TAX2 \n");
			
			sbSql.append("     , ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)) AS SALE_PRICE2 \n");			
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)))) AS OP_AMOUNT2 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))))) AS OP_NOTAX2 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))),0)) AS OP_TAX2 \n");			
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************			
			//�ΰ����� ��������� �������� �ʴ´�. ���� �հ� �� ����
			sbSql.append("     , ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_VAT2 \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
//			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))))) \n");
			sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)))) \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
			sbSql.append("     + ROUND(SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT*0.1,0))) AS OP_TOT2 \n");
			sbSql.append("  FROM (SELECT B.ITEM_CLASS3, A.* FROM HWFS_FMP_OTCUST_PR A, HWFS_FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
			sbSql.append("       , HWFS_FMS_UPJANG B, HWFS_FMU_OP_RATE C, FM_SALE_RATE K, PO_SUBINVENTORY D \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.SUBINV_CODE = K.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS3 = K.ITEM_CLASS(+) \n");			
			sbSql.append("   AND A.NEED_DATE BETWEEN K.SDATE(+) AND K.EDATE(+) \n");
			sbSql.append("   AND K.USE_YN(+) = 'Y' \n");
			sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (sType.equals("001"))
				sbSql.append("   AND A.UPJANG = " + sWhere + " \n");
			else
				sbSql.append("   AND A.NEED_DATE = REPLACE('" + sWhere + "','-') \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))
				{sbSql.append(" GROUP BY A.NEED_DATE, DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)  \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************				
//				 sbSql.append(" ,ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100)))  \n");
				 sbSql.append(" ,ROUND(A.SALE_PRICE), ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100))  \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
				}
			else
				sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");
			sbSql.append("     , A.SUBINV_CODE, D.SUBINV_NAME, DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)  \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************			
//			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM,ROUND(A.SALE_PRICE),ROUND(A.SALE_PRICE / (1 + (NVL(K.FM_SALE_RATE,0)/100))) \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM,ROUND(A.SALE_PRICE),ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(K.FM_SALE_RATE,0),NVL(K.FM_NOSALE_RATE,0))/100)) \n");
//**************  FM_NOSALE_RATE �߰��� ���� ����  2009/07/22 ��� �� ����  *******************
		}
		sbSql.append(") A \n");
		sbSql.append(" ORDER BY A.NEED_DATE_ORI, A.SUBINV_CODE, A.ITEM_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**����**/
		out_dl.add(ds_list);
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
