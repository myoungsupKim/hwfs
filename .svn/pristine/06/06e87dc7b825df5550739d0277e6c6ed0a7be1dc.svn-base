<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/자재관                                                                                                                                                                     
■ 프로그램ID   : FSI00081V_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 사업장 자재단가조회                                                                                                                                                 
■ 작성일자     : 2008.02.27                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008.02.27                                                                                                                                                                            
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
수발주등록여부, 선발주일자 표시
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%
	try {

		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
		//FileLog.println("d:\\aaa.txt", ds_cond);                                                                                                                                                            
		                                                                                                                                                                                                                                                                                                                                                                                                             
		String strUpjang		= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                           
		String strDate			= nullToBlank(ds_input.getString(0, "DATE"));                                                                                                                          
		String strCDate			= nullToBlank(ds_input.getString(0, "CDATE"));      
		String strClassCode1	= nullToBlank(ds_input.getString(0, "CLASS_CODE1"));
		String strClassCode2	= nullToBlank(ds_input.getString(0, "CLASS_CODE2"));
		String strClassCode3	= nullToBlank(ds_input.getString(0, "CLASS_CODE3"));
		String strClassCode4	= nullToBlank(ds_input.getString(0, "CLASS_CODE4"));
		String strFeature		= nullToBlank(ds_input.getString(0, "FEATURE"));
		String strItem			= nullToBlank(ds_input.getString(0, "ITEM"));
		String strSType			= nullToBlank(ds_input.getString(0, "STYPE"));
		String strItemType	    = nullToBlank(ds_input.getString(0, "ITEM_TYPE"));
                                                                                                                                                                                                        
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();  

		sbSql.append("SELECT /*+ USE_HASH(A C D E Z ZZ) */   							                                                                                      \n");
		sbSql.append("       A.ITEM_CODE                                                                                                        \n");
	    sbSql.append("     , B.ITEM_NAME                                                                                                        \n");
	    sbSql.append("     , B.ITEM_SIZE                                                                                                        \n");
	    sbSql.append("     , B.PO_UOM                                                                                                           \n");
	    sbSql.append("     , NVL(C.ITEM_PRICE,0) PRE_ITEM_PRICE                                                                                 \n");
	    sbSql.append("     , A.ITEM_PRICE                                                                                                       \n");
	    sbSql.append("     , NVL(A.ITEM_PRICE,0) - NVL(C.ITEM_PRICE,0) PRICE_DIF                                                                \n");
	    sbSql.append("     , DECODE(NVL(C.ITEM_PRICE,0),0,0,((NVL(A.ITEM_PRICE,0)-NVL(C.ITEM_PRICE,0))/NVL(C.ITEM_PRICE,1))*100) AS PRICE_RATE  \n");
	    sbSql.append("     , B.KG_CONVERT_RATE                                                                                                  \n");
	    sbSql.append("     , DECODE(B.TAX_CODE,'210','면세','과세') TAX_NAME                                                                       \n");
	    sbSql.append("     , PROC_TYP_CD AS PO_CENTER_YN                                                                                        \n");
	    sbSql.append("     , ROUND(A.ITEM_PRICE/B.KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE --재무그램단가                                                                                       \n");
	    sbSql.append("     , DECODE(B.TAX_CODE,'100',A.ITEM_PRICE*0.1,0) AS ITEM_VAT                                                            \n");
	    sbSql.append("     , A.VD_NM AS CUSTNM                                                                                                  \n");
	    sbSql.append("     , NULL AS FEATURE_NAME                                                                                               \n");
	    sbSql.append("     , NULL AS DUTY_PERIOD                                                                                                \n");
	    sbSql.append("     , NULL AS DUTY_QTY                                                                                                   \n");
	    //PB_YN을 계약에서 가져옴 (2015.08.29) 
	    //기획자재 마스터 같은 센터내 거래처가 다른 자재코드가 있어서 수정 20190225 김호석
	    sbSql.append("     , FN_ITEM_FEATURE_ICON2((SELECT DISTINCT USE_YN                                                                                \n");
	    sbSql.append("             FROM FSI_DUTY_MST                                                                                            \n");
	    sbSql.append("            WHERE ? BETWEEN START_DATE AND END_DATE                                                              \n");
	    sbSql.append("             AND USE_YN = 'Y'                                                                                             \n");
	    sbSql.append("             AND ITEM_CODE = A.ITEM_CODE                                                                                  \n");
	    //기획자재 마스터 같은 센터내 거래처가 다른 자재코드가 있어서 수정 20190225 김호석	    
	    sbSql.append("             AND CUSTCD = A.CUSTCD                                                                                  \n");
	    //효율화 자재 기간이 겹치는 경우 문제 해결 20180411 김호석
	    sbSql.append("             AND CENTER_CODE = A.CENTER_CODE), TRIM(A.PB_YN), TRIM(B.ECO_ITEM), TRIM(B.MANUF_CD),(SELECT DISTINCT USE_YN   \n");
	    sbSql.append("             FROM FSI_EFF_MST                                                                                            \n");
	    sbSql.append("            WHERE ? BETWEEN START_DATE AND END_DATE                                                              			\n");
	    sbSql.append("             AND USE_YN = 'Y'                                                                                             \n");
	    sbSql.append("             AND ITEM_CODE = A.ITEM_CODE     )) AS FEATURE_ICON         													\n");
	    //sbSql.append("             AND CENTER_CODE = A.CENTER_CODE)) AS FEATURE_ICON         													\n");                
	    sbSql.append("     , B.IMG_YN                                                                                                           \n");
	    sbSql.append("     , B.IMG_PATH                                                                                                         \n");
	    sbSql.append("     , E.RESTRICT_SEQ                                                                                                     \n");
	    sbSql.append("     , E.RESTRICT_PERIOD                                                                                                  \n");
	    sbSql.append("     , E.RESTRICT_REASON                                                                                                  \n");
	    sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_UNS('100', A.ITEM_CODE) AS MTG_UNS -- 불용자재체크                                    \n");
	    sbSql.append("     , EPROCUSR.FN_ITEM_PROCURE_MTG_STP('100', A.ITEM_CODE, '01') AS MTG_STP -- 중지자재체크(Q-STOP)                      \n");
	    
		//============================================================================================
		//(2012-11-05 추가) 시작
		// 박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
		// 수발주등록여부, 선발주일자 표시
		//============================================================================================
	    sbSql.append("     , CASE WHEN Z.UPJANG IS NOT NULL THEN 'Y' END AS SCHEDULE_YN                                                         \n");
	    sbSql.append("     , NVL(ZZ.D_DAYS, NULL) D_DAYS                                                                                           \n");
		//============================================================================================
		//(2012-11-05 추가) 끝
		//============================================================================================

		//============================================================================================
		//(2016-03-21 추가) 시작
		// 양념/미곡 표시 요청자:윤지혜(FS메뉴지원팀)
		//============================================================================================
		sbSql.append("     , CASE WHEN B.SPICE_YN = 'Y' AND B.CORN_YN = 'Y' THEN '양념/미곡'\n");
		sbSql.append("            WHEN B.SPICE_YN = 'Y' AND NVL(B.CORN_YN, 'N') = 'N' THEN '양념'\n");
		sbSql.append("            WHEN NVL(B.SPICE_YN, 'N') = 'N' AND B.CORN_YN = 'Y' THEN '미곡'\n");
		sbSql.append("            ELSE ''\n");
		sbSql.append("        END AS SPICE_CORN_YN\n");
		//============================================================================================
		//(2016-03-21 추가) 끝
		//============================================================================================
		
		// [속도개선 Project 시작] 2017. 12. 06. 김호석 담당MD 추가		
     	sbSql.append("      , F.NM_KOR AS MD_NAME	/*담당MD*/	  \n");
     	// [속도개선 Project 시작] 2017. 12. 06. 김호석 담당MD 추가		
     	
	    sbSql.append("  FROM ( \n");	
		sbSql.append("       SELECT /*+ NO_PUSH_PRED(F.V) */ A.ITEM_CODE,    \n");
		sbSql.append("              A.CUSTCD, \n");
		if (strSType.equals("1"))
			sbSql.append("              DECODE(NVL(A.MARGIN_RATE, 0), 0, A.CONTRACT_PRICE, ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) )  AS ITEM_PRICE,  --관리구매단가 \n");
		else
			sbSql.append("              A.CONTRACT_PRICE AS ITEM_PRICE, --재무구매단가 \n");
		sbSql.append("              F.UPJANG, \n");
		sbSql.append("              F.CENTER_CODE, \n");
		sbSql.append("              A.PROC_TYP_CD, \n");
		sbSql.append("              A.PB_YN,  \n");
		//sbSql.append("              E.VD_NM_LOC AS VD_NM,    \n");
		sbSql.append("              E.VD_NM,    \n");
		sbSql.append("              A.VD_SN,  \n");
		sbSql.append("              E.HFC_CHR_ID  \n");
		sbSql.append("         FROM ST_UPJANG B, \n");
		sbSql.append("              HLDC_PO_UPJANG_CENTER F, \n");
		sbSql.append("              HLDC_PO_CONTRACT_F A, \n");
		//sbSql.append("              EPROCUSR.ESMVDGL E   --VO_FC_VENDOR E \n");
		sbSql.append("              VO_FC_VENDOR E \n");
		sbSql.append("        WHERE A.CENTER_CODE = F.CENTER_CODE \n");
		//sbSql.append("          AND A.VD_SN = E.VD_SN \n");
		sbSql.append("          AND TO_CHAR(A.CUSTCD) = E.VD_CD \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("          AND A.CONTRACT_PRICE > 0 \n");
		sbSql.append("          AND A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("          AND B.AP_UNITPRICE_UPJANG = F.UPJANG \n");
		sbSql.append("          AND B.UPJANG = ? \n");
		sbSql.append("          AND ? BETWEEN A.CONTRACT_START AND A.CONTRACT_END \n");
		sbSql.append("        ) A \n");
		sbSql.append("       ,( \n");
		sbSql.append("       SELECT /*+ NO_PUSH_PRED(F.V) */ A.ITEM_CODE, \n");
		sbSql.append("              A.CUSTCD, \n");
		if (strSType.equals("1"))
			sbSql.append("              DECODE(NVL(A.MARGIN_RATE, 0), 0, A.CONTRACT_PRICE, ( ROUND( (A.CONTRACT_PRICE * (A.MARGIN_RATE+100) / 100 ) / 10) * 10 ) )  AS ITEM_PRICE, --관리구매단가 \n");
		else
			sbSql.append("              A.CONTRACT_PRICE  AS ITEM_PRICE,  --재무구매단가 \n");
		sbSql.append("              F.UPJANG, \n");
		sbSql.append("              A.DUTY_YN, \n");
		sbSql.append("              A.PB_YN  \n");
		sbSql.append("         FROM ST_UPJANG B, \n");
		sbSql.append("              HLDC_PO_UPJANG_CENTER F, \n");
		sbSql.append("              HLDC_PO_CONTRACT_F2 A \n");
		sbSql.append("        WHERE A.CENTER_CODE = F.CENTER_CODE \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("          AND A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("          AND B.AP_UNITPRICE_UPJANG = F.UPJANG \n");
		sbSql.append("          AND B.UPJANG = ? \n");
		sbSql.append("          AND ? BETWEEN A.CONTRACT_START AND A.CONTRACT_END \n");
		sbSql.append("        ) C \n");
		sbSql.append("       ,( \n");
		sbSql.append("        SELECT /*+ USE_NL(A B) */ A.RESTRICT_SEQ \n");
		sbSql.append("              ,A.ITEM_CODE \n");
		sbSql.append("              ,A.RESTRICT_REASON \n");
		sbSql.append("              ,TO_CHAR(TO_DATE(A.RESTRICT_START, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) || '~' || TO_CHAR(TO_DATE(A.RESTRICT_END, 'YYYYMMDD' ) , 'YYYY.MM.DD' ) RESTRICT_PERIOD \n");
		sbSql.append("          FROM FSI_RESTRICT_SET A \n");
		sbSql.append("              ,HLDC_PO_ITEM_MST B \n");
		sbSql.append("         WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("           AND A.UPJANG = ? \n");
		sbSql.append("           AND ? BETWEEN RESTRICT_START AND RESTRICT_END \n");
		sbSql.append("           AND NOT (CNL_START IS NOT NULL AND ? BETWEEN CNL_START AND CNL_END) \n");
		sbSql.append("       ) E --금지자재 \n");		    
		sbSql.append("       ,HLDC_PO_ITEM_MST B \n");
		sbSql.append("       ,(  \n");
		sbSql.append("          SELECT /*+ INDEX(Z.MR ESPSSGPITM_PK) */ Z.CENTER_CODE,Z.CUSTCD,Z.ITEM_CODE,Z.UPJANG \n");
		sbSql.append("            FROM HLDC_PO_ORDER_SCHEDULE Z \n");
		sbSql.append("           WHERE Z.MON||Z.TUE||Z.WED||Z.THU||Z.FRI||Z.SAT||Z.SUN <> 'NNNNNNN' AND Z.UPJANG_TYPE = '01' \n");
		sbSql.append("             AND Z.UPJANG IN (-1, " + strUpjang + ") \n");
		sbSql.append("           GROUP BY Z.CENTER_CODE,Z.CUSTCD,Z.ITEM_CODE,Z.UPJANG \n");
		sbSql.append("       ) Z \n");
		sbSql.append("       ,HLDC_PO_PREORDER_LIST ZZ \n");
		sbSql.append("       ,SCC_USERINFO F \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");
		sbSql.append("   AND A.HFC_CHR_ID = F.SABUN(+) \n");
		sbSql.append("   AND Z.CENTER_CODE(+) = A.CENTER_CODE \n");
		sbSql.append("   AND Z.CUSTCD(+)  = A.CUSTCD \n");
		sbSql.append("   AND Z.ITEM_CODE(+)  = A.ITEM_CODE \n");
		sbSql.append("   AND DECODE(Z.UPJANG(+),-1,A.UPJANG,Z.UPJANG(+)) = A.UPJANG \n");
		sbSql.append("   AND ZZ.CENTER_CODE(+) = A.CENTER_CODE \n");
		sbSql.append("   AND ZZ.ITEM_CODE(+) = A.ITEM_CODE \n");
		if (strClassCode1.trim().length() != 0) sbSql.append("   AND B.ITEM_CLASS1 = ? \n");
		if (strClassCode2.trim().length() != 0) sbSql.append("   AND B.ITEM_CLASS2 = ? \n");
		if (strClassCode3.trim().length() != 0) sbSql.append("   AND B.ITEM_CLASS3 = ? \n");
		if (strClassCode4.trim().length() != 0) sbSql.append("   AND B.ITEM_CLASS4 = ? \n");
		if (strItemType.trim().length() != 0) sbSql.append("   AND B.ITEM_TYPE = ? \n");
		if (strItem.length() != 0)
		{
			//sbSql.append("   AND (A.ITEM_CODE LIKE '%' || ? || '%' OR B.ITEM_NAME LIKE '%' || ? || '%') \n");
			// 자재명, 자재코드 동이어 검색
			//REGEXP_LIKE 함수의 변수값이 200자 넘으면 에러 발생 substr함수로 200자 제한 추가 김호석 CH201703_00107
			sbSql.append("   AND (REGEXP_LIKE(A.ITEM_CODE, (SELECT SUBSTR(TRIM(LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP)),0,200) AS ITEM_NAME \n");
			sbSql.append("             FROM																																		   \n");
			sbSql.append("      						  (SELECT REPLACE(REPLACE(REPLACE(?, '(', '\\('), ')', '\\)'), ' ', '|') AS ITEM_NAME									   \n");
			sbSql.append("      							      , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM DUAL																										   \n");
			sbSql.append("                                     UNION ALL																										   \n");
			sbSql.append("                                     --정규식에서 괄호가 한쪽만 있으면 에러 발생하기때문에 치환처리													   \n");
			sbSql.append("   		                                  SELECT REPLACE(REPLACE(REPLACE(KEYWORD||'|'||SIM_TXT, '(', ''), ')', ''), ' ', '|') AS ITEM_NAME			   \n");
			sbSql.append("                                          , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM EPROCUSR.VO_ITEM_SIM_WORD																					   \n");
			sbSql.append("                                      --유사어에 등록된 키워드는 일치검색으로 변경																	   \n");
			sbSql.append("                                      WHERE KEYWORD = REPLACE(REPLACE(REPLACE(?, '(', '\\('), ')', '\\)'), ' ', '|')									   \n");
			sbSql.append("                                    ) T																												   \n");
			sbSql.append("                              )																														   \n");	 
			sbSql.append("   			             )																															   \n");
			sbSql.append("   OR REGEXP_LIKE(B.ITEM_NAME, (SELECT SUBSTR(TRIM(LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP)),0,200) AS ITEM_NAME \n");
			sbSql.append("             FROM																																		   \n");
			sbSql.append("      						  (SELECT REPLACE(REPLACE(REPLACE(?, '(', '\\('), ')', '\\)'), ' ', '|') AS ITEM_NAME									   \n");
			sbSql.append("      							      , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM DUAL																										   \n");
			sbSql.append("                                     UNION ALL																										   \n");
			sbSql.append("                                     --정규식에서 괄호가 한쪽만 있으면 에러 발생하기때문에 치환처리													   \n");
			sbSql.append("   		                                  SELECT REPLACE(REPLACE(REPLACE(KEYWORD||'|'||SIM_TXT, '(', ''), ')', ''), ' ', '|') AS ITEM_NAME			   \n");
			sbSql.append("                                          , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM EPROCUSR.VO_ITEM_SIM_WORD																					   \n");
			sbSql.append("                                      --유사어에 등록된 키워드는 일치검색으로 변경																	   \n");
			sbSql.append("                                      WHERE KEYWORD = REPLACE(REPLACE(REPLACE(?, '(', '\\('), ')', '\\)'), ' ', '|')									   \n");
			sbSql.append("                                    ) T																												   \n");
			sbSql.append("                              )																														   \n");	 
			sbSql.append("   			             ))																															   \n");
						
			/* sbSql.append("   AND (REGEXP_LIKE(A.ITEM_CODE, (SELECT LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME	\n");
            sbSql.append("                                   FROM 																								\n");
            sbSql.append("                                       (SELECT KEYWORD||'|'||SIM_TXT AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM EPROCUSR.VO_ITEM_SIM_WORD																\n");
            sbSql.append("                                         WHERE REGEXP_LIKE(KEYWORD, REPLACE(?, ' ', '|'))												\n");
            sbSql.append("                                         UNION ALL																					\n");
            sbSql.append("                                        SELECT REPLACE(?, ' ', '|') AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM DUAL																					\n");
            sbSql.append("                                        ) T																							\n");
            sbSql.append("                                )																										\n");
            sbSql.append("                   )			
            \n");
            sbSql.append("   OR REGEXP_LIKE(B.ITEM_NAME, (SELECT LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME	\n");
            sbSql.append("                                   FROM 																								\n");
            sbSql.append("                                       (SELECT KEYWORD||'|'||SIM_TXT AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM EPROCUSR.VO_ITEM_SIM_WORD																\n");
            sbSql.append("                                         WHERE REGEXP_LIKE(KEYWORD, REPLACE(?, ' ', '|'))												\n");
            sbSql.append("                                         UNION ALL																					\n");
            sbSql.append("                                        SELECT REPLACE(?, ' ', '|') AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM DUAL																					\n");
            sbSql.append("                                        ) T																							\n");
            sbSql.append("                                )																										\n");
            sbSql.append("                   ))																											\n");
			 */		
		}
		if (strFeature.length() != 0 && strFeature.equals("005")) sbSql.append("   AND NVL((SELECT USE_YN FROM FSI_DUTY_MST WHERE ? BETWEEN START_DATE AND END_DATE AND USE_YN = 'Y' AND ITEM_CODE = A.ITEM_CODE AND CENTER_CODE = A.CENTER_CODE), 'N') = 'Y' \n"); // 기획
		if (strFeature.length() != 0 && strFeature.equals("003")) sbSql.append("   AND TRIM(B.MANUF_CD) IS NOT NULL \n"); // 전처리
		if (strFeature.length() != 0 && strFeature.equals("001")) sbSql.append("   AND NVL(TRIM(A.PB_YN), 'N') = 'Y' \n");   // PB
		if (strFeature.length() != 0 && strFeature.equals("007")) sbSql.append("   AND (TRIM(B.ECO_ITEM) IS NOT NULL AND TRIM(B.ECO_ITEM) <> '해당없음') \n"); // 친환경
		//효율화 자재 기간이 겹치는 경우 문제 해결 20180411 김호석
		//if (strFeature.length() != 0 && strFeature.equals("013")) sbSql.append("   AND NVL((SELECT DISTINCT USE_YN FROM FSI_EFF_MST WHERE ? BETWEEN START_DATE AND END_DATE AND USE_YN = 'Y' AND ITEM_CODE = A.ITEM_CODE AND CENTER_CODE = A.CENTER_CODE), 'N') = 'Y' \n"); // 효율화식재
		if (strFeature.length() != 0 && strFeature.equals("013")) sbSql.append("   AND NVL((SELECT DISTINCT USE_YN FROM FSI_EFF_MST WHERE ? BETWEEN START_DATE AND END_DATE AND USE_YN = 'Y' AND ITEM_CODE = A.ITEM_CODE ), 'N') = 'Y' \n"); // 효율화식재
		
		int idx = 1;
		pstmt = conn.prepareStatement(sbSql.toString());
		pstmt.setString(idx++, strDate);
		pstmt.setString(idx++, strDate);		
		pstmt.setString(idx++, strUpjang);
		pstmt.setString(idx++, strDate);
		pstmt.setString(idx++, strUpjang);
		pstmt.setString(idx++, strCDate);
		pstmt.setString(idx++, strUpjang);
		pstmt.setString(idx++, strDate);
		pstmt.setString(idx++, strDate);
		if (strClassCode1.trim().length() != 0) pstmt.setString(idx++, strClassCode1);
		if (strClassCode2.trim().length() != 0) pstmt.setString(idx++, strClassCode2);
		if (strClassCode3.trim().length() != 0) pstmt.setString(idx++, strClassCode3);
		if (strClassCode4.trim().length() != 0) pstmt.setString(idx++, strClassCode4);
		if (strItemType.trim().length() != 0) pstmt.setString(idx++, strItemType);
		if (strItem.length() != 0)
		{
			pstmt.setString(idx++, strItem);
			pstmt.setString(idx++, strItem);
			pstmt.setString(idx++, strItem);
			pstmt.setString(idx++, strItem);
		}
		if (strFeature.length() != 0 && strFeature.equals("005")) {
			pstmt.setString(idx++, strDate);
		}
		if (strFeature.length() != 0 && strFeature.equals("013")) {
			pstmt.setString(idx++, strDate);
		}
		
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
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