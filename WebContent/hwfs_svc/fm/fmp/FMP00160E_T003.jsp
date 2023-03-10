<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00160E_T003.jsp
■ 프로그램명   : 주문삭제
■ 작성일자     : 2008.04.21
■ 작성자       : 박은규
■ 이력관리     : 2008.04.21
               2009-03-13 박은규 CSR#(25270) 요청자:김진희(식재사업팀)
               주문수량이 0인 것은 식단정보에 발주로 처리
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.util.Map" %> 
<%@ include file = "../../sc/main/common.jsp" %>
<%
	CallableStatement cstmt   = null;

	DataSet ds_msg = new DataSet();
	DataSet ds_msg_out = new DataSet();

	try	{
		
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//오토커밋 강제 false
		//conn.setAutoCommit(false);		
		
		//입력 데이타
		//DataSet ds_iud      = in_dl.get("ds_IUD");
		
		if ( "FMP00080E".equals(nullToBlank(in_vl.getString("scrnId"))) ) {
			ds_msg    	= in_dl.get("ds_msg");
		    ds_msg_out  = in_dl.get("ds_msg");
		}
		
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sDocSrc      = nullToBlank(in_vl.getString("sDocSrc"));
		String sPrID        = nullToBlank(in_vl.getString("sPrID"));
		String sOtcustCD    = nullToBlank(in_vl.getString("sOtcustCD"));
		String sMenuFlag    = nullToBlank(in_vl.getString("sMenuFlag"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sMenuCD      = nullToBlank(in_vl.getString("sMenuCD"));
		String sItemCode    = nullToBlank(in_vl.getString("sItemCode"));
		String sPrUpjang    = nullToBlank(in_vl.getString("sPrUpjang"));
		String sPrSabun     = nullToBlank(in_vl.getString("sPrSabun"));
		String sPrNum       = nullToBlank(in_vl.getString("sPrNum"));
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
        String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));    // 식당(창고)
        String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));  // 입고예정일
        String scrnId       = nullToBlank(in_vl.getString("scrnId"));     // 화면ID
		String scrnName     = nullToBlank(in_vl.getString("scrnName"));   // 화면명
		String rcUpjang      = ""; //주문업장
// [속도개선 Project 시작] 2017. 8. 4. 최범주

		int tInsCnt         = 0;
		int iInsCnt         = 0;
		
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가        
        double befGdsGnvAmtTot  = 0;                                                                                   // 전상품발주금액합계
        double aftrGdsGnvAmtTot = 0;                                                                                   // 후상품발주금액합계
        String[] docuSource     = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)", "07 FM(주요)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문, 주요상품발주
        String prNum          = "";                                                                                  // PO_PR_NUM_S 신청번호:"년월일-0000"
        String purcProcRslt   = "";                                                                                  // 구매처리결과
