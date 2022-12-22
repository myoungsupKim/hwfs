<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/기준정보
■ 프로그램ID   : FMS00200E_T001.jsp
■ 프로그램명   : D-day제외일 조회
■ 작성일자     : 2008.03.04
■ 작성자       : 박은규
■ 이력관리     : 2008.03.04
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//FileLog.println("d:\\aaa.txt", ds_cond);
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sOp          = nullToBlank(in_vl.getString("sOp"));
	
		String sMainUpjang  = "";
		String sUpjang      = "";


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sCenterCode = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		sUpjang     = nullToBlank(ds_cond.getString(0, "UPJANG"));
		//내역조회
		sbSql.append("SELECT A.RDATE AS EXC_DATE \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.RDATE,'YYYYMMDD'),'DY', 'NLS_DATE_LANGUAGE=KOREAN') AS WEEK \n");
		sbSql.append("     , B.CONTENTS \n");
		if (sMainUpjang.equals(""))
			sbSql.append("     , SCC_YN_FUN(NVL(B.USE_YN,'N')) AS USE_YN \n");
		else
			//업장설정  조회인 경우 설정이 안되어 있으면 공통설정을 디폴트로... 
			sbSql.append("     , SCC_YN_FUN(DECODE(B.UPJANG,NULL,NVL(C.USE_YN,'N'),NVL(B.USE_YN,'N'))) AS USE_YN \n");
		sbSql.append("  FROM (SELECT '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||TRIM(TO_CHAR(ROWNUM,'00')) AS RDATE \n");
		sbSql.append("          FROM DICT \n");
		sbSql.append("         WHERE ROWNUM <= TO_CHAR(LAST_DAY(TO_DATE('" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'01','YYYYMMDD')),'DD')) A \n");
		sbSql.append("     , (SELECT * FROM FMS_EXC_DAYS A \n");
		sbSql.append("         WHERE EXC_DATE LIKE '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'%' \n");
		//본사가 없으면 공통설정
		if (sMainUpjang.equals(""))
			sbSql.append("           AND UPJANG = -1) B \n");
		else
		{
			if (sUpjang.equals(""))
			{
				//본사가 전체이고 업장이 없으면 그냥 공백으로 모든 업장을 대상으로 작업 대기
				if (sMainUpjang.equals("%"))
					sbSql.append("           AND 1=2) B \n");
				//본사가 있고 업장이 없으면 본사꺼 조회
				else
					sbSql.append("           AND UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ") B \n");
			}
			//업장이 있으면 업장꺼 조회
			else
				sbSql.append("           AND UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") B \n");
		}
		//업장설정  조회인 경우 설정이 안되어 있으면 공통설정을 디폴트로... 
		if (! sMainUpjang.equals(""))
		{
			sbSql.append("     , (SELECT * FROM FMS_EXC_DAYS \n");
			sbSql.append("         WHERE EXC_DATE LIKE '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'%' \n");
			sbSql.append("           AND UPJANG = -1) C \n");
		}
		sbSql.append(" WHERE A.RDATE = B.EXC_DATE(+) \n");
		if (! sMainUpjang.equals(""))
			sbSql.append("   AND A.RDATE = C.EXC_DATE(+) \n");
		sbSql.append(" ORDER BY A.RDATE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		//logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//pstmt.close();
		//rs.close();
		//FileLog.println("d:\\aaa.txt", ds_List);

		//out 데이타
		DataSet ds_ListUpj;
		if (! sOp.equals("1"))
		{
			//sql문 버퍼RESET
			sbSql.delete(0, sbSql.length());
	
			String sCustType  = "";
			String sCustType1  = "";
			String sCustType2 = "";
			String sCustType3 = "";
			String sCustType4 = "";
			String sCustType5 = "";
			sCustType         = nullToBlank(ds_cond.getString(0, "CUST_TYPE"));
			sCustType1        = nullToBlank(ds_cond.getString(0, "CUST_CHK1"));
			sCustType2        = nullToBlank(ds_cond.getString(0, "CUST_CHK2"));
			sCustType3        = nullToBlank(ds_cond.getString(0, "CUST_CHK3"));
			sCustType4        = nullToBlank(ds_cond.getString(0, "CUST_CHK4"));
			sCustType5        = nullToBlank(ds_cond.getString(0, "CUST_CHK5"));
			//	
			sbSql.append("SELECT A.MAIN_UPJANG \n");
			sbSql.append("     , TO_CHAR(A.MAIN_UPJANG)||'   '||B.UPJANGNM_DISP AS MAIN_UPJANGNM_DISP \n");
			sbSql.append("     , A.UPJANG, A.UPJANGNM_DISP \n");
			sbSql.append("     , NVL(C.CNT,0) AS UPJCNT \n");
			sbSql.append("     , '0' AS CHK \n");
			sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG B \n");
			sbSql.append("     ,(SELECT UPJANG, COUNT(*) AS CNT \n");
			sbSql.append("         FROM FMS_EXC_DAYS \n");
			sbSql.append("        WHERE EXC_DATE LIKE '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'%' \n");
			sbSql.append("          AND USE_YN = 'Y' \n");
			sbSql.append("        GROUP BY UPJANG) C \n");
			sbSql.append(" WHERE A.MAIN_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			//본사가 전체('%')인 경우 모든 사업장을 대상으로 작업한다. 그래서 LIKE로 조회한다. 
			sbSql.append("   AND A.MAIN_UPJANG LIKE '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "'||'%' \n");
			if (! sCenterCode.equals(""))
				sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y WHERE X.CENTER_CODE = " + sCenterCode + " AND X.UPJANG = Y.AP_UNITPRICE_UPJANG AND Y.UPJANG = A.UPJANG) \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (! sCustType.equals("")){
				sbSql.append("   AND ( 1 = 2 \n"); 
				if (! sCustType1.equals(""))
					sbSql.append("   OR A.CUST_TYPE = '" + nullToBlank(ds_cond.getString(0, "CUST_CHK1")) + "' \n");
				if (! sCustType2.equals(""))
					sbSql.append("   OR A.CUST_TYPE = '" + nullToBlank(ds_cond.getString(0, "CUST_CHK2")) + "' \n");
				if (! sCustType3.equals(""))
					sbSql.append("   OR A.CUST_TYPE = '" + nullToBlank(ds_cond.getString(0, "CUST_CHK3")) + "' \n");
				if (! sCustType4.equals(""))
					sbSql.append("   OR A.CUST_TYPE = '" + nullToBlank(ds_cond.getString(0, "CUST_CHK4")) + "' \n");
				if (! sCustType5.equals(""))
					sbSql.append("   OR A.CUST_TYPE = '" + nullToBlank(ds_cond.getString(0, "CUST_CHK5")) + "' \n");
				sbSql.append("  ) \n");				
			}
			sbSql.append("   AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
			sbSql.append(" ORDER BY A.MAIN_UPJANG, A.UPJANG \n");
	
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			//로그남기기
			//logger.debug(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());		
			rs = pstmt.executeQuery(); 
			//FileLog.println("d:\\BBB.txt", ds_ListUpj);
		}		
		ds_ListUpj = this.makeDataSet(rs, "ds_ListUpj");

		/**종료**/
		out_dl.add(ds_List);
		if (! sOp.equals("1"))
			out_dl.add(ds_ListUpj);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
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
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>
