<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30070E_T001.jsp
■ 프로그램명   : 업장출하율 관리 저장
■ 작성일자     : 2015-07-15
■ 작성자       : 김태윤
■ 이력관리     :
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
        DataSet ds_Cond     = in_dl.get("ds_Cond");
        DataSet ds_List     = in_dl.get("ds_List");// 변경된 데이타

        //입력 파라메터
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        //입력,수정
        for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
        {
            if(ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED){
                sbSql.delete(0, sbSql.length());
                sbSql.append("MERGE INTO MAP_MARGIN_RATE_MGMT A 													\n");
                sbSql.append("USING (SELECT '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' AS YY 			\n");
                sbSql.append("            , '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' AS UPJANG 		\n");
                sbSql.append("            , '" + nullToBlank(ds_Cond.getString(0, "CLASS")) + "' AS CLASS 			\n");
                sbSql.append("         FROM DUAL) B                   												\n");
                sbSql.append("   ON (A.YY     	= B.YY 			AND  										  	    \n");
                sbSql.append("       A.UPJANG   = B.UPJANG 		AND      										    \n");
                sbSql.append("       A.CLASS    = '" + nullToBlank(ds_Cond.getString(0, "CLASS")) + "' )			\n");
                sbSql.append(" WHEN MATCHED THEN                      												\n");
                sbSql.append("      UPDATE                            												\n");
                sbSql.append("         SET A.MM_MARGIN_RATE_01 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_01") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_02 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_02") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_03 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_03") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_04 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_04") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_05 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_05") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_06 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_06") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_07 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_07") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_08 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_08") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_09 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_09") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_10 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_10") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_11 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_11") + "' \n");
                sbSql.append("           , A.MM_MARGIN_RATE_12 = '" + ds_List.getString(iRow, "MM_MARGIN_RATE_12") + "' \n");
                sbSql.append("           , A.UDATE      = SYSDATE 													\n");
                sbSql.append("           , A.UUSER      = '" + g_EmpNo + "' 										\n");
                sbSql.append(" WHEN NOT MATCHED THEN 																\n");
                sbSql.append("      INSERT ( A.UPJANG 																\n");
                sbSql.append("             , A.YY 																	\n");
                sbSql.append("             , A.CLASS	 															\n");
                sbSql.append("             , A.MM_MARGIN_RATE_01 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_02 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_03 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_04 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_05 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_06 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_07 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_08 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_09 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_10 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_11 													\n");
                sbSql.append("             , A.MM_MARGIN_RATE_12 													\n");
                sbSql.append("             , A.CUSER 																\n");
                sbSql.append("             , A.CDATE 																\n");
                sbSql.append("             , A.UUSER 																\n");
                sbSql.append("             , A.UDATE ) 																\n");
                sbSql.append("      VALUES ( '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "' 				\n");
                sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 				\n");
                sbSql.append("             , '" + nullToBlank(ds_Cond.getString(0, "CLASS")) + "'	 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_01") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_02") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_03") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_04") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_05") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_06") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_07") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_08") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_09") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_10") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_11") + "' 				\n");
                sbSql.append("             , '" + ds_List.getString(iRow, "MM_MARGIN_RATE_12") + "' 				\n");
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
            }//END IF
        }// END FOR

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