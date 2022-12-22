<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식채권관리
■ 프로그램ID   : MAK10170S_T003_tune.jsp
■ 프로그램명   : 입금 및 여신현황조회(전체업장)
■ 작성일자     : 
■ 작성자       : 
■ 이력관리     : 
* HISTORY    : 
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List, ds_ListTmp;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();


		//본사통합 업장내역조회(속도관계상 운영율은 적용하지 않는다.)
		//여신연장금액 삭제
		sbSql.delete(0,sbSql.length());
	
	    sbSql.append("SELECT  A.MAIN_UPJANG		,DECODE(A.MAIN_UPJANG,A.UPJANG,'0','1')  AS BON_GB  --이거 타는건가?? \n");
		sbSql.append("       , A.UPJANG \n");
		sbSql.append("       , DECODE(A.MAIN_UPJANG,A.UPJANG,NULL,' - ')||A.UPJANGNM_DISP UPJANGNM_DISP														/* 업장명 */ \n");
		sbSql.append("       , (CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS AMT1  \n");
		sbSql.append("       , (CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS AMT1_0  \n");
		sbSql.append("       , 0 AS AMT1_1  \n");
		sbSql.append("       , DECODE(A.MAIN_UPJANG,A.UPJANG,(SELECT SUM(BUY_SCHD_AMT) FROM CREDITAMT_SUM_MST WHERE UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG V WHERE V.MAIN_UPJANG = A.MAIN_UPJANG  AND V.HEAD_CREDIT_YN ='Y')) ,BUY_SCHD_AMT) AS AMT1_2 \n");
		sbSql.append("       , DECODE(A.MAIN_UPJANG,A.UPJANG,(SELECT SUM(BUY_CONFIRM_AMT) FROM CREDITAMT_SUM_MST WHERE UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG V WHERE V.MAIN_UPJANG = A.MAIN_UPJANG  AND V.HEAD_CREDIT_YN ='Y')) ,BUY_CONFIRM_AMT)  AS AMT1_3   \n");
		//sbSql.append("	     , DECODE(A.MAIN_UPJANG,A.UPJANG,(CRDT_SALS_AMT - RECEIVE_AMT),0)   AS AMT2_0  \n");
		sbSql.append("	     , DECODE(A.MAIN_UPJANG,A.UPJANG,FMS_GET_CREDIT_CRDT_FUN(A.UPJANG),0)   AS AMT2_0  \n");
		sbSql.append("	     , DECODE(A.MAIN_UPJANG,A.UPJANG, (ADVANCE_AMT-ADVANCE_AMT_ALT),0)  AS AMT2_3  \n");
		sbSql.append("       , 0 AS AMT2  \n");
		sbSql.append("       , 0 AS AMT2_1  \n");
		sbSql.append("       , DECODE(A.MAIN_UPJANG,A.UPJANG,FMS_GET_CREDIT_FUN(A.UPJANG, 'N'),0) AS AMT3               --AS CREDIT_RMN_AMT     			/* 가용여신 */ \n");
		sbSql.append("       , A.HEAD_CREDIT_YN 	TOT_YN	 											/*통합관리여부*/    \n");     													
        sbSql.append("       , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("       ,'YYY','금액+회전일','YYN','회전일통제','YNY','금액통제','무통제') AS CTRL /*통제구분*/ \n");
		sbSql.append("       , A.CREDIT_TURN_DAYS                \n");
		sbSql.append("       , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD                                                   \n");
		sbSql.append("       , DECODE(A.MAIN_UPJANG,A.UPJANG,'Y','N') AS SUM_FLAG               \n");
		sbSql.append("       , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("              THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT 		/* 여신한도초과액*/  \n");
		sbSql.append("       ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END   \n");
		sbSql.append("FROM FMS_UPJANG A, \n");
		sbSql.append("     CREDITAMT_SUM_MST B \n");
		sbSql.append("WHERE 1=1 \n");
		//sbSql.append("AND   A.MAIN_UPJANG = B.UPJANG_CD   \n");
		sbSql.append("AND   A.UPJANG = B.UPJANG_CD   \n");
		//--영업사원코드가 들어오면 
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		    sbSql.append("AND    A.PART_SALES_SABUN =  '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		// if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		// --업장코드가 들어오면(본사OR사업장)	
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
	       sbSql.append(" AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n"); 
		
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals(""))
		    // sbSql.append(" AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n"); 
		    sbSql.append("  AND B.UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " AND HEAD_CREDIT_YN = 'Y') \n"); 
		//사용여부
	    if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
		    sbSql.append("	AND A.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");		                                                                                                                                                                     
	    
	    sbSql.append("	AND A.HEAD_CREDIT_YN = 'Y'  \n");	
		//sbSql.append("	ORDER BY A.MAIN_UPJANG, BON_GB, TOT_YN, UPJANG \n");		
	     
	    
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close(); 

		
		//사업장 업장내역조회(속도관계상 운영율은 적용하지 않는다.)
		//여신연장금액 삭제
		sbSql.delete(0,sbSql.length());
	    sbSql.append("SELECT  A.MAIN_UPJANG		,DECODE(A.MAIN_UPJANG,A.UPJANG,'0','1')  AS BON_GB   \n");
		sbSql.append("       , A.UPJANG \n");
		sbSql.append("       , A.UPJANGNM_DISP														/* 업장명 */ \n");
		sbSql.append("       ,(CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS AMT1  \n");
	    sbSql.append("       ,(CASE WHEN NVL(A.CREDIT_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END) AS AMT1_0  \n");
		sbSql.append("       , 0 AS AMT1_1  \n");
		sbSql.append("       , BUY_SCHD_AMT AS AMT1_2  \n");
		sbSql.append("       , BUY_CONFIRM_AMT AS AMT1_3  \n");
		sbSql.append("	     , (CRDT_SALS_AMT - RECEIVE_AMT) AS AMT2_0  \n");
	    sbSql.append("	     , (ADVANCE_AMT-ADVANCE_AMT_ALT) AS AMT2_3  \n");
		sbSql.append("       , 0 AS AMT2  \n");
		sbSql.append("       , 0 AS AMT2_1  \n");
		sbSql.append("       , FMS_GET_CREDIT_FUN(A.UPJANG, 'N') AS AMT3               --AS CREDIT_RMN_AMT     			/* 가용여신 */ \n");
		sbSql.append("       , A.HEAD_CREDIT_YN 	TOT_YN	 											/*통합관리여부*/       \n");										
        sbSql.append("       , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		sbSql.append("       ,'YYY','금액+회전일','YYN','회전일통제','YNY','금액통제','무통제') AS CTRL /*통제구분*/ \n");
		sbSql.append("       , A.CREDIT_TURN_DAYS                \n");
		sbSql.append("       , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD                                                   \n");
		sbSql.append("       , 'Y' AS SUM_FLAG               \n");
		sbSql.append("       , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append("              THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT 		/* 여신한도초과액*/  \n");
		sbSql.append("       ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE, 'YYYYMMDD') THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END   \n");
		sbSql.append("FROM FMS_UPJANG A, \n");
		sbSql.append("     CREDITAMT_SUM_MST B \n");
		sbSql.append("WHERE 1=1 \n");
		sbSql.append("AND A.UPJANG = B.UPJANG_CD  \n");
		//--영업사원코드가 들어오면 
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
			sbSql.append(" AND A.PART_SALES_SABUN =  '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		// if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		// --업장코드가 들어오면(본사OR사업장)	
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals(""))
			sbSql.append(" AND A.UPJANG IN ( SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " )  \n"); 
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
		    sbSql.append(" AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n"); 
		//사용여부
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals(""))				
			 sbSql.append("	AND A.USE_YN = '" + nullToBlank(ds_Cond.getString(0, "USE_YN")) + "' \n");		          
		     sbSql.append("	AND A.HEAD_CREDIT_YN = 'N' \n");	

        out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_ListTmp = this.makeDataSet(rs, "ds_ListTmp");
		rs.close();
		pstmt.close();		
		
		
		
		
		/**종료**/
		out_dl.add(ds_ListTmp);
		out_dl.add(ds_List);
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
