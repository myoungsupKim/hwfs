<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/구매신청/구매신청서작성/식자재구매신청-자재추가
■ 프로그램ID   : FSP00032E_T004.jsp
■ 프로그램명   : 자재추가
■ 작성일자     : 2008-01-28
■ 작성자       : 김동표
■ 이력관리     : 2008-01-28
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
기획자재 배분 안함, 기획자재(명칭이 ▶으로 시작)인 경우 조회상단에 뜨게.
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    
    Statement stmt  =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);  
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();
        
        //jsp log 서비스 시작 
        logger.startIndividualLog(in_vl.getString("titLogId"));     
        
        DataSet ds_favor_cond = in_dl.get("ds_favor_cond");
        
        String EXPT_UPJANG_YN = nullToBlank(ds_favor_cond.getString(0, "EXPT_UPJANG_YN"));   // 추가구매승인제외업장YN
        String APPROV_YN      = nullToBlank(ds_favor_cond.getString(0, "APPROV_YN"));   // 추가구매승인YN
        String PR_DATE        = nullToBlank(ds_favor_cond.getString(0, "PR_DATE"));
        String NEED_DATE      = nullToBlank(ds_favor_cond.getString(0, "NEED_DATE"));
        String SUBINV_CODE    = nullToBlank(ds_favor_cond.getString(0, "SUBINV_CODE"));
        String FAVOR_GROUP    = nullToBlank(ds_favor_cond.getString(0, "FAVOR_GROUP"));
        String ITEM_CODE      = nullToBlank(ds_favor_cond.getString(0, "ITEM_CODE"));
        String PO_TYPE        = nullToBlank(ds_favor_cond.getString(0, "PO_TYPE"));
        
        DataSet ds_info;
        StringBuffer sbSelSql = new StringBuffer();
        
        sbSelSql.delete(0, sbSelSql.length());
        
        sbSelSql.append("SELECT A.UPJANG, B.AP_UNITPRICE_UPJANG, C.CENTER_CODE               \n");
        sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY A, ST_UPJANG B, HLDC_PO_UPJANG_CENTER C \n");
        sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                          \n");
        sbSelSql.append("   AND B.AP_UNITPRICE_UPJANG = C.UPJANG                             \n");
        sbSelSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "'                        \n");     

        stmt = conn.createStatement();      
        rs = stmt.executeQuery(sbSelSql.toString());
        
        ds_info = this.makeDataSet(rs,"ds_info");
        
        rs.close();
        stmt.close();
        
        //업장정보가 없으면 빽~
        if (ds_info.getRowCount() < 1)
        {
            this.setResultMessage(-1, "센터 및 단가계약업장 미설정!",out_vl);
            proc_output(response,out,out_vl,out_dl);
            return;
        }
        
        String AP_UNITPRICE_UPJANG = nullToBlank(ds_info.getString(0,"AP_UNITPRICE_UPJANG"));
        String CENTER_CODE         = nullToBlank(ds_info.getString(0,"CENTER_CODE"));
        String UPJANG              = nullToBlank(ds_info.getString(0,"UPJANG"));
        
        sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("\n																																														\n");
		sbSelSql.append("SELECT	A.ITEM_CODE													 /* 자재코드 */																										\n");
		sbSelSql.append("	  ,	A.ITEM_NAME													 /* 자재명 */																										\n");
		sbSelSql.append("	  ,	A.ITEM_CLASS4												 /* 자재세분류코드 */																								\n");
		sbSelSql.append("	  ,	A.ITEM_SIZE													 /* 자재규격 */																										\n");
		sbSelSql.append("	  ,	A.DUTY_YN												     /* 기획 */																											\n");
		sbSelSql.append("	  ,	A.PB_YN												         /* PB상품 */																										\n");
		sbSelSql.append("	  ,	A.ECO_ITEM												     /* 친환경 */																										\n");
		sbSelSql.append("     , FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, '" + NEED_DATE + "'), A.PB_YN, A.ECO_ITEM, A.MANUF_CD) AS FEATURE_NAME								\n");
		sbSelSql.append("	  ,	A.PO_UOM													 /* 자재단위 */																										\n");
		sbSelSql.append("	  ,	0 KG_QTY													 /* 그램갯수 */																										\n");
		sbSelSql.append("	  ,	0 AS CANCEL_PR_QTY											 /* 구매취소량 */																									\n");
		sbSelSql.append("	  ,	ROUND(A.MARGIN_PRICE / A.KG_CONVERT_RATE / 1000,2) G_PRICE	 /* 그램당 가격	*/																									\n");
		sbSelSql.append("	  ,	0 AS PR_QTY													 /* 구매량 */																										\n");
		sbSelSql.append("	  ,	0 AS PR_AMT													 /* 구매금액 */																										\n");
		sbSelSql.append("	  ,	0 AS TOT_AMT												 /* TOT_AMT	= MARGIN_PRICE * PR_QTY	(화면에서 계산)	*/																\n");
		sbSelSql.append("	  ,	A.TAX_CODE													 /* 과/면세	*/																										\n");
		sbSelSql.append("	  ,	A.CENTER_FLAG												 /* 센터경유 */																										\n");
		sbSelSql.append("	  ,	A.PR_REMARK													 /* 비고 */																											\n");
		sbSelSql.append("	  ,	A.REMARK													 /* 비고 */																											\n");
		sbSelSql.append("	  ,	A.POINT_FLAG												 /* 소수점구매여부 */																								\n");
		sbSelSql.append("	  ,	'" + SUBINV_CODE + "' SUBINV_CODE							 /* 창고코드 */																										\n");
		sbSelSql.append("	  ,	'" + NEED_DATE	 + "' NEED_DATE								 /* 입고일자 */																										\n");
		sbSelSql.append("	  ,	A.UPJANG													 /* 업장코드 */																										\n");
		sbSelSql.append("	  ,	B.DEPT_ID													 /* 부서코드 */																										\n");
		sbSelSql.append("	  ,	A.ACCTCD													 /* 입고 계정 코드(대표) : MATERIAL_ACCTCD */																		\n");
		sbSelSql.append("	  ,	A.BUD_CLS													 /* 예산 조직 cc 코드 :	BUDCC_CD */																					\n");
		sbSelSql.append("	  ,	B.MU_CD														 /* 사업부코드 */																									\n");
		sbSelSql.append("	  ,	A.INVAT_FLAG												 /* */																												\n");
		sbSelSql.append("	  ,	A.OUTVAT_FLAG												 /* */																												\n");
		sbSelSql.append("	  ,	A.MIN_ORD_QTY												 /* 최소발주량 */																									\n");
		sbSelSql.append("	  ,	A.MAX_ORD_QTY												 /* 최대발주량 */																									\n");
		sbSelSql.append("	  ,	A.CENTER_CODE												 /* 센터코드 */																										\n");
		sbSelSql.append("	  ,	A.STOCK_FLAG												 /* */																												\n");
		sbSelSql.append("	  ,	A.BARCODE													 /* 바코드 */																										\n");
		sbSelSql.append("	  ,	A.KEEPING_TYPE												 /* 보관타입 */																										\n");
		sbSelSql.append("	  ,	NVL(A.MULTIPLIER_QTY, 0) AS MULTIPLIER_QTY											 /* 발주승수량 */																			\n");
		sbSelSql.append("	  ,	A.BUD_CLS AS BUDDEPT_ID										 /* 예산 조직 cc 코드 :	BUDCC_CD - 고도화에서 부서코드가 CC로 대체됨 */												\n");
		sbSelSql.append("	  ,	A.USE_YN													 /* ??	*/																											\n");
		sbSelSql.append("	  ,	DECODE(A.CUSTCD, NULL, 'N',	'Y') AS	CONTRACT_YN				 /* 계약YN */																										\n");
		sbSelSql.append("	  ,	NVL(A.MARGIN_PRICE,	0) AS MARGIN_PRICE						 /* 출하율적용단가 */																								\n");
		sbSelSql.append("	  ,	A.UNIT_PRICE												 /* 구매(매입)단가 */																								\n");
		sbSelSql.append("	  ,	A.CUSTCD													 /* 매입거래처코드 */																								\n");
		sbSelSql.append("	  ,	A.KG_CONVERT_RATE											 /* kg환산율 */																										\n");
		sbSelSql.append("	  ,	A.MARGIN_RATE												 /* 마진비율 */																										\n");
		sbSelSql.append("	  ,	A.AP_UNITPRICE_UPJANG										 /* 업장코드 */																										\n");
		sbSelSql.append("	  ,	D.RESTRICT_PERIOD											 /* 금지기간 */																										\n");
		sbSelSql.append("	  ,	D.RESTRICT_REASON											 /* 금지사유 */																										\n");
		sbSelSql.append("	  ,	NULL DUTY_END_DATE											 /* */																												\n");
		sbSelSql.append("	  ,	0 MIN_DUTY_QTY												 /* */																												\n");
		sbSelSql.append("	  ,	0 DUTY_QTY													 /* */																												\n");
		sbSelSql.append("	  ,	0 REAL_USE_QTY												 /*실사용갯수 */																									\n");
		sbSelSql.append("     , NVL(G.PR_YN, 'Y') AS PR_YN																																						\n");
		sbSelSql.append("     , G.SCH_INFO																																										\n");
		sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', F.OPER_ORG_SN_PURC, A.UPJANG_GRP, A.ITEM_CODE, '" + NEED_DATE +	"')	= 'CK' THEN 'Y' ELSE 'N' END 					\n");
		sbSelSql.append("                                                    AS SHP_MAP  /* 자재 업장군 맵핑 유효성 체크 CE : 맵핑안되어있음(사용불가), CK : 맵핑되어있음(사용가능) */							\n");
		sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) = 'UP' THEN 'Y' ELSE 'N' END  																					\n");
		sbSelSql.append("                                                    AS MTG_UNS      /* 자재불용체크 UK: 불용, UP:불용아님, NN: DATA NOT FOUND */														\n");
		sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') = 'TP' THEN 'Y' ELSE 'N' END 																				\n");
		sbSelSql.append("                                                    AS MTG_STP      /* 자재 중지체크 TK : 중지(사용불가), TP : 중지아님(사용가능), NN: DATA NOT FOUND */								\n");
		sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', '" + NEED_DATE +    "') = 'XR' THEN 'Y' ELSE 'N' END 										\n");
		sbSelSql.append("                                                    AS REQ_WKD      /* 요일별 신청불가 체크 XE : 신청불가(사용불가), XR : 신청가능(사용가능), NN : DATA NOT FOUND */					\n");
		sbSelSql.append("     , CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', NVL(C.D_DAY, 0), NVL(C.D_TIMES, 0), '"+ PR_DATE+"', '" +	NEED_DATE +	"') = 'HK' THEN 'Y' ELSE 'N' END 							\n");
		sbSelSql.append("                                                    AS SCH          /* 수발주 스케쥴에 따른 유효성 체크 HE : 신청불가(사용불가), HK : 신청가능(사용가능), NN : DATA NOT FOUND */		\n");
		sbSelSql.append("	  ,	NVL(C.D_DAYS,0)	+ 1	AS D_DAY								 /*D-DAY */																											\n");
		sbSelSql.append("	  ,	DECODE(C.D_DAYS,NULL,	0, DECODE(SIGN(TO_DATE('" +	NEED_DATE +	"',	'YYYYMMDD')	- TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'),	'YYYYMMDD')	- NVL(C.D_DAYS,0) -	1) , 0,					\n");
		sbSelSql.append("								   DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0,	24,	C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,	'HH24'))), 1, 0, 1), 0)	+ NVL(C.D_DAYS,	0) + 1)					\n");
		sbSelSql.append("								   AS D_DAYS						 /* D_DAYS */																										\n");
		sbSelSql.append("	  ,	DECODE(C.D_DAYS,NULL,	0, DECODE(C.D_TIMES, '', 24, 0,	24,	C.D_TIMES))																											\n");
		sbSelSql.append("								   AS D_TIMES						 /* DAYYN */																										\n");
		sbSelSql.append("	  ,	DECODE(C.D_DAYS,NULL, 'Y', DECODE(SIGN(TO_DATE('" +	NEED_DATE +	"',	'YYYYMMDD')	- TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'),	'YYYYMMDD')	- NVL(C.D_DAYS,0)) ,-1,	'N', 0,			\n");
		sbSelSql.append("								   DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0,	24,	C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,	'HH24'))), -1, 'N',	0, 'N',	'C'), 1, 'Y'))						\n");
		sbSelSql.append("								   AS D_DAY_YN						 /* DAYYN */																										\n");
		sbSelSql.append("	  ,	A.SPICE_YN													 /* 양념YN */																										\n");
		sbSelSql.append("	  ,	A.CORN_YN													 /* 미곡YN */																										\n");
		sbSelSql.append("	  ,	A.IMG_PATH													 /* 이미지 */																										\n");
		sbSelSql.append("	  ,	A.ORIGIN_NAT												 /* 원산지국가 */																					\n");
		sbSelSql.append("	  ,	A.ORIGIN_TYPE												 /* 원산지타입 */																					\n");
		sbSelSql.append("	  ,	A.VD_SN														 /* 구매요청값 */																					\n");
		sbSelSql.append("	  ,	A.APPLY_SD													 /* 구매요청값 */																					\n");
		sbSelSql.append("	  ,	''	AS MOBILE_GUBUN											 /* 모바일구분 */																					\n");
		sbSelSql.append("	  ,	A.UPJANG_GRP    											 /* 업장군 */																				        \n");
		sbSelSql.append("	  , '삭제하기' AS FAVORITE    											 /* 즐겨찾기 삭제 */																				        \n");
		sbSelSql.append("  FROM (                                                                                                                                                               \n");
        sbSelSql.append("        SELECT  C.ITEM_CODE                                                                                                                                            \n");
        sbSelSql.append("              , C.ITEM_NAME                                                                                                                                            \n");
        sbSelSql.append("              , C.ITEM_CLASS1                                                                                                                                          \n");
        sbSelSql.append("              , C.ITEM_CLASS4                                                                                                                                          \n");
        sbSelSql.append("              , C.ITEM_SIZE                                                                                                                                            \n");
        sbSelSql.append("              , C.PO_UOM                                                                                                                                               \n");
        sbSelSql.append("              , C.TAX_CODE                                                                                                                                             \n");
        sbSelSql.append("              , A.PROC_TYP_CD  AS CENTER_FLAG					                                                                                                        \n");
        sbSelSql.append("              , '' AS PR_REMARK                                                                                                                                           \n");
        sbSelSql.append("              , '' AS REMARK                                                                                                                                           \n");
        sbSelSql.append("              , C.POINT_FLAG                                                                                                                                           \n");
        sbSelSql.append("              , B.UPJANG                                                                                                                                               \n");
        sbSelSql.append("              , B.INVAT_FLAG                                                                                                                                           \n");
        sbSelSql.append("              , B.OUTVAT_FLAG                                                                                                                                          \n");
        sbSelSql.append("              , C.MIN_ORD_QTY                                                                                                                                          \n");
        sbSelSql.append("              , C.MAX_ORD_QTY                                                                                                                                          \n");
        sbSelSql.append("              , A.CENTER_CODE      /* 센터코드 */                                                                                                                      \n");
        sbSelSql.append("              , B.STOCK_FLAG                                                                                                                                           \n");
        sbSelSql.append("              , C.KEEPING_TYPE                                                                                                                                         \n");
        sbSelSql.append("              , C.BARCODE                                                                                                                                              \n");
        sbSelSql.append("              , C.MULTIPLIER_QTY                                                                                                                                       \n");
        sbSelSql.append("              , C.USE_YN                                                                                                                                               \n");
        sbSelSql.append("              , TO_NUMBER(DECODE(A.MARGIN_RATE, 0, A.CONTRACT_PRICE, (ROUND((A.CONTRACT_PRICE + (A.CONTRACT_PRICE * A.MARGIN_RATE / 100)) / 10) * 10))) AS MARGIN_PRICE  \n");
        sbSelSql.append("              , A.CONTRACT_PRICE AS UNIT_PRICE       /* 구매(매입)단가 */                                                                                              \n");
        sbSelSql.append("              , A.CUSTCD           /* 매입거래처코드 */                                                                                                                \n");
        sbSelSql.append("              , NVL(C.KG_CONVERT_RATE, 1) KG_CONVERT_RATE                                                                                                              \n");
        sbSelSql.append("              , A.MARGIN_RATE                                                                                                                                          \n");
        sbSelSql.append("              , A.UPJANG AS AP_UNITPRICE_UPJANG                                                                                                                        \n");
        sbSelSql.append("              , C.SPICE_YN                                                                                                                                             \n");
        sbSelSql.append("              , C.CORN_YN                                                                                                                                              \n");
        sbSelSql.append("              , C.IMG_PATH                                                                                                                                             \n");
        sbSelSql.append("              , C.ORIGIN_NAT                                                                                                                                           \n");
        sbSelSql.append("              , C.ORIGIN_TYPE                                                                                                                                          \n");
        sbSelSql.append("              , B.MATERIAL_ACCTCD AS ACCTCD                                                                                                                            \n");
        sbSelSql.append("              , B.BUDCC_CD AS BUD_CLS                                                                                                                                  \n");
        sbSelSql.append("              , A.DUTY_YN                                                                                                                                              \n");
        //PB_YN을 계약에서 가져옴 (2015.08.29)
        sbSelSql.append("              , A.PB_YN                                                                                                                                                \n");
        sbSelSql.append("              , C.MANUF_CD                                                                                                                                             \n");
        sbSelSql.append("              , C.ECO_ITEM                                                                                                                                             \n");
        sbSelSql.append("              , A.VD_SN                                                                                                                                                \n");
        sbSelSql.append("              , A.APPLY_SD                                                                                                                                             \n");
        sbSelSql.append("			   , A.UPJANG_GRP																																			\n");
        sbSelSql.append("           FROM HLDC_PO_CONTRACT_F A                                                                                                                                   \n");
        sbSelSql.append("              , HLDC_PO_SUBINVENTORY B                                                                                                                                 \n");
        sbSelSql.append("              , HLDC_PO_ITEM_MST C                                                                                                                                     \n");
        sbSelSql.append("              , FSP_FAVORITE D                                                                                                                                         \n");
        sbSelSql.append("          WHERE A.UPJANG       = B.UPJANG                                                                                                                              \n");
        sbSelSql.append("            AND A.ITEM_CODE    = C.ITEM_CODE                                                                                                                           \n");
        sbSelSql.append("            AND A.UPJANG       = "  + UPJANG      + "                                                                                                                  \n");
        sbSelSql.append("			 AND '" + NEED_DATE + "' BETWEEN A.CONTRACT_START	 AND A.CONTRACT_END																						\n");
        sbSelSql.append("            AND B.SUBINV_CODE  = '" + SUBINV_CODE + "'                                                                                                                 \n");
        sbSelSql.append("            AND D.UPJANG       = A.UPJANG                                                                                                                              \n");
        sbSelSql.append("            AND D.ITEM_CODE    = A.ITEM_CODE                                                                                                                           \n");
        sbSelSql.append("            AND D.FAVOR_GROUP  = '" + FAVOR_GROUP + "'                                                                                                                 \n");
        
        if(!ITEM_CODE.equals(""))
        {
	        sbSelSql.append("            AND (   C.ITEM_CODE   =    '" + ITEM_CODE + "'                                                                                                         \n");
	        sbSelSql.append("                 OR C.ITEM_NAME   LIKE '%' ||'" + ITEM_CODE + "' || '%'                                                                                            \n");
	        sbSelSql.append("                )                                                                                                                                                  \n");
    	}
       
        // 추가구매신청승인이 안된 업장이거나 승인예외업장이 아닌경우 양념 미곡만 조회
        if(!APPROV_YN.equals("Y") && !EXPT_UPJANG_YN.equals("Y"))
        {
        	sbSelSql.append("            AND (   C.SPICE_YN   =  'Y'                                                                                                                           \n");
	        sbSelSql.append("                 OR C.CORN_YN    =  'Y'                                                                                                      					   \n");
	        sbSelSql.append("                )                                                                                                                                                 \n");
        }
