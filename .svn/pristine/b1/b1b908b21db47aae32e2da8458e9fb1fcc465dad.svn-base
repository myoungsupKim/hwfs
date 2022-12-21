<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/현황관리
■ 프로그램ID   : FMP00450V_T001.jsp
■ 프로그램명   : 검수서
■ 작성일자     : 2008-02-15
■ 작성자       : 박은규 
■ 이력관리     : 2008-02-15
1. 요청내용 : 공급업체 전체 출력 가능 하게 수정 요청 
인시던트 번호 : 119035    CSR# : 29291
요청자 : FS식재사업팀 김진희씨 
수정자 : 노규완   수정일 : 2009/07/17 
특이사항 : 화면단은 스크립트 수정 오즈 레포트 odi 파일 수정 
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
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSort   = nullToBlank(ds_cond.getString(0, "SORT"));
		//내역조회
		if (sOtCust.equals("0000"))
		{
			sbSql.append(" SELECT	ITEM_CODE		\n");
			sbSql.append("      ,	ITEM_NAME		\n");
			sbSql.append("      ,	ITEM_SIZE		\n");
			sbSql.append("      ,	PO_UOM			\n");
			sbSql.append("      ,	KEEPING_TYPE	\n");
			sbSql.append("      ,	OP_PRICE		\n");
			//CENTER_DELI_QTY => 센터입고수량, DIRECT_DELI_QTY => 직송수량
			sbSql.append("      ,	PR_QTY		\n");
			sbSql.append("      ,	SUM(ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(PR_QTY * OP_PRICE))) AS OP_VAT		\n");
		  //sbSql.append("      ,   SUM(ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("      ,	SUM(ROUND(PR_QTY * OP_PRICE)) AS OP_AMOUNT 		\n");
		  //sbSql.append("      , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("      ,	OTCUSTCD		\n");
			sbSql.append("      ,	OTCUSTNM		\n");
			sbSql.append("      ,	ORIGIN_TYPE		\n");
			sbSql.append("      ,	PR_ID		\n");
			sbSql.append("	FROM ( \n");
				sbSql.append("SELECT A.ITEM_CODE		\n");
				sbSql.append("	   , A.ITEM_NAME		\n");
				sbSql.append("	   , A.ITEM_SIZE		\n");
				sbSql.append("	   , A.PO_UOM 			\n");
				sbSql.append("     , A.KEEPING_TYPE 	\n");
				sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS PR_QTY	\n");
				//sbSql.append("     , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");
				//sbSql.append("            THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n");
				//sbSql.append("            WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
				//sbSql.append("            THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n");
				//sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
				sbSql.append("     , DECODE(NVL(A.SAL_OPER_PRICE,0), 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE --운영단가 \n");
				sbSql.append("     , A.TAX_CODE \n");
				sbSql.append("     , A.PO_QTY \n");
				sbSql.append("     , '0000' AS OTCUSTCD	\n");				
				sbSql.append("     , D.OTCUSTNM \n");
				sbSql.append("     , A.ORIGIN_TYPE \n");
				sbSql.append("	   , A.PO_ID AS PR_ID  			\n");//통합영업 PR 요청 번호
				sbSql.append("  FROM (SELECT A.*, Z.ORIGIN_INFO AS ORIGIN_TYPE, B.ITEM_CLASS4, B.KEEPING_TYPE FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B, HLDC_PO_PO_HIST Z WHERE A.ITEM_CODE = B.ITEM_CODE AND A.PO_ID = Z.PO_ID AND A.PO_NUM = Z.PO_NUM) A \n");
				sbSql.append("     , FMP_OTHER_CUST D \n");
				sbSql.append("     , ( \n");   
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'M' \n");
				sbSql.append("       ) E \n");
				sbSql.append("     , ( \n");        
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'C' \n");
				sbSql.append("       ) F \n");
				sbSql.append(" WHERE 1=1 \n");
				sbSql.append("   AND A.RC_UPJANG = E.UPJANG(+) \n");
				sbSql.append("   AND A.RC_UPJANG = F.UPJANG(+) \n");
				sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
				sbSql.append("   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
				sbSql.append("   AND D.OTCUSTCD = '0000' \n");
				sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
				sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
// 				sbSql.append("   AND A.LINE_STATUS >= '008' \n");
				sbSql.append("   AND A.LINE_STATUS IN ('PC', 'DL', 'GC', 'IV') \n");
				
			sbSql.append(" ) \n");	
			sbSql.append(" GROUP BY ITEM_CODE, ITEM_NAME, ITEM_SIZE, PO_UOM, KEEPING_TYPE, OP_PRICE, PR_QTY, OTCUSTCD, OTCUSTNM, ORIGIN_TYPE, PR_ID \n");
			sbSql.append(" ORDER BY " + nullToBlank(ds_cond.getString(0, "SORT")) + " \n");
		}
		else if(sOtCust.equals(""))
		{
			sbSql.append("SELECT  A.ITEM_CODE	 \n");                                                                                                                                                                                                           
	        sbSql.append("       ,A.ITEM_NAME    \n");                                                                                                                                                                                                        
	        sbSql.append("       ,A.ITEM_SIZE    \n");                                                                                                                                                                                                        
	        sbSql.append("       ,A.PO_UOM       \n");                                                                                                                                                                                                        
	        sbSql.append("       ,A.KEEPING_TYPE \n");                                                                                                                                                                                                        
	        sbSql.append("       ,A.PR_QTY		 \n");
	        sbSql.append("       ,A.OP_PRICE	 \n");                                                                                                                                                                                                       
	        sbSql.append("       ,SUM(ROUND(A.PR_QTY * A.OP_PRICE)) AS OP_AMOUNT 		\n");                                                                                                                                                                                                      
	        sbSql.append("       ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.OP_PRICE))) AS OP_VAT		\n");
	        sbSql.append("       ,A.OTCUSTCD 	\n");
	        sbSql.append("       ,A.OTCUSTNM    \n");
	        sbSql.append("       ,A.PR_ID       \n");
	        sbSql.append("       ,A.ORIGIN_TYPE       \n");
	        sbSql.append("FROM (	\n");
		        sbSql.append("SELECT A.ITEM_CODE		\n");
				sbSql.append("	   , A.ITEM_NAME		\n");
				sbSql.append("	   , A.ITEM_SIZE		\n");
				sbSql.append("	   , A.PO_UOM 			\n");
				sbSql.append("	   , A.PO_ID AS PR_ID			\n");//통합영업 PR 요청 번호			
				sbSql.append("     , A.KEEPING_TYPE 	\n");
				sbSql.append("     , (A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS PR_QTY	\n");			
				sbSql.append("     , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n");
				sbSql.append("            WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n");
				sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
				sbSql.append("     , A.TAX_CODE \n");
				sbSql.append("     , '0000' AS OTCUSTCD	\n");				
				sbSql.append("     , D.OTCUSTNM \n");
				sbSql.append("     , A.ORIGIN_TYPE \n");
				//sbSql.append("  FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B, FMP_OTHER_CUST D \n");
				sbSql.append("  FROM (SELECT A.*, Z.ORIGIN_INFO AS ORIGIN_TYPE, B.ITEM_CLASS4, B.KEEPING_TYPE FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B, HLDC_PO_PO_HIST Z WHERE A.ITEM_CODE = B.ITEM_CODE AND A.PO_ID = Z.PO_ID) A \n");
				sbSql.append("     , FMP_OTHER_CUST D \n");
				sbSql.append("     , ( \n");   
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'M' \n");
				sbSql.append("       ) E \n");
				sbSql.append("     , ( \n");        
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'C' \n");
				sbSql.append("       ) F \n");
				sbSql.append(" WHERE 1=1	\n");                                                                                                                                                                 
		        sbSql.append("   AND A.RC_UPJANG = E.UPJANG(+)	\n");                                                                                                                                                                           
		        sbSql.append("   AND A.RC_UPJANG = F.UPJANG(+)	\n");               
		        sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
				sbSql.append("   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+)	\n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+)	\n");                                                                                                                                                 
		        sbSql.append("   AND D.OTCUSTCD = '0000' \n"); 
		        sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'	\n");
		        sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%'	\n");
		        sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "	\n");
		        //sbSql.append("   AND A.LINE_STATUS >= '008'	\n");
		        sbSql.append("   AND A.LINE_STATUS IN ('PC', 'DL', 'GC', 'IV') \n");
		        sbSql.append(" UNION ALL	\n");	
		        sbSql.append("SELECT A.ITEM_CODE		\n");
				sbSql.append("	   , A.ITEM_NAME		\n");
				sbSql.append("	   , A.ITEM_SIZE		\n");
				sbSql.append("	   , A.PO_UOM 			\n");
				sbSql.append("	   , A.PR_ID \n");//통합영업 PR 요청 번호			
				sbSql.append("     , A.KEEPING_TYPE 	\n");
				sbSql.append("     , A.PR_QTY	\n");				
				sbSql.append("     , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n");
				sbSql.append("            WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n");
				sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
				sbSql.append("     , A.TAX_CODE \n");
				sbSql.append("     , A.OTCUSTCD	\n");				
				sbSql.append("     , D.OTCUSTNM \n");
				sbSql.append("     , A.ORIGIN_TYPE \n");
				sbSql.append("  FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS4,B.KEEPING_TYPE FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
				sbSql.append("     , FMP_OTHER_CUST D \n");
				sbSql.append("     , ( \n");   
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'M' \n");
				sbSql.append("       ) E \n");
				sbSql.append("     , ( \n");        
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'C' \n");
				sbSql.append("       ) F \n");
				sbSql.append(" WHERE 1=1	\n");
				sbSql.append("   AND A.UPJANG = E.UPJANG(+)	\n");
				sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
				sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
				sbSql.append("   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
		        sbSql.append("   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
		        sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD \n");
		        sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                      \n");
		        sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%'          \n");
		        sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'              \n");
		        sbSql.append("   AND A.LINE_STATUS <> '003' ) A                                                          \n");
	        sbSql.append("WHERE (1=1)                                                                                    \n");
	        sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.PR_ID, A.KEEPING_TYPE, A.PR_QTY, A.OP_PRICE, A.TAX_CODE, A.OTCUSTCD, A.OTCUSTNM, A.ORIGIN_TYPE \n");          
	        sbSql.append(" ORDER BY A." + nullToBlank(ds_cond.getString(0, "SORT")) + " \n");	  
		    //sbSql.append("SELECT  A.ITEM_CODE                                                                                                                                                                                                            \n");
	        //sbSql.append("       ,A.ITEM_NAME                                                                                                                                                                                                            \n");
	        //sbSql.append("       ,A.ITEM_SIZE                                                                                                                                                                                                            \n");
	        //sbSql.append("       ,A.PO_UOM                                                                                                                                                                                                               \n");
	        //sbSql.append("       ,A.KEEPING_TYPE                                                                                                                                                                                                         \n");
	        //sbSql.append("       ,A.PR_QTY                                                                                                                                                                                                               \n");
	        //sbSql.append("       ,A.OP_PRICE                                                                                                                                                                                                             \n");
	        //sbSql.append("       ,A.OP_AMOUNT                                                                                                                                                                                                            \n");
	        //sbSql.append("       ,A.OP_VAT                                                                                                                                                                                                               \n");
	        //sbSql.append("       ,A.OTCUSTCD  , A.OTCUSTNM , A.PR_ID                                                                                                                                                                                              \n");
	        //sbSql.append("FROM (SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.PR_ID                                                                                                                                                                  \n");
	        //sbSql.append("     , B.KEEPING_TYPE                                                                                                                                                                                                          \n");
	        //sbSql.append("     ,(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) AS PR_QTY                                                                                                                                                                        \n");
	        //sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE                                                                                     \n");
	        //sbSql.append("     , ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT                                   \n");
	        //sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
	        //sbSql.append("     , '0000' AS OTCUSTCD, D.OTCUSTNM                                                                                                                                                                                          \n");
	        //sbSql.append("  FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B, FMU_OP_RATE C , FMP_OTHER_CUST D                                                                                                                                                      \n");
	        //sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                               \n");
	        //sbSql.append("   AND A.RC_UPJANG = C.UPJANG(+)                                                                                                                                                                                               \n");
	        //sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                                                                                                           \n");
	        //sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                                                                                                                                                            \n");
	        //sbSql.append("   AND C.USE_YN(+) = 'Y'                                                                                                                                                                                                       \n");
	        //sbSql.append("   AND D.OTCUSTCD = '0000' \n"); 
	        //sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'                                                                                                                                          \n");
	        //sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "'                                                                                                                                      \n");
	        //sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                                                                                               \n");
	        //sbSql.append("   AND A.LINE_STATUS >= '008'                                                                                                                                                                                                  \n");
	        //sbSql.append("UNION ALL                                                                                                                                                                                                                      \n");
	        //sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM ,A.PR_ID                                                                                                                                                                        \n");
	        //sbSql.append("     , B.KEEPING_TYPE                                                                                                                                                                                                          \n");
	        //sbSql.append("     , A.PR_QTY                                                                                                                                                                                                                \n");
	        //sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE                                                                                     \n");
	        //sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT                                                                  \n");
	        //sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT                             \n");
	        //sbSql.append("     , A.OTCUSTCD, D.OTCUSTNM                                                                                                                                                                                                  \n");
	        //sbSql.append("  FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B, FMU_OP_RATE C, FMP_OTHER_CUST D                                                                                                                                                     \n");
	        //sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                               \n");
	        //sbSql.append("   AND A.UPJANG = C.UPJANG(+)                                                                                                                                                                                                  \n");
	        //sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)                                                                                                                                                                           \n");
	        //sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999'                                                                                                                                                                                            \n");
	        //sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD \n");
	        //sbSql.append("   AND C.USE_YN(+) = 'Y'                                                                                                                                                                                                       \n");
	        //sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + "                                                                                                                                                  \n");
	        //sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "'                                                                                                                                      \n");
	        //sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "'                                                                                                                                          \n");
	        //sbSql.append("   AND A.LINE_STATUS <> '003' ) A                                                                                                                                                                                              \n");
	        //sbSql.append("WHERE (1=1)                                                                                                                                                                                                                    \n");
	        //sbSql.append(" ORDER BY A." + nullToBlank(ds_cond.getString(0, "SORT")) + " \n");	        
	        //sbSql.append(" ORDER BY A.OTCUSTCD, A.ITEM_NAME                                                                                                                                                                                              \n");
		}
		else
		{
			sbSql.append("SELECT  A.ITEM_CODE     \n");
	        sbSql.append("       ,A.ITEM_NAME     \n");
	        sbSql.append("       ,A.ITEM_SIZE     \n");
	        sbSql.append("       ,A.PO_UOM        \n");
	        sbSql.append("       ,A.KEEPING_TYPE  \n");
	        sbSql.append("       ,A.PR_QTY		  \n");
	        sbSql.append("       ,A.OP_PRICE      \n");
	        sbSql.append("       ,SUM(ROUND(A.PR_QTY * A.OP_PRICE)) AS OP_AMOUNT	\n");
	        sbSql.append("       ,SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * A.OP_PRICE))) AS OP_VAT	\n");
	        sbSql.append("       ,A.OTCUSTCD  , A.OTCUSTNM	\n");
	        sbSql.append("       ,A.PR_ID  		  \n");
	        sbSql.append("FROM (	\n");
		        sbSql.append("SELECT A.ITEM_CODE		\n");
				sbSql.append("	   , A.ITEM_NAME		\n");
				sbSql.append("	   , A.ITEM_SIZE		\n");
				sbSql.append("	   , A.PO_UOM 			\n");		
				sbSql.append("     , A.KEEPING_TYPE 	\n");
				sbSql.append("     , A.PR_QTY	\n");				
				sbSql.append("     , CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n");
				sbSql.append("            WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
				sbSql.append("            THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n");
				sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
				sbSql.append("     , A.TAX_CODE \n");
				sbSql.append("     , A.OTCUSTCD	\n");				
				sbSql.append("     , D.OTCUSTNM \n");
				sbSql.append("     , A.ORIGIN_TYPE \n");
				sbSql.append("	   , A.PR_ID	\n");//통합영업 PR 요청 번호
				//sbSql.append("  FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B, FMP_OTHER_CUST D \n"); 
				sbSql.append("  FROM (SELECT A.*, B.ORIGIN_TYPE, B.ITEM_CLASS4,B.KEEPING_TYPE FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
				sbSql.append("     , FMP_OTHER_CUST D \n");
				sbSql.append("     , ( \n");   
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'M' \n");
				sbSql.append("       ) E \n");
				sbSql.append("     , ( \n");        
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("            AND USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'C' \n");
				sbSql.append("       ) F \n");
				sbSql.append(" WHERE 1=1 \n");
				sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
				sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
				sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
				sbSql.append("   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
				sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD \n");
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("   AND A.SUBINV_CODE LIKE '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "%' \n");
				sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
				sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			sbSql.append(" ) A \n");		
			sbSql.append(" GROUP BY A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.KEEPING_TYPE, A.PR_QTY, A.OP_PRICE, A.TAX_CODE, A.OTCUSTCD, A.OTCUSTNM, A.ORIGIN_TYPE, A.PR_ID \n");
			sbSql.append(" ORDER BY A." + nullToBlank(ds_cond.getString(0, "SORT")) + " \n");
			//sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
			//sbSql.append("     , B.KEEPING_TYPE \n");
			//sbSql.append("     , A.PR_QTY \n");
			//sbSql.append("     , DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE) AS OP_PRICE \n");
			//sbSql.append("     , ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) AS OP_AMOUNT \n");
			//sbSql.append("     , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PR_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_VAT \n");
            //sbSql.append("     , A.OTCUSTCD, D.OTCUSTNM \n");			
			//sbSql.append("  FROM FMP_OTCUST_PR A, FMP_OTCUST_ITEM B, FMU_OP_RATE C, FMP_OTHER_CUST D \n");
			//sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			//sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			//sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD \n");
			//sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			//sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			//sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			//sbSql.append("   AND A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' \n");
			//sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			//sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			//sbSql.append(" ORDER BY A." + nullToBlank(ds_cond.getString(0, "SORT")) + " \n");
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
