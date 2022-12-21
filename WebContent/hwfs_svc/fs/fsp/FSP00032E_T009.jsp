<%
/*-----------------------------------------------------------------------------
■ 시스템명	   : 구매관리/구매신청/구매신청서작성/식자재구매신청(자동)
■ 프로그램ID   : FSP00032E_T009.jsp
■ 프로그램명   : 식자재구매신청조회(삭제재작성 업데이트	신청서 자재조회)
■ 작성일자	   : 2015-06-01
■ 작성자	   : 정영철
■ 이력관리	   : 2015-06-01
-----------------------------------------------------------------------------*/
%>

<%@	page contentType="text/html; charset=EUC-KR" %>
<%@	include	file = "../../sc/main/common.jsp" %>
<%@page import="java.math.BigDecimal"%>
<%
	Statement stmt			   =  null;
	try	{
		PlatformRequest	platformRequest	= this.proc_input(request);
		in_vl =	platformRequest.getData().getVariableList();
		in_dl =	platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet	ds_condi	= in_dl.get("ds_condi");

		String TYPE			= nullToBlank(ds_condi.getString(0,	"TYPE"));
		String PR_NUM		= nullToBlank(ds_condi.getString(0,	"PR_NUM"));
		String NEED_DATE	= nullToBlank(ds_condi.getString(0,	"NEED_DATE"));
		String PR_DATE		= nullToBlank(ds_condi.getString(0,	"PR_DATE"));
		String SUBINV_CODE	= nullToBlank(ds_condi.getString(0,	"SUBINV_CODE"));

		DataSet	ds_info, ds_out;
		StringBuffer sbSelSql =	new	StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT	A.UPJANG																				\n");
		sbSelSql.append("	  ,	B.AP_UNITPRICE_UPJANG																	\n");
		sbSelSql.append("	  ,	c.CENTER_CODE																			\n");
		sbSelSql.append("  FROM	HLDC_PO_SUBINVENTORY A																	\n");
		sbSelSql.append("	  ,	ST_UPJANG B																				\n");
		sbSelSql.append("	  ,	HLDC_PO_UPJANG_CENTER C																	\n");
		sbSelSql.append(" WHERE	A.UPJANG = B.UPJANG																		\n");
		sbSelSql.append("	AND	B.AP_UNITPRICE_UPJANG =	C.UPJANG														\n");
		//sbSelSql.append("	AND	SUBINV_CODE	= '" + SUBINV_CODE + "'														\n");
		sbSelSql.append("	AND	SUBINV_CODE	= :SUBINV_CODE	    														\n");

		//20180514 김호석 쿼리 변수 바인딩기능 추가
		
        npstmt = new NamedParameterStatement(conn, sbSelSql.toString());

        npstmt.setString("SUBINV_CODE", SUBINV_CODE);
                
        rs = npstmt.executeQuery();
     	//20180514 김호석 쿼리 변수 바인딩기능 추가
		
		//stmt = conn.createStatement();
		//rs = stmt.executeQuery(sbSelSql.toString());

		ds_info	= this.makeDataSet(rs,"ds_info");

		rs.close();
		//stmt.close();
		npstmt.close();


		String UPJANG			   = ds_info.getString(0,"UPJANG");
		String CENTER_CODE		   = ds_info.getString(0,"CENTER_CODE");
		String AP_UNITPRICE_UPJANG = ds_info.getString(0,"AP_UNITPRICE_UPJANG");

		if(nullToBlank(UPJANG).equals(""))
		{
				out_vl.add("v_out",	"창고에	업장이 연결되지	않았습니다.\n구매관리자에게	연락하세요.");
				this.setResultMessage(0, "OK",out_vl);
				return;
		}
		else if(nullToBlank(AP_UNITPRICE_UPJANG).equals(""))
		{
				out_vl.add("v_out",	"단가계약업장이	연결되지 않았습니다.\n구매관리자에게 연락하세요.");
				this.setResultMessage(0, "OK",out_vl);
				return;
		}
		else if(nullToBlank(CENTER_CODE).equals(""))
		{
				out_vl.add("v_out",	"센터에	업장이 연결되지	않았습니다.\n구매관리자에게	연락하세요.");
				this.setResultMessage(0, "OK",out_vl);
				return;
		}

/* 		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT	PHYSIC_DATE, SUBSTR(PHYSIC_DATE,5,2) ||	'-'	|| SUBSTR(PHYSIC_DATE,7,2) || '\n재고량' ONHAND_TITLE				 \n");
		sbSelSql.append("  FROM																													\n");
		sbSelSql.append("		(																												\n");
		sbSelSql.append("		SELECT NVL(MAX(PHYSIC_DATE)	, '00000000' ) PHYSIC_DATE															\n");
		sbSelSql.append("		  FROM HLDC_PO_PHYSICAL_INVENTORY																				\n");
		sbSelSql.append("		 WHERE SUBINV_CODE = '"	+ SUBINV_CODE +	"'																		\n");
		//조사일 기준일	기준일 경우	아래 주석처리
		sbSelSql.append("		   AND CLOSE_DATE IS NOT NULL																					\n");
		sbSelSql.append("		   AND PHYSIC_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE															\n");
		sbSelSql.append("			   (																										\n");
		sbSelSql.append("					  (																									\n");
		sbSelSql.append("					  SELECT MAX(CLS_YM)																				\n");
		sbSelSql.append("						FROM HLDC_PO_CLOSING																			\n");
		sbSelSql.append("					   WHERE SUBINV_CODE = '" +	SUBINV_CODE	+ "'														\n");
		sbSelSql.append("                        AND CLS_FLAG = 'Z'						                                                        \n");
		sbSelSql.append("					  )	, 'YYYYMM'																						\n");
		sbSelSql.append("			   ) ,1) , 'YYYYMMDD' )																						\n");
		sbSelSql.append("		   AND '" +	NEED_DATE +	"'																						\n");
		sbSelSql.append("		)																												\n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		rs.next();

		String PHYSIC_DATE = rs.getString("PHYSIC_DATE");
		String ONHAND_TITLE	= rs.getString("ONHAND_TITLE");

		rs.close();
		stmt.close();

		out_vl.add("v_OnHandTitle",	ONHAND_TITLE); */

		// 신청내역	조회
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("\n																																										\n");
		sbSelSql.append("SELECT																																									\n");
		sbSelSql.append("      	/*+ USE_HASH(A D E G) PUSH_PRED(C) */ 																															\n");
		sbSelSql.append("      A.PR_NUM																																							\n");
		sbSelSql.append("     , A.ORG_PR_NUM																																					\n");
		sbSelSql.append("	  ,	A.PR_ID																																							\n");
		sbSelSql.append("	  ,	A.ITEM_CODE																																						\n");
		sbSelSql.append("	  ,	A.ITEM_NAME																																						\n");
		sbSelSql.append("	  ,	A.ITEM_CLASS3																																					\n");
		sbSelSql.append("	  ,	A.ITEM_CLASS4																																					\n");
		sbSelSql.append("	  ,	FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, :NEED_DATE),	A.PB_YN, A.ECO_ITEM, A.MANUF_CD) AS	FEATURE_NAME		\n");
		sbSelSql.append("	  ,	A.ITEM_SIZE																																						\n");
		sbSelSql.append("	  ,	A.PO_UOM																																						\n");
		sbSelSql.append("	  ,	A.MENU_QTY AS KG_QTY																																			\n");
//		sbSelSql.append("	  ,	NVL(E.ONHAND_QTY, 0) AS ONHAND_QTY																																\n");
		sbSelSql.append("	  ,	FSP_TRANS_QTY_FUN(:PR_DATE, :SUBINV_CODE, A.ITEM_CODE) AS ONHAND_QTY		     															\n");
		sbSelSql.append("	  ,	0 AS CANCEL_PR_QTY																																				\n");
		sbSelSql.append("	  ,	NVL(A.PR_QTY, 0) AS PR_QTY																																		\n");
		sbSelSql.append("	  ,	0 AS TOT_AMT																																					\n");
		sbSelSql.append("	  ,	ROUND(NVL(A.MARGIN_PRICE / A.KG_CONVERT_RATE / 1000, 0)) AS	G_ITEM_PRICE /*	g당	단가 = 출하율적용단가 /	Kg 환산율 /	1000 */										\n");
		sbSelSql.append("	  ,	A.TAX_CODE																																						\n");
		sbSelSql.append("	  ,	A.CENTER_FLAG																																					\n");
		sbSelSql.append("	  ,	A.PR_REMARK																																						\n");
		sbSelSql.append("	  ,	A.REMARK																																						\n");
		sbSelSql.append("	  ,	A.POINT_FLAG																																					\n");
		sbSelSql.append("	  ,	:SUBINV_CODE AS SUBINV_CODE																																\n");
		sbSelSql.append("	  ,	:NEED_DATE AS NEED_DATE																																	\n");
		sbSelSql.append("	  ,	A.UPJANG																																						\n");
		sbSelSql.append("	  ,	B.DEPT_ID																																						\n");
		sbSelSql.append("	  ,	A.ACCTCD		 /*	입고 계정 코드(대표)  MATERIAL_ACCTCD */																									\n");
		sbSelSql.append("	  ,	A.BUD_CLS		 /*	예산 조직 cc 코드 	BUDCC_CD */																												\n");
		sbSelSql.append("	  ,	B.MU_CD																																							\n");
		sbSelSql.append("	  ,	A.INVAT_FLAG																																					\n");
		sbSelSql.append("	  ,	A.OUTVAT_FLAG																																					\n");
		sbSelSql.append("	  ,	A.MIN_ORD_QTY																																					\n");
		sbSelSql.append("	  ,	A.MAX_ORD_QTY																																					\n");
		sbSelSql.append("	  ,	A.CENTER_CODE	   /* 센터코드 */																																\n");
		sbSelSql.append("	  ,	A.STOCK_FLAG																																					\n");
		sbSelSql.append("	  ,	A.BARCODE																																						\n");
		sbSelSql.append("	  ,	NVL(A.MULTIPLIER_QTY, 0) AS	MULTIPLIER_QTY																														\n");
		sbSelSql.append("	  ,	A.BUD_CLS AS BUDDEPT_ID	 /*	예산 조직 cc 코드 	BUDCC_CD - 고도화에서 부서코드가 CC로 대체됨 */																	\n");
		sbSelSql.append("	  ,	A.USE_YN																																						\n");
		sbSelSql.append("	  ,	NVL(A.MARGIN_PRICE,	0) AS MARGIN_PRICE	   /* 출하율적용단가 */																									\n");
		sbSelSql.append("	  ,	A.UNIT_PRICE	   /* 구매(매입)단가 */																															\n");
		sbSelSql.append("	  ,	A.CUSTCD		   /* 매입거래처코드 */																															\n");
		sbSelSql.append("	  ,	A.KG_CONVERT_RATE																																				\n");
		sbSelSql.append("	  ,	A.MARGIN_RATE																																					\n");
		sbSelSql.append("	  ,	A.AP_UNITPRICE_UPJANG																																			\n");
		sbSelSql.append("	  ,	D.RESTRICT_PERIOD																																				\n");
		sbSelSql.append("	  ,	D.RESTRICT_REASON																																				\n");
		sbSelSql.append("	  ,	NULL DUTY_END_DATE																																				\n");
		sbSelSql.append("	  ,	0 MIN_DUTY_QTY																																					\n");
		sbSelSql.append("	  ,	0 DUTY_QTY																																						\n");
		sbSelSql.append("	  ,	0 REAL_USE_QTY																																					\n");
		sbSelSql.append("	  ,	'' PR_YN																																						\n");
		sbSelSql.append("	  ,	'N' DUP_YN																																						\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', F.OPER_ORG_SN_PURC, A.UPJANG_GRP, A.ITEM_CODE,	:NEED_DATE)	= 'CK' THEN	'Y'	ELSE 'N' END	\n");
		sbSelSql.append("													 AS	SHP_MAP	 /*	자재 업장군	맵핑 유효성	체크 CE	- 맵핑안되어있음(사용불가),	CK - 맵핑되어있음(사용가능)	*/						\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) = 'UP' THEN 'Y' ELSE	'N'	END																					\n");
		sbSelSql.append("													 AS	MTG_UNS		 /*	자재불용체크 UK- 불용, UP-불용아님,	NN-	DATA NOT FOUND */													\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') = 'TP'	THEN 'Y' ELSE 'N' END																			\n");
		sbSelSql.append("													 AS	MTG_STP		 /*	자재 중지체크 TK - 중지(사용불가), TP -	중지아님(사용가능),	NN-	DATA NOT FOUND */							\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', :NEED_DATE) = 'XR' THEN 'Y' ELSE	'N'	END										\n");
		sbSelSql.append("													 AS	REQ_WKD		 /*	요일별 신청불가	체크 XE	- 신청불가(사용불가), XR - 신청가능(사용가능), NN -	DATA NOT FOUND */				\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', NVL(C.D_DAY, 0), NVL(C.D_TIMES, 0), TO_CHAR(SYSDATE, 'YYYYMMDD'), :NEED_DATE)	= 'HK' THEN	'Y'	ELSE 'N' END \n");
		sbSelSql.append("													 AS	SCH			 /*	수발주 스케쥴에	따른 유효성	체크 HE	- 신청불가(사용불가), HK - 신청가능(사용가능), NN -	DATA NOT FOUND */	\n");
		sbSelSql.append("	  ,	NVL(C.D_DAYS,0)	AS D_DAY																																					\n");
		sbSelSql.append("	  ,	''	AS D_DAY_TXT																																		\n");
		sbSelSql.append("	  ,	DECODE(C.D_DAYS,NULL,	0, DECODE(SIGN(TO_DATE(:NEED_DATE,	'YYYYMMDD')	- TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'),	'YYYYMMDD')	- NVL(C.D_DAYS,0) -	1) , 0,				\n");
		sbSelSql.append("								   DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0,	24,	C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,	'HH24'))), 1, 0, 1), 0)	+ NVL(C.D_DAYS,	0))	AS D_DAYS		\n");
		sbSelSql.append("	  ,	DECODE(C.D_DAYS,NULL,	0, DECODE(C.D_TIMES, '', 24, 0,	24,	C.D_TIMES))	AS D_TIMES																							\n");
		sbSelSql.append("	  ,	A.SPICE_YN																																						\n");
		sbSelSql.append("	  ,	A.CORN_YN																																						\n");
		sbSelSql.append("	  ,	A.IMG_PATH																																						\n");
		sbSelSql.append("	  ,	A.ORIGIN_NAT																																					\n");
		sbSelSql.append("	  ,	A.ORIGIN_TYPE																																					\n");
		sbSelSql.append("	  ,	A.VD_SN																																							\n");
		sbSelSql.append("	  ,	A.APPLY_SD																																						\n");
		sbSelSql.append("	  ,	'P'	  AS MOBILE_GUBUN																																			\n");
		sbSelSql.append("	  ,	SCC_SOPR_AGG_FUN(:SUBINV_CODE,	A.ITEM_CODE, 1)	AS AGG_QTY																								\n");
		sbSelSql.append("     , A.UPJANG_GRP														                                                                                            \n");
		sbSelSql.append("     , NVL(A.IS_ENF, 0) AS IS_ENF                                                                                                                                      \n");
		sbSelSql.append("     , NVL(A.IS_REC, 0) AS IS_REC                                                                                                                                      \n");
        sbSelSql.append("     , CASE WHEN G.G_PRICE < A.G_ITEM_PRICE THEN 'Y' ELSE 'N' END AS CHEAP_YN                                                                                          \n");
        sbSelSql.append("     , CASE A.LINE_STATUS WHEN '002' 																																	 \n");
        sbSelSql.append("     THEN CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID AND IA.SUBINV_CODE = :SUBINV_CODE AND IA.RC_UPJANG = :UPJANG ) > 1									 \n");
        sbSelSql.append("                       THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID  AND IA.SUBINV_CODE = :SUBINV_CODE AND IA.RC_UPJANG = :UPJANG )  \n");
        sbSelSql.append("               ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID  AND IA.SUBINV_CODE = :SUBINV_CODE AND IA.RC_UPJANG = :UPJANG )								 \n");
        sbSelSql.append("          END																																							 \n");
        sbSelSql.append("         ELSE A.LINE_STATUS																																			 \n");
        sbSelSql.append("         END LINE_STATUS																																				 \n");
        //sbSelSql.append("        , 'DL' AS LINE_STATUS																																				 \n");
        //20180510 김호석 담당MD 추가		
  		sbSelSql.append("\n     ,(SELECT MAX(DD.USR_NM)   ");
  		sbSelSql.append("\n				FROM EPROCUSR.ESPINFO AA  ");
  		sbSelSql.append("\n     			LEFT OUTER JOIN EPROCUSR.ESMVDOG BB ON AA.SYS_ID = BB.SYS_ID AND AA.COMP_CD = BB.COMP_CD AND AA.VD_SN = BB.VD_SN "); 
  		sbSelSql.append("\n     											    AND BB.OPER_ORG_SN = '414' --FC부문만  ");
  		sbSelSql.append("\n     			INNER JOIN EPROCUSR.ESPSWHC CC ON AA.SYS_ID = CC.SYS_ID AND AA.COMP_CD = CC.COMP_CD AND AA.PURC_OPER_ORG_SN = CC.OPER_ORG_SN_PURC "); 
  		sbSelSql.append("\n     		  	INNER JOIN EPROCUSR.ESAUSER DD ON DD.SYS_ID = '100' AND DD.COMP_CD = 'HFC' AND BB.HFC_CHR_ID = DD.USR_ID  AND DD.STS <> 'D' ");
  		sbSelSql.append("\n     					WHERE AA.SYS_ID = '100' AND AA.COMP_CD = 'HFC' AND :NEED_DATE BETWEEN AA.APPLY_SD AND AA.APPLY_ED  --계약 기간 "); 
  		sbSelSql.append("\n     						   AND AA.STS <> 'D'  "); 
  		sbSelSql.append("\n     					       AND BB.VD_SN = A.VD_SN  ");
  		sbSelSql.append("\n     					       AND AA.ITEM_CD = A.ITEM_CODE ");
  		sbSelSql.append("\n    							   AND CC.WH_CNTR_CD = A.CENTER_CODE ");
  		sbSelSql.append("\n       ) AS MD_NAME	/*담당MD*/ \n");
  		//20180510 김호석 담당MD 추가
        
		sbSelSql.append("  FROM	(																																								\n");
		sbSelSql.append("		 SELECT	A.PR_NUM					       AS PR_NUM																											\n");
		sbSelSql.append("		      , A.ORG_PR_NUM					   AS ORG_PR_NUM																										\n");
		sbSelSql.append("			  ,	A.PR_ID							   AS PR_ID																												\n");
		sbSelSql.append("			  ,	C.ITEM_CODE						   AS ITEM_CODE																											\n");
		sbSelSql.append("			  ,	C.ITEM_NAME						   AS ITEM_NAME																											\n");
		sbSelSql.append("			  ,	C.ITEM_CLASS3					   AS ITEM_CLASS3																										\n");
		sbSelSql.append("			  ,	C.ITEM_CLASS4					   AS ITEM_CLASS4																										\n");
		sbSelSql.append("			  ,	C.ITEM_SIZE						   AS ITEM_SIZE																											\n");
		sbSelSql.append("			  ,	C.PO_UOM						   AS PO_UOM																											\n");
		sbSelSql.append("			  ,	A.MENU_QTY						   AS MENU_QTY		   /* 식단필요갯수 */																				\n");
		sbSelSql.append("			  ,	C.TAX_CODE						   AS TAX_CODE																											\n");
		sbSelSql.append("			  ,	B.PROC_TYP_CD					   AS CENTER_FLAG	   																									\n");
		sbSelSql.append("			  ,	A.PR_REMARK						   AS PR_REMARK																											\n");
		sbSelSql.append("			  ,	A.REMARK						   AS REMARK																											\n");
		sbSelSql.append("			  ,	C.POINT_FLAG					   AS POINT_FLAG																										\n");
		sbSelSql.append("			  ,	A.RC_UPJANG						   AS UPJANG		   /* 업장코드 */																					\n");
		sbSelSql.append("			  ,	D.INVAT_FLAG					   AS INVAT_FLAG																										\n");
		sbSelSql.append("			  ,	D.OUTVAT_FLAG					   AS OUTVAT_FLAG																										\n");
		sbSelSql.append("			  ,	C.MIN_ORD_QTY					   AS MIN_ORD_QTY																										\n");
		sbSelSql.append("			  ,	C.MAX_ORD_QTY					   AS MAX_ORD_QTY																										\n");
		sbSelSql.append("			  ,	B.CENTER_CODE					   AS CENTER_CODE	   /* 센터코드 */																					\n");
		sbSelSql.append("			  ,	D.STOCK_FLAG					   AS STOCK_FLAG																										\n");
		sbSelSql.append("			  ,	C.BARCODE						   AS BARCODE																											\n");
		sbSelSql.append("			  ,	C.MULTIPLIER_QTY				   AS MULTIPLIER_QTY																									\n");
		sbSelSql.append("			  ,	C.USE_YN						   AS USE_YN																											\n");
		sbSelSql.append("			  ,	A.PR_QTY						   AS PR_QTY																											\n");
		sbSelSql.append("			  , NVL(TO_NUMBER(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, (ROUND((B.CONTRACT_PRICE	+ (B.CONTRACT_PRICE	* B.MARGIN_RATE	/ 100))	/ 10) *	10))), 0) AS MARGIN_PRICE	\n");
		sbSelSql.append("			  ,	B.CONTRACT_PRICE				   AS UNIT_PRICE	   /* 구매(매입)단가 */																				\n");
		sbSelSql.append("             , ROUND(NVL(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, ROUND((B.CONTRACT_PRICE + (B.CONTRACT_PRICE * B.MARGIN_RATE / 100)) / 10) * 10) / NVL(C.KG_CONVERT_RATE, 1) / 1000, 0), 2) AS G_ITEM_PRICE \n");
		sbSelSql.append("			  ,	B.CUSTCD						   AS CUSTCD		   /* 매입거래처코드 */																				\n");
		sbSelSql.append("			  ,	NVL(C.KG_CONVERT_RATE, 1)		   AS KG_CONVERT_RATE																									\n");
		sbSelSql.append("			  ,	B.MARGIN_RATE					   AS MARGIN_RATE																										\n");
		sbSelSql.append("			  ,	A.RC_UPJANG						   AS AP_UNITPRICE_UPJANG																								\n");
		sbSelSql.append("			  ,	C.SPICE_YN						   AS SPICE_YN																											\n");
		sbSelSql.append("			  ,	C.CORN_YN						   AS CORN_YN																											\n");
		sbSelSql.append("			  ,	C.IMG_PATH						   AS IMG_PATH																											\n");
		sbSelSql.append("			  ,	C.ORIGIN_NAT					   AS ORIGIN_NAT																										\n");
		sbSelSql.append("			  ,	C.ORIGIN_TYPE					   AS ORIGIN_TYPE																										\n");
		sbSelSql.append("			  ,	D.MATERIAL_ACCTCD				   AS ACCTCD																											\n");
		sbSelSql.append("			  ,	D.BUDCC_CD						   AS BUD_CLS																											\n");
		sbSelSql.append("			  ,	B.DUTY_YN						   AS DUTY_YN																											\n");
		//PB_YN을 계약에서 가져옴 (2015.08.29)
		sbSelSql.append("			  ,	B.PB_YN							   AS PB_YN																												\n");
		sbSelSql.append("			  ,	C.MANUF_CD						   AS MANUF_CD																											\n");
		sbSelSql.append("			  ,	C.ECO_ITEM						   AS ECO_ITEM																											\n");
		sbSelSql.append("			  ,	A.VD_SN							   AS VD_SN																												\n");
		sbSelSql.append("			  ,	A.APPLY_SD						   AS APPLY_SD																											\n");
		sbSelSql.append("			  ,	A.UPJANG_GRP					   AS UPJANG_GRP																										\n");
		sbSelSql.append("			  ,	A.IS_ENF					       AS IS_ENF			    																							\n");
		sbSelSql.append("			  ,	(SELECT MAX(Z.ATTR02) FROM FSM_REAL_RECIPE_ITEM Z WHERE Z.UPJANG = A.RC_UPJANG AND Z.ITEM_CODE = A.ITEM_CODE AND Z.NEED_DATE = A.NEED_DATE) AS IS_REC   \n");
		sbSelSql.append("             , A.LINE_STATUS																																			\n");
		sbSelSql.append("		   FROM	SO_PR A																																					\n");
		sbSelSql.append("			  ,	(SELECT /*+ INDEX(B.MR ESPSSGPITM_PK) */ * FROM HLDC_PO_CONTRACT_F B) B																				    \n");
		sbSelSql.append("			  ,	HLDC_PO_ITEM_MST C																																		\n");
		sbSelSql.append("			  ,	HLDC_PO_SUBINVENTORY D																																	\n");
		sbSelSql.append("		  WHERE	1=1																																						\n");
		sbSelSql.append("			AND	A.RC_UPJANG	  =	B.UPJANG (+)																															\n");
		sbSelSql.append("			AND	A.ITEM_CODE	  =	B.ITEM_CODE	(+)																															\n");
		sbSelSql.append("			AND	A.RC_UPJANG	  =	D.UPJANG																																\n");
		sbSelSql.append("			AND	A.SUBINV_CODE =	D.SUBINV_CODE																															\n");
		sbSelSql.append("			AND	A.ITEM_CODE	  =	C.ITEM_CODE																																\n");
		sbSelSql.append("			AND	:NEED_DATE	BETWEEN	B.CONTRACT_START(+)	AND	B.CONTRACT_END(+)																					\n");
		sbSelSql.append("			AND	A.SUBINV_CODE =	:SUBINV_CODE																													\n");
		sbSelSql.append("			AND	A.RC_UPJANG	  = :UPJANG																															\n");
		//취소 후 재신청일 경우 PR_DATE가 변경될 수 있음 김호석 20170322 CH201703_00494
		//sbSelSql.append("			AND	A.PR_DATE	  =	'" + PR_DATE   + "'																														\n");
		sbSelSql.append("			AND	A.NEED_DATE	  =	:NEED_DATE																														\n");
		sbSelSql.append("			AND	A.ORG_PR_NUM  =	:PR_NUM																															\n");

		if(TYPE.equals("CANCEL_UPDATE"))
			sbSelSql.append("					 AND A.LINE_STATUS NOT IN('999','PD')																												\n");
		else
			sbSelSql.append("					 AND A.LINE_STATUS NOT IN('999', '003', 'PD')																											\n");
		//sbSelSql.append("			ORDER BY C.ITEM_CLASS4, C.ITEM_NAME, C.ITEM_CODE 																											\n");		
		sbSelSql.append("		) A																																								\n");
		sbSelSql.append("	  ,	SCO_UPJANG_MST_V B																																				\n");
		sbSelSql.append("	  ,(SELECT A.CENTER_CODE																																			\n");
		sbSelSql.append("			 , A.ITEM_CODE , A.D_DAYS AS D_DAY																															\n");
		sbSelSql.append("			 ,(SELECT TO_DATE(:NEED_DATE,'YYYYMMDD') -	TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')																		\n");
		sbSelSql.append("				 FROM (SELECT ROW_NUMBER() OVER(ORDER BY Z.CD_SY||Z.CD_SM||Z.CD_SD DESC) AS	SEQ																			\n");
		sbSelSql.append("							, Z.CD_SY||Z.CD_SM||Z.CD_SD	AS NONHOLI_DATE																									\n");
		sbSelSql.append("						 FROM SCC_CALENDA_DATA Z																														\n");
		sbSelSql.append("						WHERE Z.CD_SY||Z.CD_SM||Z.CD_SD	< :NEED_DATE																							\n");
		sbSelSql.append("						  AND Z.CD_SY BETWEEN TO_NUMBER(SUBSTR(:NEED_DATE,	1, 4)) - 1 AND TO_NUMBER(SUBSTR(:NEED_DATE, 1,	4))							\n");
		sbSelSql.append("					   -- AND Z.HOLIDAY	NOT	IN (1,2) --일요일 제외한 국가 공휴일 (일요일만 체크, 그	외 공유일은	상관없음(김진희))										\n");
		sbSelSql.append("						  AND Z.CD_WEEK	NOT	IN ('일')) Z																												\n");
		sbSelSql.append("				WHERE Z.SEQ	= A.D_DAYS ) AS	D_DAYS																														\n");
		sbSelSql.append("			  ,	A.D_TIMES																																				\n");
		sbSelSql.append("		   FROM	HLDC_PO_PREORDER_LIST A																																	\n");
		sbSelSql.append("		  WHERE	A.CENTER_CODE =	:CENTER_CODE																														\n");
		sbSelSql.append("		) C						 /*	선발주 제한	*/																														\n");
		sbSelSql.append("	  ,	(																																								\n");
		sbSelSql.append("		 SELECT	UPJANG																																					\n");
		sbSelSql.append("			  ,	ITEM_CODE																																				\n");
		sbSelSql.append("			  ,	TO_CHAR(TO_DATE(RESTRICT_START,	'YYYYMMDD'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(RESTRICT_END, 'YYYYMMDD'),	'YYYY.MM.DD') AS RESTRICT_PERIOD		\n");
		sbSelSql.append("			  ,	RESTRICT_REASON																																			\n");
		sbSelSql.append("		   FROM	FSI_RESTRICT_SET																																		\n");
		sbSelSql.append("		  WHERE	UPJANG = :UPJANG																																	\n");
		sbSelSql.append("			AND	(RESTRICT_START	<= :NEED_DATE AND RESTRICT_END	>= :NEED_DATE)																			\n");
		sbSelSql.append("			AND	NOT	(CNL_START IS NOT NULL AND CNL_START	<= :NEED_DATE AND CNL_END		>= :NEED_DATE)												\n");
		sbSelSql.append("		) D						 /*	금지자재 */																															\n");
		
/*
		sbSelSql.append("	  ,	(																																								\n");
		sbSelSql.append("		 SELECT	ITEM_CODE																																				\n");
		sbSelSql.append("			  ,	PHYSIC_QTY AS ONHAND_QTY																																\n");
		sbSelSql.append("		   FROM	HLDC_PO_PHYSICAL_INVENTORY A																															\n");
		sbSelSql.append("			  ,(SELECT MAX(D.PHYSIC_ID)	AS PHYSIC_ID																													\n");
		sbSelSql.append("				   FROM	HLDC_PO_PHYSICAL_INVENTORY D																													\n");
		sbSelSql.append("				  WHERE	D.PHYSIC_DATE =	'" + PHYSIC_DATE + "'																											\n");
		sbSelSql.append("					AND	D.SUBINV_CODE =	'" + SUBINV_CODE + "'																											\n");
		sbSelSql.append("				  GROUP	BY D.ITEM_CODE)	C																																\n");
		sbSelSql.append("		  WHERE	A.PHYSIC_ID	  =	C.PHYSIC_ID																																\n");
		sbSelSql.append("			AND	A.PHYSIC_DATE =	'" + PHYSIC_DATE + "'																													\n");
		sbSelSql.append("			AND	A.SUBINV_CODE =	'" + SUBINV_CODE + "'																													\n");
		sbSelSql.append("			AND	A.CLOSE_DATE > ' '																																		\n");
		sbSelSql.append("			AND	PHYSIC_QTY <> 0																																			\n");
		sbSelSql.append("		) E					   																															\n");
		 */
		sbSelSql.append("	  ,	VO_CENTER F																																						\n");
		sbSelSql.append("    , (                                                                                                                                                                                                                            \n");
		sbSelSql.append("       SELECT ITEM_CLASS4, MIN(G_PRICE) AS G_PRICE                                                                                                                                                   \n");
		sbSelSql.append("         FROM (                                                                                                                                                                                                                    \n");
		sbSelSql.append("               SELECT C.ITEM_CLASS4                                                                                                                                                                                                \n");
		sbSelSql.append("                    , ROUND(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, (ROUND((B.CONTRACT_PRICE + (B.CONTRACT_PRICE * B.MARGIN_RATE / 100)) / 10) * 10)) / DECODE(C.KG_CONVERT_RATE, 0, 1, C.KG_CONVERT_RATE) / 1000, 2) G_PRICE   \n");
		sbSelSql.append("                 FROM ST_UPJANG A                                                                                                                                                                                                  \n");
		sbSelSql.append("                    , HLDC_PO_CONTRACT_F B                                                                                                                                                                                         \n");
		sbSelSql.append("                    , HLDC_PO_ITEM_MST C                                                                                                                                                                                           \n");
		sbSelSql.append("                WHERE B.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                    \n");
		sbSelSql.append("                  AND B.USE_YN    = 'Y'                                                                                                                                                                                            \n");
		sbSelSql.append("                  AND B.CONTRACT_PRICE > 0                                                                                                                                                                                         \n");
		sbSelSql.append("                  AND B.UPJANG    = A.AP_UNITPRICE_UPJANG                                                                                                                                                                          \n");
		//sbSelSql.append("                  AND A.UPJANG    = " + UPJANG + "                                                                                                                                                                                 \n");
		//sbSelSql.append("                  AND '" + NEED_DATE + "' BETWEEN B.CONTRACT_START AND B.CONTRACT_END                                                                                                                                                                                 \n");
		sbSelSql.append("                  AND A.UPJANG    = :UPJANG                                                                                                                                                                                 \n");
		sbSelSql.append("                  AND :NEED_DATE BETWEEN B.CONTRACT_START AND B.CONTRACT_END                                                                                                                                                                                 \n");
		sbSelSql.append("               )                                                                                                                                                                                                                   \n");
		sbSelSql.append("        GROUP BY ITEM_CLASS4                                                                                                                                                                       \n");
		sbSelSql.append("      ) G                                                                                                                                                                                                                          \n");
		sbSelSql.append(" WHERE	A.UPJANG = B.UPJANG																																				\n");
		sbSelSql.append("	AND	A.CENTER_CODE =	C.CENTER_CODE(+)																																\n");
		sbSelSql.append("	AND	A.ITEM_CODE	  =	C.ITEM_CODE	 (+)																																\n");
		sbSelSql.append("	AND	A.ITEM_CODE	  =	D.ITEM_CODE	 (+)																																\n");
//		sbSelSql.append("	AND	A.ITEM_CODE	  =	E.ITEM_CODE	 (+)																																\n");
		sbSelSql.append("	AND	A.CENTER_CODE =	F.CENTER_CODE(+)																																\n");
		sbSelSql.append("   AND A.ITEM_CLASS4 = G.ITEM_CLASS4(+)                                                                                                                                \n");
		// 유효성 체크된 자재 맨 위로 정렬 추가 2018.04.02 김호석 (이혜은, 윤지혜, 염병문 확인)		
		sbSelSql.append(" ORDER	BY SHP_MAP, SHP_MAP, MTG_STP, SCH, REQ_WKD,  A.ITEM_CLASS4, A.ITEM_NAME, A.ITEM_CODE																																					\n");
		sbSelSql.append("\n																																										\n");
		
		//20180514 김호석 쿼리 변수 바인딩기능 추가		
        npstmt = new NamedParameterStatement(conn, sbSelSql.toString());
		        
        npstmt.setString("UPJANG", UPJANG);
        npstmt.setString("NEED_DATE", NEED_DATE);
        npstmt.setString("SUBINV_CODE", SUBINV_CODE);
        npstmt.setString("CENTER_CODE", CENTER_CODE);
        npstmt.setString("PR_DATE", PR_DATE);
        npstmt.setString("PR_NUM", PR_NUM);
        
        rs = npstmt.executeQuery();
     	//20180514 김호석 쿼리 변수 바인딩기능 추가
     	
		//stmt = conn.createStatement();
		//rs = stmt.executeQuery(sbSelSql.toString());

		DataSet	ds_pr_item = this.makeDataSet(rs,"ds_pr_item");

		rs.close();
		//stmt.close();
		npstmt.close();

		// remart 생성
        String sRemark = "";
        if(ds_pr_item.getRowCount() > 0)
        {
        	for(int i=0; i < ds_pr_item.getRowCount(); i++)
        	{
        		BigDecimal nMagPrice = ds_pr_item.getBigDecimal(i, "MARGIN_PRICE");
        		BigDecimal nPrQty    = ds_pr_item.getBigDecimal(i, "PR_QTY");


        		// 계약여부
        		if(ds_pr_item.getString(i, "SHP_MAP").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "단가계약 안됨");
        			ds_pr_item.set(i, "PR_YN" , "A");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}
        		// 불용자재
        		else if(ds_pr_item.getString(i, "MTG_UNS").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "불용자재");
        			ds_pr_item.set(i, "PR_YN" , "B");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}
        		// 중지자재
        		else if(ds_pr_item.getString(i, "MTG_STP").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "중지자재");
        			ds_pr_item.set(i, "PR_YN" , "B");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}

        		// 요일제한
        		else if(ds_pr_item.getString(i, "REQ_WKD").equals("N"))
        		{
        			ds_pr_item.set(i, "PR_REMARK", "요일제한");
        			ds_pr_item.set(i, "PR_YN" , "A");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}

         		else if(nullToBlank(ds_pr_item.getString(i, "RESTRICT_PERIOD")).length() > 0)
        		{
        			sRemark =	"금지자재("	+ ds_pr_item.getString(i,"RESTRICT_PERIOD")	+	", " + ds_pr_item.getString(i,"RESTRICT_REASON") + ")";
        			ds_pr_item.set(i, "PR_REMARK", sRemark);
        			ds_pr_item.set(i, "PR_YN" , "C");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}

        		else if(ds_pr_item.getString(i, "SCH").equals("N"))
        		{        			
        			sRemark = "수발주 제한";
        			ds_pr_item.set(i, "PR_REMARK", sRemark);
        			//ds_pr_item.set(i, "PR_REMARK", "");
        			//ds_pr_item.set(i, "PR_YN" , "A");
        			//수정 못하게 하기 위해 Y값이 아닌 값으로 부여하며 자재삭제 시 수발주제한만 삭제 못하게 막기 위해 D로 독립된 값을 부여 2018.03.27 김호석(이혜은 과장 요청)
        			//유효성자재는 전부 삭제 못하도록 수정 2018.04.02
        			ds_pr_item.set(i, "PR_YN" , "D");
        			//ds_pr_item.set(i, "PR_QTY", 0);
        		}
        		else
        		{
        			ds_pr_item.set(i, "PR_YN" , "Y");
        		}

        		ds_pr_item.set(i, "TOT_AMT", nMagPrice.multiply(nPrQty));
        	}
        }

		out_dl.add(ds_pr_item);

