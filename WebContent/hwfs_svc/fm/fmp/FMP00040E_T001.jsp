<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/기준정보
■ 프로그램ID   : FMS00200E_T001.jsp
■ 프로그램명   : D-day제외일 조회
■ 작성일자     : 2008.03.04
■ 작성자       : 박은규
■ 이력관리     : 2008.03.04
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//FileLog.println("d:\\aaa.txt", ds_cond);
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sOp          = nullToBlank(in_vl.getString("sOp"));
	
		String sMainUpjang  = "";
		String sUpjang      = "";
		String sItem		= "";
		String sCust		= "";

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		String sCenterCode = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		sMainUpjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		sUpjang     = nullToBlank(ds_cond.getString(0, "UPJANG"));
		sItem     = nullToBlank(ds_cond.getString(0, "ITEM"));
		sCust     = nullToBlank(ds_cond.getString(0, "CUST"));
		//내역조회
		sbSql.append("SELECT DISTINCT(A.RDATE) AS LIMI_DD \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.RDATE,'YYYYMMDD'),'DY', 'NLS_DATE_LANGUAGE=KOREAN') AS WEEK \n");
		sbSql.append("     , B.REMARK \n");
		if (sMainUpjang.equals(""))
			sbSql.append("     , SCC_YN_FUN(NVL(B.USE_YN,'N')) AS USE_YN \n");
		else
			//업장설정  조회인 경우 설정이 안되어 있으면 공통설정을 디폴트로... 
			sbSql.append("     , SCC_YN_FUN(DECODE(B.UPJANG,NULL,NVL(C.USE_YN,'N'),NVL(B.USE_YN,'N'))) AS USE_YN \n");
		sbSql.append("  FROM (SELECT '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||TRIM(TO_CHAR(ROWNUM,'00')) AS RDATE \n");
		sbSql.append("          FROM DICT \n");
		sbSql.append("         WHERE ROWNUM <= TO_CHAR(LAST_DAY(TO_DATE('" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'01','YYYYMMDD')),'DD')) A \n");
		sbSql.append("     , (SELECT * FROM FMP_ORDER_SCHL_LIMI_MGMT A \n");
		sbSql.append("         WHERE LIMI_DD LIKE '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'%' \n");
		//본사가 없으면 공통설정
		if (sMainUpjang.equals(""))
			sbSql.append("           AND UPJANG = -1) B \n");
		else
		{
			if (sUpjang.equals(""))
			{
				//본사가 전체이고 업장이 없으면 그냥 공백으로 모든 업장을 대상으로 작업 대기
				if (sMainUpjang.equals("%"))
					sbSql.append("           AND 1=2) B \n");
				//본사가 있고 업장이 없으면 본사꺼 조회
				else
					sbSql.append("           AND UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ") B \n");
			}
			//업장이 있으면 업장꺼 조회
			else
				sbSql.append("           AND UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") B \n");
		}
		//업장설정  조회인 경우 설정이 안되어 있으면 공통설정을 디폴트로... 
		if (! sMainUpjang.equals(""))
		{
			sbSql.append("     , (SELECT * FROM FMP_ORDER_SCHL_LIMI_MGMT \n");
			sbSql.append("         WHERE LIMI_DD LIKE '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'%' \n");
			sbSql.append("           AND UPJANG = -1) C \n");
		}
		sbSql.append(" WHERE A.RDATE = B.LIMI_DD(+) \n");
		if (! sMainUpjang.equals(""))
			sbSql.append("   AND A.RDATE = C.LIMI_DD(+) \n");
		sbSql.append(" ORDER BY A.RDATE \n");

		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		//logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		//pstmt.close();
		//rs.close();
		//FileLog.println("d:\\aaa.txt", ds_List);

		//out 데이타
		DataSet ds_ListUpj;
		if (! sOp.equals("1"))
		{
			//sql문 버퍼RESET
			sbSql.delete(0, sbSql.length());
	
			String sCustType  = "";
			sCustType         = nullToBlank(ds_cond.getString(0, "CUST_TYPE"));
			//	
			sbSql.append("SELECT DISTINCT(A.MAIN_UPJANG) AS MAIN_UPJANG \n");
			sbSql.append("     , TO_CHAR(A.MAIN_UPJANG)||'   '||B.UPJANGNM_DISP AS MAIN_UPJANGNM_DISP \n");
			sbSql.append("     , A.UPJANG, A.UPJANGNM_DISP \n");
			sbSql.append("     , NVL(C.CNT,0) AS UPJCNT \n");
			sbSql.append("     , '0' AS CHK \n");
			sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG B \n");
			sbSql.append("     ,(SELECT UPJANG, COUNT(*) AS CNT \n");
			sbSql.append("         FROM FMP_ORDER_SCHL_LIMI_MGMT \n");
			sbSql.append("        WHERE LIMI_DD LIKE '" + nullToBlank(ds_cond.getString(0, "MONTH")) + "'||'%' \n");
			sbSql.append("          AND USE_YN = 'Y' \n");
			sbSql.append("        GROUP BY UPJANG) C \n");
			sbSql.append(" WHERE A.MAIN_UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			//본사가 전체('%')인 경우 모든 사업장을 대상으로 작업한다. 그래서 LIKE로 조회한다. 
			sbSql.append("   AND A.MAIN_UPJANG LIKE '" + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + "' \n");
			if (! sCenterCode.equals(""))
				sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y WHERE X.CENTER_CODE = " + sCenterCode + " AND X.UPJANG = Y.AP_UNITPRICE_UPJANG AND Y.UPJANG = A.UPJANG) \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			if (! sCustType.equals(""))
				sbSql.append("   AND A.CUST_TYPE = '" + nullToBlank(ds_cond.getString(0, "CUST_TYPE")) + "' \n");
			sbSql.append("   AND A.USE_YN = 'Y' AND B.USE_YN = 'Y' \n");
			if (! sItem.equals("")){
				sbSql.append("   AND A.UPJANG IN (                                             \n");
				sbSql.append("           SELECT DISTINCT UPJANG                                \n");
				sbSql.append("           FROM   FMP_ORDER_SCHL_LIMI_MGMT A, HLDC_PO_ITEM_MST B \n");
				sbSql.append("           WHERE  A.ITEM_CODE = B.ITEM_CODE                      \n");
				sbSql.append("           AND    B.ITEM_NAME LIKE + '%'||'" + sItem + "'||'%' ) \n");
			}
				
			if (! sCust.equals("")){
				sbSql.append("   AND A.UPJANG IN (                                       \n");
				sbSql.append("           SELECT DISTINCT UPJANG                          \n");
				sbSql.append("           FROM   FMP_ORDER_SCHL_LIMI_MGMT A, ST_CUST  B   \n");
				sbSql.append("           WHERE  A.OTCUSTCD = B.CUSTCD                    \n");
				sbSql.append("           AND    B.CUSTNM LIKE '%'||'" + sCust + "'||'%') \n");
			}
			sbSql.append(" ORDER BY A.MAIN_UPJANG, A.UPJANG \n");
	
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			//로그남기기
			//logger.debug(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());		
			rs = pstmt.executeQuery(); 
			//FileLog.println("d:\\BBB.txt", ds_ListUpj);
		}		
		ds_ListUpj = this.makeDataSet(rs, "ds_ListUpj");

		/**종료**/
		out_dl.add(ds_List);
		if (! sOp.equals("1"))
			out_dl.add(ds_ListUpj);
		
		/*    추가   --Start--    */
		if(sUpjang.length() > 0){
			
			//out 데이타
			DataSet ds_item;
		      
		    sbSql.delete(0, sbSql.length());
			//내역조회
		    sbSql.append("SELECT DISTINCT(A.OTCUSTCD) AS OTCUSTCD,      \n");
		    sbSql.append("       B.VD_NM AS CUSTNM,                     \n");
		    sbSql.append("       A.ITEM_CODE AS ITEM_CODE,              \n");
		    sbSql.append("       C.ITEM_NAME,                           \n");
		    sbSql.append("       C.ITEM_SIZE,                           \n");
		    sbSql.append("       0 NO_ITEM                              \n");
		    sbSql.append("  FROM FMP_ORDER_SCHL_LIMI_MGMT A,            \n");
		    sbSql.append("       VO_FC_VENDOR B,                       \n");
		    sbSql.append("       HLDC_PO_ITEM_MST C                     \n");
		    sbSql.append(" WHERE A.ITEM_CODE = C.ITEM_CODE(+)           \n");
		    sbSql.append("   AND A.UPJANG = "+ sUpjang +"               \n");
		    sbSql.append("   AND A.OTCUSTCD = B.VD_CD(+)               \n");
		    sbSql.append("   AND SUBSTR(A.LIMI_DD,1,6) = "+nullToBlank(ds_cond.getString(0, "MONTH"))+" \n");
		    sbSql.append(" ORDER BY ITEM_CODE                           \n");
	
	out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			//로그남기기
			//logger.debug(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());		
			rs = pstmt.executeQuery(); 
			ds_item = this.makeDataSet(rs, "ds_item");
			out_dl.add(ds_item);
			//pstmt.close();
			//rs.close();
			//FileLog.println("d:\\aaa.txt", ds_List);
		}
		/*    추가  --END--     */
		
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
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
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response,out,out_vl,out_dl);

%>
