<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/영업현황관리
■ 프로그램ID   : MAG00030V_T001.jsp
■ 프로그램명   : 업장별 Z율 실적조회
■ 작성일자     : 2013-03-04 
■ 작성자       : 박은규
■ 이력관리     : 
	1) 박은규 2013-03-05 CSR#(CH201303_00014) 요청자:이종승(Fc기획팀)
	최초개발
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
		//FileLog.println("d:\\aaa.txt", ds_cond
		
		String strYear      = nullToBlank(ds_Cond.getString(0, "YYYY"));
		String strTmCd      = nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String strUpjang    = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String strUpjClss   = nullToBlank(ds_Cond.getString(0, "UPJANG_CLASS"));
		String strUpjangDtl = nullToBlank(ds_Cond.getString(0, "UPJANG_DTL"));
		String strType      = nullToBlank(in_vl.getString("strType"));
		String strExcept    = nullToBlank(in_vl.getString("strExcept"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//업장목록
		if (strType.equals("UpjLst"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.* FROM \n");
			sbSql.append("( \n");
			sbSql.append("SELECT 000000 AS UPJANG, '전체' AS UPJANGNM FROM DUAL \n");
			sbSql.append(" --------- \n");
			sbSql.append(" UNION ALL \n");
			sbSql.append(" --------- \n");
			sbSql.append("SELECT --+ INDEX_ASC(A SYS_C0024828) \n");
			sbSql.append("       A.UPJANG \n");
			sbSql.append("     , DECODE(A.ACC_CLOSEDATE,NULL,NULL,'(폐)')||A.UPJANGNM \n");
			sbSql.append("  FROM HLDC_ST_UPJANG A, HLDC_SC_DEPT B \n");
			sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
			sbSql.append("   AND B.MU_CD = 'YA' --FC업장만 대상 \n");
			sbSql.append("   AND NVL(A.CUSTCD,0) = 0 --식재영업 제외 내부업장만 대상 \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND B.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			if (! strUpjClss.equals(""))
				sbSql.append("   AND A.CLASS_CD = '" + strUpjClss + "' \n");
			if (strExcept.equals("Y"))
				sbSql.append("   AND SUBSTR(NVL(A.ACC_CLOSEDATE,'99999999'),1,4) >= '" + strYear + "' \n");
			sbSql.append(") A \n");
			sbSql.append(" ORDER BY A.UPJANG \n");
		}
		//내역조회
		else
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT A.DATA_CLASS -- A:실적, P:계획 \n");
			sbSql.append("     , A.CLOSE_TYPE -- 0:매출 C05C:재무확정, C05D:관리확정 \n");
			sbSql.append("     , A.MGMT_ACCT_CD -- PLA10000:식음료(매출액), PLB11000:식음료(재료비) \n");
			sbSql.append("     , ROUND(SUM(A.AMT1)/1000) AS \"_0\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '01', A.AMT1, 0))/1000) AS \"_1\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '02', A.AMT1, 0))/1000) AS \"_2\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '03', A.AMT1, 0))/1000) AS \"_3\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '04', A.AMT1, 0))/1000) AS \"_4\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '05', A.AMT1, 0))/1000) AS \"_5\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '06', A.AMT1, 0))/1000) AS \"_6\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '07', A.AMT1, 0))/1000) AS \"_7\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '08', A.AMT1, 0))/1000) AS \"_8\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '09', A.AMT1, 0))/1000) AS \"_9\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '10', A.AMT1, 0))/1000) AS \"_10\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '11', A.AMT1, 0))/1000) AS \"_11\" \n");
			sbSql.append("     , ROUND(SUM(DECODE(A.MM, '12', A.AMT1, 0))/1000) AS \"_12\" \n");
			sbSql.append("  FROM MAM_MST A, HLDC_ST_UPJANG B \n");
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.YY = '" + strYear + "' \n");
			if (! strTmCd.equals(""))
				sbSql.append("   AND A.TM_CD = '" + strTmCd + "' \n");
			if (! strUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + strUpjang + " \n");
			if (! strUpjangDtl.equals("0"))
				sbSql.append("   AND A.UPJANG = " + strUpjangDtl + " \n");
			if (! strUpjClss.equals(""))
				sbSql.append("   AND B.CLASS_CD = '" + strUpjClss + "' \n");
			if (strExcept.equals("Y"))
				sbSql.append("   AND SUBSTR(NVL(B.ACC_CLOSEDATE,'99999999'),1,4) >= '" + strYear + "' \n");
			sbSql.append("   AND A.DATA_CLASS IN ('P','A') --자료구분(A:실적, P:계획, F:전망, E:추정) \n");
			sbSql.append("   AND A.CLOSE_TYPE IN ('0','C05C','C05D') -- 0:매출 C05C:재무확정, C05D:관리확정 \n");
			sbSql.append("   AND A.MGMT_ACCT_CD IN ('PLA10000','PLB11000') -- PLA10000:식음료(매출액), PLB11000:식음료(재료비) \n");
			sbSql.append(" GROUP BY A.DATA_CLASS, A.CLOSE_TYPE, A.MGMT_ACCT_CD \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();

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