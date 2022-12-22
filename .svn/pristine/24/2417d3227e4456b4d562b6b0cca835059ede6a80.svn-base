<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMM00011P_S001
■ 프로그램명   : 대체상품 조회팝업
■ 작성일자     : 2013-04-30
■ 작성자       : 박용대
■ 이력관리     : 2013-04-30 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);
	
	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();	//데이터셋 받는 객체
	
	//입력 데이타셋
	DataSet ds_cond   	= in_dl.get("inDs_Cond");
	
	//입력 데이타셋 값 설정
	String upjang 		= ds_cond.getString(0, "UPJANG");
	String recipeCd		= ds_cond.getString(0, "RECIPE_CD");
	String itemCode		= ds_cond.getString(0, "ITEM_CODE");
	
	//테스트 출력
	//System.out.println("======================");
	//System.out.println(mainUpjang +"/"+ upjang);
	//System.out.println("======================");
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
		sbSql.append("\n\n");
	    
        sbSql.append("SELECT A.ITEM_CODE      --상품코드                                                                                                                                                                   \n");
        sbSql.append("      ,A.ITEM_NAME      --상품명                                                                                                                                                                   \n");
        sbSql.append("      ,A.UPJANG                                                                                                                                                                            \n");
        sbSql.append("      ,A.ITEM_SIZE      --규격                                                                                                                                                                   \n");
        sbSql.append("      ,A.PO_UOM         --구매단위                                                                                                                                                                   \n");
        sbSql.append("      ,NVL(B.OP_PRICE,0) AS ITEM_PRICE                                                                                                                                                     \n");
        sbSql.append("      ,A.KG_CONVERT_RATE                                                                                                                                                                   \n");
        sbSql.append("      ,NVL(B.G_ITEM_PRICE,0) AS G_ITEM_PRICE                                                                                                                                               \n");
        sbSql.append("      ,B.SALE_PRICE                                                                                                                                                                        \n");
        sbSql.append("      ,B.OP_RATE                                                                                                                                                                           \n");
        sbSql.append("      ,NVL(C.NEED_QTY, 0) AS NEED_QTY     --1인소요량                                                                                                                                                 \n");
        sbSql.append("      ,ROUND(NVL(C.NEED_QTY,0)*(100-NVL(A.DISUSE_RATE, 0))/100, 2) EDIBLE_QTY --가식부량                                                                                                          \n");
        sbSql.append("      ,CASE WHEN NVL(A.KG_CONVERT_RATE,0)=0 THEN 0 ELSE ROUND(NVL(C.NEED_QTY,0) * (NVL(B.OP_PRICE,0) / A.KG_CONVERT_RATE / 1000) ) END PERSON_PRICE    --1인원가                                  \n");
        sbSql.append("      ,C.CUT_SPEC                                                                                                                                                                          \n");
        sbSql.append("      ,ROUND( NVL(A.CAL,0) * ROUND(NVL(C.NEED_QTY,0)*(100-NVL(A.DISUSE_RATE,0))/100,2) / 100,2) CAL_CALC --가식부량에 대한 에너지                                                                 \n");
        sbSql.append("      ,CASE WHEN NVL(A.KG_CONVERT_RATE,0)=0 THEN 0 ELSE ROUND(NVL(B.OP_PRICE,0) / A.KG_CONVERT_RATE / 1000,2) END GRAM_PRICE                   --G당 단가  \n");
        sbSql.append("      ,A.DISUSE_RATE                                                                                                                                                                          \n");
        sbSql.append("      ,B.OP_PRICE                                                                                                                                                                          \n");
        sbSql.append("      ,A.CAL                                                                                                                                                                          \n");
        sbSql.append("  FROM                                                                                                                                                                                     \n");
        sbSql.append("       (                                                                                                                                                                                   \n");
        sbSql.append("	SELECT	A.UPJANG, A.ITEM_CODE,	A.ITEM_NAME,	A.ITEM_SIZE,	A.PO_UOM,	A.KG_CONVERT_RATE                                                                                                       \n");
        sbSql.append("		,A.OTCUSTCD,A.CENTER_CODE, A.CUSTCD, A.IMG_PATH                                                                                                                                          \n");
        sbSql.append("		,B.CAL,		B.WATER,	B.PROT,		B.FAT,		B.CARBO                                                                                                                                               \n");
        sbSql.append("		,B.FIBER,	B.ASH,		B.CA,		B.P,		B.FE                                                                                                                                                      \n");
        sbSql.append("		,B.NA,		B.K,		B.VITA_A,	B.RETIN,	B.B_CAROT                                                                                                                                               \n");
        sbSql.append("		,B.THIA,	B.RIBO,		B.NIACIN,	B.VITA_C,	B.CHOLE, B.DISUSE_RATE                                                                                                                             \n");
        sbSql.append("		,A.ITEM_CLASS1,A.ITEM_CLASS2,A.ITEM_CLASS3,A.ITEM_CLASS4                                                                                                                                 \n");
        sbSql.append("		,A.D_DAYS, A.D_TIMES                                                                                                                                                                     \n");
        sbSql.append("	FROM (		SELECT	A.UPJANG, B.ITEM_CODE,	B.ITEM_NAME,	B.ITEM_SIZE,	B.PO_UOM,	B.TAX_CODE,	B.KG_CONVERT_RATE                                                                                   \n");
        sbSql.append("				,B.ITEM_CLASS1,B.ITEM_CLASS2,B.ITEM_CLASS3,B.ITEM_CLASS4                                                                                                                               \n");
        sbSql.append("				,'0000' AS OTCUSTCD, A.CENTER_CODE, A.CUSTCD, B.IMG_PATH                                                                                                                               \n");
        sbSql.append("				,C.D_DAYS , TO_CHAR(C.D_TIMES)||'00' AS D_TIMES                                                                                                                                        \n");
        sbSql.append("			FROM	 HLDC_PO_ITEM_MST B                                                                                                                                                                \n");
        sbSql.append("				    ,HLDC_PO_TREAT_UPJANG A                                                                                                                                                            \n");
        sbSql.append("				    ,HLDC_PO_PREORDER_LIST C                                                                                                                                                           \n");
        sbSql.append("			WHERE   A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                       \n");
        sbSql.append("			AND B.ITEM_CODE BETWEEN '010000000000' AND '019999999999'                                                                                                                               \n");
        sbSql.append("			AND A.UPJANG = (SELECT C.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG C WHERE C.UPJANG = 131029)                                                                                             \n");
        sbSql.append("			AND A.USE_YN = 'Y' AND B.USE_YN = 'Y'                                                                                                                                                   \n");
        sbSql.append("			AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                                                                                        \n");
        sbSql.append("			AND A.CENTER_CODE = C.CENTER_CODE(+)                                                                                                                                                    \n");
        sbSql.append("			UNION ALL                                                                                                                                                                               \n");
        sbSql.append("			SELECT B.UPJANG, A.ITEM_CODE,	A.ITEM_NAME,	A.ITEM_SIZE,	A.PO_UOM,	A.TAX_CODE,	A.KG_CONVERT_RATE                                                                                         \n");
        sbSql.append("				 ,A.ITEM_CLASS1,A.ITEM_CLASS2,A.ITEM_CLASS3,A.ITEM_CLASS4                                                                                                                              \n");
        sbSql.append("				 ,A.OTCUSTCD, NULL AS CENTER_CODE, NULL AS CUSTCD, A.SIMAGE_PATH AS IMG_PATH, A.D_DAYS, A.D_TIMES                                                                                      \n");
        sbSql.append("			FROM	FMP_OTCUST_ITEM A,                                                                                                                                                                 \n");
        sbSql.append("				    FMP_OTCUST_PRICE_AVA_V B,                                                                                                                                                          \n");
        sbSql.append("				(                                                                                                                                                                                      \n");
        sbSql.append("				SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE                                                                                                                                          \n");
        sbSql.append("				FROM FMP_OTCUST_PRICE_AVA_V                                                                                                                                                            \n");
        sbSql.append("				WHERE UPJANG = (SELECT Z.OTCUST_PRICE_UPJANG FROM FMS_UPJANG Z WHERE Z.UPJANG = '"+upjang.toString()+"')                                                                                                \n");
        sbSql.append("				AND SDATE <= NVL('',TO_CHAR(SYSDATE,'YYYYMMDD'))                                                                                                                                       \n");
        sbSql.append("				GROUP BY UPJANG, ITEM_CODE                                                                                                                                                             \n");
        sbSql.append("				) C                                                                                                                                                                                    \n");
        sbSql.append("			WHERE	A.ITEM_CODE	= B.ITEM_CODE                                                                                                                                                         \n");
        sbSql.append("			AND	B.UPJANG	= C.UPJANG                                                                                                                                                                 \n");
        sbSql.append("			AND	B.SDATE		= C.SDATE                                                                                                                                                                  \n");
        sbSql.append("			AND	B.ITEM_CODE	= C.ITEM_CODE                                                                                                                                                           \n");
        sbSql.append("			AND	A.USE_YN	= 'Y'                                                                                                                                                                      \n");
        sbSql.append("			AND	B.USE_YN	= 'Y'                                                                                                                                                                      \n");
        sbSql.append("			) A,                                                                                                                                                                                    \n");
        sbSql.append("			(	SELECT	ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE                                  \n");
        sbSql.append("			FROM	FMP_ITEM_NUT                                                                                                                                                                       \n");
        sbSql.append("			WHERE	UPJANG = '"+upjang.toString()+"'                                                                                                                                                                   \n");
        sbSql.append("			UNION ALL                                                                                                                                                                               \n");
        sbSql.append("			SELECT	X.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE                                  \n");
        sbSql.append("            FROM	FSI_ITEM_NUT X,                                                                                                                                                           \n");
        sbSql.append("			(                                                                                                                                                                                       \n");
        sbSql.append("				SELECT	ITEM_CODE                                                                                                                                                                       \n");
        sbSql.append("				FROM	FSI_ITEM_NUT                                                                                                                                                                      \n");
        sbSql.append("				MINUS                                                                                                                                                                                  \n");
        sbSql.append("				SELECT	ITEM_CODE                                                                                                                                                                       \n");
        sbSql.append("				FROM	FMP_ITEM_NUT                                                                                                                                                                      \n");
        sbSql.append("				WHERE	UPJANG = '"+upjang.toString()+"'                                                                                                                                                                  \n");
        sbSql.append("			) Y                                                                                                                                                                                     \n");
        sbSql.append("			WHERE X.ITEM_CODE = Y.ITEM_CODE                                                                                                                                                         \n");
        sbSql.append("		) B                                                                                                                                                                                      \n");
        sbSql.append("	WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                                                                                                                        \n");
        sbSql.append("       )A                                                                                                                                                                                  \n");
        sbSql.append("     ,(                                                                                                                                                                                    \n");
        sbSql.append("              SELECT /*+-- ORDERED USE_HASH(A B) */ A.UPJANG, A.ITEM_CODE                                                                                                                  \n");
        sbSql.append("             , A.SALE_PRICE, NVL(C.OP_RATE,0) OP_RATE, DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) OP_PRICE \n");
        sbSql.append("             , ROUND(   DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE)     / KG_CONVERT_RATE/1000,2) AS G_ITEM_PRICE \n");
        sbSql.append("        FROM                                                                                                                                                                               \n");
        sbSql.append("              (                                                                                                                                                                            \n");
        sbSql.append("              SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK)*/                                                                                                                                   \n");
        sbSql.append("                              	   '"+upjang.toString()+"' AS UPJANG,                                                                                                                                        \n");
        sbSql.append("                                    NVL('', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) AS NEED_DATE ,                                                                                                  \n");
        sbSql.append("                                    A.ITEM_CODE,                                                                                                                                           \n");
        sbSql.append("                                    A.SALE_PRICE                                                                                                                                           \n");
        sbSql.append("                             FROM   HLDC_PO_CONTRACT_FSALE A                                                                                                                               \n");
        sbSql.append("                             WHERE  A.CENTER_CODE = (SELECT A.CENTER_CODE                                                                                                                  \n");
        sbSql.append("                                     FROM   HLDC_PO_UPJANG_CENTER A,                                                                                                                       \n");
        sbSql.append("                                             HLDC_ST_UPJANG B                                                                                                                              \n");
        sbSql.append("                                     WHERE  A.UPJANG = B.AP_UNITPRICE_UPJANG                                                                                                               \n");
        sbSql.append("                                     AND    B.UPJANG = '"+upjang.toString()+"')                                                                                                                             \n");
        sbSql.append("                              AND    A.UPJANG = (SELECT AP_UNITPRICE_UPJANG                                                                                                                \n");
        sbSql.append("                                     FROM   HLDC_ST_UPJANG                                                                                                                                 \n");
        sbSql.append("                                     WHERE  UPJANG = '"+upjang.toString()+"')                                                                                                                               \n");
        sbSql.append("                             AND    A.ITEM_CODE > ' '                                                                                                                                      \n");
        sbSql.append("                             AND    NVL('', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END, '20201231')                                                    \n");
        sbSql.append("                             AND    A.SALE_PRICE > 0                                                                                                                                       \n");
        sbSql.append("                             AND    A.USE_YN = 'Y'                                                                                                                                         \n");
        sbSql.append("                             AND    EXISTS (SELECT 1                                                                                                                                       \n");
        sbSql.append("                                     FROM   HLDC_PO_TREAT_UPJANG X                                                                                                                         \n");
        sbSql.append("                                     WHERE  X.ITEM_CODE = A.ITEM_CODE                                                                                                                      \n");
        sbSql.append("                                     AND    X.UPJANG = A.UPJANG)                                                                                                                           \n");
        sbSql.append("                 -----------                                                                                                                                                               \n");
        sbSql.append("                  UNION ALL                                                                                                                                                                \n");
        sbSql.append("                 -----------                                                                                                                                                               \n");
        sbSql.append("                 SELECT '"+upjang.toString()+"' AS UPJANG                                                                                                                                                   \n");
        sbSql.append("                      , NVL('', TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE                                                                                                                  \n");
        sbSql.append("                      , A.ITEM_CODE, A.SALE_PRICE                                                                                                                                          \n");
        sbSql.append("                   FROM FMP_OTCUST_PRICE_AVA_V A                                                                                                                                           \n");
        sbSql.append("                      ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE                                                                                                                      \n");
        sbSql.append("                          FROM FMP_OTCUST_PRICE_AVA_V                                                                                                                                      \n");
        sbSql.append("                         WHERE UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = '"+upjang.toString()+"')                                                                                 \n");
        sbSql.append("                           AND SDATE <= NVL('', TO_CHAR(SYSDATE,'YYYYMMDD'))                                                                                                               \n");
        sbSql.append("                         GROUP BY UPJANG, ITEM_CODE) B                                                                                                                                     \n");
        sbSql.append("                  WHERE A.UPJANG = B.UPJANG                                                                                                                                                \n");
        sbSql.append("                    AND A.SDATE = B.SDATE                                                                                                                                                  \n");
        sbSql.append("                    AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                          \n");
        sbSql.append("                    AND A.SALE_PRICE > 0                                                                                                                                                   \n");
        sbSql.append("                    AND A.USE_YN = 'Y'                                                                                                                                                     \n");
        sbSql.append("                ) A,                                                                                                                                                                       \n");
        sbSql.append("               FMS_ITEM_V B,                                                                                                                                                               \n");
        sbSql.append("        		 (                                                                                                                                                                               \n");
        sbSql.append("                SELECT A.ITEM_CODE, OP_RATE, OP_PRICE, A.CEIL_VAL                                                                                                                          \n");
        sbSql.append("                  FROM FMU_OP_RATE A                                                                                                                                                       \n");
        sbSql.append("                 WHERE UPJANG = '"+upjang.toString()+"'                                                                                                                                                     \n");
        sbSql.append("                   AND NVL('', TO_CHAR(SYSDATE,'YYYYMMDD')) BETWEEN SDATE AND EDATE                                                                                                        \n");
        sbSql.append("                   AND A.USE_YN = 'Y'                                                                                                                                                      \n");
        sbSql.append("               ) C                                                                                                                                                                         \n");
        sbSql.append("         WHERE SUBSTR(A.ITEM_CODE,1,8) = C.ITEM_CODE(+)                                                                                                                                    \n");
        sbSql.append("           AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                   \n");
        sbSql.append("      ) B -- 단가, g당 단가                                                                                                                                                                \n");
        sbSql.append("      ,FMM_STD_RECIPE_ITEM C                                                                                                                                                               \n");
        sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                                                                                                                        \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+)                                                                                                                                                        \n");
        sbSql.append("   AND (A.ITEM_CODE = '"+itemCode.toString()+"' OR NVL(B.OP_PRICE,0)>0  )                                                                                                                             \n");
        sbSql.append("   AND A.UPJANG = '"+upjang.toString()+"'                                                                                                                                                                 \n");
        sbSql.append("   AND A.ITEM_CODE = '"+itemCode.toString()+"'                                                                                                                        \n");
		
	    sbSql.append("\n\n");
        
        //출력 파라미터 셋팅
		out_vl.add("fa_Sql", sbSql.toString());
		
		//쿼리문 실행
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set으로 부터 데이터셋 생성
		ds_list = this.makeDataSet(rs, "ds_List");
		
		//출력 데이터 리스트에 데이터 셋 추가 
		out_dl.add(ds_list);
		
		//출력 변수리스트에 메세지를 저장
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>