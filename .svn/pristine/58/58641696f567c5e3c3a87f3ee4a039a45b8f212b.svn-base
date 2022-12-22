<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/현황분석/자재구매패턴분석/자재구매신청률
■ 프로그램ID   : FSP00280V4_S002.jsp
■ 프로그램명   : 자재구매신청률
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
        String SUB_JOB_CD = nullToBlank(ds_condi.getString(0, "SUB_JOB_CD"));
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
        
        sbSql.append(" SELECT B.TM_NAME                                                                                                     \n ");
        sbSql.append("      , B.JOB_NAME                                                                                                    \n ");
        sbSql.append("      , B.SUB_JOB_NAME                                                                                                \n ");
        sbSql.append("      , B.UPJANGNM                                                                                                    \n ");
        sbSql.append("      , SUM(A.ITEM_CNT) AS ITEM_CNT                                                                                   \n ");
        sbSql.append("      , SUM(A.ORDER_CNT) AS ORDER_CNT                                                                                 \n ");
        sbSql.append("      , ROUND(DECODE(SUM(A.ITEM_CNT), 0, 0, SUM(A.ORDER_CNT) / SUM(A.ITEM_CNT) * 100), 2) AS ORDER_RATE               \n ");
        sbSql.append("   FROM                                                                                                               \n ");
        sbSql.append("        (                                                                                                             \n ");
        sbSql.append("         SELECT UPJANG                                                                                                \n ");
        sbSql.append("              , 1 AS ITEM_CNT                                                                                         \n ");
        sbSql.append("              , DECODE(ORDER_YN, 'Y', 1, 0) AS ORDER_CNT                                                              \n ");
        sbSql.append("           FROM FSM_REAL_RECIPE_ITEM                                                                                  \n ");
        sbSql.append("          WHERE NEED_DATE BETWEEN '" + START_DATE + "' AND '" + END_DATE + "'                                         \n ");
        sbSql.append("          GROUP BY UPJANG, ITEM_CODE, ORDER_YN                                                                        \n ");
        sbSql.append("        ) A                                                                                                           \n ");
        sbSql.append("      , FSA_UPJANG_V  B                                                                                               \n ");
        sbSql.append("  WHERE A.UPJANG     = B.UPJANG                                                                                       \n ");
        sbSql.append("    AND B.MU_CD = '"+ MU_CD +"'                                                                                       \n ");
        
        if( BONBU.equals("Y") )
        {
        	sbSql.append( "    AND (B.TM_CD LIKE '"+ TM_CD2 +"' || '%' OR B.PT_CD LIKE '"+ TM_CD2 +"' || '%')   \n");
        }
        else
        {
            if(!TM_CD.equals(""))
                sbSql.append( "    AND (B.TM_CD = '"+ TM_CD +"' OR B.PT_CD = '"+ TM_CD +"')   \n");
        }
        
        if((!JOB_CD.equals(""))&&(!JOB_CD.equals("000")))
            sbSql.append( "    AND B.JOB_CD = '"+ JOB_CD +"'   \n");
        
        if((!SUB_JOB_CD.equals(""))&&(!SUB_JOB_CD.equals("000000")))
            sbSql.append( "    AND B.SUB_JOB_CD = '"+ SUB_JOB_CD +"'   \n");
        
        if(!UPJANG.equals(""))
            sbSql.append( "    AND B.UPJANG = '"+ UPJANG +"'   \n");
        
        sbSql.append( " GROUP BY  B.TM_NAME, B.JOB_NAME, B.SUB_JOB_NAME, B.UPJANGNM \n ");
        sbSql.append( " ORDER BY TM_NAME, JOB_NAME, SUB_JOB_NAME, UPJANGNM \n");
        
    
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list = this.makeDataSet(rs, "ds_list"); //ds_list
		
        /**종료**/
        out_dl.add(ds_list);
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