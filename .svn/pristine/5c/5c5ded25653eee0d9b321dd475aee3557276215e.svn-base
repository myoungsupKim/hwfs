<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 메뉴관리/위생관리
■ 프로그램ID   : FSC00020E_T001.jsp
■ 프로그램명   : 정검결과등록 - 신규등록(신규정보조회)
■ 작성일자     : 2008-03-20
■ 작성자       : 박지영
■ 이력관리     : 2008-03-20
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_input     = in_dl.get("ds_input");

        String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
        String strTableType		= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
          String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
          String strTableTypeNm	= nullToBlank(ds_input.getString(0, "TABLE_TYPE_NM"));
          String strFormCDNm 		= nullToBlank(ds_input.getString(0, "FORM_NAME"));


        //out 데이타
        DataSet ds_list1;
        DataSet ds_list2;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 정보
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.UPJANG \n");
        sbSql.append("     , (SELECT UPJANGNM FROM MAC_UPJANG_V WHERE UPJANG = " + strUpjang + " ) AS UPJANGNM \n");
        sbSql.append("     , C.TM_CD \n");
        sbSql.append("     , C.TM_NM \n");
        sbSql.append("     , A.TEAM_MST_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM \n");
        sbSql.append("     , A.SUBTEAM_MST_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM \n");
        sbSql.append("     , A.LEADER_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.LEADER_SABUN) AS LEADER_NM \n");
        sbSql.append("     , A.CHARGE_SABUN \n");
        sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM \n");
        sbSql.append("     , (CASE WHEN B.PER_DTA IS NULL AND B.PER_DTB IS NULL THEN \n");
        sbSql.append("                    '' \n");
        sbSql.append("             ELSE \n");
        sbSql.append("                    SCC_KUNSOK_YMD_FUN(DECODE(B.PER_DTA,NULL,B.PER_DTB,B.PER_DTA), TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
        sbSql.append("        END)    AS KUNSOK \n");
        sbSql.append("     , A.OPEN_DATE \n");
        sbSql.append("     , A.PERMISSION_TYPE \n");
        sbSql.append("     , FSC_COMMA_NAME_FUN(A.PERMISSION_TYPE, 'MA0004') AS PERMISSION_TYPE_NM \n");
        sbSql.append("     , (SELECT COUNT(1) AS CNT FROM SCO_FS_HR_PERSONAL_V L,HLDC_ST_UPJANG M WHERE L.DEPT_ID = M.DEPT_ID AND M.UPJANG = A.UPJANG AND L.GB_JAEJIK IN ('AA', 'CA') AND L.PER_DTD IS NULL) AS PERSON_CNT \n");
        sbSql.append("     , A.DIST_TYPE \n");
        sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0005' AND CODE =A.DIST_TYPE) AS DIST_TYPE_NM \n");
        sbSql.append("     , D.AVG_MEAL_QTY \n");
        sbSql.append("     , D.MEAL_CNT \n");
        sbSql.append("     , D.MENU_CNT \n");
        sbSql.append("     , DECODE(A.WATER_GUBUN,'001','지하수','002','상수도','') WATER_IRRIGATION\n");
        sbSql.append("     , C.TM_NM || ' ' || (SELECT UPJANGNM FROM MAC_UPJANG_V WHERE UPJANG = " + strUpjang + " ) AS UPJANGNM2 \n");
        sbSql.append("     , '" + strTableType + "' AS TABLE_TYPE\n");
        sbSql.append("     , '" + strFormCD + "' AS FORM_CD\n");
        sbSql.append("     , '" + strTableTypeNm + "' AS TABLE_TYPE_NM\n");
        sbSql.append("     , '" + strFormCDNm + "' AS FORM_NAME\n");
        sbSql.append("  FROM SCO_UPJANG_MST_V A \n");
        sbSql.append("     , HLDC_HR_PERSONAL B \n");
        sbSql.append("     , ( \n");
        sbSql.append("         SELECT TM_CD \n");
        sbSql.append("              , TM_NM \n");
        sbSql.append("           FROM HLDC_ST_UPJANG A \n");
        sbSql.append("              , HLDC_SC_DEPT_V B \n");
        sbSql.append("          WHERE A.DEPT_ID = B.DEPT_ID \n");
        sbSql.append("            AND B.FS_UPJANG = 'Y' \n");
        sbSql.append("            AND A.UPJANG = " + strUpjang + " \n");
        sbSql.append("       ) C \n");
        sbSql.append("     , ( \n");
        sbSql.append("          SELECT SUM(AVG_MEAL_QTY) AS AVG_MEAL_QTY \n");
        sbSql.append("               , COUNT(DISTINCT MEAL) AS MEAL_CNT \n");
        sbSql.append("               , COUNT(DISTINCT HALL_CD || MEAL || CORNER) AS MENU_CNT \n");
        sbSql.append("            FROM FSA_HALL_DTL \n");
        sbSql.append("           WHERE UPJANG = " + strUpjang + " \n");
        sbSql.append("             AND USE_YN = 'Y' \n");
        sbSql.append("       ) D \n");
        sbSql.append(" WHERE (A.UPJANG       = " + strUpjang + ") \n");
        sbSql.append("   AND (A.CHARGE_SABUN = B.SABUN(+)) \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list1 = this.makeDataSet(rs, "ds_list1");

        rs.close();
        pstmt.close();

        // 평가항목
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT A.TABLE_TYPE \n");
        sbSql.append("     , A.FORM_CD \n");
        sbSql.append("     , A.CLASS_CD \n");
        sbSql.append("     , A.LRG_CLASS_CD \n");
        sbSql.append("     , A.LRG_CLASS_NAME \n");
        sbSql.append("     , A.MIDDLE_CLASS_CD \n");
        sbSql.append("     , A.MIDDLE_CLASS_NAME \n");
        sbSql.append("     , A.CLASS_NAME \n");
        sbSql.append("     , A.MARK_1 \n");
        sbSql.append("     , A.MARK_2 \n");
        sbSql.append("     , A.MARK_3 \n");
        sbSql.append("     , A.MARK_4 \n");
        sbSql.append("     , A.MINUS_YN \n");
        sbSql.append("     , A.NOT_FIT_YN \n");
        sbSql.append("     , GREATEST(NVL(A.MARK_1,-999), NVL(A.MARK_2,-999), NVL(A.MARK_3,-999), NVL(A.MARK_4,-999)) MAX_MARK \n");
        sbSql.append("     , LEAST(NVL(A.MARK_1,999), NVL(A.MARK_2,999), NVL(A.MARK_3,999), NVL(A.MARK_4,999)) MIN_MARK \n");
        sbSql.append("     , " + strUpjang + " AS UPJANG \n");
        sbSql.append("     , 0 AS INDICATE_CNT \n");
        sbSql.append("  FROM FSC_SAFE_FORM_DTL A \n");
        sbSql.append(" WHERE A.TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("   AND A.FORM_CD = '" + strFormCD + "' \n");
        sbSql.append("ORDER BY A.CLASS_CD \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list2 = this.makeDataSet(rs, "ds_list2");

        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_list1);
        out_dl.add(ds_list2);
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