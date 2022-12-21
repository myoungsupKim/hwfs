<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/매출통계
■ 프로그램ID   : MAO00020E_T001.jsp
■ 프로그램명   : 매출계획 등록관리(조회)
■ 작성일자     : 2012-03-09
■ 작성자       : 박은규
■ 이력관리     : 2012-03-09 박은규 - 최초개발 (CH201203_00081)
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
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.PK_ID \n");
		sbSql.append("     , SUBSTR(A.YYYYMMDD,0,4) AS YYYY \n");
		sbSql.append("     , SUBSTR(A.YYYYMMDD,5,2) AS MM \n");
		sbSql.append("     , SUBSTR(A.YYYYMMDD,7,2) AS DD \n");
		sbSql.append("     , A.TEAM_CODE \n");
		sbSql.append("     , B.TM_NM AS TEAM_NAME \n");
		sbSql.append("     , A.PART_CODE \n");
		sbSql.append("     , C.CODE_NAME AS PART_NAME \n");
		sbSql.append("     , A.SABUN \n");
		sbSql.append("     , (SELECT Z.NM_KOR||' ('||Z.MU_NM||' '||Z.CC_NM||')' FROM SCO_FS_HR_PERSONAL_V Z WHERE Z.SABUN = A.SABUN) AS NM_KOR \n");
		sbSql.append("     , TO_CHAR(A.UPJANG) AS UPJANG \n");
		sbSql.append("     , TO_CHAR(A.MAIN_UPJANG) AS MAIN_UPJANG \n");
		sbSql.append("     , DECODE(C.SET2, '02' \n");
		sbSql.append("     		, (SELECT Z.CUSTNM FROM HLDC_ST_CUST Z WHERE Z.CUSTCD = A.UPJANG) \n");
		sbSql.append("     		, (SELECT Z.UPJANGNM_DISP FROM FMS_UPJANG Z WHERE Z.UPJANG = A.UPJANG)) AS UPJANG_NM \n");
		sbSql.append("     , (SELECT FU.UPJANGNM_DISP FROM FMS_UPJANG U , FMS_UPJANG FU WHERE U.UPJANG = FU.UPJANG AND U.UPJANG = A.MAIN_UPJANG) AS MAIN_UPJANG_NM \n");
		sbSql.append("     , A.SALE_AMOUNT \n");
		sbSql.append("     , A.MARGIN_AMOUNT \n");
		//sbSql.append("     , A.MARGIN_RATE \n");
		sbSql.append("     , A.CONTENTS \n");
		sbSql.append("  FROM FMB_SALE_PLAN A \n");
		sbSql.append("     , (SELECT DISTINCT TM_CD, TM_NM FROM HLDC_SC_TM WHERE MU_CD = '2004' \n");
		sbSql.append("           AND USE_YN = 'Y') B \n");
		sbSql.append("     , (SELECT CODE, CODE_NAME, SORT_SEQ, SET2 FROM SCC_COMMON_CODE \n");
		sbSql.append("         WHERE GROUP_CODE = 'FM0022' \n");
		sbSql.append("           AND USE_YN = 'Y') C \n");
		sbSql.append(" WHERE A.TEAM_CODE = B.TM_CD \n");
		sbSql.append("   AND A.PART_CODE = C.CODE \n");
		sbSql.append("   AND A.YYYYMMDD LIKE '" + nullToBlank(ds_Cond.getString(0, "YYYY")) +nullToBlank(ds_Cond.getString(0, "MM")) + "%' \n");
		if (! nullToBlank(ds_Cond.getString(0, "teamCode")).equals(""))
			sbSql.append("   AND A.TEAM_CODE = '" + nullToBlank(ds_Cond.getString(0, "teamCode")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "SABUN")).equals(""))
			sbSql.append("   AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "upjang")).equals(""))
			sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "upjang")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "mainUpjang")).equals(""))
			sbSql.append("   AND A.MAIN_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "mainUpjang")) + "' \n");		
//		sbSql.append(" ORDER BY A.YYYYMM, A.TEAM_CODE, A.PART_CODE, A.SABUN, A.UPJANG, A.ITEM_CODE \n");
		sbSql.append(" ORDER BY A.TEAM_CODE , A.PART_CODE , A.MAIN_UPJANG , A.UPJANG , A.YYYYMMDD \n");
		//sbSql.append(" ORDER BY A.YYYYMMDD, C.SORT_SEQ, A.SABUN, A.UPJANG, A.ITEM_CODE \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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
