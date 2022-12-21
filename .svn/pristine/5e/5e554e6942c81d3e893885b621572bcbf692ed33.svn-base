<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/매출조회
■ 프로그램ID   : AMG10051S_T001.jsp
■ 프로그램명   : 월별매출(조회)
■ 작성일자     : 2008-02-25
■ 작성자       : 황승한
■ 이력관리     : 2008-02-25
: 박은규 2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
  강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
	공통코드 MA0048 에 예외업장 설정
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
		
	
		String str_in_OCCUR_DATE     = nullToBlank(ds_cond.getString(0, "OCCUR_DATE"));
		String str_in_MU_CD        = nullToBlank(ds_cond.getString(0, "MU_CD"));
		String str_in_TM_CD        = nullToBlank(ds_cond.getString(0, "TM_CD"));
		String str_in_UPJANG       = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String str_in_SUB_JOB_CD   = nullToBlank(ds_cond.getString(0, "SUB_JOB_CD"));
		String str_in_LOC_CD       = nullToBlank(ds_cond.getString(0, "LOC_CD"));
		String str_in_UNIT         = nullToBlank(ds_cond.getString(0, "UNIT"));
		String str_in_HOMEPLUS     = nullToBlank(ds_cond.getString(0, "HOMEPLUS"));
		
		
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회	
		sbSql.append("    /* MAG10052S_T001.jsp */ \n");
		sbSql.append("    SELECT V.SAUP_TYPE, \n");
		sbSql.append("           (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0001' AND CODE = V.SAUP_TYPE) SAUP_TYPENM, \n");
		sbSql.append("           V.GUBUN, \n");
		sbSql.append("           V.TM_CD, \n");
		sbSql.append("           V.TM_NM, \n");
		sbSql.append("           V.UPJANG_CD, \n");
		sbSql.append("           V.UPJANGNM, \n");
		sbSql.append("           V.SUB_UPJANG, \n");
		sbSql.append("          (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = V.SUB_UPJANG) SUB_UPJANGNM, \n");
		sbSql.append("           V.NEW_GUBUN, \n");
			
		String str_Date    = "";
		String str_DateSQL = "";		
		
		//int i;
		
		for ( int i = 1 ; i <= 12 ; i++ ){
	        
			
	        str_Date = Integer.toString(i);
	        
	        if (i < 10)
			str_Date = "0" + str_Date;
				        		
	        str_DateSQL += " SUM(DECODE(SUBSTR(V.OCCUR_DATE, 5, 2), '" + str_Date + "', QTY, 0)) QTY" + str_Date  + ",\n";
	        str_DateSQL += " ROUND(SUM(DECODE(SUBSTR(V.OCCUR_DATE, 5, 2), '" + str_Date + "', F_AMT, 0))/" + str_in_UNIT + ") F_AMT" + str_Date  + ",\n";
	        str_DateSQL += " ROUND(SUM(DECODE(SUBSTR(V.OCCUR_DATE, 5, 2), '" + str_Date + "', S_AMT, 0))/" + str_in_UNIT + ") S_AMT" + str_Date  + ",\n";
	        str_DateSQL += " ROUND(SUM(DECODE(SUBSTR(V.OCCUR_DATE, 5, 2), '" + str_Date + "', E_AMT, 0))/" + str_in_UNIT + ") E_AMT" + str_Date  + ",\n";
	        str_DateSQL += " ROUND((SUM(DECODE(SUBSTR(V.OCCUR_DATE, 5, 2), '" + str_Date + "', F_AMT, 0)) + SUM(DECODE(SUBSTR(V.OCCUR_DATE, 5, 2), '" + str_Date + "', S_AMT, 0)) + SUM(DECODE(SUBSTR(V.OCCUR_DATE, 5, 2), '" + str_Date + "', E_AMT, 0)))/" + str_in_UNIT + ") TOT_AMT" + str_Date  + ",\n";
				

	    }
    
	    sbSql.append(str_DateSQL);
	    
	    sbSql.append("     SUM(QTY) TOT_QTY, \n");
		sbSql.append("     ROUND(SUM(F_AMT)/" + str_in_UNIT + ") TOT_F_AMT, \n");
		sbSql.append("     ROUND(SUM(S_AMT)/" + str_in_UNIT + ") TOT_S_AMT, \n");
		sbSql.append("     ROUND(SUM(E_AMT)/" + str_in_UNIT + ") TOT_E_AMT, \n");
		sbSql.append("     ROUND((SUM(F_AMT) + SUM(S_AMT) + SUM(E_AMT))/" + str_in_UNIT + ") TOT_TOT_AMT, \n");
		sbSql.append("           V.SAUP_TYPE||'-'||V.TM_CD||'-'||V.UPJANG_CD||'-'||V.SUB_UPJANG PL_CD, \n");
		sbSql.append("           '10' PL_UP_CD, \n");
		sbSql.append("           DECODE(V.GUBUN, 'HWFC', '10', '0') BL_SHOW, \n");
		sbSql.append("           4 LEVEL_NO, \n");
		sbSql.append("           '+' BL_PLUS \n");
		sbSql.append("      FROM ( \n");
		sbSql.append("            SELECT T3.SAUP_TYPE, \n");
		sbSql.append("                   'HWFC' GUBUN, \n");
		sbSql.append("                   T3.MU_CD, \n");
		sbSql.append("                   T3.TM_CD, \n");
		sbSql.append("                   T3.TM_NM, \n");
		sbSql.append("                   T2.UPJANG_CD, \n");
		sbSql.append("                   T3.UPJANGNM, \n");
		sbSql.append("                   NULL SUB_UPJANG, \n");
		sbSql.append("                   (CASE WHEN SUBSTR(MAX(T3.OPEN_DATE), 1, 4) < SUBSTR('" + str_in_OCCUR_DATE + "', 1, 4)  THEN '기존' \n");
		sbSql.append("                         WHEN SUBSTR(MAX(T3.OPEN_DATE), 1, 4) >= SUBSTR('" + str_in_OCCUR_DATE + "', 1, 4) THEN '신규' \n");
		sbSql.append("                         ELSE '미지정' END) NEW_GUBUN, \n");
	  //sbSql.append("                   NVL(SUM(DECODE(T2.SALS_CLASS,'1103', T2.SAL_QUANTITY,'1104', T2.SAL_QUANTITY, 0)),0) QTY, \n");
	  //sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1103','1104') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
		if(str_in_MU_CD.equals("2002")){
		  	sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
		  	sbSql.append("                   NVL(sum((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109')  THEN T2.NET_AMT ELSE 0 END )), 0 ) F_AMT, \n");
		  	sbSql.append("                   NVL(sum((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111')  THEN T2.NET_AMT ELSE 0 END )), 0 ) S_AMT, \n");
		  	sbSql.append("                   NVL(sum((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113','1114','1901')           THEN T2.NET_AMT ELSE 0 END )), 0 ) E_AMT, \n");
		  	//		sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
	//		sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.NET_AMT ELSE 0 END)), \n");
	//		sbSql.append("                          T2.VAT_CLASS, '10', SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.NET_AMT ELSE 0 END)), \n");
	//		sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1103','1104','1603','2001','2002','1108','1109') THEN T2.SAL_AMT ELSE 0 END)) ), 0) F_AMT, \n");
	//		sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
	//		sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.NET_AMT ELSE 0 END)), \n");
	//		sbSql.append("                          T2.VAT_CLASS, '10', SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.NET_AMT ELSE 0 END)), \n");
	//		sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1101','1102','1602','1701','2004','1110','1111') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
	//		sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'20', \n");
	//		sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113') THEN T2.NET_AMT ELSE 0 END)), \n");
	//		sbSql.append("                          T2.VAT_CLASS, '10', SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113') THEN T2.NET_AMT ELSE 0 END)), \n");
	//		sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1105','1106','1901','2003','1112','1113') THEN T2.SAL_AMT ELSE 0 END)) ), 0) E_AMT, \n");
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("                   NVL(SUM((CASE WHEN T2.SALS_CLASS IN ('1204','1205','2101','2102') AND (T2.SUP_AMT_YN <> 'Y' OR T2.SUP_AMT_YN IS NULL) THEN T2.SAL_QUANTITY ELSE 0 END)), 0) QTY, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'X', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205','2101','2102') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1204','1205','2101','2102') THEN T2.NET_AMT ELSE 0 END)) ), 0) F_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'X', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1201','1202','1203','1209') THEN T2.NET_AMT ELSE 0 END)) ), 0) S_AMT, \n");
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'X', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206','2103','1901') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1206','2103','1901') THEN T2.NET_AMT ELSE 0 END)) ), 0) E_AMT, \n");
		}else if(str_in_MU_CD.equals("2004")){
			sbSql.append("                   NVL(DECODE(T2.VAT_CLASS,'10', \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1301','1302') THEN T2.NET_AMT ELSE 0 END)), \n");
			sbSql.append("                          SUM((CASE WHEN SALS_CLASS IN ('1301','1302') THEN T2.SAL_AMT ELSE 0 END)) ), 0) S_AMT, \n");
		}
		sbSql.append("                   SUBSTR(T2.OCCUR_DATE,1,6) OCCUR_DATE \n");
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
		sbSql.append("            AND    T2.OCCUR_DATE   BETWEEN '" + str_in_OCCUR_DATE + "'||'0101' AND '" + str_in_OCCUR_DATE + "'||'1231' \n");

		//============================================================================================
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		  sbSql.append("            AND T3.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
		//============================================================================================
		
		if (!str_in_MU_CD.equals("")){
			sbSql.append("            AND   T3.MU_CD      = '" + str_in_MU_CD  + "' \n");
		}
		if (!str_in_HOMEPLUS.equals("1")){
			if (!str_in_TM_CD.equals("")){
				sbSql.append("            AND   (T3.TM_CD      = '" + str_in_TM_CD  + "' OR T3.PT_CD = '" + str_in_TM_CD + "') \n");
			}
		
			if (!str_in_UPJANG.equals("")){
				sbSql.append("            AND   T2.UPJANG_CD      = " + str_in_UPJANG  + " \n");
			}
		}	
		
		
		if (str_in_HOMEPLUS.equals("1")){
			if (!str_in_UPJANG.equals("")){
				sbSql.append("            AND   T3.UPJANG    IN  (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'UPJANG_GROUP' AND Z.USE_YN = 'Y' AND SET1 = " + str_in_UPJANG  + "  ) \n");
			}
		}	
		
		if (!str_in_SUB_JOB_CD.equals("")){
			sbSql.append("            AND   T3.SUB_JOB_CD  = '" + str_in_SUB_JOB_CD  + "' \n");
		}

		if (!str_in_LOC_CD.equals("")){
			sbSql.append("            AND   T3.LOC_CD  = '" + str_in_LOC_CD  + "' \n");
		}		
		
		sbSql.append("            GROUP BY T3.SAUP_TYPE,T3.MU_CD,T3.TM_CD,T3.TM_NM,T2.UPJANG_CD,T3.UPJANGNM,SUBSTR(T2.OCCUR_DATE,1,6),T2.VAT_CLASS \n");
		
		
/*		//호텔 및 63 업장 내역조회 2010.07.26#######################################
		sbSql.append("    UNION ALL \n");				

		sbSql.append("            SELECT C.SAUP_TYPE, \n");
		sbSql.append("                   'IFIS' GUBUN, \n");
		sbSql.append("                   C.TM_CD, \n");
		sbSql.append("                   C.UPJANG, \n");
		sbSql.append("                   NULL SUB_UPJANG, \n");
		sbSql.append("                   (CASE WHEN SUBSTR(MAX(C.OPEN_DATE), 1, 4) < SUBSTR('" + str_in_SALS_DATE + "', 1, 4)  THEN '기존' \n");
		sbSql.append("                         WHEN SUBSTR(MAX(C.OPEN_DATE), 1, 4) >= SUBSTR('" + str_in_SALS_DATE + "', 1, 4) THEN '신규' \n");
		sbSql.append("                         ELSE '미지정' END) NEW_GUBUN, \n");
		sbSql.append("                   SUBSTR(V.IF_DATE, 1, 6) SALS_DATE, \n");
		sbSql.append("                   NVL(SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_QTY, 0)), 0) QTY, \n"); 
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', V.SALE_AMOUNT,0)) F_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401023', V.SALE_AMOUNT,0)) S_AMT, \n");
		sbSql.append("                   SUM(DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', 0, '401023', 0, V.SALE_AMOUNT)) E_AMT \n");
		sbSql.append("            FROM HLD3_IF_SC_GETSALE V, \n");
		sbSql.append("                 HLDC_SC_DEPT A, \n");		
		sbSql.append("                 SCO_UPJANG_MST_V C \n");
		sbSql.append("            WHERE (V.DEPT_ID = A.DEPT_ID)  \n");
		sbSql.append("            AND   (A.CC_CD   = C.CC_CD) \n");
		sbSql.append("            AND   (V.IF_DATE   BETWEEN '" + str_in_SALS_DATE + "'||'0101' AND '" + str_in_SALS_DATE + "'||'1231') \n");

		//============================================================================================
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND C.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
		//============================================================================================
		
		if (!str_in_TM_CD.equals("")){
			sbSql.append("            AND   (C.TM_CD      = '" + str_in_TM_CD  + "') \n");
		}
		
		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}

		if (!str_in_SUB_JOB_CD.equals("")){
			sbSql.append("            AND   (C.SUB_JOB_CD  = '" + str_in_SUB_JOB_CD  + "') \n");
		}

		if (!str_in_LOC_CD.equals("")){
			sbSql.append("            AND   (C.LOC_CD  = '" + str_in_LOC_CD  + "') \n");
		}		
		
		sbSql.append("            GROUP BY C.SAUP_TYPE, C.TM_CD, C.UPJANG, V.TAX_CODE, SUBSTR(V.IF_DATE, 1, 6) \n");		
		
		//호텔 및 63 업장 내역조회 2010.07.26#######################################		
 				
		sbSql.append("            UNION ALL \n");
		sbSql.append("            SELECT ");
		sbSql.append("                   (SELECT SAUP_TYPE FROM SCO_UPJANG_MST WHERE UPJANG = V.SUB_UPJANG) SAUP_TYPE, \n");
		sbSql.append("                   'FICS' GUBUN, \n");
		sbSql.append("                   C.TM_CD, \n");
		sbSql.append("                   DECODE((SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = V.SUB_UPJANG), NULL, V.SUB_UPJANG, (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = V.SUB_UPJANG)) UPJANG, \n");
		sbSql.append("                   V.SUB_UPJANG, \n");
		sbSql.append("                   (CASE WHEN SUBSTR((SELECT FST_REG_DATE FROM FMS_UPJANG WHERE UPJANG = V.SUB_UPJANG), 1, 4) < SUBSTR('" + str_in_SALS_DATE + "', 1, 4)  THEN '기존' \n");
		sbSql.append("                         WHEN SUBSTR((SELECT FST_REG_DATE FROM FMS_UPJANG WHERE UPJANG = V.SUB_UPJANG), 1, 4) >= SUBSTR('" + str_in_SALS_DATE + "', 1, 4) THEN '신규' \n");
		sbSql.append("                         ELSE '미지정' END) NEW_GUBUN, \n");
		sbSql.append("                   V.SALS_DATE, \n");
		sbSql.append("                   0 QTY, \n");
		sbSql.append("                   0 F_AMT, \n");
		sbSql.append("                   NVL(S_AMT, 0) S_AMT, \n");
		sbSql.append("                   0 E_AMT \n");
		sbSql.append("            FROM ( \n");
		sbSql.append("                   SELECT V.UPJANG SUB_UPJANG, \n");
		sbSql.append("                          SUBSTR(V.SALS_DATE, 1, 6) SALS_DATE, \n");
		sbSql.append("                          NVL(SUM(AMT) , 0) S_AMT \n");
		sbSql.append("                     FROM MAS_DD_SALE V \n");
		sbSql.append("                    WHERE (V.GUBUN = '002') \n");
		sbSql.append("                    AND   (V.SALS_DATE BETWEEN '" + str_in_SALS_DATE + "'||'0101' AND '" + str_in_SALS_DATE + "'||'1231') \n");		
		sbSql.append("                    GROUP BY V.UPJANG, \n");
		sbSql.append("                             SUBSTR(V.SALS_DATE, 1, 6) \n");
		sbSql.append("                 ) V, \n");	
		sbSql.append("                 HLDC_ST_UPJANG B, \n");
		sbSql.append("                 HLDC_SC_DEPT C \n");
		sbSql.append("            WHERE (V.SUB_UPJANG = B.UPJANG) \n");
		sbSql.append("            AND   (B.DEPT_ID    = C.DEPT_ID) \n");

		
		//============================================================================================
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   B.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND B.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
		//============================================================================================
		
		if (!str_in_TM_CD.equals("")){
			sbSql.append("            AND   (C.TM_CD      = '" + str_in_TM_CD  + "') \n");
		}
		
		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (B.UPJANG      = " + str_in_UPJANG  + ") \n");
		}


		
		sbSql.append("            UNION ALL \n");
		sbSql.append("            SELECT (SELECT SAUP_TYPE FROM SCO_UPJANG_MST WHERE UPJANG = V.UPJANG) SAUP_TYPE, \n");
		sbSql.append("                   'IFIS' GUBUN, \n");
		sbSql.append("                   C.TM_CD, \n");
		sbSql.append("                   V.UPJANG, \n");
		sbSql.append("                   NULL SUB_UPJANG, \n");
		sbSql.append("                   (CASE WHEN SUBSTR((SELECT OPEN_DATE FROM SCO_UPJANG_MST WHERE UPJANG = V.UPJANG), 1, 4) < SUBSTR('" + str_in_SALS_DATE + "', 1, 4)  THEN '기존' \n");
		sbSql.append("                         WHEN SUBSTR((SELECT OPEN_DATE FROM SCO_UPJANG_MST WHERE UPJANG = V.UPJANG), 1, 4) >= SUBSTR('" + str_in_SALS_DATE + "', 1, 4) THEN '신규' \n");
		sbSql.append("                         ELSE '미지정' END) NEW_GUBUN, \n");
		sbSql.append("                   V.SALS_DATE, \n");
		sbSql.append("                   0 QTY, \n");
		sbSql.append("                   0 F_AMT, \n");
		sbSql.append("                   0 S_AMT, \n");
		sbSql.append("                   NVL(E_AMT, 0) E_AMT \n");
		sbSql.append("            FROM ( \n");
		sbSql.append("                   SELECT V.UPJANG, \n");
		sbSql.append("                          SUBSTR(V.SALS_DATE, 1, 6) SALS_DATE, \n");
		sbSql.append("                          NVL(SUM(AMT) , 0) E_AMT \n");
		sbSql.append("                     FROM MAS_DD_SALE V \n");
		sbSql.append("                    WHERE (V.GUBUN = '001') \n");
		sbSql.append("                    AND   (V.SALS_DATE BETWEEN '" + str_in_SALS_DATE + "'||'0101' AND '" + str_in_SALS_DATE + "'||'1231') \n");		
		sbSql.append("                    GROUP BY V.UPJANG, \n");
		sbSql.append("                             SUBSTR(V.SALS_DATE, 1, 6) \n");
		sbSql.append("                 ) V, \n");	 
		sbSql.append("                 HLDC_ST_UPJANG B, \n");
		sbSql.append("                 HLDC_SC_DEPT C \n");
		sbSql.append("            WHERE (V.UPJANG  = B.UPJANG) \n");
		sbSql.append("            AND   (B.DEPT_ID = C.DEPT_ID) \n");		
		
		//============================================================================================
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   B.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND B.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
		//============================================================================================

		if (!str_in_TM_CD.equals("")){
			sbSql.append("            AND   (C.TM_CD      = '" + str_in_TM_CD  + "') \n");
		}
		
		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (B.UPJANG      = " + str_in_UPJANG  + ") \n");
		}

 */	
		
		sbSql.append("           ) V \n");
		

  			
		sbSql.append("    GROUP BY V.SAUP_TYPE, V.GUBUN, V.TM_CD, V.TM_NM, V.UPJANG_CD, V.UPJANGNM, V.SUB_UPJANG, V.NEW_GUBUN \n");
		

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