// [속도개선 Project 시작] 2017. 8. 4. 최범주

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		StringBuffer buffer = new StringBuffer();
        Map<String, String> map = new HashMap();
        Map<String, String[]> parameters = request.getParameterMap();
        for (String key : parameters.keySet())  {
           String[] value = parameters.get(key);
           buffer.append(key + "=" + Arrays.toString(value) + ";");
           map.put(key, value[0]);
        }

		if (scrnId == "" ) {
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("INSERT INTO ORDER_TEMP( \n");
			sbSql.append("      G_UPJANG \n");
			sbSql.append("    , G_EMPNO \n");
			sbSql.append("    , SDOCSRC \n");
			sbSql.append("    , SOTCUSTCD \n");
			sbSql.append("    , SMENUFLAG \n");
			sbSql.append("    , SPRUPJANG \n");
			sbSql.append("    , SPRSABUN \n");
			sbSql.append("    , SSUBINV \n");
			sbSql.append("    , SCRNID \n");
			sbSql.append("    , SCRNNAME \n");
			sbSql.append("    , SNEEDDATE \n");
			sbSql.append("    , SPRNUM \n");
			sbSql.append("    , SPRID \n");
			sbSql.append("    , SMENUCD \n");
			sbSql.append("    , SITEMCODE \n");
			sbSql.append("    , CDATE \n");
			sbSql.append("    , SPRAPPRNUM \n");
			sbSql.append("    , REQUESTDATA \n");			
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	 '" + g_Upjang + "' \n");
			sbSql.append("	, '" + g_EmpNo + "' \n");
			sbSql.append("	, '" + sDocSrc + "' \n");
			sbSql.append("	, '" + sOtcustCD + "' \n");
			sbSql.append("	, '" + sMenuFlag + "' \n");
			sbSql.append("	, '" + sPrUpjang + "' \n");
			sbSql.append("	, '" + sPrSabun + "' \n");
			sbSql.append("	, '" + sSubinv + "' \n");
			sbSql.append("	, '" + scrnId + "' \n");
			sbSql.append("	, '" + scrnName + "' \n");
			sbSql.append("	, '" + sNeedDate + "' \n");
			sbSql.append("	, '" + sPrNum + "' \n");
			sbSql.append("	, '' \n");
			sbSql.append("	, '' \n");
			sbSql.append("	, '' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append("	, '' \n");
			sbSql.append("	, '" + buffer.toString() + "' \n");		
            sbSql.append(" ) \n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
            tInsCnt = pstmt.executeUpdate();
            pstmt.close();
			
		}
        
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // 발주 전 상품발주합계 조회
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		sbSql.setLength(0);
        sbSql.append("\n SELECT                                                                                           ");
        sbSql.append("\n        AA.UPJANG                                                                                 ");
        sbSql.append("\n      , AA.NEED_DATE                                                                              ");
        sbSql.append("\n      , AA.PR_NUM                                                                                 ");
        sbSql.append("\n      , SUM(ROUND(NVL(                                                                                  ");
        sbSql.append("\n                CASE WHEN AA.TAX_CODE = '100' THEN AA.SALE_AMT * 1.1  /* 과세일 경우 */  ");
        sbSql.append("\n                     ELSE                          AA.SALE_AMT                                    ");
        sbSql.append("\n                END                                                                               ");
        sbSql.append("\n        , 0))) AS GDS_GNV_TOT  /* 상품발주합계 */                                                  ");
        sbSql.append("\n   FROM (                                                                                         ");
        sbSql.append("\n         SELECT                                                                                   ");
        sbSql.append("\n                A.RC_UPJANG AS UPJANG                                                             ");
        sbSql.append("\n              , A.NEED_DATE                                                                       ");
        sbSql.append("\n              , A.PR_NUM                                                                          ");
        sbSql.append("\n              , A.TAX_CODE                                                                        ");
        sbSql.append("\n              , NVL(A.SALE_PRICE, 0) * NVL(A.PO_QTY, 0) AS SALE_AMT                      ");
        sbSql.append("\n 	      FROM SO_PR A                                                                            ");
        //sbSql.append("\n 	     WHERE A.SUBINV_CODE = :subinvCode                                                        ");
        sbSql.append("\n 	     WHERE 1=1                                                        ");
        //sbSql.append("\n 	       AND A.NEED_DATE   = :needDate                                                          ");
		//sbSql.append("\n 	       AND A.PR_NUM   = :sPrNum                                                          	  ");
		sbSql.append("\n 	       AND A.PR_ID   = :sPrID                                                          	  ");
		
        // 상품발주, 식재장바구니일 경우
        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00080E|ShoppingFicsBasket") ) {
	        sbSql.append("\n 	   AND A.DOCU_SOURCE IN (:docuSource,:docuSource1,:docuSource2,:docuSource3)              ");
        // 식단발주일 경우
        } else if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
        	sbSql.append("\n 	   AND A.DOCU_SOURCE IN (:docuSource4)                                                    ");
        // 주요상품발주일 경우
        } else if ( ValidationUtil.isEquals(scrnId, "FMP00160E") ) {
        	sbSql.append("\n 	   AND A.DOCU_SOURCE IN (:docuSource5)                                                    ");
        }
        sbSql.append("\n 	       AND A.LINE_STATUS NOT IN ('003','999')                                                 ");
       
        sbSql.append("\n        ) AA                                                                                      ");
        sbSql.append("\n  GROUP BY AA.UPJANG                                                                              ");
        sbSql.append("\n         , AA.NEED_DATE                                                                           ");
        sbSql.append("\n         , AA.PR_NUM                                                                              ");
        
        npstmt = new NamedParameterStatement(conn, sbSql.toString());
        //npstmt.setString("subinvCode", sSubinv);
        //npstmt.setString("needDate", sNeedDate);
		//npstmt.setString("sPrNum", sPrNum);
		npstmt.setString("sPrID", sPrID);
        // 상품발주, 식재장바구니일 경우
        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00080E|ShoppingFicsBasket") ) {
        	npstmt.setString("docuSource",  docuSource[0]);
        	npstmt.setString("docuSource1", docuSource[1]);
        	npstmt.setString("docuSource2", docuSource[2]);
        	npstmt.setString("docuSource3", docuSource[3]);
        // 식단발주일 경우
        } else if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
        	npstmt.setString("docuSource4", docuSource[4]);
        // 주요상품발주일 경우
        } else if ( ValidationUtil.isEquals(scrnId, "FMP00160E") ) {
        	npstmt.setString("docuSource5", docuSource[5]);
        }
        
        rs = npstmt.executeQuery();
        befGdsGnvAmtTot=0;
        while ( rs.next() ) {
	       	befGdsGnvAmtTot = rs.getBigDecimal("GDS_GNV_TOT").doubleValue();
	       	prNum           = rs.getString("PR_NUM");
			rcUpjang        = rs.getString("UPJANG");
        }
        npstmt.close();
        rs.close();
        sbSql.setLength(0);