/*      
        if (!PR_NUM.equals(""))       //수정의 경우 이미 삭제한 자재에 대한 레피시 자재는 다시 불러오지 않는다. 2008/09/24 박은규 이명희
            sbSelSql.append("                   AND NOT EXISTS (SELECT 1 FROM SO_PR_MENU_LOG Z WHERE Z.PR_NUM = '" + PR_NUM + "' AND Z.ITEM_CODE = C.ITEM_CODE)                                 \n");
        if(TYPE.equals("CANCEL_UPDATE"))   //취소재작성의 경우 취소목록에 있는건 다시 부르지 않는다. 2008/10/21 박은규 이명희
            sbSelSql.append("                   AND NOT EXISTS (SELECT 1 FROM SO_PR Z WHERE Z.PR_NUM = '" + PR_NUM + "' AND Z.ITEM_CODE = C.ITEM_CODE)                                          \n");
*/  
        sbSelSql.append("       ) A                                                                                                                                                             \n");
        sbSelSql.append("     , SCO_UPJANG_MST_V B                                                                                                                                              \n");
        sbSelSql.append("     , (SELECT A.CENTER_CODE                                                                                                                                           \n");
        sbSelSql.append("             , A.ITEM_CODE , A.D_DAYS AS D_DAY                                                                                                                         \n");
        sbSelSql.append("             ,(SELECT TO_DATE('" + NEED_DATE + "','YYYYMMDD') -    TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')                                                                  \n");
        sbSelSql.append("                 FROM (SELECT ROW_NUMBER() OVER(ORDER BY Z.CD_SY||Z.CD_SM||Z.CD_SD DESC) AS    SEQ                                                                     \n");
        sbSelSql.append("                            , Z.CD_SY||Z.CD_SM||Z.CD_SD    AS NONHOLI_DATE                                                                                             \n");
        sbSelSql.append("                         FROM SCC_CALENDA_DATA Z                                                                                                                       \n");
        sbSelSql.append("                        WHERE Z.CD_SY||Z.CD_SM||Z.CD_SD    < '" + NEED_DATE + "'                                                                                       \n");
        sbSelSql.append("                          AND Z.CD_SY BETWEEN TO_NUMBER(SUBSTR('" +    NEED_DATE + "', 1, 4)) - 1 AND TO_NUMBER(SUBSTR('" + NEED_DATE + "', 1, 4))                     \n");
        sbSelSql.append("                      --  AND Z.HOLIDAY    NOT IN (1,2) --일요일 제외한 국가 공휴일 (일요일만 체크, 그 외 공유일은 상관없음(김진희))                                   \n");
        sbSelSql.append("                          AND Z.CD_WEEK    NOT IN ('일')) Z                                                                                                            \n");
        sbSelSql.append("                WHERE Z.SEQ    = A.D_DAYS ) AS D_DAYS                                                                                                                  \n");
        sbSelSql.append("             , A.D_TIMES                                                                                                                                               \n");
        sbSelSql.append("          FROM HLDC_PO_PREORDER_LIST A                                                                                                                                 \n");
        sbSelSql.append("         WHERE A.CENTER_CODE = '" + CENTER_CODE + "'                                                                                                                   \n");
        sbSelSql.append("       ) C                      /* 선발주 제한 */                                                                                                                      \n");
        sbSelSql.append("     , (                                                                                                                                                               \n");
        sbSelSql.append("        SELECT UPJANG                                                                                                                                                  \n");
        sbSelSql.append("             , ITEM_CODE                                                                                                                                               \n");
        sbSelSql.append("             , TO_CHAR(TO_DATE(RESTRICT_START, 'YYYYMMDD'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(RESTRICT_END, 'YYYYMMDD'), 'YYYY.MM.DD') AS RESTRICT_PERIOD        \n");
        sbSelSql.append("             , RESTRICT_REASON                                                                                                                                         \n");
        sbSelSql.append("          FROM FSI_RESTRICT_SET                                                                                                                                        \n");
        sbSelSql.append("         WHERE UPJANG = " + UPJANG + "                                                                                                                                 \n");
        sbSelSql.append("           AND (RESTRICT_START <= '" + NEED_DATE + "' AND RESTRICT_END >= '" + NEED_DATE + "')                                                                         \n");
        sbSelSql.append("           AND NOT (CNL_START IS NOT NULL AND CNL_START  <= '" + NEED_DATE + "' AND CNL_END      >= '" + NEED_DATE + "')                                               \n");
        sbSelSql.append("       ) D                      /* 금지자재 */                                                                                                                         \n");
        sbSelSql.append("     , VO_CENTER F                                                                                                                                                     \n");
        sbSelSql.append("     , (SELECT /*+ INDEX(Z.MR ESPSSGPITM_PK) */ CENTER_CODE, CUSTCD, ITEM_CODE, 'N' PR_YN \n");
		sbSelSql.append("             , DECODE(NVL(MON,'N'),'N','월 ') \n");
		sbSelSql.append("             ||DECODE(NVL(TUE,'N'),'N','화 ') \n");
		sbSelSql.append("             ||DECODE(NVL(WED,'N'),'N','수 ') \n");
		sbSelSql.append("             ||DECODE(NVL(THU,'N'),'N','목 ') \n");
		sbSelSql.append("             ||DECODE(NVL(FRI,'N'),'N','금 ') \n");
		sbSelSql.append("             ||DECODE(NVL(SAT,'N'),'N','토 ') \n");
		sbSelSql.append("             ||DECODE(NVL(SUN,'N'),'N','일') AS SCH_INFO \n");
		sbSelSql.append("          FROM HLDC_PO_ORDER_SCHEDULE Z \n");
		sbSelSql.append("         WHERE CENTER_CODE = " + CENTER_CODE + " \n");
		sbSelSql.append("           AND UPJANG =  " + AP_UNITPRICE_UPJANG + " \n");
		sbSelSql.append("           AND USE_YN = 'Y' \n");
		sbSelSql.append("           AND UPJANG_TYPE  = '01' \n");
		sbSelSql.append("           AND DECODE(TO_CHAR(TO_DATE('" + NEED_DATE + "','YYYYMMDD'),'D'), \n");
		sbSelSql.append("                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
		sbSelSql.append("        UNION ALL \n");
		sbSelSql.append("        ( \n");
		sbSelSql.append("        SELECT /*+ INDEX(Z.MR ESPSSGPITM_PK) */ CENTER_CODE, CUSTCD, ITEM_CODE, 'N' \n");
		sbSelSql.append("             , DECODE(NVL(MON,'N'),'N','월 ') \n");
		sbSelSql.append("             ||DECODE(NVL(TUE,'N'),'N','화 ') \n");
		sbSelSql.append("             ||DECODE(NVL(WED,'N'),'N','수 ') \n");
		sbSelSql.append("             ||DECODE(NVL(THU,'N'),'N','목 ') \n");
		sbSelSql.append("             ||DECODE(NVL(FRI,'N'),'N','금 ') \n");
		sbSelSql.append("             ||DECODE(NVL(SAT,'N'),'N','토 ') \n");
		sbSelSql.append("             ||DECODE(NVL(SUN,'N'),'N','일') AS SCH_INFO \n");
		sbSelSql.append("          FROM HLDC_PO_ORDER_SCHEDULE Z \n");
		sbSelSql.append("         WHERE CENTER_CODE = " + CENTER_CODE + " \n");
		sbSelSql.append("           AND UPJANG = -1 \n");
		sbSelSql.append("           AND USE_YN = 'Y' \n");
		sbSelSql.append("           AND UPJANG_TYPE  = '01' \n");
		sbSelSql.append("           AND DECODE(TO_CHAR(TO_DATE('" + NEED_DATE + "','YYYYMMDD'),'D'), \n");
		sbSelSql.append("                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
		sbSelSql.append("        MINUS \n");
		sbSelSql.append("        SELECT /*+ INDEX(Z.MR ESPSSGPITM_PK) */ CENTER_CODE, CUSTCD, ITEM_CODE, 'N' \n");
		sbSelSql.append("             , DECODE(NVL(MON,'N'),'N','월 ') \n");
		sbSelSql.append("             ||DECODE(NVL(TUE,'N'),'N','화 ') \n");
		sbSelSql.append("             ||DECODE(NVL(WED,'N'),'N','수 ') \n");
		sbSelSql.append("             ||DECODE(NVL(THU,'N'),'N','목 ') \n");
		sbSelSql.append("             ||DECODE(NVL(FRI,'N'),'N','금 ') \n");
		sbSelSql.append("             ||DECODE(NVL(SAT,'N'),'N','토 ') \n");
		sbSelSql.append("             ||DECODE(NVL(SUN,'N'),'N','일') AS SCH_INFO \n");
		sbSelSql.append("          FROM HLDC_PO_ORDER_SCHEDULE Z \n");
		sbSelSql.append("         WHERE CENTER_CODE = " + CENTER_CODE + " \n");
		sbSelSql.append("           AND UPJANG = " + AP_UNITPRICE_UPJANG + " \n");
		sbSelSql.append("           AND USE_YN = 'Y' \n");
		sbSelSql.append("           AND UPJANG_TYPE  = '01' \n");
		sbSelSql.append("           AND DECODE(TO_CHAR(TO_DATE('" + NEED_DATE + "','YYYYMMDD'),'D'), \n");
		sbSelSql.append("                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y' \n");
		sbSelSql.append("        ) \n");
		sbSelSql.append("       ) G \n");
        sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                                                             \n");
        sbSelSql.append("   AND A.CENTER_CODE = C.CENTER_CODE(+)                                                                                                                                \n");
        sbSelSql.append("   AND A.ITEM_CODE   = C.ITEM_CODE  (+)                                                                                                                                \n");
        sbSelSql.append("   AND A.ITEM_CODE   = D.ITEM_CODE  (+)                                                                                                                                \n");
        sbSelSql.append("	AND	A.CENTER_CODE =	F.CENTER_CODE (+)																																\n");
        sbSelSql.append("	AND	A.ITEM_CODE	  =	G.ITEM_CODE	 (+)																																\n"); 
        //구매유형에 따라 상품/식음료 구분 추가 2017.10.10 이혜은과장 요청
        if(PO_TYPE.equals("11") || PO_TYPE.equals("88")) {        	
        	 sbSelSql.append("	AND	A.ITEM_CLASS1	= 'G'																															\n"); 	
	    } else {
	    	 sbSelSql.append("	AND	A.ITEM_CLASS1	= 'F'																															\n"); 
	    }
        sbSelSql.append(" ORDER BY A.ITEM_CLASS4, A.ITEM_NAME, A.ITEM_CODE                                                                                                                                                  \n");
        sbSelSql.append("\n                                                                                                                                                                     \n");
        
        stmt = conn.createStatement();      
        rs = stmt.executeQuery(sbSelSql.toString());
        
        DataSet ds_out = this.makeDataSet(rs,"ds_out");
        out_dl.add(ds_out);
        
        this.setResultMessage(0, "OK",out_vl);
        
    } catch(Exception ex) {
        ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);         
        this.setResultMessage(-1, ex.toString(),out_vl);
        } finally {
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