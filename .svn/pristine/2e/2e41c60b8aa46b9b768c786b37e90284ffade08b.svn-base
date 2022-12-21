<%
/*-----------------------------------------------------------------------------
■ 시스템명          : 구매관리/구매신청/추가구매승인여부 조회
■ 프로그램ID    : FSP00030E_T004.jsp
■ 프로그램명        : 추가구매승인여부 조회
■ 작성일자          : 2015-06-03
■ 작성자            : 정영철
■ 이력관리          : 2015-06-03
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);  
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();
        
        //jsp log 서비스 시작 
        logger.startIndividualLog(in_vl.getString("titLogId"));     
        
        String UPJANG       = in_vl.getString("UPJANG");
        
        StringBuffer sbSelSql = new StringBuffer();
    
        sbSelSql.delete(0, sbSelSql.length());
        // 구매신청 가능 여부 점검
        sbSelSql.append("\n /* 추가구매승인여부 조회*/"                                            );
        sbSelSql.append("\n SELECT 'Y' CHK"                                                     );
        sbSelSql.append("\n   FROM FSA_PR_CHECK "                                               );
        sbSelSql.append("\n  WHERE UPJANG = '" + UPJANG + "' "                                  );
        sbSelSql.append("\n    AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN START_DATE AND END_DATE ");
        sbSelSql.append("\n    AND APRV_YN = 'Y' "                                              );
        sbSelSql.append("\n    AND ROWNUM <= 1 "                                                );

        stmt = conn.createStatement();      
        rs = stmt.executeQuery(sbSelSql.toString());            
        
        String strPrAddYN;
        
        if(rs.next())
            strPrAddYN = rs.getString("CHK");
        else
            strPrAddYN = "N";
        
        rs.close();
        stmt.close();
        
        out_vl.add("fv_addApprovYn", strPrAddYN);
        
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