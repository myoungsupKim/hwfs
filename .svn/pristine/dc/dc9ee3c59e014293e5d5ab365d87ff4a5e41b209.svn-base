<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 마감자료 > 매입결산리스트
■ 프로그램ID   : FSV00430V_T001.jsp
■ 프로그램명   : 매입결산리스트
■ 작성일자     : 2009-06-22
■ 작성자       : 박은규
■ 이력관리     : 2009-06-22 - 최초작성 박은규 CSR#(28344)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		//DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String sCustCd      = nullToBlank(in_vl.getString("sCustCd"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//
		String sGAMU        = nullToBlank(in_vl.getString("sGAMU"));
		String sGADATE      = nullToBlank(in_vl.getString("sGADATE"));
		String sGANO        = nullToBlank(in_vl.getString("sGANO"));
		//
		String sWhat        = nullToBlank(in_vl.getString("sWhat"));

		//IRIS DB연결
		if(conn != null && !conn.isClosed()) conn.close();
		conn = getIRISConn();

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		if (sType.equals("HdrQry"))
		{
			sbSql.append("SELECT B.MU_NM||'-'||A.GADATE||'-'||LPAD(TO_CHAR(A.GANO),4,'0') AS GANUM \n");
			sbSql.append("     , TO_CHAR(A.CREATE_DATE,'YYYY-MM-DD HH24:MI:SS')||'   ' \n");
			sbSql.append("     ||(SELECT Z.NM_KOR FROM HR_PERSONAL Z WHERE Z.SABUN = A.CREATE_BY) AS CREATE_TIME \n");
			sbSql.append("     , (SELECT SUM(I1.DRAMT) FROM GA_INTERFACE I1 WHERE I1.GADATE = A.GADATE AND I1.GAMU = A.GAMU AND I1.GANO = A.GANO) AS GAAMT \n");
			sbSql.append("     , (SELECT '('||Z.BILL_TYPE||')'||Z.BILL_NO||' ['||DECODE(Z.CANCEL_FLAG,'Y','서손',DECODE(Z.PRT_FLAG,'Y','출력완료','미출력'))||']' \n");
			sbSql.append("          FROM PO_CLSBILL Z WHERE Z.GADATE = A.GADATE AND Z.GAMU = A.GAMU AND Z.GANO = A.GANO AND Z.CANCEL_FLAG = 'N') AS BILL_NO \n");
			sbSql.append("     , A.GAMU, A.GADATE, A.GANO \n");
			sbSql.append("  FROM SC_MU B \n");
			sbSql.append("     , (SELECT A.* \n");
			sbSql.append("             , (SELECT Z.CUSTCD FROM PO_TRANSACTION Z WHERE Z.GADATE = A.GADATE AND Z.GAMU = A.GAMU AND Z.GANO = A.GANO AND ROWNUM = 1) AS CUSTCD \n");
			sbSql.append("          FROM GA_INTERFACE A \n");
			sbSql.append("         WHERE A.GAMU IN (SELECT Z.MU_CD FROM SC_MU Z) \n");
			sbSql.append("           AND A.GADATE = '" + sNeedDate + "' \n");
			sbSql.append("           AND A.GALINE = 1 \n");
			sbSql.append("           AND A.GAGUBUN   = 'G05' \n");
			sbSql.append("          AND A.GAGUBUN_DETAIL = '001') A \n");
			sbSql.append(" WHERE A.GAMU = B.MU_CD \n");
			sbSql.append("   AND A.CUSTCD = " + sCustCd + " \n");
			sbSql.append(" ORDER BY 1 \n");
		}
		//상세조회
		else if (sType.equals("DtlQry"))
		{
			sbSql.append("SELECT TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS TRANS_DATE \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NAME \n");
			sbSql.append("     , A.ITEM_SIZE \n");
			sbSql.append("     , A.TRANS_UOM \n");
			sbSql.append("     , DECODE(A.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE \n");
			sbSql.append("     , A.TRANS_UPRICE \n");
			sbSql.append("     , A.TRANS_QTY \n");
			sbSql.append("     , A.TRANS_UAMOUNT \n");
			sbSql.append("     , B.UPJANGNM||' '||C.SUBINV_NAME AS UPJANGNM \n");
			sbSql.append("     , A.SOURCE_ID AS PO_ID \n");
			sbSql.append("     , A.TR_NUM \n");
			sbSql.append("     , A.TRANS_ID \n");
			sbSql.append("  FROM PO_TRANSACTION A, ST_UPJANG B, PO_SUBINVENTORY C \n");
			sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.SUBINV_CODE = C.SUBINV_CODE(+) \n");
			sbSql.append("   AND A.GAMU   = '" + sGAMU + "' \n");
			sbSql.append("   AND A.GADATE = '" + sGADATE + "' \n");
			sbSql.append("   AND A.GANO   = " + sGANO + " \n");
			sbSql.append(" ORDER BY A.TRANS_DATE, A.ITEM_CODE \n");
		}
		//MRO사번조회
		else if (sType.equals("SabunQry"))
		{
			sbSql.append("SELECT 'HLDC' AA회사코드 \n");
			sbSql.append("     , '국토개발' AB회사명 \n");
			sbSql.append("     , C.MU_CD AC사업장코드 \n");
			sbSql.append("     , C.MU_NM AD사업장명 \n");
			sbSql.append("     , E.SAUPNO AE사업자등록번호 \n");
			sbSql.append("     , C.MU_CD AF사업부코드 \n");
			sbSql.append("     , C.MU_NM AG사업부명 \n");
			sbSql.append("     , C.DEPT_ID AH부서코드 \n");
			sbSql.append("     , C.CC_NM AI부서명 \n");
			sbSql.append("     , B.NM_KOR AS AJ이름 \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', B.JUMINNO_ENC , '1') AS AK주민번호 \n");
			sbSql.append("     , NULL AL직책 \n");
			sbSql.append("     , A.SABUN AM사번 \n");
			sbSql.append("     , A.SABUN AN회사시스템사용자ID \n");
			sbSql.append("     , NULL AO전화번호 \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', B.COMM_TEL3_ENC, '4') AS AP휴대폰 \n");
			sbSql.append("     , NULL AQ회사팩스 \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', B.COMM_EMAIL_ENC, '5') AS AR이메일 \n");
			sbSql.append("     , E.POST_NO AS근무지우편번호 \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', E.ADDR_ENC ,6) AT근무지주소 \n");
			sbSql.append("     , A.PR AS AU신청권한, A.PO AS AV결의권한, A.GR AS AW수불권한 \n");
			sbSql.append("     , NULL AX사용자관리자 \n");
			sbSql.append("     , NULL AY정산관리자 \n");
			sbSql.append("     , NULL AZ결재자 \n");
			sbSql.append("     , NULL BA예산관리자 \n");
			sbSql.append("  FROM HR_PERSONAL B, SC_DEPT_V C \n");
			sbSql.append("     ,(SELECT DEPT_ID, AP_UNITPRICE_UPJANG FROM ST_UPJANG WHERE DEPT_ID <> 1528 GROUP BY DEPT_ID, AP_UNITPRICE_UPJANG \n");
			sbSql.append("       UNION ALL \n");
			sbSql.append("       SELECT DEPT_ID, AP_UNITPRICE_UPJANG FROM ST_UPJANG WHERE DEPT_ID = 1528 AND AP_UNITPRICE_UPJANG = 100001) D \n");
			sbSql.append("     , ST_UPJANG E \n");
			sbSql.append("     ,(SELECT SABUN, MAX(PR) AS PR, MAX(PO) AS PO, MAX(GR) AS GR \n");
			sbSql.append("         FROM (SELECT A.SABUN \n");
			sbSql.append("                    , 'V' AS PR \n");
			sbSql.append("                    , NULL AS PO \n");
			sbSql.append("                    , 'V' AS GR \n");
			sbSql.append("                 FROM PO_USER_POSITION a, PO_CODE B, PO_TYPE C \n");
			sbSql.append("                WHERE A.POS_CODE = B.CODE AND B.GROUP_CODE = '004' AND a.POS_CODE = '004' \n");
			sbSql.append("                  AND A.PO_TYPE = C.PO_TYPE \n");
//			sbSql.append("                  AND A.PO_TYPE IN ('13','16','20','26','30') \n");
			sbSql.append("                GROUP BY A.SABUN \n");
			sbSql.append("                UNION ALL \n");
			sbSql.append("               SELECT A.SABUN \n");
			sbSql.append("                    , NULL AS PR \n");
			sbSql.append("                    , 'V' AS PO \n");
			sbSql.append("                    , NULL AS GR \n");
			sbSql.append("                 FROM PO_USER_POSITION a, PO_CODE B, PO_TYPE C \n");
			sbSql.append("                WHERE A.POS_CODE = B.CODE AND B.GROUP_CODE = '004' AND a.POS_CODE = '006' \n");
			sbSql.append("                  AND A.PO_TYPE = C.PO_TYPE \n");
//			sbSql.append("                  AND A.PO_TYPE IN ('13','16','20','26','30') \n");
			sbSql.append("                GROUP BY A.SABUN) \n");
			sbSql.append("        GROUP BY SABUN) A \n");
			sbSql.append(" WHERE A.SABUN = B.SABUN AND B.DEPT_ID = C.DEPT_ID AND C.DEPT_ID = D.DEPT_ID AND D.AP_UNITPRICE_UPJANG = E.UPJANG \n");
			sbSql.append("   AND A.SABUN = '" + sWhat + "' \n");
		}
		//MRO부서조회
		else if (sType.equals("DeptQry"))
		{
			sbSql.append("SELECT 'HLDC' AA회사코드 \n");
			sbSql.append("     , '국토개발' AB회사명 \n");
			sbSql.append("     , C.MU_CD AC사업장코드 \n");
			sbSql.append("     , C.MU_NM AD사업장명 \n");
			sbSql.append("     , E.SAUPNO AE사업자등록번호 \n");
			sbSql.append("     , C.MU_CD AF사업부코드 \n");
			sbSql.append("     , C.MU_NM AG사업부명 \n");
			sbSql.append("     , C.DEPT_ID AH부서코드 \n");
			sbSql.append("     , C.CC_NM AI부서명 \n");
			sbSql.append("     , C.CC_NM AS AJ이름 \n");
			sbSql.append("     , NULL AK주민번호 \n");
			sbSql.append("     , NULL AL직책 \n");
			sbSql.append("     , C.DEPT_ID AM사번 \n");
			sbSql.append("     , C.DEPT_ID AN회사시스템사용자ID \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', E.TEL_NO_ENC ,4) AO전화번호 \n");
			sbSql.append("     , NULL AP휴대폰 \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', E.FAX_NO_ENC ,4) AQ회사팩스 \n");
			sbSql.append("     , NULL AS AR이메일 \n");
			sbSql.append("     , E.POST_NO AS근무지우편번호 \n");
			sbSql.append("     , SC_CRYPTO_FUN('DEC', E.ADDR_ENC ,6) AT근무지주소 \n");
			sbSql.append("     , A.PR AS AU신청권한, A.PO AS AV결의권한, A.GR AS AW수불권한 \n");
			sbSql.append("     , NULL AX사용자관리자 \n");
			sbSql.append("     , NULL AY정산관리자 \n");
			sbSql.append("     , NULL AZ결재자 \n");
			sbSql.append("     , NULL BA예산관리자 \n");
			sbSql.append("  FROM HR_PERSONAL B, SC_DEPT_V C \n");
			sbSql.append("     ,(SELECT DEPT_ID, AP_UNITPRICE_UPJANG FROM ST_UPJANG WHERE DEPT_ID <> 1528 GROUP BY DEPT_ID, AP_UNITPRICE_UPJANG \n");
			sbSql.append("       UNION ALL \n");
			sbSql.append("       SELECT DEPT_ID, AP_UNITPRICE_UPJANG FROM ST_UPJANG WHERE DEPT_ID = 1528 AND AP_UNITPRICE_UPJANG = 100001) D \n");
			sbSql.append("     , ST_UPJANG E, \n");
			sbSql.append("( \n");
			sbSql.append("SELECT SABUN, MAX(PR) AS PR, MAX(PO) AS PO, MAX(GR) AS GR \n");
			sbSql.append("FROM \n");
			sbSql.append("( \n");
			sbSql.append("SELECT A.SABUN \n");
			sbSql.append("     , 'V' AS PR \n");
			sbSql.append("     , NULL AS PO \n");
			sbSql.append("     , 'V' AS GR \n");
			sbSql.append("  FROM PO_USER_POSITION a, PO_CODE B, PO_TYPE C \n");
			sbSql.append(" WHERE A.POS_CODE = B.CODE AND B.GROUP_CODE = '004' AND a.POS_CODE = '004' \n");
			sbSql.append("   AND A.PO_TYPE = C.PO_TYPE \n");
//			sbSql.append("   AND A.PO_TYPE IN ('13','16','20','26','30') \n");
			sbSql.append(" GROUP BY A.SABUN \n");
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT A.SABUN \n");
			sbSql.append("     , NULL AS PR \n");
			sbSql.append("     , 'V' AS PO \n");
			sbSql.append("     , NULL AS GR \n");
			sbSql.append("  FROM PO_USER_POSITION a, PO_CODE B, PO_TYPE C \n");
			sbSql.append(" WHERE A.POS_CODE = B.CODE AND B.GROUP_CODE = '004' AND a.POS_CODE = '006' \n");
			sbSql.append("   AND A.PO_TYPE = C.PO_TYPE \n");
//			sbSql.append("   AND A.PO_TYPE IN ('13','16','20','26','30') \n");
			sbSql.append(" GROUP BY A.SABUN \n");
			sbSql.append(") \n");
			sbSql.append("GROUP BY SABUN) A \n");
			sbSql.append(" WHERE A.SABUN(+) = B.SABUN AND B.DEPT_ID = C.DEPT_ID AND C.DEPT_ID = D.DEPT_ID AND D.AP_UNITPRICE_UPJANG = E.UPJANG \n");
			sbSql.append("   AND C.DEPT_ID = '" + sWhat + "' \n");
			sbSql.append("GROUP BY C.MU_CD, C.MU_NM, E.SAUPNO, C.DEPT_ID, C.CC_NM, E.TEL_NO, E.FAX_NO, E.POST_NO, E.ADDR, A.PR, A.PO, A.GR \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 
		
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		stmt.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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