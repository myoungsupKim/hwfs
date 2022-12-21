
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
        String MU = nullToBlank(ds_input.getString(0, "MU_CD"));
        String TM = nullToBlank(ds_input.getString(0, "TM_CD"));
        String JOB = nullToBlank(ds_input.getString(0, "JOB"));
        String SUB_JOB = nullToBlank(ds_input.getString(0, "SUB_JOB"));
        String UPJANG = nullToBlank(ds_input.getString(0, "UPJANG"));
        String CHECK_SABUN = nullToBlank(ds_input.getString(0, "CHECK_SABUN"));
        String TEAM = nullToBlank(ds_input.getString(0, "TEAM"));
        String LEADER = nullToBlank(ds_input.getString(0, "LEADER"));
        String CNT = nullToBlank(ds_input.getString(0, "CNT"));

        /* String TABLE_TYPE		= in_vl.getString("TABLE_TYPE");
        String FROM				= in_vl.getString("FROM");
        String TO				= in_vl.getString("TO");
        String FORM_CD			= in_vl.getString("FORM_CD");
        String CHECK_TYPE1		= in_vl.getString("CHECK_TYPE1");
        String CHECK_TYPE2		= in_vl.getString("CHECK_TYPE2");
        String CHECK_TYPE3		= in_vl.getString("CHECK_TYPE3");
        String CHECK_TYPE4		= in_vl.getString("CHECK_TYPE4");
        String TM				= in_vl.getString("TM");
        String JOB				= in_vl.getString("JOB");
        String SUB_JOB			= in_vl.getString("SUB_JOB");
        String CHECK_SABUN		= in_vl.getString("CHECK_SABUN");
        String TEAM				= in_vl.getString("TEAM");
        String LEADER			= in_vl.getString("LEADER");
        String UPJANG			= in_vl.getString("UPJANG");
        String CNT				= in_vl.getString("CNT"); */

        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정검양식조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT '-' SHOW, \n");
        sbSql.append("       0 FILTER, \n");
        sbSql.append("		 LRG_CLASS_NAME, \n");
        sbSql.append("       MIDDLE_CLASS_NAME, \n");
        sbSql.append("       CLASS_NAME, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_MARK, \n");
        if (!CNT.equals("0")) {
            sbSql.append("       ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1) SUM_AVG, \n");
            sbSql.append(
                    "       ROUND(DECODE(CHK_MARK,0,0,ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1)/CHK_MARK )*100,2) GET_RATE, \n");
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
        sbSql.append("    SELECT LRG_CLASS_NAME, \n");
        sbSql.append("           MIDDLE_CLASS_NAME, \n");
        sbSql.append("           CLASS_NAME, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_MARK, \n");
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
        sbSql.append("            SELECT LRG_CLASS_NAME, \n");
        sbSql.append("                   MIDDLE_CLASS_NAME, \n");
        sbSql.append("                   CLASS_NAME, \n");
        sbSql.append("                   CHECK_MON, \n");
        sbSql.append("                   CLASS_CD, \n");
        sbSql.append("                   CHK_MARK, \n");
        sbSql.append("                   SUM_POINT, \n");
        sbSql.append("                   CNT_DATE, \n");
        sbSql.append("                   AVG_POINT, \n");
        sbSql.append("                   GET_RATE \n");
        sbSql.append("            FROM   ( \n");
        sbSql.append("                    SELECT  TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            UPJANG, \n");
        sbSql.append("                            CHECK_DATE,                                            --점검일자 \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            --SUBSTR(CHECK_DATE,5,2)||'월' CHECK_MON, \n");
        sbSql.append("                            SUBSTR(CHECK_DATE,5,2) CHECK_MON, \n");
        sbSql.append("                           -- MARK,                                      --(결과)배점 \n");
        sbSql.append("                           -- INDICATE_CNT,                      --지적건수 \n");
        sbSql.append(
                "                           -- CHECK_TYPE,                                            --점검구분(유형) \n");
        sbSql.append("                            LRG_CLASS_NAME , \n");
        sbSql.append("                            MIDDLE_CLASS_NAME , \n");
        sbSql.append("                            CLASS_NAME , \n");
        sbSql.append("                            CHK_MARK,                         --(양식) 배점 \n");
        sbSql.append("                            SUM(POINT) SUM_POINT ,            ----(결과)배점합계 \n");
        sbSql.append("                            COUNT(CHECK_DATE) CNT_DATE,        --평가결과 일수 \n");
        sbSql.append(
                "                            ROUND(SUM(POINT)/COUNT(CHECK_DATE),1)   AVG_POINT,    --월별항목별  결과 평균 \n");
        sbSql.append(
                "                            ROUND(DECODE(NVL(CHK_MARK,0),0,0, ((SUM(POINT)/COUNT(CHECK_DATE))/CHK_MARK) * 100 ),2) GET_RATE  --득점율 \n");
        sbSql.append("                    FROM ( \n");
        sbSql.append("                            SELECT  A.TABLE_TYPE, \n");
        sbSql.append("                                    A.FORM_CD, \n");
        sbSql.append("                                    A.UPJANG, \n");
        sbSql.append("                                    A.CHECK_DATE ALL_CHECK_DATE, \n");
        sbSql.append(
                "                                    SUBSTR(A.CHECK_DATE,1,6) CHECK_DATE,                     --점검일자 \n");
        sbSql.append("                                    A.CLASS_CD, \n");
        sbSql.append(
                "                                    NVL(A.MARK,0) MARK,                                      --(결과)배점 \n");
        sbSql.append(
                "                                    NVL(A.INDICATE_CNT,0) INDICATE_CNT,                      --지적건수 \n");
        sbSql.append(
                "                                    B.CHECK_TYPE,                                            --점검구분(유형) \n");
        sbSql.append("                                    C.LRG_CLASS_NAME , \n");
        sbSql.append("                                    C.MIDDLE_CLASS_NAME , \n");
        sbSql.append("                                    C.CLASS_NAME , \n");
        sbSql.append(
                "                                    GREATEST(NVL(C.MARK_1,0),NVL(C.MARK_2,0),NVL(C.MARK_3,0),NVL(C.MARK_4,0)) CHK_MARK,                         --(양식) 배점 \n");
        //sbSql.append("                                    DECODE(MINUS_YN,'N',NVL(A.MARK,0),NVL(A.MARK,0)*NVL(A.INDICATE_CNT,0)) POINT     --점수(결과배점*지적건수) \n");
        //sbSql.append("                                    --점수(결과배점*지적건수) 지적건수가 없거나 0이면 결과배점으로만처리 \n");
        sbSql.append("                                    NVL(A.SCORE,0) POINT \n");
        sbSql.append("                              FROM FSC_SAFE_RESULT_DTL A, \n");
        sbSql.append("                                   FSC_SAFE_RESULT_MST B, \n");
        sbSql.append("                                   FSC_SAFE_FORM_DTL C, \n");
        sbSql.append(
                "                                   (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042') E, \n");
        sbSql.append("                                   ( \n");
        sbSql.append("                                      SELECT UPJANG \n");
        sbSql.append("                                       FROM   FSA_UPJANG_V \n");
        sbSql.append("                                       WHERE  1=1 \n");

        if (!MU.equals("")) {
            sbSql.append("                                       AND    MU_CD='" + MU + "' \n");
        }
        if (!TM.equals("")) {
            sbSql.append("                                       AND    TM_CD='" + TM + "' \n");
        }
        if (!UPJANG.equals("")) {
            sbSql.append("                                       AND    UPJANG=" + UPJANG + " \n");
        }
        if (!JOB.equals("")) {
            sbSql.append("                                       AND    JOB_CD='" + JOB + "' \n");
        }
        if (!SUB_JOB.equals("")) {
            sbSql.append("                                       AND    SUB_JOB_CD='" + SUB_JOB + "' \n");
        }
        if (!TEAM.equals("")) {
            sbSql.append("                                       AND    SUBTEAM_MST_SABUN='" + TEAM + "' \n");
        }
        if (!LEADER.equals("")) {
            sbSql.append("                                       AND    LEADER_SABUN='" + LEADER + "' \n");
        }
        sbSql.append("                                   ) D \n");
        sbSql.append("                             WHERE A.TABLE_TYPE='" + TABLE_TYPE + "' \n");
        sbSql.append(
                "                               AND SUBSTR(A.CHECK_DATE,1,6) BETWEEN '" + FROM + "' AND '" + TO + "' \n");
        if (!UPJANG.equals("")) {
            sbSql.append("                               AND A.UPJANG=" + UPJANG + "          			-- \n");
        }
        sbSql.append("                               AND A.FORM_CD='" + FORM_CD + "' \n");
        if (CHECK_TYPE1.equals("999") && CHECK_TYPE2.equals("999") && CHECK_TYPE3.equals("999")
                && CHECK_TYPE4.equals("999")) {
            // ****
        } else {
            sbSql.append("                               AND ( B.CHECK_TYPE='" + CHECK_TYPE1 + "'  OR B.CHECK_TYPE='"
                    + CHECK_TYPE2 + "' OR B.CHECK_TYPE='" + CHECK_TYPE3 + "' OR B.CHECK_TYPE='" + CHECK_TYPE4 + "' ) \n");
        }
        sbSql.append("                               AND B.CONFIRM_YN='Y' \n");
        if (!CHECK_SABUN.equals("")) {
            sbSql.append("                               AND B.CHECK_SABUN='" + CHECK_SABUN + "'  	-- \n");
        }
        if (!TEAM.equals("")) {
            sbSql.append("                               AND B.SUBTEAM_MST_SABUN='" + TEAM + "'   	-- \n");
        }
        if (!LEADER.equals("")) {
            sbSql.append("                               AND B.LEADER_SABUN='" + LEADER + "'        -- \n");
        }
        sbSql.append("                               AND A.UPJANG=D.UPJANG \n");
        sbSql.append("                               AND A.TABLE_TYPE=B.TABLE_TYPE \n");
        sbSql.append("                               AND A.CHECK_DATE=B.CHECK_DATE \n");
        sbSql.append("                               AND A.FORM_CD=B.FORM_CD \n");
        sbSql.append("                               AND A.UPJANG=B.UPJANG \n");
        sbSql.append("                               AND A.TABLE_TYPE=C.TABLE_TYPE \n");
        sbSql.append("                               AND A.FORM_CD=C.FORM_CD \n");
        sbSql.append("                               AND A.CLASS_CD=C.CLASS_CD \n");
        //============================================================================================
        //(2012-04-16 수정) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        // 어차피 점수/평균에는 제외되어야 하는데 횟수/부적합 등은 조회안하니 아예 특별점검은 빼고 조회하자.
        //============================================================================================
        sbSql.append("                               AND B.CHECK_TYPE = E.CODE \n");
        sbSql.append("                               AND NVL(E.SET1,'N') = 'N' \n");
        //============================================================================================
        //(2012-04-16 수정) 끝
        //============================================================================================
        //sbSql.append("                            ORDER BY A.CHECK_DATE DESC, A.CLASS_CD \n");
        //	sbSql.append("                          --  TABLE_TYPE	FROM	TO	FORM_CD	CHECK_TYPE1 \n");
        //	sbSql.append("                          --  CHECK_TYPE2	CHECK_TYPE3	TM	JOB	SUB_JOB	 CHECK_SABUN	TEAM	LEADER	UPJANG \n");
        sbSql.append("                        ) \n");
        sbSql.append("                    GROUP BY TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            UPJANG, \n");
        sbSql.append("                            CHECK_DATE, \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            LRG_CLASS_NAME , \n");
        sbSql.append("                            MIDDLE_CLASS_NAME , \n");
        sbSql.append("                            CLASS_NAME , \n");
        sbSql.append("                            CHK_MARK \n");
        sbSql.append("                ) \n");
        sbSql.append("        ) \n");
        sbSql.append("    GROUP BY LRG_CLASS_NAME, \n");
        sbSql.append("           MIDDLE_CLASS_NAME, \n");
        sbSql.append("           CLASS_NAME, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_MARK, \n");
        sbSql.append("           CHECK_MON \n");
        sbSql.append(") \n");
        sbSql.append("GROUP BY LRG_CLASS_NAME, \n");
        sbSql.append("       MIDDLE_CLASS_NAME, \n");
        sbSql.append("       CLASS_NAME, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_MARK \n");
        sbSql.append("UNION ALL \n");
        sbSql.append("SELECT     '+' SHOW, \n");
        sbSql.append("	   1 FILTER, \n");
        sbSql.append("	   LRG_CLASS_NAME, \n");
        sbSql.append("	   MIDDLE_CLASS_NAME, \n");
        sbSql.append("	   '** 소계 **' CLASS_NAME, \n");
        sbSql.append("	   SUBSTR(CLASS_CD,1,6)||'000' CLASS_CD , \n");
        sbSql.append("	   SUM(CHK_MARK) CHK_MARK, \n");
        if (!CNT.equals("0")) {
            sbSql.append("	   SUM(SUM_AVG) SUM_AVG, \n");
            sbSql.append("	   DECODE(SUM(NVL(CHK_MARK,0)),0,0,ROUND(SUM(SUM_AVG)/SUM(CHK_MARK) *100,2)) GET_RATE, \n");
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
        sbSql.append("		 LRG_CLASS_NAME, \n");
        sbSql.append("       MIDDLE_CLASS_NAME, \n");
        sbSql.append("       CLASS_NAME, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_MARK, \n");
        sbSql.append("       ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1) SUM_AVG, \n");
        sbSql.append(
                "       ROUND(DECODE(CHK_MARK,0,0,ROUND(SUM(SUM_POINT)/SUM(CNT_DATE),1)/CHK_MARK )*100,2) GET_RATE, \n");
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
        sbSql.append("    SELECT LRG_CLASS_NAME, \n");
        sbSql.append("           MIDDLE_CLASS_NAME, \n");
        sbSql.append("           CLASS_NAME, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_MARK, \n");
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
        sbSql.append("            SELECT LRG_CLASS_NAME, \n");
        sbSql.append("                   MIDDLE_CLASS_NAME, \n");
        sbSql.append("                   CLASS_NAME, \n");
        sbSql.append("                   CHECK_MON, \n");
        sbSql.append("                   CLASS_CD, \n");
        sbSql.append("                   CHK_MARK, \n");
        sbSql.append("                   SUM_POINT, \n");
        sbSql.append("                   CNT_DATE, \n");
        sbSql.append("                   AVG_POINT, \n");
        sbSql.append("                   GET_RATE \n");
        sbSql.append("            FROM   ( \n");
        sbSql.append("                    SELECT  TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            UPJANG, \n");
        sbSql.append("                            CHECK_DATE,                                            --점검일자 \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            --SUBSTR(CHECK_DATE,5,2)||'월' CHECK_MON, \n");
        sbSql.append("                            SUBSTR(CHECK_DATE,5,2) CHECK_MON, \n");
        sbSql.append("                           -- MARK,                                      --(결과)배점 \n");
        sbSql.append("                           -- INDICATE_CNT,                      --지적건수 \n");
        sbSql.append(
                "                           -- CHECK_TYPE,                                            --점검구분(유형) \n");
        sbSql.append("                            LRG_CLASS_NAME , \n");
        sbSql.append("                            MIDDLE_CLASS_NAME , \n");
        sbSql.append("                            CLASS_NAME , \n");
        sbSql.append("                            CHK_MARK,                         --(양식) 배점 \n");
        sbSql.append("                            SUM(POINT) SUM_POINT ,            ----(결과)배점합계 \n");
        sbSql.append("                            COUNT(CHECK_DATE) CNT_DATE,        --평가결과 일수 \n");
        sbSql.append(
                "                            ROUND(SUM(POINT)/COUNT(CHECK_DATE),1)   AVG_POINT,    --월별항목별  결과 평균 \n");
        sbSql.append(
                "                            ROUND(DECODE(NVL(CHK_MARK,0),0,0, ((SUM(POINT)/COUNT(CHECK_DATE))/CHK_MARK) * 100 ),2) GET_RATE  --득점율 \n");
        sbSql.append("                    FROM ( \n");
        sbSql.append("                            SELECT  A.TABLE_TYPE, \n");
        sbSql.append("                                    A.FORM_CD, \n");
        sbSql.append("                                    A.UPJANG, \n");
        sbSql.append("                                    A.CHECK_DATE ALL_CHECK_DATE, \n");
        sbSql.append(
                "                                    SUBSTR(A.CHECK_DATE,1,6) CHECK_DATE,                     --점검일자 \n");
        sbSql.append("                                    A.CLASS_CD, \n");
        sbSql.append(
                "                                    NVL(A.MARK,0) MARK,                                      --(결과)배점 \n");
        sbSql.append(
                "                                    NVL(A.INDICATE_CNT,0) INDICATE_CNT,                      --지적건수 \n");
        sbSql.append(
                "                                    B.CHECK_TYPE,                                            --점검구분(유형) \n");
        sbSql.append("                                    C.LRG_CLASS_NAME , \n");
        sbSql.append("                                    C.MIDDLE_CLASS_NAME , \n");
        sbSql.append("                                    C.CLASS_NAME , \n");
        sbSql.append(
                "                                    GREATEST(NVL(C.MARK_1,0),NVL(C.MARK_2,0),NVL(C.MARK_3,0),NVL(C.MARK_4,0)) CHK_MARK,                         --(양식) 배점 \n");
        //sbSql.append("                                    DECODE(MINUS_YN,'N',NVL(A.MARK,0),NVL(A.MARK,0)*NVL(A.INDICATE_CNT,0)) POINT     --점수(결과배점*지적건수) \n");
        //sbSql.append("                                    --점수(결과배점*지적건수) 지적건수가 없거나 0이면 결과배점으로만처리 \n");
        sbSql.append("                                    NVL(A.SCORE,0) POINT \n");
        sbSql.append("                              FROM FSC_SAFE_RESULT_DTL A, \n");
        sbSql.append("                                   FSC_SAFE_RESULT_MST B, \n");
        sbSql.append("                                   FSC_SAFE_FORM_DTL C, \n");
        sbSql.append(
                "                                   (SELECT Z.CODE, Z.SET1 FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FS0042') E, \n");
        sbSql.append("                                   ( \n");
        sbSql.append("                                      SELECT UPJANG \n");
        sbSql.append("                                       FROM   FSA_UPJANG_V \n");
        sbSql.append("                                       WHERE  1=1 \n");

        if (!MU.equals("")) {
            sbSql.append("                                       AND    MU_CD='" + MU + "' \n");
        }
        if (!TM.equals("")) {
            sbSql.append("                                       AND    TM_CD='" + TM + "' \n");
        }
        if (!UPJANG.equals("")) {
            sbSql.append("                                       AND    UPJANG=" + UPJANG + " \n");
        }
        if (!JOB.equals("")) {
            sbSql.append("                                       AND    JOB_CD='" + JOB + "' \n");
        }
        if (!SUB_JOB.equals("")) {
            sbSql.append("                                       AND    SUB_JOB_CD='" + SUB_JOB + "' \n");
        }
        if (!TEAM.equals("")) {
            sbSql.append("                                       AND    SUBTEAM_MST_SABUN='" + TEAM + "' \n");
        }
        if (!LEADER.equals("")) {
            sbSql.append("                                       AND    LEADER_SABUN='" + LEADER + "' \n");
        }
        sbSql.append("                                   ) D \n");
        sbSql.append("                             WHERE A.TABLE_TYPE='" + TABLE_TYPE + "' \n");
        sbSql.append(
                "                               AND SUBSTR(A.CHECK_DATE,1,6) BETWEEN '" + FROM + "' AND '" + TO + "' \n");
        if (!UPJANG.equals("")) {
            sbSql.append("                               AND A.UPJANG=" + UPJANG + "          			-- \n");
        }
        sbSql.append("                               AND A.FORM_CD='" + FORM_CD + "' \n");
        if (CHECK_TYPE1.equals("999") && CHECK_TYPE2.equals("999") && CHECK_TYPE3.equals("999")
                && CHECK_TYPE4.equals("999")) {
            // ****
        } else {
            sbSql.append("                               AND ( B.CHECK_TYPE='" + CHECK_TYPE1 + "'  OR B.CHECK_TYPE='"
                    + CHECK_TYPE2 + "' OR B.CHECK_TYPE='" + CHECK_TYPE3 + "' OR B.CHECK_TYPE='" + CHECK_TYPE4 + "' ) \n");
        }
        sbSql.append("                               AND B.CONFIRM_YN='Y' \n");
        if (!CHECK_SABUN.equals("")) {
            sbSql.append("                               AND B.CHECK_SABUN='" + CHECK_SABUN + "'  	-- \n");
        }
        if (!TEAM.equals("")) {
            sbSql.append("                               AND B.SUBTEAM_MST_SABUN='" + TEAM + "'   	-- \n");
        }
        if (!LEADER.equals("")) {
            sbSql.append("                               AND B.LEADER_SABUN='" + LEADER + "'        -- \n");
        }
        sbSql.append("                               AND A.UPJANG=D.UPJANG \n");
        sbSql.append("                               AND A.TABLE_TYPE=B.TABLE_TYPE \n");
        sbSql.append("                               AND A.CHECK_DATE=B.CHECK_DATE \n");
        sbSql.append("                               AND A.FORM_CD=B.FORM_CD \n");
        sbSql.append("                               AND A.UPJANG=B.UPJANG \n");
        sbSql.append("                               AND A.TABLE_TYPE=C.TABLE_TYPE \n");
        sbSql.append("                               AND A.FORM_CD=C.FORM_CD \n");
        sbSql.append("                               AND A.CLASS_CD=C.CLASS_CD \n");
        //============================================================================================
        //(2012-04-16 수정) 시작
        // 박은규 2012-04-16 CSR#(SR201204_09204) 요청자:김희선(건강관리센터)
        // 특별점검 여부 추가 : 결과조회/출력에서 평균점수에서 제외
        // 어차피 점수/평균에는 제외되어야 하는데 횟수/부적합 등은 조회안하니 아예 특별점검은 빼고 조회하자.
        //============================================================================================
        sbSql.append("                               AND B.CHECK_TYPE = E.CODE \n");
        sbSql.append("                               AND NVL(E.SET1,'N') = 'N' \n");
        //============================================================================================
        //(2012-04-16 수정) 끝
        //============================================================================================
        //sbSql.append("                            ORDER BY A.CHECK_DATE DESC, A.CLASS_CD \n");
        //	sbSql.append("                          --  TABLE_TYPE	FROM	TO	FORM_CD	CHECK_TYPE1 \n");
        //	sbSql.append("                          --  CHECK_TYPE2	CHECK_TYPE3	TM	JOB	SUB_JOB	 CHECK_SABUN	TEAM	LEADER	UPJANG \n");
        sbSql.append("                        ) \n");
        sbSql.append("                    GROUP BY TABLE_TYPE, \n");
        sbSql.append("                            FORM_CD, \n");
        sbSql.append("                            UPJANG, \n");
        sbSql.append("                            CHECK_DATE, \n");
        sbSql.append("                            CLASS_CD, \n");
        sbSql.append("                            LRG_CLASS_NAME , \n");
        sbSql.append("                            MIDDLE_CLASS_NAME , \n");
        sbSql.append("                            CLASS_NAME , \n");
        sbSql.append("                            CHK_MARK \n");
        sbSql.append("                ) \n");
        sbSql.append("        ) \n");
        sbSql.append("    GROUP BY LRG_CLASS_NAME, \n");
        sbSql.append("           MIDDLE_CLASS_NAME, \n");
        sbSql.append("           CLASS_NAME, \n");
        sbSql.append("           CLASS_CD, \n");
        sbSql.append("           CHK_MARK, \n");
        sbSql.append("           CHECK_MON \n");
        sbSql.append(") \n");
        sbSql.append("GROUP BY LRG_CLASS_NAME, \n");
        sbSql.append("       MIDDLE_CLASS_NAME, \n");
        sbSql.append("       CLASS_NAME, \n");
        sbSql.append("       CLASS_CD, \n");
        sbSql.append("       CHK_MARK \n");
        sbSql.append(") \n");
        sbSql.append("GROUP BY LRG_CLASS_NAME, \n");
        sbSql.append("               MIDDLE_CLASS_NAME, \n");
        sbSql.append("             --  CLASS_NAME, \n");
        sbSql.append("               SUBSTR(CLASS_CD,1,6) \n");
        sbSql.append("            --   CHK_MARK \n");
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