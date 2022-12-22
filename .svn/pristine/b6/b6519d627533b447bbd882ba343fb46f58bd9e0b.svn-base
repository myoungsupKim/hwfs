<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Statement stmt          =  null;
    CallableStatement cstmt = null;

    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //오토커밋 강제 false
        conn.setAutoCommit(false);

        String g_EmpNo 			= nullToBlank(in_vl.getString("g_EmpNo"));
        String REMV_DAY         = nullToBlank(in_vl.getString("REMV_DAY"));
        String UPJANG           = nullToBlank(in_vl.getString("UPJANG"));
        String MU_CD            = nullToBlank(in_vl.getString("MU_CD"));
        String CC_CD            = nullToBlank(in_vl.getString("CC_CD"));
        String CUSTCD           = nullToBlank(in_vl.getString("CUSTCD"));
        String CONTRACT_AMT     = nullToZero(in_vl.getString("CONTRACT_AMT"));
        String REMV_AMT         = nullToZero(in_vl.getString("REMV_AMT"));
        String REMV_QTY         = nullToZero(in_vl.getString("REMV_QTY"));
        String RECEIPT_NUM      = nullToBlank(in_vl.getString("RECEIPT_NUM"));

        StringBuffer sbSql = new StringBuffer();

        // 마감 체크
        sbSql.append("   SELECT DECODE(COUNT(*), 0, 'N', 'Y') AS CLOSE_YN  \n");
        sbSql.append("     FROM MAS_CLOSE_MGMT                  \n");
        sbSql.append("    WHERE UPJANG = '"  + UPJANG + "'      \n");
        sbSql.append("      AND CLOSE_DATE = '" + REMV_DAY + "' \n");
        sbSql.append("      AND CLOSE_GUBUN = '008'             \n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();

        if(rs.getString("CLOSE_YN").equals("Y")) {
            this.setResultMessage(-1, "매출이 마감되어 등록이 불가합니다.", out_vl);
               proc_output(response,out,out_vl,out_dl);
               return;
        }

        String trGbn = "IFIS";
         if(Double.parseDouble(REMV_QTY) == 0) {
            trGbn = "IFISD";
        }

        // 매출등록 프로시져 호출
        cstmt = conn.prepareCall( "{call LTM_IF_SLA_SALESINFO_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
        int idx = 1;
        cstmt.setString(idx++, trGbn);        // 1 : 업무구분(LIMS:연구소, IFIS:IFIS, FTP:식재도매)
        cstmt.setString(idx++, "");            // 2 : 일련번호 (사용안함)
        cstmt.setString(idx++, REMV_DAY);      // 3 : 발생일자
        cstmt.setString(idx++, UPJANG);        // 4 : 관리업장코드
        cstmt.setString(idx++, MU_CD);         // 5 : 관리 MU 코드
        cstmt.setString(idx++, CC_CD);         // 6 : 관리 CC 코드
        cstmt.setString(idx++, CUSTCD);        // 7 : 거래처번호
        cstmt.setString(idx++, "1");           // 8 : 1:과세, 2:면세
        cstmt.setBigDecimal(idx++, new BigDecimal(CONTRACT_AMT));  // 9 : 단가
        cstmt.setBigDecimal(idx++, new BigDecimal(REMV_AMT));  // 10 : 금액
        cstmt.setBigDecimal(idx++, new BigDecimal(REMV_QTY));  // 11 : 판매수량
        cstmt.setString(idx++, g_EmpNo);       // 12 : 등록자
        cstmt.setString(idx++, RECEIPT_NUM);   // 13 : 영수증번호
        cstmt.setString(idx++, "7");           // 14 : 지불코드 - 7:후불(외상)
        cstmt.setString(idx++, "");            // 15 : 가맹점번호
        cstmt.setString(idx++, "");            // 16 : 카드구분(1:신용, 2:체크)
        cstmt.registerOutParameter(idx++, Types.VARCHAR);  // 17 : 오류코드
        cstmt.registerOutParameter(idx++, Types.VARCHAR);  // 18 : 오류메시지
        cstmt.registerOutParameter(idx++, Types.VARCHAR);  // 19 : 영수증번호
        cstmt.execute();

        if(cstmt.getString(17).equals("E"))
        {
            conn.rollback();
            this.setResultMessage(-1, cstmt.getString(18), out_vl);
               proc_output(response,out,out_vl,out_dl);
               return;
        }

        // 영수증번호가 화면에서 넘어왔을 경우 영수증번호를 업데이트하지 않는다.
        if(RECEIPT_NUM.equals("")) {

            // 영수증번호
            RECEIPT_NUM = cstmt.getString(19);

            // 영수증번호 수정
            sbSql.delete(0, sbSql.length());
            sbSql.append("UPDATE MAS_DC_OIL_MGMT \n");
            sbSql.append("   SET RECEIPT_NUM = '" + RECEIPT_NUM + "' \n");
            sbSql.append("     , RECEIPT_YN = 'Y' \n");
            sbSql.append(" WHERE UPJANG = '"  + UPJANG + "' \n");
            sbSql.append("   AND CUSTCD = '"  + CUSTCD + "' \n");
            sbSql.append("   AND REG_DD = '" + REMV_DAY + "' \n");
            sbSql.append("   AND RECEIPT_NUM IS NULL \n");

            stmt = conn.createStatement();
            stmt.execute(sbSql.toString());
            stmt.close();
        } else {
            // 매출등록 취소일 경우
            if(trGbn.equals("IFISD")) {
                sbSql.delete(0, sbSql.length());
                sbSql.append("UPDATE MAS_DC_OIL_MGMT \n");
                sbSql.append("   SET RECEIPT_YN = 'N' \n");
                sbSql.append(" WHERE UPJANG = '"  + UPJANG + "' \n");
                sbSql.append("   AND CUSTCD = '"  + CUSTCD + "' \n");
                sbSql.append("   AND REG_DD = '" + REMV_DAY + "' \n");
            } else {
                sbSql.delete(0, sbSql.length());
                sbSql.append("UPDATE MAS_DC_OIL_MGMT \n");
                sbSql.append("   SET RECEIPT_YN = 'Y' \n");
                sbSql.append(" WHERE UPJANG = '"  + UPJANG + "' \n");
                sbSql.append("   AND CUSTCD = '"  + CUSTCD + "' \n");
                sbSql.append("   AND REG_DD = '" + REMV_DAY + "' \n");
            }
            stmt = conn.createStatement();
            stmt.execute(sbSql.toString());
            stmt.close();
        }

        conn.commit();
           this.setResultMessage(0, "OK", out_vl);

    } catch(Exception ex) {
        conn.rollback();
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
        if(cstmt != null) {
            try {
                cstmt.close();
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