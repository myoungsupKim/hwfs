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
		String g_Deptid     = nullToBlank(in_vl.getString("g_Deptid"));
		String sType        = nullToBlank(in_vl.getString("sType"));

		String sChk;

		StringBuffer sbSql = new StringBuffer();

		/* 매출 차기이월 */
		for( int i = 0; i < ds_list.getRowCount(); i++ )
		{
			sChk = nullToBlank(ds_list.getString(i, "CHK"));

			if( sChk.equals("0") )	continue;

			String SEASON_NUM		= nullToBlank(ds_cond.getString(0, "SEASON_NUM"));		// 시즌번호
			String STATUS			= nullToBlank(ds_cond.getString(0, "STATUS"));			// 마감작업
			String SP_DATE			= nullToBlank(ds_list.getString(i, "SP_DATE"));			// 주문일
			String PR_SABUN			= nullToBlank(ds_list.getString(i, "PR_SABUN"));		// 주문자 ID
			String RQ_SABUN			= nullToBlank(ds_list.getString(i, "RQ_SABUN"));		// 신청자 ID
			String PAY_METHOD		= nullToBlank(ds_list.getString(i, "PAY_METHOD"));		// 지불방식
			String TAX_CODE			= nullToBlank(ds_list.getString(i, "TAX_CODE"));		// 과/면세
			String TAX_CODE_GBN		= nullToBlank(ds_list.getString(i, "TAX_CODE_GBN"));	// 과/면세 구분코드(과세 : 1, 면세 : 2)
			String CARD_COMP		= nullToBlank(ds_list.getString(i, "CARD_COMP"));		// 카드사
			String CARD_CLASS		= nullToBlank(ds_list.getString(i, "CARD_CLASS"));		// 카드구분
			String CARD_NUM			= nullToBlank(ds_list.getString(i, "CARD_NUM"));		// 카드번호
			String INST_PERIOD		= nullToBlank(ds_list.getString(i, "INST_PERIOD"));		// 할부
			String CARD_CLASS_GBN	= nullToBlank(ds_list.getString(i, "CARD_CLASS_GBN"));	// 카드구분코드(신용 : 1, 체크 : 2 )
			String CARD_MM			= nullToBlank(ds_list.getString(i, "CARD_MM"));			// 카드 유효기간
			String CARD_YY			= nullToBlank(ds_list.getString(i, "CARD_YY"));			// 카드 유효기간
			String BILL_NO			= nullToBlank(ds_list.getString(i, "BILL_NO"));			// 영수증번호
			String PAY_TIME			= nullToBlank(ds_list.getString(i, "PAY_TIME"));		// 정산시간
			String FRNC_STOR_NUM	= nullToBlank(ds_list.getString(i, "FRNC_STOR_NUM"));	// 가맹점 번호
			String APPRV_NUM		= nullToBlank(ds_list.getString(i, "APPRV_NUM"));		// 승인번호

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
			
			System.out.println(PAY_TIME.substring(0, 6));
			System.out.println(toDay.substring(0, 6));
			System.out.println(SP_DATE.substring(0, 6));
			if( SP_DATE.substring(0, 6).equals(toDay.substring(0, 6))  )
			{
                //out_vl.add("v_spClose", "매출이월 대상이 아닙니다.");
                out_vl.add("v_spClose", "현재달에 발생한 매출은 다음달에 차기이월 작업이 가능합니다.");
                this.setResultMessage(0, "OK", out_vl);
                proc_output(response, out, out_vl, out_dl);
                return;
			}

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 정산 ID 조회 */ \n");
			sbSql.append("SELECT A.SP_ID \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_AMOUNT \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS TOT_AMOUNT \n");
			sbSql.append("     , A.AR_CUSTCD AS AR_CUSTCD \n");
			sbSql.append("     , NVL(A.IF_FLAG, 'N') AS IF_FLAG \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("     , HLDC_PO_ITEM_MST B \n");
			sbSql.append(" WHERE A.ITEM_CODE   = B.ITEM_CODE \n");
			sbSql.append("   AND A.SEASON_NUM  = '" + SEASON_NUM + "' \n");
			sbSql.append("   AND A.SP_DATE     = '" + SP_DATE + "' \n");
			sbSql.append("   AND A.PR_SABUN    = '" + PR_SABUN + "' \n");
			sbSql.append("   AND A.RQ_SABUN    = '" + RQ_SABUN + "' \n");
			sbSql.append("   AND A.PAY_METHOD  = '" + PAY_METHOD + "' \n");
			sbSql.append("   AND DECODE(B.TAX_CODE, '100', '과세', '210', '면세', '영세') = '" + TAX_CODE + "' \n");
			if( !CARD_COMP.equals("") )
			{
				sbSql.append("   AND A.CARD_COMP   = '" + CARD_COMP + "' \n");
			}
			if( !INST_PERIOD.equals("") )
			{
				sbSql.append("   AND A.INST_PERIOD = '" + INST_PERIOD + "' \n");
			}
			if( !CARD_CLASS.equals("") )
			{
				sbSql.append("   AND A.CARD_CLASS =  '" + CARD_CLASS + "' \n");
			}
			sbSql.append("   AND A.BILL_NO = '" + BILL_NO + "' \n");
			sbSql.append("   AND A.LINE_STATUS IN (" + STATUS + ") \n");
			sbSql.append("   AND A.BU_CD = '2000' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();

			DataSet ds_sp = this.makeDataSet(rs, "ds_sp");

			if( ds_sp.getRowCount() == 0 )
			{
				out_vl.add("v_spClose", "주문번호를 찾을 수 없습니다.\n판촉 관리자에게 연락하세요.");
			   	this.setResultMessage(0, "OK", out_vl);
			   	proc_output(response, out, out_vl, out_dl);
			   	return;
			}

			for( int n = 0; n < ds_sp.getRowCount(); n++ )
			{
				String SP_ID		= nullToBlank(ds_sp.getString(n, "SP_ID"));			// 주문번호
				String SALE_AMT		= nullToBlank(ds_sp.getString(n, "SALE_AMOUNT"));	// 판매금액
				String TOT_AMT		= nullToBlank(ds_sp.getString(n, "TOT_AMOUNT"));	// 정산금액
				String PR_QTY		= nullToBlank(ds_sp.getString(n, "PR_QTY"));		// 주문수량
				String AR_CUSTCD	= nullToBlank(ds_sp.getString(n, "AR_CUSTCD"));		// 거래처 번호
				String IF_FLAG		= nullToBlank(ds_sp.getString(n, "IF_FLAG"));		// 구매정산여부

				if( IF_FLAG.equals("Y") )
				{
	                out_vl.add("v_spClose", "구매정산이 완료되어 매출이월이 불가합니다.");
	                this.setResultMessage(0, "OK", out_vl);
	                proc_output(response, out, out_vl, out_dl);
	                return;
				}

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
				String UPJANGNM = "";
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
				sbSql.append("                SELECT '009' CLOSE_GUBUN \n");
				sbSql.append("                     , " + UPJANG + " UPJANG \n");
				sbSql.append("                     , MM||DD CLOSE_DATE \n");
				sbSql.append("                     , DECODE((SELECT COUNT(*) FROM SLA_IF_UPJANG_SALS_DETAIL WHERE UPJANG_CD = " + UPJANG + " AND OCCUR_DATE = A.MM||B.DD AND DDDD_CLOSE_YN = 'Y' AND SYS_CLASS = '17'), 0, 'N' ,'Y') YN \n");
				sbSql.append("                     , DECODE((SELECT COUNT(*) FROM MAS_CLOSE_MGMT WHERE UPJANG = " + UPJANG + " AND CLOSE_GUBUN = '009' AND CLOSE_DATE = A.MM||B.DD), 0, 'N', 'Y') YN1 \n");
				sbSql.append("                  FROM (SELECT '" + PAY_TIME.substring(0, 6) + "' AS MM FROM DUAL) A \n");
				sbSql.append("                     , (SELECT LPAD(ROWNUM, 2, '0') DD FROM DICT WHERE ROWNUM <= 31) B \n");
				sbSql.append("                 WHERE TO_CHAR(LAST_DAY(TO_DATE(A.MM||'01', 'YYYYMMDD')), 'DD') >= B.DD \n");
				sbSql.append("               ) \n");
				sbSql.append("       ) X \n");
				sbSql.append(" WHERE X.CLOSE_DATE = TO_CHAR(LAST_DAY(TO_DATE('" + PAY_TIME.substring(0, 6) + "'||'01', 'YYYYMMDD')), 'YYYYMMDD') \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				rs.next();

				String closeMonth_yn = rs.getString("YN");

				rs.close();
				pstmt.close();

				if( closeMonth_yn.equals("Y") )
				{
					out_vl.add("v_spClose", UPJANGNM + " 사업장의 " + sMonth +  " 매출 마감이 처리되어 매출 이월을 할 수 없습니다.");
				   	this.setResultMessage(0, "OK", out_vl);
				   	proc_output(response, out, out_vl, out_dl);
				   	return;
				}

				String payDay1 = "";	// (-) 정산일
				String payDay2 = "";	// (+) 정산일
				
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

				String closeDay_yn =  rs.getString("CLOSE_YN");

				rs.close();
				pstmt.close();

				// 정산월과 현재월이 같으면 (-) 매출과 (+)매출은 현재일이 된다.
				if( PAY_TIME.substring(0,6).equals(toDay.substring(0, 6)) )
				{
					payDay1 = toDay;
					payDay2 = toDay;
				}
				else
				{
					// 정산월 마지막일의 일마감이 처리됐으면 (-), (+) 매출은 현재일이 된다.
					if( closeDay_yn.equals("Y") )
					{
						payDay1 = toDay;
						payDay2 = toDay;				
					}
					// 정산월의 마지막일의 일마감이 처리 안됐으면 (-)매출일은 정산월의 마지막일, (+)매출일은 현재일이 된다. 
					else
					{
						payDay1 = lastDay;
						payDay2 = toDay;
					}
				}

				String payMethod = "";
				if( PAY_METHOD.equals("E") )	payMethod = "8";
				else							payMethod = PAY_METHOD;

				cstmt = conn.prepareCall( "{call LTM_IF_SLA_SALESINFO_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
				int idx = 1;
				cstmt.setString(idx++, "SPEC");                       // 업무구분(LIMS:연구소, IFIS:IFIS, FTP:식재도매, SPEC:판촉상품)
			    cstmt.setString(idx++, "");                           // 일련번호 (사용안함)
			    cstmt.setString(idx++, payDay1);     				  // 발생일자
			    cstmt.setString(idx++, UPJANG);                       // 관리업장코드
			    cstmt.setString(idx++, MU_CD);                        // 관리 MU 코드
			    cstmt.setString(idx++, CC_CD);                        // 관리 CC 코드
			    cstmt.setString(idx++, CUSTCD);                       // 거래처번호
			    cstmt.setString(idx++, TAX_CODE_GBN);                 // 1:과세, 2:면세
			    cstmt.setBigDecimal(idx++, new BigDecimal(SALE_AMT)); // 판매금액
			    cstmt.setInt(idx++, (Integer.parseInt(TOT_AMT)*-1));  // 금액
			    cstmt.setInt(idx++, (Integer.parseInt(PR_QTY)*-1));   // 판매수량
			    cstmt.setString(idx++, RQ_SABUN);                     // 신청자
			    cstmt.setString(idx++, "");                           // 영수증번호
			    cstmt.setString(idx++, payMethod);                    // 결제방식
			    cstmt.setString(idx++, FRNC_STOR_NUM);                // 가맹점번호
			    cstmt.setString(idx++, CARD_CLASS_GBN);               // 카드구분(1:신용카드, 2:체크카드)
			    cstmt.registerOutParameter(idx++, Types.VARCHAR);     // 오류코드
				cstmt.registerOutParameter(idx++, Types.VARCHAR);     // 오류메시지
				cstmt.registerOutParameter(idx++, Types.VARCHAR);     // 영수증번호
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
					sbSql.append(" , '" + CARD_CLASS_GBN + "' \n");
					sbSql.append(" , '" + APPRV_NUM + "' \n");
					sbSql.append(" , '" + (Integer.parseInt(TOT_AMT)*-1) + "' \n");
					sbSql.append(" , '" + INST_PERIOD + "' \n");
					sbSql.append(" , '" + (CARD_MM + CARD_YY) + "' \n");
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

				// 매출등록 프로시저 호출
				cstmt = conn.prepareCall( "{call LTM_IF_SLA_SALESINFO_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
				idx = 1;
				cstmt.setString(idx++, "SPEC");                       // 업무구분(LIMS:연구소, IFIS:IFIS, FTP:식재도매, SPEC:판촉상품)
			    cstmt.setString(idx++, "");                           // 일련번호 (사용안함)
			    cstmt.setString(idx++, payDay2);                       // 발생일자
			    cstmt.setString(idx++, UPJANG);                       // 관리업장코드
			    cstmt.setString(idx++, MU_CD);                        // 관리 MU 코드
			    cstmt.setString(idx++, CC_CD);                        // 관리 CC 코드
			    cstmt.setString(idx++, CUSTCD);                       // 거래처번호
			    cstmt.setString(idx++, TAX_CODE_GBN);                 // 1:과세, 2:면세
			    cstmt.setBigDecimal(idx++, new BigDecimal(SALE_AMT)); // 판매금액
			    cstmt.setBigDecimal(idx++, new BigDecimal(TOT_AMT));  // 금액
			    cstmt.setBigDecimal(idx++, new BigDecimal(PR_QTY));   // 판매수량
			    cstmt.setString(idx++, RQ_SABUN);                     // 신청자
			    cstmt.setString(idx++, "");                           // 영수증번호
			    cstmt.setString(idx++, payMethod);                    // 결제방식
			    cstmt.setString(idx++, FRNC_STOR_NUM);                // 가맹점번호
			    cstmt.setString(idx++, CARD_CLASS_GBN);               // 카드구분(1:신용카드, 2:체크카드)
				cstmt.registerOutParameter(idx++, Types.VARCHAR);     // 오류코드
				cstmt.registerOutParameter(idx++, Types.VARCHAR);     // 오류메시지
				cstmt.registerOutParameter(idx++, Types.VARCHAR);     // 영수증번호
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
					sbSql.append(" , '" + CARD_CLASS_GBN + "' \n");
					sbSql.append(" , '" + APPRV_NUM + "' \n");
					sbSql.append(" , '" + TOT_AMT + "' \n");
					sbSql.append(" , '" + INST_PERIOD + "' \n");
					sbSql.append(" , '" + (CARD_YY + CARD_MM) + "' \n");
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

				// 특판주문 히스토리 저장
				String histSql = sale_hist_sql(SP_ID, g_EmpNo);

				pstmt = conn.prepareStatement(histSql.toString());
				pstmt.executeUpdate();

				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 주문 정보 업데이트 */");
				sbSql.append("UPDATE FSP_PO_SPECIAL_SALE \n");
				sbSql.append("   SET RECEIPT_NUM   = '" + cstmt.getString(19) + "' \n");
				sbSql.append("     , RECEIPT_DATE  = SYSDATE \n");
				sbSql.append("     , PAY_TIME      = SYSDATE \n");
				sbSql.append("     , PAY_SABUN     = '" + g_EmpNo + "' \n");
				sbSql.append("     , REMARK        = REMARK || ';' || LINE_STATUS || '=>매출차기이월:' || '" + g_EmpNo + "' \n");
				sbSql.append("     , UPDATE_DATE   = SYSDATE \n");
				sbSql.append("     , UPDATE_BY     = '" + g_EmpNo + "' \n");
				sbSql.append(" WHERE SP_ID = '" + SP_ID + "' \n");
				sbSql.append("   AND BU_CD = '2000' \n");
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();

				if( pstmt != null)	pstmt.close();
			}
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	catch( Exception ex )
	{
		conn.rollback();

		// jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
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

		// jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch( Exception logE ) {
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