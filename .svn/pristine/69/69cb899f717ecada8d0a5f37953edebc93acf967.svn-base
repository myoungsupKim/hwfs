<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/현황관리
■ 프로그램ID   : FMP00460V_T001.jsp
■ 프로그램명   : 보존식 라벨링
■ 작성일자     : 2008-03-06
■ 작성자       : 박은규
■ 이력관리     : 2008-03-06
              1. 수정 내용 : 식품위생법 개정으로 폐기일 산정시 현 +3일 →+6일(144시간)기준으로 변경   
                 요청자    : 이혜은 대리
                 수정 정보 : 변경번호 29527 , 인시던트 번호 122329 
                            수정자 : 노규완 수정일 : 2009/08/04
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
		String sTime        = nullToBlank(in_vl.getString("sTime"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		if (sTime.equals("0"))
			sTime = "''";
		else
			sTime = "B.FIRST_START_TIME";
		//보존식 라벨링 조회
		sbSql.append("SELECT 1 AS TEMP_GROUP_KEY \n");
		sbSql.append("     , A.MENU_DATE, A.MENU_CD, A.MEAL, A.CORNER \n");
		sbSql.append("     , '담당자:'||'" + nullToBlank(ds_cond.getString(0, "NAME")) + "' AS MAIN_USER \n");
		sbSql.append("     , '구  분:'||'" + nullToBlank(ds_cond.getString(0, "SUBINV_NAME")) + " '||C.CODE_NAME||D.CODE_NAME AS GUBUN \n");
		sbSql.append("     , '채  취:'||TO_CHAR(TO_DATE(A.MENU_DATE,'YYYYMMDD'),'YYYY-MM-DD')||' '||SUBSTR(NVL(" + sTime + ",'    '),1,2)||':'||SUBSTR(NVL(" + sTime + ",'    '),3,2) AS START_TIME \n");
		sbSql.append("     , FMM_RECIPENAME_FUN(A.UPJANG,A.MENU_CD,'1') AS RECIPE_INFO \n");
		// -- 변경 번호  29527 변경 내용 : FSM_MENU_DISUSE_DATE_FUN(A.MENU_DATE,3)  --> FSM_MENU_DISUSE_DATE_FUN(A.MENU_DATE,6)
		sbSql.append("     , '폐  기:'|| TO_CHAR(TO_DATE(A.MENU_DATE,'YYYYMMDD') + 6, 'YYYY-MM-DD') ||' '||SUBSTR(NVL(B.FIRST_START_TIME,'    '),1,2)||':'||SUBSTR(NVL(B.FIRST_START_TIME,'    '),3,2) AS DISUSE_TIME  \n");		                     		
		sbSql.append("  FROM FMM_MENU A, FMS_MEAL_CORNER B \n");
		sbSql.append("     ,(SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') C \n");
		sbSql.append("     ,(SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') D \n");
		sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
		sbSql.append("   AND A.MEAL = B.MEAL \n");
		sbSql.append("   AND A.CORNER = B.CORNER \n");
		sbSql.append("   AND A.MEAL   = C.CODE \n");
		sbSql.append("   AND A.CORNER = D.CODE \n");
		sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
		sbSql.append("   AND A.MEAL = NVL('" + nullToBlank(ds_cond.getString(0, "MEAL")) + "',A.MEAL) \n");
		sbSql.append("   AND A.CORNER = NVL('" + nullToBlank(ds_cond.getString(0, "CORNER")) + "',A.CORNER) \n");
		sbSql.append("   AND A.MENU_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "DATEF")) + "' AND '" + nullToBlank(ds_cond.getString(0, "DATET")) + "' \n");
		sbSql.append("   AND B.USE_YN = 'Y' \n");

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

%>