/*		삭제된 자재리스트 조회		   */

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT																																									\n");
		sbSelSql.append("      	/*+ USE_HASH(A D E G) PUSH_PRED(C) */ 																															\n");
		sbSelSql.append("      A.PR_NUM																																							\n");		
		sbSelSql.append("	  ,	A.PR_ID																																							\n");
		sbSelSql.append("	  ,	A.ITEM_CODE																																						\n");
		sbSelSql.append("	  ,	A.ITEM_NAME																																						\n");
		sbSelSql.append("	  ,	A.ITEM_CLASS3																																					\n");
		sbSelSql.append("	  ,	A.ITEM_CLASS4																																					\n");
		sbSelSql.append("	  ,	FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, :NEED_DATE),	A.PB_YN, A.ECO_ITEM, A.MANUF_CD) AS	FEATURE_NAME			\n");
		sbSelSql.append("	  ,	A.ITEM_SIZE																																						\n");
		sbSelSql.append("	  ,	A.PO_UOM																																						\n");
		sbSelSql.append("	  ,	A.MENU_QTY AS KG_QTY																																			\n");
		//sbSelSql.append("	  ,	NVL(E.ONHAND_QTY, 0) AS ONHAND_QTY																																\n");
		sbSelSql.append("	  ,	FSP_TRANS_QTY_FUN(:PR_DATE, :SUBINV_CODE, A.ITEM_CODE) AS ONHAND_QTY					     												\n");
		sbSelSql.append("	  ,	0 AS CANCEL_PR_QTY																																				\n");
		sbSelSql.append("	  ,	0 AS PR_QTY																																						\n");
		sbSelSql.append("	  ,	0 AS TOT_AMT																																					\n");
		sbSelSql.append("	  ,	ROUND(NVL(A.MARGIN_PRICE / A.KG_CONVERT_RATE / 1000, 0)) AS	G_ITEM_PRICE /*	g당	단가 = 출하율적용단가 /	Kg 환산율 /	1000 */										\n");
		sbSelSql.append("	  ,	A.TAX_CODE																																						\n");
		sbSelSql.append("	  ,	A.CENTER_FLAG																																					\n");
		sbSelSql.append("	  ,	A.PR_REMARK																																						\n");
		sbSelSql.append("	  ,	A.REMARK																																						\n");
		sbSelSql.append("	  ,	A.POINT_FLAG																																					\n");
		sbSelSql.append("	  ,	:SUBINV_CODE AS SUBINV_CODE																																\n");
		sbSelSql.append("	  ,	:NEED_DATE AS NEED_DATE																																	\n");
		sbSelSql.append("	  ,	A.UPJANG																																						\n");
		sbSelSql.append("	  ,	A.DEPT_ID																																						\n");
		sbSelSql.append("	  ,	A.ACCTCD		 /*	입고 계정 코드(대표) - MATERIAL_ACCTCD */																									\n");
		sbSelSql.append("	  ,	A.BUD_CLS		 /*	예산 조직 cc 코드 -	BUDCC_CD */																												\n");
		sbSelSql.append("	  ,	B.MU_CD																																							\n");
		sbSelSql.append("	  ,	A.INVAT_FLAG																																					\n");
		sbSelSql.append("	  ,	A.OUTVAT_FLAG																																					\n");
		sbSelSql.append("	  ,	A.MIN_ORD_QTY																																					\n");
		sbSelSql.append("	  ,	A.MAX_ORD_QTY																																					\n");
		sbSelSql.append("	  ,	A.CENTER_CODE	   /* 센터코드 */																																\n");
		sbSelSql.append("	  ,	A.STOCK_FLAG																																					\n");
		sbSelSql.append("	  ,	A.BARCODE																																						\n");
		sbSelSql.append("	  ,	A.MULTIPLIER_QTY																																				\n");
		sbSelSql.append("	  ,	A.BUD_CLS AS BUDDEPT_ID	 /*	예산 조직 cc 코드 :	BUDCC_CD - 고도화에서 부서코드가 CC로 대체됨 */																	\n");
		sbSelSql.append("	  ,	A.USE_YN																																						\n");
		sbSelSql.append("	  ,	DECODE(A.CUSTCD, NULL, 'N',	'Y') AS	CONTRACT_YN																													\n");
		sbSelSql.append("	  ,	NVL(A.MARGIN_PRICE,	0) AS MARGIN_PRICE	   /* 출하율적용단가 */																									\n");
		sbSelSql.append("	  ,	A.UNIT_PRICE	   /* 구매(매입)단가 */																															\n");
		sbSelSql.append("	  ,	A.CUSTCD		   /* 매입거래처코드 */																															\n");
		sbSelSql.append("	  ,	A.KG_CONVERT_RATE																																				\n");
		sbSelSql.append("	  ,	A.MARGIN_RATE																																					\n");
		sbSelSql.append("	  ,	A.AP_UNITPRICE_UPJANG																																			\n");
		sbSelSql.append("	  ,	D.RESTRICT_PERIOD																																				\n");
		sbSelSql.append("	  ,	D.RESTRICT_REASON																																				\n");
		sbSelSql.append("	  ,	NULL DUTY_END_DATE																																				\n");
		sbSelSql.append("	  ,	0 MIN_DUTY_QTY																																					\n");
		sbSelSql.append("	  ,	0 DUTY_QTY																																						\n");
		sbSelSql.append("	  ,	0 REAL_USE_QTY																																					\n");
		sbSelSql.append("	  ,	DECODE(A.REMARK, '', 'Y','N') PR_YN																																\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SHP_MAP('100', 'HFC', F.OPER_ORG_SN_PURC, A.UPJANG_GRP, A.ITEM_CODE,	:NEED_DATE)	= 'CK' THEN	'Y'	ELSE 'N' END	\n");
		sbSelSql.append("													 AS	SHP_MAP	 /*	자재 업장군	맵핑 유효성	체크 CE	- 맵핑안되어있음(사용불가),	CK - 맵핑되어있음(사용가능)	*/			\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) = 'UP' THEN 'Y' ELSE	'N'	END																		\n");
		sbSelSql.append("													 AS	MTG_UNS		 /*	자재불용체크 UK- 불용, UP-불용아님,	NN-	DATA NOT FOUND */										\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') = 'TP'	THEN 'Y' ELSE 'N' END																\n");
		sbSelSql.append("													 AS	MTG_STP		 /*	자재 중지체크 TK -중지(사용불가), TP -	중지아님(사용가능),	NN-	DATA NOT FOUND */				\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_REQ_WKD('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', :NEED_DATE) = 'XR' THEN 'Y' ELSE	'N'	END							\n");
		sbSelSql.append("													 AS	REQ_WKD		 /*	요일별 신청불가	체크 XE	- 신청불가(사용불가), XR - 신청가능(사용가능), NN :	DATA NOT FOUND */	\n");
		sbSelSql.append("	  ,	CASE WHEN EPROCUSR.FN_ITEM_PROCURE_SCH('100', 'HFC', F.OPER_ORG_SN_PURC, A.ITEM_CODE, A.VD_SN, '01', NVL(C.D_DAY, 0), NVL(C.D_TIMES, 0), TO_CHAR(SYSDATE, 'YYYYMMDD'), :NEED_DATE)	= 'HK' THEN	'Y'	ELSE 'N' END	\n");
		sbSelSql.append("													 AS	SCH			 /*	수발주 스케쥴에	따른 유효성	체크 HE - 신청불가(사용불가), HK - 신청가능(사용가능), NN -	DATA NOT FOUND */										\n");
		sbSelSql.append("	  ,	NVL(C.D_DAYS,0)	AS D_DAY																																		\n");
		sbSelSql.append("	  ,	''	AS D_DAY_TXT																																		\n");
		sbSelSql.append("	  ,	DECODE(C.D_DAYS,NULL,	0, DECODE(SIGN(TO_DATE(:NEED_DATE,	'YYYYMMDD')	- TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'),	'YYYYMMDD')	- NVL(C.D_DAYS,0) -	1) , 0,	\n");
		sbSelSql.append("								   DECODE(SIGN(DECODE(C.D_TIMES, '', 24, 0,	24,	C.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,	'HH24'))), 1, 0, 1), 0)	+ NVL(C.D_DAYS,	0))	AS D_DAYS											\n");
		sbSelSql.append("	  ,	DECODE(C.D_DAYS,NULL,	0, DECODE(C.D_TIMES, '', 24, 0,	24,	C.D_TIMES))	AS D_TIMES																				\n");
		sbSelSql.append("	  ,	A.SPICE_YN																																						\n");
		sbSelSql.append("	  ,	A.CORN_YN																																						\n");
		sbSelSql.append("	  ,	A.IMG_PATH																																						\n");
		sbSelSql.append("	  ,	A.ORIGIN_NAT																																					\n");
		sbSelSql.append("	  ,	A.ORIGIN_TYPE																																					\n");
		sbSelSql.append("	  ,	A.VD_SN																																							\n");
		sbSelSql.append("	  ,	A.APPLY_SD																																						\n");
		sbSelSql.append("	  ,	'P'	  AS MOBILE_GUBUN																																			\n");
		sbSelSql.append("	  ,	SCC_SOPR_AGG_FUN(:SUBINV_CODE,	A.ITEM_CODE, 1)	AS AGG_QTY																								\n");
		sbSelSql.append("     , A.UPJANG_GRP														                                                                                            \n");
		sbSelSql.append("     , 0 AS IS_ENF     														                                                                                        \n");
        sbSelSql.append("     , CASE WHEN G.G_PRICE < A.G_ITEM_PRICE THEN 'Y' ELSE 'N' END AS CHEAP_YN                                                                                          \n");
      	//20180510 김호석 담당MD 추가		
  		sbSelSql.append("\n     ,(SELECT MAX(DD.USR_NM)   ");
  		sbSelSql.append("\n				FROM EPROCUSR.ESPINFO AA  ");
  		sbSelSql.append("\n     			LEFT OUTER JOIN EPROCUSR.ESMVDOG BB ON AA.SYS_ID = BB.SYS_ID AND AA.COMP_CD = BB.COMP_CD AND AA.VD_SN = BB.VD_SN "); 
  		sbSelSql.append("\n     											    AND BB.OPER_ORG_SN = '414' --FC부문만  ");
  		sbSelSql.append("\n     			INNER JOIN EPROCUSR.ESPSWHC CC ON AA.SYS_ID = CC.SYS_ID AND AA.COMP_CD = CC.COMP_CD AND AA.PURC_OPER_ORG_SN = CC.OPER_ORG_SN_PURC "); 
  		sbSelSql.append("\n     		  	INNER JOIN EPROCUSR.ESAUSER DD ON DD.SYS_ID = '100' AND DD.COMP_CD = 'HFC' AND BB.HFC_CHR_ID = DD.USR_ID  AND DD.STS <> 'D' ");
  		sbSelSql.append("\n     					WHERE AA.SYS_ID = '100' AND AA.COMP_CD = 'HFC' AND :NEED_DATE BETWEEN AA.APPLY_SD AND AA.APPLY_ED  --계약 기간 "); 
  		sbSelSql.append("\n     						   AND AA.STS <> 'D'  "); 
  		sbSelSql.append("\n     					       AND BB.VD_SN = A.VD_SN  ");
  		sbSelSql.append("\n     					       AND AA.ITEM_CD = A.ITEM_CODE ");
  		sbSelSql.append("\n    							   AND CC.WH_CNTR_CD = A.CENTER_CODE ");
  		sbSelSql.append("\n       ) AS MD_NAME	/*담당MD*/ \n");
  		//20180510 김호석 담당MD 추가
		sbSelSql.append("  FROM	(																																								\n");
		sbSelSql.append("		 SELECT	A.ORG_PR_NUM					   AS PR_NUM																											\n");
		sbSelSql.append("			  ,	A.PR_ID							   AS PR_ID																												\n");
		sbSelSql.append("			  ,	C.ITEM_CODE						   AS ITEM_CODE																											\n");
		sbSelSql.append("			  ,	C.ITEM_NAME						   AS ITEM_NAME																											\n");
		sbSelSql.append("			  ,	C.ITEM_CLASS3					   AS ITEM_CLASS3																										\n");
		sbSelSql.append("			  ,	C.ITEM_CLASS4					   AS ITEM_CLASS4																										\n");
		sbSelSql.append("			  ,	C.ITEM_SIZE						   AS ITEM_SIZE																											\n");
		sbSelSql.append("			  ,	C.PO_UOM						   AS PO_UOM																											\n");
		sbSelSql.append("			  ,	A.MENU_QTY						   AS MENU_QTY		   /* 식단필요갯수 */																				\n");
		sbSelSql.append("			  ,	C.TAX_CODE						   AS TAX_CODE																											\n");
		sbSelSql.append("			  , B.PROC_TYP_CD				  	   AS CENTER_FLAG	  																									\n");
		sbSelSql.append("			  ,	A.PR_REMARK						   AS PR_REMARK																											\n");
		sbSelSql.append("			  ,	A.REMARK						   AS REMARK																											\n");
		sbSelSql.append("			  ,	C.POINT_FLAG					   AS POINT_FLAG																										\n");
		sbSelSql.append("			  ,	A.PR_DEPT_ID					   AS DEPT_ID		   /* 업장코드 */																					\n");
		sbSelSql.append("			  ,	A.RC_UPJANG						   AS UPJANG		   /* 업장코드 */																					\n");
		sbSelSql.append("			  ,	D.INVAT_FLAG					   AS INVAT_FLAG																										\n");
		sbSelSql.append("			  ,	D.OUTVAT_FLAG					   AS OUTVAT_FLAG																										\n");
		sbSelSql.append("			  ,	C.MIN_ORD_QTY					   AS MIN_ORD_QTY																										\n");
		sbSelSql.append("			  ,	C.MAX_ORD_QTY					   AS MAX_ORD_QTY																										\n");
		sbSelSql.append("			  ,	A.CENTER_CODE					   AS CENTER_CODE	   /* 센터코드 */																					\n");
		sbSelSql.append("			  ,	D.STOCK_FLAG					   AS STOCK_FLAG																										\n");
		sbSelSql.append("			  ,	C.BARCODE						   AS BARCODE																											\n");
		sbSelSql.append("			  ,	C.MULTIPLIER_QTY				   AS MULTIPLIER_QTY																									\n");
		sbSelSql.append("			  ,	C.USE_YN						   AS USE_YN																											\n");
		sbSelSql.append("			  ,	A.PR_QTY						   AS PR_QTY																											\n");
		sbSelSql.append("			  , NVL(TO_NUMBER(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, (ROUND((B.CONTRACT_PRICE	+ (B.CONTRACT_PRICE	* B.MARGIN_RATE	/ 100))	/ 10) *	10))), 0) AS MARGIN_PRICE	\n");
		sbSelSql.append("			  ,	B.CONTRACT_PRICE				   AS UNIT_PRICE	   /* 구매(매입)단가 */																				\n");
		sbSelSql.append("             , ROUND(NVL(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, ROUND((B.CONTRACT_PRICE + (B.CONTRACT_PRICE * B.MARGIN_RATE / 100)) / 10) * 10) / NVL(C.KG_CONVERT_RATE, 1) / 1000, 0), 2) AS G_ITEM_PRICE \n");
		sbSelSql.append("			  ,	B.CUSTCD						   AS CUSTCD		   /* 매입거래처코드 */																				\n");
		sbSelSql.append("			  ,	NVL(C.KG_CONVERT_RATE, 1)		   AS KG_CONVERT_RATE																									\n");
		sbSelSql.append("			  ,	B.MARGIN_RATE					   AS MARGIN_RATE																										\n");
		sbSelSql.append("			  ,	A.RC_UPJANG						   AS AP_UNITPRICE_UPJANG																								\n");
		sbSelSql.append("			  ,	C.SPICE_YN						   AS SPICE_YN																											\n");
		sbSelSql.append("			  ,	C.CORN_YN						   AS CORN_YN																											\n");
		sbSelSql.append("			  ,	C.IMG_PATH						   AS IMG_PATH																											\n");
		sbSelSql.append("			  ,	C.ORIGIN_NAT					   AS ORIGIN_NAT																										\n");
		sbSelSql.append("			  ,	C.ORIGIN_TYPE					   AS ORIGIN_TYPE																										\n");
		sbSelSql.append("			  ,	D.MATERIAL_ACCTCD				   AS ACCTCD																											\n");
		sbSelSql.append("			  ,	D.BUDCC_CD						   AS BUD_CLS																											\n");
		sbSelSql.append("			  ,	B.DUTY_YN						   AS DUTY_YN																											\n");
		//PB_YN을 계약에서 가져옴 (2015.08.29)
		sbSelSql.append("			  ,	B.PB_YN							   AS PB_YN																												\n");
		sbSelSql.append("			  ,	C.MANUF_CD						   AS MANUF_CD																											\n");
		sbSelSql.append("			  ,	C.ECO_ITEM						   AS ECO_ITEM																											\n");
		sbSelSql.append("			  ,	A.VD_SN							   AS VD_SN																												\n");
		sbSelSql.append("			  ,	A.APPLY_SD						   AS APPLY_SD																											\n");
		sbSelSql.append("			  ,	A.UPJANG_GRP					   AS UPJANG_GRP																										\n");
		sbSelSql.append("		   FROM	SO_PR_MENU_LOG A																																		\n");
		sbSelSql.append("			  ,	(SELECT /*+ INDEX(B.MR ESPSSGPITM_PK) */ * FROM HLDC_PO_CONTRACT_F B) B																																		\n");
		sbSelSql.append("			  ,	HLDC_PO_ITEM_MST C																																		\n");
		sbSelSql.append("			  ,	HLDC_PO_SUBINVENTORY D																																	\n");
		sbSelSql.append("		  WHERE	1=1																																						\n");
		sbSelSql.append("			AND	A.RC_UPJANG	  =	B.UPJANG	(+)																															\n");
		sbSelSql.append("			AND	A.ITEM_CODE	  =	B.ITEM_CODE	(+)																															\n");
		sbSelSql.append("			AND	A.RC_UPJANG	  =	D.UPJANG																																\n");
		sbSelSql.append("			AND	A.SUBINV_CODE =	D.SUBINV_CODE																															\n");
		sbSelSql.append("			AND	A.ITEM_CODE	  =	C.ITEM_CODE																																\n");
		sbSelSql.append("			AND	:NEED_DATE	BETWEEN	B.CONTRACT_START(+)	AND	B.CONTRACT_END(+)																					\n");
		sbSelSql.append("			AND	A.SUBINV_CODE =	:SUBINV_CODE																												\n");
		sbSelSql.append("			AND	A.RC_UPJANG	  =	:UPJANG																															\n");
		sbSelSql.append("			AND	A.PR_DATE	  =	:PR_DATE																														\n");
		sbSelSql.append("			AND	A.NEED_DATE	  =	:NEED_DATE																														\n");
		sbSelSql.append("			AND	A.ORG_PR_NUM  =	:PR_NUM																														\n");
