<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/현황분석/자재구매패턴분석/추가발주목록
■ 프로그램ID   : FSP00280V1_S002.jsp
■ 프로그램명   : 추가발주목록
■ 작성일자     : 2015-07-01
■ 작성자       : 정영철
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    try {
        //기간별 상세내역 조회
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();
        
        //입력 데이타
        DataSet ds_condi        = in_dl.get("ds_condi");
    
        //입력 데이타
        String MU_CD      = nullToBlank(ds_condi.getString(0, "MU_CD"));
        String TM_CD      = nullToBlank(ds_condi.getString(0, "TM_CD"));
        String JOB_CD     = nullToBlank(ds_condi.getString(0, "JOB_CD"));
        String SUB_JOB_CD = nullToBlank(ds_condi.getString(0,"SUB_JOB_CD"));
        String UPJANG     = nullToBlank(ds_condi.getString(0, "UPJANG"));
        String START_DATE = nullToBlank(ds_condi.getString(0, "START_DATE"));
        String END_DATE   = nullToBlank(ds_condi.getString(0, "END_DATE"));
        String TM_CD2     = nullToBlank(ds_condi.getString(0, "TM_CD2"));
        String BONBU      = nullToBlank(ds_condi.getString(0, "BONBU"));
        
        //out 데이타
        DataSet ds_list;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        sbSql.delete(0, sbSql.length()); //클리어
        
        
        sbSql.append("  SELECT TM_NAME                                                                              \n ");
        sbSql.append("       , JOB_NAME                                                                             \n ");
        sbSql.append("       , SUB_JOB_NAME                                                                         \n ");
        sbSql.append("       , UPJANGNM                                                                             \n ");
        sbSql.append("       , 1 AS SEQ                                                                             \n ");
        sbSql.append("       , A.PR_NUM                                                                             \n ");
        sbSql.append("       , A.NEED_DATE                                                                          \n ");
        sbSql.append("       , ROUND(A.PO_AMT,0) AS PO_AMT                                                          \n ");
        sbSql.append("       , A.PR_REASON                                                                          \n ");
        sbSql.append("       , A.REASON_CD                                                                          \n ");
        sbSql.append("    FROM (                                                                                    \n ");
        sbSql.append("          SELECT A.RC_UPJANG                                                                  \n ");
        sbSql.append("               , A.PR_NUM                                                                     \n ");
        sbSql.append("               , A.NEED_DATE                                                                  \n ");
        sbSql.append("               , A.PO_AMT                                                                     \n ");
        sbSql.append("               , B.PR_REASON                                                                  \n ");
        sbSql.append("               , B.REASON_CD                                                                  \n ");
        sbSql.append("            FROM                                                                              \n ");
        sbSql.append("                (                                                                             \n ");
        sbSql.append("                  SELECT A.RC_UPJANG                                                          \n ");
        sbSql.append("                       , B.PR_NUM                                                             \n ");
        sbSql.append("                       , A.NEED_DATE                                                          \n ");
        sbSql.append("                       , SUM(A.MARGIN_PRICE * A.PO_QTY) PO_AMT                                \n ");
        sbSql.append("                    FROM HLDC_PO_PO A                                                         \n ");
        sbSql.append("                       , SO_PR B                                                              \n ");
        sbSql.append("                       , HLDC_PO_ITEM_MST C                                                   \n ");
        sbSql.append("                   WHERE A.NEED_DATE   BETWEEN '"+    START_DATE  +"' AND '" + END_DATE + "'  \n ");
        sbSql.append("                     AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')                      \n ");
        sbSql.append("                     AND A.RC_MU_CD    =  '2002'                                              \n ");
        sbSql.append("                     AND A.SUBINV_CODE LIKE 'C%'                                              \n ");
        sbSql.append("                     AND A.PO_ID       = B.PR_ID                                              \n ");
        sbSql.append("                     AND A.PO_NUM      = B.PR_NUM                                             \n ");
        sbSql.append("                     AND A.ITEM_CODE   = C.ITEM_CODE                                          \n ");
        sbSql.append("                     AND C.ITEM_CLASS1 = 'F'                                                  \n ");
        sbSql.append("                     AND A.PO_TYPE     <> '04'                                                \n ");
        sbSql.append("                   GROUP BY A.RC_UPJANG                                                       \n ");
        sbSql.append("                       , B.PR_NUM, A.NEED_DATE                                                \n ");
        sbSql.append("                ) A                                                                           \n ");
        sbSql.append("               , SO_PR_REASON B                                                               \n ");
        sbSql.append("           WHERE A.PR_NUM = B.PR_NUM                                                          \n ");
        sbSql.append("         ) A                                                                                  \n ");
        sbSql.append("       , FSA_UPJANG_V B                                                                       \n ");
        sbSql.append("   WHERE A.RC_UPJANG = B.UPJANG                                                               \n ");  
        sbSql.append("     AND B.MU_CD = '"+ MU_CD +"'                                                      \n ");
        
        if( BONBU.equals("Y") )
        {
        	sbSql.append( " AND B.TM_CD LIKE '"+ TM_CD2 +"' || '%'  \n");
        }
        else
        {
            if(!TM_CD.equals(""))
            {
                sbSql.append( " AND B.TM_CD = '"+ TM_CD +"'   \n");
            }
        }
        
        if((!JOB_CD.equals(""))&&(!JOB_CD.equals("000")))
        {
            sbSql.append( " AND B.JOB_CD = '"+ JOB_CD +"'   \n");
        }
        
        if((!SUB_JOB_CD.equals(""))&&(!SUB_JOB_CD.equals("000000")))
        {
            sbSql.append( " AND B.SUB_JOB_CD = '"+ SUB_JOB_CD +"'   \n");
        }
        
        if(!UPJANG.equals(""))
        {
            sbSql.append( " AND B.UPJANG = '"+ UPJANG +"'   \n");
        }
        
        sbSql.append( " ORDER BY TM_NAME, JOB_NAME, SUB_JOB_NAME, UPJANGNM, NEED_DATE \n");
        
    
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        DataSet ds_list1 = this.makeDataSet(rs, "ds_list1"); //ds_list

        //FileLog.println("d:\\ds_listddd.txt", ds_list);
        
        /**종료**/
        out_dl.add(ds_list1);
        this.setResultMessage(0, "OK", out_vl);
    }
    catch(Exception ex)
    {
        ex.printStackTrace();
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
    }
    proc_output(response,out,out_vl,out_dl);
    
%>