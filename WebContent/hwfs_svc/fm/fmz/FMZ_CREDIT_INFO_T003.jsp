<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/공통
■ 프로그램ID   : FMZ_CREDIT_INFO_T001.jsp
■ 프로그램명   : 여신정보/실적 조회
■ 작성일자     : 2008.01.30
■ 작성자       : 박은규
■ 이력관리     : 2008.01.30

##### FMZ_CREDIT_INFO_T001.jsp 파일과 싱크 맞출것[outdataset 이름 주의] #####
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try	{
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
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
        String sIgnorCtrl   = nullToBlank(in_vl.getString("sIgnorCtrl"));
        String strDate;
        //String strDate      = nullToBlank(ds_cond.getString(0, "NEED_DATE"));

        //out 데이타
        DataSet ds_CrdInfo = new DataSet("ds_CrdInfo");
        
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // 여신관리여부에 따라 여신정보를 조회한다.
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		sbSql.setLength(0);
        sbSql.append("\n SELECT                                                                              ");
        sbSql.append("\n        A.CREDIT_TURN_DAYS          /* 여신회전일                                 */ ");
        sbSql.append("\n      , A.CREDIT_TURN_DAYS_TOT      /* 총 여신회전일                              */ ");
        sbSql.append("\n      , A.MAIN_UPJANG               /* 메인업장(본사)                             */ ");
        sbSql.append("\n      , A.UPJANG                    /* 업장                                       */ ");
        sbSql.append("\n      , A.UPJANGNM_DISP             /* 업장명                                     */ ");
        sbSql.append("\n      , A.CREDIT_AMOUNT             /* 기본여신금액                               */ ");
        sbSql.append("\n      , A.CREDIT_OVER_AMOUNT        /* 여신한도초과액                             */ ");
        //sbSql.append("\n      , A.BOND_AMT                  /* 채권잔액                                   */ ");
        sbSql.append("\n      , (A.CREDIT_AMOUNT - A.CREDIT_RMN_AMT)  AS BOND_AMT     /* 채권잔액         */ ");
        sbSql.append("\n      , A.L_BILL_DATE               /* 최장 미입금된 외상매출발생일               */ ");
        sbSql.append("\n      , A.CREDIT_RMN_AMT            /* 가용여신                                   */ ");
        sbSql.append("\n      , A.CREDIT_AVAIL_AMT          /* 실주문가능금액                             */ ");
        sbSql.append("\n      , A.LAST_TURN_CNT                                                              ");
        sbSql.append("\n      , A.HEAD_CREDIT_YN            /* 통합관리여부*/                                ");
        sbSql.append("\n      , A.CREDIT_TURN_CONTROL_YN    /* 'Y'이면 여신회전일통제, 'N'이면 '통제안함' */ ");
        sbSql.append("\n      , A.CREDIT_AMOUNT_CONTROL_YN  /* 'Y'이면 여신금액통제, 'N'이면 '통제안함'   */ ");
        sbSql.append("\n      , A.CREDIT_CONTROL_YN         /* 여신통제여부                               */ ");
        sbSql.append("\n      , A.ACNTCD                    /* 계좌정보                                   */ ");
        sbSql.append("\n      , A.CREDIT_CONTROL_DESC       /* 통제구분                                   */ ");
        sbSql.append("\n      , A.CREDIT_START              /* 여신부여일                                 */ ");
        sbSql.append("\n      , A.CREDIT_END                /* 여신부여일                                 */ ");
        sbSql.append("\n      , A.L_BILL_DATE_DISP          /* 최장 미입금된 외상매출발생일               */ ");
        sbSql.append("\n      , :schUpjang AS ORDER_UPJANG  /*주문업장*/");
        sbSql.append("\n   FROM TABLE(                                                                       ");
        sbSql.append("\n            FT_UPJANG_CREDIT_LIMIT(:schUpjang, :schNeedDate)                         ");
        sbSql.append("\n        ) A                                                                          ");
        
        npstmt = new NamedParameterStatement(conn, sbSql.toString());
        npstmt.setString("schUpjang", ds_Cond.getString(0, "UPJANG"));       // 업장코드
        npstmt.setString("schNeedDate", ds_Cond.getString(0, "NEED_DATE"));  // 입고예정일
        
        out_vl.add("fa_Sql", npstmt.getStatement().toString());
        
        rs         = npstmt.executeQuery();
       	ds_CrdInfo = this.makeDataSet(rs, "ds_CrdInfo");

		if ( logger.isDebugWrite() ) {
			logger.debug("\n★★★★★ FCUS.FT_UPJANG_CREDIT_LIMIT(업장별 여신정보) ★★★★★");
			logger.debug(ds_CrdInfo.saveXml());
		}
       	
        npstmt.close();
        rs.close();
        sbSql.setLength(0);        
        
//         String sHeadYn = "";
//         String sUpjang = "";
//         String sMainUpjang = "";

//         //본사통합 여신관리 여부
//         sbSql.append("SELECT NVL(HEAD_CREDIT_YN,'N') AS HEAD_CREDIT_YN \n");
//         sbSql.append("     , UPJANG \n");
//         sbSql.append("     , MAIN_UPJANG \n");
//         sbSql.append("  FROM FMS_UPJANG \n");
//         sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
//         out_vl.add("fa_Sql", sbSql.toString());

//         pstmt = conn.prepareStatement(sbSql.toString());
//         rs = pstmt.executeQuery();
//         if (rs != null) {
//             rs.next();
//             sHeadYn = rs.getString("HEAD_CREDIT_YN");
//             sUpjang = rs.getString("UPJANG");
//             sMainUpjang = rs.getString("MAIN_UPJANG");
//         }
//         if (rs != null) rs.close();
//         pstmt.close();

//         //본사통합인 경우 업장목록을 IN조건으로 만든다.
//         String sUpjangList = "";
//         if (sHeadYn.equals("Y"))
//         {
//             sbSql.delete(0,sbSql.length());
//             sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
//             sbSql.append(" WHERE MAIN_UPJANG = " + sMainUpjang + " \n");
//             sbSql.append("   AND HEAD_CREDIT_YN = 'Y' \n");
//             pstmt = conn.prepareStatement(sbSql.toString());
//             rs = pstmt.executeQuery();
//             while (rs.next())
//             {
//                 sUpjangList += ", " + rs.getString("UPJANG");
//             }
//             sUpjangList = "(" + sUpjangList.substring(1) + ")";
//             rs.close();
//             pstmt.close();
//         }

//         //여신체크할 최종 발주일자 조회
//         sbSql.delete(0,sbSql.length());
//         sbSql.append("SELECT NVL(MAX(NEED_DATE), '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "') AS NEED_DATE \n");
//         sbSql.append("  FROM SO_PR \n");
//         sbSql.append(" WHERE 1=1 \n");

//         if (sHeadYn.equals("Y")) {
//             sbSql.append(" AND RC_UPJANG IN " + sUpjangList + " \n");
//         } else {
//             sbSql.append(" AND RC_UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
//         }

//         //sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "') \n");
//         sbSql.append("   AND NEED_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "') \n");

//         sbSql.append("   AND LINE_STATUS NOT IN('003', '005','999') --신청취소, 결의반려 \n");
//         //sbSql.append("   AND ROWNUM <= 1 \n");
//         pstmt = conn.prepareStatement(sbSql.toString());
//         rs = pstmt.executeQuery();

//         if(rs.next()) {
//             strDate = rs.getString("NEED_DATE");
//         } else {
//             strDate = nullToBlank(ds_Cond.getString(0, "NEED_DATE"));
//         }

//         rs.close();
//         pstmt.close();

//         //내역조회(속도관계상 운영율은 적용하지 않는다.)
//         sbSql.delete(0,sbSql.length());
//         if (sHeadYn.equals("Y"))
//         {
//             sbSql.append("SELECT /*+ optimizer_features_enable('10.2.0.5') */ A1.MAIN_UPJANG \n");
//             sbSql.append("     , A1.UPJANG \n");
//             sbSql.append("     , A1.UPJANGNM_DISP \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT /* 여신금액 */ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_EXT_AMOUNT /* 여신연장금액-여신연장금액 삭제 */ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT /* 총 여신책정금액-여신연장금액 삭제 */ \n");
//             sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
//             sbSql.append("                THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* 여신한도초과액 */ \n");
//             //sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
//             sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
//             sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* 여신회전일 */ \n");
//             sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_EXT_DAYS /* 총 여신회전일 : 여신연장일 삭제 */ \n");
//             sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS_TOT \n");
//             sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,-1,TO_DATE("+strDate+",'YYYYMMDD') - TO_DATE(C.L_BILL_DATE,'YYYYMMDD')) AS LAST_TURN_CNT \n");
//             sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT /* 매입예정(신청) */ \n");
//             sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT /* 매입예정(발주) */ \n");
//             sbSql.append("     , NVL(D.TR_AMT,0) AS TR_AMT /* 매입확정 */ \n");
//             //sbSql.append("     , NVL(C.RMN_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
//             //sbSql.append("     , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
//             sbSql.append("     , NVL(C0.RMN_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
//             sbSql.append("     , NVL(C1.PRE_AMT,0) AS PRE_AMT /* 선수잔액 */ \n");
//             sbSql.append("     , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) + NVL(D.TR_AMT,0) + NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS BOND_AMT /* 채권잔액*/ \n");
//             //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             //sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT /* 가용여신 */ \n");
//             //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             //sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
//             //sbSql.append("               + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT /* 실주문가능금액*/ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT /* 가용여신 */ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
//             sbSql.append("               + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT /* 실주문가능금액*/ \n");
//             sbSql.append("     , NVL(C.L_BILL_DATE,'00000000') AS L_BILL_DATE /* 최장 미입금된 외상매출발생일*/ \n");
//             sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,'채권없음',TO_CHAR(TO_DATE(C.L_BILL_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"')) AS L_BILL_DATE_DISP /* 최장 미입금된 외상매출발생일*/ \n");
//             sbSql.append("     , A.HEAD_CREDIT_YN /*통합관리여부*/ \n");
//             sbSql.append("     , A.CREDIT_CONTROL_YN /* 여신통제여부 */ \n");
//             sbSql.append("     , A.CREDIT_TURN_CONTROL_YN /* 'Y'이면 여신회전일통제, 'N'이면 '통제안함' */ \n");
//             sbSql.append("     , A.CREDIT_AMOUNT_CONTROL_YN /* 'Y'이면 여신금액통제, 'N'이면 '통제안함' */ \n");
//             sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD /* 계좌정보*/ \n");
//             sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
//             sbSql.append("          ,'YYY','금액+회전일' \n");
//             sbSql.append("          ,'YYN','회전일통제' \n");
//             sbSql.append("          ,'YNY','금액통제','무통제') AS CREDIT_CONTROL_DESC /*통제구분*/ \n");
//             sbSql.append("     , A.CREDIT_START /*여신부여일*/ \n");
//             sbSql.append("     , A.CREDIT_END /*여신종료일*/ \n");
//             sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG A1 \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        C.외상잔액정보 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
//             sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
//             sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
//             sbSql.append("          FROM SLA_AR_MST M, SLA_AR_RECEIVE_DETAIL D, FMS_UPJANG B \n");
//             sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
//             sbSql.append("           AND M.RECD_STATUS = 'L' \n");
//             sbSql.append("           AND D.RECEIVE_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
//             sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
//             sbSql.append("           AND D.RECD_STATUS = 'L' \n");
//             sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
//             sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y' \n");
//             sbSql.append("           AND M.UPJANG_CD = B.UPJANG \n");
//             sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  채권잔액이 있는 자료 기준 */ \n");
//             //sbSql.append("           AND M.UPJANG_CD IN " + sUpjang + " \n");
//             sbSql.append("           AND M.UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = "+ sMainUpjang +" AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y') \n");
//             sbSql.append("         GROUP BY B.MAIN_UPJANG ) C \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        C0.선수잔액정보 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT T.MAIN_UPJANG \n");
//             sbSql.append("             , SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT \n");
//             sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n");
//             sbSql.append("                     , NVL(M.AR_AMT, 0) AS AR_AMT \n");
//             sbSql.append("                     , (SELECT NVL(SUM(D.RECEIVE_AMT),0) \n");
//             sbSql.append("                          FROM SLA_AR_RECEIVE_DETAIL D \n");
//             sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n");
//             sbSql.append("                           AND D.RECEIVE_DATE <= "+strDate+" \n");
//             sbSql.append("                           AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n");
//             sbSql.append("                  FROM SLA_AR_MST M, FMS_UPJANG B \n");
//             sbSql.append("                 WHERE M.SYS_CLASS = '13' \n");
//             sbSql.append("                   AND M.RECD_STATUS = 'L' \n");
//             sbSql.append("                   AND M.OCCUR_DATE <= "+strDate+" \n");
//             sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n");
//             sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
//             //sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n");
//             sbSql.append("                   AND M.UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = "+ sMainUpjang +" AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y') \n");
//             sbSql.append("                ) T \n");
//             sbSql.append("         GROUP BY T.MAIN_UPJANG \n");
//             //sbSql.append("        HAVING SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) > 0) C0 \n");
//             sbSql.append("        ) C0 \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        C1.선수잔액정보 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT T.MAIN_UPJANG \n");
//             sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT \n");
//             sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n");
//             sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n");
//             sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0) \n");
//             sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D \n");
//             sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n");
//             sbSql.append("                           AND D.ALT_DATE <= "+strDate+" \n");
//             sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n");
//             sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B \n");
//             sbSql.append("                 WHERE M.SYS_CLASS = '13' \n");
//             sbSql.append("                   AND M.RECD_STATUS = 'L' \n");
//             sbSql.append("                   AND M.OCCUR_DATE <= "+strDate+" \n");
//             sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n");
//             sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
//             //sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n");
//             sbSql.append("                   AND M.UPJANG_CD IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = "+ sMainUpjang +" AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y') \n");
//             sbSql.append("                ) T \n");
//             sbSql.append("         GROUP BY T.MAIN_UPJANG \n");
//             //sbSql.append("        HAVING SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) > 0) C1 \n");
//             sbSql.append("        ) C1 \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        D.당월 미매출마감된 검수금액 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT X.MAIN_UPJANG                                                                                                                                                                                                                                                   \n");
//             sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT                                                                                                                                                                                                                                         \n");
//             sbSql.append("          FROM (                                                                                                                                                                                                                                                               \n");
//             sbSql.append("                               SELECT  /*+ PUSH_PRED(A) */                                                                                                                                                                                                                     \n");
//             sbSql.append("                                       C.MAIN_UPJANG                                                                                                                                                                                                                           \n");
//             sbSql.append("                                    ,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT                                                                                                    \n");
//             sbSql.append("                                           FROM (                                                                                                                                                                                                                              \n");
//             sbSql.append("                                                SELECT DT.MG_NO AS TRANS_ID,  /* 자재수불번호 */                                                                                                                                                                               \n");
//             sbSql.append("                                                       CASE                                                                                                                                                                                                                    \n");
//             sbSql.append("                                                         WHEN SUBSTR(DT.MOVEMENT_TYP,0,2)='25' THEN 'FO'                                                                                                                                                                       \n");
//             sbSql.append("                                                         WHEN DT.PROC_TYP_CD IS NULL AND DT.IVT_INSP_NO IS NOT NULL THEN '재고조정'                                                                                                                                            \n");
//             sbSql.append("                                                         WHEN DT.PROC_TYP_CD IS NULL AND DT.IVT_INSP_NO IS NULL THEN 'INV'                                                                                                                                                     \n");
//             sbSql.append("                                                         ELSE 'PO'                                                                                                                                                                                                             \n");
//             sbSql.append("                                                       END AS SOURCE_TYPE,  /* FO, PO, INV, 재고조정 */                                                                                                                                                                        \n");
//             sbSql.append("                                                       SL.CUST_GR_DATE AS TRANS_DATE,  /* 판매일자 */                                                                                                                                                                          \n");
//             sbSql.append("                                                       DT.MG_DATE AS MG_DATE,  /* 수불일자*/                                                                                                                                                                                   \n");
//             sbSql.append("                                                       CASE                                                                                                                                                                                                                    \n");
//             sbSql.append("                                                         WHEN SUBSTR(DT.MOVEMENT_TYP,0,1) = '3' AND DT.GR_QTY IS NULL THEN 'O002'         /* 재고이동 - 이동출고   */                                                                                                          \n");
//             sbSql.append("                                                         WHEN SUBSTR(DT.MOVEMENT_TYP,0,1) = '3' AND DT.GR_QTY IS NOT NULL THEN 'I002'      /*재고이동 - 이동입고  */                                                                                                           \n");
//             sbSql.append("                                                         WHEN DT.MOVEMENT_TYP = '251'OR DT.MOVEMENT_TYP = '252' THEN 'O001'      /* POS 매출 유형  */                                                                                                                          \n");
//             sbSql.append("                                                         WHEN DT.MOVEMENT_TYP = '701' OR DT.MOVEMENT_TYP = '702' THEN 'O004'      /* 재고실사 */                                                                                                                               \n");
//             sbSql.append("                                                         ELSE 'I001'                                                                                                                                                                                                           \n");
//             sbSql.append("                                                       END AS TRANS_TYPE,                                                                                                                                                                                                      \n");
//             sbSql.append("                                                      CASE                                                                                                                                                                                                                     \n");
//             sbSql.append("                                                         WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=0 AND DT.PROC_TYP_CD IS NOT NULL THEN DECODE(DT.GR_QTY,NULL,DT.GI_PURC_QTY*-1,DT.GR_PURC_QTY*-1)                                                                               \n");
//             sbSql.append("                                                         WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=1 AND DT.PROC_TYP_CD IS NOT NULL THEN DECODE(DT.GR_QTY,NULL,DT.GI_PURC_QTY,DT.GR_PURC_QTY)                                                                                     \n");
//             sbSql.append("                                                         WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=0 AND DT.PROC_TYP_CD IS NULL THEN DECODE(DT.GR_QTY,NULL,DT.GI_QTY*-1,DT.GR_QTY*-1)                                                                                             \n");
//             sbSql.append("                                                         WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=1 AND DT.PROC_TYP_CD IS NULL THEN DECODE(DT.GR_QTY,NULL,DT.GI_QTY,DT.GR_QTY)                                                                                                   \n");
//             sbSql.append("                                                       END AS TRANS_QTY,             /* 수량 */                                                                                                                                                                                \n");
//             sbSql.append("                                                       SL.SHOP_CD AS TRANS_UPJANG,    /* 업장코드 */                                                                                                                                                                           \n");
//             sbSql.append("                                                       SL.CUST_WH_CD AS SUBINV_CODE,     /* 창고코드*/                                                                                                                                                                         \n");
//             sbSql.append("                                                       DECODE(MT.ACC_TAX_CD,'1','100','3','210','220') AS TAX_CODE,             /* 과면세 코드 */                                                                                                                              \n");
//             sbSql.append("                                                       SL.SAL_PRICE AS SALE_PRICE                               /* 외부판매단가 */                                                                                                                                             \n");
//             sbSql.append("                                                 FROM EPROCUSR.ESIMGHD HD,                                                /* 수불헤더*/                                                                                                                                        \n");
//             sbSql.append("                                                      EPROCUSR.ESIMGDT DT,                                               /* 수불상세 */                                                                                                                                        \n");
//             sbSql.append("                                                      EPROCUSR.ESPPODT PO,                                              /* 발주 상세 */                                                                                                                                        \n");
//             sbSql.append("                                                      EPROCUSR.ESPPOHD PH,                                              /* 발주 헤더 */                                                                                                                                        \n");
//             sbSql.append("                                                      EPROCUSR.ESMMTGL MT,                                              /* 품목마스터 */                                                                                                                                       \n");
//             sbSql.append("                                                      EPROCUSR.ESISALP SL                                               /* 판매단가 */                                                                                                                                         \n");
//             sbSql.append("                                                WHERE HD.SYS_ID = '100'                                                                                                                                                                                                        \n");
//             sbSql.append("                                                  AND HD.COMP_CD = 'HFC'                                                                                                                                                                                                       \n");
//             sbSql.append("                                                  AND HD.BU_CD = '2000'                                                                                                                                                                                                        \n");
//             sbSql.append("                                                  AND HD.SYS_ID = DT.SYS_ID                                                                                                                                                                                                    \n");
//             sbSql.append("                                                  AND HD.COMP_CD = DT.COMP_CD                                                                                                                                                                                                  \n");
//             sbSql.append("                                                  AND HD.WH_CD = DT.WH_CD                                                                                                                                                                                                      \n");
//             sbSql.append("                                                  AND HD.ITEM_CD = DT.ITEM_CD                                                                                                                                                                                                  \n");
//             sbSql.append("                                                  AND DT.MOVEMENT_TYP NOT IN ('561','562','998','999','901','902','801','802','111','112','211','212')   /* 기초 , 기말 재고,배송입출고, 직송 가상입출고  제외 */                                                              \n");
//             sbSql.append("                                                  AND DT.SYS_ID = PO.SYS_ID(+)                                                                                                                                                                                                 \n");
//             sbSql.append("                                                  AND DT.COMP_CD = PO.COMP_CD(+)                                                                                                                                                                                               \n");
//             sbSql.append("                                                  AND DT.PO_NO = PO.PO_NO(+)                                                                                                                                                                                                   \n");
//             sbSql.append("                                                  AND DT.PO_LNO = PO.PO_LNO(+)                                                                                                                                                                                                 \n");
//             sbSql.append("                                                  AND DT.SYS_ID = PH.SYS_ID(+)                                                                                                                                                                                                 \n");
//             sbSql.append("                                                  AND DT.COMP_CD = PH.COMP_CD(+)                                                                                                                                                                                               \n");
//             sbSql.append("                                                  AND DT.PO_NO = PH.PO_NO(+)                                                                                                                                                                                                   \n");
//             sbSql.append("                                                  AND DT.SYS_ID = MT.SYS_ID                                                                                                                                                                                                    \n");
//             sbSql.append("                                                  AND DT.ITEM_CD = MT.ITEM_CD                                                                                                                                                                                                  \n");
//             sbSql.append("                                                  AND DT.SYS_ID = SL.SYS_ID                                                                                                                                                                                                    \n");
//             sbSql.append("                                                  AND DT.COMP_CD = SL.COMP_CD                                                                                                                                                                                                  \n");
//             sbSql.append("                                                  AND DT.MG_NO = SL.MG_NO                                                                                                                                                                                                      \n");
//             sbSql.append("                                                  AND DT.STS <> 'D'                                                                                                                                                                                                            \n");
//             sbSql.append("                                                  AND SL.SHOP_CD IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = "+sMainUpjang+" AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y')                                                                                                     \n");
//             sbSql.append("                                                  AND DT.MG_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01' AND "+strDate+"                                                                                                                 \n");
//             sbSql.append("                                                UNION ALL                                                                                                                                                                                                                      \n");
//             sbSql.append("                                                   SELECT B.TRANS_ID,                                                                                                                                                                                                          \n");
//             sbSql.append("                                                          B.SOURCE_TYPE ,                                                                                                                                                                                                      \n");
//             sbSql.append("                                                          B.TRANS_DATE,                                                                                                                                                                                                        \n");
//             sbSql.append("                                                          B.TRANS_DATE AS MG_DATE,                                                                                                                                                                                             \n");
//             sbSql.append("                                                          B.TRANS_TYPE,                                                                                                                                                                                                        \n");
//             sbSql.append("                                                          B.TRANS_QTY,                                                                                                                                                                                                         \n");
//             sbSql.append("                                                          TO_CHAR (B.TRANS_UPJANG) AS TRANS_UPJANG,                                                                                                                                                                            \n");
//             sbSql.append("                                                          B.SUBINV_CODE,                                                                                                                                                                                                       \n");
//             sbSql.append("                                                          B.TAX_CODE,                                                                                                                                                                                                          \n");
//             sbSql.append("                                                          B.SALE_PRICE                                                                                                                                                                                                         \n");
//             sbSql.append("                                                     FROM FMS_TRANSACTION B                                                                                                                                                                                                    \n");
//             sbSql.append("                                                    WHERE B.TRANS_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = '"+sMainUpjang+"' AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y')                                                                                             \n");
//             sbSql.append("                                                      AND B.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01' AND "+strDate+"                                                                                                           \n");
//             sbSql.append("                                                ) A                                                                                                                                                                                                                            \n");
//             sbSql.append("                                              , (SELECT UPJANG                                                                                                                                                                                                                 \n");
//             sbSql.append("                                                     , MAX(SALE_DATE) AS SALE_DATE                                                                                                                                                                                             \n");
//             sbSql.append("                                                  FROM FMS_SALES                                                                                                                                                                                                               \n");
//             sbSql.append("                                                 WHERE SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01' AND "+strDate+"                                                                                                                 \n");
//             sbSql.append("                                                   AND TRANS_YN = 'Y'                                                                                                                                                                                                          \n");
//             sbSql.append("                                                   AND UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = '"+sMainUpjang+"' AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y')                                                                                                        \n");
//             sbSql.append("                                                 GROUP BY UPJANG                                                                                                                                                                                                               \n");
//             sbSql.append("                                                ) B                                                                                                                                                                                                                            \n");
//             sbSql.append("                                              , FMS_UPJANG C                                                                                                                                                                                                                   \n");
//             sbSql.append("                                           WHERE A.TRANS_UPJANG = C.UPJANG                                                                                                                                                                                                     \n");
//             sbSql.append("                                             AND A.TRANS_UPJANG = B.UPJANG(+)                                                                                                                                                                                                  \n");
//             sbSql.append("                                             AND C.HEAD_CREDIT_YN = 'Y'                                                                                                                                                                                                        \n");
//             sbSql.append("                                             AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO'))                                                                                                                                                    \n");
//             sbSql.append("                                             AND A.MG_DATE BETWEEN DECODE(B.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD')) AND "+strDate+" \n");
//             sbSql.append("                                             AND C.MAIN_UPJANG = '"+sMainUpjang+"'                                                                                                                                                                                                      \n");
//             sbSql.append("                                             AND A.TRANS_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = '"+sMainUpjang+"' AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y')                                                                                                      \n");
//             sbSql.append("                                           GROUP BY C.MAIN_UPJANG                                                                                                                                                                                                              \n");
//             sbSql.append("                ) X                                                                                                                                                                                                                                                            \n");
//             sbSql.append("         GROUP BY X.MAIN_UPJANG                                                                                                                                                                                                                                                \n");
//             sbSql.append("        ) D                                                                                                                                                                                                                                                                    \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("       E.당월 미검수 발주금액 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             //sbSql.append("     , ( /* PW(발주진행), PC(발주완료), DL(배송중) 만 집계 */ \n");
//             //sbSql.append("         /* CENTER_DELI_QTY(센터입고수량), DIRECT_DELI_QTY(직송수량), DELIVERED_QTY(업장입고수량-센터출고), UNDELIVERED_QTY(센터미입고수량) */ \n");
//             //sbSql.append("        SELECT /*+ PUSH_PRED(A) */ C.MAIN_UPJANG \n");
//             //sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
//             //sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
//             //sbSql.append("         WHERE A.RC_UPJANG = C.UPJANG \n");
//             //sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
//             //sbSql.append("           AND C.HEAD_CREDIT_YN = 'Y' \n");
//             //sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
//             //sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
//             //sbSql.append("           AND C.UPJANG IN " + sUpjangList + " \n");
//             //sbSql.append("         GROUP BY C.MAIN_UPJANG) E \n");
//         sbSql.append("     , (                                                                                                                                             \n");
//         sbSql.append("                SELECT                                                                                                                               \n");
//         sbSql.append("                                           C.MAIN_UPJANG                                                                                             \n");
//         sbSql.append("                                         , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
//         sbSql.append("                                      FROM                                                                                                           \n");
//         sbSql.append("                (                                                                                                                                    \n");
//         sbSql.append("                        SELECT                                                                                                                       \n");
//         sbSql.append("                               SAL.SHOP_CD              AS RC_UPJANG   -- 입고업장 코드                                                              \n");
//         sbSql.append("                             , CASE                                                                                                                  \n");
//         sbSql.append("                                 WHEN PODT.DUTY_FREE_YN ='1' THEN '100'                                                                              \n");
//         sbSql.append("                                 WHEN PODT.DUTY_FREE_YN ='3' THEN '210'                                                                              \n");
//         sbSql.append("                                 WHEN PODT.DUTY_FREE_YN ='2' THEN '220'                                                                              \n");
//         sbSql.append("                               END  AS TAX_CODE   -- 과세구분코드                                                                                    \n");
//         sbSql.append("                             , PODT.PR_QTY              AS PR_QTY      -- 신청 수량                                                                  \n");
//         sbSql.append("                             , PODT.ITEM_QTY            AS PO_QTY      -- 발수 수량                                                                  \n");
//         sbSql.append("                             , CASE WHEN PODT.PROC_TYP_CD IN('DC', 'TC') THEN PODT.ITEM_QTY ELSE 0 END  AS CENTER_DELI_QTY  -- 센터입고수량          \n");
//         sbSql.append("                             , 0  AS CENTER_UNDELI_QTY             -- 센터미입고 수량                                                                \n");
//         sbSql.append("                             , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY ELSE 0 END  AS DIRECT_DELI_QTY  -- 직송 수량                       \n");
//         sbSql.append("                             , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0) ELSE NVL(PODT.GR_QTY_WMS,0) END  AS DELIVERED_QTY    --업장입고수량(센터출고) \n");
//         sbSql.append("                            , CASE                                                                                                                   \n");
//         sbSql.append("                                 WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료          \n");
//         sbSql.append("                                 ELSE 0                                                                                                              \n");
//         sbSql.append("                               END AS UNDELIVERED_QTY -- 감량수량                                                                                    \n");
//         sbSql.append("                             , PODT.RTN_QTY AS RETURNED_QTY -- 반품수량                                                                              \n");
//         sbSql.append("                             , SAL.CUST_GR_DATE                AS NEED_DATE -- 입고희망일자                                                          \n");
//         sbSql.append("                             , NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN                                                                                 \n");
//         sbSql.append("                                     CASE                                                                                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가                     \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC'                                            \n");
//         sbSql.append("                                     END                                                                                                             \n");
//         sbSql.append("                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))                                                \n");
//         sbSql.append("                               END,'PC') AS LINE_STATUS  -- 라인 상태 코드                                                                           \n");
//         sbSql.append("                             , NVL(SAL.SAL_PRICE,0)      AS SALE_PRICE -- 판매 단가                                                                  \n");
//         sbSql.append("                          FROM EPROCUSR.ESPPOHD POHD   -- PO 헤더                                                                                    \n");
//         sbSql.append("                             , EPROCUSR.ESPPODT PODT   -- PO 상세(품목)                                                                              \n");
//         sbSql.append("                             , EPROCUSR.ESMMTGL MTGL   -- 자재마스터                                                                                 \n");
//         sbSql.append("                             , EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]                                                                     \n");
//         sbSql.append("                             , EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목)                                                                              \n");
//         sbSql.append("                         WHERE PODT.SYS_ID  = POHD.SYS_ID(+)                                                                                         \n");
//         sbSql.append("                           AND PODT.COMP_CD = POHD.COMP_CD (+)                                                                                       \n");
//         sbSql.append("                           AND PODT.PO_NO   = POHD.PO_NO(+)                                                                                          \n");
//         sbSql.append("                           AND PODT.SYS_ID  = SAL.SYS_ID(+)                                                                                          \n");
//         sbSql.append("                           AND PODT.COMP_CD = SAL.COMP_CD(+)                                                                                         \n");
//         sbSql.append("                           AND PODT.PO_NO   = SAL.PO_NO(+)                                                                                           \n");
//         sbSql.append("                           AND PODT.PO_LNO  = SAL.PO_LNO(+)                                                                                          \n");
//         sbSql.append("                           AND PODT.SYS_ID  = MTGL.SYS_ID                                                                                            \n");
//         sbSql.append("                           AND PODT.ITEM_CD = MTGL.ITEM_CD                                                                                           \n");
//         sbSql.append("                           AND PODT.PR_NO   = PRDT.PR_NO(+)                                                                                          \n");
//         sbSql.append("                           AND PODT.PR_LNO  = PRDT.PR_LNO(+)                                                                                         \n");
//         sbSql.append("                           AND PODT.SYS_ID  = PRDT.SYS_ID(+)                                                                                         \n");
//         sbSql.append("                           AND PODT.COMP_CD = PRDT.COMP_CD(+)                                                                                        \n");
//         sbSql.append("                           AND PODT.SYS_ID  = '100'                                                                                                  \n");
//         sbSql.append("                           AND PODT.COMP_CD = 'HFC'                                                                                                  \n");
//         sbSql.append("                           AND PODT.SHOP_TYP_CD = '02'                                                                                               \n");
//         sbSql.append("                           AND PODT.STS    <> 'D'                                                                                                    \n");
//         sbSql.append("                           AND POHD.PO_TYP IN ('UP','BP')                                                                                            \n");
//         sbSql.append("                           and SAL.CUST_GR_DATE between to_char(add_months(sysdate,-1),'yyyymm') || '01' and '"+strDate+"'                              \n");
//         sbSql.append("                           and SAL.SHOP_CD IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = '"+sMainUpjang+"' AND HEAD_CREDIT_YN = 'Y' AND USE_YN = 'Y') \n");
//         sbSql.append("                           and NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN                                                                                 \n");
//         sbSql.append("                                     CASE                                                                                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가                     \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC'                                            \n");
//         sbSql.append("                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC'                                            \n");
//         sbSql.append("                                     END                                                                                                             \n");
//         sbSql.append("                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))                                                \n");
//         sbSql.append("                               END,'PC') IN ('PW', 'PC', 'DL')                                                                                       \n");
//         sbSql.append("                        ) A                                                                                                                          \n");
//         sbSql.append("                        , FMS_UPJANG C                                                                                                               \n");
//         sbSql.append("                     WHERE A.RC_UPJANG = C.UPJANG                                                                                                    \n");
//         sbSql.append("                       AND C.HEAD_CREDIT_YN = 'Y'                                                                                                    \n");
//         sbSql.append("                       AND C.MAIN_UPJANG = '"+sMainUpjang+"'                                                                                                  \n");
//         sbSql.append("                     GROUP BY C.MAIN_UPJANG                                                                                                          \n");
//         sbSql.append("        ) E                                                                                                                                          \n");            
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("       F.당월 미발주 주문금액 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
//             sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
//             sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
//             sbSql.append("         WHERE A.RC_UPJANG = B.UPJANG \n");
//             sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y' \n");
//             sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
//             sbSql.append("           AND A.LINE_STATUS = '001' /* 진행상태 : 001(신청저장) */ \n");
//             sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
//             sbSql.append("         GROUP BY B.MAIN_UPJANG) F \n");
//             sbSql.append(" WHERE A1.MAIN_UPJANG = A.UPJANG \n");
//             sbSql.append("   AND A1.MAIN_UPJANG = " + sMainUpjang + " \n");
//             sbSql.append("   AND A1.UPJANG = " + sUpjang + " \n");
//             sbSql.append("   AND A.UPJANG = C.MAIN_UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = C0.MAIN_UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = C1.MAIN_UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = D.MAIN_UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = E.MAIN_UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = F.MAIN_UPJANG(+) \n");
//             sbSql.append("   AND A1.HEAD_CREDIT_YN = 'Y' \n");
//             sbSql.append("   AND A1.USE_YN = 'Y' \n");
//             sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
//             sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
//         }
//         else
//         {
//             sbSql.append("SELECT A.MAIN_UPJANG \n");
//             sbSql.append("     , A.UPJANG \n");
//             sbSql.append("     , A.UPJANGNM_DISP \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT /* 여신금액 */ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_EXT_AMOUNT /* 여신연장금액-여신연장금액 삭제 */ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT /* 총 여신책정금액-여신연장금액 삭제 */ \n");
//             sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
//             sbSql.append("                THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* 여신한도초과액 */ \n");
//             //sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
//             sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
//             sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* 여신회전일 */ \n");
//             sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_EXT_DAYS /* 총 여신회전일 : 여신연장일 삭제 */ \n");
//             sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS_TOT \n");
//             sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,-1,TO_DATE("+strDate+",'YYYYMMDD') - TO_DATE(C.L_BILL_DATE,'YYYYMMDD')) AS LAST_TURN_CNT \n");
//             sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT /* 매입예정(신청) */ \n");
//             sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT /* 매입예정(발주) */ \n");
//             sbSql.append("     , NVL(D.TR_AMT,0) AS TR_AMT /* 매입확정 */ \n");
//             //sbSql.append("     , NVL(C.RMN_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
//             //sbSql.append("     , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
//             sbSql.append("     , NVL(C0.RMN_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
//             sbSql.append("     , NVL(C1.PRE_AMT,0) AS PRE_AMT /* 선수잔액 */ \n");
//             sbSql.append("     , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) + NVL(D.TR_AMT,0) + NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS BOND_AMT /* 채권잔액*/ \n");
//             //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             //sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT /* 가용여신 */ \n");
//             //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             //sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
//             //sbSql.append("               + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT /* 실주문가능금액*/ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT /* 가용여신 */ \n");
//             sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
//             sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
//             sbSql.append("               + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT /* 실주문가능금액*/ \n");
//             sbSql.append("     , NVL(C.L_BILL_DATE,'00000000') AS L_BILL_DATE /* 최장 미입금된 외상매출발생일*/ \n");
//             sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,'채권없음',TO_CHAR(TO_DATE(C.L_BILL_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"')) AS L_BILL_DATE_DISP /* 최장 미입금된 외상매출발생일*/ \n");
//             sbSql.append("     , A.HEAD_CREDIT_YN /*통합관리여부*/ \n");
//             sbSql.append("     , A.CREDIT_CONTROL_YN /* 여신통제여부 */ \n");
//             sbSql.append("     , A.CREDIT_TURN_CONTROL_YN /* 'Y'이면 여신회전일통제, 'N'이면 '통제안함' */ \n");
//             sbSql.append("     , A.CREDIT_AMOUNT_CONTROL_YN /* 'Y'이면 여신금액통제, 'N'이면 '통제안함' */ \n");
//             sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD /* 계좌정보*/ \n");
//             sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
//             sbSql.append("          ,'YYY','금액+회전일' \n");
//             sbSql.append("          ,'YYN','회전일통제' \n");
//             sbSql.append("          ,'YNY','금액통제','무통제') AS CREDIT_CONTROL_DESC /*통제구분*/ \n");
//             sbSql.append("     , A.CREDIT_START /*여신부여일*/ \n");
//             sbSql.append("     , A.CREDIT_END /*여신종료일*/ \n");
//             sbSql.append("  FROM FMS_UPJANG A \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        C.외상잔액정보 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT M.UPJANG_CD AS UPJANG \n");
//             sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
//             sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
//             sbSql.append("          FROM SLA_AR_MST M, SLA_AR_RECEIVE_DETAIL D, FMS_UPJANG B \n");
//             sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
//             sbSql.append("           AND M.RECD_STATUS = 'L' \n");
//             sbSql.append("           AND D.RECEIVE_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
//             sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
//             sbSql.append("           AND D.RECD_STATUS = 'L' \n");
//             sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
//             sbSql.append("           AND B.HEAD_CREDIT_YN = 'N' \n");
//             sbSql.append("           AND M.UPJANG_CD = B.UPJANG \n");
//             sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  채권잔액이 있는 자료 기준 */ \n");
//             sbSql.append("           AND M.UPJANG_CD = " + sUpjang + " \n");
//             sbSql.append("         GROUP BY M.UPJANG_CD ) C \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        C0.선수잔액정보 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT T.UPJANG \n");
//             sbSql.append("             , SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT \n");
//             sbSql.append("          FROM (SELECT B.UPJANG \n");
//             sbSql.append("                     , NVL(M.AR_AMT, 0) AS AR_AMT \n");
//             sbSql.append("                     , (SELECT NVL(SUM(D.RECEIVE_AMT),0) \n");
//             sbSql.append("                          FROM SLA_AR_RECEIVE_DETAIL D \n");
//             sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n");
//             sbSql.append("                           AND D.RECEIVE_DATE <= "+strDate+" \n");
//             sbSql.append("                           AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n");
//             sbSql.append("                  FROM SLA_AR_MST M, FMS_UPJANG B \n");
//             sbSql.append("                 WHERE M.SYS_CLASS = '13' \n");
//             sbSql.append("                   AND M.RECD_STATUS = 'L' \n");
//             sbSql.append("                   AND M.OCCUR_DATE <= "+strDate+" \n");
//             sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N' \n");
//             sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
//             sbSql.append("                   AND M.UPJANG_CD = " + sUpjang + " \n");
//             sbSql.append("                ) T \n");
//             sbSql.append("         GROUP BY T.UPJANG \n");
//             //sbSql.append("        HAVING SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) > 0) C0 \n");
//             sbSql.append("        ) C0 \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        C1.선수잔액정보 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT T.UPJANG \n");
//             sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT \n");
//             sbSql.append("          FROM (SELECT B.UPJANG \n");
//             sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n");
//             sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0) \n");
//             sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D \n");
//             sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n");
//             sbSql.append("                           AND D.ALT_DATE <= "+strDate+" \n");
//             sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n");
//             sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B \n");
//             sbSql.append("                 WHERE M.SYS_CLASS = '13' \n");
//             sbSql.append("                   AND M.RECD_STATUS = 'L' \n");
//             sbSql.append("                   AND M.OCCUR_DATE <= "+strDate+" \n");
//             sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N' \n");
//             sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
//             sbSql.append("                   AND M.UPJANG_CD = " + sUpjang + " \n");
//             sbSql.append("                ) T \n");
//             sbSql.append("         GROUP BY T.UPJANG \n");
//             //sbSql.append("        HAVING SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) > 0) C1 \n");
//             sbSql.append("        ) C1 \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("        D.당월 미매출마감된 검수금액 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT X.UPJANG \n");
//             sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
//             sbSql.append("          FROM ( \n");
//             //sbSql.append("                   SELECT B.UPJANG \n");
//             //sbSql.append("                     , SUM(A.SAL_AMT) AS TR_AMT \n");
//             //sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
//             //sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
//             //sbSql.append("                   AND A.SALE_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
//             //sbSql.append("                   AND A.TRANS_YN='N' /* 영업회계 미전송건 */ \n");
//             //sbSql.append("                   AND B.HEAD_CREDIT_YN='N' \n");
//             //sbSql.append("                   AND A.UPJANG = " + sUpjang + " \n");
//             //sbSql.append("                 GROUP BY B.UPJANG \n");
//             //sbSql.append("                 UNION ALL \n");
//             sbSql.append("                /* D2. 식재매출집계(FMS_SALES)의 최종마감일자 이후에서 기준일자 까지 */ \n");
//             sbSql.append("                SELECT /*+ PUSH_PRED(A) */ C.UPJANG \n");
//             //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
//             sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
//             sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
//             sbSql.append("                     , (SELECT UPJANG \n");
//             sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
//             sbSql.append("                          FROM FMS_SALES \n");
//             sbSql.append("                         WHERE SALE_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
//             sbSql.append("                           AND UPJANG = " + sUpjang + " \n");
//             sbSql.append("                   		   AND TRANS_YN = 'Y' /* 영업회계 전송건 */ \n");
//             sbSql.append("                         GROUP BY UPJANG \n");
//             sbSql.append("                        ) B \n");
//             sbSql.append("                      , FMS_UPJANG C \n");
//             sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
//             sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
//             sbSql.append("                    AND C.HEAD_CREDIT_YN = 'N' \n");
//             sbSql.append("                    AND A.MG_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
//             //sbSql.append("                    /* 업장별 최종마감일자 이후 ~ 기준일자까지의 집계 : 만약 마감정보가 없으면 기준일자 대비 1개월 전부터 대입 */ \n");
//             //sbSql.append("                    AND A.TRANS_DATE>=GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+" , 'YYYYMMDD'),-1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
// 			sbSql.append("                    /* 업장별 최종마감일자 이후 ~ 기준일자까지의 집계 : 만약 마감정보가 없으면 기준일자 대비 1개월 전부터 대입 : 2015-10-27 */ \n");
// 			sbSql.append("				   AND    A.MG_DATE >= DECODE(B.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
//             sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
//             //sbSql.append("                    AND A.TRANS_UPJANG = " + sUpjang + " \n");
//             sbSql.append("                    AND C.UPJANG = " + sUpjang + " \n");
//             sbSql.append("                  GROUP BY C.UPJANG) X \n");
//             sbSql.append("         GROUP BY X.UPJANG \n");
//             sbSql.append("        ) D \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("       E.당월 미검수 발주금액 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , ( /* PW(발주진행), PC(발주완료), DL(배송중) 만 집계 */ \n");
//             sbSql.append("         /* CENTER_DELI_QTY(센터입고수량), DIRECT_DELI_QTY(직송수량), DELIVERED_QTY(업장입고수량-센터출고), UNDELIVERED_QTY(센터미입고수량) */ \n");
//             sbSql.append("        SELECT /*+ PUSH_PRED(A) */ C.UPJANG \n");
//             sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
//             sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
//             sbSql.append("         WHERE A.RC_UPJANG = C.UPJANG \n");
//             sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
//             sbSql.append("           AND C.HEAD_CREDIT_YN = 'N' \n");
//             sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
//             //sbSql.append("           AND A.RC_UPJANG = " + sUpjang + " \n");
//             sbSql.append("           AND C.UPJANG = " + sUpjang + " \n");
//             sbSql.append("         GROUP BY C.UPJANG) E \n");
//             sbSql.append("       /************************************************************************ \n");
//             sbSql.append("       F.당월 미발주 주문금액 \n");
//             sbSql.append("       **************************************************************************/ \n");
//             sbSql.append("     , (SELECT B.UPJANG \n");
//             sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
//             sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
//             sbSql.append("         WHERE A.RC_UPJANG = B.UPJANG \n");
//             sbSql.append("           AND B.HEAD_CREDIT_YN = 'N' \n");
//             sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
//             sbSql.append("           AND A.LINE_STATUS = '001' /* 진행상태 : 001(신청저장) */ \n");
//             sbSql.append("           AND A.RC_UPJANG = " + sUpjang + " \n");
//             sbSql.append("         GROUP BY B.UPJANG) F \n");
//             sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = C0.UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
//             sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
//             sbSql.append("   AND A.MAIN_UPJANG = " + sMainUpjang + " \n");
//             sbSql.append("   AND A.HEAD_CREDIT_YN = 'N' \n");
//             sbSql.append("   AND A.USE_YN = 'Y' \n");
//         }

// out_vl.add("fa_Sql", sbSql.toString());
//         //System.out.println(sbSql.toString());
//         pstmt = conn.prepareStatement(sbSql.toString());
//         rs = pstmt.executeQuery();
//         ds_list = this.makeDataSet(rs, "ds_List");
//         rs.close();
//         pstmt.close();

        /**종료**/
        out_dl.add(ds_CrdInfo);
        this.setResultMessage(0, "OK", out_vl);
// [속도개선 Project 시작] 2017. 8. 21. 최범주

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
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체        
        if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
// [속도개선 Project   끝] 2017. 8. 21. 최범주
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
        String sIgnorCtrl   = nullToBlank(in_vl.getString("sIgnorCtrl"));
        //String "+strDate+"      = nullToBlank(in_vl.getString(""+strDate+""));
        //FileLog.println("d:\\aaa.txt", ds_cond);


        //out 데이타
        DataSet ds_list;
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        //본사통합 여신관리 여부
        sbSql.append("SELECT NVL(HEAD_CREDIT_YN,'N') AS HEAD_CREDIT_YN \n");
        sbSql.append("     , MAIN_UPJANG \n");
        sbSql.append("  FROM FMS_UPJANG \n");
        sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");

out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
//		if(! rs.next())
//		{
//			out_vl.add("v_ErrMsg", "여신정보 조회오류...\n관리자에게 연락하세요.");
//		   	this.setResultMessage(0, "OK", out_vl);
//		   	if (true) return;
//		}
        rs.next();
        String sHeadYn = rs.getString("HEAD_CREDIT_YN");
        String sMainUpjang = rs.getString("MAIN_UPJANG");
        rs.close();
        pstmt.close();

        //본사통합인 경우 업장목록을 IN조건으로 만든다.
        String sUpjangList = "";
        if (sHeadYn.equals("Y"))
        {
            sbSql.delete(0,sbSql.length());
            sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
            sbSql.append(" WHERE MAIN_UPJANG = " + sMainUpjang + " \n");
            sbSql.append("   AND HEAD_CREDIT_YN = 'Y' \n");
            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            while (rs.next())
            {
                sUpjangList += ", " + rs.getString("UPJANG");
            }
            sUpjangList = "(" + sUpjangList.substring(1) + ")";
            rs.close();
            pstmt.close();
        }

        //여신체크할 최종 발주일자 조회
        sbSql.delete(0,sbSql.length());
        sbSql.append("SELECT /*+ DRIVING_SITE(HLDC_PO_PR) INDEX_DESC(HLDC_PO_PR PO_PR_I5) */ \n");
        sbSql.append("       NEED_DATE \n");
        sbSql.append("  FROM HLDC_PO_PR \n");
        if (sHeadYn.equals("Y"))
            sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
        else
            sbSql.append(" WHERE RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
        sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n");
        sbSql.append("   AND LINE_STATUS <> '003' --신청취소 \n");
        sbSql.append("   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        String "+strDate+";
        if(rs.next())
            "+strDate+" = rs.getString("NEED_DATE");
        else
            "+strDate+" = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
        rs.close();
        pstmt.close();

        //내역조회(속도관계상 운영율은 적용하지 않는다.)
        sbSql.delete(0,sbSql.length());
        if (sHeadYn.equals("Y"))
        {
            sbSql.append("SELECT NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS \n");//여신회전일
            sbSql.append("     , NVL(B.CREDIT_EXT_DAYS,0) AS CREDIT_EXT_DAYS \n");//여신회전 연장일
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) + NVL(B.CREDIT_EXT_DAYS,0) AS CREDIT_TURN_DAYS_TOT \n");//총 여신회전일
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT \n");//여신금액
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END AS CREDIT_EXT_AMOUNT \n");//여신연장금액
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT \n");//총 여신책정금액
            sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT \n");   //여신한도초과액
            sbSql.append("     , NVL(C.RMN_AMT,0) AS RMN_AMT \n"); //외상매출잔액
            sbSql.append("     , NVL(C1.PRE_AMT,0) AS PRE_AMT \n");//선수잔액
            sbSql.append("     , NVL(D.TR_AMT,0) AS TR_AMT \n"); //매입확정
            sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT \n"); //매입예정(발주)
            sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT \n"); //매입예정(신청)
            sbSql.append("     , NVL(C.RMN_AMT,0) - NVL(C1.PRE_AMT,0) + NVL(D.TR_AMT,0) + NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS BOND_AMT \n"); //채권잔액
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT \n"); //가용여신
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
            sbSql.append("     + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT \n");//실주문가능금액
            sbSql.append("     , NVL(C.L_BILL_DATE,'00000000') AS L_BILL_DATE \n");//최장 미입금된 외상매출발생일
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,'채권없음',TO_CHAR(TO_DATE(C.L_BILL_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"')) AS L_BILL_DATE_DISP \n");//최장 미입금된 외상매출발생일
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,-1,TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(C.L_BILL_DATE,'YYYYMMDD')) AS LAST_TURN_CNT \n");
            sbSql.append("     , A.CREDIT_TURN_CONTROL_YN \n");//'Y'이면 여신회전일통제, 'N'이면 '통제안함'
            sbSql.append("     , A.CREDIT_AMOUNT_CONTROL_YN \n"); //'Y'이면 여신금액통제, 'N'이면 '통제안함'
            sbSql.append("     , A.CREDIT_CONTROL_YN \n"); //여신통제여부
            sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD \n"); //계좌정보
            sbSql.append("  FROM FMS_UPJANG A \n");
            sbSql.append("       --B.여신연장정보 \n");
            sbSql.append("     ,(SELECT SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
            sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
            sbSql.append("         FROM FMS_CREDIT_EXT A \n");
            sbSql.append("        WHERE A.UPJANG = " + sMainUpjang + " \n");
            //sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
            sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
            sbSql.append("          AND A.APPR_YN = 'Y') B \n");
            sbSql.append("       --C.외상잔액정보 \n");
            sbSql.append("     ,(SELECT /*+ LEADING(A B) USE_NL(B) PUSH_PRED(B) PUSH_SUBQ */ SUM((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) AS RMN_AMT \n");
            sbSql.append("            , MIN(A.BILL_DATE) AS L_BILL_DATE \n");
            sbSql.append("         FROM HLDC_FM_BILL A \n");
            sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
            sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
            sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
            sbSql.append("                 AND B.UPJANG IN " + sUpjangList + " \n");
            sbSql.append("               GROUP BY C.BILL_ID) B \n");
            sbSql.append("        WHERE A.BILL_ID = B.BILL_ID(+) \n");
            sbSql.append("          AND A.UPJANG IN " + sUpjangList + " \n");
            sbSql.append("          AND A.BILL_DATE <= GREATEST('" + "+strDate+" + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
            sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
            sbSql.append("          AND A.DCGUBUN = '1' \n");
            sbSql.append("          AND A.ACCTCD = '1110411' \n");
            sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) != 0) C \n");
            sbSql.append("       --C1.선수잔액정보 \n");
            sbSql.append("     ,(SELECT /*+ INDEX(A FM_RECEIPT_I4) */ SUM(A.AMOUNT - NVL(B.USE_AMT,0)) AS PRE_AMT \n");
            //sbSql.append("            , MIN(A.RECEIPT_DATE) AS L_RECEIPT_DATE \n");
            sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
            sbSql.append("            ,(SELECT /*+ LEADING(C B) USE_NL(C B)  */ C.RECEIPT_ID, SUM(C.AMOUNT) AS USE_AMT \n");
            sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
            sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
            sbSql.append("                 AND B.UPJANG IN " + sUpjangList + " \n");
            sbSql.append("               GROUP BY C.RECEIPT_ID) B \n");
            sbSql.append("        WHERE A.RECEIPT_ID = B.RECEIPT_ID(+) \n");
            sbSql.append("          AND A.UPJANG IN " + sUpjangList + " \n");
            sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + "+strDate+" + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
            sbSql.append("          AND A.DCGUBUN = '2' \n");
            sbSql.append("          AND A.ACCTCD = '2110441' \n");
            sbSql.append("          --AND A.GANO > 0 --가상계좌 전표화 시킨 것만 인정하려면 주석제거. \n");
            sbSql.append("          AND (A.AMOUNT - NVL(B.USE_AMT,0)) != 0) C1 \n");
            sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
            sbSql.append("     ,(SELECT SUM(TR_AMT) AS TR_AMT \n");
            sbSql.append("         FROM (SELECT \n");
            //sbSql.append("                      SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                      SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                 FROM FMS_TRANSACTION_V \n");
            sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
            sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
            //sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
            sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
            sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
            sbSql.append("                  AND SGANO = -1 \n");
            sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
            sbSql.append("                UNION ALL \n");
            sbSql.append("               SELECT \n");
            //sbSql.append("                      SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                      SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                 FROM FMS_TRANSACTION_V \n");
            sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + "+strDate+" + "',1,6)||'01' AND '" + "+strDate+" + "' \n");
            sbSql.append("                  AND TRANS_UPJANG IN " + sUpjangList + " \n");
            //sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
            sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
            sbSql.append("                  AND SGANO = -1 \n");
            sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
            sbSql.append("              ) \n");
            sbSql.append("      ) D \n");
            sbSql.append("       --E.당월 미검수 발주금액 \n");
            sbSql.append("     ,(SELECT /*+ USE_CONCAT DRIVING_SITE(A) INDEX(A PO_PO_I8) */ \n");
            sbSql.append("              SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
            sbSql.append("         FROM HLDC_PO_PO A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + "+strDate+" + "' \n");
            sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
            sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
            sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
            sbSql.append("      ) E \n");
            sbSql.append("       --F.당월 미발주 주문금액 \n");
            sbSql.append("     ,(SELECT /*+ NO_EXPAND DRIVING_SITE(A) INDEX(A PO_PR_I5) */ \n");
            sbSql.append("              SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
            sbSql.append("         FROM HLDC_PO_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + "+strDate+" + "' \n");
            sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
            sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
            sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
            sbSql.append("      ) F \n");
            sbSql.append(" WHERE A.UPJANG = " + sMainUpjang + " \n");
            //sbSql.append("   AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            if (! sIgnorCtrl.equals("Y"))
            {
                sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
                sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
            }
        }
        else
        {
            sbSql.append("SELECT NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS \n");//여신회전일
            sbSql.append("     , NVL(B.CREDIT_EXT_DAYS,0) AS CREDIT_EXT_DAYS \n");//여신회전 연장일
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) + NVL(B.CREDIT_EXT_DAYS,0) AS CREDIT_TURN_DAYS_TOT \n");//총 여신회전일
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT \n");//여신금액
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END AS CREDIT_EXT_AMOUNT \n");//여신연장금액
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT \n");//총 여신책정금액
            //sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) AS CREDIT_AMOUNT \n");//여신금액
            //sbSql.append("     , NVL(B.CREDIT_EXT_AMOUNT,0) AS CREDIT_EXT_AMOUNT \n");//여신연장금액
            //sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) AS CREDIT_AMOUNT_TOT \n"); //총 여신책정금액
            sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT \n");//여신한도초과액
            sbSql.append("     , NVL(C.RMN_AMT,0) AS RMN_AMT \n"); //외상매출잔액
            sbSql.append("     , NVL(C1.PRE_AMT,0) AS PRE_AMT \n");//선수잔액
            sbSql.append("     , NVL(D.TR_AMT,0) AS TR_AMT \n"); //매입확정
            sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT \n"); //매입예정(발주)
            sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT \n"); //매입예정(신청)
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT \n"); //가용여신
            sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
            sbSql.append("     + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT \n");//실주문가능금액
            sbSql.append("     , NVL(C.L_BILL_DATE,'00000000') AS L_BILL_DATE \n");//최장 미입금된 외상매출발생일
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,'채권없음',TO_CHAR(TO_DATE(C.L_BILL_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"')) AS L_BILL_DATE_DISP \n");//최장 미입금된 외상매출발생일
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,-1,TO_DATE('" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "','YYYYMMDD') - TO_DATE(C.L_BILL_DATE,'YYYYMMDD')) AS LAST_TURN_CNT \n");
            sbSql.append("     , A.CREDIT_TURN_CONTROL_YN \n");//'Y'이면 여신회전일통제, 'N'이면 '통제안함'
            sbSql.append("     , A.CREDIT_AMOUNT_CONTROL_YN \n"); //'Y'이면 여신금액통제, 'N'이면 '통제안함'
            sbSql.append("     , A.CREDIT_CONTROL_YN \n"); //여신통제여부
            sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD \n"); //계좌정보
            sbSql.append("  FROM FMS_UPJANG A \n");
            sbSql.append("       --B.여신연장정보 \n");
            sbSql.append("     ,(SELECT SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
            sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
            sbSql.append("         FROM FMS_CREDIT_EXT A \n");
            sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
//			sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
            sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
            sbSql.append("          AND A.APPR_YN = 'Y') B \n");
            sbSql.append("       --C.외상잔액정보 \n");
            sbSql.append("     ,(SELECT /*+ LEADING(A B) USE_NL(B) PUSH_PRED(B) PUSH_SUBQ */ SUM((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) AS RMN_AMT \n");
            sbSql.append("            , MIN(A.BILL_DATE) AS L_BILL_DATE \n");
            sbSql.append("         FROM HLDC_FM_BILL A \n");
            sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
            sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
            sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
            sbSql.append("                 AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("               GROUP BY C.BILL_ID) B \n");
            sbSql.append("        WHERE A.BILL_ID = B.BILL_ID(+) \n");
            sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND A.BILL_DATE <= GREATEST('" + "+strDate+" + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
            sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
            sbSql.append("          AND A.DCGUBUN = '1' \n");
            sbSql.append("          AND A.ACCTCD = '1110411' \n");
            sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(B.RCP_AMT,0)) != 0) C \n");
            sbSql.append("       --C1.선수잔액정보 \n");
            sbSql.append("     ,(SELECT /*+ INDEX(A FM_RECEIPT_I4) */ SUM(A.AMOUNT - NVL(B.USE_AMT,0)) AS PRE_AMT \n");
            //sbSql.append("            , MIN(A.RECEIPT_DATE) AS L_RECEIPT_DATE \n");
            sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
            sbSql.append("            ,(SELECT /*+ LEADING(C B) USE_NL(C B)  */ C.RECEIPT_ID, SUM(C.AMOUNT) AS USE_AMT \n");
            sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
            sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
            sbSql.append("                 AND B.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("               GROUP BY C.RECEIPT_ID) B \n");
            sbSql.append("        WHERE A.RECEIPT_ID = B.RECEIPT_ID(+) \n");
            sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + "+strDate+" + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
            sbSql.append("          AND A.DCGUBUN = '2' \n");
            sbSql.append("          AND A.ACCTCD = '2110441' \n");
            sbSql.append("          --AND A.GANO > 0 --가상계좌 전표화 시킨 것만 인정하려면 주석제거. \n");
            sbSql.append("          AND (A.AMOUNT - NVL(B.USE_AMT,0)) != 0) C1 \n");
            sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
            sbSql.append("     ,(SELECT SUM(TR_AMT) AS TR_AMT \n");
            sbSql.append("         FROM (SELECT \n");
            //sbSql.append("                      SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                      SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                 FROM FMS_TRANSACTION_V \n");
            sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
            sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
            //sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
            sbSql.append("                  AND TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
            sbSql.append("                  AND SGANO = -1 \n");
            sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
            sbSql.append("                UNION ALL \n");
            sbSql.append("               SELECT \n");
            //sbSql.append("                      SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                      SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("                 FROM FMS_TRANSACTION_V \n");
            sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + "+strDate+" + "',1,6)||'01' AND '" + "+strDate+" + "' \n");
            //sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
            sbSql.append("                  AND TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
            sbSql.append("                  AND SGANO = -1 \n");
            sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
            sbSql.append("              ) \n");
            sbSql.append("      ) D \n");
            sbSql.append("       --E.당월 미검수 발주금액 \n");
            sbSql.append("     ,(SELECT /*+ USE_CONCAT DRIVING_SITE(A) INDEX(A PO_PO_I8) */ \n");
            sbSql.append("              SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
            sbSql.append("         FROM HLDC_PO_PO A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + "+strDate+" + "' \n");
            sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
            sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
            sbSql.append("      ) E \n");
            sbSql.append("       --F.당월 미발주 주문금액 \n");
            sbSql.append("     ,(SELECT /*+ NO_EXPAND DRIVING_SITE(A) INDEX(A PO_PR_I5) */ \n");
            sbSql.append("              SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
            sbSql.append("         FROM HLDC_PO_PR A \n");
            sbSql.append("        WHERE A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + "+strDate+" + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + "+strDate+" + "' \n");
            sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
            sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
            sbSql.append("      ) F \n");
            sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
            //sbSql.append("   AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            if (! sIgnorCtrl.equals("Y"))
            {
                sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
                sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
            }
        }

out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_List");
        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_list);
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