/*		   if(TYPE.equals("CANCEL_UPDATE")){   //취소재작성의 경우 취소목록에 있는건 다시 부르지 않는다. 2008/10/21	박은규 이명희
		}else{	//수정의 경우 이미 삭제한 자재에 대한 레피시 자재는	다시 불러오지 않는다. 2008/09/24 박은규	이명희
		} */		
		sbSelSql.append("			ORDER BY C.ITEM_CLASS4, C.ITEM_NAME, C.ITEM_CODE 																											\n");
		sbSelSql.append("		) A																																								\n");
		sbSelSql.append("	  ,	SCO_UPJANG_MST_V B																																				\n");
		sbSelSql.append("	  ,(SELECT A.CENTER_CODE																																			\n");
		sbSelSql.append("			 , A.ITEM_CODE	, A.D_DAYS AS D_DAY																															\n");
		sbSelSql.append("			 ,(SELECT TO_DATE(:NEED_DATE,'YYYYMMDD') -	TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')																		\n");
		sbSelSql.append("				 FROM (SELECT ROW_NUMBER() OVER(ORDER BY Z.CD_SY||Z.CD_SM||Z.CD_SD DESC) AS	SEQ																			\n");
		sbSelSql.append("							, Z.CD_SY||Z.CD_SM||Z.CD_SD	AS NONHOLI_DATE																									\n");
		sbSelSql.append("						 FROM SCC_CALENDA_DATA Z																														\n");
		sbSelSql.append("						WHERE Z.CD_SY||Z.CD_SM||Z.CD_SD	< :NEED_DATE																							\n");
		sbSelSql.append("						  AND Z.CD_SY BETWEEN TO_NUMBER(SUBSTR(:NEED_DATE,	1, 4)) - 1 AND TO_NUMBER(SUBSTR(:NEED_DATE, 1,	4))							\n");
		sbSelSql.append("					   -- AND Z.HOLIDAY	NOT	IN (1,2) --일요일 제외한 국가 공휴일 (일요일만 체크, 그	외 공유일은	상관없음(김진희))										\n");
		sbSelSql.append("						  AND Z.CD_WEEK	NOT	IN ('일')) Z																												\n");
		sbSelSql.append("				WHERE Z.SEQ	= A.D_DAYS ) AS	D_DAYS																														\n");
		sbSelSql.append("			  ,	A.D_TIMES																																				\n");
		sbSelSql.append("		   FROM	HLDC_PO_PREORDER_LIST A																																	\n");
		sbSelSql.append("		  WHERE	A.CENTER_CODE =	:CENTER_CODE																														\n");
		sbSelSql.append("		) C						 /*	선발주 제한	*/																														\n");
		sbSelSql.append("	  ,	(																																								\n");
		sbSelSql.append("		 SELECT	UPJANG																																					\n");
		sbSelSql.append("			  ,	ITEM_CODE																																				\n");
		sbSelSql.append("			  ,	TO_CHAR(TO_DATE(RESTRICT_START,	'YYYYMMDD'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE(RESTRICT_END, 'YYYYMMDD'),	'YYYY.MM.DD') AS RESTRICT_PERIOD		\n");
		sbSelSql.append("			  ,	RESTRICT_REASON																																			\n");
		sbSelSql.append("		   FROM	FSI_RESTRICT_SET																																		\n");
		sbSelSql.append("		  WHERE	UPJANG = :UPJANG																																\n");
		sbSelSql.append("			AND	(RESTRICT_START	<= :NEED_DATE AND RESTRICT_END	>= :NEED_DATE)																			\n");
		sbSelSql.append("			AND	NOT	(CNL_START IS NOT NULL AND CNL_START	<= :NEED_DATE AND CNL_END		>= :NEED_DATE)												\n");
		sbSelSql.append("		) D						 /*	금지자재 */			 																												\n");
