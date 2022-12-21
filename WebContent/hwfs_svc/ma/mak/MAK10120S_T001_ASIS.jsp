<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/마케팅
■ 프로그램ID   : MAK10120S_T001.jsp
■ 프로그램명   : 거래처별 매출실적조회
■ 작성일자     : 2008-02-25
■ 작성자       : 황승한
■ 이력관리     : 2008-02-25
               2013-08-27 김장욱 SQL튜닝 
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
	
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_cond");
		
		//입력 파라메터  
		
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		
	
		String str_in_DEPT_ID            = nullToBlank(ds_cond.getString(0, "DEPT_ID"));
		String str_in_PART_SALES_SABUN   = nullToBlank(ds_cond.getString(0, "PART_SALES_SABUN"));
		String str_in_CENTER_CODE        = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		String str_in_TRANS_DATEFR       = nullToBlank(ds_cond.getString(0, "TRANS_DATEFR"));
		String str_in_TRANS_DATETO       = nullToBlank(ds_cond.getString(0, "TRANS_DATETO"));
		String str_in_MAIN_UPJANG        = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String str_in_SUB_UPJANG         = nullToBlank(ds_cond.getString(0, "SUB_UPJANG"));
		String str_in_JOB                = nullToBlank(ds_cond.getString(0, "JOB"));
		String str_in_SUBJOB             = nullToBlank(ds_cond.getString(0, "SUB_JOB"));
		String str_in_chk_0              = nullToBlank(ds_cond.getString(0, "chk_0"));
		String str_in_chk_1              = nullToBlank(ds_cond.getString(0, "chk_1"));
		String CHK_HIS                   = nullToBlank(ds_cond.getString(0, "CHK_HIS"));
		
		String str_Div         = " A.SALE_PRICE";
		
		if (str_in_chk_0.equals("true")){
			
			
			//str_Div =  " / (1 + ((SELECT FM_SALE_RATE FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = C.SUBINV_CODE) /100)) ";	
			str_Div =  "ROUND(A.SALE_PRICE / (1 + DECODE(A.TAX_CODE,'100',NVL(C.FM_SALE_RATE,0),NVL(C.FM_NOSALE_RATE,0))/100))";
		}

		//FileLog.println("d:\\aaa.txt", ds_cond);
	

		//Master 조회###########################################################################
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회	

		//=========================================================================================
		// (2013-08-27 변경) 시작
		// 김장욱  2013-08-27 SQL 튜닝
		//=========================================================================================
		//if (str_in_chk_1.equals("1")){
		//sbSql.append("    SELECT 'A' GUBUN, MAIN_UPJANG, MAIN_UPJANGNM, '' UPJANG, '' UPJANGNM_DISP, '' FST_REG_DATE, '' SABUN, '' NM_KOR \n");
		//}
		//else {
		//sbSql.append("    SELECT DECODE(MAIN_UPJANG, UPJANG, 'A', 'B') GUBUN, MAIN_UPJANG, MAIN_UPJANGNM, UPJANG, UPJANGNM_DISP, DECODE(FST_REG_DATE, NULL, '', SUBSTR(FST_REG_DATE, 1, 4)||'-'||SUBSTR(FST_REG_DATE, 5, 2)||'-'||SUBSTR(FST_REG_DATE, 7, 2)) FST_REG_DATE, SABUN, NM_KOR \n");						
		//}
		//sbSql.append("                 ,DECODE(NVL(SUM(PRE_SALE_AMOUNT), 0), 0, 0, 1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) DATE_CNT_A\n");
		//sbSql.append("                 ,DECODE(NVL(SUM(SALE_AMOUNT), 0), 0, 0, 1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) DATE_CNT_B\n");			
		//sbSql.append("                 --전월실적 \n");
		//sbSql.append("                 , SUM(PRE_SALE_AMOUNT_TOT) SUM_A_TOT \n");
		//sbSql.append("                 , SUM(PRE_SALE_AMOUNT) SUM_A \n");
		//sbSql.append("                 , SUM(PRE_SALE_AMOUNT) - SUM(PRE_UNIT_AMOUNT) SUM_B \n");
		//sbSql.append("                 , DECODE(SUM(PRE_SALE_AMOUNT),0,0,100*(SUM(PRE_SALE_AMOUNT) - SUM(PRE_UNIT_AMOUNT))/SUM(PRE_SALE_AMOUNT)) SUM_C \n");
		//sbSql.append("                 , SUM(PRE_SALE_AMOUNT)/(1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) SUM_D \n");
		//sbSql.append("                 --당월실적 \n");
		//sbSql.append("                 , SUM(SALE_AMOUNT_TOT) SUM_E_TOT \n");
		//sbSql.append("                 , SUM(SALE_AMOUNT) SUM_E \n");
		//sbSql.append("                 , SUM(SALE_AMOUNT) - SUM(UNIT_AMOUNT) SUM_F \n");
		//sbSql.append("                 , DECODE(SUM(SALE_AMOUNT),0,0,100*(SUM(SALE_AMOUNT) - SUM(UNIT_AMOUNT))/SUM(SALE_AMOUNT)) SUM_G \n");
		//sbSql.append("                 , SUM(SALE_AMOUNT)/(1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) SUM_H \n");
		//sbSql.append("                 --전월대비 \n");
		//sbSql.append("                 , 0 SUM_I \n");
		//sbSql.append("                 , 0 SUM_J \n");
		//sbSql.append("                 , 0 SUM_K \n");
		//sbSql.append("                 , 0 SUM_L \n");
		//sbSql.append("              FROM \n");
		//sbSql.append("            ( \n");
		//sbSql.append("            SELECT  B.MAIN_UPJANG \n");
		//sbSql.append("                 , (SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = B.MAIN_UPJANG) MAIN_UPJANGNM \n");
		//sbSql.append("                 , B.UPJANG, B.UPJANGNM_DISP, B.FST_REG_DATE \n");
		//sbSql.append("                 , D.SABUN, D.NM_KOR \n");
		//sbSql.append("                 , PRE_SALE_AMOUNT_TOT \n");		
		//sbSql.append("                 , PRE_SALE_AMOUNT \n");
		//sbSql.append("                 , PRE_UNIT_AMOUNT \n");
		//sbSql.append("                 , 0 AS SALE_AMOUNT_TOT \n");
		//sbSql.append("                 , 0 AS SALE_AMOUNT \n");
		//sbSql.append("                 , 0 AS UNIT_AMOUNT \n");
		//sbSql.append("              FROM ( \n");
		//sbSql.append("                    SELECT /*+ INDEX(A PO_TRANSACTION_PT_I6) */ \n");
		//sbSql.append("                           A.TRANS_UPJANG, ROUND(DECODE(TAX_CODE,'100',1.1,1) * DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ") AS PRE_SALE_AMOUNT_TOT, ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ") AS PRE_SALE_AMOUNT \n");
		//sbSql.append("                         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT AS PRE_UNIT_AMOUNT, A.CENTER_CODE, C.FM_SALE_RATE \n");
		//sbSql.append("                      FROM HLDC_PO_TRANSACTION A, HLDC_FM_SALE_RATE C \n");
		//sbSql.append("                     WHERE (A.SUBINV_CODE  = C.SUBINV_CODE(+))\n");
		
		//sbSql.append("                       AND SUBSTR(A.ITEM_CODE,1,6)||'00' = C.ITEM_CLASS(+) \n");		
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)) \n");
		//sbSql.append("                       AND (C.USE_YN(+) = 'Y') \n");
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') \n");
		//sbSql.append("                                            AND TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD'),-1),'YYYYMMDD')) \n");
		//sbSql.append("                       AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");		
		//sbSql.append("                   ) A \n");
		//sbSql.append("                 , FMS_UPJANG B \n");
		//sbSql.append("                 , HLDC_HR_PERSONAL D \n");
		//sbSql.append("             WHERE A.TRANS_UPJANG(+)  = B.UPJANG \n");
		//sbSql.append("               AND B.PART_SALES_SABUN = D.SABUN(+) \n");
		
		//if (!str_in_DEPT_ID.equals("")){
		//	sbSql.append("            AND   (B.DEPT_ID               = " + str_in_DEPT_ID  + ") \n");
		//}
		
		//if (!str_in_PART_SALES_SABUN.equals("")){
		//	sbSql.append("            AND   (B.PART_SALES_SABUN      = '" + str_in_PART_SALES_SABUN  + "') \n");
		//}
		
		//if (!str_in_CENTER_CODE.equals("")){
		//	sbSql.append("            AND   (A.CENTER_CODE           = '" + str_in_CENTER_CODE  + "') \n");
		//}
		
		//if (!str_in_JOB.equals("")){
		//	sbSql.append("            AND   (B.BIZ_GROUP           = '" + str_in_JOB  + "') \n");
		//}
		//if (!str_in_SUBJOB.equals("")){
		//	sbSql.append("            AND   (B.BIZ_DETAIL          = '" + str_in_SUBJOB  + "') \n");
		//}
		
		
		
		//if (!str_in_SUB_UPJANG.equals("")){
		//	sbSql.append("            AND   (A.TRANS_UPJANG          = " + str_in_SUB_UPJANG  + ") \n");
		//}
		//else {
			
			
		//	if (!str_in_MAIN_UPJANG.equals("")){
		//		sbSql.append("        AND   (B.MAIN_UPJANG          = " + str_in_MAIN_UPJANG  + ") \n");
		//	}
			
		//}
		
		//sbSql.append("             UNION ALL \n");
		//sbSql.append("            SELECT  B.MAIN_UPJANG \n");
		//sbSql.append("                 , (SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = B.MAIN_UPJANG) MAIN_UPJANGNM \n");
		//sbSql.append("                 , B.UPJANG, B.UPJANGNM_DISP, B.FST_REG_DATE \n");
		//sbSql.append("                 , D.SABUN, D.NM_KOR \n");
		//sbSql.append("                 , 0 PRE_SALE_AMOUNT_TOT \n");		
		//sbSql.append("                 , 0 PRE_SALE_AMOUNT \n");
		//sbSql.append("                 , 0 PRE_UNIT_AMOUNT \n");
		//sbSql.append("                 , SALE_AMOUNT_TOT \n");
		//sbSql.append("                 , SALE_AMOUNT \n");
		//sbSql.append("                 , UNIT_AMOUNT \n");
		//sbSql.append("              FROM ( \n");
		//sbSql.append("                    SELECT /*+ INDEX(A PO_TRANSACTION_PT_I6) */ \n");
		//sbSql.append("                           A.TRANS_UPJANG \n");
		
		//sbSql.append("                         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'210',ROUND(A.TRANS_QTY * " + str_Div + "),0) + DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',ROUND(A.TRANS_QTY * " + str_Div + "),0) + DECODE(TAX_CODE,'100',ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * SALE_AMOUNT * 0.1) + (TRANS_QTY * SALE_VAT),0) AS SALE_AMOUNT_TOT \n");
		
		//sbSql.append("                         , ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ") AS SALE_AMOUNT \n");
		//sbSql.append("                         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT UNIT_AMOUNT, A.CENTER_CODE, C.FM_SALE_RATE  \n");
		//sbSql.append("                      FROM HLDC_PO_TRANSACTION A, HLDC_FM_SALE_RATE C \n");
		//sbSql.append("                     WHERE (A.SUBINV_CODE  = C.SUBINV_CODE(+)) \n");
		
		//sbSql.append("                       AND SUBSTR(A.ITEM_CODE,1,6)||'00' = C.ITEM_CLASS(+) \n");		
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)) \n");
		//sbSql.append("                       AND (C.USE_YN(+) = 'Y') \n");
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "') \n");
		//sbSql.append("                       AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                   ) A \n");
		//sbSql.append("                 , FMS_UPJANG B \n");
		//sbSql.append("                 , HLDC_HR_PERSONAL D \n");
		//sbSql.append("             WHERE A.TRANS_UPJANG(+)  = B.UPJANG \n");
		//sbSql.append("               AND B.PART_SALES_SABUN = D.SABUN(+) \n");
		
		//if (!str_in_DEPT_ID.equals("")){
		//	sbSql.append("            AND   (B.DEPT_ID               = " + str_in_DEPT_ID  + ") \n");
		//}
		
		//if (!str_in_PART_SALES_SABUN.equals("")){
		//	sbSql.append("            AND   (B.PART_SALES_SABUN      = '" + str_in_PART_SALES_SABUN  + "') \n");
		//}
		
		//if (!str_in_CENTER_CODE.equals("")){
		//	sbSql.append("            AND   (A.CENTER_CODE           = '" + str_in_CENTER_CODE  + "') \n");
		//}
		
		//if (!str_in_JOB.equals("")){
		//	sbSql.append("            AND   (B.BIZ_GROUP           = '" + str_in_JOB  + "') \n");
		//}
		//if (!str_in_SUBJOB.equals("")){
		//	sbSql.append("            AND   (B.BIZ_DETAIL          = '" + str_in_SUBJOB  + "') \n");
		//}
		
		
		
		//if (!str_in_SUB_UPJANG.equals("")){
		//	sbSql.append("            AND   (A.TRANS_UPJANG          = " + str_in_SUB_UPJANG  + ") \n");
		//}
		//else {
			
			
		//	if (!str_in_MAIN_UPJANG.equals("")){
		//		sbSql.append("        AND   (B.MAIN_UPJANG          = " + str_in_MAIN_UPJANG  + ") \n");
		//	}
		//}	
			
		//sbSql.append("            ) \n");
		
		//if (str_in_chk_1.equals("1")){
		//sbSql.append("             GROUP BY MAIN_UPJANG, MAIN_UPJANGNM \n");
		//}
		//else {
		//sbSql.append("             GROUP BY MAIN_UPJANG, MAIN_UPJANGNM, UPJANG, UPJANGNM_DISP, FST_REG_DATE, SABUN, NM_KOR \n");				
		//}
        sbSql.append("SELECT GUBUN,                                   \n");
        sbSql.append("  MAIN_UPJANG,                                  \n");
        sbSql.append(" (SELECT UPJANGNM_DISP                          \n");
        sbSql.append("    FROM FMS_UPJANG@FCUS_TO_FSUS                             \n");
        sbSql.append("   WHERE UPJANG = B.MAIN_UPJANG) MAIN_UPJANGNM , \n");
        sbSql.append("  UPJANG,                                       \n");
        sbSql.append("  UPJANGNM_DISP,                                \n");
        sbSql.append("  FST_REG_DATE,                                 \n");
        sbSql.append("  SABUN,                                        \n");
        sbSql.append("  NM_KOR ,                                      \n");
        sbSql.append("  DATE_CNT_A ,                                  \n");
        sbSql.append("  DATE_CNT_B ,                                  \n");
        sbSql.append("  SUM_A_TOT ,                                   \n");
        sbSql.append("  SUM_A ,                                       \n");
        sbSql.append("  SUM_B ,                                       \n");
        sbSql.append("  SUM_C ,                                       \n");
        sbSql.append("  SUM_D ,                                       \n");
        sbSql.append("  SUM_E_TOT ,                                   \n");
        sbSql.append("  SUM_E ,                                       \n");
        sbSql.append("  SUM_F ,                                       \n");
        sbSql.append("  SUM_G ,                                       \n");
        sbSql.append("  SUM_H,                                        \n");
        sbSql.append("  SUM_I ,                                       \n");
        sbSql.append("  SUM_J ,                                       \n");
        sbSql.append("  SUM_K ,                                       \n");
        sbSql.append("  SUM_L                                         \n");
        sbSql.append("  FROM (                                        \n");
		
		if (str_in_chk_1.equals("true")){
			sbSql.append("    SELECT /*거래처별 매출실적 조회*/ 'A' GUBUN, B.MAIN_UPJANG, V.UPJANGNM_DISP MAIN_UPJANGNM, '' UPJANG, '' UPJANGNM_DISP, '' FST_REG_DATE, '' SABUN, '' NM_KOR \n");
		}else {
			sbSql.append("    SELECT DECODE(B.MAIN_UPJANG, B.UPJANG, 'A', 'B') GUBUN, B.MAIN_UPJANG, V.UPJANGNM_DISP MAIN_UPJANGNM, B.UPJANG, B.UPJANGNM_DISP, DECODE(B.FST_REG_DATE, NULL, '', SUBSTR(B.FST_REG_DATE, 1, 4)||'-'||SUBSTR(B.FST_REG_DATE, 5, 2)||'-'||SUBSTR(B.FST_REG_DATE, 7, 2)) FST_REG_DATE, SABUN, NM_KOR \n");						
		}
		
			sbSql.append("                 ,DECODE(NVL(SUM(PRE_SALE_AMOUNT), 0), 0, 0, 1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) DATE_CNT_A\n");
			sbSql.append("                 ,DECODE(NVL(SUM(SALE_AMOUNT), 0), 0, 0, 1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) DATE_CNT_B\n");			
			sbSql.append("                 --전월실적 \n");
			sbSql.append("                 , NVL(SUM(PRE_SALE_AMOUNT_TOT), 0) SUM_A_TOT \n");
			sbSql.append("                 , NVL(SUM(PRE_SALE_AMOUNT), 0) SUM_A \n");
			sbSql.append("                 , NVL(SUM(PRE_SALE_AMOUNT), 0) - NVL(SUM(PRE_UNIT_AMOUNT), 0) SUM_B \n");
			sbSql.append("                 , DECODE(NVL(SUM(PRE_SALE_AMOUNT), 0),0,0,100*(SUM(PRE_SALE_AMOUNT) - SUM(PRE_UNIT_AMOUNT))/SUM(PRE_SALE_AMOUNT)) SUM_C \n");
			sbSql.append("                 , SUM(PRE_SALE_AMOUNT)/(1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) SUM_D \n");
			sbSql.append("                 --당월실적 \n");
			sbSql.append("                 , NVL(SUM(SALE_AMOUNT_TOT), 0) SUM_E_TOT \n");
			sbSql.append("                 , NVL(SUM(SALE_AMOUNT), 0) SUM_E \n");
			sbSql.append("                 , NVL(SUM(SALE_AMOUNT), 0) - NVL(SUM(UNIT_AMOUNT), 0) SUM_F \n");
			sbSql.append("                 , DECODE(NVL(SUM(SALE_AMOUNT), 0),0,0,100*(NVL(SUM(SALE_AMOUNT), 0) - NVL(SUM(UNIT_AMOUNT), 0))/SUM(SALE_AMOUNT)) SUM_G \n");
			sbSql.append("                 , NVL(SUM(SALE_AMOUNT), 0)/(1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) SUM_H \n");
			sbSql.append("                 --전월대비 \n");
			sbSql.append("                 , 0 SUM_I \n");
			sbSql.append("                 , 0 SUM_J \n");
			sbSql.append("                 , 0 SUM_K \n");
			sbSql.append("                 , 0 SUM_L \n");
			sbSql.append("              FROM \n");
			sbSql.append("            ( \n");
			if (CHK_HIS.equals("false"))
			{
				sbSql.append("            SELECT /*+ LEADING(A C) USE_HASH(A C) SWAP_JOIN_INPUTS(C) */ B.MAIN_UPJANG \n");
			}
			else
			{
				sbSql.append("            SELECT B.MAIN_UPJANG \n");
			}
			sbSql.append("                 --, (SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = B.MAIN_UPJANG) MAIN_UPJANGNM \n");
			sbSql.append("                 , B.UPJANG, B.UPJANGNM_DISP, B.FST_REG_DATE \n");
			sbSql.append("                 , D.SABUN, D.NM_KOR \n");
			sbSql.append("                 , PRE_SALE_AMOUNT_TOT \n");		
			sbSql.append("                 , PRE_SALE_AMOUNT \n");
			sbSql.append("                 , PRE_UNIT_AMOUNT \n");
			sbSql.append("                 , SALE_AMOUNT_TOT \n");
			sbSql.append("                 , SALE_AMOUNT \n");
			sbSql.append("                 , UNIT_AMOUNT \n");
			sbSql.append("              FROM ( \n");
			//sbSql.append("                    SELECT /*+ PARALLEL(A ,4) */                                                                                                                                                                                                                                                                                           \n");
			sbSql.append("                    SELECT A.TRANS_UPJANG,                                                                                                                                                                                                                                                                                                 \n");
	        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD'),-1),'YYYYMMDD') THEN                                                                                               \n");
	        sbSql.append("                                   ROUND(DECODE(TAX_CODE,'100',1.1,1) * DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ")                                                                                                                                                                                         \n");
	        sbSql.append("                                ELSE                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                                   0                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                           END PRE_SALE_AMOUNT_TOT,                                                                                                                                                                                                                                                                                        \n");
	        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD'),-1),'YYYYMMDD') THEN                                                                                               \n");
	        sbSql.append("                                   ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ")                                                                                                                                                                                                                        \n");
	        sbSql.append("                                ELSE                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                                   0                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                           END PRE_SALE_AMOUNT,                                                                                                                                                                                                                                                                                            \n");
	        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD'),-1),'YYYYMMDD') THEN                                                                                               \n");
	        sbSql.append("                                   DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT                                                                                                                                                                                                                                               \n");
	        sbSql.append("                                ELSE                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                                   0                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                           END PRE_UNIT_AMOUNT,                                                                                                                                                                                                                                                                                            \n");
	        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "' THEN                                                                                                                                                                                                             \n");
	        sbSql.append("                                   DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'210',ROUND(A.TRANS_QTY * " + str_Div + "),0) + DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',ROUND(A.TRANS_QTY * " + str_Div + "),0) + DECODE(TAX_CODE,'100',ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * SALE_AMOUNT * 0.1) + (TRANS_QTY * SALE_VAT),0) \n");
	        sbSql.append("                                ELSE                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                                   0                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                           END SALE_AMOUNT_TOT,                                                                                                                                                                                                                                                                                            \n");
	        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "' THEN                                                                                                                                                                                                             \n");
	        sbSql.append("                                   ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ")                                                                                                                                                                                                                         \n");
	        sbSql.append("                                ELSE                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                                   0                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                           END SALE_AMOUNT,                                                                                                                                                                                                                                                                                                \n");
	        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "' THEN                                                                                                                                                                                                             \n");
	        sbSql.append("                                   DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT                                                                                                                                                                                                                                               \n");
	        sbSql.append("                                ELSE                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                                   0                                                                                                                                                                                                                                                                                                       \n");
	        sbSql.append("                           END UNIT_AMOUNT,                                                                                                                                                                                                                                                                                                \n");
	        sbSql.append("                           A.CENTER_CODE,                                                                                                                                                                                                                                                                                                  \n");
	        sbSql.append("                           C.FM_SALE_RATE                                                                                                                                                                                                                                                                                                  \n");
	        if (CHK_HIS.equals("false"))
			{
	        	sbSql.append("                      FROM PO_TRANSACTION@FCUS_TO_HLDC A, FM_SALE_RATE@FCUS_TO_HLDC C                                                                                                                                                                                                                                                                      \n");
			}
	        else
	        {
	        	sbSql.append("                      FROM HIS_PO_TRANSACTION_201312@FCUS_TO_HLDC A, FM_SALE_RATE@FCUS_TO_HLDC C                                                                                                                                                                                                                                                                      \n");
	        }
	        sbSql.append("                     WHERE (A.SUBINV_CODE  = C.SUBINV_CODE(+))                                                                                                                                                                                                                                                                             \n");
	        sbSql.append("                       AND SUBSTR(A.ITEM_CODE,1,6)||'00' = C.ITEM_CLASS(+)                                                                                                                                                                                                                                                                 \n");
	        sbSql.append("                       AND (A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+))                                                                                                                                                                                                                                                                \n");
	        sbSql.append("                       AND (C.USE_YN(+) = 'Y')                                                                                                                                                                                                                                                                                             \n");
	        sbSql.append("                       AND (A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') AND '" + str_in_TRANS_DATETO + "')                                                                                                                                                                   \n");
	        sbSql.append("                       AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("                   ) A \n");
			sbSql.append("                 , FMS_UPJANG@FCUS_TO_FSUS B \n");
			sbSql.append("                 , HR_PERSONAL@FCUS_TO_HLDC D \n");
			sbSql.append("             WHERE A.TRANS_UPJANG(+)  = B.UPJANG \n");
			sbSql.append("               AND B.PART_SALES_SABUN = D.SABUN(+) \n");		
			if (!str_in_DEPT_ID.equals("")){
				sbSql.append("            AND   (B.DEPT_ID               = " + str_in_DEPT_ID  + ") \n");
			}
			if (!str_in_PART_SALES_SABUN.equals("")){
				sbSql.append("            AND   (B.PART_SALES_SABUN      = '" + str_in_PART_SALES_SABUN  + "') \n");
			}
			if (!str_in_CENTER_CODE.equals("")){
				sbSql.append("            AND   (A.CENTER_CODE           = '" + str_in_CENTER_CODE  + "') \n");
			}
			if (!str_in_JOB.equals("")){
				sbSql.append("            AND   (B.BIZ_GROUP           = '" + str_in_JOB  + "') \n");
			}
			if (!str_in_SUBJOB.equals("")){
				sbSql.append("            AND   (B.BIZ_DETAIL          = '" + str_in_SUBJOB  + "') \n");
			}
			if (!str_in_SUB_UPJANG.equals("")){
				sbSql.append("            AND   (A.TRANS_UPJANG          = " + str_in_SUB_UPJANG  + ") \n");
			}
			else {	
				if (!str_in_MAIN_UPJANG.equals("")){
					sbSql.append("        AND   (B.MAIN_UPJANG          = " + str_in_MAIN_UPJANG  + ") \n");
				}
			}
			sbSql.append("       ) B, \n");
			sbSql.append("       FMS_UPJANG@FCUS_TO_FSUS V \n");
			sbSql.append(" WHERE V.UPJANG(+) = B.MAIN_UPJANG \n");
			if (str_in_chk_1.equals("true")){
			sbSql.append("             GROUP BY B.MAIN_UPJANG, V.UPJANGNM_DISP \n");
			}
			else {
			sbSql.append("             GROUP BY B.MAIN_UPJANG, V.UPJANGNM_DISP, B.UPJANG, B.UPJANGNM_DISP, B.FST_REG_DATE, SABUN, NM_KOR \n");				
			}			
			sbSql.append("       ) B \n");
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

		/**종료**/
		out_dl.add(ds_list);
		
		
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>