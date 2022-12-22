<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/현황분석/자재구매패턴분석/발주유형별발주금액
■ 프로그램ID   : FSP00280V1_S001.jsp
■ 프로그램명   : 발주유형별발주금액
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
        String MU_CD  = nullToBlank(ds_condi.getString(0, "MU_CD"));
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
        
        sbSql.append("  SELECT TM_NAME                                                                                     \n ");   
        sbSql.append("       , JOB_NAME                                                                                    \n ");
        sbSql.append("       , SUB_JOB_NAME                                                                                \n ");
        sbSql.append("       , UPJANGNM                                                                                    \n ");
        sbSql.append("       , (ROUND(D2, 0)+ROUND(D1, 0)+ROUND(B1, 0)) TOT --합계                                                           \n ");
        sbSql.append("       , ROUND(D2, 0) D2 -- D-2발주                                                                                              \n ");
        sbSql.append("       , CASE WHEN (D2+D1+B1) = 0 THEN 0                                                             \n ");
        sbSql.append("              ELSE ROUND((D2 / (D2 + D1 + B1)) * 100, 1)                                             \n ");
        sbSql.append("              END D2_RATE -- D-2%                                                                    \n ");
        sbSql.append("       , ROUND(D1, 0) D1 -- D-1발주                                                                                              \n ");
        sbSql.append("       , CASE WHEN (D2 + D1 + B1) = 0 THEN 0                                                         \n ");
        sbSql.append("              ELSE ROUND((D1 / (D2 + D1 + B1)) * 100, 1)                                             \n ");
        sbSql.append("              END D1_RATE -- D-1%                                                                    \n ");
        sbSql.append("       , ROUND(B1, 0) B1 -- 현지구매                                                                                              \n ");
		sbSql.append("       , CASE WHEN (D2 + D1 + B1) = 0 THEN 0                                                         \n ");
		sbSql.append("              ELSE ROUND((B1 / (D2 + D1 + B1)) * 100, 1)                                             \n ");
		sbSql.append("              END B1_RATE -- 현지구매%                                                                 \n ");
		sbSql.append("       , ROUND(A1, 0) A1 -- 자동                                                                                                  \n ");
		sbSql.append("       , CASE WHEN (D2 + D1 + B1) = 0 THEN 0                                                         \n ");
		sbSql.append("              ELSE ROUND((A1 / (D2 + D1 + B1)) * 100, 1)                                             \n ");
		sbSql.append("              END A1_RATE -- 자동%                                                                    \n ");
		sbSql.append("       , ROUND(A2, 0) A2 -- 추가일반                                                                                                  \n ");
		sbSql.append("       , CASE WHEN (D2 + D1 + B1) = 0 THEN 0                                                         \n ");
		sbSql.append("              ELSE ROUND((A2 / (D2 + D1 + B1)) * 100, 1)                                             \n ");
		sbSql.append("              END A2_RATE -- 추가일반%                                                                    \n ");
		sbSql.append("       , ROUND(A3, 0) A3 -- 추가양념미곡                                                                                                  \n ");
		sbSql.append("       , CASE WHEN (D2 + D1 + B1) = 0 THEN 0                                                         \n ");
		sbSql.append("              ELSE ROUND((A3 / (D2 + D1 + B1)) * 100, 1)                                             \n ");
		sbSql.append("              END A3_RATE -- 추가양념미곡%                                                                    \n ");
        sbSql.append("    FROM (                                                                                           \n ");
        sbSql.append("          SELECT RC_UPJANG                                                                           \n ");
        sbSql.append("               , SUM(D2) D2                                                                          \n ");
        sbSql.append("               , SUM(D1) D1                                                                          \n ");
        sbSql.append("               , SUM(B1) B1                                                                          \n ");
        sbSql.append("               , SUM(A1) A1                                                                          \n ");
        sbSql.append("               , SUM(A2) A2                                                                          \n ");
        sbSql.append("               , SUM(A3) A3                                                                          \n ");
        sbSql.append("            FROM (                                                                                   \n ");
        
        /*
        sbSql.append("                  SELECT A.RC_UPJANG, SUM(A.PO_QTY*A.MARGIN_PRICE) D2, 0 D1, 0 A1, 0 A2, 0 B1, 0 A3        \n ");
        sbSql.append("                    FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B                                            \n ");
        sbSql.append("                   WHERE A.ITEM_CODE = B.ITEM_CODE                                                   \n ");
        sbSql.append("                     AND A.NEED_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'              \n ");
        sbSql.append("                     AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')                             \n ");
        sbSql.append("                     AND B.ITEM_CLASS1 = 'F'                                                         \n ");
        */
        /*
        sbSql.append("                     AND A.RC_MU_CD = '2002'                                                         \n ");
        
        sbSql.append("                     AND A.RC_MU_CD = '"+ MU_CD + "'                                                 \n ");
        sbSql.append("                     AND A.SUBINV_CODE LIKE 'C%'                                                     \n ");
        sbSql.append("                     AND A.PO_TYPE <> 'MT'                                                           \n ");
        sbSql.append("                     AND TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(SUBSTR(A.ORDER_DATE, 1, 8),'YYYYMMDD') > 1      \n ");
        sbSql.append("                   GROUP BY RC_UPJANG                                                                \n ");
        sbSql.append("                  UNION ALL                                                                          \n ");
        sbSql.append("                  SELECT A.RC_UPJANG, 0 D2, SUM(A.PO_QTY*A.MARGIN_PRICE) D1, 0 A1, 0 A2, 0 B1, 0 A3        \n ");
        sbSql.append("                    FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B                                            \n ");
        sbSql.append("                   WHERE A.ITEM_CODE = B.ITEM_CODE                                                   \n ");
        sbSql.append("                     AND A.NEED_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'              \n ");
        sbSql.append("                     AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')                             \n ");
        sbSql.append("                     AND B.ITEM_CLASS1 = 'F'                                                         \n ");
        */
        /*
        sbSql.append("                     AND A.RC_MU_CD = '2002'                                                         \n ");
        
        sbSql.append("                     AND A.RC_MU_CD = '"+ MU_CD + "'                                                         \n ");
        sbSql.append("                     AND A.SUBINV_CODE LIKE 'C%'                                                     \n ");
        sbSql.append("                     AND A.PO_TYPE <> 'MT'                                                           \n ");
        sbSql.append("                     AND TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(SUBSTR(A.ORDER_DATE, 1, 8),'YYYYMMDD') <= 1     \n ");
        sbSql.append("                   GROUP BY A.RC_UPJANG                                                              \n ");
        sbSql.append("                  UNION ALL                                                                          \n ");
        sbSql.append("                  SELECT A.RC_UPJANG, 0 D2, 0 D1, SUM(A.PO_QTY*A.MARGIN_PRICE) A1, 0 A2, 0 B1, 0 A3        \n ");
        sbSql.append("                    FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B                                            \n ");
        sbSql.append("                   WHERE A.ITEM_CODE = B.ITEM_CODE                                                   \n ");
        sbSql.append("                     AND A.NEED_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'              \n ");
        sbSql.append("                     AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')                             \n ");
        sbSql.append("                     AND B.ITEM_CLASS1 = 'F'                                                         \n ");
        */
        /*
        sbSql.append("                     AND A.RC_MU_CD = '2002'                                                         \n ");
        
        //sbSql.append("                     AND A.RC_MU_CD = '"+ MU_CD + "'                                                         \n ");
        //sbSql.append("                     AND A.SUBINV_CODE LIKE 'C%'                                                     \n ");
        //sbSql.append("                     AND A.PO_TYPE     = '04'    --dsPOType.FoodAutoFS                               \n ");
        //sbSql.append("                   GROUP BY A.RC_UPJANG                                                              \n ");
        //sbSql.append("                  UNION ALL                                                                          \n ");
        //sbSql.append("                  SELECT A.RC_UPJANG, 0 D2, 0 D1, 0 A1, SUM(A.PO_QTY*A.MARGIN_PRICE) A2, 0 B1, 0 A3        \n ");
        //sbSql.append("                    FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B                                            \n ");
        //sbSql.append("                   WHERE A.ITEM_CODE = B.ITEM_CODE                                                   \n ");
        //sbSql.append("                     AND A.NEED_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'              \n ");
        //sbSql.append("                     AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')                             \n ");
        //sbSql.append("                     AND B.ITEM_CLASS1 = 'F'                                                         \n ");
        */
        /*
        sbSql.append("                     AND A.RC_MU_CD = '2002'                                                         \n ");
        
        sbSql.append("                     AND A.RC_MU_CD = '"+ MU_CD + "'                                                         \n ");
        sbSql.append("                     AND A.SUBINV_CODE LIKE 'C%'                                                     \n ");
        sbSql.append("                     AND A.PO_TYPE    =  '05'   --dsPOType.FoodAutoFS                               \n ");
        sbSql.append("                     AND (NVL(B.SPICE_YN, 'N') = 'N' AND NVL(B.CORN_YN, 'N') = 'N')                  \n ");
        sbSql.append("                   GROUP BY A.RC_UPJANG                                                              \n ");
        sbSql.append("                  UNION ALL                                                                          \n ");
        sbSql.append("                  SELECT A.RC_UPJANG, 0 D2, 0 D1, 0 A1, 0 A2, 0 B1, SUM(A.PO_QTY*A.MARGIN_PRICE) A3  \n ");
        sbSql.append("                    FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B                                            \n ");
        sbSql.append("                   WHERE A.ITEM_CODE = B.ITEM_CODE                                                   \n ");
        sbSql.append("                     AND A.NEED_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'              \n ");
        sbSql.append("                     AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')                             \n ");
        sbSql.append("                     AND B.ITEM_CLASS1 = 'F'                                                         \n ");
        */
        /*
        sbSql.append("                     AND A.RC_MU_CD = '2002'                                                         \n ");
        */
        //sbSql.append("                     AND A.RC_MU_CD = '"+ MU_CD + "'                                                          \n ");
        //sbSql.append("                     AND A.SUBINV_CODE LIKE 'C%'                                                     \n ");
        //sbSql.append("                     AND A.PO_TYPE     = '05'   --dsPOType.FoodAutoFS                               \n ");
        //sbSql.append("                     AND (NVL(B.SPICE_YN, 'N') = 'Y' OR NVL(B.CORN_YN, 'N')  = 'Y')                  \n ");
        //sbSql.append("                   GROUP BY A.RC_UPJANG                                                              \n ");
        //sbSql.append("                  UNION ALL                                                                          \n ");
        /* 재료비 - 실적 - 현재구매 */
        //sbSql.append("                 SELECT /*+ USE_NL(A.HD A.DT) */                                                                                                                                 \n ");
        //sbSql.append("                        TO_CHAR(A.TRANS_UPJANG), 0 D2, 0 D1, 0 A1, 0 A2                                                                                                          \n ");
        //sbSql.append("                      , ROUND(NVL(DECODE(B.OUTVAT_FLAG, 'Y', SUM(MARGIN_AMOUNT * DECODE(TAX_CODE, '100', DECODE(MATERIAL_ACCTCD, '11402000', 1.1, 1))), SUM(MARGIN_AMOUNT)), 0)) B1, 0 A3  \n ");
        //sbSql.append("                   FROM HLDC_PO_TRANSACTION A                                                                                                                                    \n ");
        //sbSql.append("                      , HLDC_PO_SUBINVENTORY B                                                                                                                                   \n ");
        //sbSql.append("                  WHERE A.SUBINV_CODE = B.SUBINV_CODE                                                                                                                            \n ");
        //sbSql.append("                    AND A.TRANS_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'                                                                                          \n ");
        //sbSql.append("                    AND A.TRANS_TYPE LIKE 'I%'        -- 입고                                                                                                                    \n ");
        //sbSql.append("                    AND A.PO_TYP = 'BP'               -- BP : 정산용, UP : 전산구매                                                                                              \n ");
        //sbSql.append("                    AND A.ITEM_CODE LIKE 'F%'         -- 식재료                                                                                                                  \n ");
        //sbSql.append("                  GROUP BY A.TRANS_UPJANG, B.OUTVAT_FLAG                                                                                                                         \n ");
        //sbSql.append("                 )                                                                                   \n ");
        //sbSql.append("           GROUP BY RC_UPJANG                                                                        \n ");
        //sbSql.append("         ) A                                                                                         \n ");
        
        //속도개선 적용 2017.07.12 김호석
        sbSql.append("      SELECT A.RC_UPJANG AS RC_UPJANG  \n ");
        sbSql.append("      	, NVL(SUM(CASE WHEN A.PO_TYPE <> 'MT' AND TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(SUBSTR(A.ORDER_DATE, 1, 8),'YYYYMMDD') >  1 THEN   A.PO_QTY*A.MARGIN_PRICE END),0) AS D2   \n ");
        sbSql.append("      	, NVL(SUM(CASE WHEN A.PO_TYPE <> 'MT' AND TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(SUBSTR(A.ORDER_DATE, 1, 8),'YYYYMMDD') <= 1 THEN   A.PO_QTY*A.MARGIN_PRICE END),0) AS D1  \n ");
        sbSql.append("      	, NVL(SUM(CASE WHEN A.PO_TYPE='04'                                                            THEN A.PO_QTY*A.MARGIN_PRICE END),0) AS A1  \n ");
        sbSql.append("      	, NVL(SUM(CASE WHEN A.PO_TYPE='05' AND ((NVL(B.SPICE_YN,'N')='N' AND NVL(B.CORN_YN,'N')='N')) THEN A.PO_QTY*A.MARGIN_PRICE END),0) AS A2  \n ");
        sbSql.append("      	, 0                                                                                                                                AS B1  \n ");
        sbSql.append("      	, NVL(SUM(CASE WHEN A.PO_TYPE='05' AND ((NVL(B.SPICE_YN,'N')='Y'  OR NVL(B.CORN_YN,'N')='Y')) THEN A.PO_QTY*A.MARGIN_PRICE END),0) AS  A3          \n ");
        sbSql.append("       FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B                                              \n ");
        sbSql.append("      WHERE A.ITEM_CODE = B.ITEM_CODE                                                     \n ");
        sbSql.append("        AND A.NEED_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'               \n ");
        sbSql.append("        AND A.LINE_STATUS IN ('RV', 'PC', 'DL', 'GC', 'IV')                      \n ");         
        sbSql.append("        AND B.ITEM_CLASS1 = 'F'                                                          \n "); 
        sbSql.append("        AND A.RC_MU_CD = '"+ MU_CD +"'                                                          \n ");
        sbSql.append("        AND A.SUBINV_CODE LIKE 'C%'                                                       \n ");
        if(!UPJANG.equals("")) 
        	sbSql.append("        AND A.RC_UPJANG=TO_CHAR('"+ UPJANG +"')   			\n ");
        
        sbSql.append("      GROUP BY A.RC_UPJANG   \n ");
        sbSql.append("      UNION ALL  \n ");
        sbSql.append("      SELECT                                         \n ");                                                                          
        sbSql.append("      	 A.TRANS_UPJANG AS RC_UPJANG  \n ");
        sbSql.append("         , 0 D2  \n ");
        sbSql.append("         , 0 D1  \n ");
        sbSql.append("         , 0 A1  \n ");
        sbSql.append("         , 0 A2                                   \n ");                                                                         
        sbSql.append("         , ROUND(NVL(DECODE(B.OUTVAT_FLAG, 'Y', SUM(MARGIN_AMOUNT * DECODE(TAX_CODE, '100', DECODE(MATERIAL_ACCTCD, '11402000', 1.1, 1))), SUM(MARGIN_AMOUNT)), 0)) B1  \n ");
        sbSql.append("         , 0 A3    \n ");
        sbSql.append("      FROM HLDC_PO_TRANSACTION A                              \n ");                                                                                                        
        sbSql.append("         , HLDC_PO_SUBINVENTORY B                    \n ");                                                                                                                 
        sbSql.append("      WHERE A.SUBINV_CODE = B.SUBINV_CODE           \n ");                                                                                                                   
        sbSql.append("       AND A.TRANS_DATE BETWEEN '"+ START_DATE + "' AND '" + END_DATE + "'           \n ");                                                                                 
        sbSql.append("       AND A.TRANS_TYPE LIKE 'I%'        -- 입고                                                    \n ");                                                                  
        sbSql.append("       AND A.PO_TYP = 'BP'               -- BP : 정산용, UP : 전산구매                                                          \n ");                                      
        sbSql.append("       AND A.ITEM_CODE LIKE 'F%'         -- 식재료    \n "); 
        if(!UPJANG.equals("")) 
        	sbSql.append("       AND A.TRANS_UPJANG =TO_CHAR('"+ UPJANG +"')  \n ");
        
        sbSql.append("      GROUP BY A.TRANS_UPJANG, B.OUTVAT_FLAG     \n ");
        sbSql.append("		)           \n ");                                                                         
    	sbSql.append("		GROUP BY RC_UPJANG   \n ");
        sbSql.append("  ) A   \n ");
                     
        
        
        sbSql.append("       , FSA_UPJANG_V B                                                                              \n ");
        sbSql.append("   WHERE TO_NUMBER(A.RC_UPJANG) = B.UPJANG                                                           \n ");
        
        sbSql.append("     AND B.MU_CD = '"+ MU_CD +"'                                                                     \n ");
        
        if( BONBU.equals("Y") )
        {
        	sbSql.append( " AND (B.TM_CD LIKE '"+ TM_CD2 +"' || '%' OR B.PT_CD LIKE '"+ TM_CD2 +"' || '%')                   \n ");
        }
        else
        {
            if(!TM_CD.equals(""))
                sbSql.append( " AND (B.TM_CD = '"+ TM_CD +"' OR B.PT_CD = '"+ TM_CD +"')                   \n ");        	
        }

        if((!JOB_CD.equals(""))&&(!JOB_CD.equals("000")))
            sbSql.append( " AND B.JOB_CD = '"+ JOB_CD +"'                                                                  \n ");
        if((!SUB_JOB_CD.equals(""))&&(!SUB_JOB_CD.equals("000000")))
            sbSql.append( " AND B.SUB_JOB_CD = '"+ SUB_JOB_CD +"'                                                          \n ");
        //if(!UPJANG.equals(""))
        //    sbSql.append( " AND B.UPJANG = '"+ UPJANG +"'                                                                  \n ");
        sbSql.append( " ORDER BY  TM_NAME, JOB_NAME, SUB_JOB_NAME, UPJANGNM                                                \n ");
        
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        DataSet ds_list1 = this.makeDataSet(rs, "ds_list1"); 
        
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