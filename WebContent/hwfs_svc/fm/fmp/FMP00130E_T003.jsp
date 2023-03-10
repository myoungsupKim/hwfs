<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00130E_T003.jsp
■ 프로그램명   : 주문 취소
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2009-03-16 박은규 CSR#(25384) 요청자:이혜은(fs기획팀)
               최초 작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	CallableStatement cstmt   = null;

	try	{
		
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		//DataSet ds_List     = in_dl.get("ds_List");
		//입력 파라메터
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_ItemCode   = nullToBlank(in_vl.getString("g_ItemCode"));
		String sPrID        = nullToBlank(in_vl.getString("sPrID"));
		String sPrUpjang    = nullToBlank(in_vl.getString("sPrUpjang"));
		String sPrSabun     = nullToBlank(in_vl.getString("sPrSabun"));
		String sPrNum       = nullToBlank(in_vl.getString("sPrNum"));
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
        String scrnId       = nullToBlank(in_vl.getString("scrnId"));    // 화면ID
		String scrnName     = nullToBlank(in_vl.getString("scrnName"));  // 화면명
		String rcUpjang      = ""; //주문업장
// [속도개선 Project 시작] 2017. 8. 4. 최범주
			
		int iInsCnt         = 0;
		
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가        
        double befGdsGnvAmtTot  = 0;                                                                  // 전상품발주금액합계
        double aftrGdsGnvAmtTot = 0;       															// 후상품발주금액합계 
        List<Map> beforelistMap = new ArrayList<Map>();  // 전상품발주금액합계
        List<Map> afterlistMap = new ArrayList<Map>();  // 후상품발주금액합계                                                          // 후상품발주금액합계
        String[] docuSource   = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문
        String prNum          = "";                                                                 // PO_PR_NUM_S 신청번호:"년월일-0000"
        String purcProcRslt   = "";                                                                 // 구매처리결과
// [속도개선 Project 시작] 2017. 8. 4. 최범주
		
		//구매인터페이스용 DS
		DataSet ds_poIf;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
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
        sbSql.append("\n              , NVL(A.SALE_PRICE, 0) * NVL(A.PO_QTY, 0) AS SALE_AMT                      			  ");
        sbSql.append("\n 	      FROM SO_PR A                                                                            ");
        sbSql.append("\n 	     WHERE A.SUBINV_CODE = :subinvCode                                                        ");
        sbSql.append("\n 	       AND A.NEED_DATE   = :needDate                                                          ");		
		//sbSql.append("\n 	      AND A.PR_NUM   = :sPrNum                                                          	  ");
        // 식단발주일 경우
        if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
        	sbSql.append("\n 	   AND A.DOCU_SOURCE IN (:docuSource)                                                     ");
        }
        sbSql.append("\n 	       AND A.LINE_STATUS NOT IN ('003','999')                                                 ");
        
        sbSql.append("\n        ) AA                                                                                      ");
        sbSql.append("\n  GROUP BY AA.UPJANG                                                                              ");
        sbSql.append("\n         , AA.NEED_DATE                                                                           ");
        sbSql.append("\n         , AA.PR_NUM                                                                              ");
        
        npstmt = new NamedParameterStatement(conn, sbSql.toString());
        npstmt.setString("subinvCode", sSubinv);
        npstmt.setString("needDate", sNeedDate);
		//npstmt.setString("sPrNum", sPrNum);
        // 식단발주일 경우
        if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
        	npstmt.setString("docuSource", docuSource[4]);
        }
        
        rs = npstmt.executeQuery();
        while ( rs.next() ) {
	       	befGdsGnvAmtTot = rs.getBigDecimal("GDS_GNV_TOT").doubleValue();
	       	prNum           = rs.getString("PR_NUM");
			rcUpjang         = rs.getString("UPJANG");
	       	
	       	Map<String, Object> before_rowData = new HashMap<String,Object>();
	       	before_rowData.put("prUpjang", sPrUpjang);
	       	before_rowData.put("needDate", sNeedDate);
	       	before_rowData.put("scrnId", scrnId);
	       	before_rowData.put("scrnName", scrnName);
	       	before_rowData.put("empNo", g_EmpNo);
	       	before_rowData.put("prNum", prNum);
	       	before_rowData.put("rcUpjang", rcUpjang);
	       	before_rowData.put("befGdsGnvAmtTot", befGdsGnvAmtTot);
	       	before_rowData.put("aftrGdsGnvAmtTot", null);
	    	
	    	beforelistMap.add(before_rowData);
        }
        npstmt.close();
        rs.close();
        sbSql.setLength(0);
