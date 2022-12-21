<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30210E_T004.jsp
■ 프로그램명   : 마케터 사업계획관리 최종확정 + 개선과제 적용
■ 작성일자     : 2015-08-07
■ 작성자       : 김태윤
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page import = "java.math.BigDecimal"%>
<%@ page import = "com.hwfs.sc.cmn.sap.dto.AcctPlanReqDTO" %>
<%@ page import = "com.hwfs.sc.cmn.sap.service.EAIService" %>
<%@ page import = "com.hwfs.sc.cmn.sap.list.AcctPlanReqList" %>
<%@ page import = "com.hwfs.sc.cmn.util.*" %>
<%@ page import = "com.hwfs.sc.cmn.sap.EAIResponse" %>

<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		DataSet ds_List     = in_dl.get("ds_List");// 변경된 데이타
		
		//입력 파라메터
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		// 기존에 BPC에 전송한 데이터가 있으면 삭제 후 인서트 한다.
		for ( int iRow = 0 ; iRow < 1 ; iRow++ ){
			sbSql.delete(0, sbSql.length());
			sbSql.append("      DELETE MAP_BPC_BIZ_PLAN_INFO                        							\n");
			sbSql.append("       WHERE PLAN_CLASS  = '" + "AP" + "'												\n");
			sbSql.append("         AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
			sbSql.append("         AND VER_CD  = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'			\n");
			
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}// END FOR
		
		// 팀별 사업계획(최종PL 정보)  FC -> BPC로 최종PL 정보 전송
		List<AcctPlanReqDTO> lst = new ArrayList<AcctPlanReqDTO>();
		
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
		{	
			sbSql.delete(0, sbSql.length());
			///*
			sbSql.append("      INSERT INTO MAP_BPC_BIZ_PLAN_INFO		\n");
			sbSql.append("      	   ( PLAN_CLASS 					\n");
			sbSql.append("             , PLAN_YEAR 						\n");
			sbSql.append("             , VER_CD 						\n");
			sbSql.append("             , CC_CD 							\n");
			sbSql.append("             , UPJANG							\n");
			sbSql.append("             , JOB_GRADE_CD 					\n");
			sbSql.append("             , JOB_GRADE_NM 					\n");
			sbSql.append("             , ACCT_CD 						\n");
			sbSql.append("             , ACCT_NM 						\n");
			sbSql.append("             , MM_AMT_01 						\n");
			sbSql.append("             , MM_AMT_02 						\n");
			sbSql.append("             , MM_AMT_03 						\n");
			sbSql.append("             , MM_AMT_04 						\n");
			sbSql.append("             , MM_AMT_05 						\n");
			sbSql.append("             , MM_AMT_06 						\n");
			sbSql.append("             , MM_AMT_07 						\n");
			sbSql.append("             , MM_AMT_08 						\n");
			sbSql.append("             , MM_AMT_09 						\n");
			sbSql.append("             , MM_AMT_10 						\n");
			sbSql.append("             , MM_AMT_11 						\n");
			sbSql.append("             , MM_AMT_12 						\n");
			sbSql.append("             , CUSER 							\n");
			sbSql.append("             , CDATE 							\n");
			sbSql.append("             , UUSER 							\n");
			sbSql.append("             , UDATE ) 						\n");
			sbSql.append("      VALUES ( '" + "AP" + "' 														\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' 					\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "' 					\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 					\n");
			sbSql.append("             , '" + "N_RANK" + "' 													\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_NM")) + "' 		\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' 				\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "' 				\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_01")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_01"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_02")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_02"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_03")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_03"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_04")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_04"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_05")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_05"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_06")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_06"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_07")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_07"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_08")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_08"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_09")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_09"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_10")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_10"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_11")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_11"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + (stringToFloat(ds_List.getString(iRow, "MM_AMT_12")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_12"))) * 1000 + "' 	\n");
			sbSql.append("             , '" + g_EmpNo + "' 														\n");
			sbSql.append("             , SYSDATE 																\n");
			sbSql.append("             , '" + g_EmpNo + "' 														\n");
			sbSql.append("             , SYSDATE 																\n");
			sbSql.append("             ) 																		\n");
			//*/
			AcctPlanReqDTO acctPlanReqDTO01 = new AcctPlanReqDTO();
			acctPlanReqDTO01.setPlanType("AP");
			acctPlanReqDTO01.setPlanYear(nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
			acctPlanReqDTO01.setVerCd(nullToBlank(ds_Cond.getString(0, "TM_CD")));
			acctPlanReqDTO01.setCcCd(nullToBlank(ds_Cond.getString(0, "CC_CD")));
			//acctPlanReqDTO01.setUpjang(Integer.parseInt(ds_Cond.getString(0, "UPJANG")));
			acctPlanReqDTO01.setUpjang(BigDecimal.valueOf( Long.valueOf(ds_Cond.getString(0, "UPJANG"))));
			acctPlanReqDTO01.setJobGradeCd("N_RANK");
			acctPlanReqDTO01.setJobGradeNm("");
			acctPlanReqDTO01.setAcctCd(nullToBlank(ds_List.getString(iRow, "ACCT_CD")));
			acctPlanReqDTO01.setAcctNm(nullToBlank(ds_List.getString(iRow, "ACCT_NM")));
			acctPlanReqDTO01.setMmAmt01(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_01")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_01"))) * 1000));
			acctPlanReqDTO01.setMmAmt02(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_02")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_02"))) * 1000));
			acctPlanReqDTO01.setMmAmt03(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_03")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_03"))) * 1000));
			acctPlanReqDTO01.setMmAmt04(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_04")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_04"))) * 1000));
			acctPlanReqDTO01.setMmAmt05(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_05")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_05"))) * 1000));
			acctPlanReqDTO01.setMmAmt06(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_06")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_06"))) * 1000));
			acctPlanReqDTO01.setMmAmt07(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_07")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_07"))) * 1000));
			acctPlanReqDTO01.setMmAmt08(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_08")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_08"))) * 1000));
			acctPlanReqDTO01.setMmAmt09(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_09")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_09"))) * 1000));
			acctPlanReqDTO01.setMmAmt10(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_10")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_10"))) * 1000));
			acctPlanReqDTO01.setMmAmt11(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_11")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_11"))) * 1000));
			acctPlanReqDTO01.setMmAmt12(BigDecimal.valueOf( (stringToFloat(ds_List.getString(iRow, "MM_AMT_12")) + stringToFloat(ds_List.getString(iRow, "MM_IMPROV_AMT_12"))) * 1000));

			lst.add(acctPlanReqDTO01);
			//*/
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}// END FOR
		
		// EAI 호출.
		///*
		EAIService eaiService = (EAIService)BeanUtil.getBean("EAIService");
		AcctPlanReqList acctPlanReqList = new AcctPlanReqList();
		acctPlanReqList.setDataList(lst);
		
		EAIResponse res = eaiService.call(acctPlanReqList);
		
		if (res.isSuccess()) {
			//TODO :: 성공에 대하여 적절히 코딩하세요.
			//list = res.getListMap();
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
		}	
		//*/
		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		conn.rollback();
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