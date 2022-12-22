<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00161E_T001.jsp
■ 프로그램명   : 주문 저장
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2008.01.21
               2009-03-13 박은규 CSR#(25270) 요청자:김진희(식재사업팀)
               주문수량이 0인 것은 식단정보에 발주로 처리
               2021.07.13 [PJT]주문채널통합
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt            = null;
    CallableStatement cstmt   = null;

    DataSet ds_msg = new DataSet();
    DataSet ds_msg_out = new DataSet();
    
    try	{

        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();
        
        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_iud      = in_dl.get("ds_IUD");
        DataSet ds_cond    = in_dl.get("ds_Cond");
        
        //[2021.07.13][PJT]주문채널통합
        if ( "FMP00082E".equals(nullToBlank(in_vl.getString("scrnId"))) ) {
            ds_msg     = in_dl.get("ds_msg");
            ds_msg_out  = in_dl.get("ds_msg");
        }
        //구매인터페이스용 DS
        DataSet ds_poIf = makeDataSet("ds_poIf");
        ds_poIf.addColumn("PR_NUM", DataTypes.STRING);
        ds_poIf.addColumn("ROW_STATUS", DataTypes.STRING);

        //입력 파라메터
        String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));        
        String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
        String sDocSrc      = nullToBlank(in_vl.getString("sDocSrc"));
        String sPrUpjang      = nullToBlank(in_vl.getString("sPrUpjang"));
        String sPrSabun      = nullToBlank(in_vl.getString("sPrSabun"));
        // 신규일경우 기존대로 새로운 주문번호 생성:NEW , 동일업장, 창고 및 입고일자에 주문건수가 있을경우 상품추가시  주문번호를 새로 생성하지 않는다:OLD
        String sGubunNewOrOld = nullToBlank(in_vl.getString("sGubunNewOrOld"));
        String sMaxPrNum = nullToBlank(in_vl.getString("sMaxPrNum"));
        String sMaxApproveNum = nullToBlank(in_vl.getString("sMaxApproveNum"));
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
        String scrnId         = nullToBlank(in_vl.getString("scrnId"));    // 화면ID
		String scrnName       = nullToBlank(in_vl.getString("scrnName"));  // 화면명
        String cNeedDate     = "";  //입고예정일 주문내역에서 가져오기 2017.10.11 김호석(입고예정일 변경되어 넘어오는 경우 문제 발생)
        String cSubinv       = "";  //창고코드 주문내역에서 가져오기 2017.10.11 김호석(창고코드 변경되어 넘어오는 경우 문제 발생)
		String rcUpjang      = ""; //주문업장
// [속도개선 Project 시작] 2017. 8. 4. 최범주
        String sPR_Qty      = "";
        int sRowStatus;
        String sOtcustCD    = "";
        String sMenuFlag    = "";
        String sItemStatus  = ""; //[PJT]주문채널통합

		int tInsCnt         = 0;
        int iInsCnt         = 0;
        int iUpdateCnt      = 0;
        int iAddCnt         = 0;
        int iDeleteCnt      = 0;
            
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가        
        double befGdsGnvAmtTot    = 0;                                                                                 // 전상품발주금액합계
        double aftrGdsGnvAmtTot   = 0;  
        List<Map> beforelistMap = new ArrayList<Map>();  // 전상품발주금액합계
        List<Map> afterlistMap = new ArrayList<Map>();  // 후상품발주금액합계
        String[] docuSource     = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)", "07 FM(주요)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문, 주요상품발주
        String prNum            = "";                                                                                // PO_PR_NUM_S 신청번호:"년월일-0000"
        String purcProcRslt     = "";                                                                                // 구매처리결과
        
        //입고예정일 주문내역에서 가져오기 2017.10.11 김호석(입고예정일 변경되어 넘어오는 경우 문제 발생)
        cNeedDate = nullToBlank(ds_iud.getString(0, "NEED_DATE"));
      	//창고코드 주문내역에서 가져오기 2017.10.11 김호석(창고코드 변경되어 넘어오는 경우 문제 발생)
        cSubinv = nullToBlank(ds_iud.getString(0, "SUBINV_CODE"));
        //1건을 수량0으로 변경하는 경우
        if (cNeedDate.equals("")) {
//[PJT]주문채널통합nullpointexception처리
//         	cNeedDate = nullToBlank(ds_iud.getRemovedData(0, "NEED_DATE").toString());
//         	cSubinv = nullToBlank(ds_iud.getRemovedData(0, "SUBINV_CODE").toString());
        	cNeedDate = nullToBlank((String)ds_iud.getRemovedData(0, "NEED_DATE"));
        	cSubinv = nullToBlank((String)ds_iud.getRemovedData(0, "SUBINV_CODE"));
        }
