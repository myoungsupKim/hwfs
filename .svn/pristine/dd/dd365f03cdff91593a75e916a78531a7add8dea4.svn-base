<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page import="java.math.BigDecimal" %>
<%
	CallableStatement cstmt = null;

	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_cond     = in_dl.get("ds_cond");
		DataSet ds_list     = in_dl.get("ds_list");

		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Name       = nullToBlank(in_vl.getString("g_Name"));
		String g_Deptid     = nullToBlank(in_vl.getString("g_Deptid"));
		String sType        = nullToBlank(in_vl.getString("sType"));

		StringBuffer sbSql = new StringBuffer();

		/* 주문 취소 */
		for( int i = 0; i < ds_list.getRemovedRowCount(); i++ )
		{
			String IF_FLAG		  = nullToBlank(ds_list.getRemovedData(i, "IF_FLAG").toString());				// 구매정산여부
			String SEASON_NUM     = nullToBlank(ds_list.getRemovedData(i, "SEASON_NUM").toString());			// 시즌번호
			String SP_ID          = nullToBlank(ds_list.getRemovedData(i, "SP_ID").toString());					// 주문번호
			String ITEM_CODE      = nullToBlank(ds_list.getRemovedData(i, "ITEM_CODE").toString());				// 자재코드
			String ITEM_NAME      = nullToBlank(ds_list.getRemovedData(i, "ITEM_NAME").toString());				// 자재명
			String TAX_CODE_GBN   = nullToBlank(ds_list.getRemovedData(i, "TAX_CODE_GBN").toString());			// 과세구분
			String LINE_STATUS    = nullToBlank(ds_list.getRemovedData(i, "LINE_STATUS").toString());			// 주문상태
			String RQ_SABUN       = nullToBlank(ds_list.getRemovedData(i, "RQ_SABUN").toString());				// 신청자사번
			String PAY_TIME       = nullToBlank(ds_list.getRemovedData(i, "PAY_TIME").toString());				// 정산일
			String RECEIPT_NUM    = nullToBlank(ds_list.getRemovedData(i, "RECEIPT_NUM").toString());			// 매출영수증번호
			String SALE_AMOUNT    = nullToBlank(ds_list.getRemovedData(i, "ORG_SALE_AMOUNT").toString());		// 판매금액
			String TOT_AMOUNT     = nullToBlank(ds_list.getRemovedData(i, "ORG_TOT_AMOUNT").toString());		// 총판매금액
			String PR_QTY         = nullToBlank(ds_list.getRemovedData(i, "ORG_PR_QTY").toString());			// 판매수량
			String PAY_METHOD     = nullToBlank(ds_list.getRemovedData(i, "ORG_PAY_METHOD").toString());		// 결제방식
			String APPRV_NUM      = "";
			String CARD_CLASS     = "";
			String FRNC_STOR_NUM  = "";
			String INST_PERIOD    = "";
			String CARD_YYMM      = "";
			if( PAY_METHOD.equals("2") )
			{
				INST_PERIOD    = nullToBlank(ds_list.getRemovedData(i, "ORG_INST_PERIOD").toString());			// 카드할부기간
				CARD_CLASS     = nullToBlank(ds_list.getRemovedData(i, "ORG_CARD_CLASS").toString());			// 카드구분
				CARD_YYMM      = nullToBlank(ds_list.getRemovedData(i, "ORG_CARD_YYMM").toString());			// 카드유효기간
				APPRV_NUM      = nullToBlank(ds_list.getRemovedData(i, "ORG_APPRV_NUM").toString());			// 카드승인번호
				FRNC_STOR_NUM  = nullToBlank(ds_list.getRemovedData(i, "ORG_FRNC_STOR_NUM").toString());		// 카드가맹점번호
			}
			String AR_CUSTCD      = "";
			if( PAY_METHOD.equals("E") )
				AR_CUSTCD      = nullToBlank(ds_list.getRemovedData(i, "ORG_AR_CUSTCD").toString());			// 거래처코드

			if( IF_FLAG.equals("Y") )
			{
                out_vl.add("v_spClose", ITEM_CODE + "[" + ITEM_NAME +"]" + " 구매정산이 완료 되어 삭제가 불가합니다.");
                this.setResultMessage(0, "OK", out_vl);
                proc_output(response, out, out_vl, out_dl);
                return;
			}

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 서버날짜 조회 */ \n");
			sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD') AS TODAY \n");
			sbSql.append("     , TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR(ADD_MONTHS('" + PAY_TIME + "', 0), 'YYYYMM')||'01', 'YYYYMMDD')), 'YYYYMMDD') AS LASTDAY \n");
			sbSql.append("     , TO_CHAR(TO_DATE(TO_CHAR(ADD_MONTHS('" + PAY_TIME + "', 0), 'YYYYMM'), 'YYYYMM'), 'YYYY\"년\"MM\"월\"') AS STR_MONTH \n");
			sbSql.append("     , TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR(ADD_MONTHS('" + PAY_TIME + "', 0), 'YYYYMM')||'01', 'YYYYMMDD')), 'YYYY\"년\"MM\"월\"DD\"일\"') AS STR_DAY \n");
			sbSql.append("  FROM DUAL \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			String toDay = rs.getString("TODAY");
			String lastDay = rs.getString("LASTDAY");
			String sMonth = rs.getString("STR_MONTH");
			String sDay = rs.getString("STR_DAY");

			rs.close();
			pstmt.close();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉귀속부서 조회 */ \n");
			sbSql.append("SELECT COUNT(*) AS CNT \n");
			sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
			sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
			sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
			sbSql.append("   AND A.GB_JAEJIK <> 'RA' \n");
			sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
			sbSql.append("   AND B.SEASON_NUM = '" + SEASON_NUM + "' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			int cnt = rs.getInt("CNT");

			rs.close();
			pstmt.close();

			String UPJANG = "";
			String MU_CD  = "";
			String CC_CD  = "";
			String CUSTCD = "";

			// 예외처리
			if( cnt > 0 )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 신청자 소속 정보 조회 */ \n");
				sbSql.append("SELECT A.SABUN \n");
				sbSql.append("     , (SELECT Z.MU_CD FROM HLDC_SC_DEPT_V Z WHERE Z.CC_CD = B.ATTR_CC_CD) AS MU_CD \n");
				sbSql.append("     , B.ATTR_CC_CD AS CC_CD \n");
				sbSql.append("     , B.UPJANG \n");
				if( PAY_METHOD.equals("E") )
				{
					sbSql.append("     , '" + AR_CUSTCD + "' AS CUST_CD \n");
				}
				else
				{
					sbSql.append("     , A.CUSTCD AS CUST_CD \n");	
				}
				sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
				sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
				sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
				sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
				sbSql.append("   AND B.SEASON_NUM = '" + SEASON_NUM + "' \n");
			}
			// 일반제조
			else
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT CASE WHEN C.CODE IS NULL THEN A.CST_PLNKGVRN_CLASS_CD ELSE 'SG' END AS CST_PLNKGVRN_CLASS_CD \n");
				sbSql.append("  FROM SCC_CC A \n");
				sbSql.append("   	left OUTER JOIN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0300') C ON A.ATTR04 = C.CODE \n");
				sbSql.append("     , HLDC_HR_PERSONAL B \n");
				sbSql.append(" WHERE A.CC_CD = B.CC_CD \n");
				sbSql.append("   AND B.SABUN = '" + RQ_SABUN + "' \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				rs.next();

				String cstPlnkgvrnClassCd = rs.getString("CST_PLNKGVRN_CLASS_CD");

				rs.close();
				pstmt.close();

				if( cstPlnkgvrnClassCd.equals("CG") )
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("/* 신청자 소속 정보 조회 */ \n");
			        sbSql.append("SELECT A.SABUN \n");
		       		sbSql.append("     , A.CC_CD \n");
					sbSql.append("     , B.MU_CD \n");
					sbSql.append("     , C.UPJANG \n");
					if( PAY_METHOD.equals("E") )
					{
						sbSql.append("     , '" + AR_CUSTCD + "' AS CUST_CD \n");
					}
					else
					{
						sbSql.append("     , A.CUSTCD AS CUST_CD \n");	
					}
			        sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
					sbSql.append("     , HLDC_SC_DEPT_V B \n");
					sbSql.append("     , ST_UPJANG C \n");
			        sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
			        sbSql.append("   AND A.CC_CD = C.CC_CD \n");
			        sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
				}
				else
				{
	                out_vl.add("v_spClose", "신청자의 판관 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}
			}

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			if( rs.next() )
			{
				UPJANG = nullToBlank(rs.getString("UPJANG"));
				MU_CD  = nullToBlank(rs.getString("MU_CD"));
				CC_CD  = nullToBlank(rs.getString("CC_CD"));
				CUSTCD = nullToBlank(rs.getString("CUST_CD"));

				if( UPJANG.equals("")  || MU_CD.equals("")  || CC_CD.equals("")  || CUSTCD.equals("") )
				{
	                out_vl.add("v_spClose", "신청자의 소속 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}
			}
			else
			{
                out_vl.add("v_spClose", "신청자의 소속 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
                this.setResultMessage(0, "OK", out_vl);
                proc_output(response, out, out_vl, out_dl);
                return;
			}

			rs.close();
			pstmt.close();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 매출 월마감 확인 */ \n");
			sbSql.append("SELECT X.YN \n");
			sbSql.append("  FROM ( \n");
			sbSql.append("        SELECT CLOSE_GUBUN \n");
			sbSql.append("             , UPJANG \n");
			sbSql.append("             , CLOSE_DATE \n");
			sbSql.append("             , DECODE(YN||YN1, 'NN', 'N', 'Y') AS YN \n");
			sbSql.append("             , DECODE(YN||YN1, 'NN', '미마감', '마감') AS NOTE \n");
			sbSql.append("          FROM ( \n");
			sbSql.append("                SELECT '009' AS CLOSE_GUBUN \n");
			sbSql.append("                     , " + UPJANG + " AS UPJANG \n");
			sbSql.append("                     , MM||DD AS CLOSE_DATE \n");
			sbSql.append("                     , DECODE((SELECT COUNT(*) FROM SLA_IF_UPJANG_SALS_DETAIL WHERE UPJANG_CD = " + UPJANG + " AND OCCUR_DATE = A.MM||B.DD AND DDDD_CLOSE_YN = 'Y' AND SYS_CLASS = '17'), 0, 'N' ,'Y') AS YN \n");
			sbSql.append("                     , DECODE((SELECT COUNT(*) FROM MAS_CLOSE_MGMT WHERE UPJANG = " + UPJANG + " AND CLOSE_GUBUN = '009' AND CLOSE_DATE = A.MM||B.DD), 0, 'N', 'Y') AS YN1 \n");
			sbSql.append("                  FROM (SELECT '" + PAY_TIME.substring(0, 6) + "' AS MM FROM DUAL) A \n");
			sbSql.append("                     , (SELECT LPAD(ROWNUM, 2, '0') AS DD FROM DICT WHERE ROWNUM <= 31) B \n");
			sbSql.append("                 WHERE TO_CHAR(LAST_DAY(TO_DATE(A.MM||'01', 'YYYYMMDD')), 'DD') >= B.DD \n");
			sbSql.append("               ) \n");
			sbSql.append("       ) X \n");
			sbSql.append(" WHERE X.CLOSE_DATE = TO_CHAR(LAST_DAY(TO_DATE('" + PAY_TIME.substring(0, 6) + "' ||'01', 'YYYYMMDD')), 'YYYYMMDD') \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			String closeMonth_yn = nullToBlank(rs.getString("YN"));

			rs.close();
			pstmt.close();

			if( !closeMonth_yn.equals("N") )
			{
				out_vl.add("v_spClose", "해당 업장의 " + sMonth + " 매출 마감이 처리되어 " + ITEM_NAME + "(" + ITEM_CODE +  ") 상품을 주문취소 할 수 없습니다.");
			   	this.setResultMessage(0, "OK", out_vl);
			   	proc_output(response, out, out_vl, out_dl);
			   	return;
			}

			String payDay = "";	// 매출 발생일

			// 정산월과 현재월이 같다면 취소 매출 발생일은 현재일로 한다.
			if( PAY_TIME.substring(0, 6).equals(toDay.substring(0, 6)))
			{
				payDay = toDay;
			}
			// 정산월이 다르면 정산일, 정산월 마지막일의 일마감을 체크한다.
			else
			{
				String closeDay_yn = "";

				// 정산일 일마감 체크
				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 매출 일마감 확인 */ \n");
				sbSql.append("SELECT CASE WHEN COUNT(1) = 0 THEN 'N' \n");
				sbSql.append("            ELSE 'Y' \n");
				sbSql.append("       END CLOSE_YN \n");
				sbSql.append("  FROM SLA_IF_UPJANG_SALS_MST \n");
				sbSql.append(" WHERE OCCUR_DATE = '" + PAY_TIME + "' \n");
				sbSql.append("   AND SYS_CLASS = '17' \n");
				sbSql.append("   AND UPJANG_CD = '"  + UPJANG + "' \n");
				sbSql.append("   AND DDDD_CLOSE_YN = 'Y' \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				rs.next();

				closeDay_yn =  rs.getString("CLOSE_YN");

				rs.close();
				pstmt.close();

				// 정산일의 일마감이 처리됐다면 정산월의 마지막일의 일마감을 체크한다.
				if( closeDay_yn.equals("Y") )
				{
					// 정산월 마지막일 일마감 체크
					sbSql.delete(0, sbSql.length());
					sbSql.append("/* 매출 일마감 확인 */ \n");
					sbSql.append("SELECT CASE WHEN COUNT(1) = 0 THEN 'N' \n");
					sbSql.append("            ELSE 'Y' \n");
					sbSql.append("       END CLOSE_YN \n");
					sbSql.append("  FROM SLA_IF_UPJANG_SALS_MST \n");
					sbSql.append(" WHERE OCCUR_DATE = '" + lastDay + "' \n");
					sbSql.append("   AND SYS_CLASS = '17' \n");
					sbSql.append("   AND UPJANG_CD = '"  + UPJANG + "' \n");
					sbSql.append("   AND DDDD_CLOSE_YN = 'Y' \n");

					pstmt = conn.prepareStatement(sbSql.toString());
					rs = pstmt.executeQuery();
					rs.next();

					closeDay_yn =  rs.getString("CLOSE_YN");

					rs.close();
					pstmt.close();

					if( closeDay_yn.equals("Y") )
					{
						out_vl.add("v_spClose", "해당 업장의 " + sDay + " 매출 마감이 처리되어 " + ITEM_NAME + "(" + ITEM_CODE +  ") 상품을 주문취소 할 수 없습니다.");
					   	this.setResultMessage(0, "OK", out_vl);
					   	proc_output(response, out, out_vl, out_dl);
					   	return;
					}
					else
					{
						payDay = lastDay;
					}

				}
				// 정산일에 일마감 처리가 안됐다면 매출 취소일은 정산일이 된다.
				else
				{
					payDay = PAY_TIME;
				}
			}

			if( PAY_METHOD.equals("E") )	PAY_METHOD = "8";

			String cardClass = "";
			if( PAY_METHOD.equals("2") )
			{
				if( CARD_CLASS.equals("신용") )
					cardClass = "1";
				else
					cardClass = "2";
			}

			// 매출등록 프로시져 호출
			cstmt = conn.prepareCall( "{call LTM_IF_SLA_SALESINFO_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
			int idx = 1;
			cstmt.setString(idx++, "SPEC");								// 업무구분(LIMS:연구소, IFIS:IFIS, FTP:식재도매, SPEC:판촉상품)
		    cstmt.setString(idx++, "");									// 일련번호 (사용안함)
		    cstmt.setString(idx++, payDay);								// 발생일자
		    cstmt.setString(idx++, UPJANG);								// 관리업장코드
		    cstmt.setString(idx++, MU_CD);								// 관리 MU 코드
		    cstmt.setString(idx++, CC_CD);								// 관리 CC 코드
		    cstmt.setString(idx++, CUSTCD);								// 거래처번호
		    cstmt.setString(idx++, TAX_CODE_GBN);						// 1:과세, 2:면세
		    cstmt.setBigDecimal(idx++, new BigDecimal(SALE_AMOUNT));	// 판매금액
		    cstmt.setInt(idx++, (Integer.parseInt(TOT_AMOUNT)*-1));		// 금액
		    cstmt.setInt(idx++, (Integer.parseInt(PR_QTY)*-1));			// 판매수량
		    cstmt.setString(idx++, RQ_SABUN);							// 신청자
		    cstmt.setString(idx++, "");									// 영수증번호
		    cstmt.setString(idx++, PAY_METHOD);							// 결제방식
		    cstmt.setString(idx++, FRNC_STOR_NUM);						// 가맹점번호
		    cstmt.setString(idx++, cardClass);							// 카드구분(1:신용카드, 2:체크카드)
			cstmt.registerOutParameter(idx++, Types.VARCHAR);			// 오류코드
			cstmt.registerOutParameter(idx++, Types.VARCHAR);			// 오류메시지
			cstmt.registerOutParameter(idx++, Types.VARCHAR);			// 영수증번호
			cstmt.execute();

			if( cstmt.getString(17).equals("E") )
			{
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(18), out_vl);
			   	proc_output(response, out, out_vl, out_dl);
			   	return;
			}

			// 특판주문 히스토리 저장
			String histSql = sale_hist_sql(SP_ID, g_EmpNo);

			pstmt = conn.prepareStatement(histSql.toString());
			pstmt.executeUpdate();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 입출고내역 저장 */ \n");
			sbSql.append("INSERT INTO FSP_PO_SPECIAL_TRANS \n");
	        sbSql.append("(  SEASON_NUM \n");
	        sbSql.append(" , ITEM_CODE \n");
	        sbSql.append(" , TRANS_DATE \n");
	        sbSql.append(" , INOUT \n");
	        sbSql.append(" , PRICE \n");
	        sbSql.append(" , QTY \n");
	        sbSql.append(" , AMOUNT \n");
	        sbSql.append(" , SP_ID \n");
	        sbSql.append(" , REMARK \n");
	        sbSql.append(" , CREATE_BY \n");
	        sbSql.append(" , CREATE_DATE \n");
	        sbSql.append(" , UPDATE_BY \n");
	        sbSql.append(" , UPDATE_DATE ) \n");
	        sbSql.append("SELECT SEASON_NUM \n");
	        sbSql.append("     , ITEM_CODE \n");
	        sbSql.append("     , TO_CHAR(SYSDATE, 'YYYYMMDD') AS TRANS_DATE \n");
	        sbSql.append("     , 'I' AS INOUT \n");
	        sbSql.append("     , SALE_PRICE AS PRICE \n");
	        sbSql.append("     , PR_QTY AS QTY \n");
	        sbSql.append("     , SALE_AMOUNT AS AMOUNT \n");
	        sbSql.append("     , SP_ID \n");
	        sbSql.append("     , '상품조회(삭제)' AS REMARK \n");
	        sbSql.append("     , '" + g_EmpNo + "' AS CREATE_BY \n");
			sbSql.append("     , SYSDATE AS CREATE_DATE \n");
			sbSql.append("     , '" + g_EmpNo + "' AS UPDATE_BY \n");
			sbSql.append("     , SYSDATE AS UPDATE_DATE \n");
	        sbSql.append("  FROM FSP_PO_SPECIAL_SALE \n");
	        sbSql.append(" WHERE SP_ID = '" + SP_ID + "' \n");
	        sbSql.append("   AND BU_CD = '2000' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 특판주문정보 수정 */ \n");
			sbSql.append("UPDATE FSP_PO_SPECIAL_SALE \n");
			sbSql.append("   SET LINE_STATUS    = '취소' \n");
			sbSql.append("     , CANCEL_TIME    = SYSDATE \n");
			sbSql.append("     , CANCEL_SABUN   = '" + g_EmpNo + "' \n");
			sbSql.append("     , RECEIPT_NUM    = '"+ cstmt.getString(19) +"'");
			sbSql.append("     , REMARK         = REMARK ||';'||LINE_STATUS||'=>취소:'||'" + g_EmpNo + "' \n");
			sbSql.append("     , RECEIPT_DATE   = SYSDATE \n");
			sbSql.append("     , UPDATE_DATE    = SYSDATE \n");
			sbSql.append("     , UPDATE_BY      = '" + g_EmpNo + "' \n");
			sbSql.append(" WHERE SP_ID          = '" + SP_ID + "' \n");
			sbSql.append("   AND SEASON_NUM     = '" + nullToBlank(ds_list.getRemovedData(i, "SEASON_NUM").toString()) + "' \n");
			sbSql.append("   AND LINE_STATUS    = '" + nullToBlank(ds_list.getRemovedData(i, "LINE_STATUS").toString()) + "' \n");
			sbSql.append("   AND BU_CD          = '2000' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();

			if( PAY_METHOD.equals("2") )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 카드 승인 정보 입력 */ \n");
				sbSql.append("INSERT INTO SLA_IF_CARD_APPRV_INFO \n");
				sbSql.append("( \n");
				sbSql.append("   OCCUR_DATE \n");        // 발생일자
				sbSql.append(" , SYS_CLASS \n");         // 시스템 구분 (17:특판)
				sbSql.append(" , UPJANG_CD \n");         // 업장코드(신청자)
				sbSql.append(" , RECEIPT_NUM \n");       // 영수증 번호
				sbSql.append(" , SEQ \n");               // PK MAX + 1
				sbSql.append(" , CARD_CLASS \n");        // 카드 구분 (1: 신용카드 2: 체크카드)
				sbSql.append(" , APPRV_NUM \n");         // 승인번호
				sbSql.append(" , USE_AMT \n");           // 사용 금액 (판매가)
				sbSql.append(" , ALLT_TERM \n");         // 할부기간
				sbSql.append(" , VALID_YYMM \n");        // 유효 년월
				sbSql.append(" , MU_CD \n");             // MU 코드
				sbSql.append(" , CC_CD \n");             // CC 코드
				sbSql.append(" , FRNC_STOR_NUM \n");     // 가맹점 번호
				sbSql.append(" , VOID_YN \n");           // VOID 여부(N)
				sbSql.append(" , DEAL_TYPE \n");         // 거래 유형(1:정상매출분)
				sbSql.append(" , DDDD_CLOSE_YN \n");     // N
				sbSql.append(" , MODIFY_SALS_YN \n");    // N
				sbSql.append(" , DATA_CLASS \n");        // 1
				sbSql.append(" , RECD_STATUS \n");       // L
				sbSql.append(" , CUSER \n");             // 로그인 사용자
				sbSql.append(" , CDATE \n");             // SYSDATE
				sbSql.append(" , UUSER \n");             // 로그인 사용자
				sbSql.append(" , UDATE \n");             // SYSDATE
				sbSql.append(") \n");
				sbSql.append("VALUES \n");
				sbSql.append("( \n");
				sbSql.append("   '" + payDay + "' \n");
				sbSql.append(" , '17' \n");
				sbSql.append(" , '" + UPJANG + "' \n");
				sbSql.append(" , '" + cstmt.getString(19) + "' \n");
				sbSql.append(" , (SELECT NVL(MAX(SEQ + 1), 1) \n");
				sbSql.append("      FROM SLA_IF_CARD_APPRV_INFO \n");
				sbSql.append("     WHERE OCCUR_DATE = '" + payDay + "' \n");
				sbSql.append("       AND SYS_CLASS = '17'  \n");
				sbSql.append("       AND UPJANG_CD = '" + UPJANG + "'\n");
				sbSql.append("       AND RECEIPT_NUM = '" + cstmt.getString(19) + "') \n");
				sbSql.append(" , '" + cardClass + "' \n");
				sbSql.append(" , '" + APPRV_NUM + "' \n");
				sbSql.append(" , '" + (Integer.parseInt(TOT_AMOUNT)*-1) + "' \n");
				sbSql.append(" , '" + INST_PERIOD + "' \n");
				sbSql.append(" , '" + CARD_YYMM + "' \n");
				sbSql.append(" , '" + MU_CD + "' \n");
				sbSql.append(" , '" + CC_CD + "' \n");
				sbSql.append(" , '" + FRNC_STOR_NUM + "' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , '1' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , '1' \n");
				sbSql.append(" , 'L' \n");
				sbSql.append(" , '" + g_EmpNo + "' \n");
				sbSql.append(" , SYSDATE \n");
				sbSql.append(" , '" + g_EmpNo + "' \n");
				sbSql.append(" , SYSDATE \n");
				sbSql.append(") \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();

				if( pstmt != null)	pstmt.close();
			}
		}

		/* 주문 변경 */
		for( int i = 0; i < ds_list.getRowCount(); i++ )
		{
			if( ds_list.getString(i, "EDIT_YN").equals("N") )	continue;

			String IF_FLAG				= nullToBlank(ds_list.getString(i, "IF_FLAG"));
			String SEASON_NUM			= nullToBlank(ds_list.getString(i, "SEASON_NUM"));
			String SP_ID				= nullToBlank(ds_list.getString(i, "SP_ID"));
			String ITEM_CODE			= nullToBlank(ds_list.getString(i, "ITEM_CODE"));
			String ITEM_NAME			= nullToBlank(ds_list.getString(i, "ITEM_NAME"));
			String TAX_CODE_GBN			= nullToBlank(ds_list.getString(i, "TAX_CODE_GBN"));
			String LINE_STATUS			= nullToBlank(ds_list.getString(i, "LINE_STATUS"));
			String RQ_SABUN				= nullToBlank(ds_list.getString(i, "RQ_SABUN"));
			String PAY_TIME				= nullToBlank(ds_list.getString(i, "PAY_TIME"));
			String RECEIPT_NUM			= nullToBlank(ds_list.getString(i, "RECEIPT_NUM"));
			String SALE_AMOUNT			= nullToBlank(ds_list.getString(i, "SALE_AMOUNT"));
			String PR_QTY				= nullToBlank(ds_list.getString(i, "PR_QTY"));
			String ADM_DC_AMOUNT		= nullToBlank(ds_list.getString(i, "ADM_DC_AMOUNT"));
			String TOT_AMOUNT			= nullToBlank(ds_list.getString(i, "TOT_AMOUNT"));
			String SALE_TYPE 			= nullToBlank(ds_list.getString(i, "SALE_TYPE"));
			String PAY_METHOD			= nullToBlank(ds_list.getString(i, "PAY_METHOD"));
			String INST_PERIOD			= nullToBlank(ds_list.getString(i, "INST_PERIOD"));
			String CARD_CLASS			= nullToBlank(ds_list.getString(i, "CARD_CLASS"));
			String CARD_COMP			= nullToBlank(ds_list.getString(i, "CARD_COMP"));
			String CARD_NUM				= nullToBlank(ds_list.getString(i, "CARD_NUM"));
			String VALID_THRU_MM		= nullToBlank(ds_list.getString(i, "VALID_THRU_MM"));
			String VALID_THRU_YY		= nullToBlank(ds_list.getString(i, "VALID_THRU_YY"));
			String CARD_YYMM			= nullToBlank(ds_list.getString(i, "CARD_YYMM"));
			String FRNC_STOR_NUM		= nullToBlank(ds_list.getString(i, "FRNC_STOR_NUM"));
			String AR_CUSTCD			= nullToBlank(ds_list.getString(i, "AR_CUSTCD"));
			String AR_SAUPNO			= nullToBlank(ds_list.getString(i, "AR_SAUPNO"));
			String AR_ADDR				= nullToBlank(ds_list.getString(i, "AR_ADDR"));
			String AR_NAME				= nullToBlank(ds_list.getString(i, "AR_NAME"));
			String AR_TEL				= nullToBlank(ds_list.getString(i, "AR_TEL"));
			String AR_EMAIL				= nullToBlank(ds_list.getString(i, "AR_EMAIL"));
			String APPRV_NUM			= nullToBlank(ds_list.getString(i, "APPRV_NUM"));

			// 변경전 데이터
			String ORG_SALE_AMOUNT		= nullToBlank(ds_list.getString(i, "ORG_SALE_AMOUNT"));
			String ORG_TOT_AMOUNT		= nullToBlank(ds_list.getString(i, "ORG_TOT_AMOUNT"));
			String ORG_PR_QTY			= nullToBlank(ds_list.getString(i, "ORG_PR_QTY"));
			String ORG_SALE_TYPE		= nullToBlank(ds_list.getString(i, "ORG_SALE_TYPE"));
			String ORG_PAY_METHOD		= nullToBlank(ds_list.getString(i, "ORG_PAY_METHOD"));
			String ORG_INST_PERIOD		= nullToBlank(ds_list.getString(i, "ORG_INST_PERIOD"));
			String ORG_CARD_CLASS		= nullToBlank(ds_list.getString(i, "ORG_CARD_CLASS"));
			String ORG_CARD_COMP		= nullToBlank(ds_list.getString(i, "ORG_CARD_COMP"));
			String ORG_CARD_NUM			= nullToBlank(ds_list.getString(i, "ORG_CARD_NUM"));
			String ORG_VALID_THRU_MM	= nullToBlank(ds_list.getString(i, "ORG_VALID_THRU_MM"));
			String ORG_VALID_THRU_YY	= nullToBlank(ds_list.getString(i, "ORG_VALID_THRU_YY"));
			String ORG_CARD_YYMM		= nullToBlank(ds_list.getString(i, "ORG_CARD_YYMM"));
			String ORG_FRNC_STOR_NUM	= nullToBlank(ds_list.getString(i, "ORG_FRNC_STOR_NUM"));
			String ORG_AR_CUSTCD		= nullToBlank(ds_list.getString(i, "ORG_AR_CUSTCD"));
			String ORG_APPRV_NUM		= nullToBlank(ds_list.getString(i, "ORG_APPRV_NUM"));

			String UPJANG = "";
			String MU_CD  = "";
			String CC_CD  = "";
			String CUSTCD = "";

			if( IF_FLAG.equals("Y") )
			{
                out_vl.add("v_spClose", ITEM_CODE + "[" + ITEM_NAME +"]" + " 구매정산이 완료 되어 수정이 불가합니다.");
                this.setResultMessage(0, "OK", out_vl);
                proc_output(response, out, out_vl, out_dl);
                return;
			}

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 서버날짜 조회 */ \n");
			sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD') AS TODAY \n");
			sbSql.append("     , TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR(ADD_MONTHS('" + PAY_TIME + "', 0), 'YYYYMM')||'01', 'YYYYMMDD')), 'YYYYMMDD') AS LASTDAY \n");
			sbSql.append("     , TO_CHAR(TO_DATE(TO_CHAR(ADD_MONTHS('" + PAY_TIME + "', 0), 'YYYYMM'), 'YYYYMM'), 'YYYY\"년\"MM\"월\"') AS STR_MONTH \n");
			sbSql.append("     , TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR(ADD_MONTHS('" + PAY_TIME + "', 0), 'YYYYMM')||'01', 'YYYYMMDD')), 'YYYY\"년\"MM\"월\"DD\"일\"') AS STR_DAY \n");
			sbSql.append("  FROM DUAL \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			String toDay = rs.getString("TODAY");
			String lastDay = rs.getString("LASTDAY");
			String sMonth = rs.getString("STR_MONTH");
			String sDay = rs.getString("STR_DAY");

			rs.close();
			pstmt.close();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 판촉귀속부서 조회 */ \n");
			sbSql.append("SELECT COUNT(*) AS CNT \n");
			sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
			sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
			sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
			sbSql.append("   AND A.GB_JAEJIK <> 'RA' \n");
			sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
			sbSql.append("   AND B.SEASON_NUM = '" + SEASON_NUM + "' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			int cnt = rs.getInt("CNT");

			rs.close();
			pstmt.close();

			// 예외처리
			if( cnt > 0 )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 신청자 소속 정보 조회 */ \n");
				sbSql.append("SELECT A.SABUN \n");
				sbSql.append("     , (SELECT Z.MU_CD FROM HLDC_SC_DEPT_V Z WHERE Z.CC_CD = B.ATTR_CC_CD) AS MU_CD \n");
				sbSql.append("     , B.ATTR_CC_CD AS CC_CD \n");
				sbSql.append("     , B.UPJANG \n");
				if( ORG_PAY_METHOD.equals("E") )
				{
					sbSql.append("     , '" + ORG_AR_CUSTCD + "' AS CUST_CD \n");
				}
				else
				{
					sbSql.append("     , A.CUSTCD AS CUST_CD \n");
				}
				sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
				sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
				sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
				sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
				sbSql.append("   AND B.SEASON_NUM = '" + SEASON_NUM + "' \n");
			}
			else
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT CASE WHEN C.CODE IS NULL THEN A.CST_PLNKGVRN_CLASS_CD ELSE 'SG' END AS CST_PLNKGVRN_CLASS_CD \n");
				sbSql.append("  FROM SCC_CC A \n");
				sbSql.append("   	left OUTER JOIN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0300') C ON A.ATTR04 = C.CODE \n");
				sbSql.append("     , HLDC_HR_PERSONAL B \n");
				sbSql.append(" WHERE A.CC_CD = B.CC_CD \n");
				sbSql.append("   AND B.SABUN = '" + RQ_SABUN + "' \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				rs.next();

				String cstPlnkgvrnClassCd = rs.getString("CST_PLNKGVRN_CLASS_CD");

				rs.close();
				pstmt.close();

				if( cstPlnkgvrnClassCd.equals("CG") )
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("/* 신청자 소속 정보 조회 */ \n");
			        sbSql.append("SELECT A.SABUN \n");
		       		sbSql.append("     , A.CC_CD \n");
					sbSql.append("     , B.MU_CD \n");
					sbSql.append("     , C.UPJANG \n");
					if( ORG_PAY_METHOD.equals("E") )
					{
						sbSql.append("     , '" + ORG_AR_CUSTCD + "' AS CUST_CD \n");
					}
					else
					{
						sbSql.append("     , A.CUSTCD AS CUST_CD \n");
					}
			        sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
					sbSql.append("     , HLDC_SC_DEPT_V B \n");
					sbSql.append("     , ST_UPJANG C \n");
			        sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
			        sbSql.append("   AND A.CC_CD = C.CC_CD \n");
			        sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
				}
				else
				{
	                out_vl.add("v_spClose", "신청자의 판관 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}
			}
			
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			
			if( rs.next() )
			{
				UPJANG = nullToBlank(rs.getString("UPJANG"));
				MU_CD  = nullToBlank(rs.getString("MU_CD"));
				CC_CD  = nullToBlank(rs.getString("CC_CD"));
				CUSTCD = nullToBlank(rs.getString("CUST_CD"));

				if( UPJANG.equals("")  || MU_CD.equals("")  || CC_CD.equals("")  || CUSTCD.equals("") )
				{
	                out_vl.add("v_spClose", "신청자의 소속 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}
			}
			else
			{
				out_vl.add("v_spClose", "신청자의 소속 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
				this.setResultMessage(0, "OK", out_vl);
				proc_output(response, out, out_vl, out_dl);
				return;
			}
			
			rs.close();
			pstmt.close();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 매출 월마감 확인 */ \n");
			sbSql.append("SELECT X.YN \n");
			sbSql.append("  FROM ( \n");
			sbSql.append("        SELECT CLOSE_GUBUN \n");
			sbSql.append("             , UPJANG \n");
			sbSql.append("             , CLOSE_DATE \n");
			sbSql.append("             , DECODE(YN||YN1, 'NN', 'N', 'Y') AS YN \n");
			sbSql.append("             , DECODE(YN||YN1, 'NN', '미마감', '마감') AS NOTE \n");
			sbSql.append("          FROM ( \n");
			sbSql.append("                SELECT '009' AS CLOSE_GUBUN \n");
			sbSql.append("                     , " + UPJANG + " AS UPJANG \n");
			sbSql.append("                     , MM||DD AS CLOSE_DATE \n");
			sbSql.append("                     , DECODE((SELECT COUNT(*) FROM SLA_IF_UPJANG_SALS_DETAIL WHERE UPJANG_CD = " + UPJANG + " AND OCCUR_DATE = A.MM||B.DD AND DDDD_CLOSE_YN = 'Y' AND SYS_CLASS = '17'), 0, 'N' ,'Y') AS YN \n");
			sbSql.append("                     , DECODE((SELECT COUNT(*) FROM MAS_CLOSE_MGMT WHERE UPJANG = " + UPJANG + " AND CLOSE_GUBUN = '009' AND CLOSE_DATE = A.MM||B.DD), 0, 'N', 'Y') AS YN1 \n");
			sbSql.append("     	             FROM (SELECT '" + PAY_TIME.substring(0, 6) + "' AS MM FROM DUAL) A \n");
			sbSql.append("                     , (SELECT LPAD(ROWNUM, 2, '0') AS DD FROM DICT WHERE ROWNUM <= 31) B \n");
			sbSql.append("                 WHERE TO_CHAR(LAST_DAY(TO_DATE(A.MM||'01', 'YYYYMMDD')), 'DD') >= B.DD \n");
			sbSql.append("               ) \n");
			sbSql.append("       ) X \n");
			sbSql.append(" WHERE X.CLOSE_DATE = TO_CHAR(LAST_DAY(TO_DATE('" + PAY_TIME.substring(0, 6) + "'||'01', 'YYYYMMDD')), 'YYYYMMDD') \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();

			String closeMonth_yn = nullToBlank(rs.getString("YN"));

			rs.close();
			pstmt.close();

			if( closeMonth_yn.equals("Y") )
			{
				out_vl.add("v_spClose", "해당 업장의 " + sMonth + " 매출 마감이 처리되어 " + ITEM_NAME + "(" + ITEM_CODE +  ") 상품을 주문취소 할 수 없습니다.");
			   	this.setResultMessage(0, "OK", out_vl);
			   	proc_output(response, out, out_vl, out_dl);
			   	return;
			}

			String payDay1 = ""; // (-) 매출 발생일
			String payDay2 = ""; // (+) 매출 발생일

			// 정산월과 현재월이 같으면 (-) 매출과 (+)매출은 현재일이 된다.
			if( PAY_TIME.substring(0,6).equals(toDay.substring(0, 6)) )
			{
				payDay1 = toDay;
				payDay2 = toDay;
			}
			// 정산월이 다르면 정산일, 정산월 마지막일의 일마감을 체크한다.
			else
			{
				String closeDay_yn = "";

				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 매출 일마감 확인 */ \n");
				sbSql.append("SELECT CASE WHEN COUNT(1) = 0 THEN 'N' \n");
				sbSql.append("            ELSE 'Y' \n");
				sbSql.append("       END CLOSE_YN \n");
				sbSql.append("  FROM SLA_IF_UPJANG_SALS_MST \n");
				sbSql.append(" WHERE OCCUR_DATE = '" + PAY_TIME + "' \n");
				sbSql.append("   AND SYS_CLASS = '17' \n");
				sbSql.append("   AND UPJANG_CD = '"  + UPJANG + "' \n");
				sbSql.append("   AND DDDD_CLOSE_YN = 'Y' \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				rs.next();

				closeDay_yn =  rs.getString("CLOSE_YN");

				rs.close();
				pstmt.close();

				if( closeDay_yn.equals("Y") )
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("/* 매출 일마감 확인 */ \n");
					sbSql.append("SELECT CASE WHEN COUNT(1) = 0 THEN 'N' \n");
					sbSql.append("            ELSE 'Y' \n");
					sbSql.append("       END CLOSE_YN \n");
					sbSql.append("  FROM SLA_IF_UPJANG_SALS_MST \n");
					sbSql.append(" WHERE OCCUR_DATE = '" + lastDay + "' \n");
					sbSql.append("   AND SYS_CLASS = '17' \n");
					sbSql.append("   AND UPJANG_CD = '"  + UPJANG + "' \n");
					sbSql.append("   AND DDDD_CLOSE_YN = 'Y' \n");

					pstmt = conn.prepareStatement(sbSql.toString());
					rs = pstmt.executeQuery();
					rs.next();

					closeDay_yn =  rs.getString("CLOSE_YN");

					rs.close();
					pstmt.close();

					if( closeDay_yn.equals("Y") )
					{
						out_vl.add("v_spClose", "해당 업장의 " + sDay + "매출 마감이 처리되어 " + ITEM_NAME + "(" + ITEM_CODE +  ") 상품을 주문취소 할 수 없습니다.");
					   	this.setResultMessage(0, "OK", out_vl);
					   	proc_output(response, out, out_vl, out_dl);
					   	return;
					}
					// 정산월의 마지막일의 일마감 처리가 안됐다면 (-)매출일은 정산월의 마지막일, (+)매출일은 현재일이 된다.
					else
					{
						payDay1 = lastDay;
						payDay2 = toDay;
					}
				}
				// 정산일에 일마감 처리가 안됐다면 (-) 매출일은 정산일, (+) 매출일은 현재일이 된다.
				else
				{
					payDay1 = PAY_TIME;
					payDay2 = toDay;
				}
			}

/* (-)매출 등록 시작 */
/*****************************************************************************************************************************************************************/
			String cardClass      = "";
 			if( ORG_PAY_METHOD.equals("2") )
			{
				if( ORG_CARD_CLASS.equals("신용") )			cardClass = "1";
				else if( ORG_CARD_CLASS.equals("체크") )	cardClass = "2";
			}

 			String payMethod = "";
 			if( ORG_PAY_METHOD.equals("E") )	payMethod = "8";

 			// (-) 매출에는 변경전 수량과 금액을 사용한다.
			cstmt = conn.prepareCall( "{call LTM_IF_SLA_SALESINFO_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
			int idx = 1;
			cstmt.setString(idx++, "SPEC");									// 업무구분(LIMS:연구소, IFIS:IFIS, FTP:식재도매, SPEC:판촉상품)
		    cstmt.setString(idx++, "");										// 일련번호 (사용안함)
		    cstmt.setString(idx++, payDay1);								// 발생일자
		    cstmt.setString(idx++, UPJANG);									// 관리업장코드
		    cstmt.setString(idx++, MU_CD);									// 관리 MU 코드
		    cstmt.setString(idx++, CC_CD);									// 관리 CC 코드
		    cstmt.setString(idx++, CUSTCD);									// 거래처번호
		    cstmt.setString(idx++, TAX_CODE_GBN);							// 1:과세, 2:면세
		    cstmt.setBigDecimal(idx++, new BigDecimal(ORG_SALE_AMOUNT));	// 판매금액
		    cstmt.setInt(idx++, (Integer.parseInt(ORG_TOT_AMOUNT)*-1));		// 금액
		    cstmt.setInt(idx++, (Integer.parseInt(ORG_PR_QTY)*-1));			// 판매수량
		    cstmt.setString(idx++, RQ_SABUN);								// 등록자
		    cstmt.setString(idx++, "");										// 영수증번호
		    cstmt.setString(idx++, ORG_PAY_METHOD);							// 결제방식
		    cstmt.setString(idx++, ORG_FRNC_STOR_NUM);						// 가맹점번호
		    cstmt.setString(idx++, cardClass);								// 카드구분(1:신용카드, 2:체크카드)
		    cstmt.registerOutParameter(idx++, Types.VARCHAR);				// 오류코드
			cstmt.registerOutParameter(idx++, Types.VARCHAR);				// 오류메시지
			cstmt.registerOutParameter(idx++, Types.VARCHAR);				// 영수증번호
			cstmt.execute();

			if( cstmt.getString(17).equals("E") )
			{
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(18), out_vl);
			   	proc_output(response, out, out_vl, out_dl);
			   	return;
			}

			if( ORG_PAY_METHOD.equals("2") )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 카드 승인 정보 입력 */ \n");
				sbSql.append("INSERT INTO SLA_IF_CARD_APPRV_INFO \n");
				sbSql.append("( \n");
				sbSql.append("   OCCUR_DATE \n");        // 발생일자
				sbSql.append(" , SYS_CLASS \n");         // 시스템 구분 (17:특판)
				sbSql.append(" , UPJANG_CD \n");         // 업장코드(신청자)
				sbSql.append(" , RECEIPT_NUM \n");       // 영수증 번호
				sbSql.append(" , SEQ \n");               // PK MAX + 1
				sbSql.append(" , CARD_CLASS \n");        // 카드 구분 (1: 신용카드 2: 체크카드)
				sbSql.append(" , APPRV_NUM \n");         // 승인번호
				sbSql.append(" , USE_AMT \n");           // 사용 금액 (판매가)
				sbSql.append(" , ALLT_TERM \n");         // 할부기간
				sbSql.append(" , VALID_YYMM \n");        // 유효 년월
				sbSql.append(" , MU_CD \n");             // MU 코드
				sbSql.append(" , CC_CD \n");             // CC 코드
				sbSql.append(" , FRNC_STOR_NUM \n");     // 가맹점 번호
				sbSql.append(" , VOID_YN \n");           // VOID 여부(N)
				sbSql.append(" , DEAL_TYPE \n");         // 거래 유형(1:정상매출분)
				sbSql.append(" , DDDD_CLOSE_YN \n");     // N
				sbSql.append(" , MODIFY_SALS_YN \n");    // N
				sbSql.append(" , DATA_CLASS \n");        // 1
				sbSql.append(" , RECD_STATUS \n");       // L
				sbSql.append(" , CUSER \n");             // 로그인 사용자
				sbSql.append(" , CDATE \n");             // SYSDATE
				sbSql.append(" , UUSER \n");             // 로그인 사용자
				sbSql.append(" , UDATE \n");             // SYSDATE
				sbSql.append(") \n");
				sbSql.append("VALUES \n");
				sbSql.append("( \n");
				sbSql.append("   '" + payDay1 + "' \n");
				sbSql.append(" , '17' \n");
				sbSql.append(" , '" + UPJANG + "' \n");
				sbSql.append(" , '" + cstmt.getString(19) + "' \n");
				sbSql.append(" , (SELECT NVL(MAX(SEQ + 1), 1) \n");
				sbSql.append("      FROM SLA_IF_CARD_APPRV_INFO \n");
				sbSql.append("     WHERE OCCUR_DATE = '" + payDay1 + "' \n");
				sbSql.append("       AND SYS_CLASS = '17'  \n");
				sbSql.append("       AND UPJANG_CD = '" + UPJANG + "'\n");
				sbSql.append("       AND RECEIPT_NUM = '" + cstmt.getString(19) + "') \n");
				sbSql.append(" , '" + cardClass + "' \n");
				sbSql.append(" , '" + ORG_APPRV_NUM + "' \n");
				sbSql.append(" , '" + Integer.parseInt(ORG_TOT_AMOUNT)*-1 + "' \n");
				sbSql.append(" , '" + ORG_INST_PERIOD + "' \n");
				sbSql.append(" , '" + ORG_CARD_YYMM + "' \n");
				sbSql.append(" , '" + MU_CD + "' \n");
				sbSql.append(" , '" + CC_CD + "' \n");
				sbSql.append(" , '" + ORG_FRNC_STOR_NUM + "' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , '1' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , '1' \n");
				sbSql.append(" , 'L' \n");
				sbSql.append(" , '" + g_EmpNo + "' \n");
				sbSql.append(" , SYSDATE \n");
				sbSql.append(" , '" + g_EmpNo + "' \n");
				sbSql.append(" , SYSDATE \n");
				sbSql.append(") \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();

				if( pstmt != null)	pstmt.close();
			}
/*****************************************************************************************************************************************************************/
/* (-)매출 등록 종료 */

/* (+)매출 등록 시작 */
/*****************************************************************************************************************************************************************/
				// 예외처리
				if( cnt > 0 )
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("/* 신청자 소속 정보 조회 */ \n");
					sbSql.append("SELECT A.SABUN \n");
					sbSql.append("     , (SELECT Z.MU_CD FROM HLDC_SC_DEPT_V Z WHERE Z.CC_CD = B.ATTR_CC_CD) AS MU_CD \n");
					sbSql.append("     , B.ATTR_CC_CD AS CC_CD \n");
					sbSql.append("     , B.UPJANG \n");
					if( PAY_METHOD.equals("E") )
					{
						sbSql.append("     , '" + AR_CUSTCD + "' AS CUST_CD \n");
					}
					else
					{
						sbSql.append("     , A.CUSTCD AS CUST_CD \n");	
					}
					sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
					sbSql.append("     , FSP_PO_SPECIAL_UPJANG B \n");
					sbSql.append(" WHERE A.CC_CD = B.OCCUR_CC_CD \n");
					sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
					sbSql.append("   AND B.SEASON_NUM = '" + SEASON_NUM + "' \n");
				}
				// 일반제조
				else
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("SELECT CASE WHEN C.CODE IS NULL THEN A.CST_PLNKGVRN_CLASS_CD ELSE 'SG' END AS CST_PLNKGVRN_CLASS_CD \n");
					sbSql.append("  FROM SCC_CC A \n");
					sbSql.append("   	left OUTER JOIN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0300') C ON A.ATTR04 = C.CODE \n");
					sbSql.append("     , HLDC_HR_PERSONAL B \n");
					sbSql.append(" WHERE A.CC_CD = B.CC_CD \n");
					sbSql.append("   AND B.SABUN = '" + RQ_SABUN + "' \n");

					pstmt = conn.prepareStatement(sbSql.toString());
					rs = pstmt.executeQuery();
					rs.next();

					String cstPlnkgvrnClassCd = rs.getString("CST_PLNKGVRN_CLASS_CD");

					rs.close();
					pstmt.close();

					if( cstPlnkgvrnClassCd.equals("CG") )
					{
						sbSql.delete(0, sbSql.length());
						sbSql.append("/* 신청자 소속 정보 조회 */ \n");
				        sbSql.append("SELECT A.SABUN \n");
			       		sbSql.append("     , A.CC_CD \n");
						sbSql.append("     , B.MU_CD \n");
						sbSql.append("     , C.UPJANG \n");
						if( PAY_METHOD.equals("E") )
						{
							sbSql.append("     , '" + AR_CUSTCD + "' AS CUST_CD \n");
						}
						else
						{
							sbSql.append("     , A.CUSTCD AS CUST_CD \n");	
						}
				        sbSql.append("  FROM HLDC_HR_PERSONAL A \n");
						sbSql.append("     , HLDC_SC_DEPT_V B \n");
						sbSql.append("     , ST_UPJANG C \n");
				        sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n");
				        sbSql.append("   AND A.CC_CD = C.CC_CD \n");
				        sbSql.append("   AND A.SABUN = '" + RQ_SABUN + "' \n");
					}
					else
					{
		                out_vl.add("v_spClose", "신청자의 판관 정보가 잘못됐습니다.\n관리자에게 문의하세요.");
		                this.setResultMessage(0, "OK", out_vl);
		                proc_output(response, out, out_vl, out_dl);
		                return;
					}
				}

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			if( rs.next() )
			{
				UPJANG = nullToBlank(rs.getString("UPJANG"));
				MU_CD  = nullToBlank(rs.getString("MU_CD"));
				CC_CD  = nullToBlank(rs.getString("CC_CD"));
				CUSTCD = nullToBlank(rs.getString("CUST_CD"));

				if( UPJANG.equals("")  || MU_CD.equals("")  || CC_CD.equals("")  || CUSTCD.equals("") )
				{
	                out_vl.add("v_spClose", "신청자의 소속 정보가 잘못됐습니다.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}
			}
			else
			{
                out_vl.add("v_spClose", "신청자의 소속 정보가 잘못됐습니다.");
                this.setResultMessage(0, "OK", out_vl);
                proc_output(response, out, out_vl, out_dl);
                return;
			}

			rs.close();
			pstmt.close();

			cardClass      = "";
 			if( PAY_METHOD.equals("2") )
			{
				if( CARD_CLASS.equals("신용") )			cardClass = "1";
				else if( CARD_CLASS.equals("체크") )	cardClass = "2";
			}

 			payMethod = "";
 			if( PAY_METHOD.equals("E") )	payMethod = "8";

			// (+) 매출에는 변경된 수량과 금액을 사용한다.
			cstmt = conn.prepareCall( "{call LTM_IF_SLA_SALESINFO_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
			idx = 1;
			cstmt.setString(idx++, "SPEC");								// 업무구분(LIMS:연구소, IFIS:IFIS, FTP:식재도매, SPEC:판촉상품)
		    cstmt.setString(idx++, "");									// 일련번호 (사용안함)
		    cstmt.setString(idx++, payDay2);							// 발생일자
		    cstmt.setString(idx++, UPJANG);								// 관리업장코드
		    cstmt.setString(idx++, MU_CD);								// 관리 MU 코드
		    cstmt.setString(idx++, CC_CD);								// 관리 CC 코드
		    cstmt.setString(idx++, CUSTCD);								// 거래처번호
		    cstmt.setString(idx++, TAX_CODE_GBN);						// 1:과세, 2:면세
		    cstmt.setBigDecimal(idx++, new BigDecimal(SALE_AMOUNT));	// 판매금액
		    cstmt.setBigDecimal(idx++, new BigDecimal(TOT_AMOUNT));		// 금액
		    cstmt.setBigDecimal(idx++, new BigDecimal(PR_QTY));			// 판매수량
		    cstmt.setString(idx++, RQ_SABUN);							// 신청자
		    cstmt.setString(idx++, "");									// 영수증번호
		    cstmt.setString(idx++, PAY_METHOD);							// 결제방식
		    cstmt.setString(idx++, FRNC_STOR_NUM);						// 가맹점번호
		    cstmt.setString(idx++, cardClass);							// 카드구분(1:신용카드, 2:체크카드)
			cstmt.registerOutParameter(idx++, Types.VARCHAR);			// 오류코드
			cstmt.registerOutParameter(idx++, Types.VARCHAR);			// 오류메시지
			cstmt.registerOutParameter(idx++, Types.VARCHAR);			// 영수증번호
			cstmt.execute();

			if( cstmt.getString(17).equals("E") )
			{
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(18), out_vl);
				proc_output(response, out, out_vl, out_dl);
			   	return;
			}

			if( PAY_METHOD.equals("2") )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 카드 승인 정보 입력 */ \n");
				sbSql.append("INSERT INTO SLA_IF_CARD_APPRV_INFO \n");
				sbSql.append("( \n");
				sbSql.append("   OCCUR_DATE \n");        // 발생일자
				sbSql.append(" , SYS_CLASS \n");         // 시스템 구분 (17:특판)
				sbSql.append(" , UPJANG_CD \n");         // 업장코드(신청자)
				sbSql.append(" , RECEIPT_NUM \n");       // 영수증 번호
				sbSql.append(" , SEQ \n");               // PK MAX + 1
				sbSql.append(" , CARD_CLASS \n");        // 카드 구분 (1: 신용카드 2: 체크카드)
				sbSql.append(" , APPRV_NUM \n");         // 승인번호
				sbSql.append(" , USE_AMT \n");           // 사용 금액 (판매가)
				sbSql.append(" , ALLT_TERM \n");         // 할부기간
				sbSql.append(" , VALID_YYMM \n");        // 유효 년월
				sbSql.append(" , MU_CD \n");             // MU 코드
				sbSql.append(" , CC_CD \n");             // CC 코드
				sbSql.append(" , FRNC_STOR_NUM \n");     // 가맹점 번호
				sbSql.append(" , VOID_YN \n");           // VOID 여부(N)
				sbSql.append(" , DEAL_TYPE \n");         // 거래 유형(1:정상매출분)
				sbSql.append(" , DDDD_CLOSE_YN \n");     // N
				sbSql.append(" , MODIFY_SALS_YN \n");    // N
				sbSql.append(" , DATA_CLASS \n");        // 1
				sbSql.append(" , RECD_STATUS \n");       // L
				sbSql.append(" , CUSER \n");             // 로그인 사용자
				sbSql.append(" , CDATE \n");             // SYSDATE
				sbSql.append(" , UUSER \n");             // 로그인 사용자
				sbSql.append(" , UDATE \n");             // SYSDATE
				sbSql.append(") \n");
				sbSql.append("VALUES \n");
				sbSql.append("( \n");
				sbSql.append("   '" + payDay2 + "' \n");
				sbSql.append(" , '17' \n");
				sbSql.append(" , '" + UPJANG + "' \n");
				sbSql.append(" , '" + cstmt.getString(19) + "' \n");
				sbSql.append(" , (SELECT NVL(MAX(SEQ + 1), 1) \n");
				sbSql.append("      FROM SLA_IF_CARD_APPRV_INFO \n");
				sbSql.append("     WHERE OCCUR_DATE = '" + payDay2 + "' \n");
				sbSql.append("       AND SYS_CLASS = '17'  \n");
				sbSql.append("       AND UPJANG_CD = '" + UPJANG + "'\n");
				sbSql.append("       AND RECEIPT_NUM = '" + cstmt.getString(19) + "') \n");
				sbSql.append(" , '" + cardClass + "' \n");
				sbSql.append(" , '" + APPRV_NUM + "' \n");
				sbSql.append(" , '" + TOT_AMOUNT + "' \n");
				sbSql.append(" , '" + INST_PERIOD + "' \n");
				sbSql.append(" , '" + CARD_YYMM + "' \n");
				sbSql.append(" , '" + MU_CD + "' \n");
				sbSql.append(" , '" + CC_CD + "' \n");
				sbSql.append(" , '" + FRNC_STOR_NUM + "' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , '1' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , 'N' \n");
				sbSql.append(" , '1' \n");
				sbSql.append(" , 'L' \n");
				sbSql.append(" , '" + g_EmpNo + "' \n");
				sbSql.append(" , SYSDATE \n");
				sbSql.append(" , '" + g_EmpNo + "' \n");
				sbSql.append(" , SYSDATE \n");
				sbSql.append(") \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();

				if( pstmt != null)	pstmt.close();
			}


/*****************************************************************************************************************************************************************/
/* (+)매출 등록 종료 */

			// 특판주문 히스토리 저장
			String histSql = sale_hist_sql(SP_ID, g_EmpNo);

			pstmt = conn.prepareStatement(histSql.toString());
			pstmt.executeUpdate();
			pstmt.close();

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 특판주문정보 수정 */ \n");
			sbSql.append("UPDATE FSP_PO_SPECIAL_SALE \n");
			sbSql.append("   SET PR_QTY         = '" + PR_QTY + "' \n");
			sbSql.append("     , SALE_AMOUNT    = '" + SALE_AMOUNT + "' \n");
			sbSql.append("     , ADM_DC_AMOUNT  = '" + ADM_DC_AMOUNT + "' \n");
			sbSql.append("     , SALE_TYPE      = '" + SALE_TYPE + "' \n");
			sbSql.append("     , PAY_METHOD     = '" + PAY_METHOD + "' \n");
			sbSql.append("     , INST_PERIOD    = '" + INST_PERIOD + "' \n");
			sbSql.append("     , CARD_CLASS     = '" + CARD_CLASS + "' \n");
			sbSql.append("     , CARD_COMP      = '" + CARD_COMP + "' \n");
			sbSql.append("     , CARD_NUM_ENC   = SC_CRYPTO_FUN('ENC', '" + CARD_NUM + "', '2') \n");
			sbSql.append("     , VALID_THRU_MM  = '" + VALID_THRU_MM + "' \n");
			sbSql.append("     , VALID_THRU_YY  = '" + VALID_THRU_YY + "' \n");
			sbSql.append("     , AR_CUSTCD      = '" + AR_CUSTCD + "' \n");
			sbSql.append("     , AR_SAUPNO      = '" + AR_SAUPNO + "' \n");
			sbSql.append("     , AR_ADDR_ENC    = SC_CRYPTO_FUN('ENC', '" + AR_ADDR + "', '6') \n");
			sbSql.append("     , AR_NAME        = '" +AR_NAME + "' \n");
			sbSql.append("     , AR_TEL_ENC     = SC_CRYPTO_FUN('ENC', '" + AR_TEL + "', '4') \n");
			sbSql.append("     , AR_EMAIL_ENC   = SC_CRYPTO_FUN('ENC', '" + AR_EMAIL + "', '5') \n");
			sbSql.append("     , PAY_TIME       = SYSDATE \n");
			sbSql.append("     , PAY_SABUN      = '" + g_EmpNo + "' \n");
			sbSql.append("     , REMARK         = REMARK || ';' || LINE_STATUS || '=>주문변경:' || '" + g_EmpNo + "' \n");
			sbSql.append("     , RECEIPT_NUM    = '"+ cstmt.getString(19) +"'");
			sbSql.append("     , RECEIPT_DATE   = SYSDATE \n");
			sbSql.append("     , UPDATE_DATE    = SYSDATE \n");
			sbSql.append("     , UPDATE_BY      = '" + g_EmpNo + "' \n");
			sbSql.append(" WHERE SP_ID          = '" + SP_ID + "' \n");
			sbSql.append("   AND SEASON_NUM     = '" + SEASON_NUM + "' \n");
			sbSql.append("   AND LINE_STATUS    = '" + LINE_STATUS + "' \n");
			sbSql.append("   AND BU_CD          = '2000' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch( Exception ex )
	{
		conn.rollback();

		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	}
	finally
	{
		if( rs != null )
		{
			try {
				rs.close();
			} catch( Exception e ) {}
		}
		if( pstmt != null )
		{
			try {
				pstmt.close();
			} catch( Exception e ) {}
		}
		if( cstmt != null )
		{
			try {
				cstmt.close();
			} catch( Exception e ) {}
		}
		if( conn != null )
		{
			try {
				conn.close();
			} catch( Exception e ) {}
		}

		//jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>

<%!
public String sale_hist_sql(String SP_ID, String strUser)
{
	StringBuffer sql = new StringBuffer();

	sql.delete(0, sql.length());
	sql.append("/* 특판주문 히스토리 저장 */ \n");
	sql.append("INSERT INTO FSP_PO_SPECIAL_SALE_HIST \n");
	sql.append("(  BAK_SN \n");
	sql.append(" , SP_ID \n");
	sql.append(" , SEASON_NUM \n");
	sql.append(" , SP_TYPE \n");
	sql.append(" , SP_DATE \n");
	sql.append(" , ITEM_CODE \n");
	sql.append(" , SALE_PRICE \n");
	sql.append(" , PR_QTY \n");
	sql.append(" , SALE_AMOUNT \n");
	sql.append(" , DC_AMOUNT \n");
	sql.append(" , ADM_DC_AMOUNT \n");
	sql.append(" , SALE_TYPE \n");
	sql.append(" , LINE_STATUS \n");
	sql.append(" , PR_SABUN \n");
	sql.append(" , RQ_SABUN \n");
	sql.append(" , UPJANG \n");
	sql.append(" , SEND_NAME \n");
	sql.append(" , RECE_NAME \n");
	sql.append(" , AR_SAUPNO \n");
	sql.append(" , AR_NAME \n");
	sql.append(" , PAY_METHOD \n");
	sql.append(" , INST_PERIOD \n");
	sql.append(" , CARD_CLASS \n");
	sql.append(" , CONTENT \n");
	sql.append(" , PAY_TIME \n");
	sql.append(" , PAY_SABUN \n");
	sql.append(" , BILL_NO \n");
	sql.append(" , APPRV_NUM \n");
	sql.append(" , FRNC_STOR_NUM \n");
	sql.append(" , RECEIPT_NUM \n");
	sql.append(" , CANCEL_TIME \n");
	sql.append(" , CANCEL_SABUN \n");
	sql.append(" , CANCEL_BILL_NO \n");
	sql.append(" , REMARK \n");
	sql.append(" , IF_FLAG \n");
	sql.append(" , RECEIPT_DATE \n");
	sql.append(" , OPER_ORG_SN \n");
	sql.append(" , VD_SN \n");
	sql.append(" , CONTRACT_START \n");
	sql.append(" , DELI_TYPE \n");
	sql.append(" , DELI_COMP \n");
	sql.append(" , DELI_TIME \n");
	sql.append(" , DELI_SABUN \n");
	sql.append(" , INVOICE_NUM \n");
	sql.append(" , CREATE_DATE \n");
	sql.append(" , CREATE_BY \n");
	sql.append(" , UPDATE_DATE \n");
	sql.append(" , UPDATE_BY ) \n");
	sql.append("SELECT FSP_PO_SPECIAL_SALE_HIST_S.NEXTVAL AS BAK_SN \n");
	sql.append("     , SP_ID \n");
	sql.append("     , SEASON_NUM \n");
	sql.append("     , SP_TYPE \n");
	sql.append("     , SP_DATE \n");
	sql.append("     , ITEM_CODE \n");
	sql.append("     , SALE_PRICE \n");
	sql.append("     , PR_QTY \n");
	sql.append("     , SALE_AMOUNT \n");
	sql.append("     , DC_AMOUNT \n");
	sql.append("     , ADM_DC_AMOUNT \n");
	sql.append("     , SALE_TYPE \n");
	sql.append("     , LINE_STATUS \n");
	sql.append("     , PR_SABUN \n");
	sql.append("     , RQ_SABUN \n");
	sql.append("     , UPJANG \n");
	sql.append("     , SEND_NAME \n");
	sql.append("     , RECE_NAME \n");
	sql.append("     , AR_SAUPNO \n");
	sql.append("     , AR_NAME \n");
	sql.append("     , PAY_METHOD \n");
	sql.append("     , INST_PERIOD \n");
	sql.append("     , CARD_CLASS \n");
	sql.append("     , CONTENT \n");
	sql.append("     , PAY_TIME \n");
	sql.append("     , PAY_SABUN \n");
	sql.append("     , BILL_NO \n");
	sql.append("     , APPRV_NUM \n");
	sql.append("     , FRNC_STOR_NUM \n");
	sql.append("     , RECEIPT_NUM \n");
	sql.append("     , CANCEL_TIME \n");
	sql.append("     , CANCEL_SABUN \n");
	sql.append("     , CANCEL_BILL_NO \n");
	sql.append("     , REMARK \n");
	sql.append("     , IF_FLAG \n");
	sql.append("     , RECEIPT_DATE \n");
	sql.append("     , OPER_ORG_SN \n");
	sql.append("     , VD_SN \n");
	sql.append("     , CONTRACT_START \n");
	sql.append("     , DELI_TYPE \n");
	sql.append("     , DELI_COMP \n");
	sql.append("     , DELI_TIME \n");
	sql.append("     , DELI_SABUN \n");
	sql.append("     , INVOICE_NUM \n");
	sql.append("     , CREATE_DATE \n");
	sql.append("     , CREATE_BY \n");
	sql.append("     , SYSDATE AS UPDATE_DATE \n");
	sql.append("     , '" + strUser + "' AS UPDATE_BY \n");
	sql.append("  FROM FSP_PO_SPECIAL_SALE \n");
	sql.append(" WHERE SP_ID = '" + SP_ID + "' \n");

	return sql.toString();
}
%>