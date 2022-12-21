<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS식단/구매관리
■ 프로그램ID   : FSP00320V_T001.jsp
■ 프로그램명   : 자재별 소요량 비교(식단예상 소요량, 실제 발주량, 실제 사용량)
■ 작성일자     : 2009-09-09
■ 작성자       : 정영철
■ 이력관리     : 2009-09-09
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
        try     {
                PlatformRequest platformRequest = this.proc_input(request);
                in_vl = platformRequest.getData().getVariableList();
                in_dl = platformRequest.getData().getDataSetList();

                //jsp log 서비스 시작
                logger.startIndividualLog(in_vl.getString("titLogId"));

                //입력 데이타
                DataSet ds_condi     = in_dl.get("ds_condi");
				
                String MU_CD       = nullToBlank(ds_condi.getString(0, "MU_CD"));
                String TM_CD       = nullToBlank(ds_condi.getString(0, "TM_CD"));
                String UPJANG      = nullToBlank(ds_condi.getString(0, "UPJANG"));
                String MENU_DATE   = nullToBlank(ds_condi.getString(0, "MENU_DATE"));
                String NEED_DATE   = nullToBlank(ds_condi.getString(0, "NEED_DATE"));
                String SUBINV_CODE = nullToBlank(ds_condi.getString(0, "SUBINV_CODE"));

                //out 데이타
                DataSet ds_List;
                //sql문 버퍼생성
                StringBuffer sbSql = new StringBuffer();

                //내역조회
                sbSql.append("\n SELECT A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM "                        );
                sbSql.append("\n      , NVL(C.MARGIN_PRICE, 0)                               AS MARGIN_PRICE "   );
                sbSql.append("\n      , ROUND(SUM(A.MENU_QTY / B.KG_CONVERT_RATE / 1000), 2) AS MENU_QTY "       );
                sbSql.append("\n      , SUM(A.PR_QTY)                                        AS PR_QTY "         );
                sbSql.append("\n      , ROUND(SUM(A.OUT_QTY / B.UOM_CONVERT_RATE), 2)        AS OUT_QTY "        );
                sbSql.append("\n   FROM HLDC_PO_ITEM_MST B, "                                                    );
                sbSql.append("\n        (SELECT A.ITEM_CODE"                                                     );
                sbSql.append("\n              , DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, DECODE(E.OUTVAT_FLAG, 'Y' , ( ROUND( (A.CONTRACT_PRICE * DECODE(D.TAX_CODE, '100' , 1.1, 2) * (A.MARGIN_RATE+100) / 100 ) / 10, 2) * 10 ) , ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10, 2) * 10 ) ) ) AS MARGIN_PRICE");
                sbSql.append("\n              , A.UPJANG"                                                        );
                sbSql.append("\n           FROM HLDC_ST_UPJANG B"                                                );
                sbSql.append("\n              , HLDC_PO_SUBINVENTORY E"                                          );
                sbSql.append("\n              , HLDC_PO_CONTRACT_F A"                                            );
                sbSql.append("\n              , HLDC_PO_ITEM_MST D"                                              );
                sbSql.append("\n              , HLDC_PO_PREORDER_LIST F"                                         ); // 선발주제한
                sbSql.append("\n          WHERE A.ITEM_CODE   = D.ITEM_CODE"                                     );
                sbSql.append("\n            AND A.USE_YN      = 'Y'"                                             );
                sbSql.append("\n            AND A.CONTRACT_PRICE > 0"                                            );
                sbSql.append("\n            AND A.UPJANG      = B.AP_UNITPRICE_UPJANG"                           );
                sbSql.append("\n            AND B.UPJANG      = E.UPJANG"                                        );
                sbSql.append("\n            AND A.UPJANG      = '" + UPJANG      + "'"                           );
                sbSql.append("\n            AND E.SUBINV_CODE = '" + SUBINV_CODE + "'"                           ); //[창고코드] FSM_REAL_MENU_MST.SUBINV_CODE 사용(우선적용), FSA_HALL_MST.SUBINV_CODE 사용
                sbSql.append("\n            AND '"+ MENU_DATE +"' BETWEEN A.CONTRACT_START AND A.CONTRACT_END"   ); //[메뉴일자]
                sbSql.append("\n            AND A.CENTER_CODE = F.CENTER_CODE (+)"                               );
                sbSql.append("\n            AND A.ITEM_CODE   = F.ITEM_CODE   (+)) C,"                           );
                sbSql.append("\n        (SELECT B.ITEM_CODE "                                                    );
                sbSql.append("\n              , SUM(B.NEED_QTY * A.EXPECT_MEAL_QTY) AS MENU_QTY  "               );
                sbSql.append("\n              , 0 AS PR_QTY "                                                    );
                sbSql.append("\n              , 0 AS OUT_QTY "                                                   );
                sbSql.append("\n           FROM FSM_REAL_MENU_MST A "                                            );
                sbSql.append("\n              , FSM_REAL_RECIPE_ITEM B "                                         );
                sbSql.append("\n          WHERE A.UPJANG      = B.UPJANG "                                       );
                sbSql.append("\n            AND A.MENU_CD     = B.MENU_CD "                                      );
                sbSql.append("\n            AND A.UPJANG      = '" + UPJANG      + "'"                           );
                sbSql.append("\n            AND A.MENU_DATE   = '" + MENU_DATE   + "'"                           );
                sbSql.append("\n            AND A.SUBINV_CODE = '" + SUBINV_CODE + "'"                           );
                sbSql.append("\n          GROUP BY B.ITEM_CODE "                                                 );
                sbSql.append("\n         ----------- "                                                           );
                sbSql.append("\n          UNION ALL "                                                            );
                sbSql.append("\n         ----------- "                                                           );
                sbSql.append("\n         SELECT A.ITEM_CODE "                                                    );
                sbSql.append("\n              , 0 AS MENU_QTY "                                                  );
                sbSql.append("\n              , SUM(A.PR_QTY) AS PR_QTY "                                        );
                sbSql.append("\n              , 0 AS OUT_QTY "                                                   );
                sbSql.append("\n           FROM SO_PR A "                                                        );
                sbSql.append("\n          WHERE A.RC_UPJANG   = '" + UPJANG      + "'"                           );
                sbSql.append("\n            AND A.SUBINV_CODE = '" + SUBINV_CODE + "'"                           );
                sbSql.append("\n            AND A.NEED_DATE   = '" + NEED_DATE   + "'"                           );
                sbSql.append("\n            AND A.LINE_STATUS NOT IN ('003','005', 'PD', 'PR')"                              );    //신청취소,결의반려 항목 제외
                sbSql.append("\n          GROUP BY A.ITEM_CODE "                                                 );
                sbSql.append("\n         ----------- "                                                           );
                sbSql.append("\n          UNION ALL "                                                            );
                sbSql.append("\n         ----------- "                                                           );
                sbSql.append("\n         SELECT A.ITEM_CODE "                                                    );
                sbSql.append("\n              , 0 AS MENU_QTY "                                                  );
                sbSql.append("\n              , 0 AS PR_QTY "                                                    );
                sbSql.append("\n              , SUM(A.UOM_QTY) AS OUT_QTY "                                      );
                sbSql.append("\n           FROM HLDC_PO_TRANSACTION A "                                          );
                sbSql.append("\n          WHERE A.TRANS_UPJANG = '" + UPJANG      + "'"                          );
                sbSql.append("\n            AND A.SUBINV_CODE  = '" + SUBINV_CODE + "'"                          );
                sbSql.append("\n            AND A.TRANS_DATE   = '" + NEED_DATE   + "'"                          );
                sbSql.append("\n            AND A.TRANS_TYPE LIKE 'O%'"                                          );  //일단 출고전체
                sbSql.append("\n            AND A.TRANS_TYPE <> 'O002%'"                                          );  //일단 출고전체
                sbSql.append("\n          GROUP BY A.ITEM_CODE "                                                 );
                sbSql.append("\n ) A "                                                                           );
                sbSql.append("\n  WHERE A.ITEM_CODE = B.ITEM_CODE "                                              );
                sbSql.append("\n    AND A.ITEM_CODE = C.ITEM_CODE(+) "                                           );
                sbSql.append("\n  GROUP BY A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, C.MARGIN_PRICE "       );
                sbSql.append("\n  HAVING NOT (SUM(A.MENU_QTY) = 0 AND SUM(A.PR_QTY) = 0 AND SUM(A.OUT_QTY) = 0) ");

                out_vl.add("fa_Sql", sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                rs = pstmt.executeQuery();
                ds_List = this.makeDataSet(rs, "ds_list");

                pstmt.close();
                rs.close();

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