// [속도개선 Project 시작] 2017. 8. 4. 최범주

		if (! sPrID.equals(""))
		{
			//과거와는 달리 주문삭제 시 "취소"로 남기지 않고 그냥 삭제처리한다.
			//"취소"로 남겨야 할 경우 LINE_STATUS = '003'으로 업데이트 처리하고, 주문화면에서 주문내용 조회 시 취소내용도 감안하여 조회하여야 한다.
			//또한, 마감전 여부로 수정여부를 지정하는 것 역시 다 바뀌어야 한다.
			if (sOtcustCD.equals("0000"))
			{
				//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>1:SO_PR_UPDATE_START");
				
				sbSql.append("UPDATE SO_PR A \n");
				sbSql.append("   SET A.LINE_STATUS = '003' \n");
				sbSql.append("     , A.SO_STATUS = '003' \n");
				sbSql.append("     , A.UPDATE_BY = '" + g_EmpNo + "' \n");
				sbSql.append("     , A.UPDATE_DATE = SYSDATE \n");
				sbSql.append(" WHERE A.PR_ID = " + sPrID + " \n");
				sbSql.append("   AND A.LINE_STATUS <= '004' \n");
				
				//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>2:SO_PR_UPDATE_END");
			}
			else
			{
				//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>3:FMP_OTCUST_PR_UPDATE_START");
				
				sbSql.append("UPDATE FMP_OTCUST_PR A \n");
				sbSql.append("   SET A.LINE_STATUS = '003' \n");
				sbSql.append("     , A.UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , A.UDATE = SYSDATE \n");
				sbSql.append(" WHERE A.PR_ID = " + sPrID + " \n");
				sbSql.append("   AND A.LINE_STATUS <= '004' \n");
				//공급업체는 마감개념이 없어서 D데이를 체크 
				sbSql.append("   AND (SELECT DECODE( SIGN( TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(Z.D_DAYS,0) - 1) \n");
				sbSql.append("                     , 1, 'Y' \n");
				sbSql.append("                     , 0, DECODE(SIGN(DECODE(Z.D_TIMES,'',2400,0,2400,TO_NUMBER(Z.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'Y','N') \n");
				sbSql.append("                     , 'N' \n");
				sbSql.append("                     ) AS DEL_POS \n");
				sbSql.append("          FROM FMP_OTCUST_ITEM Z \n");
				sbSql.append("         WHERE Z.ITEM_CODE = A.ITEM_CODE) = 'Y' \n");
				
				//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>4:FMP_OTCUST_PR_UPDATE_END");
			}
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			iInsCnt = pstmt.executeUpdate();
			pstmt.close();
		}
		//식단발주인 경우 식단자료 업데이트
		if ((sDocSrc.equals("07 FM(식단)") && sMenuFlag.equals("Y"))
				&&
			(sPrID.equals("") || ((! sPrID.equals("")) && (iInsCnt > 0))))
		{
			//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>5:FMM_RECIPE_ITEM_UPDATE(-999)_START");
			
			sbSql.delete(0, sbSql.length());
			//취소자료는 일단 주문상태이며, 주문수량만 0이다.
			sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
			sbSql.append("   SET PR_QTY = 0 \n");
			sbSql.append("     , PR_YN = 'Y' \n");
			sbSql.append("     , PR_ID = -999 \n");
			sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
			sbSql.append("     , UDATE = SYSDATE \n");
			sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
//			sbSql.append("   AND MENU_CD LIKE '" + sMenuCD + "%' \n");

//============================================================================================
//(2009-01-14 추가) 시작
// 박은규 2009-03-13 CSR#(25270) 요청자:김진희(식재사업팀)
// 주문수량이 0인 것은 식단정보에 발주로 처리
//============================================================================================
			//신규식단 주문을 삭제한 경우 발주상태를 'Y'로 설정
			if (sPrID.equals(""))
			{
				sbSql.append("   AND NEED_DATE = '" + sMenuCD.substring(0,8) + "' \n");
				sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
				sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
				sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
				sbSql.append("                  AND B.UPJANG = " + sUpjang + " \n");
				sbSql.append("                  AND B.SUBINV_CODE = '" + sMenuCD.substring(9) + "') \n");
				sbSql.append("   AND ITEM_CODE = '" + sItemCode + "' \n");
				sbSql.append("   AND PR_YN = 'N' \n");
			}
//============================================================================================
//(2009-01-14 추가) 끝
//============================================================================================
			else
			{
				sbSql.append("   AND PR_ID = " + sPrID + " \n");
				sbSql.append("   AND PR_YN = 'Y' \n");
			}
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();		
			
			//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>6:FMM_RECIPE_ITEM_UPDATE(-999)_END");
		}
		
		
		//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>7:SP_IF_SALES_ORDER_START");
		// 구매 프로시져 호출
		if (! sPrID.equals(""))
		{
			cstmt = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
			
			//실행
			cstmt.setString(1,"100");
			cstmt.setString(2,"HFC");
			cstmt.setString(3,"FR");
			cstmt.setString(4,"MT");
			cstmt.setString(5,sPrUpjang);
			cstmt.setString(6,sPrSabun);
			cstmt.setString(7,"07");
			cstmt.setString(8,sPrNum);
			cstmt.setString(9,"U");
			
			cstmt.registerOutParameter(10, Types.VARCHAR);
			cstmt.registerOutParameter(11, Types.VARCHAR);
			
			cstmt.execute();
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
            purcProcRslt = cstmt.getString(10);  // 구매처리결과
//[속도개선 Project 시작] 2017. 8. 4. 최범주

			//System.out.println("cstmt.getString(10)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + cstmt.getString(10));
			//System.out.println("cstmt.getString(11)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + cstmt.getString(11));
			
			if(!cstmt.getString(10).equals("S000"))	
			{
				conn.rollback();
				
				this.setResultMessage(-1, cstmt.getString(11), out_vl);
				proc_output(response,out,out_vl,out_dl);
				return;			
			}
	
			cstmt.close();
		}
		
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // 발주 후 상품발주합계 조회
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // 구매 프로시저 처리가 성공일 경우
        if ( ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
	        sbSql.setLength(0);
	        sbSql.append("\n SELECT                                                                                           ");
	        sbSql.append("\n        AA.UPJANG                                                                                 ");
	        sbSql.append("\n      , AA.NEED_DATE                                                                              ");
	        sbSql.append("\n      , AA.PR_NUM                                                                                 ");
	        sbSql.append("\n      , SUM(ROUND(NVL(                                                                                  ");
	        sbSql.append("\n                CASE WHEN AA.TAX_CODE = '100' THEN AA.SALE_AMT * 1.1  /* 과세일 경우 */  ");
	        sbSql.append("\n                     ELSE                          AA.SALE_AMT                                    ");
	        sbSql.append("\n                END                                                                               ");
	        sbSql.append("\n        , 0))) AS GDS_GNV_TOT  /* 상품발주합계 */                                                  ");
	        sbSql.append("\n   FROM (                                                                                         ");
	        sbSql.append("\n         SELECT                                                                                   ");
	        sbSql.append("\n                A.RC_UPJANG AS UPJANG                                                             ");
	        sbSql.append("\n              , A.NEED_DATE                                                                       ");
	        sbSql.append("\n              , A.PR_NUM                                                                          ");
	        sbSql.append("\n              , A.TAX_CODE                                                                        ");
	        sbSql.append("\n              , NVL(A.SALE_PRICE, 0) * NVL(A.PO_QTY, 0) AS SALE_AMT                      ");
	        sbSql.append("\n 	      FROM SO_PR A                                                                            ");
	        sbSql.append("\n 	     WHERE 1=1                                                        ");
	        //sbSql.append("\n 	     WHERE A.SUBINV_CODE = :subinvCode                                                        ");
	        //sbSql.append("\n 	       AND A.NEED_DATE   = :needDate                                                          ");
			//sbSql.append("\n 	      AND A.PR_NUM   = :sPrNum                                                          	  ");
			sbSql.append("\n 	       AND A.PR_ID   = :sPrID                                                          	  ");
	        // 상품발주, 식재장바구니일 경우
	        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00080E|ShoppingFicsBasket") ) {
	        	sbSql.append("\n 	   AND A.DOCU_SOURCE IN (:docuSource,:docuSource1,:docuSource2,:docuSource3)              ");
	        // 식단발주일 경우
	        } else if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
	        	sbSql.append("\n 	   AND A.DOCU_SOURCE IN (:docuSource4)                                                    ");
	        // 주요상품발주일 경우
	        } else if ( ValidationUtil.isEquals(scrnId, "FMP00160E") ) {
	        	sbSql.append("\n       AND A.DOCU_SOURCE IN (:docuSource5)                                                    ");
	        }
	        sbSql.append("\n 	       AND A.LINE_STATUS NOT IN ('003','999')                                                 ");
	       
	        sbSql.append("\n        ) AA                                                                                      ");
	        sbSql.append("\n  GROUP BY AA.UPJANG                                                                              ");
	        sbSql.append("\n         , AA.NEED_DATE                                                                           ");
	        sbSql.append("\n         , AA.PR_NUM                                                                              ");
	        
	        npstmt = new NamedParameterStatement(conn, sbSql.toString());
	        //npstmt.setString("subinvCode", sSubinv);
	        //npstmt.setString("needDate", sNeedDate);
			//npstmt.setString("sPrNum", sPrNum);
			npstmt.setString("sPrID", sPrID);
	        // 상품발주, 식재장바구니일 경우
	        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00080E|ShoppingFicsBasket") ) {
	        	npstmt.setString("docuSource",  docuSource[0]);
	        	npstmt.setString("docuSource1", docuSource[1]);
	        	npstmt.setString("docuSource2", docuSource[2]);
	        	npstmt.setString("docuSource3", docuSource[3]);
	        // 식단발주일 경우
	        } else if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
	        	npstmt.setString("docuSource4", docuSource[4]);
	        // 주요상품발주일 경우
	        } else if ( ValidationUtil.isEquals(scrnId, "FMP00160E") ) {
	        	npstmt.setString("docuSource5", docuSource[5]);
	        }
	        
	        rs = npstmt.executeQuery();
	        aftrGdsGnvAmtTot = 0;
	        while ( rs.next() ) {
	        	aftrGdsGnvAmtTot = rs.getBigDecimal("GDS_GNV_TOT").doubleValue();
	        	prNum            = rs.getString("PR_NUM");
	        }
	        npstmt.close();
	        rs.close();
	        sbSql.setLength(0);
        }

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 여신금액 집계 프로시저 호출
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ( ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
			sbSql.setLength(0);
			sbSql.append("\n {                             ");
			sbSql.append("\n  CALL FCUS.FMS_CREDIT_SUM_PRO ");
			sbSql.append("\n  (                            ");
			sbSql.append("\n     ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n   , ?                         ");
			sbSql.append("\n  )                            ");
			sbSql.append("\n }                             ");
			
			cstmt = conn.prepareCall( sbSql.toString() );
			//cstmt.setString(1, rcUpjang);                   // (필수)업장코드
			cstmt.setString(1, sPrUpjang);                   // (필수)업장코드
			cstmt.setString(2, sNeedDate);                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
			cstmt.setString(3, "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
			cstmt.setDouble(4, aftrGdsGnvAmtTot);             // (필수)발생금액
			cstmt.setDouble(5, befGdsGnvAmtTot);              // (필수)발생금액(전)
			cstmt.setString(6, "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
			cstmt.setString(7, "(03)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
			cstmt.setString(8, "PR_NUM");                   // (필수)키명
			cstmt.setString(9, sPrNum);                      // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			cstmt.setString(10, "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			cstmt.setString(11, "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			cstmt.setString(12, "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			cstmt.setString(13, "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			cstmt.setString(14, scrnId);                    // 프로그램ID
			cstmt.setString(15, scrnName);                  // 프로그램 한글명
			cstmt.setString(16, g_EmpNo);                   // 생성자
			cstmt.registerOutParameter(17, Types.VARCHAR);  // 성공여부
			cstmt.registerOutParameter(18, Types.VARCHAR);  // 메세지
			
			cstmt.execute();
			if ( logger.isDebugWrite() ) {
				logger.debug("\n★★★★★ FCUS.FMS_CREDIT_SUM_PRO(여신금액 집계 프로시저) 인자 ★★★★★");
				logger.debug("sPrUpjang         : [" + sPrUpjang            + "]");
				logger.debug("sNeedDate        : [" + sNeedDate           + "]");
				logger.debug("aftrGdsGnvAmtTot : [" + aftrGdsGnvAmtTot    + "]");
				logger.debug("befGdsGnvAmtTot  : [" + befGdsGnvAmtTot     + "]");
				logger.debug("prNum            : [" + prNum               + "]");
				logger.debug("scrnId           : [" + scrnId              + "]");
				logger.debug("scrnName         : [" + scrnName            + "]");
				logger.debug("g_EmpNo          : [" + g_EmpNo             + "]");
				logger.debug("o_rtn            : [" + cstmt.getString(17) + "]");
				logger.debug("o_rtnmsg         : [" + cstmt.getString(18) + "]");
			}
			// 여신금액 집계 프로시저 처리가 실패했을 경우
			if ( !ValidationUtil.isEquals(cstmt.getString(17), Const.YN_Y) ) {
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(18), out_vl);
				proc_output(response,out,out_vl,out_dl);
				return;
			}
		}
// [속도개선 Project 시작] 2017. 8. 4. 최범주
		
		conn.commit();
		if ( "FMP00080E".equals(nullToBlank(in_vl.getString("scrnId"))) ) {
			ds_msg_out.setName("ds_msg_out");
			out_dl.add(ds_msg_out);
		}
		this.setResultMessage(0, "OK", out_vl);
		
		//System.out.println("FMP00160E_T003_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>8:SP_IF_SALES_ORDER_END");
	}
	catch(Exception ex)
	{
		conn.rollback();
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
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가        
        if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
// [속도개선 Project   끝] 2017. 8. 4. 최범주
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		if(cstmt != null) {
            try {
            	cstmt.close();
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
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);		
	
		//입력 데이타
		//DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sDocSrc      = nullToBlank(in_vl.getString("sDocSrc"));
		String sPrID        = nullToBlank(in_vl.getString("sPrID"));
		String sOtcustCD    = nullToBlank(in_vl.getString("sOtcustCD"));
		String sMenuFlag    = nullToBlank(in_vl.getString("sMenuFlag"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sMenuCD      = nullToBlank(in_vl.getString("sMenuCD"));
		String sItemCode    = nullToBlank(in_vl.getString("sItemCode"));
		int iInsCnt         = 0;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		if (! sPrID.equals(""))
		{
			//과거와는 달리 주문삭제 시 "취소"로 남기지 않고 그냥 삭제처리한다.
			//"취소"로 남겨야 할 경우 LINE_STATUS = '003'으로 업데이트 처리하고, 주문화면에서 주문내용 조회 시 취소내용도 감안하여 조회하여야 한다.
			//또한, 마감전 여부로 수정여부를 지정하는 것 역시 다 바뀌어야 한다.
			if (sOtcustCD.equals("0000"))
			{
				//sbSql.append("DELETE FROM HLDC_PO_PR \n");
				//sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
				//sbSql.append("   AND LINE_STATUS <= '004' \n");
				sbSql.append("UPDATE SO_PR A \n");
				sbSql.append("   SET A.LINE_STATUS = '003' \n");
				sbSql.append("     , A.UPDATE_BY = '" + g_EmpNo + "' \n");
				sbSql.append("     , A.UPDATE_DATE = SYSDATE \n");
				sbSql.append(" WHERE A.PR_ID = " + sPrID + " \n");
				sbSql.append("   AND A.LINE_STATUS <= '004' \n");
			}
			else
			{
				//sbSql.append("DELETE FROM FMP_OTCUST_PR \n");
				//sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
				//sbSql.append("   AND LINE_STATUS <= '004' \n");
				sbSql.append("UPDATE FMP_OTCUST_PR A \n");
				sbSql.append("   SET A.LINE_STATUS = '003' \n");
				sbSql.append("     , A.UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , A.UDATE = SYSDATE \n");
				sbSql.append(" WHERE A.PR_ID = " + sPrID + " \n");
				sbSql.append("   AND A.LINE_STATUS <= '004' \n");
				//공급업체는 마감개념이 없어서 D데이를 체크 
				sbSql.append("   AND (SELECT DECODE( SIGN( TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(Z.D_DAYS,0) - 1) \n");
				sbSql.append("                     , 1, 'Y' \n");
				sbSql.append("                     , 0, DECODE(SIGN(DECODE(Z.D_TIMES,'',2400,0,2400,TO_NUMBER(Z.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'Y','N') \n");
				sbSql.append("                     , 'N' \n");
				sbSql.append("                     ) AS DEL_POS \n");
				sbSql.append("          FROM FMP_OTCUST_ITEM Z \n");
				sbSql.append("         WHERE Z.ITEM_CODE = A.ITEM_CODE) = 'Y' \n");
			}
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			iInsCnt = pstmt.executeUpdate();
			pstmt.close();
		}
		//식단발주인 경우 식단자료 업데이트
		if ((sDocSrc.equals("07 FM(식단)") && sMenuFlag.equals("Y"))
				&&
			(sPrID.equals("") || ((! sPrID.equals("")) && (iInsCnt > 0))))
		{
			sbSql.delete(0, sbSql.length());
			//취소자료는 일단 주문상태이며, 주문수량만 0이다.
			sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
			sbSql.append("   SET PR_QTY = 0 \n");
			//신규식단 주문을 삭제한 경우 발주상태를 'Y'로 설정
			//if (sPrID.equals(""))
			//{
				sbSql.append("     , PR_YN = 'Y' \n");
				sbSql.append("     , PR_ID = -999 \n");
			//}
			sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
			sbSql.append("     , UDATE = SYSDATE \n");
			sbSql.append(" WHERE UPJANG = " + sUpjang + " \n");
//			sbSql.append("   AND MENU_CD LIKE '" + sMenuCD + "%' \n");

//============================================================================================
//(2009-01-14 추가) 시작
// 박은규 2009-03-13 CSR#(25270) 요청자:김진희(식재사업팀)
// 주문수량이 0인 것은 식단정보에 발주로 처리
//============================================================================================
			//신규식단 주문을 삭제한 경우 발주상태를 'Y'로 설정
			if (sPrID.equals(""))
			{
				sbSql.append("   AND NEED_DATE = '" + sMenuCD.substring(0,8) + "' \n");
				sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
				sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
				sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
				sbSql.append("                  AND B.UPJANG = " + sUpjang + " \n");
				sbSql.append("                  AND B.SUBINV_CODE = '" + sMenuCD.substring(9) + "') \n");
				sbSql.append("   AND ITEM_CODE = '" + sItemCode + "' \n");
				sbSql.append("   AND PR_YN = 'N' \n");
			}
//============================================================================================
//(2009-01-14 추가) 끝
//============================================================================================
			else
			{
				sbSql.append("   AND PR_ID = " + sPrID + " \n");
				sbSql.append("   AND PR_YN = 'Y' \n");
			}
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();			
		}
		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		conn.rollback();
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