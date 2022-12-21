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
		int nCardCnt = 0;

		StringBuffer sbSql = new StringBuffer();
		StringBuffer sbSql2 = new StringBuffer();

		sbSql.delete(0, sbSql.length());
		sbSql.append("/* 서버날짜 조회 */ \n");
		sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD') TODAY FROM DUAL \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();

		String PAY_DAY = rs.getString("TODAY");

		for( int i = 0; i < ds_list.getRowCount(); i++ )
		{
			sChk = nullToBlank(ds_list.getString(i, "CHK"));
			nCardCnt = 0;

			if( sChk.equals("0") )	continue;

			String SEASON_NUM     = nullToBlank(ds_cond.getString(0, "SEASON_NUM"));
			String SP_DATE        = nullToBlank(ds_list.getString(i, "SP_DATE"));
			String PR_SABUN       = nullToBlank(ds_list.getString(i, "PR_SABUN"));
			String RQ_SABUN       = nullToBlank(ds_list.getString(i, "RQ_SABUN"));
			String PAY_METHOD     = nullToBlank(ds_list.getString(i, "PAY_METHOD"));
			String TAX_CODE       = nullToBlank(ds_list.getString(i, "TAX_CODE"));
			String CARD_COMP      = nullToBlank(ds_list.getString(i, "CARD_COMP"));
			String CARD_NUM       = nullToBlank(ds_list.getString(i, "CARD_NUM"));
			String INST_PERIOD    = nullToBlank(ds_list.getString(i, "INST_PERIOD"));
			String CARD_CLASS     = nullToBlank(ds_list.getString(i, "CARD_CLASS"));
			String STATUS         = nullToBlank(ds_cond.getString(0, "STATUS"));
			String BILL_NO        = nullToBlank(ds_list.getString(i, "BILL_NO"));
			String APPRV_NUM      = nullToBlank(ds_list.getString(i, "APPRV_NUM"));
			String TAX_CODE_GBN   = nullToBlank(ds_list.getString(i, "TAX_CODE_GBN"));
			String CARD_CLASS_GBN = nullToBlank(ds_list.getString(i, "CARD_CLASS_GBN"));
			String FRNC_STOR_NUM  = nullToBlank(ds_list.getString(i, "FRNC_STOR_NUM"));
			String CARD_YYMM      = nullToBlank(ds_list.getString(i, "CARD_YYMM"));

			sbSql.delete(0, sbSql.length());
			sbSql.append("/* 정산 ID 조회 */ \n");
			sbSql.append("SELECT A.SP_ID \n");
			sbSql.append("     , A.PR_QTY \n");
			sbSql.append("     , A.SALE_PRICE \n");
			sbSql.append("     , A.SALE_AMOUNT - A.DC_AMOUNT - A.ADM_DC_AMOUNT AS TOT_AMOUNT \n");
			sbSql.append("     , A.AR_CUSTCD \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("  FROM FSP_PO_SPECIAL_SALE A \n");
			sbSql.append("     , HLDC_PO_ITEM_MST B \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
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
			if( !CARD_NUM.equals("") )
			{
				sbSql.append("   AND SC_CRYPTO_FUN('DEC', A.CARD_NUM_ENC, '2') = '" + CARD_NUM + "' \n");
			}
			if( !INST_PERIOD.equals("") )
			{
				sbSql.append("   AND A.INST_PERIOD = '" + INST_PERIOD + "' \n");
			}
			if( !CARD_CLASS.equals("") )
			{
				sbSql.append("   AND A.CARD_CLASS =  '" + CARD_CLASS + "' \n");
			}
	        if( !STATUS.equals("'주문'") )
	        {
				sbSql.append("   AND NVL(A.BILL_NO, ' ') = NVL('" + BILL_NO + "', ' ') \n");
		    }
			sbSql.append("   AND A.LINE_STATUS IN (" + STATUS + ") \n");
			sbSql.append("   AND A.BU_CD       = '2000' \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			DataSet ds_sp = this.makeDataSet(rs, "ds_sp");

			rs.close();
			pstmt.close();

			if( ds_sp.getRowCount() == 0 )
			{
				out_vl.add("v_spClose", "주문번호를 찾을 수 없습니다.\n판촉 관리자에게 문의하세요.");
			   	this.setResultMessage(0, "OK", out_vl);
			   	proc_output(response, out, out_vl, out_dl);
			   	return;
			}

			for( int n = 0; n < ds_sp.getRowCount(); n++ )
			{
				String SP_ID		= nullToBlank(ds_sp.getString(n, "SP_ID"));
				String PR_QTY		= nullToBlank(ds_sp.getString(n, "PR_QTY"));
				String SALE_AMT		= nullToBlank(ds_sp.getString(n, "SALE_PRICE"));
				String TOT_AMT		= nullToBlank(ds_sp.getString(n, "TOT_AMOUNT"));
				String AR_CUSTCD 	= nullToBlank(ds_sp.getString(n, "AR_CUSTCD"));
				String orderUpjang  = nullToBlank(ds_sp.getString(n, "UPJANG"));
				
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
					sbSql2.delete(0, sbSql2.length());
					sbSql2.append("SELECT CASE WHEN C.CODE IS NULL THEN A.CST_PLNKGVRN_CLASS_CD ELSE 'SG' END AS CST_PLNKGVRN_CLASS_CD \n");
					sbSql2.append("  FROM SCC_CC A \n");
					sbSql2.append("   	left OUTER JOIN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0300') C ON A.ATTR04 = C.CODE \n");
					sbSql2.append("     , HLDC_HR_PERSONAL B \n");
					sbSql2.append(" WHERE A.CC_CD = B.CC_CD \n");
					sbSql2.append("   AND B.SABUN = '" + RQ_SABUN + "' \n");

					pstmt = conn.prepareStatement(sbSql2.toString());
					rs = pstmt.executeQuery();
					rs.next();

					String cstPlnkgvrnClassCd = rs.getString("CST_PLNKGVRN_CLASS_CD");

					rs.close();
					pstmt.close();

					if( cstPlnkgvrnClassCd.equals("CG") )
					{
					/*
						sbSql.delete(0, sbSql.length());
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
				    */
				    
						sbSql.delete(0, sbSql.length());
						sbSql.append("SELECT '" + RQ_SABUN + "' AS SABUN \n");
			       		sbSql.append("     , C.CC_CD \n");
						sbSql.append("     , B.MU_CD \n");
						sbSql.append("     , C.UPJANG \n");
						if( PAY_METHOD.equals("E") )
						{
							sbSql.append("     , '" + AR_CUSTCD + "' AS CUST_CD \n");
						}
						else
						{
							sbSql.append("     , (SELECT A.CUSTCD FROM HLDC_HR_PERSONAL A WHERE A.SABUN = '" + RQ_SABUN + "' )AS CUST_CD \n");	
						}
				        sbSql.append("  FROM HLDC_SC_DEPT_V B \n");
						sbSql.append("     , ST_UPJANG C \n");
				        sbSql.append(" WHERE B.CC_CD = C.CC_CD \n");
				        sbSql.append("   AND C.UPJANG = '" + orderUpjang + "' \n");
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
				
				String payMethod = "";
				if( PAY_METHOD.equals("E") )	payMethod = "8";
				else							payMethod = PAY_METHOD;

				// 매출등록 프로시져 호출
				cstmt = conn.prepareCall( "{call LTM_IF_SLA_SALESINFO_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
				int idx = 1;
				cstmt.setString(idx++, "SPEC");                       // 업무구분(LIMS:연구소, IFIS:IFIS, FTP:식재도매, SPEC:판촉상품)
			    cstmt.setString(idx++, "");                           // 일련번호 (사용안함)
			    cstmt.setString(idx++, PAY_DAY);                      // 발생일자
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

				sbSql.delete(0, sbSql.length());
				sbSql.append("/* 특판주문 정보 업데이트 */ \n");
				sbSql.append("UPDATE FSP_PO_SPECIAL_SALE \n");
				sbSql.append("   SET LINE_STATUS   = '정산' \n");
				sbSql.append("     , PAY_TIME      = SYSDATE \n");
				sbSql.append("     , PAY_SABUN     = '" + g_EmpNo + "' \n");
				sbSql.append("     , BILL_NO       = '" + BILL_NO + "' \n");
				sbSql.append("     , APPRV_NUM     = '" + APPRV_NUM + "' \n");
				sbSql.append("     , FRNC_STOR_NUM = '" + FRNC_STOR_NUM + "' \n");
				sbSql.append("     , REMARK        = REMARK ||';'||LINE_STATUS||'=>정산:'||'" + g_EmpNo + "' \n");
				sbSql.append("     , RECEIPT_NUM   = '" + cstmt.getString(19) + "' \n");
				sbSql.append("     , RECEIPT_DATE  = SYSDATE \n");
				sbSql.append("     , UPDATE_DATE   = SYSDATE \n");
				sbSql.append("     , UPDATE_BY     = '" + g_EmpNo + "' \n");
				sbSql.append(" WHERE SP_ID = '" + nullToBlank(ds_sp.getString(n, "SP_ID")) + "' \n");
				sbSql.append("   AND BU_CD = '2000' \n");

				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();

				if( !CARD_NUM.equals("") )
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("/* 카드 승인 정보 입력 */");
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
					sbSql.append("   '" + PAY_DAY + "' \n");
					sbSql.append(" , '17' \n");
					sbSql.append(" , '" + UPJANG + "' \n");
					sbSql.append(" , '" + cstmt.getString(19) + "' \n");
					sbSql.append(" , (SELECT NVL(MAX(SEQ + 1), 1) \n");
					sbSql.append("      FROM SLA_IF_CARD_APPRV_INFO \n");
					sbSql.append("     WHERE OCCUR_DATE = '" + PAY_DAY + "' \n");
					sbSql.append("       AND SYS_CLASS = '17'  \n");
					sbSql.append("       AND UPJANG_CD = '" + UPJANG + "'\n");
					sbSql.append("       AND RECEIPT_NUM = '" + cstmt.getString(19) + "') \n");
					sbSql.append(" , '" + CARD_CLASS_GBN + "' \n");
					sbSql.append(" , '" + APPRV_NUM + "' \n");
					sbSql.append(" , '" + TOT_AMT + "' \n");
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

			if( pstmt != null)	pstmt.close();
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
			} catch(Exception e) {}
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