<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/마케팅
■ 프로그램ID   : MAK10130S_T001.jsp
■ 프로그램명   : 대분류별 매출실적조회
■ 작성일자     : 2008-02-25
■ 작성자       : 황승한
■ 이력관리     : 2008-02-25
                2013-08-28 김장욱 SQL튜닝 
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
		
		String str_in_chk_0    = nullToBlank(ds_cond.getString(0, "chk_0"));
		String str_in_chk_1              = nullToBlank(ds_cond.getString(0, "chk_1"));
		String str_in_chk_2              = nullToBlank(ds_cond.getString(0, "chk_2"));
		String str_in_chk_3              = nullToBlank(ds_cond.getString(0, "chk_3"));
		
		String str_Div         = " A.SALE_PRICE";
		boolean blnDiv1 = false;
		boolean blnDiv2 = false;
		boolean blnDiv3 = false;
		String strDiv1 = "";
		String strDiv2 = "";
		String strDiv3 = "";
		
		if  (str_in_chk_1.equals("1")) {
			blnDiv1 = true;
			strDiv1 += " FMS_ITEM_SALE_RATE_PRICE_FUN(A.TAX_CODE, A.TRANS_UPJANG, A.SUBINV_CODE, '003', A.ITEM_CODE, A.TRANS_DATE, A.SALE_PRICE)";
		  }

		  if  (str_in_chk_2.equals("1")) {
			blnDiv2 = true;
			if (blnDiv1) strDiv2 = " + ";
			strDiv2 = strDiv2 + "FMS_ITEM_SALE_RATE_PRICE_FUN(A.TAX_CODE, A.TRANS_UPJANG, A.SUBINV_CODE, '001', A.ITEM_CODE, A.TRANS_DATE, A.SALE_PRICE)";
		  }

		  if  (str_in_chk_3.equals("1")) {
			blnDiv3 = true;
			if (blnDiv1 || blnDiv2) strDiv3 = " + ";
			strDiv3 = strDiv3 + "FMS_ITEM_SALE_RATE_PRICE_FUN(A.TAX_CODE, A.TRANS_UPJANG, A.SUBINV_CODE, '002', A.ITEM_CODE, A.TRANS_DATE, A.SALE_PRICE)";
		  }
		  
		  if (blnDiv1 || blnDiv2 || blnDiv3) {
			  str_Div = "(" + str_Div + " - ";
			  str_Div += "(" + strDiv1 + strDiv2 + strDiv3 + ")";
			  str_Div += ")";
			}
		
		if (str_in_chk_0.equals("1")){
			
			
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
		//sbSql.append("    SELECT  (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = PART_SALES_SABUN) PART_SALES_SABUNNM, CLASS_NAME \n");
		//sbSql.append("                 --전월실적 \n");
		//sbSql.append("                 , SUM(PRE_SALE_AMOUNT) SUM_A \n");
		//sbSql.append("                 , SUM(PRE_SALE_AMOUNT) - SUM(PRE_UNIT_AMOUNT) SUM_B \n");
		//sbSql.append("                 , DECODE(SUM(PRE_SALE_AMOUNT),0,0,100*(SUM(PRE_SALE_AMOUNT) - SUM(PRE_UNIT_AMOUNT))/SUM(PRE_SALE_AMOUNT)) SUM_C \n");
		//sbSql.append("                 , SUM(PRE_SALE_AMOUNT)/(1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) SUM_D \n");
		//sbSql.append("                 --당월실적 \n");
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
		//sbSql.append("            SELECT B.PART_SALES_SABUN, CLASS_NAME \n");
		//sbSql.append("                 , PRE_SALE_AMOUNT \n");
		//sbSql.append("                 , PRE_UNIT_AMOUNT \n");
		//sbSql.append("                 , 0 AS SALE_AMOUNT \n");
		//sbSql.append("                 , 0 AS UNIT_AMOUNT \n");
		//sbSql.append("              FROM ( \n");
		//sbSql.append("                    SELECT /*+ INDEX(A PO_TRANSACTION_PT_I6) */ \n");
		//sbSql.append("                           A.TRANS_UPJANG, SUBSTR(A.ITEM_CODE,1,4)||'0000' AS ITEM_CLASS \n");
		//sbSql.append("                         , ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ") AS PRE_SALE_AMOUNT \n");
		//sbSql.append("                         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT AS PRE_UNIT_AMOUNT, A.CENTER_CODE, C.FM_SALE_RATE \n");
		//sbSql.append("                      FROM HLDC_PO_TRANSACTION A, HLDC_FM_SALE_RATE C \n");
		//sbSql.append("                     WHERE (A.SUBINV_CODE  = C.SUBINV_CODE(+)) \n");
		//sbSql.append("                       AND SUBSTR(A.ITEM_CODE,1,6)||'00' = C.ITEM_CLASS(+) \n");
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)) \n");
		//sbSql.append("                       AND (C.USE_YN(+) = 'Y') \n");
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') \n");
		//sbSql.append("                                            AND TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD'),-1),'YYYYMMDD')) \n");
		//sbSql.append("                       AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                   ) A \n");
		//sbSql.append("                 , FMS_UPJANG B \n");
		//sbSql.append("                 , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
		//sbSql.append("             WHERE A.TRANS_UPJANG = B.UPJANG \n");
		//sbSql.append("               AND ITEM_CLASS     = D.CLASS_CODE \n");
		
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
		//sbSql.append("             --------- \n");
		//sbSql.append("             UNION ALL \n");
		//sbSql.append("             --------- \n");
		//sbSql.append("            SELECT B.PART_SALES_SABUN, CLASS_NAME \n");
		//sbSql.append("                 , 0 PRE_SALE_AMOUNT \n");
		//sbSql.append("                 , 0 PRE_UNIT_AMOUNT \n");
		//sbSql.append("                 , SALE_AMOUNT \n");
		//sbSql.append("                 , UNIT_AMOUNT \n");
		//sbSql.append("              FROM ( \n");
		//sbSql.append("                    SELECT /*+ INDEX(A PO_TRANSACTION_PT_I6) */ \n");
		//sbSql.append("                           A.TRANS_UPJANG, SUBSTR(A.ITEM_CODE,1,4)||'0000' AS ITEM_CLASS \n");
		//sbSql.append("                         , ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *  " + str_Div + ") AS SALE_AMOUNT \n");
		//sbSql.append("                         , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT UNIT_AMOUNT, A.CENTER_CODE, C.FM_SALE_RATE \n");
		//sbSql.append("                      FROM HLDC_PO_TRANSACTION A, HLDC_FM_SALE_RATE C \n");
		//sbSql.append("                     WHERE (A.SUBINV_CODE  = C.SUBINV_CODE(+)) \n");
		//sbSql.append("                       AND SUBSTR(A.ITEM_CODE,1,6)||'00' = C.ITEM_CLASS(+) \n");		
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)) \n");
		//sbSql.append("                       AND (C.USE_YN(+) = 'Y') \n");
		//sbSql.append("                       AND (A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "') \n");
		//sbSql.append("                       AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                   ) A \n");
		//sbSql.append("                 , FMS_UPJANG B \n");
		//sbSql.append("                 , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
		//sbSql.append("             WHERE A.TRANS_UPJANG = B.UPJANG \n");
		//sbSql.append("               AND ITEM_CLASS     = D.CLASS_CODE \n");
		
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
		//sbSql.append("             GROUP BY PART_SALES_SABUN, CLASS_NAME \n");
			
		sbSql.append("    SELECT  (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN = PART_SALES_SABUN) PART_SALES_SABUNNM, CLASS_NAME \n");
		sbSql.append("                 --전월실적 \n");
		sbSql.append("                 , SUM(PRE_SALE_AMOUNT) SUM_A \n");
		sbSql.append("                 , SUM(PRE_SALE_AMOUNT) - SUM(PRE_UNIT_AMOUNT) SUM_B \n");
		sbSql.append("                 , DECODE(SUM(PRE_SALE_AMOUNT),0,0,100*(SUM(PRE_SALE_AMOUNT) - SUM(PRE_UNIT_AMOUNT))/SUM(PRE_SALE_AMOUNT)) SUM_C \n");
		sbSql.append("                 , SUM(PRE_SALE_AMOUNT)/(1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) SUM_D \n");
		sbSql.append("                 --당월실적 \n");
		sbSql.append("                 , SUM(SALE_AMOUNT) SUM_E \n");
		sbSql.append("                 , SUM(SALE_AMOUNT) - SUM(UNIT_AMOUNT) SUM_F \n");
		sbSql.append("                 , DECODE(SUM(SALE_AMOUNT),0,0,100*(SUM(SALE_AMOUNT) - SUM(UNIT_AMOUNT))/SUM(SALE_AMOUNT)) SUM_G \n");
		sbSql.append("                 , SUM(SALE_AMOUNT)/(1 + TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD') - TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD')) SUM_H \n");
		sbSql.append("                 --전월대비 \n");
		sbSql.append("                 , 0 SUM_I \n");
		sbSql.append("                 , 0 SUM_J \n");
		sbSql.append("                 , 0 SUM_K \n");
		sbSql.append("                 , 0 SUM_L \n");
		sbSql.append("              FROM \n");
		sbSql.append("            ( \n");
		sbSql.append("            SELECT B.PART_SALES_SABUN, CLASS_NAME \n");
		sbSql.append("                 , PRE_SALE_AMOUNT \n");
		sbSql.append("                 , PRE_UNIT_AMOUNT \n");
		sbSql.append("                 , SALE_AMOUNT \n");
		sbSql.append("                 , UNIT_AMOUNT \n");
		sbSql.append("              FROM ( \n");
        //sbSql.append("                    SELECT /*+ PARALLEL(A,4) */                                                                                                                               \n");
        sbSql.append("                    SELECT /*+ LEADING(A C) USE_HASH(A C) SWAP_JOIN_INPUTS(C) */ A.TRANS_UPJANG,                                                                                                                                    \n");
        sbSql.append("                           C.ITEM_CLASS2 AS ITEM_CLASS,                                                                                                     \n");
        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD'),-1),'YYYYMMDD') THEN \n");
        sbSql.append("                                   ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY *   " + str_Div + ")                                                            \n");
        sbSql.append("                                ELSE                                                                                                                                          \n");
        sbSql.append("                                   0                                                                                                                                          \n");
        sbSql.append("                           END AS PRE_SALE_AMOUNT,                                                                                                                            \n");
        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') AND TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATETO + "','YYYYMMDD'),-1),'YYYYMMDD') THEN \n");
        sbSql.append("                                   DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT                                                                                  \n");
        sbSql.append("                                ELSE                                                                                                                                          \n");
        sbSql.append("                                   0                                                                                                                                          \n");
        sbSql.append("                           END AS PRE_UNIT_AMOUNT,                                                                                                                            \n");
        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "' THEN                                                                                      \n");
        sbSql.append("                                   ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY * " + str_Div + ")                                                              \n");
        sbSql.append("                                ELSE                                                                                                                                          \n");
        sbSql.append("                                   0                                                                                                                                          \n");
        sbSql.append("                           END AS SALE_AMOUNT,                                                                                                                                \n");
        sbSql.append("                           CASE WHEN A.TRANS_DATE BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "' THEN                                                                                      \n");
        sbSql.append("                                   DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.UNIT_AMOUNT                                                                                  \n");
        sbSql.append("                                ELSE                                                                                                                                          \n");
        sbSql.append("                                   0                                                                                                                                          \n");
        sbSql.append("                           END AS UNIT_AMOUNT,                                                                                                                                \n");
        sbSql.append("                           A.CENTER_CODE                                                                                                                                     \n");
       // sbSql.append("                           C.FM_SALE_RATE                                                                                                                                     \n");
        sbSql.append("                      FROM FMS_TRANSACTION_V A, HLDC_PO_ITEM_MST C                                                                                                         \n");
        sbSql.append("                     WHERE (A.ITEM_CODE  = C.ITEM_CODE)                                                                                                                \n");
       // sbSql.append("                       AND SUBSTR(A.ITEM_CODE,1,6)||'00' = C.ITEM_CLASS(+)                                                                                                    \n");
        sbSql.append("                       AND (A.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + str_in_TRANS_DATEFR + "','YYYYMMDD'),-1),'YYYYMMDD') AND '" + str_in_TRANS_DATETO + "')                                            \n");
        sbSql.append("                       AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))                                                                     \n");
      //  sbSql.append("                       AND (A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+))                                                                                                   \n");
      //  sbSql.append("                       AND (C.USE_YN(+) = 'Y')                                                                                                                                \n");
		sbSql.append("                   ) A \n");
		sbSql.append("                 , FMS_UPJANG B \n");
		sbSql.append("                 , HLDC_PO_ITEM_CLASS_HLDC_V D \n");
		sbSql.append("                 , HLDC_SC_DEPT_V E \n");
		sbSql.append("             WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("               AND A.ITEM_CLASS = D.CLASS_CODE \n");
		sbSql.append("               AND B.DEPT_ID = E.DEPT_ID \n");
		
		if (!str_in_DEPT_ID.equals("")){
			sbSql.append("            AND   (E.TM_CD               = '" + str_in_DEPT_ID  + "') \n");
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
				
		sbSql.append("            ) \n");
		sbSql.append("             GROUP BY PART_SALES_SABUN, CLASS_NAME \n");
		
		//=========================================================================================
		// (2013-08-27 변경) 끝
		//=========================================================================================		
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