/*
		sbSelSql.append("	  ,	(																																								\n");
		sbSelSql.append("		 SELECT	ITEM_CODE																																				\n");
		sbSelSql.append("			  ,	PHYSIC_QTY AS ONHAND_QTY																																\n");
		sbSelSql.append("		   FROM	HLDC_PO_PHYSICAL_INVENTORY A																															\n");
		sbSelSql.append("			  ,(SELECT MAX(D.PHYSIC_ID)	AS PHYSIC_ID																													\n");
		sbSelSql.append("				   FROM	HLDC_PO_PHYSICAL_INVENTORY D																													\n");
		sbSelSql.append("				  WHERE	D.PHYSIC_DATE =	'" + PHYSIC_DATE + "'																											\n");
		sbSelSql.append("					AND	D.SUBINV_CODE =	'" + SUBINV_CODE + "'																											\n");
		sbSelSql.append("				  GROUP	BY D.ITEM_CODE   																																\n");
		sbSelSql.append("				 HAVING COUNT(1) = 1)	C																																\n");
		sbSelSql.append("		  WHERE	A.PHYSIC_ID	  =	C.PHYSIC_ID																																\n");
		sbSelSql.append("			AND	A.PHYSIC_DATE =	'" + PHYSIC_DATE + "'																													\n");
		sbSelSql.append("			AND	A.SUBINV_CODE =	'" + SUBINV_CODE + "'																													\n");
		sbSelSql.append("			AND	CANCEL_YN = 'N'																																			\n");
//		sbSelSql.append("			AND	A.CLOSE_DATE > ' '																																		\n");
		sbSelSql.append("			AND	PHYSIC_QTY <> 0																																			\n");
		sbSelSql.append("		) E					   																															\n");
 */
		sbSelSql.append("	  ,	VO_CENTER F																																						\n");
		sbSelSql.append("    , (                                                                                                                                                                                                                            \n");
		sbSelSql.append("       SELECT ITEM_CLASS4, MIN(G_PRICE) AS G_PRICE                                                                                                                                                   \n");
		sbSelSql.append("         FROM (                                                                                                                                                                                                                    \n");
		sbSelSql.append("               SELECT C.ITEM_CLASS4                                                                                                                                                                                                \n");
		sbSelSql.append("                    , ROUND(DECODE(B.MARGIN_RATE, 0, B.CONTRACT_PRICE, (ROUND((B.CONTRACT_PRICE + (B.CONTRACT_PRICE * B.MARGIN_RATE / 100)) / 10) * 10)) / DECODE(C.KG_CONVERT_RATE, 0, 1, C.KG_CONVERT_RATE) / 1000, 2) G_PRICE   \n");
		sbSelSql.append("                 FROM ST_UPJANG A                                                                                                                                                                                                  \n");
		sbSelSql.append("                    , HLDC_PO_CONTRACT_F B                                                                                                                                                                                         \n");
		sbSelSql.append("                    , HLDC_PO_ITEM_MST C                                                                                                                                                                                           \n");
		sbSelSql.append("                WHERE B.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                    \n");
		sbSelSql.append("                  AND B.USE_YN    = 'Y'                                                                                                                                                                                            \n");
		sbSelSql.append("                  AND B.CONTRACT_PRICE > 0                                                                                                                                                                                         \n");
		sbSelSql.append("                  AND B.UPJANG    = A.AP_UNITPRICE_UPJANG                                                                                                                                                                          \n");
		sbSelSql.append("                  AND A.UPJANG    = :UPJANG                                                                                                                                                                                 \n");
		sbSelSql.append("                  AND :NEED_DATE BETWEEN B.CONTRACT_START AND B.CONTRACT_END                                                                                                                                                                                 \n");
		sbSelSql.append("               )                                                                                                                                                                                                                   \n");
		sbSelSql.append("        GROUP BY ITEM_CLASS4                                                                                                                                                                       \n");
		sbSelSql.append("      ) G                                                                                                                                                                                                                          \n");
		sbSelSql.append(" WHERE	A.UPJANG = B.UPJANG																																				\n");
		sbSelSql.append("	AND	A.CENTER_CODE =	C.CENTER_CODE(+)																																\n");
		sbSelSql.append("	AND	A.ITEM_CODE	  =	C.ITEM_CODE	 (+)																																\n");
		sbSelSql.append("	AND	A.ITEM_CODE	  =	D.ITEM_CODE	 (+)																																\n");
