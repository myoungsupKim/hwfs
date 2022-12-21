.
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //입력 데이타
        DataSet ds_condi        = in_dl.get("ds_condi");

        String SEARCH_TYPE = nullToBlank(ds_condi.getString(0, "SEARCH_TYPE")); //창고 & 부서구분
        String SEARCH_CODE = nullToBlank(ds_condi.getString(0, "SEARCH_CODE")); //창고코드 & 부서코드
        String START_DT    = nullToBlank(ds_condi.getString(0, "START_DT"));    //시작일자
        String END_DT      = nullToBlank(ds_condi.getString(0, "END_DT"));      //종료일자
        String CUSTCD      = nullToBlank(ds_condi.getString(0, "CUSTCD"));      //거래처코드
        String CHK1        = nullToBlank(ds_condi.getString(0, "CHK1"));        //
        String CHK2        = nullToBlank(ds_condi.getString(0, "CHK2"));
        String CHK3        = nullToBlank(ds_condi.getString(0, "CHK3"));
        String strIPo      = nullToBlank(ds_condi.getString(0, "I_PO"));
        String strITrans   = nullToBlank(ds_condi.getString(0, "I_TRANS"));

        stmt        =  conn.createStatement();

        //out 데이타
        DataSet ds_out;

        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        // 구매검수내역
        sbSql.delete(0, sbSql.length());
        /* 속도개선작업 2017.06.23 김호석 */
        sbSql.append("SELECT A.TRANS_DATE                                                                                  \n");
        sbSql.append(" , A.TRANS_DEPT_ID                                                                                   \n");
        sbSql.append(" , A.CC_NM                                                                                           \n");
        sbSql.append(" , A.ITEM_TITLE                                                                                      \n");
        sbSql.append(" , A.TRANS_MAMOUNT                                                                                   \n");
        sbSql.append(" , A.TRANS_MVAT                                                                                      \n");
        sbSql.append(" , A.TOT_AMT                                                                                         \n");
        sbSql.append(" FROM TABLE(FCUS.FT_PO_TRANSACTION_01(                                                                                     \n");
        if (SEARCH_TYPE.equals("S"))    // 창고입고 선택시
        {
        	sbSql.append("          arg_SEARCH_TYPE => 'S' 																	\n");
            sbSql.append("        , arg_SEARCH_CODE => '" + SEARCH_CODE + "'											    \n");
        }
        else                            // 부서입고 선택시
        {
        	sbSql.append("          arg_SEARCH_TYPE => 'E' 																	\n");
            sbSql.append("        , arg_SEARCH_CODE => '" + SEARCH_CODE + "' 											 	\n");
            // 부서검수 전체 체크시
            //if (CHK2.equals("1")) 
            //	sbSql.append("        , arg_CHK2 => NULL \n");
        }
        //의미 없는 조건 : 창고는 NULL일 수 없음
        sbSql.append("        , arg_CHK2 => NULL 																	        \n");
        //입고거래처 != NULL
        if (CUSTCD.length() != 0)
        {
        	sbSql.append("           , arg_CUSTCD => '" + CUSTCD + "' 														\n");
        } else {
        	sbSql.append("           , arg_CUSTCD => NULL			 														\n");
        }
        sbSql.append("    , arg_bgn_yyyymmdd  => '" + START_DT + "'  														\n");
        sbSql.append("    , arg_end_yyyymmdd  => '" + END_DT + "' 															\n");
        sbSql.append("  )) A 																								\n");
        
        /*속도개선 후 주석처리 */
        /*
        sbSql.append("SELECT A.TRANS_DATE                                                                                       \n");
        sbSql.append("     , A.TRANS_DEPT_ID                                                                                    \n");
        sbSql.append("     , D.MU_NM ||' '||D.CC_NM   AS CC_NM                                                                  \n");
        sbSql.append("     , A.ITEM_NAME||DECODE(SIGN(C.TRANS_CNT - 1),1,' 외 '||TO_CHAR(C.TRANS_CNT - 1)||'건') AS ITEM_TITLE  \n");
        sbSql.append("     , C.TRANS_MAMOUNT AS TRANS_MAMOUNT                                                            		\n");
        sbSql.append("     , C.TRANS_MVAT AS TRANS_MVAT                                                                  		\n");
        sbSql.append("     , C.TRANS_MAMOUNT + C.TRANS_MVAT AS TOT_AMT                                                   		\n");
        sbSql.append("  FROM HLDC_PO_TRANSACTION A                                                                              \n");
        sbSql.append("     , (                                                                                                  \n");
        sbSql.append("         SELECT TRANS_DATE                                                                                \n");
        sbSql.append("              , MIN(TRANS_ID)      AS TRANS_ID                                                            \n");
        sbSql.append("              , COUNT(*)           AS TRANS_CNT                                                           \n");
        sbSql.append("              , SUM(CASE WHEN TRANS_MPRICE < 5 THEN  ROUND(TRANS_MPRICE * TRANS_QTY, -1)  ELSE  ROUND(TRANS_MPRICE, -1) * TRANS_QTY END ) AS TRANS_MAMOUNT                                  \n"); */ /*윤지혜 대리 5원 미만 금액은 계산 후 반올림 처리 SR_ID : SR201609_01546 변경ID :CH201609_00104 */
        /*
        sbSql.append("              , SUM(CASE WHEN TRANS_MPRICE < 5 THEN  ROUND(TRUNC((DECODE(TAX_CODE, '100' ,0.1 ,0) * TRANS_MPRICE) * TRANS_QTY) , -1)   ELSE TRUNC(DECODE(TAX_CODE, '100' ,0.1 ,0) * ROUND(TRANS_MPRICE, -1), 0) * TRANS_QTY END) AS TRANS_MVAT   \n");
        sbSql.append("           FROM HLDC_PO_TRANSACTION                                                                       \n");
        sbSql.append("          WHERE TRANS_DATE    BETWEEN '" + START_DT + "' AND '" + END_DT + "'                             \n");
        sbSql.append("            AND SOURCE_TYPE   = 'PO'                                                                      \n");
        sbSql.append("            AND TRANS_TYPE    BETWEEN 'I001'     AND 'I002'                                               \n");
        sbSql.append("  		  AND PO_TYP <> 'BP'                                                                             \n"); //2016.04.22 최학진 윤지혜 대리 현지구매건 총액에서 제외 FSP00200V_T001.jsp
        if (SEARCH_TYPE.equals("S"))    // 창고입고 선택시
        {
            sbSql.append("        AND SUBINV_CODE = '" + SEARCH_CODE + "' \n");
        }
        else                            // 부서입고 선택시
        {
            sbSql.append("        AND TRANS_DEPT_ID = '" + SEARCH_CODE + "' \n");
            // 부서검수 전체 체크시
            if (CHK2.equals("1")) 
            	sbSql.append("        AND SUBINV_CODE IS NULL \n");
        }
        //입고거래처 != NULL
        if (CUSTCD.length() != 0) sbSql.append("           AND CUSTCD = '" + CUSTCD + "' \n");
        sbSql.append("          GROUP BY TRANS_DATE, TRANS_DEPT_ID                                                              \n");
        sbSql.append("        ) C                                                                                               \n");
        sbSql.append("     , HLDC_SC_DEPT_V D                                                                                   \n");
        sbSql.append(" WHERE A.TRANS_ID      = C.TRANS_ID                                                                  \n");
        sbSql.append("   AND A.TRANS_DEPT_ID = D.DEPT_ID                                                                   \n");        
        sbSql.append(" ORDER BY TRANS_DATE                                                                                \n"); 
        */


        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_out = this.makeDataSet(rs, "ds_out");

        /**종료**/
        out_dl.add(ds_out);
        this.setResultMessage(0, "OK", out_vl);

    } catch(Exception ex) {
           ex.printStackTrace();
           this.setResultMessage(-1, ex.toString(),out_vl);
        } finally {
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
            if(stmt != null) {
                try {
                    stmt.close();
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