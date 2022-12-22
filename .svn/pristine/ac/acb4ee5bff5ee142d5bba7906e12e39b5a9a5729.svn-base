
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 메뉴관리/위생관리
    ■ 프로그램ID   : FSC00090V_S001.jsp
    ■ 프로그램명   : 항목별 득점율 관리
    ■ 작성일자     : 2008-03-20
    ■ 작성자       : 박지영
    ■ 이력관리     : 2008-03-20
    : 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
    특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
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
        DataSet ds_input = in_dl.get("ds_input");

        //입력 데이타
        String TABLE_TYPE = nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
        String FROM = nullToBlank(ds_input.getString(0, "FROM"));
        String TO = nullToBlank(ds_input.getString(0, "TO"));
        String FORM_CD = nullToBlank(ds_input.getString(0, "FORM_CD"));
        String CHECK_TYPE1 = nullToBlank(ds_input.getString(0, "CHECK_TYPE1"));
        String CHECK_TYPE2 = nullToBlank(ds_input.getString(0, "CHECK_TYPE2"));
        String CHECK_TYPE3 = nullToBlank(ds_input.getString(0, "CHECK_TYPE3"));
        String CHECK_TYPE4 = nullToBlank(ds_input.getString(0, "CHECK_TYPE4"));
        String CUSTCD = nullToBlank(ds_input.getString(0, "CUSTCD"));
        String CHECK_SABUN = nullToBlank(ds_input.getString(0, "CHECK_SABUN"));
        String CNT = nullToBlank(ds_input.getString(0, "CNT"));

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT '-' SHOW, \n");
        sbSql.append("       0 FILTER, \n");
        sbSql.append("		 HL_CLASS_NM AS LRG_CLASS_NAME, \n");
        sbSql.append("       HM_CLASS_NM AS MIDDLE_CLASS_NAME, \n");
        sbSql.append("       CLASS_NM AS CLASS_NAME, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_SCORE AS CHK_MARK, \n");
        if (!CNT.equals("0")) {
            sbSql.append("       ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1) SUM_AVG, \n");
            sbSql.append(
                    "       ROUND(DECODE(CHK_SCORE,0,0,ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1)/CHK_SCORE )*100,2) GET_RATE, \n");
        } else {
            sbSql.append("       0 SUM_AVG, \n");
            sbSql.append("       0 GET_RATE, \n");
        }
        sbSql.append("       MAX(AVG_POINT01) AVG01, \n");
        sbSql.append("       MAX(AVG_POINT02) AVG02, \n");
        sbSql.append("       MAX(AVG_POINT03) AVG03, \n");
        sbSql.append("       MAX(AVG_POINT04) AVG04, \n");
        sbSql.append("       MAX(AVG_POINT05) AVG05, \n");
        sbSql.append("       MAX(AVG_POINT06) AVG06, \n");
        sbSql.append("       MAX(AVG_POINT07) AVG07, \n");
        sbSql.append("       MAX(AVG_POINT08) AVG08, \n");
        sbSql.append("       MAX(AVG_POINT09) AVG09, \n");
        sbSql.append("       MAX(AVG_POINT10) AVG10, \n");
        sbSql.append("       MAX(AVG_POINT11) AVG11, \n");
        sbSql.append("       MAX(AVG_POINT12) AVG12 \n");
        sbSql.append("FROM \n");
        sbSql.append("( \n");
        sbSql.append("    SELECT HL_CLASS_NM, \n");
        sbSql.append("           HM_CLASS_NM, \n");
        sbSql.append("           CLASS_NM, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_SCORE, \n");
        sbSql.append("           SUM(SUM_POINT) SUM_POINT, \n");
        sbSql.append("           SUM(CNT_DATE) CNT_DATE, \n");
        sbSql.append("           DECODE(CHECK_MON,'01',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT01, \n");
        sbSql.append("           DECODE(CHECK_MON,'02',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT02, \n");
        sbSql.append("           DECODE(CHECK_MON,'03',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT03, \n");
        sbSql.append("           DECODE(CHECK_MON,'04',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT04, \n");
        sbSql.append("           DECODE(CHECK_MON,'05',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT05, \n");
        sbSql.append("           DECODE(CHECK_MON,'06',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT06, \n");
        sbSql.append("           DECODE(CHECK_MON,'07',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT07, \n");
        sbSql.append("           DECODE(CHECK_MON,'08',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT08, \n");
        sbSql.append("           DECODE(CHECK_MON,'09',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT09, \n");
        sbSql.append("           DECODE(CHECK_MON,'10',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT10, \n");
        sbSql.append("           DECODE(CHECK_MON,'11',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT11, \n");
        sbSql.append("           DECODE(CHECK_MON,'12',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT12 \n");
        sbSql.append("    FROM ( \n");
        sbSql.append("            SELECT HL_CLASS_NM, \n");
        sbSql.append("                   HM_CLASS_NM, \n");
        sbSql.append("                   CLASS_NM, \n");
        sbSql.append("                   CHECK_MON, \n");
        sbSql.append("                   CLASS_CD, \n");
        sbSql.append("                   CHK_SCORE, \n");
        sbSql.append("                   SUM_POINT, \n");
        sbSql.append("                   CNT_DATE, \n");
        sbSql.append("                   AVG_POINT, \n");
        sbSql.append("                   GET_RATE \n");
        sbSql.append("            FROM   ( \n");
        sbSql.append("                    SELECT  TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            CUSTCD, \n");
        sbSql.append("                            CHK_DD,                                            --점검일자 \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            SUBSTR(CHK_DD,5,2) CHECK_MON, \n");
        sbSql.append("                            HL_CLASS_NM , \n");
        sbSql.append("                            HM_CLASS_NM , \n");
        sbSql.append("                            CLASS_NM , \n");
        sbSql.append("                            CHK_SCORE,                         --(양식) 배점 \n");
        sbSql.append("                            SUM(POINT) SUM_POINT ,            ----(결과)배점합계 \n");
        sbSql.append("                            COUNT(CHK_DD) CNT_DATE,        --평가결과 일수 \n");
        sbSql.append("                            ROUND(SUM(POINT)/COUNT(CHK_DD),1)   AVG_POINT,    --월별항목별  결과 평균 \n");
        sbSql.append("                            ROUND(DECODE(NVL(CHK_SCORE,0),0,0, ((SUM(POINT)/COUNT(CHK_DD))/CHK_SCORE) * 100 ),2) GET_RATE  --득점율 \n");
        sbSql.append("                    FROM ( \n");
        sbSql.append("                            SELECT  A.TABLE_TYPE, \n");
        sbSql.append("                                    A.FORM_CD, \n");
        sbSql.append("                                    A.CUSTCD, \n");
        sbSql.append("                                    A.CHK_DD ALL_CHK_DD, \n");
        sbSql.append("                                    SUBSTR(A.CHK_DD,1,6) CHK_DD,                     --점검일자 \n");
        sbSql.append("                                    A.CLASS_CD, \n");
        sbSql.append("                                    B.CHK_CLASS,                                            --점검구분(유형) \n");
        sbSql.append("                                    C.HL_CLASS_NM , \n");
        sbSql.append("                                    C.HM_CLASS_NM , \n");
        sbSql.append("                                    C.CLASS_NM , \n");
        sbSql.append("                                    A.CHK_IDCTR AS CHK_SCORE,                         --(양식) 배점 \n");
        //sbSql.append("                                    DECODE(MINUS_YN,'N',NVL(A.MARK,0),NVL(A.MARK,0)*NVL(A.INDICATE_CNT,0)) POINT     --점수(결과배점*지적건수) \n");
        //sbSql.append("                                    --점수(결과배점*지적건수) 지적건수가 없거나 0이면 결과배점으로만처리 \n");
        sbSql.append("                                    NVL(A.CHK_SCORE,0) POINT \n");
        sbSql.append("                              FROM FSC_CONTRT_RESULT_DTL A, \n");
        sbSql.append("                                   FSC_CONTRT_RESULT B, \n");
        sbSql.append("                                   FSC_CONTRT_FORM_DTL C, \n");
        sbSql.append("                                   (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0102') E \n");
        sbSql.append("                             WHERE A.TABLE_TYPE='" + TABLE_TYPE + "' \n");
        sbSql.append("                               AND SUBSTR(A.CHK_DD,1,6) BETWEEN '" + FROM + "' AND '" + TO + "' \n");
        sbSql.append("                                   AND A.FORM_CD='" + FORM_CD + "' \n");
        sbSql.append("                                   AND B.CONFIRM_YN='Y' \n");
        
        if (!CUSTCD.equals("")) {
            sbSql.append("                               AND A.CUSTCD=" + CUSTCD + "          			-- \n");
        }
        
        if (CHECK_TYPE1.equals("99") && CHECK_TYPE2.equals("99") && CHECK_TYPE3.equals("99") && CHECK_TYPE4.equals("99")) {
        } else {
            sbSql.append("                               AND ( B.CHK_CLASS='" + CHECK_TYPE1 + "'  OR B.CHK_CLASS='" + CHECK_TYPE2 + "' OR B.CHK_CLASS='" + CHECK_TYPE3 + "' OR B.CHK_CLASS='" + CHECK_TYPE4 + "' ) \n");
        }

        if (!CHECK_SABUN.equals("")) {
            sbSql.append("                               AND B.INSPECTOR='" + CHECK_SABUN + "'  	-- \n");
        }

        sbSql.append("                               AND A.TABLE_TYPE=B.TABLE_TYPE \n");
        sbSql.append("                               AND A.CHK_DD=B.CHK_DD \n");
        sbSql.append("                               AND A.FORM_CD=B.FORM_CD \n");
        sbSql.append("                               AND A.CUSTCD=B.CUSTCD \n");
        sbSql.append("                               AND A.TABLE_TYPE=C.TABLE_TYPE \n");
        sbSql.append("                               AND A.FORM_CD=C.FORM_CD \n");
        sbSql.append("                               AND A.CLASS_CD=C.CLASS_CD \n");
        //============================================================================================
        //(2012-04-16 수정) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        // 어차피 점수/평균에는 제외되어야 하는데 횟수/부적합 등은 조회안하니 아예 특별점검은 빼고 조회하자.
        //============================================================================================
        sbSql.append("                               AND B.CHK_CLASS = E.CODE \n");
        sbSql.append("                               AND NVL(E.SET1,'N') = 'N' \n");
        //============================================================================================
        //(2012-04-16 수정) 끝
        //============================================================================================
        sbSql.append("                        ) \n");
        sbSql.append("                    GROUP BY TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            CUSTCD, \n");
        sbSql.append("                            CHK_DD, \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            HL_CLASS_NM , \n");
        sbSql.append("                            HM_CLASS_NM , \n");
        sbSql.append("                            CLASS_NM , \n");
        sbSql.append("                            CHK_SCORE \n");
        sbSql.append("                ) \n");
        sbSql.append("        ) \n");
        sbSql.append("    GROUP BY HL_CLASS_NM, \n");
        sbSql.append("           HM_CLASS_NM, \n");
        sbSql.append("           CLASS_NM, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_SCORE, \n");
        sbSql.append("           CHECK_MON \n");
        sbSql.append(") \n");
        sbSql.append("GROUP BY HL_CLASS_NM, \n");
        sbSql.append("       HM_CLASS_NM, \n");
        sbSql.append("       CLASS_NM, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_SCORE \n");
        sbSql.append("UNION ALL \n");
        sbSql.append("SELECT     '+' SHOW, \n");
        sbSql.append("	   1 FILTER, \n");
        sbSql.append("	   HL_CLASS_NM, \n");
        sbSql.append("	   HM_CLASS_NM, \n");
        sbSql.append("	   '** 소계 **' CLASS_NM, \n");
        sbSql.append("	   SUBSTR(CLASS_CD,1,6)||'000' CLASS_CD , \n");
        sbSql.append("	   SUM(CHK_SCORE) CHK_SCORE, \n");
        if (!CNT.equals("0")) {
            sbSql.append("	   SUM(SUM_AVG) SUM_AVG, \n");
            sbSql.append("	   DECODE(SUM(NVL(CHK_SCORE,0)),0,0,ROUND(SUM(SUM_AVG)/SUM(CHK_SCORE) *100,2)) GET_RATE, \n");
        } else {
            sbSql.append("	   0 SUM_AVG, \n");
            sbSql.append("	   0 GET_RATE, \n");
        }
        sbSql.append("	   SUM(AVG01) AVG01, \n");
        sbSql.append("	   SUM(AVG02) AVG02, \n");
        sbSql.append("	   SUM(AVG03) AVG03, \n");
        sbSql.append("	   SUM(AVG04) AVG04, \n");
        sbSql.append("	   SUM(AVG05) AVG05, \n");
        sbSql.append("	   SUM(AVG06) AVG06, \n");
        sbSql.append("	   SUM(AVG07) AVG07, \n");
        sbSql.append("	   SUM(AVG08) AVG08, \n");
        sbSql.append("	   SUM(AVG09) AVG09, \n");
        sbSql.append("	   SUM(AVG10) AVG10, \n");
        sbSql.append("	   SUM(AVG11) AVG11, \n");
        sbSql.append("	   SUM(AVG12) AVG12 \n");
        sbSql.append("FROM \n");
        sbSql.append("( \n");
        sbSql.append("SELECT '+' SHOW, \n");
        sbSql.append("       0 FILTER, \n");
        sbSql.append("		 HL_CLASS_NM, \n");
        sbSql.append("       HM_CLASS_NM, \n");
        sbSql.append("       CLASS_NM, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_SCORE, \n");
        sbSql.append("       ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1) SUM_AVG, \n");
        sbSql.append("       ROUND(DECODE(CHK_SCORE,0,0,ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1)/CHK_SCORE )*100,2) GET_RATE, \n");
        sbSql.append("       MAX(AVG_POINT01) AVG01, \n");
        sbSql.append("       MAX(AVG_POINT02) AVG02, \n");
        sbSql.append("       MAX(AVG_POINT03) AVG03, \n");
        sbSql.append("       MAX(AVG_POINT04) AVG04, \n");
        sbSql.append("       MAX(AVG_POINT05) AVG05, \n");
        sbSql.append("       MAX(AVG_POINT06) AVG06, \n");
        sbSql.append("       MAX(AVG_POINT07) AVG07, \n");
        sbSql.append("       MAX(AVG_POINT08) AVG08, \n");
        sbSql.append("       MAX(AVG_POINT09) AVG09, \n");
        sbSql.append("       MAX(AVG_POINT10) AVG10, \n");
        sbSql.append("       MAX(AVG_POINT11) AVG11, \n");
        sbSql.append("       MAX(AVG_POINT12) AVG12 \n");
        sbSql.append("FROM \n");
        sbSql.append("( \n");
        sbSql.append("    SELECT HL_CLASS_NM, \n");
        sbSql.append("           HM_CLASS_NM, \n");
        sbSql.append("           CLASS_NM, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_SCORE, \n");
        sbSql.append("           SUM(SUM_POINT) SUM_POINT, \n");
        sbSql.append("           SUM(CNT_DATE) CNT_DATE, \n");
        sbSql.append("           DECODE(CHECK_MON,'01',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT01, \n");
        sbSql.append("           DECODE(CHECK_MON,'02',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT02, \n");
        sbSql.append("           DECODE(CHECK_MON,'03',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT03, \n");
        sbSql.append("           DECODE(CHECK_MON,'04',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT04, \n");
        sbSql.append("           DECODE(CHECK_MON,'05',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT05, \n");
        sbSql.append("           DECODE(CHECK_MON,'06',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT06, \n");
        sbSql.append("           DECODE(CHECK_MON,'07',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT07, \n");
        sbSql.append("           DECODE(CHECK_MON,'08',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT08, \n");
        sbSql.append("           DECODE(CHECK_MON,'09',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT09, \n");
        sbSql.append("           DECODE(CHECK_MON,'10',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT10, \n");
        sbSql.append("           DECODE(CHECK_MON,'11',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT11, \n");
        sbSql.append("           DECODE(CHECK_MON,'12',ROUND(AVG(AVG_POINT),1),0,NULL) AVG_POINT12 \n");
        sbSql.append("    FROM ( \n");
        sbSql.append("            SELECT HL_CLASS_NM, \n");
        sbSql.append("                   HM_CLASS_NM, \n");
        sbSql.append("                   CLASS_NM, \n");
        sbSql.append("                   CHECK_MON, \n");
        sbSql.append("                   CLASS_CD, \n");
        sbSql.append("                   CHK_SCORE, \n");
        sbSql.append("                   SUM_POINT, \n");
        sbSql.append("                   CNT_DATE, \n");
        sbSql.append("                   AVG_POINT, \n");
        sbSql.append("                   GET_RATE \n");
        sbSql.append("            FROM   ( \n");
        sbSql.append("                    SELECT  TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            CUSTCD, \n");
        sbSql.append("                            CHK_DD,                                            --점검일자 \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            SUBSTR(CHK_DD,5,2) CHECK_MON, \n");
        sbSql.append("                            HL_CLASS_NM , \n");
        sbSql.append("                            HM_CLASS_NM , \n");
        sbSql.append("                            CLASS_NM , \n");
        sbSql.append("                            CHK_SCORE,                         --(양식) 배점 \n");
        sbSql.append("                            SUM(POINT) SUM_POINT ,            ----(결과)배점합계 \n");
        sbSql.append("                            COUNT(CHK_DD) CNT_DATE,        --평가결과 일수 \n");
        sbSql.append("                            ROUND(SUM(POINT)/COUNT(CHK_DD),1)   AVG_POINT,    --월별항목별  결과 평균 \n");
        sbSql.append("                            ROUND(DECODE(NVL(CHK_SCORE,0),0,0, ((SUM(POINT)/COUNT(CHK_DD))/CHK_SCORE) * 100 ),2) GET_RATE  --득점율 \n");
        sbSql.append("                    FROM ( \n");
        sbSql.append("                            SELECT  A.TABLE_TYPE, \n");
        sbSql.append("                                    A.FORM_CD, \n");
        sbSql.append("                                    A.CUSTCD, \n");
        sbSql.append("                                    A.CHK_DD ALL_CHK_DD, \n");
        sbSql.append("                                    SUBSTR(A.CHK_DD,1,6) CHK_DD,                     --점검일자 \n");
        sbSql.append("                                    A.CLASS_CD, \n");
        sbSql.append("                                    B.CHK_CLASS,                                            --점검구분(유형) \n");
        sbSql.append("                                    C.HL_CLASS_NM , \n");
        sbSql.append("                                    C.HM_CLASS_NM , \n");
        sbSql.append("                                    C.CLASS_NM , \n");
        sbSql.append("                                    A.CHK_IDCTR AS CHK_SCORE,                         --(양식) 배점 \n");
        //sbSql.append("                                    DECODE(MINUS_YN,'N',NVL(A.MARK,0),NVL(A.MARK,0)*NVL(A.INDICATE_CNT,0)) POINT     --점수(결과배점*지적건수) \n");
        //sbSql.append("                                    --점수(결과배점*지적건수) 지적건수가 없거나 0이면 결과배점으로만처리 \n");
        sbSql.append("                                    NVL(A.CHK_SCORE,0) POINT \n");
        sbSql.append("                              FROM FSC_CONTRT_RESULT_DTL A, \n");
        sbSql.append("                                   FSC_CONTRT_RESULT B, \n");
        sbSql.append("                                   FSC_CONTRT_FORM_DTL C, \n");
        sbSql.append("                                   (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0102') E \n");
        sbSql.append("                             WHERE A.TABLE_TYPE='" + TABLE_TYPE + "' \n");
        sbSql.append("                               AND SUBSTR(A.CHK_DD,1,6) BETWEEN '" + FROM + "' AND '" + TO + "' \n");
        
        if (!CUSTCD.equals("")) {
            sbSql.append("                               AND A.CUSTCD=" + CUSTCD + "          			-- \n");
        }
        
        sbSql.append("                                   AND A.FORM_CD='" + FORM_CD + "' \n");
        
        if (CHECK_TYPE1.equals("99") && CHECK_TYPE2.equals("99") && CHECK_TYPE3.equals("99") && CHECK_TYPE4.equals("99")) {
        } else {
            sbSql.append("                               AND ( B.CHK_CLASS='" + CHECK_TYPE1 + "'  OR B.CHK_CLASS='" + CHECK_TYPE2 + "' OR B.CHK_CLASS='" + CHECK_TYPE3 + "' OR B.CHK_CLASS='" + CHECK_TYPE4 + "' ) \n");
        }
        
        sbSql.append("                                   AND B.CONFIRM_YN='Y' \n");
        
        if (!CHECK_SABUN.equals("")) {
            sbSql.append("                               AND B.INSPECTOR='" + CHECK_SABUN + "'  	-- \n");
        }

        sbSql.append("                               AND A.TABLE_TYPE=B.TABLE_TYPE \n");
        sbSql.append("                               AND A.CHK_DD=B.CHK_DD \n");
        sbSql.append("                               AND A.FORM_CD=B.FORM_CD \n");
        sbSql.append("                               AND A.CUSTCD=B.CUSTCD \n");
        sbSql.append("                               AND A.TABLE_TYPE=C.TABLE_TYPE \n");
        sbSql.append("                               AND A.FORM_CD=C.FORM_CD \n");
        sbSql.append("                               AND A.CLASS_CD=C.CLASS_CD \n");
        //============================================================================================
        //(2012-04-16 수정) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        // 어차피 점수/평균에는 제외되어야 하는데 횟수/부적합 등은 조회안하니 아예 특별점검은 빼고 조회하자.
        //============================================================================================
        sbSql.append("                               AND B.CHK_CLASS = E.CODE \n");
        sbSql.append("                               AND NVL(E.SET1,'N') = 'N' \n");
        //============================================================================================
        //(2012-04-16 수정) 끝
        //============================================================================================
        sbSql.append("                        ) \n");
        sbSql.append("                    GROUP BY TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            CUSTCD, \n");
        sbSql.append("                            CHK_DD, \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            HL_CLASS_NM , \n");
        sbSql.append("                            HM_CLASS_NM , \n");
        sbSql.append("                            CLASS_NM , \n");
        sbSql.append("                            CHK_SCORE \n");
        sbSql.append("                ) \n");
        sbSql.append("        ) \n");
        sbSql.append("    GROUP BY HL_CLASS_NM, \n");
        sbSql.append("           HM_CLASS_NM, \n");
        sbSql.append("           CLASS_NM, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_SCORE, \n");
        sbSql.append("           CHECK_MON \n");
        sbSql.append(") \n");
        sbSql.append("GROUP BY HL_CLASS_NM, \n");
        sbSql.append("       HM_CLASS_NM, \n");
        sbSql.append("       CLASS_NM, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_SCORE \n");
        sbSql.append(") \n");
        sbSql.append("GROUP BY HL_CLASS_NM, \n");
        sbSql.append("               HM_CLASS_NM, \n");
        sbSql.append("             --  CLASS_NM, \n");
        sbSql.append("               SUBSTR(CLASS_CD,1,6) \n");
        sbSql.append("            --   CHK_SCORE \n");
        sbSql.append("ORDER BY CLASS_CD \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_list");

        /**종료**/
        out_dl.add(ds_list);
        this.setResultMessage(0, "OK", out_vl);

    } catch (Exception ex) {
        ex.printStackTrace();
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
    }

    proc_output(response, out, out_vl, out_dl);
%>