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
		DataSet ds_CcCd     = in_dl.get("ds_CcCd");
		DataSet ds_List     = in_dl.get("ds_List");// 변경된 데이타
		
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//마케터명_최종으로 데이터 생성.
		// 사업계획 이력관리(수정계획) 저장.
		sbSql.delete(0, sbSql.length());
		sbSql.append("INSERT INTO MAP_BIZ_LOG_MGMT2 																	\n");
		sbSql.append("		 (UPJANG, YY, BIZ_CLASS, CONFIRM_YN, IMPROV_YN, ORGIN_YN, BPC_SEND_YN, VER_CD, TM_CD, SABUN, CDATE, CUSER)	\n");
		sbSql.append("VALUES ('" + nullToBlank(ds_List.getString(0, "CC_CD")) + "'			 						\n");
		sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			 					\n");
		sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "_최종" + "'					\n");
		sbSql.append("      , 'Y', 'Y', 'N', 'Y' 																	\n");
		sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "VER_CD")) + "'									\n");
		sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'									\n");
		sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'									\n");
		sbSql.append("      , SYSDATE, '" + g_EmpNo + "' ) 															\n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		
		// 기존 사업계획 이력관리(수정계획) 수정.
		sbSql.delete(0, sbSql.length());
		sbSql.append("      UPDATE MAP_BIZ_LOG_MGMT2		                           								\n");
		sbSql.append("         SET CONFIRM_YN = '" + "Y" + "', IMPROV_YN = 'Y', BPC_SEND_YN = 'Y'				\n");
		sbSql.append("           , UDATE     = SYSDATE 															\n");
		sbSql.append("           , UUSER     = '" + g_EmpNo + "' 												\n");
		sbSql.append("       WHERE TM_CD     = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'				\n");
		sbSql.append("         AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'					\n");
		sbSql.append("         AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'					\n");
		sbSql.append("         AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'			\n");
		
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		
		// 기존값을 삭제한다.
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ ){
			sbSql.delete(0, sbSql.length());
			sbSql.append("      DELETE MAP_BIZ_PLAN2		                        							\n");
			sbSql.append("       WHERE UPJANG = '" + nullToBlank(ds_CcCd.getString(iRow, "UPJANG")) + "' 		\n");
			sbSql.append("         AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'				\n");
			sbSql.append("         AND VER_CD  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'		\n");
			sbSql.append("         AND SABUN =  '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' 			\n");
			
			out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}// END FOR	
			
		// 원본 + 개선과제 적용 => 원본_최종으로 생성.
		///*
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO MAP_BIZ_PLAN2 A 															\n");
			sbSql.append("      	   ( A.UPJANG 																\n");
			sbSql.append("             , A.TM_CD																\n");
			sbSql.append("             , A.SABUN																\n");
			sbSql.append("             , A.CC_CD																\n");
			sbSql.append("             , A.YY 																	\n");
			sbSql.append("             , A.VER_CD																\n");
			sbSql.append("             , A.ACCT_CD 																\n");
			sbSql.append("             , A.ACCT_NM 																\n");
			sbSql.append("             , A.JOB_GRADE_CD															\n");
			sbSql.append("             , A.JOB_GRADE_NM															\n");
			sbSql.append("             , A.ACCT_CLASS 															\n");
			sbSql.append("             , A.BIZ_CLASS 															\n");
			sbSql.append("             , A.MM_AMT_01 															\n");
			sbSql.append("             , A.MM_AMT_02 															\n");
			sbSql.append("             , A.MM_AMT_03 															\n");
			sbSql.append("             , A.MM_AMT_04 															\n");
			sbSql.append("             , A.MM_AMT_05 															\n");
			sbSql.append("             , A.MM_AMT_06 															\n");
			sbSql.append("             , A.MM_AMT_07 															\n");
			sbSql.append("             , A.MM_AMT_08 															\n");
			sbSql.append("             , A.MM_AMT_09 															\n");
			sbSql.append("             , A.MM_AMT_10 															\n");
			sbSql.append("             , A.MM_AMT_11 															\n");
			sbSql.append("             , A.MM_AMT_12 															\n");
			sbSql.append("             , A.CUSER 																\n");
			sbSql.append("             , A.CDATE 																\n");
			sbSql.append("             , A.UUSER 																\n");
			sbSql.append("             , A.UDATE ) 																\n");
			sbSql.append("      VALUES ( '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' 				\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' 					\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' 					\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 				\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
			sbSql.append("      	   , '" + nullToBlank(ds_Cond.getString(0, "VER_CD")) + "'					\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' 				\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "' 				\n");
			sbSql.append("             , DECODE('" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "', '', 'N_RANK') 		\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_NM")) + "' 		\n");
			sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")) + "' 			\n");
			sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS"))+ "_최종" + "' 	 	\n");
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

			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}//END FOR		
		//*/
		
		// 개선과제 적용대상을 상태값을 'S'로 변경하여 다시 적용하지 못하게 한다.
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("      UPDATE MAP_IMPROV_MGT_MST                           									\n");
			sbSql.append("         SET APPROV_YN = '" + "Y" + "' 														\n");
			sbSql.append("           , UDATE     = SYSDATE 																\n");
			sbSql.append("           , UUSER     = '" + g_EmpNo + "' 													\n");
			sbSql.append("       WHERE UPJANG     = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "'			\n");
			sbSql.append("         AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' BETWEEN APPLY_ST_DT AND APPLY_ND_DT	\n");
			//sbSql.append("         AND YY     	  = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
			//sbSql.append("         AND BIZ_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");
			
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}//END FOR
		
		// 기존에 BPC에 전송한 데이터가 있으면 삭제 후 인서트 한다.
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ ){
			sbSql.delete(0, sbSql.length());
			sbSql.append("      DELETE MAP_BPC_BIZ_PLAN_INFO                        							\n");
			sbSql.append("       WHERE PLAN_CLASS  = '" + "AP" + "'												\n");
			sbSql.append("         AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
			//sbSql.append("         AND UPJANG = '" + nullToBlank(ds_CcCd.getString(iRow, "UPJANG")) + "' 		\n");
			sbSql.append("         AND UPJANG = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' 		\n");
			sbSql.append("         AND VER_CD  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'		\n");
			
			out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}// END FOR	
		
		//사업계획(최종PL 정보)  BPC -> FC로 최종PL 정보 전송 (관리 금액을 재무금액으로 변환해서 전송)
		///*
		List<AcctPlanReqDTO> lst = new ArrayList<AcctPlanReqDTO>();
		
		for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
		{
			sbSql.delete(0, sbSql.length());
			// 매출이익 계정은 제외.
			if(!"44000000".equals(ds_List.getString(iRow, "ACCT_CD"))){
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
				sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "VER_CD")) + "' 					\n");
				sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 				\n");
				sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' 				\n");
				sbSql.append("             , DECODE('" + nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")) + "', '', 'N_RANK') \n");
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
				///*
				AcctPlanReqDTO acctPlanReqDTO01 = new AcctPlanReqDTO();
				acctPlanReqDTO01.setPlanType("AP");
				acctPlanReqDTO01.setPlanYear(nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
				acctPlanReqDTO01.setVerCd(nullToBlank(ds_Cond.getString(0, "VER_CD")));
				acctPlanReqDTO01.setCcCd(nullToBlank(ds_List.getString(iRow, "CC_CD")));
				//acctPlanReqDTO01.setUpjang(Integer.parseInt(ds_List.getString(iRow, "UPJANG")));
				acctPlanReqDTO01.setUpjang(BigDecimal.valueOf( Long.valueOf(ds_List.getString(iRow, "UPJANG"))));
				acctPlanReqDTO01.setJobGradeCd("".equals(nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")))?"N_RANK":nullToBlank(ds_List.getString(iRow, "JOB_GRADE_CD")));
				acctPlanReqDTO01.setJobGradeNm(nullToBlank(ds_List.getString(iRow, "JOB_GRADE_NM")));
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
			}
			
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