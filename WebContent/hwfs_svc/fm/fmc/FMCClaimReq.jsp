<%
/*-----------------------------------------------------------------------------
■ 시스템명          : 공통팝업 상품조회
■ 프로그램ID   		: FMZ_UPJANG_ITEM_T001.jsp
■ 프로그램명       	: 공통팝업 상품조회(단가 포함)
■ 작성일자          : 2009.01.07
■ 작성자            : 노규완
■ 이력관리          : 2009.01.07
					  [고도화]_운영율 관련 수정_김경은
					  2017.02.10	kihoon	[CH201702_00230] 클레임 요청시간(클라이언트->서버) 변경
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
		//DataSet ds_in     = in_dl.get("ds_in1");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append( " SELECT A.UPJANG, A.UPJANGNM, B.MU_CD, TO_CHAR(SYSDATE,'YYYYMMDD') AS DT, TO_CHAR(SYSDATE, 'HH24MISS') AS DT2 FROM ST_UPJANG A, HLDC_SC_DEPT_V B \n");
		sbSql.append( " WHERE A.DEPT_ID = B.DEPT_ID AND UPJANG = '"+g_Upjang+"' \n");

		out_vl.add("fa_Sql", sbSql.toString());
		
		pstmt = conn.prepareStatement(sbSql.toString());		
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_in     = in_dl.get("ds_in1");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("UPJANG"));
		String sSDATE       = nullToBlank(in_vl.getString("SDATE"));
		String sItem_Code   = nullToBlank(ds_in.getString(0,"ITEM_CODE"));		             	
		String sItem_Name   = nullToBlank(ds_in.getString(0,"ITEM_NAME"));  			
	
		//out 데이타
		DataSet gds_Csqlout;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.delete(0, sbSql.length());
		sbSql.append( " SELECT A.UPJANG \n");
		sbSql.append( "      , A.CONSUM_YN, A.ITEM_CLASS1, A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4 \n");
		sbSql.append( "      , A.ITEM_CODE, A.ITEM_NAME \n");
		sbSql.append( "      , DECODE(A.TAX_CODE,'100','과)','면)')||A.ITEM_SIZE AS ITEM_SIZE \n");
		sbSql.append( "      , A.PO_UOM, A.TAX_CODE \n");
		sbSql.append( "      , A.KG_CONVERT_RATE, A.MIN_ORD_QTY, A.POINT_FLAG, A.MULTIPLIER_QTY \n");
		sbSql.append( "      , A.ITEM_CODE AS ORI_ITEM_CODE \n");
		sbSql.append( "      , A.CODE_KIND \n");
		sbSql.append( "      , A.OTCUSTCD \n");
		sbSql.append( "      , A.USE_YN \n");
		sbSql.append( "      , A.UNIT_PRICE, A.SALE_PRICE \n");
		sbSql.append( "      , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE \n");
		sbSql.append( "   FROM FMU_OP_RATE C \n");
		sbSql.append( "      ,(SELECT /*+ DRIVING_SITE(A) */ \n");
		sbSql.append( "               '" +sUpjang+ "' AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE \n");
		sbSql.append( "             , B.CONSUM_YN, B.ITEM_CLASS1, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append( "             , B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append( "             , B.KG_CONVERT_RATE, B.MIN_ORD_QTY, B.POINT_FLAG, B.MULTIPLIER_QTY \n");
		sbSql.append( "             , B.ITEM_CODE AS ORI_ITEM_CODE \n");
		sbSql.append( "             , 'PO' AS CODE_KIND \n");
		sbSql.append( "             , '0000' AS OTCUSTCD \n");
		sbSql.append( "             , B.USE_YN \n");
		sbSql.append( "             , A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE \n");
		sbSql.append( "          FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B \n");
		sbSql.append( "         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append( "           AND A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = '" +sUpjang+ "') \n");
		sbSql.append( "           AND A.UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = '" +sUpjang+ "') \n");
		sbSql.append( "           AND A.ITEM_CODE > ' ' \n");
		sbSql.append( "           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append( "           AND A.SALE_PRICE > 0 \n");
		sbSql.append( "           AND A.USE_YN = 'Y' \n");
		sbSql.append( "           AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND X.UPJANG = A.UPJANG) \n");
		sbSql.append( "         UNION ALL \n");
		sbSql.append( "        SELECT '" +sUpjang+ "' AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE \n");
		sbSql.append( "             , B.CONSUM_YN, B.ITEM_CLASS1, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 \n");
		sbSql.append( "             , B.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.TAX_CODE \n");
		sbSql.append( "             , B.KG_CONVERT_RATE, B.MIN_ORD_QTY, B.POINT_FLAG, B.MULTIPLIER_QTY \n");
		sbSql.append( "             , B.ORI_ITEM_CODE \n");
		sbSql.append( "             , 'OT' AS CODE_KIND \n");
		sbSql.append( "             , B.OTCUSTCD \n");
		sbSql.append( "             , B.USE_YN \n");
		sbSql.append( "             , A.UNIT_PRICE, A.SALE_PRICE \n");
		sbSql.append( "          FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B \n");
		sbSql.append( "             ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE \n");
		sbSql.append( "                 FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append( "                WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = '" +sUpjang+ "') \n");
		sbSql.append( "                  AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSql.append( "                GROUP BY UPJANG, ITEM_CODE) C \n");
		sbSql.append( "         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append( "           AND A.UPJANG = C.UPJANG \n");
		sbSql.append( "           AND A.SDATE = C.SDATE \n");
		sbSql.append( "           AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append( "           AND A.SALE_PRICE > 0 \n");
		sbSql.append( "           AND A.USE_YN = 'Y' \n");
		sbSql.append( "       ) A \n");
		sbSql.append( "  WHERE A.UPJANG = C.UPJANG(+) \n");
		sbSql.append( "    AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append( "    AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
		sbSql.append( "    AND C.USE_YN(+) = 'Y' \n");

		if ( !sItem_Code.equals("")){							
			sbSql.append( "     	         AND A.ITEM_CODE    LIKE '%'|| '" +sItem_Code+ "' ||'%' \n");
			}
		if ( !sItem_Name.equals("")){							
			sbSql.append( "     	         AND A.ITEM_NAME    LIKE '%'|| '" +sItem_Name+ "' ||'%' \n");
			}			

out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		gds_Csqlout = this.makeDataSet(rs, "gds_Csqlout");
		
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(gds_Csqlout);
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

--%>