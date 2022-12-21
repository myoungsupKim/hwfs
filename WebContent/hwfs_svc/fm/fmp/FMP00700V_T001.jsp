<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00700V_T001.jsp
■ 프로그램명   : 사업장별 거래추이조회
■ 작성일자     : 2008-01-31
■ 작성자       : 박은규
■ 이력관리     : 2008-01-31
   				[수정] 2009/07/22 BY 노규완
	    		: 매출 장려율 테이블 FM_SALE_RATE 에서 과/면세 율(%)을 따로 관리 하기 위해 수정.
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
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP \n");
			sbSql.append("     , SUM(A.AMT) AS AMT \n");
			sbSql.append("     , SUM(A.NOTAX) AS NOTAX \n");
			sbSql.append("     , SUM(A.TAX) AS TAX \n");
			sbSql.append("     , SUM(A.VAT) AS VAT \n");
			sbSql.append("     , SUM(A.TOT) AS TOT \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			if (sType.equals("002"))
  			//sbSql.append("SELECT /*+ USE_NL(B A C) INDEX(A PO_TRANSACTION_PT_I8) */ \n");
			sbSql.append("SELECT  \n");
  		else
  			sbSql.append("SELECT  \n");
 			sbSql.append("       TO_CHAR(A.TRANS_UPJANG) AS UPJANG \n");
			sbSql.append("     , B.UPJANGNM_DISP \n");
			if (sType.equals("001")) //장려금
			{
				
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100)))) AS AMT \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0,1)) AS NOTAX \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1,0)) AS TAX \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS VAT \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(A.TRANS_QTY * ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(NVL(D.FM_SALE_RATE, NVL(E.FM_SALE_RATE, F.FM_SALE_RATE)),0),NVL(NVL(D.FM_NOSALE_RATE, NVL(E.FM_NOSALE_RATE, F.FM_NOSALE_RATE)),0))/100))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS TOT \n");				
//**************  FM_NOSALE_RATE 추가에 따른 변경  2009/07/22 백업 및 수정  *******************				
			}
			else if (sType.equals("002")) //사업장
			{
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT \n");
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS AMT\n");
				*/
				sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))) AS AMT \n");
		        //sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS NOTAX \n");
		        /*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS NOTAX\n");
				*/
		        sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS NOTAX \n");
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)) AS TAX \n");
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)),0) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.TRANS_QTY * A.SALE_PRICE),0) END\n");
				sbSql.append("              ) AS TAX\n");
				*/
				sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0)) AS TAX \n");
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS VAT \n");
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS VAT\n");
				*/
				sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS VAT \n");
				//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS TOT \n");
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS TOT\n");
				*/
				sbSql.append("         , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))) AS TOT \n");		        
			}
			else //본사
			{
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.SALE_AMOUNT) AS AMT \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS NOTAX \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS TAX \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS VAT \n");
				sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS TOT \n");
			}
			//sbSql.append("  FROM HLDC_PO_TRANSACTION A, FMS_UPJANG B \n");
			 sbSql.append(" FROM (SELECT A.* , B.ITEM_CLASS3, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B \n");
			if (sType.equals("001")){
				sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CODE, A.FM_SALE_RATE, A.FM_NOSALE_RATE     						\n");
				sbSql.append("   FROM FMS_ITEM_SALE_RATE A -- 자재별    													\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append(" ) D																							\n");
				sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CLASS AS ITEM_CLASS4, A.FM_SALE_RATE, A.FM_NOSALE_RATE			\n");
				sbSql.append("   FROM FMS_SALE_RATE A -- 세분류별    														\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append("    AND LENGTH(A.ITEM_CLASS) = 7																\n");
				sbSql.append(" ) E																							\n");
				sbSql.append(",( 																							\n");
				sbSql.append(" SELECT A.SUBINV_CODE, A.ITEM_CLASS AS ITEM_CLASS3, A.FM_SALE_RATE, A.FM_NOSALE_RATE			\n");
				sbSql.append("   FROM FMS_SALE_RATE A -- 소분류별    														\n");
				sbSql.append("  WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "    				\n");
				sbSql.append("    AND A.CASH_CODE = '003'  																	\n");
				sbSql.append("    AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SDATE AND A.EDATE  \n");
				sbSql.append("    AND (A.FM_SALE_RATE > 0 OR A.FM_NOSALE_RATE > 0)  										\n");
				sbSql.append("    AND A.USE_YN = 'Y'  																		\n");
				sbSql.append("    AND LENGTH(A.ITEM_CLASS) = 5																\n");
				sbSql.append(" ) F																							\n");
			}else if (sType.equals("002")){
				/*
				//sbSql.append("     , FMU_OP_RATE C \n");
				sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG											\n");
			    sbSql.append("          FROM FMU_OP_RATE 																	\n");
			    //sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 																	\n");
			    sbSql.append("         WHERE 1 = 1 																			\n");
			    sbSql.append("           AND USE_YN = 'Y'																	\n");
			    sbSql.append("           AND ITEM_TYPE = 'M'																\n");
			    sbSql.append("       ) C																					\n");
			    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG					\n");
			    sbSql.append("           FROM FMU_OP_RATE 																	\n");
			    //sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 																	\n");
			    sbSql.append("         WHERE 1 = 1 																			\n");
			    sbSql.append("            AND USE_YN = 'Y'																	\n");
			    sbSql.append("            AND ITEM_TYPE = 'C'																\n");
			    sbSql.append("        ) D 																					\n");
			    */
			}
			sbSql.append(" WHERE 1=1 \n");
			if (sType.equals("001"))
			{				
			    //sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
			    //sbSql.append("   AND SUBSTR(A.ITEM_CODE,1,8) = C.ITEM_CLASS(+) \n");			
			    //sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			    //sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			    sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) 					\n");
			    sbSql.append("   AND A.ITEM_CLASS4 = E.ITEM_CLASS4(+) 				\n");
			    sbSql.append("   AND A.ITEM_CLASS3 = F.ITEM_CLASS3(+) 				\n");
			    sbSql.append("   AND A.SUBINV_CODE = D.SUBINV_CODE(+) 				\n");
			    sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) 				\n");
			    sbSql.append("   AND A.SUBINV_CODE = F.SUBINV_CODE(+) 				\n");
			}
			else if (sType.equals("002"))
			{
				//sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
				//sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
				//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
				/*
				sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) 					\n");
	        	sbSql.append("   AND A.TRANS_UPJANG = D.UPJANG(+) 					\n");
	        	sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) 					\n");
		        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) 				\n");
		        sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		        sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		        */
			}
			sbSql.append("   AND A.TRANS_UPJANG = B.UPJANG 							\n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			sbSql.append(" GROUP BY A.TRANS_UPJANG, B.UPJANGNM_DISP \n");
		}
		
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			sbSql.append("SELECT TO_CHAR(A.UPJANG) AS UPJANG \n");
			sbSql.append("     , B.UPJANGNM_DISP \n");
			if (sType.equals("001")) //장려금
			{
				sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100))))) AS AMT \n");
				sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0,1)) AS NOTAX \n");
				sbSql.append("     , SUM(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1,0)) AS TAX \n");
				sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',0.1,0))) AS VAT \n");
				sbSql.append("     , SUM(ROUND(ROUND(A.PR_QTY * ROUND(A.SALE_PRICE / (1 + (NVL(B.SALE_RATE,0)/100)))) * DECODE(A.TAX_CODE,'100',1.1,1))) AS TOT \n");
			}
			else if (sType.equals("002")) //사업장
			{
				//sbSql.append("     , SUM(ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT \n");
				/*
				sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
				sbSql.append("               ELSE ROUND(A.PR_QTY * A.SALE_PRICE) END\n");
				sbSql.append("              ) AS AMT\n");
				*/
				sbSql.append("         ,SUM(A.OP_AMOUNT) AS AMT \n");
		        //sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS NOTAX \n");
		        /*
		        sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE DECODE(A.TAX_CODE,'100',0,ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS NOTAX\n");
		        */
				sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',0,A.OP_AMOUNT)) AS NOTAX \n");
		        //sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)) AS TAX \n");
		        /*
		        sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)),0) \n");
				sbSql.append("               ELSE DECODE(A.TAX_CODE,'100',ROUND(A.PR_QTY * A.SALE_PRICE),0) END\n");
				sbSql.append("              ) AS TAX\n");
				*/
		        sbSql.append("         ,SUM(DECODE(A.TAX_CODE,'100',A.OP_AMOUNT,0)) AS TAX \n");
		        //sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS VAT \n");
		        /*
		        sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS VAT\n");
				*/
		        sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.OP_AMOUNT,0)) AS VAT \n");
		        //sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS TOT \n");
				/*
		        sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
				sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
				sbSql.append("                    THEN ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
				sbSql.append("               ELSE ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE)) END\n");
				sbSql.append("              ) AS TOT\n");
				*/
				sbSql.append("         ,SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.OP_AMOUNT,0)) AS TOT \n");
			}
			else //본사
			{
				sbSql.append("     , SUM(A.SALE_AMOUNT) AS AMT \n");
				sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS NOTAX \n");
				sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS TAX \n");
				sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS VAT \n");
				sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS TOT \n");
			}
			//sbSql.append("  FROM FMP_OTCUST_PR A, FMS_UPJANG B \n");
			sbSql.append(" FROM (SELECT A.* , B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B \n");
			/*
			if (sType.equals("002")){
				//sbSql.append("     , FMU_OP_RATE C \n");
				sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG											\n");
			    sbSql.append("          FROM FMU_OP_RATE 																					\n");
			    //sbSql.append("         WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 																	\n");
			    sbSql.append("         WHERE 1 = 1  																	\n");
			    sbSql.append("           AND USE_YN = 'Y'																					\n");
			    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
			    sbSql.append("       ) C																									\n");
			    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG											\n");
			    sbSql.append("           FROM FMU_OP_RATE 																					\n");
			    //sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " 																	\n");
			    sbSql.append("         WHERE 1 = 1  																	\n");
			    sbSql.append("            AND USE_YN = 'Y'																					\n");
			    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
			    sbSql.append("        ) D 																									\n");
			} 
			*/
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			/*
			if (sType.equals("002"))
			{
				//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
				//sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
				//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
				sbSql.append("   AND A.UPJANG = C.UPJANG(+) 						\n");
	        	sbSql.append("   AND A.UPJANG = D.UPJANG(+) 						\n");
	        	sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) 					\n");
		        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) 				\n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) 	\n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) 	\n");
			}
			*/
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");
		}
		
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.UPJANG, A.UPJANGNM_DISP \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>