// [속도개선 Project 시작] 2017. 8. 4. 최범주
		
		//SO_PR 구매 삭제할 주문조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT PR_ID, PR_NUM FROM SO_PR \n");
		sbSql.append(" WHERE NEED_DATE = '" + sNeedDate + "' \n");
		sbSql.append("   AND RC_UPJANG = " + sUpjang + " \n"); 
		sbSql.append("   AND DOCU_SOURCE = '07 FM(식단)' \n");
		sbSql.append("   AND LINE_STATUS = '002' \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_poIf = this.makeDataSet(rs, "ds_poIf");
		rs.close();
		pstmt.close();
		
		//해당날짜/창고의 주문취소
		//PO_PR
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE SO_PR A \n");
		sbSql.append("   SET A.LINE_STATUS = '003' \n");
		sbSql.append("     , A.SO_STATUS = '003' \n");
		sbSql.append("     , A.UPDATE_BY = '" + g_EmpNo + "' \n");
		sbSql.append("     , A.UPDATE_DATE = SYSDATE \n");
		sbSql.append(" WHERE A.NEED_DATE LIKE '" + sNeedDate + "' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + sSubinv + "' \n");
		sbSql.append("   AND A.LINE_STATUS <= '004' \n");
		//메뉴발주인 것만 취소
		sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_RECIPE_ITEM Z \n");
		sbSql.append("                WHERE Z.PR_ID = A.PR_ID \n");
		sbSql.append("                  AND Z.PR_YN = 'Y') \n");
		if(!g_ItemCode.equals("")){
	    	sbSql.append("       AND A.ITEM_CODE = '" + g_ItemCode + "'        \n");}
			out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		iInsCnt = pstmt.executeUpdate();
		pstmt.close();

		//공급업체
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FMP_OTCUST_PR A \n");
		sbSql.append("   SET A.LINE_STATUS = '003' \n");
		sbSql.append("     , A.UUSER = '" + g_EmpNo + "' \n");
		sbSql.append("     , A.UDATE = SYSDATE \n");
		sbSql.append(" WHERE A.NEED_DATE LIKE '" + sNeedDate + "' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + sSubinv + "' \n");
		sbSql.append("   AND A.LINE_STATUS <= '004' \n");
		//공급업체는 마감개념이 없어서 D데이를 체크 
		sbSql.append("   AND (SELECT DECODE( SIGN( TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(Z.D_DAYS,0) - 1) \n");
		sbSql.append("                     , 1, 'Y' \n");
		sbSql.append("                     , 0, DECODE(SIGN(DECODE(Z.D_TIMES,'',2400,0,2400,TO_NUMBER(Z.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'Y','N') \n");
		sbSql.append("                     , 'N' \n");
		sbSql.append("                     ) AS DEL_POS \n");
		sbSql.append("          FROM FMP_OTCUST_ITEM Z \n");
		sbSql.append("         WHERE Z.ITEM_CODE = A.ITEM_CODE) = 'Y' \n");
		//메뉴발주인 것만 취소
		sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_RECIPE_ITEM Z \n");
		sbSql.append("                WHERE Z.PR_ID = A.PR_ID \n");
		sbSql.append("                  AND Z.PR_YN = 'Y') \n");
		if(!g_ItemCode.equals("")){
	    	sbSql.append("       AND A.ITEM_CODE = '" + g_ItemCode + "'        \n");}
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		iInsCnt = pstmt.executeUpdate();
		pstmt.close();

		//식단복원
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
		sbSql.append("   SET A.PR_YN  = 'N' \n");
		sbSql.append("     , A.PR_ID  = NULL \n");
		sbSql.append("     , A.PR_NUM = NULL \n");
		sbSql.append("     , A.PR_QTY = 0 \n");
		sbSql.append("     , A.UUSER  = '" + g_EmpNo + "' \n");
		sbSql.append("     , A.UDATE  = SYSDATE \n");
		sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND A.NEED_DATE LIKE '" + sNeedDate + "' \n");
		sbSql.append("   AND A.PR_YN  = 'Y' \n");
		sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
		sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
		sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
		sbSql.append("                  AND B.UPJANG = " + sUpjang + " \n");
		sbSql.append("                  AND B.SUBINV_CODE = '" + sSubinv + "') \n");
		//발주되지 않은 것만
		sbSql.append("   AND NOT EXISTS (SELECT 1 FROM SO_PR Z \n");
		sbSql.append("                    WHERE Z.PR_ID = A.PR_ID \n");
		sbSql.append("                      AND Z.LINE_STATUS > '004') \n");
		sbSql.append("   AND NOT EXISTS (SELECT 1 FROM FMP_OTCUST_PR Z \n");
		sbSql.append("                    WHERE Z.PR_ID = A.PR_ID \n");
		sbSql.append("                      AND Z.LINE_STATUS > '004') \n");
		//공급업체는 마감개념이 없어서 D데이를 체크 
		sbSql.append("   AND NOT EXISTS (SELECT 1 FROM FMP_OTCUST_ITEM Z \n");
		sbSql.append("                    WHERE Z.ITEM_CODE = A.ITEM_CODE \n");
		sbSql.append("                      AND DECODE( SIGN( TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(Z.D_DAYS,0) - 1) \n");
		sbSql.append("                                , 1, 'Y' \n");
		sbSql.append("                                , 0, DECODE(SIGN(DECODE(Z.D_TIMES,'',2400,0,2400,TO_NUMBER(Z.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,'Y','N') \n");
		sbSql.append("                                , 'N' \n");
		sbSql.append("                                ) = 'N' \n");
		sbSql.append("                  ) \n");
		if(!g_ItemCode.equals("")){
	    	sbSql.append("       AND A.ITEM_CODE = '" + g_ItemCode + "'        \n");}
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		iInsCnt = pstmt.executeUpdate();
		pstmt.close();

		
		for ( int i = 0 ; i < ds_poIf.getRowCount() ; i++ )
		{
    		// 구매 프로시져 호출
    		cstmt = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
    		
    		//실행
    		cstmt.setString(1,"100");
    		cstmt.setString(2,"HFC");
    		cstmt.setString(3,"FR");
    		cstmt.setString(4,"MT");
    		cstmt.setString(5,sPrUpjang);
    		cstmt.setString(6,sPrSabun);
    		cstmt.setString(7,"07");
    		cstmt.setString(8,nullToBlank(ds_poIf.getString(i, "PR_NUM")));
    		cstmt.setString(9,"U");
    		cstmt.registerOutParameter(10, Types.VARCHAR);
    		cstmt.registerOutParameter(11, Types.VARCHAR);
    		
    		cstmt.execute();
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
            purcProcRslt = cstmt.getString(10);  // 구매처리결과
//[속도개선 Project 시작] 2017. 8. 4. 최범주
            
            if(!cstmt.getString(10).equals("S000"))
            {
                conn.rollback();
                this.setResultMessage(-1, cstmt.getString(11), out_vl);
                proc_output(response,out,out_vl,out_dl);
                return;
            }
            cstmt.close();
		}	
		
		
		/*
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
			
			System.out.println("cstmt.getString(10)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + cstmt.getString(10));
			
			if(!cstmt.getString(10).equals("S000"))	
			{
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(11), out_vl);
				return;			
			}
	
			cstmt.close();
		}
		*/
		
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
	        sbSql.append("\n                CASE WHEN AA.TAX_CODE = '100' THEN AA.SALE_AMT * 1.1  /* 과세일 경우 */  		  ");
	        sbSql.append("\n                     ELSE                          AA.SALE_AMT                                    ");
	        sbSql.append("\n                END                                                                               ");
	        sbSql.append("\n        , 0))) AS GDS_GNV_TOT  /* 상품발주합계 */                                                  ");
	        sbSql.append("\n   FROM (                                                                                         ");
	        sbSql.append("\n         SELECT                                                                                   ");
	        sbSql.append("\n                A.RC_UPJANG AS UPJANG                                                             ");
	        sbSql.append("\n              , A.NEED_DATE                                                                       ");
	        sbSql.append("\n              , A.PR_NUM                                                                          ");
	        sbSql.append("\n              , A.TAX_CODE                                                                        ");
	        sbSql.append("\n              , NVL(A.SALE_PRICE, 0) * NVL(A.PO_QTY, 0) AS SALE_AMT   			                  ");
	        sbSql.append("\n 	      FROM SO_PR A                                                                            ");
	        sbSql.append("\n 	     WHERE A.SUBINV_CODE = :subinvCode                                                        ");
	        sbSql.append("\n 	       AND A.NEED_DATE   = :needDate                                                          ");		
			//sbSql.append("\n 	      AND A.PR_NUM   = :sPrNum                                                          	  ");
	        // 식단발주일 경우
	        if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
	        	sbSql.append("\n 	   AND A.DOCU_SOURCE IN (:docuSource)                                                     ");
	        }
	        sbSql.append("\n 	       AND A.LINE_STATUS NOT IN ('003','999')                                                 ");
	        
	        sbSql.append("\n        ) AA                                                                                      ");
	        sbSql.append("\n  GROUP BY AA.UPJANG                                                                              ");
	        sbSql.append("\n         , AA.NEED_DATE                                                                           ");
	        sbSql.append("\n         , AA.PR_NUM                                                                              ");
	        
	        npstmt = new NamedParameterStatement(conn, sbSql.toString());
	        npstmt.setString("subinvCode", sSubinv);
	        npstmt.setString("needDate", sNeedDate);
			//npstmt.setString("sPrNum", sPrNum);
	        // 식단발주일 경우
	        if ( ValidationUtil.isEquals(scrnId, "FMP00130E") ) {
	        	npstmt.setString("docuSource", docuSource[4]);
	        }
	        
	        rs = npstmt.executeQuery();
	        while ( rs.next() ) {
	        	aftrGdsGnvAmtTot = rs.getBigDecimal("GDS_GNV_TOT").doubleValue();
	        	prNum            = rs.getString("PR_NUM");
				rcUpjang         = rs.getString("UPJANG");

				Map<String, Object> after_rowData = new HashMap<String,Object>();
				after_rowData.put("prUpjang", sPrUpjang);
				after_rowData.put("needDate", sNeedDate);
				after_rowData.put("scrnId", scrnId);
				after_rowData.put("scrnName", scrnName);
				after_rowData.put("empNo", g_EmpNo);
				after_rowData.put("prNum", prNum);
				after_rowData.put("rcUpjang", rcUpjang);
				after_rowData.put("befGdsGnvAmtTot", null);
				after_rowData.put("aftrGdsGnvAmtTot", aftrGdsGnvAmtTot);
		    	
		    	afterlistMap.add(after_rowData);
	        }
	        npstmt.close();
	        rs.close();
	        sbSql.setLength(0);
        }
				
		for (int i = 0 ; i < afterlistMap.size() ; i++) {
	        	
	        	Map<String, Object> aMap = afterlistMap.get(i);
	        	
	        	prNum = aMap.get("prNum").toString();
	        	aftrGdsGnvAmtTot = (Double) aMap.get("aftrGdsGnvAmtTot");

	        	//발생전 금액 초기화 
	        	befGdsGnvAmtTot = 0;		
	        	for (int j = 0 ; j < beforelistMap.size() ; j++) {
	        		Map<String, Object> bMap = beforelistMap.get(j);
					if ( prNum.equals(bMap.get("prNum").toString())) {
						//befGdsGnvAmtTot = bMap.get("befGdsGnvAmtTot");					
						befGdsGnvAmtTot = Math.round((Double) bMap.get("befGdsGnvAmtTot"));
					}       
	        	}       
	        	/*
	        	if (beforelistMap.size() == 0) {
	        		befGdsGnvAmtTot = 0;
	        	}
	        	*/
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
					cstmt.setString(1, rcUpjang);                   // (필수)업장코드
					cstmt.setString(2, sNeedDate);                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					cstmt.setString(3, "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					cstmt.setDouble(4, aftrGdsGnvAmtTot);             // (필수)발생금액
					cstmt.setDouble(5, befGdsGnvAmtTot);              // (필수)발생금액(전)
					cstmt.setString(6, "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					cstmt.setString(7, "(02)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
					cstmt.setString(8, "PR_NUM");             // (필수)키명
					cstmt.setString(9, prNum);                      // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
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
						logger.debug("rcUpjang         : [" + rcUpjang            + "]");
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
		 }
		
		//마지막건을 취소하는 경우 
        if (afterlistMap.size() == 0) {
    		aftrGdsGnvAmtTot = 0;
    		
        	Map<String, Object> aMap = beforelistMap.get(0);
        	
        	prNum = aMap.get("prNum").toString();
        	befGdsGnvAmtTot = (Double) aMap.get("befGdsGnvAmtTot");
        	
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
				cstmt.setString(1, rcUpjang);                   // (필수)업장코드
				cstmt.setString(2, sNeedDate);                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
				cstmt.setString(3, "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
				cstmt.setDouble(4, aftrGdsGnvAmtTot);             // (필수)발생금액
				cstmt.setDouble(5, befGdsGnvAmtTot);              // (필수)발생금액(전)
				cstmt.setString(6, "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
				cstmt.setString(7, "(02)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
				cstmt.setString(8, "PR_NUM");             // (필수)키명
				cstmt.setString(9, prNum);                      // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
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
					logger.debug("rcUpjang         : [" + rcUpjang            + "]");
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
	 }
// [속도개선 Project 시작] 2017. 8. 4. 최범주
		
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