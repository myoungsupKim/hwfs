<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00090E_T001.jsp
■ 프로그램명   : 입고예정일 수정
■ 작성일자     : 2015.02.10
■ 작성자       : 김경은
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.util.Map" %> 
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt            = null;
	CallableStatement cstmt   = null;

	try	{
		
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sPrUpjang      = nullToBlank(in_vl.getString("sPrUpjang"));
		String sPrSabun      = nullToBlank(in_vl.getString("sPrSabun"));
		String sOrgPrNum      = nullToBlank(in_vl.getString("sOrgPrNum"));		
		//여신집계 프로시서 호출 시작 2017.09.04 김호석
		String OldsNeedDate = nullToBlank(in_vl.getString("OldsNeedDate"));     // 입고일 변경전 날짜
        String scrnId       = nullToBlank(in_vl.getString("scrnId"));     // 화면ID
		String scrnName     = nullToBlank(in_vl.getString("scrnName"));   // 화면명
		long p_occur_amt        = 0;
		long p_occur_amt_before = 0;
		double saleAmount 		= 0;
		//여신집계 프로시서 호출 끝 2017.09.04 김호석
		
		int sRowStatus;
		String sOtcustCD    = "";
		int iInsCnt         = 0;
		String sDocSrc      = "";
		
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		StringBuffer sbSql2 = new StringBuffer();
		
		// 1. 신규 구매신청번호 및 승인번호 가져오기
		sbSql.delete(0, sbSql.length());

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

		String sPrNum = rs.getString("PRNUM");
		String sOtcustPrNum = rs.getString("OTCUST_PRNUM");
		String sPrApprNum = rs.getString("PRAPPRNUM");
		
		rs.close();
		pstmt.close();			
	
		// 3. SO_PR 데이터 수정
		for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sRowStatus = ds_iud.getRowType(i);
			sOtcustCD  = nullToBlank(ds_iud.getString(i, "OTCUSTCD"));
			sDocSrc    = nullToBlank(ds_iud.getString(i, "DOCU_SOURCE"));
			
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				if (sOtcustCD.equals("0000"))
				{
					sbSql.append("UPDATE SO_PR \n");
					sbSql.append("   SET PR_NUM = '" + sPrNum + "' \n");
					sbSql.append("     , APPROVER = '" + g_EmpNo + "' \n");
					sbSql.append("     , APPROVE_TIME = TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
					sbSql.append("     , APPROVE_NUM = '" + sPrApprNum + "' \n");
					sbSql.append("     , NEED_DATE = " + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + " \n");
					sbSql.append("     , UPDATE_BY = '" + g_EmpNo + "' \n");
					sbSql.append("     , UPDATE_DATE = SYSDATE \n");
					sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
					sbSql.append("   AND LINE_STATUS = '002' \n");
				}
				else
				{
					sbSql.append("UPDATE FMP_OTCUST_PR \n");
					sbSql.append("   SET NEED_DATE = " + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + " \n");
					sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
					sbSql.append("     , UDATE = SYSDATE \n");
					sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
					sbSql.append("   AND LINE_STATUS = '002' \n");
				}
				
				//여신집계 프로시서 호출 시작 2017.09.04 김호석
			 	String p_upjang_cd      = ds_iud.getString(i, "RC_UPJANG").toString();
				String p_apply_date     = sNeedDate + "|" + OldsNeedDate;  // 변경후입고일자 + 변경전입고일자 
				String prId         = ds_iud.getString(i, "PR_ID").toString();

				// 발생금액 셋팅
				saleAmount = Double.parseDouble(ds_iud.getString(i, "SALE_AMOUNT").toString());
				// 과세일 경우
				if (ds_iud.getString(i, "TAX_CODE").equals("100")) {
					p_occur_amt = (long) (saleAmount * 1.1);  
				} else {
					p_occur_amt = (long) saleAmount;
				}

				sbSql2.delete(0, sbSql2.length());
				
				sbSql2.setLength(0);
				sbSql2.append("\n {                             ");
				sbSql2.append("\n  CALL FCUS.FMS_CREDIT_SUM_PRO ");
				sbSql2.append("\n  (                            ");
				sbSql2.append("\n     ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n   , ?                         ");
				sbSql2.append("\n  )                            ");
				sbSql2.append("\n }                             ");
				
				cstmt = conn.prepareCall( sbSql2.toString() );
				cstmt.setString(1, p_upjang_cd);                   // (필수)업장코드
				cstmt.setString(2, p_apply_date);                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
				cstmt.setString(3, "11");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
				cstmt.setLong(4, p_occur_amt);             // (필수)발생금액
				cstmt.setLong(5, p_occur_amt_before);              // (필수)발생금액(전)
				cstmt.setString(6, "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
				cstmt.setString(7, "SO_PR");     // (필수)발생테이블
				cstmt.setString(8, "PR_ID");                   // (필수)키명
				cstmt.setString(9, prId);                      // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
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
					logger.debug("sPrUpjang           : [" + p_upjang_cd            + "]");
					logger.debug("sNeedDate           : [" + p_apply_date           + "]");
					logger.debug("p_occur_amt         : [" + p_occur_amt    		+ "]");
					logger.debug("p_occur_amt_before  : [" + p_occur_amt_before     + "]");
					logger.debug("prId                : [" + prId               	+ "]");
					logger.debug("scrnId              : [" + scrnId             	+ "]");
					logger.debug("scrnName            : [" + scrnName           	+ "]");
					logger.debug("g_EmpNo             : [" + g_EmpNo            	+ "]");
					logger.debug("o_rtn               : [" + cstmt.getString(17)	+ "]");
					logger.debug("o_rtnmsg            : [" + cstmt.getString(18) 	+ "]");
				}
				// 여신금액 집계 프로시저 처리가 실패했을 경우
				if ( !ValidationUtil.isEquals(cstmt.getString(17), Const.YN_Y) ) {
					conn.rollback();
					this.setResultMessage(-1, cstmt.getString(18), out_vl);
					proc_output(response,out,out_vl,out_dl);
					return;
				}		
				//여신집계 프로시서 호출 끝 2017.09.04 김호석   
						
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
				
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
				sbSql.append("   SET NEED_DATE = '" + nullToBlank(ds_iud.getString(i, "NEED_DATE")) + "' \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
				sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_iud.getString(i, "ITEM_CODE")) + "' \n");
				sbSql.append("   AND PR_ID = " + nullToBlank(ds_iud.getString(i, "PR_ID")) + " \n");
				sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
				sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
				sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
				sbSql.append("                  AND B.UPJANG = " + nullToBlank(ds_iud.getString(i, "RC_UPJANG")) + " \n");
				sbSql.append("                  AND B.SUBINV_CODE = '" + nullToBlank(ds_iud.getString(i, "SUBINV_CODE")) + "') \n");
				
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
			
		}
		
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
		sbSql.append("      , '단가업장 수발주 스케쥴에 따른 해당상품 발주제한' AS ITEM_VAL         \n");
		sbSql.append(" FROM  SO_PR A 	                                                            \n");
		sbSql.append(" WHERE 1=1                                                                    \n");
		sbSql.append(" AND   (CENTER_CODE, CUSTCD, ITEM_CODE) IN                                    \n");
		sbSql.append("       (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                 \n");
		sbSql.append("        FROM   FMP_ORDER_SCHEDULE                                             \n");
		sbSql.append("        WHERE  CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                    \n");
		sbSql.append("        AND    UPJANG = '" + sApUnitpriceUjang + "'                                           \n");
		sbSql.append("        AND    USE_YN = 'Y'                                                   \n");
		sbSql.append("        AND    DECODE(TO_CHAR(TO_DATE('" + sNeedDate + "','YYYYMMDD'),'D'),   \n");
		sbSql.append("                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'        \n");
		sbSql.append("        UNION ALL                                                             \n");
		sbSql.append("        (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                \n");
		sbSql.append("        FROM    FMP_ORDER_SCHEDULE                                            \n");
		sbSql.append("        WHERE   CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                   \n");
		sbSql.append("        AND     UPJANG = -2                                                   \n");
		sbSql.append("        AND     USE_YN = 'Y'                                                  \n");
		sbSql.append("        AND     DECODE(TO_CHAR(TO_DATE('" + sNeedDate + "','YYYYMMDD'),'D'),  \n");
		sbSql.append("                       1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'       \n");
		sbSql.append("        MINUS                                                                 \n");
		sbSql.append("        SELECT  CENTER_CODE, CUSTCD, ITEM_CODE                                \n");
		sbSql.append("        FROM    FMP_ORDER_SCHEDULE                                            \n");
		sbSql.append("        WHERE   CENTER_CODE = '" + nullToBlank(ds_iud.getString(0, "CENTER_CODE")) + "'                                   \n");
		sbSql.append("        AND     UPJANG = '" + sApUnitpriceUjang + "'                                          \n");
		sbSql.append("        AND     USE_YN = 'Y'                                                  \n");
		sbSql.append("        AND     DECODE(TO_CHAR(TO_DATE('" + sNeedDate + "','YYYYMMDD'),'D'),  \n");
		sbSql.append("                       1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'))     \n");
		sbSql.append(" AND A.PR_NUM = '" + sPrNum + "'                                              \n");
		sbSql.append(" AND A.LINE_STATUS = '002' AND A.DOCU_SOURCE = '" + sDocSrc + "'              \n");
		
		stmt = conn.createStatement();
        rs = stmt.executeQuery(sbSql.toString());

        DataSet ds_save_out = this.makeDataSet(rs,"ds_save_out");
        
        if(ds_save_out.getRowCount() > 0)
        {
           this.setResultMessage(-1, "발주 불가 자재가 존재합니다.", out_vl);
           
           conn.rollback();
           out_dl.add(ds_save_out);
           proc_output(response,out,out_vl,out_dl);
           return;
        }
        rs.close();
        stmt.close();
		
		// 4. 구매발주 정합성 체크
		sbSql.delete(0, sbSql.length());
 		
  		sbSql.append("  SELECT T.* \n");
  		sbSql.append("    FROM ( \n");
  		sbSql.append("    SELECT A.ITEM_CODE \n");
  		sbSql.append("         , A.ITEM_NAME \n");
  		sbSql.append("         , A.CENTER_CODE \n");
  		sbSql.append("         , A.RC_UPJANG \n");
  		sbSql.append("         , A.CENTER_FLAG \n");
  		sbSql.append("         , (SELECT CASE WHEN VAL_SHP_CNT IN ('CE', 'NN') THEN '자재 업장군 맵핑 유효성 체크 오류'	\n");
  		sbSql.append("                        WHEN VAL_UNS_CNT IN ('UK', 'NN') THEN '자재 불용체크 오류' \n");
  		sbSql.append("                        WHEN VAL_STP_CNT IN ('TK', 'NN') THEN '자재 중지체크 오류' \n");
  		sbSql.append("                        WHEN VAL_EVT_CNT IN ('VE', 'NN') THEN '기획자재 한정수량체크 오류' \n");
  		sbSql.append("                        WHEN VAL_CTR_CNT IN ('SE', 'NN') THEN 'SPOT계약 발주횟수체크 오류' \n");
  		sbSql.append("                        WHEN VAL_REQ_CNT IN ('XE', 'NN') THEN '요일별 신청불가 체크 오류'	\n");
  		sbSql.append("                        WHEN VAL_SCH_CNT IN ('HE', 'NN') THEN '수발주 스케쥴에 따른 유효성 체크 오류' \n");
  		sbSql.append("                        WHEN A.CENTER_FLAG = 'DC' \n");
  		//sbSql.append("                             AND EPROCUSR.FC_GET_CENTER_IVT_YN('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE) \n");
  		sbSql.append("                             AND EPROCUSR.FC_GET_CENTER_IVT_YN('100', 'HFC', A.CENTER_CODE \n");
  		sbSql.append("                                                                    , A.ITEM_CODE, A.PR_QTY) = 'N' THEN 'DC자재 수량체크 오류' \n");
  		sbSql.append("                   ELSE 'OK' END \n");
  		sbSql.append("              FROM TABLE(EPROCUSR.FN_ITEM_PROCURE_VALIDATE('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE) \n");
  		sbSql.append("                                                           , A.ITEM_CODE, A.VD_SN, A.APPLY_SD, A.PR_QTY, A.UPJANG_GRP, '02' \n");
  		sbSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS') \n");
  		sbSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), TO_CHAR(SYSDATE, 'YYYYMMDD'), '" + sNeedDate + "')) \n");
  		sbSql.append("           ) AS ITEM_VAL \n");
  		sbSql.append("      FROM SO_PR A \n");
  		sbSql.append("     WHERE A.PR_NUM  = '" + sPrNum + "' \n");
  		sbSql.append("       AND A.LINE_STATUS = '002') T \n");
  		sbSql.append(" WHERE T.ITEM_VAL <> 'OK' \n");
		
  		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString());

        ds_save_out = this.makeDataSet(rs,"ds_save_out");
		
        if(ds_save_out.getRowCount() > 0)
		{
			this.setResultMessage(-1, "구매신청 불가 자재가 존재합니다.", out_vl);
        	conn.rollback();
        	out_dl.add(ds_save_out);
			proc_output(response,out,out_vl,out_dl);
			return;			
		}
        rs.close();
        stmt.close();
        
     	// 2. 구매 발주 데이터 삭제
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
   		cstmt.setString(8,sOrgPrNum);
   		cstmt.setString(9,"D");
   		cstmt.registerOutParameter(10, Types.VARCHAR);
   		cstmt.registerOutParameter(11, Types.VARCHAR);
   		
   		cstmt.execute();
   		
   		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:"+cstmt.getString(10));
            
         if(!cstmt.getString(10).equals("S000"))
         {
             conn.rollback();
             this.setResultMessage(-1, cstmt.getString(11), out_vl);
             proc_output(response,out,out_vl,out_dl);
             return;  	 
         }
         cstmt.close();
		
		// 5. 수정된 SO 데이터 구매 생성
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
   		cstmt.setString(9,"C");
   		cstmt.registerOutParameter(10, Types.VARCHAR);
   		cstmt.registerOutParameter(11, Types.VARCHAR);
   		
   		cstmt.execute();
   		
   		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>:"+cstmt.getString(10));
           
        if(!cstmt.getString(10).equals("S000"))
        {
            conn.rollback();
            this.setResultMessage(-1, cstmt.getString(11), out_vl);
            proc_output(response,out,out_vl,out_dl);
            return;
        }
        cstmt.close();
			
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