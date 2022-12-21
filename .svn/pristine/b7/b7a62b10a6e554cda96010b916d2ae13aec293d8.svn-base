<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/현황분석/자재구매패턴분석/현지구매목록
■ 프로그램ID   : FSP00280V1_S002.jsp
■ 프로그램명   : 현지구매목록
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
    
        //FileLog.println("d:\\ds_condi.txt", ds_condi);
        
            
        //입력 데이타
        String MU_CD  = nullToBlank(ds_condi.getString(0, "MU_CD"));
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
        
        /* 재료비 - 실적 - 현재구매 */
        sbSql.append("SELECT /*+ USE_NL(A.HD A.DT) */                                                                                                                                 \n ");
        sbSql.append("       C.TM_NAME                                                                                                                                                \n ");
        sbSql.append("     , C.JOB_NAME                                                                                                                                               \n ");
        sbSql.append("     , C.SUB_JOB_NAME                                                                                                                                           \n ");
        sbSql.append("     , A.TRANS_UPJANG AS UPJANG                                                                                                                                 \n ");
        sbSql.append("     , C.UPJANGNM                                                                                                                                               \n ");
        sbSql.append("     , 1 AS SEQ                                                                                                                                                 \n ");
        sbSql.append("     , A.TRANS_DATE AS NEED_DATE                                                                                                                                \n ");
        sbSql.append("     , ROUND(NVL(DECODE(B.OUTVAT_FLAG, 'Y', MARGIN_AMOUNT * DECODE(TAX_CODE, '100', DECODE(MATERIAL_ACCTCD, '11402000', 1.1, 1)), MARGIN_AMOUNT), 0)) AS PO_AMT \n ");
        sbSql.append("  FROM HLDC_PO_TRANSACTION A                                                                                                                                    \n ");
        sbSql.append("     , HLDC_PO_SUBINVENTORY B                                                                                                                                   \n ");
        sbSql.append("     , FSA_UPJANG_V C                                                                                                                                           \n ");
        sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                            \n ");
        sbSql.append("   AND A.TRANS_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'                                                                                          \n ");
        sbSql.append("   AND A.TRANS_TYPE LIKE 'I%'        -- 입고                                                                                                                    \n ");
        sbSql.append("   AND A.PO_TYP = 'BP'               -- BP : 정산용, UP : 전산구매                                                                                              \n ");
        sbSql.append("   AND A.ITEM_CODE LIKE 'F%'         -- 식재료                                                                                                                  \n ");
        sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG                                                                                                                                \n ");
        sbSql.append("   AND C.MU_CD = '"+ MU_CD +"'                                                                                                                                  \n ");
        
        if( BONBU.equals("Y") )
        {
        	sbSql.append( "    AND (C.TM_CD LIKE '"+ TM_CD2 +"' || '%' OR C.PT_CD LIKE '"+ TM_CD2 +"' || '%')   \n");
        }
        else
        {
            if(!TM_CD.equals(""))
            {
                sbSql.append( "    AND (C.TM_CD = '"+ TM_CD +"' OR C.PT_CD = '"+ TM_CD +"')   \n");
            }	
        }

        
        if((!JOB_CD.equals(""))&&(!JOB_CD.equals("000")))
        {
            sbSql.append( "    AND C.JOB_CD = '"+ JOB_CD +"'   \n");
        }
        
        if((!SUB_JOB_CD.equals(""))&&(!SUB_JOB_CD.equals("000000")))
        {
            sbSql.append( "    AND C.SUB_JOB_CD = '"+ SUB_JOB_CD +"'   \n");
        }
        
        if(!UPJANG.equals(""))
        {
            sbSql.append( "    AND C.UPJANG = '"+ UPJANG +"'   \n");
        }
        
        sbSql.append( " ORDER BY C.TM_NAME, C.JOB_NAME, C.SUB_JOB_NAME, C.UPJANGNM \n");
        
    
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        DataSet ds_list1 = this.makeDataSet(rs, "ds_list1"); //ds_list

        //FileLog.println("d:\\ds_listzzzz.txt", ds_list);
        
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