// [속도개선 Project 시작] 2017. 8. 4. 최범주


        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        
        //구매신청번호 및 승인번호 가져오기
        sbSql.delete(0, sbSql.length());

        /*
        sbSql.append("SELECT NVL((SELECT PR_NUM \n");
        sbSql.append("              FROM (SELECT PR_NUM FROM SO_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1 \n");
        sbSql.append("                     UNION ALL \n");
        sbSql.append("                    SELECT PR_NUM FROM FMP_OTCUST_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
        sbSql.append("             WHERE ROWNUM <= 1) \n");
        sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0')) AS PRNUM \n");
        sbSql.append("     , NVL((SELECT PR_NUM \n");
        sbSql.append("              FROM (SELECT PR_NUM FROM SO_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1 \n");
        sbSql.append("                     UNION ALL \n");
        sbSql.append("                    SELECT PR_NUM FROM FMP_OTCUST_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
        sbSql.append("             WHERE ROWNUM <= 1) \n");
        sbSql.append("          ,'NEW') AS NEW_TYPE \n");
        sbSql.append("     , NVL((SELECT APPROVE_NUM FROM SO_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
        sbSql.append("          , '자동'||TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_APV_NUM_S.NEXTVAL,4,'0')) AS PRAPPRNUM \n");
        sbSql.append("  FROM DUAL \n");
        */

        sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0') AS PRNUM \n");
        sbSql.append("     , NVL((SELECT PR_NUM \n");
        sbSql.append("              FROM (SELECT PR_NUM FROM FMP_OTCUST_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
        sbSql.append("             WHERE ROWNUM <= 1) \n");
        sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0')) AS OTCUST_PRNUM \n");
        sbSql.append("     , '자동'||TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_APV_NUM_S.NEXTVAL,4,'0') AS PRAPPRNUM \n");
        sbSql.append("  FROM DUAL \n");

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
		
        String sPrNum = "";
        String sOtcustPrNum = "";
        String sPrApprNum = "";

        System.out.println(" ------------------!!!!!!!!!!!!!_------------");
        System.out.println("sNeedDate     : [" + sNeedDate + "]");
        System.out.println("sSubinv       : [" + sSubinv + "]");
        System.out.println("g_Upjang      : [" + g_Upjang + "]");
        System.out.println("g_EmpNo       : [" + g_EmpNo + "]");
        System.out.println("sDocSrc       : [" + sDocSrc + "]");
        System.out.println("sPrUpjang     : [" + sPrUpjang + "]");
        System.out.println("sPrSabun      : [" + sPrSabun + "]");
        System.out.println("PRNUM         : [" + nullToBlank(rs.getString("PRNUM")) + "]");
        System.out.println("sMaxPrNum     : [" + sMaxPrNum + "]");
        System.out.println("sGubunNewOrOld: [" + sGubunNewOrOld + "]");
        System.out.println(" ------------------!!!!!!!!!!!!!_------------");
       	
        if(sGubunNewOrOld.equals("NEW"))
        {
        	sPrNum = nullToBlank(rs.getString("PRNUM"));
        	sOtcustPrNum = nullToBlank(rs.getString("OTCUST_PRNUM"));
        	sPrApprNum = nullToBlank(rs.getString("PRAPPRNUM"));
        }
        else if(sGubunNewOrOld.equals("OLD"))
        {
        	sPrNum = sMaxPrNum;
        	sOtcustPrNum = nullToBlank(rs.getString("OTCUST_PRNUM"));
        	
        	if(sMaxApproveNum.equals(""))
        	{
        		sPrApprNum = nullToBlank(rs.getString("PRAPPRNUM"));
        	}
        	else
        	{
        		sPrApprNum = sMaxApproveNum;
        	}        	
        }
        else
        {
        	sPrNum = nullToBlank(rs.getString("PRNUM"));
        	sOtcustPrNum = nullToBlank(rs.getString("OTCUST_PRNUM"));
        	sPrApprNum = nullToBlank(rs.getString("PRAPPRNUM"));
        	
        }
        
        rs.close();
        pstmt.close();   
		
		
		StringBuffer buffer = new StringBuffer();
        Map<String, String> map = new HashMap();
        Map<String, String[]> parameters = request.getParameterMap();
        for (String key : parameters.keySet())  {
           String[] value = parameters.get(key);
           buffer.append(key + "=" + Arrays.toString(value) + ";");
           map.put(key, value[0]);
        }
        //System.out.println(buffer.toString()); 

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
			sbSql.append("	, '" + sPrApprNum + "' \n");
			sbSql.append("	, '" + buffer.toString() + "' \n");			
            sbSql.append(" ) \n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
            tInsCnt = pstmt.executeUpdate();
            pstmt.close();
		
			
		}

        sbSql.delete(0, sbSql.length());
		
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
        sbSql.append("\n                CASE WHEN AA.TAX_CODE = '100' THEN AA.SALE_AMT * 1.1   /* 과세일 경우 */  ");
        sbSql.append("\n                     ELSE                          AA.SALE_AMT                                    ");
        sbSql.append("\n                END                                                                               ");
        sbSql.append("\n        , 0))) AS GDS_GNV_TOT  /* 상품발주합계 */                                                  ");
        sbSql.append("\n   FROM (                                                                                         ");
        sbSql.append("\n         SELECT                                                                                   ");
        sbSql.append("\n                A.RC_UPJANG AS UPJANG                                                             ");
        sbSql.append("\n              , A.NEED_DATE                                                                       ");
        sbSql.append("\n              , A.PR_NUM                                                                          ");
        sbSql.append("\n              , A.TAX_CODE                                                                        ");
        sbSql.append("\n              , NVL(A.SALE_PRICE, 0) * NVL(A.PO_QTY, 0)  AS SALE_AMT                      ");
        sbSql.append("\n 	      FROM SO_PR A                                                                            ");
        sbSql.append("\n 	     WHERE A.SUBINV_CODE = :subinvCode                                                        ");
        sbSql.append("\n 	       AND (A.NEED_DATE   = :needDate                                                          ");		
        sbSql.append("\n 	       OR A.NEED_DATE   = :needDate2)                                                           ");
		//sbSql.append("\n 	      AND A.PR_NUM   = :sPrNum                                                          	  ");
        // 상품발주, 식재장바구니일 경우
        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00082E|ShoppingFicsBasket") ) {
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
        //창고코드 주문내역에서 가져오기 2017.10.11 김호석(창고코드 변경되어 넘어오는 경우 문제 발생)
        //npstmt.setString("subinvCode", sSubinv);
        npstmt.setString("subinvCode", cSubinv);
        //입고예정일 주문내역에서 가져오기 2017.10.11 김호석(입고예정일 변경되어 넘어오는 경우 문제 발생)
        //npstmt.setString("needDate", sNeedDate);
        npstmt.setString("needDate", cNeedDate);
        npstmt.setString("needDate2", sNeedDate);
		//npstmt.setString("sPrNum", sPrNum);
        // 상품발주, 식재장바구니일 경우
        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00082E|ShoppingFicsBasket") ) {
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
        while ( rs.next() ) {
	       	befGdsGnvAmtTot = rs.getBigDecimal("GDS_GNV_TOT").doubleValue();
        	prNum           = rs.getString("PR_NUM");
	       	
	       	Map<String, Object> before_rowData = new HashMap<String,Object>();
	       	before_rowData.put("prUpjang", sPrUpjang);
	       	before_rowData.put("needDate", sNeedDate);
	       	before_rowData.put("scrnId", scrnId);
	       	before_rowData.put("scrnName", scrnName);
	       	before_rowData.put("empNo", g_EmpNo);
	       	before_rowData.put("prNum", prNum);
	       	before_rowData.put("befGdsGnvAmtTot", befGdsGnvAmtTot);
	       	before_rowData.put("aftrGdsGnvAmtTot", null);
	    	
	    	beforelistMap.add(before_rowData);
        }
        npstmt.close();
        rs.close();
        sbSql.setLength(0);
// [속도개선 Project 시작] 2017. 8. 4. 최범주
    
		
        
        //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>1:sPrNum:"+sPrNum);

        //입력,수정
        for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
        {
            sbSql.delete(0, sbSql.length());

            sRowStatus  = ds_iud.getRowType(i);
            sOtcustCD   = nullToBlank(ds_iud.getString(i, "OTCUSTCD"));
            sPR_Qty     = nullToBlank(ds_iud.getString(i, "PR_QTY"));
            sItemStatus = nullToBlank(ds_iud.getString(i, "ITEM_STATUS")); //[PJT]주문채널통합 [ E : ERROR, N : NOMAL(정상)]
            
            if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
            {
                continue;
            }
            //[PJT]주문채널통합 [ E : ERROR, N : NOMAL(정상)]
            else if ("E".equals(sItemStatus))
            {
                continue;
            }
            else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
            {
            	
            	
            	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>2");
            	//PR_ID생성
                sbSql.append("SELECT SO_PR_S.NEXTVAL AS PR_ID FROM DUAL \n");
                pstmt = conn.prepareStatement(sbSql.toString());
                rs = pstmt.executeQuery();
                rs.next();
                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>3:PR_ID:"+rs.getString("PR_ID"));
                ds_iud.set(i, "PR_ID", nullToBlank(rs.getString("PR_ID")));
                rs.close();
                pstmt.close();

                sbSql.delete(0, sbSql.length());
                
                if (sOtcustCD.equals("0000"))
                {
                	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>4:SO_PR_INSERT_START");
                	sbSql.append("INSERT INTO SO_PR( \n");
                    sbSql.append("      PR_ID \n");
                    sbSql.append("    , PR_NUM \n");
                    sbSql.append("    , PR_DATE \n");
                    sbSql.append("    , PR_DEPT_ID \n");
                    sbSql.append("    , PR_UPJANG \n");
                    sbSql.append("    , PR_SABUN \n");
                    sbSql.append("    , APPROVER \n");
                    sbSql.append("    , APPROVE_TIME \n");
                    sbSql.append("    , APPROVE_NUM \n");
                    sbSql.append("    , PO_TYPE \n");
                    sbSql.append("    , DOCU_SOURCE \n");
                    sbSql.append("    , CUSTCD \n");
                    sbSql.append("    , SUBINV_CODE \n");
                    sbSql.append("    , RC_MU_CD \n");
                    sbSql.append("    , RC_DEPT_ID \n");
                    sbSql.append("    , RC_UPJANG \n");
                    sbSql.append("    , BUDDEPT_ID \n");
                    sbSql.append("    , CENTER_CODE \n");
                    sbSql.append("    , ITEM_CODE \n");
                    sbSql.append("    , ITEM_NAME \n");
                    sbSql.append("    , ITEM_SIZE \n");
                    sbSql.append("    , PO_UOM \n");
                    sbSql.append("    , TAX_CODE \n");
                    sbSql.append("    , ACCTCD \n");
                    sbSql.append("    , BUD_CLS \n");
                    sbSql.append("    , CENTER_FLAG \n");
                    sbSql.append("    , UNIT_PRICE \n");
                    sbSql.append("    , MARGIN_PRICE \n");
                    sbSql.append("    , SALE_PRICE \n");
                    sbSql.append("    , PR_QTY \n");
                    sbSql.append("    , PO_QTY \n");
                    sbSql.append("    , NEED_DATE \n");
                    sbSql.append("    , INVAT_FLAG \n");
                    sbSql.append("    , OUTVAT_FLAG \n");
                    sbSql.append("    , PR_REMARK \n");
                    sbSql.append("    , LINE_STATUS \n");
                    sbSql.append("    , CREATE_BY \n");
                    sbSql.append("    , CREATE_DATE \n");
                    sbSql.append("    , UPDATE_BY \n");
                    sbSql.append("    , UPDATE_DATE \n");
                    sbSql.append("    , APPLY_SD \n");
                    sbSql.append("    , VD_SN \n");
                    sbSql.append("    , MOBILE_GUBUN \n");
                    sbSql.append("    , UPJANG_GRP \n");
                    sbSql.append("	  , OP_PRICE \n");
                    sbSql.append("	  , OP_RATE \n");
                    sbSql.append("	  , T_ORDER \n");
                    sbSql.append("	  , WMS_INT_ID \n"); //[PJT]주문채널통합 
                    sbSql.append(" ) VALUES ( \n");
                    sbSql.append("	" + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("	, '" + sPrNum + "' \n");	
                    sbSql.append("	, TO_CHAR(SYSDATE,'YYYYMMDD') \n");
                    sbSql.append("	, (SELECT DEPT_ID FROM HLDC_ST_UPJANG WHERE UPJANG = " + g_Upjang + ") \n");
                    sbSql.append("	, " + g_Upjang + " \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
                    sbSql.append("	, '" + sPrApprNum + "' \n");
                    sbSql.append("	, '07' \n");
                    sbSql.append("	, '" + sDocSrc + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "CUSTCD")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "' \n");
                    sbSql.append("	, (SELECT B.MU_CD FROM HLDC_ST_UPJANG A, HLDC_SC_DEPT B WHERE A.DEPT_ID = B.DEPT_ID AND A.UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + ") \n");
                    sbSql.append("	, (SELECT DEPT_ID FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + ") \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                    //BUDDEPT_ID 이 컬럼이 뭐로 바꿨는지?
                    //sbSql.append("	, (SELECT BUDDEPT_ID FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    sbSql.append("	, (SELECT BUDCC_CD FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "CENTER_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_NAME")).replaceAll("'", "''") + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_SIZE")).replaceAll("'", "''") + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PO_UOM")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "TAX_CODE")) + "' \n");
                    sbSql.append("	, (SELECT MATERIAL_ACCTCD FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    //MATERIAL_BUD_CLS 이 컬럼이 뭐로 바꿨는지? MATERIAL_ACCTCD 로 대체
                    //sbSql.append("	, (SELECT NVL(MATERIAL_BUD_CLS,' ') FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    sbSql.append("	, (SELECT MATERIAL_ACCTCD FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "CENTER_FLAG")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("	, '" + sNeedDate + "' \n"); /*날짜변경 후 저장하는 케이스가 있음. 그리드에서 가져오면 안됨*/
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "INVAT_FLAG")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "OUTVAT_FLAG")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")).replaceAll("'", "''") + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LINE_STATUS")) + "' \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "APPLY_SD")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "VD_SN")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "MOBILE_GUBUN")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "UPJANG_GRP")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "OP_RATE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "T_ORDER")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "EVENT_ID")) + "' \n"); //[PJT]주문채널통합 
                    sbSql.append(" ) \n");
                	
                    //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>5:SO_PR_INSERT_END");

                    iAddCnt++;
                }
                else
                {
                	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>6:FMP_OTCUST_PR_INSERT_START");
                	
                	sbSql.append("INSERT INTO FMP_OTCUST_PR( \n");
                    sbSql.append("	  PR_ID \n");
                    sbSql.append("	, PR_NUM \n");
                    sbSql.append("  , DOCU_SOURCE \n");
                    sbSql.append("	, PR_DATE \n");
                    sbSql.append("	, PR_SABUN \n");
                    sbSql.append("	, NEED_DATE \n");
                    sbSql.append("	, UPJANG \n");
                    sbSql.append("	, SUBINV_CODE \n");
                    sbSql.append("	, ITEM_CODE \n");
                    sbSql.append("	, ITEM_NAME \n");
                    sbSql.append("	, ITEM_SIZE \n");
                    sbSql.append("	, PO_UOM \n");
                    sbSql.append("	, TAX_CODE \n");
                    sbSql.append("	, PO_QTY \n");
                    sbSql.append("	, PR_QTY \n");
                    sbSql.append("	, UNIT_PRICE \n");
                    sbSql.append("	, UNIT_AMOUNT \n");
                    sbSql.append("	, SALE_PRICE \n");
                    sbSql.append("	, SALE_AMOUNT \n");
                    sbSql.append("	, OP_PRICE \n");
                    sbSql.append("	, OP_AMOUNT \n");
                    sbSql.append("	, OTCUSTCD \n");
                    sbSql.append("	, CONTENTS \n");
                    sbSql.append("	, LINE_STATUS \n");
                    sbSql.append("	, CUSER \n");
                    sbSql.append("	, CDATE \n");
                    sbSql.append("	, UUSER \n");
                    sbSql.append("	, UDATE \n");
                    sbSql.append("	, T_ORDER \n");
                    sbSql.append(" ) VALUES ( \n");
                    sbSql.append("	" + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("	, '" + sOtcustPrNum + "' \n");	
                    sbSql.append("	, '" + sDocSrc + "' \n");
                    sbSql.append("	, TO_CHAR(SYSDATE,'YYYYMMDD') \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, '" + sNeedDate + "' \n"); /*날짜변경 후 저장하는 케이스가 있음. 그리드에서 가져오면 안됨*/
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_NAME")).replaceAll("'", "''") + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_SIZE")).replaceAll("'", "''") + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PO_UOM")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "TAX_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + "' \n");
                    sbSql.append("	, ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + ") \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + "' \n");
                    sbSql.append("	, ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + ") \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + " \n");
                    sbSql.append("	, ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + ") \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "OTCUSTCD")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")).replaceAll("'", "''") + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LINE_STATUS")) + "' \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "T_ORDER")) + "' \n");
                    sbSql.append(" ) \n");
                	
                    //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>7:FMP_OTCUST_PR_INSERT_END");
                }
            }
            else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
            {
                if (sOtcustCD.equals("0000"))
                {
                	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>8:SO_PR_UPDATE_START");
                	
                	sbSql.append("UPDATE SO_PR \n");
                    sbSql.append("   SET PR_QTY = '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("     , PO_QTY = '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("     , PR_REMARK = '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")).replaceAll("'", "''") + "' \n");
                    sbSql.append("     , LINE_STATUS = DECODE('" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "',0,'003',LINE_STATUS) \n");
                    sbSql.append("     , SO_STATUS = DECODE('" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "',0,'003',SO_STATUS) \n");
                    sbSql.append("     , APPROVER = '" + g_EmpNo + "' \n");
                    sbSql.append("     , APPROVE_TIME = TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
                    sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
                    sbSql.append("     , UPDATE_DATE = SYSDATE \n");
                    sbSql.append("     , T_ORDER = '" + nullToBlank(ds_iud.getString(i, "T_ORDER")) + "' \n");
                    sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("   AND LINE_STATUS <= '004' \n");

                    // 구매 인터페이스용 DS
                    if (!ds_iud.getString(i, "PR_NUM").equals(ds_iud.getString(i-1, "PR_NUM")))
                    {
                        int nRow = ds_poIf.newRow();
                        ds_poIf.set(nRow, "PR_NUM", ds_iud.getString(i, "PR_NUM"));
                        ds_poIf.set(nRow, "ROW_STATUS", "U");
                    }
                    
                    //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>9:SO_PR_UPDATE_END");

                    iUpdateCnt++;
                }
                else
                {
                	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>10:FMP_OTCUST_PR_UPDATE_START");
                	
                	sbSql.append("UPDATE FMP_OTCUST_PR \n");
                    sbSql.append("   SET PO_QTY = '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("     , PR_QTY = '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                    sbSql.append("     , UNIT_AMOUNT = ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + ") \n");
                    sbSql.append("     , SALE_AMOUNT = ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + ") \n");
                    sbSql.append("     , OP_AMOUNT = ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + ") \n");
                    sbSql.append("     , CONTENTS = '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")).replaceAll("'", "''") + "' \n");
                    sbSql.append("     , LINE_STATUS = DECODE(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + ",0,'003',LINE_STATUS) \n");
                    sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                    sbSql.append("     , UDATE = SYSDATE \n");
                    sbSql.append("     , T_ORDER = '" + nullToBlank(ds_iud.getString(i, "T_ORDER")) + "' \n");
                    sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("   AND LINE_STATUS <= '004' \n");
                    
                    //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>11:FMP_OTCUST_PR_UPDATE_END");
                }
            }

            pstmt = conn.prepareStatement(sbSql.toString());
            iInsCnt = pstmt.executeUpdate();
            pstmt.close();
            
            //추가 또는 수정시 PR_ID 및 ROW_TYPE값을 임시 테이블에 저장한다.
            //구매 자재신청 유효성 체크시 해당 동일 PR_NUM중에서 해당 테이블에 있는 PR_ID신청 및 수정건만 체크하기 위함
            if (sRowStatus == DataSet.ROW_TYPE_INSERTED || sRowStatus == DataSet.ROW_TYPE_UPDATED)
            {	
            	String rowType    = "";
            	
            	if(sRowStatus == DataSet.ROW_TYPE_INSERTED)
            	{
            		rowType = "I";
            	}
            	else if(sRowStatus == DataSet.ROW_TYPE_UPDATED)
            	{
            		rowType = "U";
            	}
            	
            	sbSql.delete(0, sbSql.length());
            	
            	sbSql.append("INSERT INTO FMP_PR_ID_TEMP( \n");
                sbSql.append("      PR_ID \n");
                sbSql.append("    , PR_NUM \n");
                sbSql.append("    , ROW_TYPE \n");
                sbSql.append("    , CREATE_BY \n");
                sbSql.append("    , CREATE_DATE \n");
                sbSql.append("    , UPDATE_BY \n");
                sbSql.append("    , UPDATE_DATE \n");
                sbSql.append(" ) VALUES ( \n");
                sbSql.append("	" + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                sbSql.append("	, '" + sPrNum + "' \n");	
                sbSql.append("	, '" + rowType + "' \n");
                sbSql.append("	, '" + g_EmpNo + "' \n");
                sbSql.append("	, SYSDATE \n");
                sbSql.append("	, '" + g_EmpNo + "' \n");
                sbSql.append("	, SYSDATE \n");  
                sbSql.append(" ) \n");
            	
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
            	
            }  
            
            if (iInsCnt <= 0){continue;}

            //식단발주인 경우 식단자료 업데이트
            if (sDocSrc.equals("07 FM(식단)"))
            {
                sMenuFlag = nullToBlank(ds_iud.getString(i, "MENU_FLAG"));

                if (! sMenuFlag.equals("Y"))
                {
                    continue;
                }

                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>12:FMM_RECIPE_ITEM_UPDATE_START");
                
                sbSql.delete(0, sbSql.length());

                sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
                sbSql.append("   SET PR_YN = 'Y' \n");
                if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
                    sbSql.append("     , PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                
                sbSql.append("     , PR_NUM = '" + sPrNum + "' \n");	
                sbSql.append("     , PR_QTY = '" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + "' \n");
                sbSql.append("     , UNIT_PRICE = '" + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + "' \n");
                sbSql.append("     , OP_PRICE = '" + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + "' \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                //2015.10.13 sbSql.append("   AND NEED_DATE LIKE '" + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + "' \n");
                sbSql.append("   AND NEED_DATE = '" + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + "' \n");
                sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
                sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
                sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
                sbSql.append("                  AND B.UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                sbSql.append("                  AND B.SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
                {
                    sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
                    sbSql.append("   AND PR_YN = 'N' \n");
                }
                else
                {
                    sbSql.append("   AND PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("   AND PR_YN = 'Y' \n");
                }

                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
                
                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>13:FMM_RECIPE_ITEM_UPDATE_END");
            }           
            
        }

        //삭제(수량을 0으로 수정해서 화면 내부에서 강제로 삭제한 것) - 기존신청자료가 아닌 신규식단자료는 Insert후 Delete이므로 Delete버퍼에 쌓이지 않는다.
        String sPrID;

        for ( int i = 0 ; i < ds_iud.getRemovedRowCount() ; i++ )
        {
            sPrID  = ds_iud.getRemovedData(i, "PR_ID").toString();
            //PR_ID가 -1인 것은 사용자의 삭제처리로 이미 처리가 끝난것
            if (sPrID.equals("-1")) continue;

            //기존 구매신청자료 삭제처리
            //과거와는 달리 주문삭제 시 "취소"로 남기지 않고 그냥 삭제처리한다.
            //"취소"로 남겨야 할 경우 LINE_STATUS = '003'으로 업데이트 처리하고, 주문화면에서 주문내용 조회 시 취소내용도 감안하여 조회하여야 한다.
            //또한, 마감전 여부로 수정여부를 지정하는 것 역시 다 바뀌어야 한다.
            sbSql.delete(0, sbSql.length());
            sOtcustCD  = ds_iud.getRemovedData(i, "OTCUSTCD").toString();
            if (sOtcustCD.equals("0000"))
            {
            	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>14:SO_PR_UPDATE(003)_START");
            	
            	sbSql.append("UPDATE SO_PR \n");
                sbSql.append("   SET LINE_STATUS = '003' \n");
                sbSql.append("     , SO_STATUS = '003' \n");
                sbSql.append("     , PR_QTY = '" + ds_iud.getRemovedData(i, "PR_QTY").toString() + "' \n");
                sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
                sbSql.append("     , UPDATE_DATE = SYSDATE \n");
                sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                sbSql.append("   AND LINE_STATUS <= '004' \n");

                // 구매 인터페이스용 DS
                if (!ds_iud.getRemovedData(i, "PR_NUM").equals(ds_iud.getRemovedData(i+1, "PR_NUM")))
                {
                    int nRow = ds_poIf.newRow();
                    ds_poIf.set(nRow, "PR_NUM", ds_iud.getRemovedData(i, "PR_NUM"));
                    ds_poIf.set(nRow, "ROW_STATUS", "D");
                }
                
                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>15:SO_PR_UPDATE(003)_END");

                iDeleteCnt++;
            }
            else
            {
            	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>16:FMP_OTCUST_PR_UPDATE(003)_START");
            	
            	sbSql.append("UPDATE FMP_OTCUST_PR \n");
                sbSql.append("   SET LINE_STATUS = '003' \n");
                sbSql.append("     , PR_QTY = '" + ds_iud.getRemovedData(i, "PR_QTY").toString() + "' \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                sbSql.append("   AND LINE_STATUS <= '004' \n");
                
                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>17:FMP_OTCUST_PR_UPDATE(003)_END");
            }

            pstmt = conn.prepareStatement(sbSql.toString());
            iInsCnt = pstmt.executeUpdate();
            pstmt.close();
            if (iInsCnt <= 0){continue;}

            //식단발주인 경우 식단자료 업데이트
            if (sDocSrc.equals("07 FM(식단)"))
            {
                sMenuFlag = ds_iud.getRemovedData(i, "MENU_FLAG").toString();

                if (! sMenuFlag.equals("Y"))
                {
                    continue;
                }

                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>18:FMM_RECIPE_ITEM_UPDATE(-999)_START");
                
                sbSql.delete(0, sbSql.length());
                //취소자료는 일단 주문상태이며, 주문수량만 0이다.
                sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
                sbSql.append("   SET PR_QTY = 0 \n");
                sbSql.append("     , PR_ID = -999 \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE UPJANG = " + ds_iud.getRemovedData(i, "RC_UPJANG").toString() + " \n");
                // 2015.10.13 sbSql.append("   AND NEED_DATE LIKE '" + ds_iud.getRemovedData(i, "NEED_DATE").toString() + "' \n");
                sbSql.append("   AND NEED_DATE = '" + ds_iud.getRemovedData(i, "NEED_DATE").toString() + "' \n");
                sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
                sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
                sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
                sbSql.append("                  AND B.UPJANG = " + ds_iud.getRemovedData(i, "RC_UPJANG").toString() + " \n");
                sbSql.append("                  AND B.SUBINV_CODE = '" + ds_iud.getRemovedData(i, "SUBINV_CODE").toString() + "') \n");
                sbSql.append("   AND PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                sbSql.append("   AND PR_YN = 'Y' \n");

                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
                
                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>19:FMM_RECIPE_ITEM_UPDATE(-999)_END");
            }
        }


//============================================================================================
//(2009-01-14 추가) 시작
// 박은규 2009-03-13 CSR#(25270) 요청자:김진희(식재사업팀)
// 주문수량이 0인 것은 식단정보에 발주로 처리
//============================================================================================
        //식단발주인 경우
        //수량을 0로 저장 시 내부적으로 삭제처리 하는데
        //기존신청자료가 아닌 신규식단자료는 Insert후 Delete이므로 Delete버퍼에 쌓이지 않는다.
        //그래서 별도의 데이타세트를 받아 처리한다.
        if (sDocSrc.equals("07 FM(식단)"))
        {
            //입력 데이타
            DataSet ds_TmpDel = in_dl.get("ds_TmpDel");
            //입력,수정
            for ( int i = 0 ; i < ds_TmpDel.getRowCount() ; i++ )
            {
            	//System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>20:FMM_RECIPE_ITEM_UPDATE(-999)_START");
            	
            	sbSql.delete(0, sbSql.length());

                //취소자료는 일단 주문상태이며, 주문수량만 0이다.
                sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
                sbSql.append("   SET PR_QTY = 0 \n");
                sbSql.append("     , PR_YN = 'Y' \n");
                sbSql.append("     , PR_ID = -999 \n");
                sbSql.append("     , UNIT_PRICE = '" + nullToZero(ds_TmpDel.getString(i, "SALE_PRICE")).toString() + "' \n");
                sbSql.append("     , OP_PRICE = '" + nullToZero(ds_TmpDel.getString(i, "OP_PRICE")).toString() + "' \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_TmpDel.getString(i, "RC_UPJANG")) + " \n");
                // 20151013 sbSql.append("   AND NEED_DATE LIKE '" + nullToBlank(ds_TmpDel.getString(i, "NEED_DATE")) + "' \n");
                sbSql.append("   AND NEED_DATE = '" + nullToBlank(ds_TmpDel.getString(i, "NEED_DATE")) + "' \n");
                sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
                sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
                sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
                sbSql.append("                  AND B.UPJANG = " + nullToBlank(ds_TmpDel.getString(i, "RC_UPJANG")) + " \n");
                sbSql.append("                  AND B.SUBINV_CODE = '" + nullToBlank(ds_TmpDel.getString(i, "SUBINV_CODE")) + "') \n");
                sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_TmpDel.getString(i, "ITEM_CODE")) + "' \n");
                sbSql.append("   AND PR_YN = 'N' \n");

                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
                
                //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>21:FMM_RECIPE_ITEM_UPDATE(-999)_END");
            }
        }
		//============================================================================================
		//(2009-01-14 추가) 끝
		//============================================================================================
		
		if(!nullToBlank(ds_iud.getString(0, "RC_UPJANG")).equals(""))
		{
			//AP_UNITPRICE_UPJANG 담기
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("SELECT AP_UNITPRICE_UPJANG \n");
	        sbSql.append("  FROM ST_UPJANG \n");
	        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_iud.getString(0, "RC_UPJANG")) + "'  \n");

	        pstmt = conn.prepareStatement(sbSql.toString());
	        rs = pstmt.executeQuery();
	        rs.next();
			
	        String sApUnitpriceUjang =  nullToBlank(rs.getString("AP_UNITPRICE_UPJANG"));        	
	         
	        rs.close();
	        pstmt.close();  
	        
			// 수발주 스케쥴에 따른 유효성 체크
	        sbSql.delete(0, sbSql.length());
			
			sbSql.append(" SELECT A.ITEM_CODE                                                           \n");
			sbSql.append("      , A.ITEM_NAME                                                           \n");
			sbSql.append("      , A.CENTER_CODE                                                         \n");
			sbSql.append("      , A.RC_UPJANG                                                           \n");
			sbSql.append("      , A.CENTER_FLAG                                                         \n");
			sbSql.append("      , '단가업장 수발주 스케쥴에 따른 해당상품 발주제한' AS ITEM_VAL                   \n");
			sbSql.append(" FROM  SO_PR A , FMP_PR_ID_TEMP B 	                                        \n");
			sbSql.append(" WHERE 1=1                                                                    \n");
			sbSql.append(" AND   (CENTER_CODE, CUSTCD, ITEM_CODE) IN                                    \n");
			sbSql.append("       (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                 \n");
			sbSql.append("        FROM   FMP_ORDER_SCHEDULE                                             \n");
			sbSql.append("        WHERE  CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                    \n");
			sbSql.append("        AND    UPJANG = '" + sApUnitpriceUjang + "'                                           \n");
			sbSql.append("        AND    USE_YN = 'Y'                                                   \n");
			sbSql.append("        AND    DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_iud.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'),           \n");
			sbSql.append("                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'        \n");
			sbSql.append("        UNION ALL                                                             \n");
			sbSql.append("        (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                \n");
			sbSql.append("        FROM    FMP_ORDER_SCHEDULE                                            \n");
			sbSql.append("        WHERE   CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                   \n");
			sbSql.append("        AND     UPJANG = -2                                                   \n");
			sbSql.append("        AND     USE_YN = 'Y'                                                  \n");
			sbSql.append("        AND     DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_iud.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'),          \n");
			sbSql.append("                       1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'       \n");
			sbSql.append("        MINUS                                                                 \n");
			sbSql.append("        SELECT  CENTER_CODE, CUSTCD, ITEM_CODE                                \n");
			sbSql.append("        FROM    FMP_ORDER_SCHEDULE                                            \n");
			sbSql.append("        WHERE   CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                   \n");
			sbSql.append("        AND     UPJANG = '" + sApUnitpriceUjang + "'                                          \n");
			sbSql.append("        AND     USE_YN = 'Y'                                                  \n");
			sbSql.append("        AND     DECODE(TO_CHAR(TO_DATE('" + nullToBlank(ds_iud.getString(0, "NEED_DATE")) + "','YYYYMMDD'),'D'),          \n");
			sbSql.append("                       1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'))     \n");
			sbSql.append(" AND A.PR_NUM = '" + sPrNum + "'                                              \n");
			sbSql.append(" AND A.LINE_STATUS = '002' AND A.DOCU_SOURCE = '" + sDocSrc + "'              \n");
			sbSql.append(" AND A.PR_ID   = B.PR_ID 				                                        \n");
	        
			stmt = conn.createStatement();
	        rs = stmt.executeQuery(sbSql.toString());

	        DataSet ds_save_out = this.makeDataSet(rs,"ds_save_out");
	        
	        if(ds_save_out.getRowCount() > 0)
	        {
	           if(ds_iud.getString(0, "MOBILE_GUBUN").equals("M"))
	           {
	               //모바일일때는 에러코드를 1로 리턴 2015.10.03 강대성요청
	               this.setResultMessage(1, "발주 불가 자재가 존재합니다.", out_vl);
	           }else{
	               this.setResultMessage(-1, "발주 불가 자재가 존재합니다.", out_vl);
	           }

	           conn.rollback();
	           out_dl.add(ds_save_out);
	           proc_output(response,out,out_vl,out_dl);
	           return;
	        }
	        rs.close();
	        stmt.close();
			
			// 구매 자재신청 유효성 체크
			// 브랜드/마트 수발주제어 예외품목 관리 추가 2022.05.20
	        sbSql.delete(0, sbSql.length());
	
	        sbSql.append(" SELECT Z.* \n");
	        sbSql.append(" FROM (SELECT T.* , NVL(DECODE(T.EXC_GUBUN,'1',DECODE(T.BRAND_YN, 'Y', T.ORDER_YN, DECODE(T.MART_YN, 'Y', T.ORDER_YN, '')),'2', DECODE(T.BRAND_YN, 'Y', T.ORDER_YN, ''), '3', DECODE(T.MART_YN, 'Y', T.ORDER_YN, ''),''),'OK') AS EXCEPTION_ORDER \n");
	        sbSql.append("    FROM ( \n");
	        sbSql.append("    SELECT A.ITEM_CODE \n");
	        sbSql.append("         , A.ITEM_NAME \n");
	        sbSql.append("         , A.CENTER_CODE \n");
	        sbSql.append("         , A.RC_UPJANG \n");
	        sbSql.append("         , A.CENTER_FLAG \n");
	        sbSql.append("         , (SELECT CASE WHEN VAL_SHP_CNT IN ('CE', 'NN') THEN '자재 업장군 맵핑 유효성 체크 오류'	\n");
	        sbSql.append("                        WHEN VAL_UNS_CNT IN ('UK', 'NN') THEN '자재 불용체크 오류'																				\n");
	        sbSql.append("                        WHEN VAL_STP_CNT IN ('TK', 'NN') THEN '자재 중지체크 오류'																				\n");
	        sbSql.append("                        WHEN VAL_EVT_CNT IN ('VE', 'NN') THEN '기획자재 한정수량체크 오류'																		\n");
	        sbSql.append("                        WHEN VAL_CTR_CNT IN ('SE', 'NN') THEN 'SPOT계약 발주횟수체크 오류'																		\n");
	        sbSql.append("                        WHEN VAL_REQ_CNT IN ('XE', 'NN') THEN '요일별 신청불가 체크 오류'																			\n");
	        sbSql.append("                        WHEN VAL_SCH_CNT IN ('HE', 'NN') THEN '수발주 스케쥴에 따른 유효성 체크 오류'																\n");
	        sbSql.append("                        WHEN A.CENTER_FLAG = 'DC' 																												\n");
	        sbSql.append("                             AND EPROCUSR.FC_GET_CENTER_IVT_YN('100', 'HFC', A.CENTER_CODE		\n");
	        sbSql.append("                                                                   , A.ITEM_CODE, A.PR_QTY) = 'N' THEN 'DC자재 수량체크 오류'										\n");
	        sbSql.append("                   ELSE 'OK' END																																	\n");
	        sbSql.append("              FROM TABLE(EPROCUSR.FN_ITEM_PROCURE_VALIDATE('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE)			\n");
	        sbSql.append("                                                           , A.ITEM_CODE, A.VD_SN, A.APPLY_SD, A.PR_QTY, A.UPJANG_GRP, '02'										\n");
	        sbSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS')													\n");
	        sbSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), TO_CHAR(SYSDATE, 'YYYYMMDD'), '" + sNeedDate + "'))		\n");
	        sbSql.append("           ) AS ITEM_VAL																																			\n");
	        
	        sbSql.append("         , NVL((SELECT 'Y' FROM FMS_UPJANG WHERE UPJANG = A.RC_UPJANG AND DEPT_ID IN ( /* 브랜드유통사업장만 */ \n");
	        sbSql.append("         																				SELECT CC_CD  	     \n");
	        sbSql.append("         																				FROM HLDC_SC_DEPT_V	 \n");
	        sbSql.append("         																				WHERE BU_CD = '2000' \n");
	        sbSql.append("         																				AND MU_CD = '2004'   \n");
	        sbSql.append("         																				AND TM_CD LIKE 'CI%' \n");
	       	sbSql.append("         		   																		)				     \n");
	        sbSql.append("         ),'') AS BRAND_YN																				 \n");														
	        sbSql.append("         , NVL((SELECT 'Y' FROM FMS_UPJANG WHERE UPJANG = A.RC_UPJANG AND DEPT_ID IN ( /* 마트사업장 */       \n");
	        sbSql.append("         																				SELECT CC_CD  	     \n");
	        sbSql.append("         																				FROM HLDC_SC_DEPT_V	 \n");
	        sbSql.append("         																				WHERE BU_CD = '2000' \n");
	        sbSql.append("         																				AND MU_CD = '2004'   \n");
	        sbSql.append("         																				AND DEPT_ID IN (SELECT CODE FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'BRAND_UPJANG_POP_ETC') \n");
	        sbSql.append("         																				)				      \n");
	        sbSql.append("         ),'') AS MART_YN																			 \n");																	
	        sbSql.append("         , NVL((SELECT EXC_GUBUN FROM EXC_ITEM_MST WHERE ITEM_CODE = A.ITEM_CODE),'') AS EXC_GUBUN \n");
	        sbSql.append("         , NVL((SELECT ORDER_YN FROM EXC_ITEM_MST WHERE ITEM_CODE = A.ITEM_CODE),'') AS ORDER_YN \n");
	        
	        sbSql.append("      FROM SO_PR A																																				\n");
	        sbSql.append("         , FMP_PR_ID_TEMP B 																																		\n");
	        sbSql.append("     WHERE A.PR_NUM  = '" + sPrNum + "'																															\n");	
	        sbSql.append("       AND A.PR_ID   = B.PR_ID 																																    \n");
	        sbSql.append("       AND A.LINE_STATUS = '002' AND A.DOCU_SOURCE = '" + sDocSrc + "') T																							\n");
	        sbSql.append("    ) Z \n");
	        sbSql.append(" WHERE (Z.ITEM_VAL <> 'OK' AND Z.EXCEPTION_ORDER <> 'Y')																											\n");
	        sbSql.append(" OR Z.EXCEPTION_ORDER = 'N'																																		\n");
	        
	        stmt = conn.createStatement();
	        rs = stmt.executeQuery(sbSql.toString());
	
	        ds_save_out = this.makeDataSet(rs,"ds_save_out");
	        
	        if(ds_save_out.getRowCount() > 0)
	        {
	           if(ds_iud.getString(0, "MOBILE_GUBUN").equals("M"))
	           {
	               //모바일일때는 에러코드를 1로 리턴 2015.10.03 강대성요청
	               this.setResultMessage(1, "구매신청 불가 자재가 존재합니다.", out_vl);
	           }else{
	               this.setResultMessage(-1, "구매신청 불가 자재가 존재합니다.", out_vl);
	           }
	
	           conn.rollback();
	           out_dl.add(ds_save_out);
	           proc_output(response,out,out_vl,out_dl);
	           return;
	        }
	        rs.close();
	        stmt.close();
		}
		sbSql.delete(0, sbSql.length());
        
      	//수정 및 신청시 저장해두었던 PR_ID 데이터 초기화
        sbSql.append("DELETE FMP_PR_ID_TEMP \n");
        sbSql.append("WHERE  PR_NUM = '" + sPrNum + "' \n");	
        
        pstmt = conn.prepareStatement(sbSql.toString());
        pstmt.executeUpdate();
        pstmt.close();
        
        //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>23:구매 자재신청 유효성 체크_END");
        
        /**************************************
        구매발주 프로시져 호출
        신규 저장할때 마다 PR_NUM을 채번한다.
        상태값 : 신규(C), 수정(U), 자재삭제(U)
        ***************************************/

        //추가건이 존재하는경우

        //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>24:SP_IF_SALES_ORDER_START");
        
        if(iAddCnt > 0)
        {
        	System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>24:SP_IF_SALES_ORDER_START");	
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
            cstmt.setString(8,sPrNum); 
            
            if(sGubunNewOrOld.equals("NEW"))
            {
            	cstmt.setString(9,"C");
            }
            else if(sGubunNewOrOld.equals("OLD"))
            {
            	cstmt.setString(9,"U");
            } 
            else
            {
            	cstmt.setString(9,"C");
            }
            
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
        }	//추가건이 존재할경우 END

        String sInPrNum = "";
        
        // 변경건이 존재할경우
        if(iUpdateCnt > 0 || iDeleteCnt > 0)
        {
        	/* 구매 발주상태 체크 로직은 일단 보류
        	// 수정, 삭제시 구매의 발주상태(LINE_STATUS) 체크
        	for( int i = 0 ; i < ds_poIf.getRowCount() ; i++ ) {
                
        		sInPrNum += "'"+ds_poIf.getString(i, "PR_NUM")+"'";

                if(i < ds_poIf.getRowCount()-1) {
                	sInPrNum += ",";
                }
            }
        	
            sbSql.delete(0, sbSql.length());
            sbSql.append("SELECT LINE_STATUS, PO_NUM, ITEM_CODE, ITEM_NAME \n"); 
            sbSql.append("  FROM HLDC_PO_PO \n");
            sbSql.append(" WHERE PO_NUM IN(" + sInPrNum + ") \n"); 
            sbSql.append("   AND LINE_STATUS IN('DL','GC','IV') \n");//배송중, 입고완료, 정산완료
            sbSql.append("   AND ROWNUM = 1 \n");
            
            pstmt = conn.prepareStatement(sbSql.toString());
            rs = pstmt.executeQuery();
            
            while(rs.next())
            {
	        	if (rs.getString("PO_NUM") != null){
	        		conn.rollback();
	                this.setResultMessage(-1, "마감된 데이터가 존재합니다.\n재조회 후 발주상태를 확인하세요!", out_vl);
	                proc_output(response,out,out_vl,out_dl);
	                rs.close();
	                pstmt.close();
	                return;  
	        	}
	        	break;
            }
            rs.close();
            pstmt.close();
            */
            
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
// [속도개선 Project 시작] 2017. 8. 4. 최범주

                if(!cstmt.getString(10).equals("S000"))
                {
                    conn.rollback();
                    this.setResultMessage(-1, cstmt.getString(11), out_vl);
                    proc_output(response,out,out_vl,out_dl);
                    return;
                }
                cstmt.close();
            }

        }	// 변경건이 존재할경우 END

        //System.out.println("FMP00160E_T001_LOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>25:SP_IF_SALES_ORDER_END");

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
	        sbSql.append("\n      , AA.PR_NUM                                                                               ");
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
	        sbSql.append("\n 	     WHERE A.SUBINV_CODE = :subinvCode                                                        ");
	        sbSql.append("\n 	       AND (A.NEED_DATE   = :needDate                                                          ");
	        sbSql.append("\n 	       OR A.NEED_DATE   = :needDate2 )                                                          ");
			//sbSql.append("\n 	      AND A.PR_NUM   = :sPrNum                                                          	  ");
	        // 상품발주, 식재장바구니일 경우
	        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00082E|ShoppingFicsBasket") ) {
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
	        //창고코드 주문내역에서 가져오기 2017.10.11 김호석(창고코드 변경되어 넘어오는 경우 문제 발생)
	        //npstmt.setString("subinvCode", sSubinv);
	        npstmt.setString("subinvCode", cSubinv);
	        //입고예정일 주문내역에서 가져오기 2017.10.11 김호석(입고예정일 변경되어 넘어오는 경우 문제 발생)
	        //npstmt.setString("needDate", sNeedDate);
	        npstmt.setString("needDate", cNeedDate);
	        npstmt.setString("needDate2", sNeedDate);
			//npstmt.setString("sPrNum", sPrNum);
	        // 상품발주, 식재장바구니일 경우
	        if ( ValidationUtil.isEqualsOr(scrnId, "FMP00082E|ShoppingFicsBasket") ) {
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
				after_rowData.put("befGdsGnvAmtTot", null);
				after_rowData.put("aftrGdsGnvAmtTot", aftrGdsGnvAmtTot);
		    	
		    	afterlistMap.add(after_rowData);
				
	        }
	        npstmt.close();
	        rs.close();
	        sbSql.setLength(0);
        }
		
		//마지막건을 삭제하는 경우 
		/*
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
				//cstmt.setString(1, rcUpjang);                   // (필수)업장코드
				cstmt.setString(1, sPrUpjang);                   // (필수)업장코드
				cstmt.setString(2, sNeedDate);                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
				cstmt.setString(3, "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
				cstmt.setDouble(4, aftrGdsGnvAmtTot);             // (필수)발생금액
				cstmt.setDouble(5, befGdsGnvAmtTot);              // (필수)발생금액(전)
				cstmt.setString(6, "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
				cstmt.setString(7, "(01)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
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
        }
		*/
		
		//PR_NUM이 수정 후 적어진 경우(취소로 인한) 발생전 맵의 수만큼 LOOP
		//발생후MAP 기준으로 LOOP
		if (afterlistMap.size() >= beforelistMap.size()) { 
			
	        for (int i = 0 ; i < afterlistMap.size() ; i++) {
	        	
	        	Map<String, Object> aMap = afterlistMap.get(i);
	        	
	        	prNum = aMap.get("prNum").toString();
	        	aftrGdsGnvAmtTot = 0;
	        	aftrGdsGnvAmtTot = Math.round((Double)aMap.get("aftrGdsGnvAmtTot"));
	        	
	        	//발생전 금액 초기화 
	        	befGdsGnvAmtTot = 0;
	        	for (int j = 0 ; j < beforelistMap.size() ; j++) {
	        		Map<String, Object> bMap = beforelistMap.get(j);
					if ( prNum.equals(bMap.get("prNum").toString())) {
						//befGdsGnvAmtTot = bMap.get("befGdsGnvAmtTot");					
						befGdsGnvAmtTot = Math.round((Double)bMap.get("befGdsGnvAmtTot"));
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
					//cstmt.setString(1, rcUpjang);                   // (필수)업장코드
					cstmt.setString(1, sPrUpjang);                   // (필수)업장코드
					cstmt.setString(2, sNeedDate);                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					cstmt.setString(3, "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					cstmt.setDouble(4, aftrGdsGnvAmtTot);             // (필수)발생금액
					cstmt.setDouble(5, befGdsGnvAmtTot);              // (필수)발생금액(전)
					cstmt.setString(6, "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					cstmt.setString(7, "(01)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
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
	        }
	        
	    //발생전MAP 기준으로 LOOP
		} else {
			
			for (int i = 0 ; i < beforelistMap.size() ; i++) {
	        	
	        	Map<String, Object> bMap = beforelistMap.get(i);
	        	
	        	prNum = bMap.get("prNum").toString();		
	        	befGdsGnvAmtTot = 0;
				befGdsGnvAmtTot = Math.round((Double) bMap.get("befGdsGnvAmtTot"));
	        	
	        	//발생후 금액 초기화 
	        	aftrGdsGnvAmtTot = 0;
	        	for (int j = 0 ; j < afterlistMap.size() ; j++) {
	        		Map<String, Object> aMap = afterlistMap.get(j);
					if ( prNum.equals(aMap.get("prNum").toString())) {
	        			aftrGdsGnvAmtTot = Math.round((Double) aMap.get("aftrGdsGnvAmtTot"));
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
					//cstmt.setString(1, rcUpjang);                   // (필수)업장코드
					cstmt.setString(1, sPrUpjang);                   // (필수)업장코드
					cstmt.setString(2, sNeedDate);                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					cstmt.setString(3, "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					cstmt.setDouble(4, aftrGdsGnvAmtTot);             // (필수)발생금액
					cstmt.setDouble(5, befGdsGnvAmtTot);              // (필수)발생금액(전)
					cstmt.setString(6, "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					cstmt.setString(7, "(01)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
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
	        }
			
			
		}
       
// [속도개선 Project 시작] 2017. 8. 4. 최범주
        

/** 안쓸기능으로 간주, 추후 동시 발주로 인해 서버에서 통제필요시 하단 내용 보완 필요
			if ( "FMP00082E".equals(scrnId) || "FMP00160E".equals(scrnId) ) {

				sbSql.setLength(0);
				sbSql.setLength(0);
				sbSql.append("\n	SELECT 																																			");
				sbSql.append("\n			Z.*, NVL(ROUND(SUM(SUBINV_AMT) OVER()), 0) AS TOT																						");
				sbSql.append("\n	   		, NVL(ROUND(SUM(SUBINV_AMT) OVER()), 0) - NVL(CONTROL_AMT, 0) AS DIFF_AMT																");
				sbSql.append("\n		FROM (																																		");
				sbSql.append("\n				SELECT RC_UPJANG																															");
				sbSql.append("\n				        , SUBINV_CODE                                                                                                                       ");
				sbSql.append("\n				        , NVL(ROUND(SUM(PO_AMT)), 0) AS SUBINV_AMT                                                                                          ");
				sbSql.append("\n				        , NVL(ROUND(DECODE(CONTROL_YN, 'Y'                                                                                                  ");
				sbSql.append("\n				                        , (SUM(PO_AMT) + SUM(NON_CRTL_AMT))                                                                                 ");
				sbSql.append("\n				                        , SUM(PO_AMT)                                                                                                       ");
				sbSql.append("\n				                        )), 0) AS PO_AMT                                                                                                    ");
				sbSql.append("\n				        , NVL(CONTROL_AMT, 0) AS CONTROL_AMT                                                                                                ");
				sbSql.append("\n				        , CONTROL_YN                                                                                                                        ");
				sbSql.append("\n				        , NVL(ROUND(                                                                                                                        ");
				sbSql.append("\n				                DECODE(CONTROL_YN, 'Y'                                                                                                      ");
				sbSql.append("\n				                        , 0                                                                                                                 ");
				sbSql.append("\n				                        , SUM(NON_CRTL_AMT)                                                                                                 ");
				sbSql.append("\n				                        )), 0) AS NON_CTRL_AMT                                                                                              ");
				sbSql.append("\n				        , CASE WHEN CONTROL_YN = 'Y' AND NVL(SUM(PO_AMT), 0) = 0 THEN 'Y'                            										");
				sbSql.append("\n				         	   WHEN CONTROL_YN = 'N' THEN 'Y'                            																	");
				sbSql.append("\n				          	   ELSE 'N' END AS CHK_SAVE                                                                                                     ");
				sbSql.append("\n				                                                                                                                                            ");
				sbSql.append("\n				        FROM (                                                                                                                              ");
				sbSql.append("\n				                SELECT A.UPJANG AS RC_UPJANG                                                                                                ");
				sbSql.append("\n				                       , A.SUBINV_CODE                                                                                                      ");
				sbSql.append("\n				                       , (DECODE(C.TAX_CODE,'100',1.1,1)                                                                                    ");
				sbSql.append("\n				                            * (C.CENTER_DELI_QTY + C.DIRECT_DELI_QTY - C.DELIVERED_QTY - C.UNDELIVERED_QTY)                                 ");
				sbSql.append("\n				                            * C.SAL_OPER_PRICE) AS PO_AMT                                                                                   ");
				sbSql.append("\n				                       , NVL(A.CONTROL_AMT, 0) AS CONTROL_AMT                                                                               ");
				sbSql.append("\n				                       --, A.CONTROL_YN                                                                                                     ");
				sbSql.append("\n				                       , CASE WHEN A.CONTROL_SD <= :needDate AND A.CONTROL_ED >= :needDate THEN 'Y'                                         ");
				sbSql.append("\n				                         ELSE 'N' END AS CONTROL_YN                                                                                         ");
				sbSql.append("\n				                       , NVL(D.NON_CRTL_AMT, 0) AS NON_CRTL_AMT                                                                             ");
				sbSql.append("\n				                       , FMS_PREORDER_FUN(C.CENTER_CODE,C.ITEM_CODE,'D_DAYS') AS D_DAYS                                                     ");
				sbSql.append("\n				                       FROM FMS_SUBINVENTORY A                                                                                              ");
				sbSql.append("\n				                            , FMS_UPJANG B                                                                                                  ");
				sbSql.append("\n				                            ,  HLDC_PO_PO C                                                                                                 ");
				sbSql.append("\n				                            , ( SELECT X.UPJANG                                                                                             ");
				sbSql.append("\n				                                                                                                                                            ");
				sbSql.append("\n				                                        , NVL(SUM(DECODE(Y.TAX_CODE,'100',1.1,1)                                                            ");
				sbSql.append("\n				                                                * (Y.CENTER_DELI_QTY + Y.DIRECT_DELI_QTY - Y.DELIVERED_QTY - Y.UNDELIVERED_QTY)             ");
				sbSql.append("\n				                                                * Y.SAL_OPER_PRICE), 0) AS NON_CRTL_AMT                                                     ");
				sbSql.append("\n				                                                                                                                                            ");
				sbSql.append("\n				                                        FROM FMS_SUBINVENTORY X, HLDC_PO_PO Y                                                               ");
				sbSql.append("\n				                                        WHERE X.SUBINV_CODE = Y.SUBINV_CODE(+)                                                              ");
				sbSql.append("\n				                                        AND X.UPJANG = Y.RC_UPJANG(+)                                                                       ");
				sbSql.append("\n				                                        AND X.UPJANG = :upjang                                                                              ");
				sbSql.append("\n				                                        AND NVL(X.CONTROL_YN, 'N') = 'N'                                                                    ");
				sbSql.append("\n				                                        AND Y.LINE_STATUS(+)  = 'PC'                                                                        ");
				sbSql.append("\n				                                        AND Y.NEED_DATE(+) = :needDate                                                                      ");
				sbSql.append("\n				                                        AND FMS_PREORDER_FUN(Y.CENTER_CODE,Y.ITEM_CODE,'D_DAYS') <= 1                                       ");
				sbSql.append("\n				                                        GROUP BY X.UPJANG                                                                                   ");
				sbSql.append("\n				                        ) D                                                                                                                 ");
				sbSql.append("\n				                WHERE A.UPJANG = C.RC_UPJANG(+)                                                                                             ");
				sbSql.append("\n				                AND A.UPJANG = B.UPJANG                                                                                                     ");
				sbSql.append("\n				       			AND	A.UPJANG = :upjang                                                                                                      ");
				sbSql.append("\n				                AND A.SUBINV_CODE = C.SUBINV_CODE(+)                                                                                        ");
				sbSql.append("\n				                AND A.UPJANG = D.UPJANG(+)                                                                                                  ");
				sbSql.append("\n				                AND C.NEED_DATE(+) = :needDate                                                                                              ");
				sbSql.append("\n				                AND C.LINE_STATUS(+)  = 'PC'                                                                                                ");
				sbSql.append("\n				            )                                                                                                                               ");
				sbSql.append("\n				            GROUP BY RC_UPJANG, SUBINV_CODE, CONTROL_AMT, CONTROL_YN                                                                        ");
				sbSql.append("\n	            ) Z																																");	
		        
		        
		        npstmt = new NamedParameterStatement(conn, sbSql.toString());
		        npstmt.setString("upjang", sPrUpjang);
		        npstmt.setString("needDate", sNeedDate);
	
		        rs = npstmt.executeQuery();
		        
		        while ( rs.next() ) {
		        	if ( "Y".equals(rs.getString("CONTROL_YN")) && "Y".equals(rs.getString("CHK_SAVE")) && (rs.getInt("DIFF_AMT") < 0) && g_EmpNo.toString().indexOf("CS") == 0 ) {
		        		
		        		System.out.println("#1#"+rs.getInt("CONTROL_AMT")+"#2#"+rs.getInt("PO_AMT")+"#3#"+rs.getInt("NON_CTRL_AMT")+"#4#"+rs.getInt("DIFF_AMT"));
		        		
		        		conn.rollback();
		        		this.setResultMessage(-1
		        				, "최소발주금액["+NumberFormat.getNumberInstance(Locale.US).format(rs.getInt("CONTROL_AMT"))+"]원보다 ["
		        					+ NumberFormat.getNumberInstance(Locale.US).format(Math.abs(rs.getInt("DIFF_AMT")))+"]원 부족합니다.\r\n\r\n발주금액을 확인하시기 바랍니다."
		        				, out_vl);
						proc_output(response,out,out_vl,out_dl);
						return;
		        	}
		        }
		        
		        npstmt.close();
		        rs.close();
		        sbSql.setLength(0);
			}
*/


        /**종료**/
        conn.commit();
        if ( "FMP00082E".equals(nullToBlank(in_vl.getString("scrnId"))) ) {
			ds_msg_out.setName("ds_msg_out");
			out_dl.add(ds_msg_out); 
        }	        
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
        if(stmt != null) {
            try {
            	stmt.close();
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
        DataSet ds_iud      = in_dl.get("ds_IUD");
        //입력 파라메터
        String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
        String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
        String sDocSrc      = nullToBlank(in_vl.getString("sDocSrc"));

        String sPR_Qty      = "";
        int sRowStatus;
        String sOtcustCD    = "";
        String sMenuFlag    = "";

        int iInsCnt         = 0;

        //FileLog.println("d:\\aaa.txt", ds_list);


        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        //구매신청번호 및 승인번호 가져오기
        sbSql.delete(0, sbSql.length());

        sbSql.append("SELECT NVL((SELECT PR_NUM \n");
        sbSql.append("              FROM (SELECT PR_NUM FROM SO_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1 \n");
        sbSql.append("                     UNION ALL \n");
        sbSql.append("                    SELECT PR_NUM FROM FMP_OTCUST_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
        sbSql.append("             WHERE ROWNUM <= 1) \n");
//		sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(HLDC_PO_PR_NUM_S.NEXTVAL,4,'0')) AS PRNUM \n");
        sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0')) AS PRNUM \n");
        sbSql.append("     , NVL((SELECT APPROVE_NUM FROM SO_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
        sbSql.append("          , '자동'||TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_APV_NUM_S.NEXTVAL,4,'0')) AS PRAPPRNUM \n");
        sbSql.append("  FROM DUAL \n");

out_vl.add("fa_Sql", sbSql.toString());
        //System.out.println(sbSql.toString());
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

//		if(! rs.next())
//		{
//			out_vl.add("v_ErrMsg", "신청번호 생성오류...\n관리자에게 연락하세요.");
//      this.setResultMessage(0, "OK", out_vl);
//      proc_output(response,out,out_vl,out_dl);
//		   	return;
//		}
        rs.next();

        String sPrNum = rs.getString("PRNUM");
        String sPrApprNum = rs.getString("PRAPPRNUM");

        rs.close();
        pstmt.close();

        //입력,수정
        for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
        {
            sbSql.delete(0, sbSql.length());

            sRowStatus = ds_iud.getRowType(i);
            sOtcustCD  = nullToBlank(ds_iud.getString(i, "OTCUSTCD"));
            sPR_Qty    = nullToBlank(ds_iud.getString(i, "PR_QTY"));

            //========수량이 없으면 제외==========
//			if ( (Double.parseDouble(ds_iud.getString(i, "PR_QTY")) == 0)
//				||(sPR_Qty.equals("0"))||(sPR_Qty.equals("0.0"))||(sPR_Qty.equals("")) )
//			{
//				continue;
//			}

            if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
            {
                continue;
            }
            else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
            {
                //PR_ID생성
                sbSql.append("SELECT SO_PR_S.NEXTVAL AS PR_ID FROM DUAL \n");
out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                rs = pstmt.executeQuery();
                rs.next();
                ds_iud.set(i, "PR_ID", rs.getString("PR_ID"));
                rs.close();
                pstmt.close();

                sbSql.delete(0, sbSql.length());

                if (sOtcustCD.equals("0000"))
                {
                    sbSql.append("INSERT INTO SO_PR( \n");
                    sbSql.append("      PR_ID \n");
                    sbSql.append("    , PR_NUM \n");
                    sbSql.append("    , PR_DATE \n");
                    sbSql.append("    , PR_DEPT_ID \n");
                    sbSql.append("    , PR_UPJANG \n");
                    sbSql.append("    , PR_SABUN \n");
                    sbSql.append("    , APPROVER \n");
                    sbSql.append("    , APPROVE_TIME \n");
                    sbSql.append("    , APPROVE_NUM \n");
                    sbSql.append("    , PO_TYPE \n");
                    sbSql.append("    , DOCU_SOURCE \n");
                    sbSql.append("    , CUSTCD \n");
                    sbSql.append("    , SUBINV_CODE \n");
                    sbSql.append("    , RC_MU_CD \n");
                    sbSql.append("    , RC_DEPT_ID \n");
                    sbSql.append("    , RC_UPJANG \n");
                    sbSql.append("    , BUDDEPT_ID \n");
                    sbSql.append("    , CENTER_CODE \n");
                    sbSql.append("    , ITEM_CODE \n");
                    sbSql.append("    , ITEM_NAME \n");
                    sbSql.append("    , ITEM_SIZE \n");
                    sbSql.append("    , PO_UOM \n");
                    sbSql.append("    , TAX_CODE \n");
                    sbSql.append("    , ACCTCD \n");
                    sbSql.append("    , BUD_CLS \n");
                    sbSql.append("    , CENTER_FLAG \n");
                    sbSql.append("    , UNIT_PRICE \n");
                    sbSql.append("    , MARGIN_PRICE \n");
                    sbSql.append("    , SALE_PRICE \n");
                    sbSql.append("    , PR_QTY \n");
                    sbSql.append("    , PO_QTY \n");
                    sbSql.append("    , NEED_DATE \n");
                    sbSql.append("    , INVAT_FLAG \n");
                    sbSql.append("    , OUTVAT_FLAG \n");
                    sbSql.append("    , PR_REMARK \n");
                    sbSql.append("    , LINE_STATUS \n");
                    sbSql.append("    , CREATE_BY \n");
                    sbSql.append("    , CREATE_DATE \n");
                    sbSql.append("    , UPDATE_BY \n");
                    sbSql.append("    , UPDATE_DATE \n");
                    sbSql.append(" ) VALUES ( \n");
//					sbSql.append("	HLDC_PO_PR_S.NEXTVAL \n");
                    sbSql.append("	" + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("	, '" + sPrNum + "' \n");
                    sbSql.append("	, TO_CHAR(SYSDATE,'YYYYMMDD') \n");
                    sbSql.append("	, (SELECT DEPT_ID FROM HLDC_ST_UPJANG WHERE UPJANG = " + g_Upjang + ") \n");
                    sbSql.append("	, " + g_Upjang + " \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
                    sbSql.append("	, '" + sPrApprNum + "' \n");
                    sbSql.append("	, '07' \n");
//					sbSql.append("	, '07 FM' \n");
                    sbSql.append("	, '" + sDocSrc + "' \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "CUSTCD")) + " \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "' \n");
                    sbSql.append("	, (SELECT B.MU_CD FROM HLDC_ST_UPJANG A, HLDC_SC_DEPT B WHERE A.DEPT_ID = B.DEPT_ID AND A.UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + ") \n");
                    sbSql.append("	, (SELECT DEPT_ID FROM HLDC_ST_UPJANG WHERE UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + ") \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                    //BUDDEPT_ID 이 컬럼이 뭐로 바꿨는지?
                    //sbSql.append("	, (SELECT BUDDEPT_ID FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    //sbSql.append("	, (SELECT BUDCC_CD FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    sbSql.append("	, '확인요' \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "CENTER_CODE")) + " \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_NAME")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_SIZE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PO_UOM")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "TAX_CODE")) + "' \n");
                    sbSql.append("	, (SELECT MATERIAL_ACCTCD FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    //MATERIAL_BUD_CLS 이 컬럼이 뭐로 바꿨는지?
                    //sbSql.append("	, (SELECT NVL(MATERIAL_BUD_CLS,' ') FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                    sbSql.append("	, '확인요' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "CENTER_FLAG")) + "' \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + " \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + " \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + " \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("	, '" + sNeedDate + "' \n"); /*날짜변경 후 저장하는 케이스가 있음. 그리드에서 가져오면 안됨*/
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "INVAT_FLAG")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "OUTVAT_FLAG")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LINE_STATUS")) + "' \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append(" ) \n");
                }
                else
                {
                    sbSql.append("INSERT INTO FMP_OTCUST_PR( \n");
                    sbSql.append("	  PR_ID \n");
                    sbSql.append("	, PR_NUM \n");
                    sbSql.append("  , DOCU_SOURCE \n");
                    sbSql.append("	, PR_DATE \n");
                    sbSql.append("	, PR_SABUN \n");
                    sbSql.append("	, NEED_DATE \n");
                    sbSql.append("	, UPJANG \n");
                    sbSql.append("	, SUBINV_CODE \n");
                    sbSql.append("	, ITEM_CODE \n");
                    sbSql.append("	, ITEM_NAME \n");
                    sbSql.append("	, ITEM_SIZE \n");
                    sbSql.append("	, PO_UOM \n");
                    sbSql.append("	, TAX_CODE \n");
                    sbSql.append("	, PO_QTY \n");
                    sbSql.append("	, PR_QTY \n");
                    sbSql.append("	, UNIT_PRICE \n");
                    sbSql.append("	, UNIT_AMOUNT \n");
                    sbSql.append("	, SALE_PRICE \n");
                    sbSql.append("	, SALE_AMOUNT \n");
                    sbSql.append("	, OP_PRICE \n");
                    sbSql.append("	, OP_AMOUNT \n");
                    sbSql.append("	, OTCUSTCD \n");
                    sbSql.append("	, CONTENTS \n");
                    sbSql.append("	, LINE_STATUS \n");
                    sbSql.append("	, CUSER \n");
                    sbSql.append("	, CDATE \n");
                    sbSql.append("	, UUSER \n");
                    sbSql.append("	, UDATE \n");
                    sbSql.append(" ) VALUES ( \n");
//					sbSql.append("	HLDC_PO_PR_S.NEXTVAL \n");
                    sbSql.append("	" + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("	, '" + sPrNum + "' \n");
                    sbSql.append("	, '" + sDocSrc + "' \n");
                    sbSql.append("	, TO_CHAR(SYSDATE,'YYYYMMDD') \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, '" + sNeedDate + "' \n"); /*날짜변경 후 저장하는 케이스가 있음. 그리드에서 가져오면 안됨*/
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_NAME")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "ITEM_SIZE")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PO_UOM")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "TAX_CODE")) + "' \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + " \n");
                    sbSql.append("	, ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + ") \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + " \n");
                    sbSql.append("	, ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + ") \n");
                    sbSql.append("	, " + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + " \n");
                    sbSql.append("	, ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + ") \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "OTCUSTCD")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")) + "' \n");
                    sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LINE_STATUS")) + "' \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append("	, '" + g_EmpNo + "' \n");
                    sbSql.append("	, SYSDATE \n");
                    sbSql.append(" ) \n");
                }
            }
            else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
            {
                if (sOtcustCD.equals("0000"))
                {
                    sbSql.append("UPDATE SO_PR \n");
                    sbSql.append("   SET PR_QTY = " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("     , PO_QTY = " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("     , PR_REMARK = '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")) + "' \n");
                    sbSql.append("     , LINE_STATUS = DECODE(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + ",0,'003',LINE_STATUS) \n");
                    sbSql.append("     , APPROVER = '" + g_EmpNo + "' \n");
                    sbSql.append("     , APPROVE_TIME = TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
                    sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
                    sbSql.append("     , UPDATE_DATE = SYSDATE \n");
                    sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("   AND LINE_STATUS <= '004' \n");
                }
                else
                {
                    sbSql.append("UPDATE FMP_OTCUST_PR \n");
                    sbSql.append("   SET       PO_QTY = " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("     , PR_QTY = " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                    sbSql.append("     , UNIT_AMOUNT = ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "UNIT_PRICE")) + ") \n");
                    sbSql.append("     , SALE_AMOUNT = ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + ") \n");
                    sbSql.append("     , OP_AMOUNT = ROUND(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " * " + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + ") \n");
                    sbSql.append("     , CONTENTS = '" + nullToBlank(ds_iud.getString(i, "PR_REMARK")) + "' \n");
                    sbSql.append("     , LINE_STATUS = DECODE(" + nullToBlank(ds_iud.getString(i, "PR_QTY")) + ",0,'003',LINE_STATUS) \n");
                    sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                    sbSql.append("     , UDATE = SYSDATE \n");
                    sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("   AND LINE_STATUS <= '004' \n");
                }
            }
out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            iInsCnt = pstmt.executeUpdate();
            pstmt.close();
            if (iInsCnt <= 0){continue;}

            //식단발주인 경우 식단자료 업데이트
            if (sDocSrc.equals("07 FM(식단)"))
            {
                sMenuFlag = nullToBlank(ds_iud.getString(i, "MENU_FLAG"));

                if (! sMenuFlag.equals("Y"))
                {
                    continue;
                }

                sbSql.delete(0, sbSql.length());

                sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
                sbSql.append("   SET PR_YN = 'Y' \n");
                if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
                    sbSql.append("     , PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                sbSql.append("     , PR_NUM = '" + sPrNum + "' \n");
                sbSql.append("     , PR_QTY = " + nullToBlank(ds_iud.getString(i, "PR_QTY")) + " \n");
                sbSql.append("     , UNIT_PRICE = " + nullToBlank(ds_iud.getString(i, "SALE_PRICE")) + " \n");
                sbSql.append("     , OP_PRICE = " + nullToBlank(ds_iud.getString(i, "OP_PRICE")) + " \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                //sbSql.append("   AND MENU_CD LIKE '" + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + "-" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "%' \n");
                sbSql.append("   AND NEED_DATE LIKE '" + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + "' \n");
                sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
                sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
                sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
                sbSql.append("                  AND B.UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
                sbSql.append("                  AND B.SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
                if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
                {
                    sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
                    sbSql.append("   AND PR_YN = 'N' \n");
                }
                else
                {
                    sbSql.append("   AND PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
                    sbSql.append("   AND PR_YN = 'Y' \n");
                }

out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
            }
        }

        //삭제(수량을 0으로 수정해서 화면 내부에서 강제로 삭제한 것) - 기존신청자료가 아닌 신규식단자료는 Insert후 Delete이므로 Delete버퍼에 쌓이지 않는다.
        String sPrID;
        for ( int i = 0 ; i < ds_iud.getRemovedRowCount() ; i++ )
        {
            sPrID  = ds_iud.getRemovedData(i, "PR_ID").toString();
            //PR_ID가 -1인 것은 사용자의 삭제처리로 이미 처리가 끝난것
            if (sPrID.equals("-1")) continue;

            //기존 구매신청자료 삭제처리
            //과거와는 달리 주문삭제 시 "취소"로 남기지 않고 그냥 삭제처리한다.
            //"취소"로 남겨야 할 경우 LINE_STATUS = '003'으로 업데이트 처리하고, 주문화면에서 주문내용 조회 시 취소내용도 감안하여 조회하여야 한다.
            //또한, 마감전 여부로 수정여부를 지정하는 것 역시 다 바뀌어야 한다.
            sbSql.delete(0, sbSql.length());
            sOtcustCD  = ds_iud.getRemovedData(i, "OTCUSTCD").toString();
            if (sOtcustCD.equals("0000"))
            {
                //sbSql.append("DELETE FROM HLDC_PO_PR \n");
                //sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                //sbSql.append("   AND LINE_STATUS <= '004' \n");
                sbSql.append("UPDATE SO_PR \n");
                sbSql.append("   SET LINE_STATUS = '003' \n");
                sbSql.append("     , PR_QTY = " + ds_iud.getRemovedData(i, "PR_QTY").toString() + " \n");
                sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
                sbSql.append("     , UPDATE_DATE = SYSDATE \n");
                sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                sbSql.append("   AND LINE_STATUS <= '004' \n");
            }
            else
            {
                //sbSql.append("DELETE FROM FMP_OTCUST_PR \n");
                //sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                //sbSql.append("   AND LINE_STATUS <= '004' \n");
                sbSql.append("UPDATE FMP_OTCUST_PR \n");
                sbSql.append("   SET LINE_STATUS = '003' \n");
                sbSql.append("     , PR_QTY = " + ds_iud.getRemovedData(i, "PR_QTY").toString() + " \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                sbSql.append("   AND LINE_STATUS <= '004' \n");
            }
out_vl.add("fa_Sql", sbSql.toString());
            //System.out.println(sbSql.toString());
            pstmt = conn.prepareStatement(sbSql.toString());
            iInsCnt = pstmt.executeUpdate();
            pstmt.close();
            if (iInsCnt <= 0){continue;}

            //식단발주인 경우 식단자료 업데이트
            if (sDocSrc.equals("07 FM(식단)"))
            {
                sMenuFlag = ds_iud.getRemovedData(i, "MENU_FLAG").toString();

                if (! sMenuFlag.equals("Y"))
                {
                    continue;
                }

                sbSql.delete(0, sbSql.length());
                //취소자료는 일단 주문상태이며, 주문수량만 0이다.
                sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
                sbSql.append("   SET PR_QTY = 0 \n");
                //sbSql.append("     , PR_YN = 'N' \n");
                sbSql.append("     , PR_ID = -999 \n");
                //sbSql.append("     , PR_NUM = NULL \n");
                //sbSql.append("     , UNIT_PRICE = 0 \n");
                //sbSql.append("     , OP_PRICE = 0 \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE UPJANG = " + ds_iud.getRemovedData(i, "RC_UPJANG").toString() + " \n");
                //sbSql.append("   AND MENU_CD LIKE '" + ds_iud.getRemovedData(i, "NEED_DATE").toString() + "-" + ds_iud.getRemovedData(i, "SUBINV_CODE").toString() + "%' \n");
                sbSql.append("   AND NEED_DATE LIKE '" + ds_iud.getRemovedData(i, "NEED_DATE").toString() + "' \n");
                sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
                sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
                sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
                sbSql.append("                  AND B.UPJANG = " + ds_iud.getRemovedData(i, "RC_UPJANG").toString() + " \n");
                sbSql.append("                  AND B.SUBINV_CODE = '" + ds_iud.getRemovedData(i, "SUBINV_CODE").toString() + "') \n");
                sbSql.append("   AND PR_ID = " + ds_iud.getRemovedData(i, "PR_ID").toString() + " \n");
                sbSql.append("   AND PR_YN = 'Y' \n");

out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
            }
        }


//============================================================================================
//(2009-01-14 추가) 시작
// 박은규 2009-03-13 CSR#(25270) 요청자:김진희(식재사업팀)
// 주문수량이 0인 것은 식단정보에 발주로 처리
//============================================================================================
        //식단발주인 경우
        //수량을 0로 저장 시 내부적으로 삭제처리 하는데
        //기존신청자료가 아닌 신규식단자료는 Insert후 Delete이므로 Delete버퍼에 쌓이지 않는다.
        //그래서 별도의 데이타세트를 받아 처리한다.
        if (sDocSrc.equals("07 FM(식단)"))
        {
            //입력 데이타
            DataSet ds_TmpDel = in_dl.get("ds_TmpDel");
            //입력,수정
            for ( int i = 0 ; i < ds_TmpDel.getRowCount() ; i++ )
            {
                sbSql.delete(0, sbSql.length());

                //취소자료는 일단 주문상태이며, 주문수량만 0이다.
                sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
                sbSql.append("   SET PR_QTY = 0 \n");
                sbSql.append("     , PR_YN = 'Y' \n");
                sbSql.append("     , PR_ID = -999 \n");
                sbSql.append("     , UNIT_PRICE = " + nullToZero(ds_TmpDel.getString(i, "SALE_PRICE")).toString() + " \n");
                sbSql.append("     , OP_PRICE = " + nullToZero(ds_TmpDel.getString(i, "OP_PRICE")).toString() + " \n");
                sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
                sbSql.append("     , UDATE = SYSDATE \n");
                sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_TmpDel.getString(i, "RC_UPJANG")) + " \n");
                //sbSql.append("   AND MENU_CD LIKE '" + nullToBlank(ds_TmpDel.getString(i, "NEED_DATE")) + "-" + nullToBlank(ds_TmpDel.getString(i, "SUBINV_CODE")) + "%' \n");
                sbSql.append("   AND NEED_DATE LIKE '" + nullToBlank(ds_TmpDel.getString(i, "NEED_DATE")) + "' \n");
                sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
                sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
                sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
                sbSql.append("                  AND B.UPJANG = " + nullToBlank(ds_TmpDel.getString(i, "RC_UPJANG")) + " \n");
                sbSql.append("                  AND B.SUBINV_CODE = '" + nullToBlank(ds_TmpDel.getString(i, "SUBINV_CODE")) + "') \n");
                sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_TmpDel.getString(i, "ITEM_CODE")) + "' \n");
                sbSql.append("   AND PR_YN = 'N' \n");

out_vl.add("fa_Sql", sbSql.toString());
                //System.out.println(sbSql.toString());
                pstmt = conn.prepareStatement(sbSql.toString());
                pstmt.executeUpdate();
                pstmt.close();
            }
        }
//============================================================================================
//(2009-01-14 추가) 끝
//============================================================================================


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