<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30100E_T001.jsp
■ 프로그램명   : 사업계획 이력 관리
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
        //입력 파라메터
        //String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        //String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
        //String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));

        String g_BizGbn     = nullToBlank(ds_Cond.getString(0, "BIZ_GBN"));
        String g_CcCd		= nullToBlank(ds_Cond.getString(0, "CC_CD"));
        //FileLog.println("d:\\aaa.txt", ds_Cond\ㅜ");
        //System.out.println("g_BizGbn===>"+g_BizGbn);

        //out 데이타
        DataSet ds_List;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 사업계획
        if("0".equals(g_BizGbn)){
            sbSql.delete(0, sbSql.length());
            ///*
            sbSql.append("		SELECT B.UPJANGNM                                             \n");
            sbSql.append("		      ,A.UPJANG                                               \n");
            sbSql.append("		      ,B.MU_CD                                                \n");
            sbSql.append("		      ,B.TM_CD                                                \n");
            sbSql.append("		      ,B.CC_CD                                                \n");
            sbSql.append("		      ,A.YY                                                   \n");
            sbSql.append("		      ,A.BIZ_CLASS                                            \n");
            sbSql.append("		      ,DECODE(A.CONFIRM_YN, 'Y', '1', '0') CONFIRM_YN         \n");
            sbSql.append("		      ,DECODE(A.IMPROV_YN, 'Y', '1', '0') IMPROV_YN           \n");
            sbSql.append("		      ,DECODE(A.BPC_SEND_YN, 'Y', '1', '0') BPC_SEND_YN       \n");
            sbSql.append("		      ,A.REMARK                                               \n");
            sbSql.append("		  FROM MAP_BIZ_LOG_MGMT A                                     \n");
            sbSql.append("		      ,SCO_UPJANG_MST_V B                                     \n");
            sbSql.append("		 WHERE A.UPJANG = B.UPJANG                                    \n");
            // 최종 상태값이 "_최종" 인 값으 가져온다. (원본, 최종중 최종만 가져오고 둘다 업데이트 친다.)
            //sbSql.append("		   AND A.ORGIN_YN = 'N'                                       \n");
            sbSql.append("		   AND A.YY = '" + ds_Cond.getString(0, "INPUT_YY") + "'      \n");
            sbSql.append(" 	       AND B.MU_CD = '" + ds_Cond.getString(0, "MU_CD") + "'   	  \n");
            sbSql.append(" 	       AND B.TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'   	  \n");

            if(!"".equals(g_CcCd)){
                sbSql.append("	   AND B.CC_CD = '" + ds_Cond.getString(0, "CC_CD") + "'   	  \n");
            }
            // 최종값 ORGIN_YN = 'N' 가져온다.
            //sbSql.append("		   AND A.BIZ_CLASS = '" + ds_Cond.getString(0, "BIZ_CLASS") + "' \n");
            out_vl.add("fa_Sql", sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            ds_List = this.makeDataSet(rs, "ds_List");

            pstmt.close();
            rs.close();

        // 월추정
        }else{
            sbSql.delete(0, sbSql.length());
            //sbSql.append("		 UNION ALL                                                    \n");
            sbSql.append("		SELECT B.UPJANGNM                                             \n");
            sbSql.append("		      ,A.UPJANG                                               \n");
            sbSql.append("		      ,B.MU_CD                                                \n");
            sbSql.append("		      ,B.TM_CD                                                \n");
            sbSql.append("		      ,B.CC_CD                                                \n");
            sbSql.append("		      ,A.YY                                                   \n");
            sbSql.append("		      ,A.BIZ_CLASS                                            \n");
            sbSql.append("		      ,DECODE(A.CONFIRM_YN, 'Y', '1', '0') CONFIRM_YN         \n");
            sbSql.append("		      ,'0' IMPROV_YN                                          \n");
            sbSql.append("		      ,DECODE(A.BPC_SEND_YN, 'Y', '1', '0') BPC_SEND_YN       \n");
            sbSql.append("		      ,A.REMARK                                               \n");
            sbSql.append("		  FROM MAP_MON_LOG_MGMT A                                     \n");
            sbSql.append("		      ,SCO_UPJANG_MST_V B                                     \n");
            sbSql.append("		 WHERE A.UPJANG = B.UPJANG                                    \n");
            sbSql.append("		   AND A.YY = '" + ds_Cond.getString(0, "INPUT_YY") + "'      \n");
            sbSql.append(" 	       AND B.MU_CD = '" + ds_Cond.getString(0, "MU_CD") + "'   	  \n");
            sbSql.append(" 	       AND B.TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'   	  \n");
            if(!"".equals(g_CcCd)){
                sbSql.append("	   AND B.CC_CD = '" + ds_Cond.getString(0, "CC_CD") + "'   	  \n");
            }
            sbSql.append("		   AND A.BIZ_CLASS = '" + ds_Cond.getString(0, "BIZ_CLASS") + "' \n");

            out_vl.add("fa_Sql", sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            ds_List = this.makeDataSet(rs, "ds_List");

            pstmt.close();
            rs.close();

        }

        /**종료**/
        out_dl.add(ds_List);
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