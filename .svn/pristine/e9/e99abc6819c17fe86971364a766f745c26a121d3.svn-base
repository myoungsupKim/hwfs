<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30100E_T002.jsp
■ 프로그램명   : 사업계획 이력관리
■ 작성일자     : 2015-07-10
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
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_BizGbn     = nullToBlank(ds_Cond.getString(0, "BIZ_GBN"));

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        for ( int iRow = 0 ; iRow < ds_List.getRowCount() ; iRow++ )
        {
            if(ds_List.getRowType(iRow) == DataSet.ROW_TYPE_UPDATED){

                // 사업계획 만 업데이트(원본, _최종 업데이트).
                if("0".equals(g_BizGbn)){

                    //if(Integer.parseInt(ds_List.getString(iRow, "CHK")) ==  1) {

                    sbSql.delete(0, sbSql.length());
                    sbSql.append("      UPDATE MAP_BIZ_LOG_MGMT                           													\n");
                    sbSql.append("         SET CONFIRM_YN = DECODE('" + ds_List.getString(iRow, "CONFIRM_YN") + "', '0', 'N', 'Y' )			\n");
                    sbSql.append("           , IMPROV_YN = DECODE('" + ds_List.getString(iRow, "IMPROV_YN") + "', '0', 'N', 'Y' )			\n");
                    sbSql.append("           , BPC_SEND_YN = DECODE('" + ds_List.getString(iRow, "BPC_SEND_YN") + "', '0', 'N', 'Y' )		\n");
                    //sbSql.append("           , ORGIN_YN = 'Y'		\n");
                    sbSql.append("           , ORGIN_YN = DECODE('" + ds_List.getString(iRow, "CONFIRM_YN") + "', '0', 'Y', 'N' )		\n");
                    sbSql.append("           , UDATE      = SYSDATE 																		\n");
                    sbSql.append("           , UUSER      = '" + g_EmpNo + "' 																\n");
                    sbSql.append(" 	     WHERE UPJANG ='" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "'	  							\n");
                    sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'									\n");
                    //sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS"))+ "'							\n");
                    sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_List.getString(iRow, "BIZ_CLASS"))+ "'						\n");
                    
                    out_vl.add("fa_Sql", sbSql.toString());
                                //System.out.println(sbSql.toString());
                                pstmt = conn.prepareStatement(sbSql.toString());
                                pstmt.executeUpdate();
                                pstmt.close();

                    // 개선과제 적용대상을 상태값을 'Y'로 변경하여 다시 적용할수있게 한다.
                    sbSql.delete(0, sbSql.length());
                    sbSql.append("      UPDATE MAP_IMPROV_MGT_MST                           							\n");
                    if("0".equals(ds_List.getString(iRow, "IMPROV_YN")) ){
                        sbSql.append("         SET APPROV_YN= '" + "Y" + "' 												\n");
                    }else{
                        sbSql.append("         SET APPROV_YN= '" + "Y" + "' 												\n");
                    }
                    sbSql.append("           , UDATE      = SYSDATE 													\n");
                    sbSql.append("           , UUSER      = '" + g_EmpNo + "' 											\n");
                    sbSql.append("       WHERE UPJANG     = '" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "'	\n");
                    sbSql.append("         AND '" + ds_Cond.getString(0, "INPUT_YMD") + "' BETWEEN APPLY_ST_DT AND APPLY_ND_DT	\n");
                    //sbSql.append("         AND YY     	  = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'		\n");
                    //sbSql.append("         AND BIZ_CLASS  = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");

                    out_vl.add("fa_Sql", sbSql.toString());
                    //System.out.println(sbSql.toString());
                    pstmt = conn.prepareStatement(sbSql.toString());
                    pstmt.executeUpdate();
                    pstmt.close();



                // 월추정(원본, _최종 업데이트).
                }else{

                    //if(Integer.parseInt(ds_List.getString(iRow, "CHK")) ==  1) {
                    sbSql.delete(0, sbSql.length());
                    sbSql.append("      UPDATE MAP_MON_LOG_MGMT                           													\n");
                    sbSql.append("         SET CONFIRM_YN = DECODE('" + ds_List.getString(iRow, "CONFIRM_YN") + "', '0', 'N', 'Y' )			\n");
                    //sbSql.append("           , IMPROV_YN = DECODE('" + ds_List.getString(iRow, "IMPROV_YN") + "', '0', 'N', 'Y' )				\n");
                    sbSql.append("           , BPC_SEND_YN = DECODE('" + ds_List.getString(iRow, "BPC_SEND_YN") + "', '0', 'N', 'Y' )		\n");
                    sbSql.append("           , UDATE      = SYSDATE 																		\n");
                    sbSql.append("           , UUSER      = '" + g_EmpNo + "' 																\n");
                    sbSql.append(" 	     WHERE UPJANG ='" + nullToBlank(ds_List.getString(iRow, "UPJANG")) + "'	  							\n");
                    sbSql.append(" 		   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'									\n");
                    //sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS"))+ "'							\n");
                    sbSql.append("   	   AND BIZ_CLASS = '" + nullToBlank(ds_List.getString(iRow, "BIZ_CLASS"))+ "'							\n");
                    
                    out_vl.add("fa_Sql", sbSql.toString());
                                //System.out.println(sbSql.toString());
                                pstmt = conn.prepareStatement(sbSql.toString());
                                pstmt.executeUpdate();
                                pstmt.close();

                }

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