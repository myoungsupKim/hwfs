<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/영업현황관리
■ 프로그램ID   : MAG00020V_T001.jsp
■ 프로그램명   : 부서별 Z율 실적조회
■ 작성일자     : 2013-03-04 
■ 작성자       : 박은규
■ 이력관리     : 
	1) 2013-03-04 박은규 - 최초개발 (CH201203_00081)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	
		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//FileLog.println("d:\\aaa.txt", ds_cond
		
		String strSdate     = nullToBlank(ds_Cond.getString(0, "SDATE"));
		String strEdate     = nullToBlank(ds_Cond.getString(0, "EDATE"));
		String strTmCd      = nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String strMuCd      = nullToBlank(ds_Cond.getString(0, "MU_CD"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.delete(0, sbSql.length());
//		sbSql.append("SELECT /*+ USE_HASH(A C) INDEX(A PO_TRANSACTION_PT_I8) */ \n");
//		sbSql.append("       A.TRANS_UPJANG AS UPJANG \n");
//		sbSql.append("     , C.UPJANGNM \n");
//		sbSql.append("     , B.OUTVAT_FLAG \n");
//		sbSql.append("     , DECODE(B.OUTVAT_FLAG, 'Y', ROUND(SUM(A.UNIT_AMOUNT * DECODE(A.TAX_CODE, '100', DECODE(B.MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( A.UNIT_AMOUNT ) ) AS UNIT_AMOUNT \n");
//		sbSql.append("     , DECODE(B.OUTVAT_FLAG, 'Y', ROUND(SUM(A.MARGIN_AMOUNT * DECODE(A.TAX_CODE, '100', DECODE(B.MATERIAL_ACCTCD, '1120311', 1.1, 1), 1) ) ), SUM( A.MARGIN_AMOUNT ) ) AS MARGIN_AMOUNT \n");
//		sbSql.append("  FROM HLDC_PO_TRANSACTION A, HLDC_PO_SUBINVENTORY B, SCO_UPJANG_MST_V C \n");
//		sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
//		sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG \n");
//		sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "' \n");
//		sbSql.append("   AND A.TRANS_TYPE LIKE 'O%' \n");
//		sbSql.append("   AND A.TRANS_TYPE <> 'O002' \n");
//		sbSql.append("   AND A.SUBINV_CODE LIKE 'C%' \n");
//		sbSql.append("   AND A.ACCTCD = '4020231'  -- 식음료원가 \n");
//		sbSql.append("   AND A.TRANS_MU_CD = 'YA' \n");
//		sbSql.append("   AND C.TM_CD = '" + strTmCd + "' \n");
//		sbSql.append(" GROUP BY A.TRANS_UPJANG, C.UPJANGNM, B.OUTVAT_FLAG \n");

//		sbSql.append("SELECT /*+ USE_HASH(A C) INDEX(A PO_TRANSACTION_PT_I8) */ \n");
//		sbSql.append("       A.TRANS_UPJANG AS UPJANG \n");
//		sbSql.append("     , C.UPJANGNM \n");
//		sbSql.append("     , B.OUTVAT_FLAG \n");
//		sbSql.append("     , DECODE(B.OUTVAT_FLAG, 'Y', ROUND(SUM(A.UNIT_AMOUNT * DECODE(A.TAX_CODE, '100', DECODE(B.MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( A.UNIT_AMOUNT ) ) AS UNIT_AMOUNT \n");
//		sbSql.append("     , DECODE(B.OUTVAT_FLAG, 'Y', ROUND(SUM(A.MARGIN_AMOUNT * DECODE(A.TAX_CODE, '100', DECODE(B.MATERIAL_ACCTCD, '11402000', 1.1, 1), 1) ) ), SUM( A.MARGIN_AMOUNT ) ) AS MARGIN_AMOUNT \n");
//		sbSql.append("  FROM HLDC_PO_TRANSACTION A, HLDC_PO_SUBINVENTORY B, SCO_UPJANG_MST_V C \n");
//		sbSql.append(" WHERE A.SUBINV_CODE = B.SUBINV_CODE \n");
//		sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG \n");
//  	sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "' \n");
//  	sbSql.append("   AND A.TRANS_TYPE LIKE 'O%' \n");
//  	sbSql.append("   AND A.TRANS_TYPE <> 'O002' \n");
//		sbSql.append("   AND A.SUBINV_CODE LIKE 'C%' \n");
//  	sbSql.append("   AND A.ACCTCD IN ('42203030', '41203030')  -- 식음료원가_식료(FC음료포함):42203010 \n");
 // 		sbSql.append("   AND A.TRANS_MU_CD = '2002' \n");
//		sbSql.append("   AND C.TM_CD = '" + strTmCd + "' \n");
//		sbSql.append(" GROUP BY A.TRANS_UPJANG, C.UPJANGNM, B.OUTVAT_FLAG \n");
 
		sbSql.append("SELECT   \n");
		sbSql.append("       MIHD.SHOP_CD AS UPJANG  \n");
		sbSql.append("       , REPLACE (B.UPJANGNM, '단체급식 ', '')  \n");
		sbSql.append("          || CASE WHEN A.CLOSE_DATE IS NULL THEN '' ELSE CASE WHEN A.CLOSE_DATE = '99991231' THEN '' ELSE '(폐점:' || SUBSTR (A.CLOSE_DATE, 1, 4) || '년' || SUBSTR (A.CLOSE_DATE, 5, 2) || '월' || SUBSTR (A.CLOSE_DATE, 7, 2) || '일)' END END AS UPJANGNM \n");
		sbSql.append("       , SWHU.NO_DEDUC_YN AS OUTVAT_FLAG    \n");
		//sbSql.append("       , SUM(ROUND(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_BUY_AMT, 0), 2))  AS UNIT_AMOUNT  \n");
		//sbSql.append("       , SUM(ROUND(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_MGT_AMT, 0), 2))  AS MARGIN_AMOUNT  \n");
		//불공제 및 면세 품목 계산 빠져서 변경 
		//sbSql.append("      , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_BUY_AMT, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_AMT, 0) , 2))  AS UNIT_AMOUNT   \n");
		//sbSql.append("      , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_MGT_AMT, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_MGT_AMT, 0) , 2)) AS MARGIN_AMOUNT   \n");
        sbSql.append("       , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', CASE WHEN MTGL.ACC_TAX_CD = '1' AND SWHU.NO_DEDUC_YN = 'Y' THEN MIDT.GAP_BUY_AMT * 1.1 ELSE MIDT.GAP_BUY_AMT END, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_AMT, 0) , 2))  AS UNIT_AMOUNT     \n");
		sbSql.append("     , SUM(ROUND(NVL(DECODE(MIDT.CANCEL_YN, 'N', CASE WHEN MTGL.ACC_TAX_CD = '1' AND SWHU.NO_DEDUC_YN = 'Y' THEN MIDT.GAP_MGT_AMT * 1.1 ELSE MIDT.GAP_MGT_AMT END, 0), 0) + DECODE(MIDT.CANCEL_YN, 'Y', MIDT.AMEND_MGT_AMT, 0) , 2)) AS MARGIN_AMOUNT  \n");

		sbSql.append("  FROM EPROCUSR.ESIMIHD MIHD  \n");
		sbSql.append("    INNER JOIN EPROCUSR.ESIMIDT MIDT  \n");
		sbSql.append("        ON MIHD.SYS_ID = MIDT.SYS_ID  \n");
		sbSql.append("        AND MIHD.COMP_CD = MIDT.COMP_CD  \n");
		sbSql.append("        AND MIHD.IVT_INSP_NO = MIDT.IVT_INSP_NO  \n");
		sbSql.append("    INNER JOIN EPROCUSR.ESPSWHU SWHU  \n");
		sbSql.append("        ON MIHD.SYS_ID = SWHU.SYS_ID  \n");
		sbSql.append("        AND MIHD.COMP_CD = SWHU.COMP_CD  \n");
		sbSql.append("        AND MIHD.WH_CD = SWHU.WH_CD  \n");
		sbSql.append("    INNER JOIN SCO_UPJANG_MST A  \n");
		sbSql.append("        ON TO_NUMBER(SWHU.SHOP_CD) = A.UPJANG  \n");
		sbSql.append("    INNER JOIN ST_UPJANG B  \n");
		sbSql.append("        ON A.UPJANG = B.UPJANG  \n");
		sbSql.append("    INNER JOIN HLDC_SC_DEPT_V C  \n");
		sbSql.append("        ON B.DEPT_ID = C.DEPT_ID  \n");
		
		//추가
	    sbSql.append("   INNER JOIN EPROCUSR.ESMMTGL MTGL   \n");
        sbSql.append("        ON MIDT.SYS_ID = MTGL.SYS_ID   \n");
        sbSql.append("       AND MIDT.ITEM_CD = MTGL.ITEM_CD   \n");
  
		sbSql.append(" WHERE MIHD.SYS_ID = '100'  \n");
		sbSql.append("   AND MIHD.COMP_CD = 'HFC'  \n");
		sbSql.append("   AND MIHD.INSP_DATE BETWEEN ? AND ?  \n");
		sbSql.append("   AND MIDT.MG_NO IS NOT NULL  \n");
		sbSql.append("   AND MIHD.WH_CD LIKE 'C%'  \n");
		//sbSql.append("   AND MIDT.JRNL_TYP_CD IN (SELECT JRNL_TYP_CD FROM EPROCUSR.ESIJRNL WHERE SYS_ID = '100' AND COMP_CD = 'HFC' AND DR_ACC_CD IN ('42203030', '41203030') AND MG_CLS_CD = 'GI')  \n");
		sbSql.append("   AND MIDT.JRNL_TYP_CD IN (SELECT JRNL_TYP_CD FROM EPROCUSR.ESIJRNL WHERE SYS_ID = '100' AND COMP_CD = 'HFC' AND DR_ACC_CD IN ('42203030','42203010','42203020', '41203030','41203020','41203010') AND MG_CLS_CD = 'GI')  \n");
		//sbSql.append("   AND C.MU_CD = '2002'  \n");
		sbSql.append("   AND C.MU_CD = ?  \n");
		if (strTmCd.length() != 0) sbSql.append("   AND C.TM_CD = ?  \n");
		//sbSql.append("   AND MIDT.CANCEL_YN = 'N'  \n");
		sbSql.append("   GROUP BY MIHD.SHOP_CD, B.UPJANGNM, A.CLOSE_DATE, SWHU.NO_DEDUC_YN  \n");

		int idx = 1;
		out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());	
		pstmt.setString(idx++, strSdate);
		pstmt.setString(idx++, strEdate);		
		pstmt.setString(idx++, strMuCd);
		if (strTmCd.length() != 0) pstmt.setString(idx++, strTmCd);	
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();

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