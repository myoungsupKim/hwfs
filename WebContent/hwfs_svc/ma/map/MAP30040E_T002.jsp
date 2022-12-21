
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30040E_T002.jsp
    ■ 프로그램명   : 일추정 관리 저장
    ■ 작성일자     : 2015-06-30
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

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 일계획 등록여부 확인
        sbSql.append("SELECT COUNT(1) ISDATA  															\n");
        sbSql.append("  FROM MAP_DAY_LOG_MGMT															\n");
        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'				\n");
        sbSql.append("   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
        sbSql.append("   AND MM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2)	\n");
        sbSql.append("   AND DAY_CLASS = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'		\n");
        //sbSql.append("   AND CONFIRM_YN = '" + "N" + "'	\n");
        sbSql.append("   AND CONFIRM_YN = '" + "Y" + "'	\n");  //카운트 체크 잘못되어 변경 처리:맹수영 20151127
        
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        rs.next();

        String isData = rs.getString("ISDATA");

        // 일추정 마스터 데이터.
        if ("0".equals(isData)) {
            // 일계획 등록.
            sbSql.delete(0, sbSql.length());
            sbSql.append("INSERT INTO MAP_DAY_LOG_MGMT 													\n");
            sbSql.append("		 (UPJANG, YY, MM, DAY_CLASS, CONFIRM_YN, CDATE, CUSER)					\n");
            sbSql.append("VALUES ('" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'			 		\n");
            sbSql.append("      , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4) \n");
            sbSql.append("      , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) \n");
            sbSql.append("      , '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'				\n");
            sbSql.append("      , 'Y', SYSDATE, '" + g_EmpNo + "' )		 								\n");

            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            rs.next();

            // 기존값이 있으면 변경된 계정값을 해당월의 월추정에 반영.
        } //else{
            // 월추정 업데이트.
 //월추정 업데이트 제외 요청   요청자 :유영진 20160113   처리자 : 맹수영           
  /*      for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED) {
                //
                int j = 1;
                //for(int k = 7; k <= chkDt; k++ ){
                sbSql.delete(0, sbSql.length());

                sbSql.append("      UPDATE MAP_MON_PLAN                													\n");
                sbSql.append("         SET MM_AMT_" + ds_Cond.getString(0, "INPUT_MM") + " = '" + stringToFloat(ds_List.getString(iRow, "MM_AMT")) * 1000 + "'	\n");
                sbSql.append("           , UDATE      = SYSDATE 														\n");
                sbSql.append("           , UUSER      = '" + g_EmpNo + "' 												\n");
                sbSql.append(" 		WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 				\n");
                sbSql.append(" 	 	  AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
                sbSql.append(" 	 	  AND ACCT_CD = '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "'			\n");
                // 마직막 적용 대상을 찾는다.
                sbSql.append(" 	 	  AND BIZ_CLASS = (SELECT BIZ_CLASS 												\n");
                sbSql.append(" 	 	  					 FROM (															\n");
                sbSql.append(" 	 	  							SELECT UDATE, BIZ_CLASS FROM MAP_MON_LOG_MGMT 			\n");
                sbSql.append(" 	 	  							 WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'			\n");
                sbSql.append(" 	 	  							   AND YY = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)			\n");
                sbSql.append(" 	 	  							   AND CONFIRM_YN = 'Y'									\n");
                sbSql.append(" 	 	  							 ORDER BY UDATE DESC )									\n");
                sbSql.append(" 	 	  					 WHERE ROWNUM < 2 )												\n");
                //System.out.println("SUM=====>"+ds_List.getString(iRow, "MM_AMT"));

                out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();

                //}//END FOR
            } //END IF
        } //END FOR
*/
        //}

        // 일계획 데이터
        int chkDt = Integer.parseInt(ds_Cond.getString(0, "SAVE_DD"));
        int chkCol = Integer.parseInt(ds_Cond.getString(0, "COL_CNT"));
        //System.out.println("chkDt===========>"+chkDt); //38
        //System.out.println("chkCol===========>"+chkCol); //31
        ///*
        // 기존값이 있으면 업데이트. 없으면 인서트.
        ///*
        if ("0".equals(isData)) {
            sbSql.delete(0, sbSql.length());
            sbSql.append(" INSERT INTO MAP_DAY_PLAN (                                                           \n");
            sbSql.append("               UPJANG                                                                 \n");
            sbSql.append("             , CC_CD                                                                  \n");
            sbSql.append("             , YY                                                                     \n");
            sbSql.append("             , MM                                                                     \n");
            sbSql.append("             , DD                                                                     \n");
            sbSql.append("             , YMD                                                                    \n");
            sbSql.append("             , ACCT_CD                                                                \n");
            sbSql.append("             , ACCT_NM                                                                \n");
            sbSql.append("             , ACCT_CLASS                                                             \n");
            sbSql.append("             , DD_AMT                                                                 \n");
            sbSql.append("             , DAY_CLASS                                                              \n");
            sbSql.append("             , MM_AMT                                                                 \n");
            sbSql.append("             , CUSER                                                                  \n");
            sbSql.append("             , CDATE                                                                  \n");
            sbSql.append("             , UUSER                                                                  \n");
            sbSql.append("             , UDATE )                                                                \n");
            sbSql.append("      VALUES ( ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , SYSDATE \n");
            sbSql.append("             , ?  \n");
            sbSql.append("             , SYSDATE \n");
            sbSql.append("             )    \n");
            pstmt = conn.prepareStatement(sbSql.toString());

            //입력,수정
            for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
                //
                int j = 1;
                for (int k = 10; k <= chkDt; k++) {
                    pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "UPJANG")));
                    pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "CC_CD")));
                    pstmt.setString(3, nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(0, 4)));
                    pstmt.setString(4, nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)));
                    if (k < 19) {
                        pstmt.setString(5, '0' + String.valueOf(j));
                    } else if (k >= 19 && k <= chkDt) {
                        pstmt.setString(5, String.valueOf(j));
                    }
                    if (k < 19) {
                        pstmt.setString(6, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + j);
                    } else if (k >= 19 && k <= chkDt) {
                        pstmt.setString(6, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + j);
                    }
                    pstmt.setString(7, nullToBlank(ds_List.getString(iRow, "ACCT_CD")));
                    pstmt.setString(8, nullToBlank(ds_List.getString(iRow, "ACCT_NM")));
                    pstmt.setString(9, nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")));
                    pstmt.setFloat(10, stringToFloat(ds_List.getString(iRow, k)) * 1000);
                    pstmt.setString(11, nullToBlank(ds_Cond.getString(0, "DAY_CLASS")));                    
                    //추가
                    pstmt.setString(12, nullToBlank(ds_List.getString(iRow, "SUM_AMT")));
                    pstmt.setString(13, g_EmpNo);
                    pstmt.setString(14, g_EmpNo);
                    //
                    j++;

                    //out_vl.add("fa_Sql", sbSql.toString());
                    //System.out.println(sbSql.toString());
                    //pstmt = conn.prepareStatement(sbSql.toString());
                    //pstmt.executeUpdate();
                    //pstmt.close();

                    pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
                } //END FOR 2
            } //END FOR
            pstmt.executeBatch(); //배치처리
            pstmt.close();
        } else {
            for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
                if (ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED) {
                    int j = 1;
                    for (int k = 10; k <= chkDt; k++) {
                        sbSql.delete(0, sbSql.length());
                        sbSql.append("MERGE INTO MAP_DAY_PLAN A 															\n");
                        sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' AS UPJANG			\n");
                        if (k < 19) {
                            sbSql.append("        , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + j + "' AS YMD	\n");
                        } else if (k >= 19 && k <= chkDt) {
                            sbSql.append("        , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + j + "'  AS YMD		\n");
                        }
                        sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' AS ACCT_CD 	\n");
                        sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "' AS DAY_CLASS 	\n");
                        sbSql.append("         FROM DUAL) B                   												\n");
                        sbSql.append("   ON (A.UPJANG  		= B.UPJANG 		AND  											\n");
                        sbSql.append("       A.YMD     		= B.YMD 		AND      										\n");
                        sbSql.append("       A.ACCT_CD      = B.ACCT_CD 	AND        										\n");
                        sbSql.append("       A.DAY_CLASS    = '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "' )	\n");
                        sbSql.append(" WHEN MATCHED THEN                      												\n");
                        sbSql.append("      UPDATE                            												\n");
                        sbSql.append("         SET A.DD_AMT = " + stringToFloat(ds_List.getString(iRow, k)) * 1000 + " 		\n");
                        sbSql.append("           , A.UDATE      = SYSDATE 													\n");
                        sbSql.append("           , A.UUSER      = '" + g_EmpNo + "' 										\n");
                        sbSql.append(" WHEN NOT MATCHED THEN 																\n");
                        sbSql.append("      INSERT ( A.UPJANG 																\n");
                        sbSql.append("             , A.CC_CD																\n");
                        sbSql.append("             , A.YY 																	\n");
                        sbSql.append("             , A.MM 																	\n");
                        sbSql.append("             , A.DD 																	\n");
                        sbSql.append("             , A.YMD 																	\n");
                        sbSql.append("             , A.ACCT_CD 																\n");
                        sbSql.append("             , A.ACCT_NM 																\n");
                        sbSql.append("             , A.ACCT_CLASS 															\n");
                        sbSql.append("             , A.DD_AMT	 															\n");
                        sbSql.append("             , A.DAY_CLASS 															\n");
                        sbSql.append("             , A.CUSER 																\n");
                        sbSql.append("             , A.CDATE 																\n");
                        sbSql.append("             , A.UUSER 																\n");
                        sbSql.append("             , A.UDATE ) 																\n");
                        sbSql.append("      VALUES ( '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 					\n");
                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "CC_CD")) + "' 				\n");
                        sbSql.append("             , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 1, 4)	\n");
                        sbSql.append("             , SUBSTR('" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "', 5, 2) 	\n");

                        // 날짜가 들어가야함 마지막 날이 31 이면 1~31까지 일자가 들어가야함.
                        if (k < 19) {
                            sbSql.append("             , '" + '0' + j + "' 													\n");
                        } else if (k >= 19 && k <= chkDt) {
                            sbSql.append("             , '" + j + "' 														\n");
                        }

                        if (k < 19) {
                            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + j + "' 	\n");
                        } else if (k >= 19 && k <= chkDt) {
                            sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + j + "' 		\n");
                        }

                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CD")) + "' 				\n");
                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_NM")) + "' 				\n");
                        sbSql.append("             , '" + nullToBlank(ds_List.getString(iRow, "ACCT_CLASS")) + "' 			\n");
                        sbSql.append("             , '" + stringToFloat(ds_List.getString(iRow, k)) * 1000 + "' 			\n");
                        sbSql.append("      	   , '" + nullToBlank(ds_Cond.getString(0, "DAY_CLASS")) + "'				\n");
                        sbSql.append("             , '" + g_EmpNo + "' 														\n");
                        sbSql.append("             , SYSDATE 																\n");
                        sbSql.append("             , '" + g_EmpNo + "' 														\n");
                        sbSql.append("             , SYSDATE 																\n");
                        sbSql.append("             ) 																		\n");

                        j++;

                        out_vl.add("fa_Sql", sbSql.toString());
                        //System.out.println(sbSql.toString());
                        pstmt = conn.prepareStatement(sbSql.toString());
                        pstmt.executeUpdate();
                        pstmt.close();

                    } //END FOR
                } //END IF
            } //END FOR
        } //END ELSE

        //*/
        // 기존에 BPC에 전송한 데이터가 있으면 삭제 후 인서트 한다.
        for (int iRow = 0; iRow < 1; iRow++) {
            sbSql.delete(0, sbSql.length());
            sbSql.append("      DELETE MAP_BPC_CONFIRM_DAY_PL_INFO                     							\n");
            sbSql.append("       WHERE CC_CD     = '" + nullToBlank(ds_Cond.getString(0, "CC_CD")) + "'			\n");
            sbSql.append("         AND YYMM = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'			\n");
            sbSql.append("         AND DAY_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "DAY_GBN")) + "'		\n");

            out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();
        } // END FOR

        // 재무금액으로 변경을 위한 출하율 조회
        double marginRate01 = 100.0;
        double marginRate02 = 100.0;
        double marginRate03 = 100.0;
        double marginRate04 = 100.0;
        double marginRate05 = 100.0;
        double marginRate06 = 100.0;
        double marginRate07 = 100.0;
        double marginRate08 = 100.0;
        double marginRate09 = 100.0;
        double marginRate10 = 100.0;
        double marginRate11 = 100.0;
        double marginRate12 = 100.0;

        sbSql.delete(0, sbSql.length());
        sbSql.append(" SELECT NVL(A.MM_MARGIN_RATE_01, 100) AS MM_MARGIN_RATE_01 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_02, 100) AS MM_MARGIN_RATE_02 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_03, 100) AS MM_MARGIN_RATE_03 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_04, 100) AS MM_MARGIN_RATE_04 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_05, 100) AS MM_MARGIN_RATE_05 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_06, 100) AS MM_MARGIN_RATE_06 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_07, 100) AS MM_MARGIN_RATE_07 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_08, 100) AS MM_MARGIN_RATE_08 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_09, 100) AS MM_MARGIN_RATE_09 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_10, 100) AS MM_MARGIN_RATE_10 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_11, 100) AS MM_MARGIN_RATE_11 \n");
        sbSql.append("       ,NVL(A.MM_MARGIN_RATE_12, 100) AS MM_MARGIN_RATE_12 \n");
        sbSql.append("   FROM MAP_MARGIN_RATE_MGMT A \n");
        sbSql.append("      , SCO_UPJANG_MST_V B \n");
        sbSql.append("  WHERE A.UPJANG(+) = B.UPJANG \n");
        sbSql.append("    AND A.CLASS(+) = 'R' \n");
        sbSql.append("    AND A.YY(+) = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(0, 4)) + "' \n");
        sbSql.append("    AND B.CLOSE_DATE IS NULL \n");
        //sbSql.append("    AND B.MU_CD = '2002' \n");
        //sbSql.append("    AND (B.TM_CD = 'CDH' OR PT_CD = 'CDH') \n");
        sbSql.append("    AND B.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        while (rs.next()) {
            marginRate01 = rs.getDouble("MM_MARGIN_RATE_01");
            marginRate02 = rs.getDouble("MM_MARGIN_RATE_02");
            marginRate03 = rs.getDouble("MM_MARGIN_RATE_03");
            marginRate04 = rs.getDouble("MM_MARGIN_RATE_04");
            marginRate05 = rs.getDouble("MM_MARGIN_RATE_05");
            marginRate06 = rs.getDouble("MM_MARGIN_RATE_06");
            marginRate07 = rs.getDouble("MM_MARGIN_RATE_07");
            marginRate08 = rs.getDouble("MM_MARGIN_RATE_08");
            marginRate09 = rs.getDouble("MM_MARGIN_RATE_09");
            marginRate10 = rs.getDouble("MM_MARGIN_RATE_10");
            marginRate11 = rs.getDouble("MM_MARGIN_RATE_11");
            marginRate12 = rs.getDouble("MM_MARGIN_RATE_12");
        }
        rs.close();
        pstmt.close();

        sbSql.delete(0, sbSql.length());
        sbSql.append("      INSERT INTO MAP_BPC_CONFIRM_DAY_PL_INFO                                         \n");
        sbSql.append("             ( YYMM                                                                   \n");
        sbSql.append("             , YMD                                                                    \n");
        sbSql.append("             , DAY_CLASS                                                              \n");
        sbSql.append("             , BU_CD                                                                  \n");
        sbSql.append("             , CC_CD                                                                  \n");
        sbSql.append("             , ACCT_CD                                                                \n");
        sbSql.append("             , MU_CD                                                                  \n");
        sbSql.append("             , TM_CD                                                                  \n");
        sbSql.append("             , DD_AMT                                                                 \n");
        sbSql.append("             , CURRENCY_CD                                                            \n");
        sbSql.append("             , CUSER                                                                  \n");
        sbSql.append("             , CDATE                                                                  \n");
        sbSql.append("             , UUSER                                                                  \n");
        sbSql.append("             , UDATE )                                                                \n");
        sbSql.append("      VALUES ( ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , ?   \n");
        sbSql.append("             , SYSDATE \n");
        sbSql.append("             , ?       \n");
        sbSql.append("             , SYSDATE \n");
        sbSql.append("             )        \n");
        pstmt = conn.prepareStatement(sbSql.toString());

        //월추정 확정정보 FC -> BPC로 정보 전송
        StringBuffer tmpString = new StringBuffer();
        for (int iRow = 0; iRow < ds_List.getRowCount(); iRow++) {
            int j = 1;
            double marginRate = 100.0;
            for (int k = 10; k <= chkDt; k++) {
                marginRate = 100.0;
                pstmt.setString(1, nullToBlank(ds_Cond.getString(0, "INPUT_YY")));
                if (k < 19) {
                    pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + '0' + String.valueOf(j));
                } else if (k >= 19 && k <= chkDt) {
                    pstmt.setString(2, nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + String.valueOf(j));
                }
                pstmt.setString(3, nullToBlank(ds_Cond.getString(0, "DAY_GBN")));
                pstmt.setString(4, "2000");
                pstmt.setString(5, nullToBlank(ds_List.getString(iRow, "CC_CD")));
                pstmt.setString(6, nullToBlank(ds_List.getString(iRow, "ACCT_CD")));
                pstmt.setString(7, "");
                pstmt.setString(8, "");

                // 재무금액으로 변경하여 BPC쪽으로 전송한다.
                if (nullToBlank(ds_List.getString(iRow, "ACCT_CD").substring(0, 5)).equals("42203")) {
                    if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("01")) marginRate = marginRate01;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("02")) marginRate = marginRate02;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("03")) marginRate = marginRate03;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("04")) marginRate = marginRate04;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("05")) marginRate = marginRate05;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("06")) marginRate = marginRate06;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("07")) marginRate = marginRate07;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("08")) marginRate = marginRate08;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("09")) marginRate = marginRate09;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("10")) marginRate = marginRate10;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("11")) marginRate = marginRate11;
                    else if (nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)).equals("12")) marginRate = marginRate12;
                    else marginRate = 100.0;
                    pstmt.setFloat(9, (int)Math.ceil(stringToFloat(ds_List.getString(iRow, k)) / (marginRate / 100.0)) * 1000);
                    //tmpString.append(nullToBlank(ds_Cond.getString(0, "INPUT_YY").substring(4, 6)) + " , " + marginRate + " , " + stringToFloat(ds_List.getString(iRow, k)) + " , "+ (marginRate / 100) + " , "+ ((int)Math.ceil(stringToFloat(ds_List.getString(iRow, k)) / (marginRate / 100)) * 1000) + "\n");
                } else {
                    pstmt.setFloat(9, stringToFloat(ds_List.getString(iRow, k)) * 1000);
                }
                //pstmt.setFloat(9, stringToFloat(ds_List.getString(iRow, k)) * 1000);

                pstmt.setString(10, "KRW");
                pstmt.setString(11, g_EmpNo);
                pstmt.setString(12, g_EmpNo);

                j++;

                //out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                //pstmt = conn.prepareStatement(sbSql.toString());
                //pstmt.executeUpdate();
                //pstmt.close();
                pstmt.addBatch(); //변수대입이 끝나면 다음 배치추가
            }
        } // END FOR
        pstmt.executeBatch(); //배치처리
        pstmt.close();

        //System.out.println(tmpString.toString());

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