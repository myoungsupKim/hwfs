<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
				
			String FROM 		= nullToBlank(in_vl.getString("FROM"));		
			String g_CustCd		= nullToBlank(in_vl.getString("g_CustCd"));
			
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT SEQ_ID,\n");
		sbSql.append("       (SELECT CENTER_NAME FROM PO_CENTER WHERE CENTER_CODE = B.CENTER_CODE) CENTER_NAME,\n");
		sbSql.append("       ITEM_CLASS2_NM, --평가부문,\n");
		sbSql.append("       SAUPNO, --사업자번호,\n");
		sbSql.append("       CUSTNM, --업체명,\n");
		sbSql.append("       C_PER_TELNO, --전화번호,\n");
		sbSql.append("       ADDR, --주소,\n");
		sbSql.append("       SCORE1, --품질,\n");
		sbSql.append("       SCORE2, --가격,\n");
		sbSql.append("       SCORE3, --배송,\n");
		sbSql.append("       SCORE4, --협조도,\n");
		sbSql.append("       SCORE5, --벌점,\n");
		sbSql.append("       SCORE6, --총점,\n");
		sbSql.append("       ROWNUM RANK_NO, --순위,\n");
		sbSql.append("       (\n");
		sbSql.append("        CASE WHEN SCORE6 >= 90 THEN 'A'\n");
		sbSql.append("             WHEN SCORE6 >= 70 AND SCORE6 <= 89 THEN 'B'\n");
		sbSql.append("             ELSE 'C'\n");
		sbSql.append("        END\n");
		sbSql.append("       ) GRADE, --등급,\n");
		sbSql.append("       UPDATE_BY_NM -- 평가자\n");
		sbSql.append("  FROM (\n");
		sbSql.append("        SELECT V.SEQ_ID,\n");
		sbSql.append("               (SELECT CLASS_NAME FROM PO_ITEM_CLASS WHERE CLASS_CODE = V.ITEM_CLASS2) ITEM_CLASS2_NM,  --평가부문,\n");
		sbSql.append("               A.SAUPNO,      --사업자번호,\n");
		sbSql.append("               A.CUSTNM,      --업체명,\n");
		//=========================================================================================
		// (2013-09-03 수정) 시작
		// 김장욱 2013-09-03 양방향 암호화
		//=========================================================================================			
		//sbSql.append("               A.C_PER_TELNO, --전화번호,\n");
		//sbSql.append("               A.ADDR,        --주소,\n");
		sbSql.append("               SC_CRYPTO_FUN('DEC', A.C_PER_TELNO_ENC, 4) AS C_PER_TELNO, --전화번호,\n");
		sbSql.append("               SC_CRYPTO_FUN('DEC', A.ADDR_ENC, 6) AS ADDR,        --주소,\n");
		
		//=========================================================================================
		//(2013-09-03 수정) 끝
		//=========================================================================================
			
		sbSql.append("               (SELECT SUM(DECODE(A.ATTR2, '정성', B.SCORE,\n");
		sbSql.append("                                  A.WEIGHTING * NVL(DECODE(B.SCORE, 1, A.ATTR1_SCORE,\n");
		sbSql.append("                                                                    2, A.ATTR2_SCORE,\n");
		sbSql.append("                                                                    3, A.ATTR3_SCORE,\n");
		sbSql.append("                                                                    4, A.ATTR4_SCORE,\n");
		sbSql.append("                                                                    5, A.ATTR5_SCORE), 0)))\n");
		sbSql.append("                FROM PO_CUST_PARITY A,\n");
		sbSql.append("                     PO_CUST_PARITY_DETAIL B\n");
		sbSql.append("                WHERE (A.SEQ_ID  = B.ATTR) AND (A.ATTR3 = '품질') AND (B.SEQ_ID = V.SEQ_ID)) SCORE1,    -- 품질,\n");
		sbSql.append("               (SELECT SUM(DECODE(A.ATTR2, '정성', B.SCORE,\n");
		sbSql.append("                                  A.WEIGHTING * NVL(DECODE(B.SCORE, 1, A.ATTR1_SCORE,\n");
		sbSql.append("                                                                    2, A.ATTR2_SCORE,\n");
		sbSql.append("                                                                    3, A.ATTR3_SCORE,\n");
		sbSql.append("                                                                    4, A.ATTR4_SCORE,\n");
		sbSql.append("                                                                    5, A.ATTR5_SCORE), 0)))\n");
		sbSql.append("                FROM PO_CUST_PARITY A,\n");
		sbSql.append("                     PO_CUST_PARITY_DETAIL B\n");
		sbSql.append("                WHERE (A.SEQ_ID  = B.ATTR) AND (A.ATTR3 = '가격') AND (B.SEQ_ID = V.SEQ_ID)) SCORE2,    -- 가격,\n");
		sbSql.append("               (SELECT SUM(DECODE(A.ATTR2, '정성', B.SCORE,\n");
		sbSql.append("                                  A.WEIGHTING * NVL(DECODE(B.SCORE, 1, A.ATTR1_SCORE,\n");
		sbSql.append("                                                                    2, A.ATTR2_SCORE,\n");
		sbSql.append("                                                                    3, A.ATTR3_SCORE,\n");
		sbSql.append("                                                                    4, A.ATTR4_SCORE,\n");
		sbSql.append("                                                                    5, A.ATTR5_SCORE), 0)))\n");
		sbSql.append("                FROM PO_CUST_PARITY A,\n");
		sbSql.append("                     PO_CUST_PARITY_DETAIL B\n");
		sbSql.append("                WHERE (A.SEQ_ID  = B.ATTR) AND (A.ATTR3 = '배송') AND (B.SEQ_ID = V.SEQ_ID)) SCORE3,    -- 배송,\n");
		sbSql.append("               (SELECT SUM(DECODE(A.ATTR2, '정성', B.SCORE,\n");
		sbSql.append("                                  A.WEIGHTING * NVL(DECODE(B.SCORE, 1, A.ATTR1_SCORE,\n");
		sbSql.append("                                                                    2, A.ATTR2_SCORE,\n");
		sbSql.append("                                                                    3, A.ATTR3_SCORE,\n");
		sbSql.append("                                                                    4, A.ATTR4_SCORE,\n");
		sbSql.append("                                                                    5, A.ATTR5_SCORE), 0)))\n");
		sbSql.append("                FROM PO_CUST_PARITY A,\n");
		sbSql.append("                     PO_CUST_PARITY_DETAIL B\n");
		sbSql.append("                WHERE (A.SEQ_ID  = B.ATTR) AND (A.ATTR3 = '협조도') AND (B.SEQ_ID = V.SEQ_ID)) SCORE4,    -- 협조도,\n");
		sbSql.append("               (SELECT SUM(DECODE(A.ATTR2, '정성', B.SCORE,\n");
		sbSql.append("                                  A.WEIGHTING * NVL(DECODE(B.SCORE, 1, A.ATTR1_SCORE,\n");
		sbSql.append("                                                                    2, A.ATTR2_SCORE,\n");
		sbSql.append("                                                                    3, A.ATTR3_SCORE,\n");
		sbSql.append("                                                                    4, A.ATTR4_SCORE,\n");
		sbSql.append("                                                                    5, A.ATTR5_SCORE), 0)))\n");
		sbSql.append("                FROM PO_CUST_PARITY A,\n");
		sbSql.append("                     PO_CUST_PARITY_DETAIL B\n");
		sbSql.append("                WHERE (A.SEQ_ID  = B.ATTR) AND (A.ATTR3 = '벌점') AND (B.SEQ_ID = V.SEQ_ID)) SCORE5,    -- 벌점,\n");
		sbSql.append("               (SELECT SUM(DECODE(A.ATTR2, '정성', B.SCORE,\n");
		sbSql.append("                                  A.WEIGHTING * NVL(DECODE(B.SCORE, 1, A.ATTR1_SCORE,\n");
		sbSql.append("                                                                    2, A.ATTR2_SCORE,\n");
		sbSql.append("                                                                    3, A.ATTR3_SCORE,\n");
		sbSql.append("                                                                    4, A.ATTR4_SCORE,\n");
		sbSql.append("                                                                    5, A.ATTR5_SCORE), 0)))\n");
		sbSql.append("                FROM PO_CUST_PARITY A,\n");
		sbSql.append("                     PO_CUST_PARITY_DETAIL B\n");
		sbSql.append("                WHERE (A.SEQ_ID  = B.ATTR) AND (B.SEQ_ID = V.SEQ_ID)) SCORE6,    -- 총점,\n");
		sbSql.append("                (SELECT NM_KOR FROM HR_PERSONAL WHERE SABUN = V.UPDATE_BY) UPDATE_BY_NM, -- 평가자,\n");
		sbSql.append("                V.PARITY_YM, -- 해당월,\n");
		sbSql.append("                V.CUSTCD, -- 거래처코드,\n");
		sbSql.append("                V.CENTER_CODE, -- 센터코드,\n");
		sbSql.append("                NVL(V.ATTR1, 'N') ATTR1_NM -- 완료\n");
		sbSql.append("          FROM PO_CUST_PARITY_MASTER V,\n");
		sbSql.append("               ST_CUST A\n");
		sbSql.append("        WHERE (V.CUSTCD      = A.CUSTCD)\n");
		sbSql.append("        AND   (V.ATTR1       = 'Y')\n");
		sbSql.append("        AND   (V.PARITY_YM   = '"+FROM+"')\n");
		sbSql.append("        AND   (V.CUSTCD      = '"+g_CustCd+"')  -- [g_CustCd]\n");
		sbSql.append("        ORDER BY (SELECT SUM(DECODE(A.ATTR2, '정성', B.SCORE,\n");
		sbSql.append("                                  A.WEIGHTING * NVL(DECODE(B.SCORE, 1, A.ATTR1_SCORE,\n");
		sbSql.append("                                                                    2, A.ATTR2_SCORE,\n");
		sbSql.append("                                                                    3, A.ATTR3_SCORE,\n");
		sbSql.append("                                                                    4, A.ATTR4_SCORE,\n");
		sbSql.append("                                                                        5, A.ATTR5_SCORE), 0)))\n");
		sbSql.append("                    FROM PO_CUST_PARITY A,\n");
		sbSql.append("                         PO_CUST_PARITY_DETAIL B\n");
		sbSql.append("                    WHERE (A.SEQ_ID  = B.ATTR) AND (B.SEQ_ID = V.SEQ_ID)) DESC\n");
		sbSql.append("       ) B\n");
		
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);

	   	this.setResultMessage(0, "OK",out_vl);
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