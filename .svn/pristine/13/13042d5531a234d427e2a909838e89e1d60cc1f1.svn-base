<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/발주관리
■ 프로그램ID   : FMP00170V_T001.jsp
■ 프로그램명   : 사업장 발주여부 조회
■ 작성일자     : 2008-03-06
■ 작성자       : 박은규
■ 이력관리     : 2008-03-06 - 최초작성
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
		
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		String sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String sUpjang     = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sType       = nullToBlank(ds_cond.getString(0, "TYPE"));
		//내역조회
		sbSql.append("SELECT TO_CHAR(C.UPJANG)||' '||C.UPJANGNM_DISP AS MAIN_UPJANGNM_DISP \n");
		sbSql.append("     , TO_CHAR(B.UPJANG)||' '||B.UPJANGNM_DISP AS UPJANGNM_DISP\n");
		sbSql.append("     , A.SUBINV_CODE||' '||A.SUBINV_NAME_DISP  AS SUBINV_NAME_DISP\n");
		sbSql.append("     , DECODE(E.CNT,NULL,'N',0,'N','Y') AS SIGNAL \n");
		sbSql.append("     , NVL(E.CNT,0) AS CNT \n");
		sbSql.append("     , SC_CRYPTO_FUN('DEC', B.PART_TEL_NO_ENC, '4') AS PART_TEL_NO \n");
		sbSql.append("     , SC_CRYPTO_FUN('DEC', B.PART_HP_NO_ENC, '4') AS PART_HP_NO \n");
		sbSql.append("     , D.NM_KOR, B.PART_NAME \n");
		sbSql.append("  FROM FMS_SUBINVENTORY A, FMS_UPJANG B, FMS_UPJANG C, SCC_USERINFO D \n");
		sbSql.append("     ,(SELECT A.SUBINV_CODE, COUNT(*) AS CNT \n");
		sbSql.append("         FROM SO_PR A \n");
		sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' \n");
		sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		if (! sUpjang.equals(""))
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		else if (! sMainUpjang.equals(""))
			sbSql.append("          AND A.RC_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ") \n");
		sbSql.append("          AND A.LINE_STATUS NOT IN ('003','999') \n");
		sbSql.append("        GROUP BY A.SUBINV_CODE) E \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND B.MAIN_UPJANG = C.UPJANG \n");
		sbSql.append("   AND B.CS_SABUN = D.SABUN(+) \n");
		sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		if (! sType.equals(""))
			sbSql.append("   AND NVL(A.CONSUM_YN,'0') IN (" + nullToBlank(ds_cond.getString(0, "TYPE")) + ") \n");
		sbSql.append("   AND B.CS_SABUN = NVL('" + nullToBlank(ds_cond.getString(0, "CS")) + "',B.CS_SABUN) \n");
		if (! sUpjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		else if (! sMainUpjang.equals(""))
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("   AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY B.MAIN_UPJANG, B.UPJANG, A.SUBINV_CODE \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**종료**/
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

<%--
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
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		String sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String sUpjang     = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sType       = nullToBlank(ds_cond.getString(0, "TYPE"));
		//내역조회
		sbSql.append("SELECT TO_CHAR(C.UPJANG)||' '||C.UPJANGNM_DISP AS MAIN_UPJANGNM_DISP \n");
		sbSql.append("     , TO_CHAR(B.UPJANG)||' '||B.UPJANGNM_DISP AS UPJANGNM_DISP\n");
		sbSql.append("     , A.SUBINV_CODE||' '||A.SUBINV_NAME_DISP  AS SUBINV_NAME_DISP\n");
		sbSql.append("     , DECODE(E.CNT,NULL,'N',0,'N','Y') AS SIGNAL \n");
		sbSql.append("     , NVL(E.CNT,0) AS CNT \n");
		sbSql.append("     , SC_CRYPTO_FUN('DEC', B.PART_TEL_NO_ENC, '4') AS PART_TEL_NO \n");
		sbSql.append("     , SC_CRYPTO_FUN('DEC', B.PART_HP_NO_ENC, '4') AS PART_HP_NO \n");
		sbSql.append("     , D.NM_KOR, B.PART_NAME \n");
		sbSql.append("  FROM FMS_SUBINVENTORY A, FMS_UPJANG B, FMS_UPJANG C, SCC_USERINFO D \n");
		sbSql.append("     ,(SELECT A.SUBINV_CODE, COUNT(*) AS CNT \n");
		sbSql.append("         FROM HLDC_PO_PR A \n");
		sbSql.append("        WHERE A.NEED_DATE = '" + nullToBlank(ds_cond.getString(0, "JDATE")) + "' \n");
		sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		if (! sUpjang.equals(""))
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		else if (! sMainUpjang.equals(""))
			sbSql.append("          AND A.RC_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ") \n");
		sbSql.append("          AND A.LINE_STATUS <> '003' \n");
		sbSql.append("        GROUP BY A.SUBINV_CODE) E \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND B.MAIN_UPJANG = C.UPJANG \n");
		sbSql.append("   AND B.CS_SABUN = D.SABUN(+) \n");
		sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE(+) \n");
		if (! sType.equals(""))
			sbSql.append("   AND NVL(A.CONSUM_YN,'0') IN (" + nullToBlank(ds_cond.getString(0, "TYPE")) + ") \n");
		sbSql.append("   AND B.CS_SABUN = NVL('" + nullToBlank(ds_cond.getString(0, "CS")) + "',B.CS_SABUN) \n");
		if (! sUpjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		else if (! sMainUpjang.equals(""))
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("   AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' AND C.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY B.MAIN_UPJANG, B.UPJANG, A.SUBINV_CODE \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_List);

		/**종료**/
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

--%>
