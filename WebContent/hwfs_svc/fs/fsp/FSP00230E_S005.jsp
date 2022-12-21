<%
    /*-----------------------------------------------------------------------------
    ■ 시스템명     : TEST
    ■ 프로그램ID   : MAP30070E_S003.jsp
    ■ 프로그램명   : TEST
    ■ 작성일자     : 2015-10-29
    ■ 작성자       : jshoon
    ■ 이력관리     :
    -----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
    try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_Cond = in_dl.get("ds_Cond");

        String g_EmpNo = nullToBlank(in_vl.getString("g_EmpNo"));
        String g_Upjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
        String g_Class = nullToBlank(ds_Cond.getString(0, "CLASS"));
        String g_SubinvCode = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));

        int isData = 0;

        StringBuffer sbSql = new StringBuffer();

        if( g_Class.equals("I") )
        {
            // 업장이 등록이 안되어 있으면 INSERT 잠금 후 RETURN
            sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT COUNT(1) AS CNT \n");
            sbSql.append("  FROM FSP_PHYSICAL_INVENTORY_LOG \n");
            sbSql.append(" WHERE UPJANG = '" + g_Upjang + "'  \n");
            sbSql.append("   AND SUBINV_CODE = '" + g_SubinvCode + "' \n");

            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            rs.next();

            isData = rs.getInt("CNT");

            rs.close();
            pstmt.close();

            if (isData == 0)
            {
                sbSql.delete(0, sbSql.length());
                sbSql.append("INSERT INTO FSP_PHYSICAL_INVENTORY_LOG (UPJANG, SUBINV_CODE, STATUS, CREATE_DATE, CREATE_BY) \n");
                sbSql.append("VALUES ('" + g_Upjang + "' \n");
                sbSql.append(" , '" + g_SubinvCode + "' \n");
                sbSql.append(" , '1' \n");
                sbSql.append(" , SYSDATE \n");
                sbSql.append(" , '" + g_EmpNo + "' \n");
                sbSql.append(" )  \n");
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();

                //out_vl.add("v_StockClose", "화면을 잠궜습니다.");
                out_vl.add("v_CloseYn", "N");
            } else {
                // 잠김여부를 체크해서 잠겨있으면 RETURN, 풀려있으면 잠금 후 RETURN
                sbSql.delete(0, sbSql.length());
                sbSql.append("SELECT COUNT(1) AS CNT \n");
                sbSql.append("  FROM FSP_PHYSICAL_INVENTORY_LOG \n");
                sbSql.append(" WHERE UPJANG = '" + g_Upjang + "' \n");
                sbSql.append("   AND SUBINV_CODE = '" + g_SubinvCode + "' \n");
                sbSql.append("   AND STATUS = '1' \n");
                pstmt = conn.prepareStatement(sbSql.toString());
                rs = pstmt.executeQuery();
                rs.next();
                isData = rs.getInt("CNT");
                rs.close();
                pstmt.close();

                if (isData > 0) {
                    out_vl.add("v_StockClose", "다른 화면에서 사용중입니다.");
                    out_vl.add("v_CloseYn", "Y");
                } else {
                    sbSql.delete(0, sbSql.length());
                    sbSql.append("UPDATE FSP_PHYSICAL_INVENTORY_LOG SET \n");
                    sbSql.append("       STATUS = '1' \n");
                    sbSql.append("     , UPDATE_DATE = SYSDATE \n");
                    sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
                    sbSql.append(" WHERE UPJANG = '" + g_Upjang + "'  \n");
                    sbSql.append("   AND SUBINV_CODE = '" + g_SubinvCode + "' \n");
                    pstmt = conn.prepareStatement(sbSql.toString());
                    pstmt.executeUpdate();
                    pstmt.close();

                    //out_vl.add("v_StockClose", "화면을 잠궜습니다.");
                    out_vl.add("v_CloseYn", "N");
                }
            }
        } else if (g_Class.equals("D")) {
            // 화면을 종료 시 잠금을 풀고 RETURN
            sbSql.delete(0, sbSql.length());
            sbSql.append("UPDATE FSP_PHYSICAL_INVENTORY_LOG SET \n");
            sbSql.append("       STATUS = '0' \n");
            sbSql.append("     , UPDATE_DATE = SYSDATE \n");
            sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
            sbSql.append(" WHERE UPJANG = '" + g_Upjang + "'  \n");
            sbSql.append("   AND SUBINV_CODE = '" + g_SubinvCode + "' \n");
            pstmt = conn.prepareStatement(sbSql.toString());
            pstmt.executeUpdate();
            pstmt.close();

            //out_vl.add("v_StockClose", "화면잠금을 풀었습니다.");
            out_vl.add("v_CloseYn", "N");
        }

        /**종료**/
        conn.commit();
        this.setResultMessage(0, "OK", out_vl);
    } catch (Exception ex) {
        //ex.printStackTrace();
        //jsp 로그남기기
        conn.rollback();
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