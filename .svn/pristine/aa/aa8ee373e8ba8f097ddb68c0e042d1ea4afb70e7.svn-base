
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30120E_T002.jsp
    ■ 프로그램명   : 사업계획 개선과제 _최종 생성
    ■ 작성일자     : 2015-06-23
    ■ 작성자       : 김태윤
    ■ 이력관리     :
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_Cond = in_dl.get("ds_Cond");
        DataSet ds_List = in_dl.get("ds_List");// 변경된 데이타

        //입력 파라메터
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));

        //FileLog.println("d:\\b.txt", ds_List);
        //FileLog.println("d:\\a.txt", ds_List_ALL);

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 등록된 '_최종' PL이 있으면 MAP_BIZ_PLAN 삭제후 재 생성한다.
        sbSql.append("SELECT COUNT(1) ISDATA  																\n");
        sbSql.append("  FROM MAP_BIZ_LOG_MGMT																\n");
        sbSql.append(" WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 					\n");
        sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 				\n");
        sbSql.append("   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "_최종" + "'	\n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        String isData = rs.getString("ISDATA");
        rs.close();
        pstmt.close();

        if ("0".equals(isData)) {
            // 사업계획 이력관리(수정계획) 저장.
            sbSql.delete(0, sbSql.length());
            sbSql.append("INSERT INTO MAP_BIZ_LOG_MGMT 															\n");
            sbSql.append("		 (UPJANG, YY, BIZ_CLASS, CONFIRM_YN, IMPROV_YN, ORGIN_YN, VER_CD, CDATE, CUSER)	\n");
            sbSql.append("VALUES ('" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'			 				\n");
            sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			 			\n");
            sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "_최종" + "'			\n");
            //sbSql.append("      , 'Y', 'Y', 'N', (SELECT VER_CD FROM MAP_BPC_MODIFY_PLAN WHERE PLAN_CLASS = 'AP' AND OPEN_YN = 'Y'), SYSDATE, '" + g_EmpNo + "' ) 									\n");
			sbSql.append("      , 'Y', 'N', 'N', (SELECT VER_CD FROM MAP_BPC_MODIFY_PLAN WHERE PLAN_CLASS = 'AP' AND OPEN_YN = 'Y'), SYSDATE, '" + g_EmpNo + "' ) 									\n");
 
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();

        } else {

            // 기존에 데이터가 있으면 업데이트 후 입력.
            sbSql.delete(0, sbSql.length());
            sbSql.append("UPDATE MAP_BIZ_LOG_MGMT 																				\n");
            sbSql.append("	 SET CONFIRM_YN = '" + "Y" + "'																		\n");
            //sbSql.append("		,IMPROV_YN = '" + "Y" + "'																		\n");
            sbSql.append("		,IMPROV_YN = '" + "N" + "'																		\n");
            sbSql.append("		,BPC_SEND_YN = '" + "N" + "'																	\n");
            sbSql.append(" 	     WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  						\n");
            sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'								\n");
            sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "_최종" + "'			\n");

            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();

            // 입력 PL 삭제.
            //for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
            //{
            //if(Integer.parseInt(ds_List.getString(iRow, "CHK")) ==  1) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("DELETE MAP_BIZ_PLAN	 																				\n");
            sbSql.append(" 	     WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  						\n");
            sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'								\n");
            sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "_최종" + "'			\n");
            //sbSql.append("   	   AND ACCT_CD = '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "'						\n");

            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
            //}//END IF

            //}//END FOR
        }

        // 원본 => 원본_최종으로 생성.
        sbSql.delete(0, sbSql.length());
        sbSql.append("INSERT INTO MAP_BIZ_PLAN 																		\n");
        sbSql.append("			 (																					\n");
        sbSql.append("		SELECT																					\n");
        sbSql.append("               UPJANG, YY,  VER_CD, TM_CD, CC_CD, ACCT_CD, ACCT_NM, JOB_GRADE_CD , JOB_GRADE_NM , ACCT_CLASS	\n");
        sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "_최종" + "' AS BIZ_CLASS \n");
        sbSql.append("             , MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06				\n");
        sbSql.append("             , MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12				\n");
        sbSql.append("             , SYSDATE AS CDATE 																\n");
        sbSql.append("             , '" + g_EmpNo + "' AS CUSER 													\n");
        sbSql.append("             , SYSDATE AS UDATE 																\n");
        sbSql.append("             , '" + g_EmpNo + "' AS UUSER 													\n");
        sbSql.append("  	  FROM MAP_BIZ_PLAN   																	\n");
        sbSql.append(" 	     WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'					\n");
        sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'						\n");
        sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'				\n");
        sbSql.append("			 )																					\n");

        //out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();

        // 개선과제에 해당하는 계정만 업데이트.
        //if("0".equals(isData)){
        //입력
        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            if (Integer.parseInt(ds_List.getString(iRow, "CHK")) == 1) {
                sbSql.delete(0, sbSql.length());
                sbSql.append("      UPDATE MAP_BIZ_PLAN                           														\n");
                sbSql.append("         SET MM_AMT_01 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_01")) * 1000 + " + MM_AMT_01	\n");
                sbSql.append("           , MM_AMT_02 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_02")) * 1000 + " + MM_AMT_02 	\n");
                sbSql.append("           , MM_AMT_03 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_03")) * 1000 + " + MM_AMT_03 	\n");
                sbSql.append("           , MM_AMT_04 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_04")) * 1000 + " + MM_AMT_04 	\n");
                sbSql.append("           , MM_AMT_05 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_05")) * 1000 + " + MM_AMT_05 	\n");
                sbSql.append("           , MM_AMT_06 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_06")) * 1000 + " + MM_AMT_06 	\n");
                sbSql.append("           , MM_AMT_07 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_07")) * 1000 + " + MM_AMT_07 	\n");
                sbSql.append("           , MM_AMT_08 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_08")) * 1000 + " + MM_AMT_08 	\n");
                sbSql.append("           , MM_AMT_09 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_09")) * 1000 + " + MM_AMT_09 	\n");
                sbSql.append("           , MM_AMT_10 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_10")) * 1000 + " + MM_AMT_10 	\n");
                sbSql.append("           , MM_AMT_11 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_11")) * 1000 + " + MM_AMT_11 	\n");
                sbSql.append("           , MM_AMT_12 = " + stringToFloat(ds_List.getString(iRow, "MM_AMT_12")) * 1000 + " + MM_AMT_12 	\n");
                sbSql.append("           , UDATE      = SYSDATE 																		\n");
                sbSql.append("           , UUSER      = '" + g_EmpNo + "' 																\n");
                sbSql.append(" 	     WHERE UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  							\n");
                sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'									\n");
                sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "_최종" + "'							\n");
                sbSql.append("   	   AND ACCT_CD = '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "'							\n");
                /*
                sbSql.append("INSERT INTO MAP_BIZ_PLAN 																				\n");
                sbSql.append("			 (																							\n");
                sbSql.append("		SELECT																							\n");
                sbSql.append("               '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' AS UPJANG						\n");
                sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'  AS YY							\n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' AS ACCT_CD					\n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "' AS ACCT_NM					\n");
                sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")) + "' AS ACCT_CLASS				\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_01")) * 1000 + "' + A.MM_AMT_01 AS MM_AMT_01 		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_02")) * 1000 + "' + A.MM_AMT_02 AS MM_AMT_02		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_03")) * 1000 + "' + A.MM_AMT_03 AS MM_AMT_03		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_04")) * 1000 + "' + A.MM_AMT_04 AS MM_AMT_04		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_05")) * 1000 + "' + A.MM_AMT_05 AS MM_AMT_05		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_06")) * 1000 + "' + A.MM_AMT_06 AS MM_AMT_06		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_07")) * 1000 + "' + A.MM_AMT_07 AS MM_AMT_07		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_08")) * 1000 + "' + A.MM_AMT_08 AS MM_AMT_08		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_09")) * 1000 + "' + A.MM_AMT_09 AS MM_AMT_09		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_10")) * 1000 + "' + A.MM_AMT_10 AS MM_AMT_10		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_11")) * 1000 + "' + A.MM_AMT_11 AS MM_AMT_11		\n");
                sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, "MM_AMT_12")) * 1000 + "' + A.MM_AMT_12 AS MM_AMT_12		\n");
                sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS"))+ "_최종" + "' AS BIZ_CLASS 		\n");
                sbSql.append("             , '" + " " + "' AS REMARK																\n");
                sbSql.append("             , '" + g_EmpNo + "' AS CDATE 															\n");
                sbSql.append("             , SYSDATE AS CUSER 																		\n");
                sbSql.append("             , '" + g_EmpNo + "' AS UDATE 															\n");
                sbSql.append("             , SYSDATE AS UUSER 																		\n");
                sbSql.append("  	  FROM MAP_BIZ_PLAN A  																			\n");
                sbSql.append(" 	     WHERE A.UPJANG ='" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'	  						\n");
                sbSql.append(" 		   AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'							\n");
                sbSql.append("   	   AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'					\n");
                sbSql.append("   	   AND A.ACCT_CD = '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "'					\n");
                sbSql.append("			 )				 																			\n");
                */
                //out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
            } //END IF
        } // END FOR
        //}

        // 선택된 개선과제 정보를 저장한다.
        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      UPDATE MAP_IMPROV_PL_DTL	                           							\n");
            sbSql.append("         SET CHECK_YN= '" + nullToBlank(ds_List.getString(iRow, "CHK")) + "' 			\n");
            sbSql.append("           , UDATE      = SYSDATE 													\n");
            sbSql.append("           , UUSER      = '" + g_EmpNo + "' 											\n");
            sbSql.append("       WHERE UPJANG     = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "'	\n");
            sbSql.append("         AND IMPROV_YEAR  = '" + ds_List.getString(iRow, "YY") + "'	 				\n");
            sbSql.append("         AND ACCT_CD  = '" + ds_List.getString(iRow, "ACCT_CD") + "'	 				\n");
            sbSql.append("         AND IMPROV_MGRP  = '" + ds_List.getString(iRow, "IMPROV_MGRP") + "'			\n");
            sbSql.append("         AND IMPROV_MCALSS  = '" + ds_List.getString(iRow, "IMPROV_MCALSS") + "'		\n");
            sbSql.append("         AND IMPROV_SCLASS  = '" + ds_List.getString(iRow, "IMPROV_SCLASS") + "'	 	\n");
            sbSql.append("         AND IMPROV_THEME_SEQ  = '" + ds_List.getString(iRow, "IMPROV_THEME_SEQ") + "'\n");
            sbSql.append("         AND REV_SEQ  = '" + ds_List.getString(iRow, "REV_SEQ") + "'	 				\n");

            //out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } //END FOR

        /**종료**/
        conn.commit();
        this.setResultMessage(0, "OK", out_vl);
    } catch (Exception ex) {
        conn.rollback();
        //ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
        this.setResultMessage(-1, ex.toString(), out_vl);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (Exception e) {
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
            }
        }
        //jsp log 서비스 닫기
        try {
            logger.endIndividualLog();
        } catch (Exception logE) {
            logE.printStackTrace();
        }
    }

    proc_output(response, out, out_vl, out_dl);
%>