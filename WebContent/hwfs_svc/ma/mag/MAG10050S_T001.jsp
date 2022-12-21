ek.<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/매출조회
■ 프로그램ID   : AMG10051S_T001.jsp
■ 프로그램명   : 사업장별매출집계(조회)
■ 작성일자     : 2008-02-25
■ 작성자       : 황승한
■ 이력관리     :                                                                                                                                                                             
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


		//Master 조회###########################################################################

		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		System.out.println("str_in_HOMEPLUS:" + str_in_HOMEPLUS);
		//내역조회

		sbSql.append("    SELECT A.OCCUR_DATE, \n");
		sbSql.append("           DECODE(TO_CHAR(TO_DATE(A.OCCUR_DATE, 'YYYYMMDD'), 'dy', 'NLS_DATE_LANGUAGE=AMERICAN'), 'mon', '월', 'tue', '화', 'wed', '수', 'thu', '목', 'fri', '금', 'sat', '토', 'sun', '일') AS OCCUR_DAY, \n");
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
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND T3.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
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
		 

		
//***************************************************************여기까지*******************************************************************		
		
/* 		
		//호텔 및 63 업장 내역조회 2010.07.26#######################################
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
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND C.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}
		sbSql.append("            GROUP BY C.UPJANG, \n");
		sbSql.append("                     V.IF_DATE, \n");
		sbSql.append("                     V.TAX_CODE \n");		
		//호텔 및 63 업장 내역조회 2010.07.26#######################################		
		
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

		/**종료**/
		out_dl.add(ds_list);



		//Detail1 조회###########################################################################
		//out 데이타
		DataSet ds_listDetail1;
		//sql문 버퍼생성
		sbSql.delete(0,sbSql.length());

		//내역조회

		sbSql.append("    SELECT  \n");
		                       if (!str_in_HOMEPLUS.equals("1")){ 
		                    	   sbSql.append("   UPJANG_CD, \n");
		                       }
		if(str_in_MU_CD.equals("2002")){
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1103_310_QTY, \n");//식음식료과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1103_410_QTY, \n");//식음식료면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1104_310_QTY, \n");//식음음료과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1104_410_QTY, \n");//식음음료면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1603_310_QTY, \n");//장례식료과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1603_410_QTY, \n");//장례식료면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1101_310_QTY, \n");//상품일반과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1101_410_QTY, \n");//상품일반면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1102_310_QTY, \n");//상품슈퍼과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1102_410_QTY, \n");//상품슈퍼면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1602_310_QTY, \n");//장례매점과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1602_410_QTY, \n");//장례매점면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1701_310_QTY, \n");//특판과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1701_410_QTY, \n");//특판면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1105_310_QTY, \n");//임대과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1105_410_QTY, \n");//임대면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1106_310_QTY, \n");//기타과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1106_410_QTY, \n");//기타면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1901_310_QTY, \n");//페유과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1901_410_QTY, \n");//폐유면세식수
		}else if(str_in_MU_CD.equals("2003")){
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1204') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1103_310_QTY, \n");//식음식료과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1204') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1103_410_QTY, \n");//식음식료면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1205') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) F1104_310_QTY, \n");//식음음료과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1205') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) F1104_410_QTY, \n");//식음음료면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1201','1203','1209') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1101_310_QTY, \n");//상품일반과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1201','1203','1209') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1101_410_QTY, \n");//상품일반면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1102_310_QTY, \n");//상품유류과세식수	: 2015.10.23 유류탭 추가에 의한 ''처리
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1102_410_QTY, \n");//상품유류면세식수	: 2015.10.23 유류탭 추가에 의한 ''처리
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1902_310_QTY, \n");//상품유류과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1902_410_QTY, \n");//상품유류면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1701_310_QTY, \n");//상품휴게소과세식수  : 2015.10.23 주유소탭 추가에 의한 ''처리
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('999') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1701_410_QTY, \n");//상품휴게소면세식수 : 2015.10.23 주유소탭 추가에 의한 ''처리 
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) S1801_310_QTY, \n");//상품휴게소과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) S1801_410_QTY, \n");//상품휴게소면세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1206') AND VAT_CLASS = '20' THEN QTY  ELSE 0 END)), 0) E1105_310_QTY, \n");//기타과세식수
			sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1206') AND VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) E1105_410_QTY, \n");//기타면세식수
		}
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN QTY ELSE 0 END)), 0) TOT_310_QTY, \n");//과세식수소계
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS <> '20' THEN QTY ELSE 0 END)), 0) TOT_410_QTY, \n");//면세식수소계
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS = '20' THEN F_AMT ELSE 0 END)), 0) F1103_310_AMT, \n");//식음식료과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS <> '20' THEN F_AMT ELSE 0 END)), 0) F1103_410_AMT, \n");//식음식료면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109','1205') AND VAT_CLASS = '20' THEN F_AMT ELSE 0 END)), 0) F1104_310_AMT, \n");//식음음료과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109','1205') AND VAT_CLASS <> '20' THEN F_AMT ELSE 0 END)), 0) F1104_410_AMT, \n");//식음음료면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN F_AMT ELSE 0 END)), 0) F1603_310_AMT, \n");//장례식료과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS <> '20' THEN F_AMT ELSE 0 END)), 0) F1603_410_AMT, \n");//장례식료면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1203','1209') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1101_310_AMT, \n");//상품일반과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1203','1209') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1101_410_AMT, \n");//상품일반면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1801_310_AMT, \n");//주유소 과세		: 2015.10.23 추가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1801_410_AMT, \n");//주유소 면세		: 2015.10.23 추가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1102_310_AMT, \n");//상품슈퍼과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1102_410_AMT, \n");//상품슈퍼면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1902_310_AMT, \n");//유류과세		: 2015.10.23 추가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1902_410_AMT, \n");//유류면세	: 2015.10.23 추가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1602_310_AMT, \n");//장례매점과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1602_410_AMT, \n");//장례매점면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN S_AMT ELSE 0 END)), 0) S1701_310_AMT, \n");//특판과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS <> '20' THEN S_AMT ELSE 0 END)), 0) S1701_410_AMT, \n");//특판면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112','1206') AND VAT_CLASS = '20' THEN E_AMT ELSE 0 END)), 0) E1105_310_AMT, \n");//임대과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112','1206') AND VAT_CLASS <> '20' THEN E_AMT ELSE 0 END)), 0) E1105_410_AMT, \n");//임대면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS = '20' THEN E_AMT ELSE 0 END)), 0) E1106_310_AMT, \n");//기타과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS <> '20' THEN E_AMT ELSE 0 END)), 0) E1106_410_AMT, \n");//기타면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN E_AMT ELSE 0 END)), 0) E1901_310_AMT, \n");//폐유과세공급가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS <> '20' THEN E_AMT ELSE 0 END)), 0) E1901_410_AMT, \n");//폐유면세공급가
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN F_AMT + S_AMT + E_AMT ELSE 0 END)), 0) TOT_310_AMT, \n");//과세공급가소계
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS <> '20' THEN  F_AMT + S_AMT + E_AMT ELSE 0 END)), 0) TOT_410_AMT, \n");//면세공급가소계
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) ELSE 0 END)), 0) F1103_310_VAT,\n");//식음식료부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109','1205') AND VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) ELSE 0 END)), 0) F1104_310_VAT,\n");//식음음료부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) ELSE 0 END)), 0) F1603_310_VAT,\n");//장례식료부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1209') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1101_310_VAT, \n");//상품일반부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1801_310_VAT, \n");//휴게소 부가세 : 2015.10.23 추가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1102_310_VAT, \n");//상품슈퍼부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1902_310_VAT, \n");//유류 부가세 : 2015.10.23 추가
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1602_310_VAT, \n");//장례슈퍼부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN (S_AMT_TOT - S_AMT) ELSE 0 END)), 0) S1701_310_VAT, \n");//특판부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS = '20' THEN (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) E1105_310_VAT, \n");//임대부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113') AND VAT_CLASS = '20' THEN (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) E1106_310_VAT, \n");//기타부가세
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) E1901_310_VAT, \n");//폐유부가세
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN (F_AMT_TOT - F_AMT) + (S_AMT_TOT - S_AMT) + (E_AMT_TOT - E_AMT) ELSE 0 END)), 0) TOT_310_VAT, \n");//부가세소계
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1204') AND VAT_CLASS = '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1103_310_TOT, \n");//식음식료과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1103','2001','1108','1205') AND VAT_CLASS <> '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1103_410_TOT, \n");//식음식료면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS = '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1104_310_TOT, \n");//식음음료과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1104','2002','1109') AND VAT_CLASS <> '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1104_410_TOT, \n");//식음음료면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS = '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1603_310_TOT, \n");//장례식료과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1603') AND VAT_CLASS <> '20' THEN F_AMT_TOT ELSE 0 END)), 0) F1603_410_TOT, \n");//장례식료면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1209') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1101_310_TOT, \n");//상품일반과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1101','1110','1201','1209') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1101_410_TOT, \n");//상품일반면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1801_310_TOT, \n");//휴게소과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1203') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1801_410_TOT, \n");//휴게소과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1902_310_TOT, \n");//유류과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1202') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1902_410_TOT, \n");//유류과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1102_310_TOT, \n");//상품슈퍼과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1102','2004','1111') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1102_410_TOT, \n");//상품슈퍼면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1602_310_TOT, \n");//장례슈퍼과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1602') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1602_410_TOT, \n");//장례슈퍼면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS = '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1701_310_TOT, \n");//특판과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1701') AND VAT_CLASS <> '20' THEN S_AMT_TOT ELSE 0 END)), 0) S1701_410_TOT, \n");//특판면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS = '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1105_310_TOT, \n");//임대과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1105','1112') AND VAT_CLASS <> '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1105_410_TOT, \n");//임대면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS = '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1106_310_TOT, \n");//기타과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1106','2003','1113','1114') AND VAT_CLASS <> '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1106_410_TOT, \n");//기타면세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS = '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1901_310_TOT, \n");//폐유과세매출
		sbSql.append("           NVL(SUM((CASE WHEN SALS_CLASS IN ('1901') AND VAT_CLASS <> '20' THEN E_AMT_TOT ELSE 0 END)), 0) E1901_410_TOT, \n");//폐유면세매출
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS = '20' THEN F_AMT_TOT + S_AMT_TOT + E_AMT_TOT ELSE 0 END)), 0) TOT_310_TOT, \n");//과세매출소계
		sbSql.append("           NVL(SUM((CASE WHEN VAT_CLASS <> '20' THEN F_AMT_TOT + S_AMT_TOT + E_AMT_TOT ELSE 0 END)), 0) TOT_410_TOT \n");//면세매출소계
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
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		 sbSql.append("            AND T3.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
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
		//호텔 및 63 업장 내역조회 2010.07.26#######################################
		sbSql.append("    UNION ALL \n");
		
		sbSql.append("    SELECT UPJANG, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '식음료매출액' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '식음료매출액' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) F_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '상품매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '상품매출' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) S_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '기타매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '기타매출' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) E_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND = '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_310_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND <> '310' THEN \n");
		sbSql.append("                              QTY \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_410_QTY, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '식음료매출액' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              F_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '식음료매출액' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              F_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '상품매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              S_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '상품매출' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              S_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '기타매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '기타매출' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) E_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND = '310' THEN \n");
		sbSql.append("                              F_AMT + S_AMT + E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_310_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND <> '310' THEN \n");
		sbSql.append("                              F_AMT + S_AMT + E_AMT \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_410_AMT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '식음료매출액' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              (F_AMT_TOT - F_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '상품매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              (S_AMT_TOT - S_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '기타매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              (E_AMT_TOT - E_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN TAX_KIND = '310' THEN \n");
		sbSql.append("                              (F_AMT_TOT - F_AMT) + (S_AMT_TOT - S_AMT) + (E_AMT_TOT - E_AMT) \n");
		sbSql.append("                         ELSE 0 END)), 0) TOT_310_VAT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '식음료매출액' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              F_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_310_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '식음료매출액' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              F_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) F_410_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '상품매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              S_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_310_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '상품매출' AND TAX_KIND <> '310' THEN \n");
		sbSql.append("                              S_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) S_410_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '기타매출' AND TAX_KIND = '310' THEN \n");
		sbSql.append("                              E_AMT_TOT \n");
		sbSql.append("                         ELSE 0 END)), 0) E_310_TOT, \n");
		sbSql.append("           NVL(SUM((CASE WHEN ACCT_NAME = '기타매출' AND TAX_KIND <> '310' THEN \n");
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
		sbSql.append("                   DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', '식음료매출액', '401023', '상품매출', '기타매출')  ACCT_NAME, \n");
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
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND C.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}
		sbSql.append("            GROUP BY C.UPJANG, \n");
		sbSql.append("                     DECODE(SUBSTR(V.ACCTCD, 1, 6), '401022', '식음료매출액', '401023', '상품매출', '기타매출'), \n");
		sbSql.append("                     DECODE(V.TAX_CODE, '100', '310', '210', '410', '220', '350') \n");
		sbSql.append("            ) V \n");
		sbSql.append("       GROUP BY UPJANG \n");
		//호텔 및 63 업장 내역조회 2010.07.26#######################################
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

		/**종료**/
		out_dl.add(ds_listDetail1);


		//Detail2 조회###########################################################################
		//out 데이타
		DataSet ds_listDetail2;
		//sql문 버퍼생성
		sbSql.delete(0,sbSql.length());

		//내역조회

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
		//매점포스는 창고코드를 DETAIL에서 가져와야함(아이템별로 창고코드가 다를 수 있음) 2016.08.24 김호석 수정
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
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		  sbSql.append("            AND T3.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
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
		//호텔 및 63 업장 내역조회 2010.07.26#######################################
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
		sbSql.append("                   DECODE(V.TAX_CODE, '100', '과세', '210', '면세', '220', '영세') TAX_KINDNM, \n");
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
		//(2012-05-22 추가) 시작
		//2012-05-22 CSR#(CH201205_00127) 요청자:이혜은(FC기획팀)
		//강제 조회 차단 : 카이스트교수회관점 (113228), 카이스트학사점 (113229), 대전보건대학점 (104663), 대전보건대청운대점(104729), 대전보건대비봉숙점(104728)
		//============================================================================================
		//sbSql.append("            AND   C.UPJANG NOT IN (121930) \n");
		sbSql.append("            AND C.UPJANG NOT IN (SELECT Z.CODE FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'MA0048' AND Z.USE_YN = 'Y') \n");
		//============================================================================================
		//(2012-05-22 추가) 끝
		//============================================================================================

		if (!str_in_UPJANG.equals("")){
			sbSql.append("            AND   (C.UPJANG      = " + str_in_UPJANG  + ") \n");
		}
		sbSql.append("            GROUP BY C.UPJANG, \n");
		sbSql.append("                     V.TAX_CODE \n");
		sbSql.append("            ) V \n");
		sbSql.append("     GROUP BY V.UPJANG, \n");
		sbSql.append("              V.SUBINV_CODE \n");
		//호텔 및 63 업장 내역조회 2010.07.26#######################################		
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

		/**종료**/
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>