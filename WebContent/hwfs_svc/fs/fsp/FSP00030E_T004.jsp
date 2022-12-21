<%
/*-----------------------------------------------------------------------------
■ 시스템명      : 구매관리/구매신청/구매유형 조회
■ 프로그램ID    : FSP00030E_T004.jsp
■ 프로그램명    : 구매유형조회
■ 작성일자      : 2015-06-03
■ 작성자            : 정영철
■ 이력관리      : 2015-06-03
1) 창고관리자 조인 로직 없어짐
2) 구매팀에서 70여개 유형을 7개로 압축
3) FS사업부와 외식사업부는 특정 구매유형만 조회(윤지혜PI요청)
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        DataSet ds_out;
        StringBuffer sbSelSql = new StringBuffer();
        String MU_CD = nullToBlank(in_vl.getString("MU_CD"));

        sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("\n /*[구매유형 조회]*/"                                                                                                      );
        sbSelSql.append("\n SELECT A.PO_TYPE, A.TYPE_NAME AS PO_TYPE_NM"                                                                            );
        sbSelSql.append("\n      , DECODE(A.D_DAYS,0,'----',TO_CHAR(A.D_DAYS))||'일 '||DECODE(A.D_TIMES,0,'--',TO_CHAR(A.D_TIMES))||'시' AS D_DAY "  );
        sbSelSql.append("\n      , A.D_DAYS"                                                                                                        );
        sbSelSql.append("\n      , A.D_TIMES"                                                                                                       );
        sbSelSql.append("\n      , A.REMARK"                                                                                                        );
        sbSelSql.append("\n   FROM HLDC_PO_TYPE_FS A"                                                                                                  );
        sbSelSql.append("\n  WHERE A.USE_YN   = 'Y'"                                                                                                );
        
        // FS사업부와 외식사업부는 특정 구매유형만 조회(윤지혜PI요청)
        if(!MU_CD.equals(""))
        {
            if(MU_CD.equals("2002"))    // FS 사업부
                sbSelSql.append("\n    AND  A.PO_TYPE  IN ('04','05', '11','96')"                                                                            );
            if(MU_CD.equals("2003"))    // 외식 사업부
            	// 아직 외식자동이 구현되지 않아서 임시로 외식 자동 차단
                //sbSelSql.append("\n    AND  A.PO_TYPE  IN ('98','99')"                                                                                  );
            	sbSelSql.append("\n    AND  A.PO_TYPE  IN ('11','88','96','99')"                                                                                  );
            if(MU_CD.equals("2001"))    // FC 본사는 외식 사업부와 동일하게 추가. 2017.05.02 이혜은과장 요청. 김호석 수정 
            	// 아직 외식자동이 구현되지 않아서 임시로 외식 자동 차단
                //sbSelSql.append("\n    AND  A.PO_TYPE  IN ('98','99')"                                                                                  );
            	//sbSelSql.append("\n    AND  A.PO_TYPE  IN ('99')"
            	//sbSelSql.append("\n    AND  A.PO_TYPE  IN ('88','96','99')"                                                                                  );
            	//상품개발팀 사용으로 구매유형 변경 20200702 정지언
            	sbSelSql.append("\n    AND  A.PO_TYPE  IN ('05','96')"    );
        }

        sbSelSql.append(" ORDER BY 2 \n"                                                                                                            );
        sbSelSql.append("\n"                                                                                                                        );

        stmt = conn.createStatement();
        rs = stmt.executeQuery(sbSelSql.toString());

        ds_out = this.makeDataSet(rs,"ds_out");
        out_dl.add(ds_out);

        this.setResultMessage(0, "OK",out_vl);

    } catch(Exception ex) {
        //ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
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
            //jsp log 서비스 닫기
            try {
                logger.endIndividualLog();
            } catch( Exception logE) {
                logE.printStackTrace();
            }
        }

      proc_output(response,out,out_vl,out_dl);

%>