//		sbSelSql.append("	AND	A.ITEM_CODE	  =	E.ITEM_CODE	 (+)																																\n");
		sbSelSql.append("	AND	A.CENTER_CODE =	F.CENTER_CODE(+)																																\n");
		sbSelSql.append("   AND A.ITEM_CLASS4 = G.ITEM_CLASS4(+)                                                                                                                                \n");
		//sbSelSql.append(" ORDER	BY A.ITEM_CLASS4, A.ITEM_NAME, A.ITEM_CODE																														\n");
		sbSelSql.append("\n																																										\n");

		//20180514 김호석 쿼리 변수 바인딩기능 추가		
        npstmt = new NamedParameterStatement(conn, sbSelSql.toString());
		        
        npstmt.setString("UPJANG", UPJANG);
        npstmt.setString("NEED_DATE", NEED_DATE);
        npstmt.setString("SUBINV_CODE", SUBINV_CODE);
        npstmt.setString("CENTER_CODE", CENTER_CODE);
        npstmt.setString("PR_DATE", PR_DATE);
        npstmt.setString("PR_NUM", PR_NUM);
        
        rs = npstmt.executeQuery();
     	//20180514 김호석 쿼리 변수 바인딩기능 추가
		//stmt = conn.createStatement();
		//rs = stmt.executeQuery(sbSelSql.toString());

		DataSet	ds_del_item	= this.makeDataSet(rs,"ds_del_item");

		// remart 생성
        sRemark = "";
        if(ds_del_item.getRowCount() > 0)
        {
        	for(int i=0; i < ds_del_item.getRowCount(); i++)
        	{
        		BigDecimal nMagPrice = ds_del_item.getBigDecimal(i, "MARGIN_PRICE");
        		BigDecimal nPrQty    = ds_del_item.getBigDecimal(i, "PR_QTY");

        		// 계약여부
        		if(ds_del_item.getString(i, "SHP_MAP").equals("N"))
        		{
        			ds_del_item.set(i, "PR_REMARK", "단가계약 안됨");
        			ds_del_item.set(i, "PR_YN" , "A");
        			ds_del_item.set(i, "PR_QTY", 0);
        		}
        		// 불용자재
        		else if(ds_del_item.getString(i, "MTG_UNS").equals("N"))
        		{
        			ds_del_item.set(i, "PR_REMARK", "불용자재");
        			ds_del_item.set(i, "PR_YN" , "B");
        			ds_del_item.set(i, "PR_QTY", 0);
        		}
        		// 중지자재
        		else if(ds_del_item.getString(i, "MTG_STP").equals("N"))
        		{
        			ds_del_item.set(i, "PR_REMARK", "중지자재");
        			ds_del_item.set(i, "PR_YN" , "B");
        			ds_del_item.set(i, "PR_QTY", 0);
        		}

        		// 요일제한
        		else if(ds_del_item.getString(i, "REQ_WKD").equals("N"))
        		{
        			ds_del_item.set(i, "PR_REMARK", "요일제한");
        			ds_del_item.set(i, "PR_YN" , "A");
        			ds_del_item.set(i, "PR_QTY", 0);
        		}

         		else if(nullToBlank(ds_del_item.getString(i, "RESTRICT_PERIOD")).length() > 0)
        		{
        			sRemark =	"금지자재("	+ ds_del_item.getString(i,"RESTRICT_PERIOD")	+	", " + ds_del_item.getString(i,"RESTRICT_REASON") + ")";
        			ds_del_item.set(i, "PR_REMARK", sRemark);
        			ds_del_item.set(i, "PR_YN" , "C");
        			ds_del_item.set(i, "PR_QTY", 0);
        		}

        		else if(ds_del_item.getString(i, "SCH").equals("N"))
        		{	
        			//문구 수정 20180516 김호석(이혜은과장 요청)
        			sRemark = "수발주제한(발주 수정/삭제 불가사유)";
        			ds_del_item.set(i, "PR_REMARK", sRemark);
        			ds_del_item.set(i, "PR_YN" , "A");
        			ds_del_item.set(i, "PR_QTY", 0);
        		}
        		else
        		{
        			ds_del_item.set(i, "PR_YN" , "Y");
        		}
        		ds_del_item.set(i, "TOT_AMT", nMagPrice.multiply(nPrQty));
        	}
        }
		out_dl.add(ds_del_item);
		rs.close();
		//stmt.close();
		npstmt.close();


		this.setResultMessage(0, "OK",out_vl);

	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
			if(rs != null) {
				try	{
					rs.close();
				}catch(Exception e)	{}
			}
			if(pstmt !=	null) {
				try	{
					pstmt.close();
				}catch(Exception e)	{}
			}
			if(stmt	!= null) {
				try	{
					stmt.close();
				}catch(Exception e)	{}
			}
			if(npstmt	!= null) {
				try	{
					npstmt.close();
				}catch(Exception e)	{}
			}
			if(conn	!= null) {
				try	{
					conn.close();
				}catch(Exception e)	{}
			}
			//jsp log 서비스 닫기
			try	{
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}
		}

	  proc_output(response,out,out_vl,out_dl);

%>