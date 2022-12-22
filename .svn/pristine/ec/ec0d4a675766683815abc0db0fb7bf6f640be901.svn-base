<%
//-----------------------------------------------------------------------------
//■ 시스템명          : 식재영업/수불관리>입고관리>반품내역서 출력
//■ 프로그램ID   : FMP00290V_T002.jsp
//■ 프로그램명       : 반품내역서 출력
//■ 작성일자          : 2008.01.25
//■ 작성자             : 노규완
//■ 이력관리          : 2008.01.25
//					Copy From [FMP00290V_T001.jsp]
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sSubinv_code = "";
		if (!nullToBlank(ds_cond.getString(0, "SUBINV_CODE")).equals("")) {
			sSubinv_code = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));	
		}

//		System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")))	;
		//내역조회
		sbSql.append("SELECT T.NEED_DATE \n");
		sbSql.append("     , T.RC_UPJANG AS UPJANG \n");
		sbSql.append("     , (SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = T.RC_UPJANG) AS UPJANGNM \n");
		sbSql.append("     , T.ITEM_CODE \n");
		sbSql.append("     , T.ITEM_NAME \n");
		sbSql.append("     , T.ITEM_SIZE \n");
		sbSql.append("     , T.PO_UOM \n");
		sbSql.append("     , T.LINE_STATUS \n");
		sbSql.append("     , T.PR_QTY \n");
		sbSql.append("     , T.RTN_QTY \n");
		sbSql.append("     , T.IN_QTY \n");
		sbSql.append("     , T.OP_PRICE \n");
		sbSql.append("     , ROUND(T.RTN_QTY * T.OP_PRICE) AS OP_AMOUNT \n");
		sbSql.append("     , ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.RTN_QTY * T.OP_PRICE)) AS OP_VAT \n");
		sbSql.append("     , T.ORIGIN_TYPE \n");
		sbSql.append("  FROM \n");
		sbSql.append("( \n");
			sbSql.append("SELECT  \n");
			sbSql.append("       TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			sbSql.append("     , A.RC_UPJANG \n");
			sbSql.append("     , A.ITEM_CODE \n");
			sbSql.append("     , A.ITEM_NAME \n");
			sbSql.append("     , A.ITEM_SIZE \n");
			sbSql.append("     , A.PO_UOM \n");
			sbSql.append("     , B.CODE_NAME AS LINE_STATUS \n");
			sbSql.append("     , SUM(A.ADJUST_QTY + A.PO_QTY) AS PR_QTY \n");
			sbSql.append("     , SUM(A.DELIVERED_QTY) AS IN_QTY\n");
			sbSql.append("     , SUM(A.ADJUST_QTY + A.CENTER_UNDELI_QTY + A.UNDELIVERED_QTY + A.RETURNED_QTY) AS RTN_QTY \n");
			sbSql.append("     , A.TAX_CODE \n");
			sbSql.append("     , A.ORIGIN_TYPE \n");
			sbSql.append("     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
			sbSql.append("            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
			sbSql.append("            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
			sbSql.append("       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
			//sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM HLDC_PO_PO A, HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
            sbSql.append("  FROM (SELECT A.*, B.ITEM_CLASS4, B.ORIGIN_TYPE FROM \n");
			sbSql.append("                                       (               SELECT  PODT.LEGCY_REQ_LNO       AS PO_ID  -- PO 아이디                                                                                                                                                     \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO        AS PO_NUM   -- PO번호                                                                                              \n");
			sbSql.append("                                                             , POHD.PO_CRE_DT           AS PO_DATE     -- 발주 일자                                                                                          \n");
			sbSql.append("                                                             , PODT.PR_REQ_CC_CD        AS PO_DEPT_ID  -- 발주자 부서(CC) 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.PO_CHR_ID           AS PO_SABUN    -- 발주자 사번                                                                                         \n");
			sbSql.append("                                                             , NVL(POHD.LEGCY_SO_TYP_CD, POHD.PURC_TYP)     AS PO_TYPE     -- 통합영업 구매유형 코드                                                               \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO        AS PR_ID       -- 통합영업 PR 요청 번호                                                                                  \n");
			sbSql.append("                                                           --  , (SELECT CC_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_DEPT_ID  --  신청자 부서코드(CC)\n");
			sbSql.append("                                                          --   , (SELECT SHOP_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_UPJANG  -- 신청자 업장코드     \n");
			sbSql.append("                                                             , POHD.VD_CD               AS CUSTCD      -- 업체코드                                                                                           \n");
			sbSql.append("                                                             , PODT.WH_CNTR_CD          AS CENTER_CODE -- 물류센터코드                                                                                         \n");
			sbSql.append("                                                             --, PODT.WH_CD               AS SUBINV_CODE -- 입고창고 코드                                                                                      \n");
			sbSql.append("                                                             , SAL.WH_CD                AS SUBINV_CODE -- 입고창고 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.MU_CD               AS RC_MU_CD    -- 입고업장/창고 MU 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.CC_CD               AS RC_DEPT_ID  -- 입고업장 부서(CC) 코드                                                                                 \n");
			sbSql.append("                                                             --, PODT.SHOP_CD             AS RC_UPJANG   -- 입고업장 코드                                                                                      \n");
			sbSql.append("                                                             , SAL.SHOP_CD              AS RC_UPJANG   -- 입고업장 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.ITEM_CD             AS ITEM_CODE   -- 자재코드                                                                                           \n");
			sbSql.append("                                                             , MTGL.ITEM_NM             AS ITEM_NAME   -- 자재명                                                                                            \n");
			sbSql.append("                                                             , MTGL.SPEC                AS ITEM_SIZE   -- 규격                                                                                             \n");
			sbSql.append("                                                             , MTGL.PURC_UNIT_CD        AS PO_UOM      -- 구매단위코드                                                                                         \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='1' THEN '100'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='3' THEN '210'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='2' THEN '220'                                                                                              \n");
			sbSql.append("                                                               END  AS TAX_CODE   -- 과세구분코드                                                                                                              \n");
			sbSql.append("                                                             , PODT.ACC_CD              AS ACCTCD      -- 매입계정코드                                                                                         \n");
			sbSql.append("                                                             , POHD.APRV_DT             AS ORDER_DATE  -- 발주 일시 (검토발주의 경우 승인일시)                                                                          \n");
			sbSql.append("                                                             , PODT.PROC_TYP_CD AS CENTER_FLAG  -- 센터경유 여부                                                                                               \n");
			sbSql.append("                                                             , PODT.BUY_PRICE           AS UNIT_PRICE -- 매입 단가                                                                                           \n");
			sbSql.append("                                                             , PODT.MGT_PRICE           AS MARGIN_PRICE -- 출하(관리) 단가                                                                                     \n");
			sbSql.append("                                                             , NVL(PODT.PR_QTY,0) - NVL(PODT.ITEM_QTY,0) AS ADJUST_QTY -- 발주 조정수량 ( PR수량 - PO수량 )                                                        \n");
			sbSql.append("                                                             , PODT.PR_QTY              AS PR_QTY      -- 신청 수량                                                                                          \n");
			sbSql.append("                                                             , PODT.ITEM_QTY            AS PO_QTY      -- 발수 수량                                                                                          \n");
			sbSql.append("                                                            -- , CASE WHEN PODT.PROC_TYP_CD IN('DC', 'TC') THEN PODT.ITEM_QTY ELSE 0 END  AS CENTER_DELI_QTY  -- 센터입고수량                              \n");
			sbSql.append("                                                             , 0  AS CENTER_UNDELI_QTY             -- 센터미입고 수량                                                                                           \n");
			sbSql.append("                                                           --  , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY ELSE 0 END  AS DIRECT_DELI_QTY  -- 직송 수량                                           \n");
			sbSql.append("                                                             , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0) ELSE NVL(PODT.GR_QTY_WMS,0) END  AS DELIVERED_QTY    --업장입고수량(센터출고)             \n");
			sbSql.append("                                                        --     , CASE WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN  -- 입고완료                                                                  \n");
			sbSql.append("                                                        --         CASE WHEN PODT.PROC_TYP_CD<>'DC' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0)                                                     \n");
			sbSql.append("                                                        --         ELSE 0                                                                                                                                \n");
			sbSql.append("                                                        --         END                                                                                                                                   \n");
			sbSql.append("                                                        --       ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                        --       END AS UNDELIVERED_QTY -- 감량수량                                                                                                          \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료                              \n");
			sbSql.append("                                                                 ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                               END AS UNDELIVERED_QTY -- 감량수량                                                                                                            \n");
			sbSql.append("                                                             , PODT.RTN_QTY AS RETURNED_QTY -- 반품수량                                                                                                      \n");
			sbSql.append("                                                             , SAL.CUST_GR_DATE                AS NEED_DATE -- 입고희망일자                                                                                    \n");
			sbSql.append("                                                             , NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN                                                                                                   \n");
			sbSql.append("                                                                     CASE                                                                                                                                \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가                                            \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD'                                                        \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC'                                                        \n");
			sbSql.append("                                                                     END                                                                                                                                 \n");
			sbSql.append("                                                               --ELSE NVL(PRDT.PR_PROG_STS, 'PC')                                                                                                      \n");
			sbSql.append("                                                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))                                                              \n");
			sbSql.append("                                                               END,'PC') AS LINE_STATUS  -- 라인 상태 코드                                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_PRICE,0)      AS SALE_PRICE -- 판매 단가                                                                                          \n");
			sbSql.append("                                                             , NVL(SAL.SAL_EVNT_PRICE,0) AS SAL_EVNT_PRICE -- 판매 기획 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_STRA_PRICE,0) AS SAL_STRA_PRICE -- 판매 전략 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_ENCO_PRICE,0) AS SAL_ENCO_PRICE -- 판매 장려 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_OPER_PRICE,0) AS SAL_OPER_PRICE -- 판매 운영 단가                                                                                   \n");
			sbSql.append("                                                             , CASE WHEN NVL(SAL.SHOP_CHNG_YN,'N')='N' THEN 'Y' ELSE 'N' END AS CLAIM_YN -- 클레임등록가능 여부                                           \n");
			sbSql.append("                                                             , PODT.PO_COMP_YN AS PO_COMP_YN -- 부분입고 여부                                                                                                  \n");
			sbSql.append("                                                             , PODT.PJT_NO AS PJT_NO -- PJT I/O 넘버                                                                                                       \n");
			sbSql.append("                                                             , PODT.PO_NO AS PO_NO  -- PO_NO                                                                                                             \n");
			sbSql.append("                                                             , PODT.PO_LNO AS PO_LNO   -- PO_LNO                                                                                                         \n");
			sbSql.append("                                                             , PRDT.PR_NO AS PR_NO -- PR_NO                                                                                                              \n");
			sbSql.append("                                                             , PRDT.PR_LNO AS PR_LNO -- PR_LNO                                                                                                           \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO AS LEGCY_REQ_NO                                                                                                         \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_LNO AS LEGCY_REQ_LNO                                                                                                       \n");
			sbSql.append("                                                          FROM EPROCUSR.ESPPOHD POHD   -- PO 헤더                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODT PODT   -- PO 상세(품목)                                                                                                      \n");
			sbSql.append("                                                             , EPROCUSR.ESMMTGL MTGL   -- 자재마스터                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]                                                                                                   \n");
			sbSql.append("                                                             , EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목)                                                                                                      \n");
			sbSql.append("                                                         WHERE PODT.SYS_ID  = POHD.SYS_ID(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.COMP_CD = POHD.COMP_CD (+)                                                                                                           \n");
			sbSql.append("                                                           AND PODT.PO_NO   = POHD.PO_NO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = SAL.SYS_ID(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.COMP_CD = SAL.COMP_CD(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.PO_NO   = SAL.PO_NO(+)                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PO_LNO  = SAL.PO_LNO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = MTGL.SYS_ID                                                                                                                \n");
			sbSql.append("                                                           AND PODT.ITEM_CD = MTGL.ITEM_CD                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PR_NO   = PRDT.PR_NO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.PR_LNO  = PRDT.PR_LNO(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = PRDT.SYS_ID(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.COMP_CD = PRDT.COMP_CD(+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = '100'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.COMP_CD = 'HFC'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.SHOP_TYP_CD = '02'                                                                                                                 \n");
			sbSql.append("                                                           --AND POHD.STS    <> 'D'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.STS    <> 'D'                                                                                                                      \n");
			sbSql.append("                                                           --AND PRDT.STS    <> 'D'                                                                                                                    \n");
			sbSql.append("                                                           AND POHD.PO_TYP = 'UP'                                                                                                                      \n");
			if (!sUpjang.equals("")){		
				sbSql.append("   AND SAL.SHOP_CD  = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");	
			}
			//sbSql.append("                                                           AND SAL.SHOP_CD  IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG =  " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")                                                               \n");
			sbSql.append("                                                           AND  SAL.CUST_GR_DATE  BETWEEN  '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("                                                           --AND DECODE(POHD.PO_TYP, 'BP', '1', PRDT.STS) <> DECODE(POHD.PO_TYP, 'BP', '2', 'D')                                               \n");
			sbSql.append("                                                         UNION ALL                                                                                                                                       \n");
			sbSql.append("                                                        SELECT PODT.LEGCY_REQ_LNO       AS PO_ID  -- PO 아이디                                                                                              \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO        AS PO_NUM   -- PO번호                                                                                              \n");
			sbSql.append("                                                             , POHD.PO_CRE_DT           AS PO_DATE     -- 발주 일자                                                                                          \n");
			sbSql.append("                                                             , PODT.PR_REQ_CC_CD        AS PO_DEPT_ID  -- 발주자 부서(CC) 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.PO_CHR_ID           AS PO_SABUN    -- 발주자 사번                                                                                         \n");
			sbSql.append("                                                             , NVL(POHD.LEGCY_SO_TYP_CD, POHD.PURC_TYP)     AS PO_TYPE     -- 통합영업 구매유형 코드                                                               \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO        AS PR_ID       -- 통합영업 PR 요청 번호                                                                                  \n");
			sbSql.append("                                                          --   , (SELECT CC_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_DEPT_ID  --  신청자 부서코드(CC)\n");
			sbSql.append("                                                          --   , (SELECT SHOP_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_UPJANG  -- 신청자 업장코드     \n");
			sbSql.append("                                                             , POHD.VD_CD               AS CUSTCD      -- 업체코드                                                                                           \n");
			sbSql.append("                                                             , PODT.WH_CNTR_CD          AS CENTER_CODE -- 물류센터코드                                                                                         \n");
			sbSql.append("                                                             , PODT.WH_CD               AS SUBINV_CODE -- 입고창고 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.MU_CD               AS RC_MU_CD    -- 입고업장/창고 MU 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.CC_CD               AS RC_DEPT_ID  -- 입고업장 부서(CC) 코드                                                                                 \n");
			sbSql.append("                                                             , PODT.SHOP_CD             AS RC_UPJANG   -- 입고업장 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.ITEM_CD             AS ITEM_CODE   -- 자재코드                                                                                           \n");
			sbSql.append("                                                             , MTGL.ITEM_NM             AS ITEM_NAME   -- 자재명                                                                                            \n");
			sbSql.append("                                                             , MTGL.SPEC                AS ITEM_SIZE   -- 규격                                                                                             \n");
			sbSql.append("                                                             , MTGL.PURC_UNIT_CD        AS PO_UOM      -- 구매단위코드                                                                                         \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='1' THEN '100'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='3' THEN '210'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='2' THEN '220'                                                                                              \n");
			sbSql.append("                                                               END  AS TAX_CODE   -- 과세구분코드                                                                                                              \n");
			sbSql.append("                                                             , PODT.ACC_CD              AS ACCTCD      -- 매입계정코드                                                                                         \n");
			sbSql.append("                                                             , POHD.APRV_DT             AS ORDER_DATE  -- 발주 일시 (검토발주의 경우 승인일시)                                                                          \n");
			sbSql.append("                                                             , PODT.PROC_TYP_CD AS CENTER_FLAG  -- 센터경유 여부                                                                                               \n");
			sbSql.append("                                                             , PODT.BUY_PRICE           AS UNIT_PRICE -- 매입 단가                                                                                           \n");
			sbSql.append("                                                             , PODT.MGT_PRICE           AS MARGIN_PRICE -- 출하(관리) 단가                                                                                     \n");
			sbSql.append("                                                             , NVL(PODT.PR_QTY,0) - NVL(PODT.ITEM_QTY,0) AS ADJUST_QTY -- 발주 조정수량 ( PR수량 - PO수량 )                                                        \n");
			sbSql.append("                                                             , PODT.PR_QTY              AS PR_QTY      -- 신청 수량                                                                                          \n");
			sbSql.append("                                                             , PODT.ITEM_QTY            AS PO_QTY      -- 발수 수량                                                                                          \n");
			sbSql.append("                                                        --     , CASE WHEN PODT.PROC_TYP_CD IN('DC', 'TC') THEN PODT.ITEM_QTY ELSE 0 END  AS CENTER_DELI_QTY  -- 센터입고수량                              \n");
			sbSql.append("                                                             , 0  AS CENTER_UNDELI_QTY             -- 센터미입고 수량                                                                                           \n");
			sbSql.append("                                                         --    , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY ELSE 0 END  AS DIRECT_DELI_QTY  -- 직송 수량                                           \n");
			sbSql.append("                                                             , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0) ELSE NVL(PODT.GR_QTY_WMS,0) END  AS DELIVERED_QTY    --업장입고수량(센터출고)             \n");
			sbSql.append("                                                        --     , CASE WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN  -- 입고완료                                                                  \n");
			sbSql.append("                                                        --         CASE WHEN PODT.PROC_TYP_CD<>'DC' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0)                                                     \n");
			sbSql.append("                                                        --         ELSE 0                                                                                                                                \n");
			sbSql.append("                                                        --         END                                                                                                                                   \n");
			sbSql.append("                                                        --       ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                        --       END AS UNDELIVERED_QTY -- 감량수량                                                                                                          \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료                              \n");
			sbSql.append("                                                                 ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                               END AS UNDELIVERED_QTY -- 감량수량                                                                                                            \n");
			sbSql.append("                                                             , PODT.RTN_QTY AS RETURNED_QTY -- 반품수량                                                                                                      \n");
			sbSql.append("                                                             , PODT.GR_REQ_DATE                AS NEED_DATE -- 입고희망일자                                                                                    \n");
			sbSql.append("                                                             , NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN                                                                                                   \n");
			sbSql.append("                                                                     CASE                                                                                                                                \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가                                            \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD'                                                        \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC'                                                        \n");
			sbSql.append("                                                                     END                                                                                                                                 \n");
			sbSql.append("                                                               --ELSE NVL(PRDT.PR_PROG_STS, 'PC')                                                                                                      \n");
			sbSql.append("                                                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))                                                              \n");
			sbSql.append("                                                               END,'PC') AS LINE_STATUS  -- 라인 상태 코드                                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_PRICE,0)      AS SALE_PRICE -- 판매 단가                                                                                          \n");
			sbSql.append("                                                             , NVL(SAL.SAL_EVNT_PRICE,0) AS SAL_EVNT_PRICE -- 판매 기획 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_STRA_PRICE,0) AS SAL_STRA_PRICE -- 판매 전략 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_ENCO_PRICE,0) AS SAL_ENCO_PRICE -- 판매 장려 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_OPER_PRICE,0) AS SAL_OPER_PRICE -- 판매 운영 단가                                                                                   \n");
			sbSql.append("                                                             , 'Y'                       AS CLAIM_YN -- 클레임등록가능 여부                                                                                     \n");
			sbSql.append("                                                             , PODT.PO_COMP_YN AS PO_COMP_YN -- 부분입고 여부                                                                                                  \n");
			sbSql.append("                                                             , PODT.PJT_NO AS PJT_NO -- PJT I/O 넘버                                                                                                       \n");
			sbSql.append("                                                             , PODT.PO_NO AS PO_NO  -- PO_NO                                                                                                             \n");
			sbSql.append("                                                             , PODT.PO_LNO AS PO_LNO   -- PO_LNO                                                                                                         \n");
			sbSql.append("                                                             , PRDT.PR_NO AS PR_NO -- PR_NO                                                                                                              \n");
			sbSql.append("                                                             , PRDT.PR_LNO AS PR_LNO -- PR_LNO                                                                                                           \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO AS LEGCY_REQ_NO                                                                                                         \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_LNO AS LEGCY_REQ_LNO                                                                                                       \n");
			sbSql.append("                                                          FROM EPROCUSR.ESPPOHD POHD   -- PO 헤더                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODT PODT   -- PO 상세(품목)                                                                                                      \n");
			sbSql.append("                                                             , EPROCUSR.ESMMTGL MTGL   -- 자재마스터                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]                                                                                                   \n");
			sbSql.append("                                                             , EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목)                                                                                                      \n");
			sbSql.append("                                                         WHERE PODT.SYS_ID  = POHD.SYS_ID (+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.COMP_CD = POHD.COMP_CD(+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.PO_NO   = POHD.PO_NO  (+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = SAL.SYS_ID(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.COMP_CD = SAL.COMP_CD(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.PO_NO   = SAL.PO_NO(+)                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PO_LNO  = SAL.PO_LNO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = MTGL.SYS_ID                                                                                                                \n");
			sbSql.append("                                                           AND PODT.ITEM_CD = MTGL.ITEM_CD                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PR_NO   = PRDT.PR_NO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.PR_LNO  = PRDT.PR_LNO(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = PRDT.SYS_ID(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.COMP_CD = PRDT.COMP_CD(+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.SHOP_TYP_CD <> '02'                                                                                                                \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = '100'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.COMP_CD = 'HFC'                                                                                                                    \n");
			sbSql.append("                                                           -- AND POHD.STS    <> 'D'                                                                                                                   \n");
			sbSql.append("                                                           AND PODT.STS    <> 'D'                                                                                                                      \n");
			sbSql.append("                                                           AND PRDT.STS    <> 'D'                                                                                                                      \n");
			sbSql.append("                                                           AND PODT.REQ_SYS_CD = 'FR'                                                                                                                  \n");
			if (!sUpjang.equals("")){		
				sbSql.append("   AND SAL.SHOP_CD  = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");	
			}
			//sbSql.append("                                                           AND SAL.SHOP_CD  IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG =  " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")                                                               \n");
			sbSql.append("                                                           AND  SAL.CUST_GR_DATE BETWEEN  '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("                                                         UNION ALL                                                                                                                                       \n");
			sbSql.append("                                                        SELECT TO_NUMBER(PODT.PO_LNO)   AS PO_ID  -- PO 아이디                                                                                              \n");
			sbSql.append("                                                             , PODT.PO_NO               AS PO_NUM   -- PO번호                                                                                              \n");
			sbSql.append("                                                             , POHD.PO_CRE_DT           AS PO_DATE     -- 발주 일자                                                                                          \n");
			sbSql.append("                                                             , PODT.PR_REQ_CC_CD        AS PO_DEPT_ID  -- 발주자 부서(CC) 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.PO_CHR_ID           AS PO_SABUN    -- 발주자 사번                                                                                         \n");
			sbSql.append("                                                             , NVL(POHD.LEGCY_SO_TYP_CD, POHD.PURC_TYP)     AS PO_TYPE     -- 통합영업 구매유형 코드                                                               \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO        AS PR_ID       -- 통합영업 PR 요청 번호                                                                                  \n");
			sbSql.append("                                                           --  , (SELECT CC_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_DEPT_ID  --  신청자 부서코드(CC)\n");
			sbSql.append("                                                           --  , (SELECT SHOP_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_UPJANG  -- 신청자 업장코드     \n");
			sbSql.append("                                                             , POHD.VD_CD               AS CUSTCD      -- 업체코드                                                                                           \n");
			sbSql.append("                                                             , PODT.WH_CNTR_CD          AS CENTER_CODE -- 물류센터코드                                                                                         \n");
			sbSql.append("                                                             , PODT.WH_CD               AS SUBINV_CODE -- 입고창고 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.MU_CD               AS RC_MU_CD    -- 입고업장/창고 MU 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.CC_CD               AS RC_DEPT_ID  -- 입고업장 부서(CC) 코드                                                                                 \n");
			sbSql.append("                                                             , PODT.SHOP_CD             AS RC_UPJANG   -- 입고업장 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.ITEM_CD             AS ITEM_CODE   -- 자재코드                                                                                           \n");
			sbSql.append("                                                             , MTGL.ITEM_NM             AS ITEM_NAME   -- 자재명                                                                                            \n");
			sbSql.append("                                                             , MTGL.SPEC                AS ITEM_SIZE   -- 규격                                                                                             \n");
			sbSql.append("                                                             , MTGL.PURC_UNIT_CD        AS PO_UOM      -- 구매단위코드                                                                                         \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='1' THEN '100'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='3' THEN '210'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='2' THEN '220'                                                                                              \n");
			sbSql.append("                                                               END  AS TAX_CODE   -- 과세구분코드                                                                                                              \n");
			sbSql.append("                                                             , PODT.ACC_CD              AS ACCTCD      -- 매입계정코드                                                                                         \n");
			sbSql.append("                                                             , POHD.APRV_DT             AS ORDER_DATE  -- 발주 일시 (검토발주의 경우 승인일시)                                                                          \n");
			sbSql.append("                                                             , PODT.PROC_TYP_CD AS CENTER_FLAG  -- 센터경유 여부                                                                                               \n");
			sbSql.append("                                                             , PODT.BUY_PRICE           AS UNIT_PRICE -- 매입 단가                                                                                           \n");
			sbSql.append("                                                             , PODT.MGT_PRICE           AS MARGIN_PRICE -- 출하(관리) 단가                                                                                     \n");
			sbSql.append("                                                             , NVL(PODT.PR_QTY,0) - NVL(PODT.ITEM_QTY,0) AS ADJUST_QTY -- 발주 조정수량 ( PR수량 - PO수량 )                                                        \n");
			sbSql.append("                                                             , PODT.PR_QTY              AS PR_QTY      -- 신청 수량                                                                                          \n");
			sbSql.append("                                                             , PODT.ITEM_QTY            AS PO_QTY      -- 발수 수량                                                                                          \n");
			sbSql.append("                                                          --   , CASE WHEN PODT.PROC_TYP_CD IN('DC', 'TC') THEN PODT.ITEM_QTY ELSE 0 END  AS CENTER_DELI_QTY  -- 센터입고수량                              \n");
			sbSql.append("                                                             , 0  AS CENTER_UNDELI_QTY             -- 센터미입고 수량                                                                                           \n");
			sbSql.append("                                                          --   , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY ELSE 0 END  AS DIRECT_DELI_QTY  -- 직송 수량                                           \n");
			sbSql.append("                                                             , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0) ELSE NVL(PODT.GR_QTY_WMS,0) END  AS DELIVERED_QTY    --업장입고수량(센터출고)             \n");
			sbSql.append("                                                        --     , CASE WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN  -- 입고완료                                                                  \n");
			sbSql.append("                                                        --         CASE WHEN PODT.PROC_TYP_CD<>'DC' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0)                                                     \n");
			sbSql.append("                                                        --         ELSE 0                                                                                                                                \n");
			sbSql.append("                                                        --         END                                                                                                                                   \n");
			sbSql.append("                                                        --       ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                        --       END AS UNDELIVERED_QTY -- 감량수량                                                                                                          \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료                              \n");
			sbSql.append("                                                                 ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                               END AS UNDELIVERED_QTY -- 감량수량                                                                                                            \n");
			sbSql.append("                                                             , PODT.RTN_QTY AS RETURNED_QTY -- 반품수량                                                                                                      \n");
			sbSql.append("                                                             , PODT.GR_REQ_DATE                AS NEED_DATE -- 입고희망일자                                                                                    \n");
			sbSql.append("                                                             , NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN                                                                                                   \n");
			sbSql.append("                                                                     CASE                                                                                                                                \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가                                            \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD'                                                        \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC'                                                        \n");
			sbSql.append("                                                                     END                                                                                                                                 \n");
			sbSql.append("                                                               --ELSE NVL(PRDT.PR_PROG_STS, 'PC')                                                                                                      \n");
			sbSql.append("                                                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))                                                              \n");
			sbSql.append("                                                               END,'PC') AS LINE_STATUS  -- 라인 상태 코드                                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_PRICE,0)      AS SALE_PRICE -- 판매 단가                                                                                          \n");
			sbSql.append("                                                             , NVL(SAL.SAL_EVNT_PRICE,0) AS SAL_EVNT_PRICE -- 판매 기획 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_STRA_PRICE,0) AS SAL_STRA_PRICE -- 판매 전략 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_ENCO_PRICE,0) AS SAL_ENCO_PRICE -- 판매 장려 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_OPER_PRICE,0) AS SAL_OPER_PRICE -- 판매 운영 단가                                                                                   \n");
			sbSql.append("                                                             , 'Y'                       AS CLAIM_YN -- 클레임등록가능 여부                                                                                     \n");
			sbSql.append("                                                             , PODT.PO_COMP_YN AS PO_COMP_YN -- 부분입고 여부                                                                                                  \n");
			sbSql.append("                                                             , PODT.PJT_NO AS PJT_NO -- PJT I/O 넘버                                                                                                       \n");
			sbSql.append("                                                             , PODT.PO_NO AS PO_NO  -- PO_NO                                                                                                             \n");
			sbSql.append("                                                             , PODT.PO_LNO AS PO_LNO   -- PO_LNO                                                                                                         \n");
			sbSql.append("                                                             , PRDT.PR_NO AS PR_NO -- PR_NO                                                                                                              \n");
			sbSql.append("                                                             , PRDT.PR_LNO AS PR_LNO -- PR_LNO                                                                                                           \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO AS LEGCY_REQ_NO                                                                                                         \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_LNO AS LEGCY_REQ_LNO                                                                                                       \n");
			sbSql.append("                                                          FROM EPROCUSR.ESPPOHD POHD   -- PO 헤더                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODT PODT   -- PO 상세(품목)                                                                                                      \n");
			sbSql.append("                                                             , EPROCUSR.ESMMTGL MTGL   -- 자재마스터                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]                                                                                                   \n");
			sbSql.append("                                                             , EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목)                                                                                                      \n");
			sbSql.append("                                                         WHERE PODT.SYS_ID  = POHD.SYS_ID (+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.COMP_CD = POHD.COMP_CD (+)                                                                                                           \n");
			sbSql.append("                                                           AND PODT.PO_NO   = POHD.PO_NO (+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = SAL.SYS_ID(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.COMP_CD = SAL.COMP_CD(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.PO_NO   = SAL.PO_NO(+)                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PO_LNO  = SAL.PO_LNO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = MTGL.SYS_ID                                                                                                                \n");
			sbSql.append("                                                           AND PODT.ITEM_CD = MTGL.ITEM_CD                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PR_NO   = PRDT.PR_NO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.PR_LNO  = PRDT.PR_LNO(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = PRDT.SYS_ID(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.COMP_CD = PRDT.COMP_CD(+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.SHOP_TYP_CD <> '02'                                                                                                                \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = '100'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.COMP_CD = 'HFC'                                                                                                                    \n");
			sbSql.append("                                                           --AND POHD.STS    <> 'D'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.STS    <> 'D'                                                                                                                      \n");
			sbSql.append("                                                           --AND PRDT.STS    <> 'D'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.REQ_SYS_CD <> 'FR'                                                                                                                 \n");
			if (!sUpjang.equals("")){		
				sbSql.append("   AND SAL.SHOP_CD  = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");	
			}
			//sbSql.append("                                                           AND SAL.SHOP_CD  IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG =  " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")                                                               \n");
			sbSql.append("                                                           AND  SAL.CUST_GR_DATE  BETWEEN  '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("                                                           --2015.10.19 최학진 정산용 PO 추가                                                                                                                    \n");
			sbSql.append("                                                           UNION ALL                                                                                                                                     \n");
			sbSql.append("                                                            SELECT TO_NUMBER(PODT.PO_LNO) AS PO_ID --PO 아이디                                                                                              \n");
			sbSql.append("                                                             , PODT.PO_NO               AS PO_NUM --PO번호                                                                                                 \n");
			sbSql.append("                                                             , POHD.PO_CRE_DT           AS PO_DATE     -- 발주 일자                                                                                          \n");
			sbSql.append("                                                             , PODT.PR_REQ_CC_CD        AS PO_DEPT_ID  -- 발주자 부서(CC) 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.PO_CHR_ID           AS PO_SABUN    -- 발주자 사번                                                                                         \n");
			sbSql.append("                                                             , NVL(POHD.LEGCY_SO_TYP_CD, POHD.PURC_TYP)     AS PO_TYPE     -- 통합영업 구매유형 코드                                                               \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO        AS PR_ID       -- 통합영업 PR 요청 번호                                                                                  \n");
			sbSql.append("                                                        --     , (SELECT CC_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_DEPT_ID  --  신청자 부서코드(CC)\n");
			sbSql.append("                                                         --    , (SELECT SHOP_CD FROM ESAUSER WHERE SYS_ID=PODT.SYS_ID AND COMP_CD=PODT.COMP_CD AND USR_ID=PODT.PR_REQ_ID) AS PR_UPJANG  -- 신청자 업장코드     \n");
			sbSql.append("                                                             , POHD.VD_CD               AS CUSTCD      -- 업체코드                                                                                           \n");
			sbSql.append("                                                             , PODT.WH_CNTR_CD          AS CENTER_CODE -- 물류센터코드                                                                                         \n");
			sbSql.append("                                                             , SAL.WH_CD                AS SUBINV_CODE -- 입고창고 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.MU_CD               AS RC_MU_CD    -- 입고업장/창고 MU 코드                                                                                  \n");
			sbSql.append("                                                             , PODT.CC_CD               AS RC_DEPT_ID  -- 입고업장 부서(CC) 코드                                                                                 \n");
			sbSql.append("                                                             , SAL.SHOP_CD              AS RC_UPJANG   -- 입고업장 코드                                                                                        \n");
			sbSql.append("                                                             , PODT.ITEM_CD             AS ITEM_CODE   -- 자재코드                                                                                           \n");
			sbSql.append("                                                             , MTGL.ITEM_NM             AS ITEM_NAME   -- 자재명                                                                                            \n");
			sbSql.append("                                                             , MTGL.SPEC                AS ITEM_SIZE   -- 규격                                                                                             \n");
			sbSql.append("                                                             , MTGL.PURC_UNIT_CD        AS PO_UOM      -- 구매단위코드                                                                                         \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='1' THEN '100'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='3' THEN '210'                                                                                              \n");
			sbSql.append("                                                                 WHEN PODT.DUTY_FREE_YN ='2' THEN '220'                                                                                              \n");
			sbSql.append("                                                               END  AS TAX_CODE   -- 과세구분코드                                                                                                              \n");
			sbSql.append("                                                             , PODT.ACC_CD              AS ACCTCD      -- 매입계정코드                                                                                         \n");
			sbSql.append("                                                             , POHD.APRV_DT             AS ORDER_DATE  -- 발주 일시 (검토발주의 경우 승인일시)                                                                          \n");
			sbSql.append("                                                             , PODT.PROC_TYP_CD AS CENTER_FLAG  -- 센터경유 여부                                                                                               \n");
			sbSql.append("                                                             , PODT.BUY_PRICE           AS UNIT_PRICE -- 매입 단가                                                                                           \n");
			sbSql.append("                                                             , PODT.MGT_PRICE           AS MARGIN_PRICE -- 출하(관리) 단가                                                                                     \n");
			sbSql.append("                                                             --, NVL(PODT.PR_QTY,0) - NVL(PODT.ITEM_QTY,0) AS ADJUST_QTY -- 발주 조정수량 ( PR수량 - PO수량 )                                                      \n");
			sbSql.append("                                                             , 0 as ADJUST_QTY -- 발주 조정수량 ( 정산용PO는 PR이 없다 )                                                                                              \n");
			sbSql.append("                                                             , PODT.PR_QTY              AS PR_QTY      -- 신청 수량                                                                                          \n");
			sbSql.append("                                                             , PODT.ITEM_QTY            AS PO_QTY      -- 발수 수량                                                                                          \n");
			sbSql.append("                                                           --  , CASE WHEN PODT.PROC_TYP_CD IN('DC', 'TC') THEN PODT.ITEM_QTY ELSE 0 END  AS CENTER_DELI_QTY  -- 센터입고수량                              \n");
			sbSql.append("                                                             , 0  AS CENTER_UNDELI_QTY             -- 센터미입고 수량                                                                                           \n");
			sbSql.append("                                                           --  , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY ELSE 0 END  AS DIRECT_DELI_QTY  -- 직송 수량                                           \n");
			sbSql.append("                                                             , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0) ELSE NVL(PODT.GR_QTY_WMS,0) END  AS DELIVERED_QTY    --업장입고수량(센터출고)             \n");
			sbSql.append("                                                        --     , CASE WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN  -- 입고완료                                                                  \n");
			sbSql.append("                                                        --         CASE WHEN PODT.PROC_TYP_CD<>'DC' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0)                                                     \n");
			sbSql.append("                                                        --         ELSE 0                                                                                                                                \n");
			sbSql.append("                                                        --         END                                                                                                                                   \n");
			sbSql.append("                                                        --       ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                        --       END AS UNDELIVERED_QTY -- 감량수량                                                                                                          \n");
			sbSql.append("                                                             , CASE                                                                                                                                      \n");
			sbSql.append("                                                                 WHEN PODT.PO_COMP_YN='Y' OR PODT.GR_COMP_YN='Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료                              \n");
			sbSql.append("                                                                 ELSE 0                                                                                                                                  \n");
			sbSql.append("                                                               END AS UNDELIVERED_QTY -- 감량수량                                                                                                            \n");
			sbSql.append("                                                             , PODT.RTN_QTY AS RETURNED_QTY -- 반품수량                                                                                                      \n");
			sbSql.append("                                                             , SAL.CUST_GR_DATE                AS NEED_DATE -- 입고희망일자                                                                                    \n");
			sbSql.append("                                                             , NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN                                                                                                   \n");
			sbSql.append("                                                                     CASE                                                                                                                                \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'T'         THEN 'RW' --통합영업에서 뷰 불가                                            \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'P'         THEN 'PW'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS IN ('R', 'W') THEN 'PD'                                                        \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='N' AND POHD.APRV_STS = 'B'         THEN 'PD'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS = 'B'         THEN 'GC'                                                          \n");
			sbSql.append("                                                                       WHEN PODT.GR_COMP_YN='Y' AND POHD.APRV_STS IN ('C', 'K') THEN 'GC'                                                        \n");
			sbSql.append("                                                                     END                                                                                                                                 \n");
			sbSql.append("                                                               --ELSE NVL(PRDT.PR_PROG_STS, 'PC')                                                                                                      \n");
			sbSql.append("                                                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))                                                              \n");
			sbSql.append("                                                               END,'PC') AS LINE_STATUS  -- 라인 상태 코드                                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_PRICE,0)      AS SALE_PRICE -- 판매 단가                                                                                          \n");
			sbSql.append("                                                             , NVL(SAL.SAL_EVNT_PRICE,0) AS SAL_EVNT_PRICE -- 판매 기획 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_STRA_PRICE,0) AS SAL_STRA_PRICE -- 판매 전략 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_ENCO_PRICE,0) AS SAL_ENCO_PRICE -- 판매 장려 단가                                                                                   \n");
			sbSql.append("                                                             , NVL(SAL.SAL_OPER_PRICE,0) AS SAL_OPER_PRICE -- 판매 운영 단가                                                                                   \n");
			sbSql.append("                                                             , CASE WHEN NVL(SAL.SHOP_CHNG_YN,'N')='N' THEN 'Y' ELSE 'N' END AS CLAIM_YN -- 클레임등록가능 여부                                           \n");
			sbSql.append("                                                             , PODT.PO_COMP_YN AS PO_COMP_YN -- 부분입고 여부                                                                                                  \n");
			sbSql.append("                                                             , PODT.PJT_NO AS PJT_NO -- PJT I/O 넘버                                                                                                       \n");
			sbSql.append("                                                             , PODT.PO_NO AS PO_NO  -- PO_NO                                                                                                             \n");
			sbSql.append("                                                             , PODT.PO_LNO AS PO_LNO   -- PO_LNO                                                                                                         \n");
			sbSql.append("                                                             , PRDT.PR_NO AS PR_NO -- PR_NO                                                                                                              \n");
			sbSql.append("                                                             , PRDT.PR_LNO AS PR_LNO -- PR_LNO                                                                                                           \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_NO AS LEGCY_REQ_NO                                                                                                         \n");
			sbSql.append("                                                             , PODT.LEGCY_REQ_LNO AS LEGCY_REQ_LNO                                                                                                       \n");
			sbSql.append("                                                          FROM EPROCUSR.ESPPOHD POHD   -- PO 헤더                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODT PODT   -- PO 상세(품목)                                                                                                      \n");
			sbSql.append("                                                             , EPROCUSR.ESMMTGL MTGL   -- 자재마스터                                                                                                          \n");
			sbSql.append("                                                             , EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]                                                                                                   \n");
			sbSql.append("                                                             , EPROCUSR.ESPPRDT PRDT   -- PR 상세(품목)                                                                                                      \n");
			sbSql.append("                                                         WHERE PODT.SYS_ID  = POHD.SYS_ID(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.COMP_CD = POHD.COMP_CD (+)                                                                                                           \n");
			sbSql.append("                                                           AND PODT.PO_NO   = POHD.PO_NO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = SAL.SYS_ID(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.COMP_CD = SAL.COMP_CD(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.PO_NO   = SAL.PO_NO(+)                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PO_LNO  = SAL.PO_LNO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = MTGL.SYS_ID                                                                                                                \n");
			sbSql.append("                                                           AND PODT.ITEM_CD = MTGL.ITEM_CD                                                                                                               \n");
			sbSql.append("                                                           AND PODT.PR_NO   = PRDT.PR_NO(+)                                                                                                              \n");
			sbSql.append("                                                           AND PODT.PR_LNO  = PRDT.PR_LNO(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = PRDT.SYS_ID(+)                                                                                                             \n");
			sbSql.append("                                                           AND PODT.COMP_CD = PRDT.COMP_CD(+)                                                                                                            \n");
			sbSql.append("                                                           AND PODT.SYS_ID  = '100'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.COMP_CD = 'HFC'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.SHOP_TYP_CD = '02'                                                                                                                 \n");
			sbSql.append("                                                           --AND POHD.STS    <> 'D'                                                                                                                    \n");
			sbSql.append("                                                           AND PODT.STS    <> 'D'                                                                                                                      \n");
			sbSql.append("                                                           --AND PRDT.STS    <> 'D'                                                                                                                    \n");
			sbSql.append("                                                           AND POHD.PO_TYP = 'BP'                                                                                                                      \n");
			if (!sUpjang.equals("")){		
				sbSql.append("   AND SAL.SHOP_CD  = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");	
			}
			//sbSql.append("                                                           AND SAL.SHOP_CD  IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG =  " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ")                                                               \n");
			sbSql.append("                                                           AND  SAL.CUST_GR_DATE BETWEEN  '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' ) A   \n");
			sbSql.append("        , HLDC_PO_ITEM_MST B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");	
			
			sbSql.append("     , (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0037') B --HLDC_PO_LINE_STATUS_V B \n");
			sbSql.append("     , ( \n");   
			sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
			sbSql.append("           FROM FMU_OP_RATE \n");
			sbSql.append("          WHERE USE_YN = 'Y' \n");
			sbSql.append("            AND ITEM_TYPE = 'M' \n");
			sbSql.append("       ) C \n");
			sbSql.append("     , ( \n");        
			sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
			sbSql.append("           FROM FMU_OP_RATE \n");
			sbSql.append("          WHERE USE_YN = 'Y' \n");
			sbSql.append("            AND ITEM_TYPE = 'C' \n");
			sbSql.append("       ) D \n");
			
			sbSql.append(" WHERE A.LINE_STATUS = B.CODE \n");
			sbSql.append("   AND A.RC_UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.RC_UPJANG = D.UPJANG(+) \n");
			sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
			sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
			if (!sUpjang.equals("")){		
				sbSql.append("   AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");	
			}
			
			//sbSql.append("   AND A.RC_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + ") \n");
			
			if (!sSubinv_code.equals("")){		
				sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
			}
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			sbSql.append("   AND (A.ADJUST_QTY + A.CENTER_UNDELI_QTY + A.UNDELIVERED_QTY + A.RETURNED_QTY) > 0 \n");
			sbSql.append("   GROUP BY A.RC_UPJANG, A.NEED_DATE, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.ORIGIN_TYPE,  \n");
		    sbSql.append("     B.CODE_NAME, B.CODE,                                                                 \n");
		    sbSql.append("     A.ADJUST_QTY, A.PO_QTY, A.CENTER_UNDELI_QTY, A.TAX_CODE ,                            \n");
		    sbSql.append("     A.UNDELIVERED_QTY, A.RETURNED_QTY, A.DELIVERED_QTY, A.SALE_PRICE,                    \n");
		    sbSql.append("    C.OP_PRICE, C.OP_RATE, C.CEIL_VAL, D.OP_PRICE, D.OP_RATE, D.CEIL_VAL                  \n");
		sbSql.append(") T \n");
		//sbSql.append(" GROUP BY T.NEED_DATE, T.ITEM_CODE, T.ITEM_NAME, T.ITEM_SIZE, T.PO_UOM, T.PR_QTY, T.IN_QTY, T.OP_PRICE, T.RTN_QTY, T.TAX_CODE \n");
		sbSql.append(" GROUP BY T.RC_UPJANG, T.NEED_DATE, T.ITEM_CODE, T.ITEM_NAME, T.ITEM_SIZE, T.PO_UOM, T.PR_QTY, T.IN_QTY, T.OP_PRICE, T.RTN_QTY, T.TAX_CODE, T.LINE_STATUS, T.ORIGIN_TYPE \n");
		sbSql.append(" ORDER BY T.RC_UPJANG, T.NEED_DATE, T.ITEM_CODE \n");
				
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_list);
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