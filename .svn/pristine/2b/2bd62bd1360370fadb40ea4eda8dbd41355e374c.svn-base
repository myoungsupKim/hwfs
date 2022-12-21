
<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : 사업계획관리
    ■ 프로그램ID   : MAP30010E_T003.jsp
    ■ 프로그램명   : 사업계획 노무비 전송
    ■ 작성일자     : 2015-06-10
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
        //DataSet ds_Man      = in_dl.get("ds_Man"); // FC -> BPC로 조리직 인건비 데이타

        //입력 파라메터
        String g_Upjang = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));

        //FileLog.println("d:\\b.txt", ds_List);
        //FileLog.println("d:\\a.txt", ds_List_ALL);

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        //입력,수정
        //for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
        //{
        sbSql.delete(0, sbSql.length());
        sbSql.append("      UPDATE MAP_BIZ_LOG_MGMT                           								\n");
        sbSql.append("         SET CONFIRM_YN = '" + "Y" + "' 												\n");
        sbSql.append("           , ORGIN_YN = '" + "N" + "' 												\n");
        sbSql.append("           , UDATE      = SYSDATE 													\n");
        sbSql.append("           , UUSER      = '" + g_EmpNo + "' 											\n");
        sbSql.append("       WHERE UPJANG     = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'		\n");
        sbSql.append("         AND YY     	  = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
        sbSql.append("         AND BIZ_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");

        out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();
        //}// END FOR

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