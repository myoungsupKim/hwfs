<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 위생관리/외부기관점검결과관리
■ 프로그램ID   : FSC92030E_T003.jsp
■ 프로그램명   : 외부기간점검결과조회
■ 작성일자     : 2019-07-08
■ 작성자       : 김명섭
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

        String strUpjang 		= ds_input.getString(0, "UPJANG");
        String strVisitDt		= ds_input.getString(0, "VISIT_DT");
        Integer intSeqNo		= ds_input.getInt(0, "SEQNO");

        //out 데이타
        DataSet ds_Detail, ds_Detail1;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT UPJANG,                                                                                                \n");
        sbSql.append("       VISIT_DT,                                                                                              \n");
        sbSql.append("       SEQNO,                                                                                                 \n");
        sbSql.append("       CHECKSEQ,                                                                                                 \n");
        sbSql.append("       CHECKGB,                                                                                                 \n");
        sbSql.append("       SCC_CODE_NM('FS9130',A.CHECKGB) AS CHECKGBNM,                                         \n");
        sbSql.append("       CHECKDTL,                                                                                                 \n");
        sbSql.append("       SCC_CODE_NM('FS9140',A.CHECKDTL) AS CHECKDTLNM,                                         \n");
        sbSql.append("       CHECK_CONTENTS,                                                                                                 \n");
        sbSql.append("       IMPRV_CONTENTS,                                                                                                 \n");
        sbSql.append("       IMPRV_DT,                                                                                                 \n");
        sbSql.append("       MAIN_AGENT,                                                                                                 \n");
        sbSql.append("       SCC_CODE_NM('FS9150',A.MAIN_AGENT) AS MAIN_AGENTNM,                                         \n");
        sbSql.append("       (SELECT COUNT(1)                             \n");
        sbSql.append("          FROM FSC_TEST_EXTERNAL_IMGE               \n");
        sbSql.append("         WHERE UPJANG = A.UPJANG                    \n");
        sbSql.append("           AND VISIT_DT = A.VISIT_DT                \n");
        sbSql.append("           AND SEQNO = A.SEQNO                      \n");
        sbSql.append("           AND CHECKSEQ = A.CHECKSEQ) AS IMGE_CNT   \n");    
        sbSql.append("  FROM FSC_TEST_EXTERNAL_DTL A                                                                                \n");
        sbSql.append(" WHERE A.UPJANG = '" + strUpjang + "' \n");
        sbSql.append("   AND A.VISIT_DT = '" + strVisitDt + "' \n");
        sbSql.append("   AND A.SEQNO = " + intSeqNo + " \n");
        sbSql.append(" ORDER BY A.VISIT_DT DESC, A.SEQNO, A.CHECKSEQ \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        
        ds_Detail = this.makeDataSet(rs, "ds_Detail");

        rs.close();
        pstmt.close();
        
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT UPJANG,                                                                                                \n");
        sbSql.append("       VISIT_DT,                                                                                              \n");
        sbSql.append("       SEQNO,                                                                                                 \n");
        sbSql.append("       CHECKSEQ,                                                                                                 \n");
        sbSql.append("       CHECKGB,                                                                                                 \n");
        sbSql.append("       SCC_CODE_NM('FS9160',A.CHECKGB) AS CHECKGBNM,                                         \n");
        sbSql.append("       PUMMOK,                                                                                                 \n");
        sbSql.append("       STATUS,                                                                                                 \n");
        sbSql.append("       MOVEGB,                                                                                                 \n");
        sbSql.append("       SCC_CODE_NM('FS9170',A.MOVEGB) AS MOVEGBNM                                          \n");
        sbSql.append("  FROM FSC_TEST_EXTERNAL_DTL_PICK A                                                                                \n");
        sbSql.append(" WHERE A.UPJANG = '" + strUpjang + "' \n");
        sbSql.append("   AND A.VISIT_DT = '" + strVisitDt + "' \n");
        sbSql.append("   AND A.SEQNO = " + intSeqNo + " \n");
        sbSql.append(" ORDER BY A.VISIT_DT DESC, A.SEQNO, A.CHECKSEQ \n");

        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        
        ds_Detail1 = this.makeDataSet(rs, "ds_Detail1");
        
        rs.close();
        pstmt.close();

        /**종료**/
        out_dl.add(ds_Detail);
        out_dl.add(ds_Detail1);
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