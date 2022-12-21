package com.ifis.fm.fmm;

import com.ifis.sc.scc.CommonUtil;
import com.sz.business.BusinessRuntimeException;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.util.AppDataUtility;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 사업장레시피관리
 */
public class FMM00030E_ACT extends AbstractAction {
	
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	private static final long serialVersionUID = -3709643689347990515L;
// [속도개선 Project   끝] 2017. 7. 7. 최범주	

	/**
	 * 사업장 담당자가 관리하는 업장의 갯수를 조회하여 한 개인 경우 자동 셋팅
	 * @param ctx
	 * @throws Exception
	 */
	public void chkOneUpjang(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sEmpNo = ctx.getInputString("EMP_NO");
		
		// SQL 셋팅
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.append("\nSELECT B.MAIN_UPJANG, A.UPJANG, B.UPJANGNM_DISP AS UPJANGNM	");
		sbQuery.append("\n  FROM FMS_USER_UPJANG A, FMS_UPJANG B						");
		sbQuery.append("\n WHERE A.SABUN = '" + sEmpNo + "'								");
		sbQuery.append("\n   AND A.UPJANG = B.UPJANG									");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    if( dsResult.getRowCount() != 1 ) {
	    	dsResult.clearData();
	    }
	    
	    // Result DataSet Return
    	ctx.addOutput("ds_ONE_UPJANG", dsResult);
	}
	
	/**
	 * 사업장 검색
	 * @param ctx
	 * @throws Exception
	 */
	public void searchUpjang(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sUserKind   = ctx.getInputString("USER_KIND"               );
		int    iUpjang     = 0;
		String sEmpNo      = ctx.getInputString("EMP_NO"                  );
		String sCode       = ctx.getInputString("CODE"                    );
		String sCodeName   = ctx.getInputString("CODE_NAME"               );
		String sOutDataSet = ctx.getInputString("OUT_DataSet"             );
		
		StringBuffer sbQuery = new StringBuffer();
		if( sUserKind.equals("본부") ) {
			sbQuery.append("\nSELECT UPJANG, UPJANGNM_DISP AS UPJANGNM				");
			sbQuery.append("\n  FROM FMS_UPJANG										");
			sbQuery.append("\n WHERE 1 = 1											");
			if( AppDataUtility.isNotNull(sCode) ) {
				sbQuery.append("\n   AND UPJANG LIKE '%" + sCode + "%'				");
			}
			if( AppDataUtility.isNotNull(sCodeName) ) {
				sbQuery.append("\n   AND UPJANGNM_DISP LIKE '%" + sCodeName + "%'	");
			}
			sbQuery.append("\n ORDER BY UPJANG										");
		} else if( sUserKind.equals("본사") ) {
			if( AppDataUtility.isNotNull(ctx.getInputString("UPJANG")) )
				iUpjang = Integer.parseInt(ctx.getInputString("UPJANG"));
			else
				throw new BusinessRuntimeException("g_Upjang 정보가 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
			
			sbQuery.append("\nSELECT UPJANG, UPJANGNM_DISP AS UPJANGNM				");
			sbQuery.append("\n  FROM FMS_UPJANG										");
			sbQuery.append("\n WHERE 1 = 1											");
			sbQuery.append("\n   AND MAIN_UPJANG = " + iUpjang                       ); 
			if( AppDataUtility.isNotNull(sCode) ) {
				sbQuery.append("\n   AND UPJANG LIKE '%" + sCode + "%'				");
			}
			if( AppDataUtility.isNotNull(sCodeName) ) {
				sbQuery.append("\n   AND UPJANGNM_DISP LIKE '%" + sCodeName + "%'	");
			}
			sbQuery.append("\n ORDER BY UPJANG										");
		} else if( sUserKind.equals("사업장") ) {
			sbQuery.append("\nSELECT A.UPJANG, B.UPJANGNM_DISP AS UPJANGNM		");
			sbQuery.append("\n  FROM FMS_USER_UPJANG A, FMS_UPJANG B			");
			sbQuery.append("\n WHERE A.SABUN = '" + sEmpNo + "'					");
			sbQuery.append("\n   AND A.UPJANG = B.UPJANG						");
			sbQuery.append("\n   AND B.UPJANG LIKE '%" + sCode + "%'			");
			sbQuery.append("\n   AND B.UPJANGNM_DISP LIKE '%" + sCodeName + "%'	");
			sbQuery.append("\n ORDER BY A.UPJANG								");
		} else {
			throw new BusinessRuntimeException("g_UserKind 정보가 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput(sOutDataSet, dsResult);
	}
	
	/**
	 * 사업장 식당군 검색
	 * @param ctx
	 * @throws Exception
	 */
	public void searchUpjangSubinvClass(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsSearch = (DataSet) ctx.getInputObject("ds_SEARCH");
		
		// 변수 선언
		int iUpjang = dsSearch.getInt(0, "UPJANG");
		
		StringBuffer sbQuery = new StringBuffer();
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT DISTINCT A.SUBINV_CLASS AS CODE, B.CODE_NAME	");
		sbQuery.append("\n  FROM FMS_SUBINVENTORY A, SCC_COMMON_CODE B			");
		sbQuery.append("\n WHERE A.UPJANG = #UPJANG#						    ");
		sbQuery.append("\n   AND A.SUBINV_CLASS = B.CODE						");
		sbQuery.append("\n   AND B.GROUP_CODE = 'FM0006'						");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		sqlRequest.addParamObject("UPJANG", iUpjang);
// [속도개선 Project   끝] 2017. 7. 7. 최범주

		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_SUBINV_CLASS", dsResult);
	}
	
	/**
	 * 콤보박스 데이터 검색
	 * @param ctx
	 * @throws Exception
	 */
	public void searchComboData(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sGroupCode     = ctx.getInputString("GROUP_CODE"    );
		String sSubinvClass   = ctx.getInputString("SUBINV_CLASS"  );
		String sReturnDataSet = ctx.getInputString("RETURN_DATASET");
		String sAllGubun      = ctx.getInputString("ALL_GUBUN"     );
		
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.setLength(0);
		
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
		if( sGroupCode.equals("FM0006") ) {	// 레시피분류일 경우
			// ALL_GUBUN이 'T'일 경우 '- 전체 -' 포함하여 가져오기
			if( sAllGubun.equals("T") ) {
				sbQuery.append("\nSELECT '000' AS CODE, '- 전체 -' AS CODE_NAME FROM DUAL		");
				sbQuery.append("\n UNION ALL												");
			}
			sbQuery.append("\nSELECT DISTINCT A.SET2 AS CODE, B.CODE_NAME																");
			sbQuery.append("\n  FROM (SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0007' AND SET1 = #SUBINV_CLASS#) A,	        ");
			sbQuery.append("\n       (SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0001') B										");
			sbQuery.append("\n WHERE A.SET2 = B.CODE																					");
		} else if( sGroupCode.equals("FS0002") ) {	// 레시피유형일 경우
			// ALL_GUBUN이 'T'일 경우 '- 전체 -' 포함하여 가져오기
			if( sAllGubun.equals("T") ) {
				sbQuery.append("\nSELECT '000' AS CODE, '- 전체 -' AS CODE_NAME FROM DUAL		");
				sbQuery.append("\n UNION ALL												");
			}
			sbQuery.append("\nSELECT CODE, CODE_NAME							");
			sbQuery.append("\n  FROM (SELECT CODE, CODE_NAME					");
			sbQuery.append("\n          FROM SCC_COMMON_CODE					");
			sbQuery.append("\n         WHERE GROUP_CODE = #GROUP_CODE_1#	    ");
			sbQuery.append("\n           AND SET1 = 'N'							");
			sbQuery.append("\n           AND USE_YN = 'Y'						");
			sbQuery.append("\n         ORDER BY SORT_SEQ)						");
		} else {
			// 조리법유형의 경우 레시피유형별로 Filter를 위해 SET1 컬럼까지 SELECT
			// ALL_GUBUN이 'T'일 경우 '- 전체 -' 포함하여 가져오기
			if( sAllGubun.equals("T") ) {
				sbQuery.append("\nSELECT '000' AS CODE, '- 전체 -' AS CODE_NAME, '' AS SET1 FROM DUAL		");
				sbQuery.append("\n UNION ALL															");
			}
			sbQuery.append("\nSELECT CODE, CODE_NAME, SET1						");
			sbQuery.append("\n  FROM (SELECT CODE, CODE_NAME, SET1				");
			sbQuery.append("\n          FROM SCC_COMMON_CODE					");
			sbQuery.append("\n         WHERE GROUP_CODE = #GROUP_CODE_2#	    ");
			sbQuery.append("\n           AND USE_YN = 'Y'						");
			sbQuery.append("\n         ORDER BY SORT_SEQ)						");
		}
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		if ( sGroupCode.equals("FM0006") ) {
			sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
			
		} else if ( sGroupCode.equals("FS0002") ) {
			sqlRequest.addParamObject("GROUP_CODE_1", sGroupCode);
		} else {
			sqlRequest.addParamObject("GROUP_CODE_2", sGroupCode);
		}
// [속도개선 Project   끝] 2017. 7. 7. 최범주

		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput(sReturnDataSet, dsResult);
	}
	
	/**
	 * 레시피명 콤보박스 검색
	 * @param ctx
	 * @throws Exception
	 */
	public void searchRecipeName(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsSearch = (DataSet) ctx.getInputObject("ds_SEARCH");
		
		// 변수 선언
		int iUpjang = dsSearch.getInt(0, "UPJANG");
		
		StringBuffer sbQuery = new StringBuffer();
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT RECIPE_NAME										");
		sbQuery.append("\n  FROM (SELECT RECIPE_NAME FROM FMR_STD_RECIPE_MST		");
		sbQuery.append("\n         UNION											");
		sbQuery.append("\n        SELECT RECIPE_NAME FROM FMM_STD_RECIPE_MST		");
		sbQuery.append("\n         WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = #UPJANG_1#)	");
		sbQuery.append("\n         UNION											");
		sbQuery.append("\n        SELECT RECIPE_NAME FROM FMM_UPJANG_RECIPE_MST		");
		sbQuery.append("\n         WHERE UPJANG = #UPJANG_2#)					        ");
		sbQuery.append("\n ORDER BY RECIPE_NAME										");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		sqlRequest.addParamObject("UPJANG_1", iUpjang);
		sqlRequest.addParamObject("UPJANG_2", iUpjang);
// [속도개선 Project   끝] 2017. 7. 7. 최범주

		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_RECIPE_NAME", dsResult);
	}
	
	/**
	 * 표준/사업장 레시피 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchRecipeList(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsSearch = (DataSet) ctx.getInputObject("ds_SEARCH");
		
		// 검색조건 DataSet 검증
		if( dsSearch.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int    iMainUpjang   = 0;
		int    iUpjang       = dsSearch.getInt(0, "UPJANG");
		String strOpLen;
		String sSubinvClass  = dsSearch.getString(0, "SUBINV_CLASS");
		String sRecipeClass  = CommonUtil.nullToString(dsSearch.getString(0, "RECIPE_CLASS"), "");
		String sRecipeClass2 = ""; //레시피분류가 전체일 경우 식당군에 딸린 레시피분류만 조회하기 위한 변수
		String sRecipeType   = CommonUtil.nullToString(dsSearch.getString(0, "RECIPE_TYPE" ), "");
		String sCuisineType  = CommonUtil.nullToString(dsSearch.getString(0, "CUISINE_TYPE"), "");
		String sRecipeName   = CommonUtil.nullToString(dsSearch.getString(0, "RECIPE_NAME" ), "");
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성 
	    SqlRequest sqlRequest = null;
	    
	    // Result DataSet
	    DataSet dsStdRecipeMst    = null;
	    DataSet dsUpjangRecipeMst = null;
	    
	    // SQL StringBuffer 변수 생성
	    StringBuffer sbQuery = new StringBuffer();
	    
		/************* 식당군에 딸린 레시피 분류 조회 Start **************************************************/
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	    if( sRecipeClass.equals("000") ) {
			
			sbQuery.setLength(0);
		    sbQuery.append("\nSELECT SET2 							");
		    sbQuery.append("\n  FROM SCC_COMMON_CODE				");
		    sbQuery.append("\n WHERE GROUP_CODE = 'FM0007'			");
		    sbQuery.append("\n   AND SET1 = #SET1#	                ");
		    
		    // SQL 요청자 정보 생성
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("SET1", sSubinvClass);
			
			// Execute Result DataSet
			DataSet dsRecipeClass2 = (DataSet)executor.query(sqlRequest).getResultObject();
		    
			if( dsRecipeClass2.getRowCount() > 0 ) {
				for( int iTmp = 0; iTmp < dsRecipeClass2.getRowCount(); iTmp++ ) {
					if( iTmp == 0 ) {
						sRecipeClass2 = "'" + dsRecipeClass2.getString(iTmp, "SET2") + "'";
					} else {
						sRecipeClass2 += ", '" + dsRecipeClass2.getString(iTmp, "SET2") + "'";
					}
				}
			} else {
				sRecipeClass2 = "''";
			}
		}
		/************* 식당군에 딸린 레시피 분류 조회 End ****************************************************/
		
	    String sTmpChk = dsSearch.getString(0, "FSR_STD_RECIPE") + dsSearch.getString(0, "FMM_STD_RECIPE");
	    String sGbn	   = dsSearch.getString(0, "GBN");
	    /************* 본사코드 조회 Start ***************************************************************/
	    if( !sTmpChk.equals("00") &&  sGbn.equals("0") ) {
	    	if ( sTmpChk.equals("01") || sTmpChk.equals("11") ) {
	    		sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = #UPJANG#");
	    		
	    		// SQL 요청자 정보 생성
	    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    		sqlRequest.addParamObject("UPJANG", iUpjang);
	    		
	    		// Execute Result DataSet
	    		DataSet dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    		
	    		if( dsTemp.getRowCount() == 1 ) {
	    			iMainUpjang = dsTemp.getInt(0, "MAIN_UPJANG");
	    		} else {
	    			throw new Exception("본사 업장코드가 올바르지 않습니다.");
	    		}
	    	}
	    }
	    /************* 본사코드 조회 End *****************************************************************/
		
		/************* 표준 레시피 리스트 조회 Start ********************************************************/
		// SQL Setting
	    if( !sTmpChk.equals("00") &&  sGbn.equals("0") ) {
	    	if( sTmpChk.equals("10") ) {	// 한화(본부) 표준레시피 조회일 경우
		    	 
	    		sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT  ");
	    		sbQuery.append("\n       GUBUN,				--구분 ");
	    		sbQuery.append("\n       RECIPE_CD,			--레시피코드 ");
	    		sbQuery.append("\n       RECIPE_NAME,		--레시피명 ");
	    		sbQuery.append("\n       RECIPE_CLASS,		--레시피분류 ");
	    		sbQuery.append("\n       RECIPE_TYPE,		--레시피유형 ");
	    		sbQuery.append("\n       CUISINE_TYPE,		--조리법유형 ");
	    		sbQuery.append("\n       MAIN_ITEM_CODE1,	--주재료 ");
	    		sbQuery.append("\n       SUM(ROUND(NEED_QTY * OP_PRICE / KG_CONVERT_RATE / 1000)) AS RECIPE_COST,	--레시피원가");
	    		sbQuery.append("\n       RESP_NUT1			--대표영양 ");
	    		sbQuery.append("\n  FROM (SELECT TRIM(A.GUBUN) AS GUBUN, A.RECIPE_CD, A.RECIPE_NAME, B.ITEM_CODE, A.RECIPE_CLASS, A.RECIPE_TYPE, ");
	    		sbQuery.append("\n               A.CUISINE_TYPE, A.MAIN_ITEM_CODE1, SUM(A.NEED_QTY) AS NEED_QTY, B.OP_PRICE, B.KG_CONVERT_RATE, A.RESP_NUT1 ");
	    		sbQuery.append("\n          FROM ( ");
	    		sbQuery.append("\n                SELECT '한화' AS GUBUN,		--구분 ");
	    		sbQuery.append("\n                       A.RECIPE_CD,			--레시피코드 ");
	    		sbQuery.append("\n                       A.RECIPE_NAME,			--레시피명 ");
	    		sbQuery.append("\n                       B.ITEM_CODE,			--자재코드 ");
	    		sbQuery.append("\n                       A.RECIPE_CLASS,		--레시피분류 ");
	    		sbQuery.append("\n                       A.RECIPE_TYPE,         --레시피유형 ");
	    		sbQuery.append("\n                       A.CUISINE_TYPE,        --조리법유형 ");
	    		sbQuery.append("\n                       A.MAIN_ITEM_CODE1,     --주재료 ");
	    		sbQuery.append("\n                       A.RESP_NUT1,           --대표영양 ");
	    		sbQuery.append("\n                       B.NEED_QTY             --1인소요량 ");
	    		sbQuery.append("\n                  FROM FMR_STD_RECIPE_MST A, ");
	    		sbQuery.append("\n                       (SELECT A.RECIPE_CD"	   );
	    		sbQuery.append("\n							   , A.NEED_QTY ");    		
	    		sbQuery.append("\n							   , NVL((SELECT ITEM_CODE_TO FROM FMM_CHG_ITEM_LIST WHERE UPJANG = #UPJANG_1_1# AND A.ITEM_CODE = ITEM_CODE AND A.USE_YN = 'Y'), A.ITEM_CODE) AS ITEM_CODE");
	    		//sbQuery.append("\n               	   		   , FMM_CHGITEM_FUN(" + iUpjang + ", ITEM_CODE) AS ITEM_CODE ");
	    		sbQuery.append("\n                          FROM FMR_STD_RECIPE_ITEM A) B ");
	    		sbQuery.append("\n                 WHERE 1 = 1 ");
	    		sbQuery.append("\n                -- 검색조건(식당군, 레시피분류, 레시피유형, 조리법유형, 레시피명) -- ");
	    		if( !sRecipeClass.equals("000") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_CLASS = #RECIPE_CLASS_1_1# /* 선택 검색조건(레시피분류) */ ");
	    		} else {
	    			sbQuery.append("\n                   AND A.RECIPE_CLASS IN (" + sRecipeClass2 + ")");
	    		}
	    		if( !sRecipeType.equals("000") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_TYPE = #RECIPE_TYPE_1_1# /* 선택 검색조건(레시피유형) */ ");
	    		}
	    		if( !sCuisineType.equals("000") ) {
	    			sbQuery.append("\n                   AND A.CUISINE_TYPE = #CUISINE_TYPE_1_1# /* 선택 검색조건(조리법유형) */ ");
	    		}
	    		if( !sRecipeName.equals("") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_NAME LIKE #RECIPE_NAME_1_1# /* 선택 검색조건(레시피명) */ ");
	    		}
	    		sbQuery.append("\n                ------------------------------------------------------------ ");
	    		sbQuery.append("\n                       AND A.RECIPE_CD = B.RECIPE_CD ");
	    		sbQuery.append("\n               ) A, ");
	    		sbQuery.append("\n               ( ");
	    		sbQuery.append("\n                SELECT  ");
	    		sbQuery.append("\n                       A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE ");
	    		sbQuery.append("\n                     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    		sbQuery.append("\n                            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    		sbQuery.append("\n                            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    		sbQuery.append("\n                            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    		sbQuery.append("\n                            ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)");
	    		sbQuery.append("\n                  FROM ");
	    		sbQuery.append("\n                       ( ");
	    		sbQuery.append("\n                        SELECT #UPJANG_1_2# AS UPJANG ");
	    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
	    		sbQuery.append("\n                             , C.ITEM_CODE, C.SALE_PRICE ");
	    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE C, HLDC_ST_UPJANG D ");
	    		sbQuery.append("\n                         WHERE C.UPJANG = D.AP_UNITPRICE_UPJANG ");
	    		sbQuery.append("\n                           AND D.UPJANG = #UPJANG_1_3#");
	    		sbQuery.append("\n                           AND C.ITEM_CODE > ' ' ");
	    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') ");
	    		sbQuery.append("\n                           AND C.SALE_PRICE > 0 ");
	    		sbQuery.append("\n                        ----------- ");
	    		sbQuery.append("\n                         UNION ALL ");
	    		sbQuery.append("\n                        ----------- ");
	    		sbQuery.append("\n                        SELECT #UPJANG_1_4# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE ");
	    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A , ");
	    		sbQuery.append("\n                               ( ");
	    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
	    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
	    		sbQuery.append("\n                                 WHERE UPJANG = ");
	    		sbQuery.append("\n                                       ( ");
	    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
	    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
	    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_1_5#");
	    		sbQuery.append("\n                                       ) ");
	    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
	    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
	    		sbQuery.append("\n                               ) B ");
	    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
	    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
	    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
	    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
	    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n                       ) A, ");
	    		sbQuery.append("\n                       FMS_ITEM_V B, ");
	    		sbQuery.append("\n                       ( ");
	    		sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    		sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    		sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_1_6#");
	    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    		sbQuery.append("\n                           AND ITEM_TYPE = 'M' ");
	    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n                       ) C, ");
	    		sbQuery.append("\n                       ( ");
	    		sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    		sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    		sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_1_7#");
	    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    		sbQuery.append("\n                           AND ITEM_TYPE = 'C' ");
	    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n                       ) D ");
	    		sbQuery.append("\n                 WHERE A.ITEM_CODE = B.ITEM_CODE ");
	    		sbQuery.append("\n                   AND A.ITEM_CODE = C.ITEM_CODE(+) ");
	    		sbQuery.append("\n                   AND B.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    		sbQuery.append("\n               ) B ");
	    		sbQuery.append("\n          WHERE A.ITEM_CODE = B.ITEM_CODE(+) ");
	    		sbQuery.append("\n          GROUP BY TRIM(A.GUBUN), A.RECIPE_CD, A.RECIPE_NAME, B.ITEM_CODE, A.RECIPE_CLASS, A.RECIPE_TYPE, ");
	    		sbQuery.append("\n                   A.CUISINE_TYPE, A.MAIN_ITEM_CODE1, B.OP_PRICE, B.KG_CONVERT_RATE, A.RESP_NUT1) ");
	    		sbQuery.append("\n GROUP BY GUBUN, RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, RESP_NUT1 ");
	    		sbQuery.append("\n ORDER BY GUBUN, RECIPE_CD ");
	    		
		    } else if( sTmpChk.equals("01") ) {		// 본사 표준레시피 조회일 경우
		    	
		    	sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT  ");
	    		sbQuery.append("\n       TRIM(A.GUBUN) AS GUBUN,  --구분 ");
	    		sbQuery.append("\n       A.RECIPE_CD,        --레시피코드 ");
	    		sbQuery.append("\n       A.RECIPE_NAME,      --레시피명 ");
	    		sbQuery.append("\n       A.RECIPE_CLASS,     --레시피분류 ");
	    		sbQuery.append("\n       A.RECIPE_TYPE,      --레시피유형 ");
	    		sbQuery.append("\n       A.CUISINE_TYPE,     --조리법유형 ");
	    		sbQuery.append("\n       A.MAIN_ITEM_CODE1,  --주재료 ");
	    		sbQuery.append("\n       SUM(ROUND(A.NEED_QTY * B.OP_PRICE / B.KG_CONVERT_RATE / 1000)) AS RECIPE_COST, --레시피원가");
	    		sbQuery.append("\n       A.RESP_NUT1         --대표영양 ");
	    		sbQuery.append("\n  FROM ");
	    		sbQuery.append("\n     ( ");
	    		sbQuery.append("\n       SELECT '본사' AS GUBUN,       --구분 ");
	    		sbQuery.append("\n              A.RECIPE_CD,           --레시피코드 ");
	    		sbQuery.append("\n              A.RECIPE_NAME,         --레시피명 ");
	    		//sbQuery.append("\n              FMM_CHGITEM_FUN(" + iUpjang + ", B.ITEM_CODE) ITEM_CODE,	       --자재코드 ");		
	    		sbQuery.append("\n				NVL((SELECT ITEM_CODE_TO FROM FMM_CHG_ITEM_LIST WHERE UPJANG = #UPJANG_2_1# AND B.ITEM_CODE = ITEM_CODE AND B.USE_YN = 'Y'), B.ITEM_CODE) AS ITEM_CODE,");
	    		sbQuery.append("\n              A.RECIPE_CLASS,        --레시피분류 ");
	    		sbQuery.append("\n              A.RECIPE_TYPE,         --레시피유형 ");
	    		sbQuery.append("\n              A.CUISINE_TYPE,        --조리법유형 ");
	    		sbQuery.append("\n              A.MAIN_ITEM_CODE1,     --주재료 ");
	    		sbQuery.append("\n              A.RESP_NUT1,           --대표영양 ");
	    		sbQuery.append("\n              B.NEED_QTY  		   --1인소요량 ");
	    		sbQuery.append("\n         FROM FMM_STD_RECIPE_MST A, ");
	    		sbQuery.append("\n              FMM_STD_RECIPE_ITEM B ");
	    		sbQuery.append("\n        WHERE 1 = 1 ");
	    		sbQuery.append("\n       -- 검색조건(식당군, 레시피분류, 레시피유형, 조리법유형, 레시피명) -- ");
	    		sbQuery.append("\n          AND A.UPJANG = #MAIN_UPJANG_1#");
	    		if( !sRecipeClass.equals("000") ) {
	    			sbQuery.append("\n          AND A.RECIPE_CLASS = #RECIPE_CLASS_2_1# /* 선택 검색조건(레시피분류) */ ");
	    		} else {
	    			sbQuery.append("\n          AND A.RECIPE_CLASS IN (" + sRecipeClass2 + ")");
	    		}
	    		if( !sRecipeType.equals("000") ) {
	    			sbQuery.append("\n          AND A.RECIPE_TYPE = #RECIPE_TYPE_2_1# /* 선택 검색조건(레시피유형) */ ");
	    		}
	    		if( !sCuisineType.equals("000") ) {
	    			sbQuery.append("\n          AND A.CUISINE_TYPE = #CUISINE_TYPE_2_1# /* 선택 검색조건(조리법유형) */ ");
	    		}
	    		if( !sRecipeName.equals("") ) {
	    			sbQuery.append("\n          AND A.RECIPE_NAME LIKE #RECIPE_NAME_2_1# /* 선택 검색조건(레시피명) */ ");
	    		}
	    		sbQuery.append("\n       ------------------------------------------------------------ ");
	    		sbQuery.append("\n          AND A.RECIPE_CD = B.RECIPE_CD ");
	    		sbQuery.append("\n     ) A, ");
	    		sbQuery.append("\n     ( ");
	    		sbQuery.append("\n      SELECT  ");
	    		sbQuery.append("\n             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE ");
	    		
	    		sbQuery.append("\n           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    		sbQuery.append("\n                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    		sbQuery.append("\n                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    		sbQuery.append("\n                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    		sbQuery.append("\n                  ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) ");
	    		sbQuery.append("\n        FROM ");
	    		sbQuery.append("\n             ( ");
	    		sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    		sbQuery.append("\n                FROM FMU_OP_RATE A");
	    		sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_2_2#");
	    		sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    		sbQuery.append("\n                 AND ITEM_TYPE = 'M' ");
	    		sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n             ) C, ");
	    		sbQuery.append("\n             ( ");
	    		sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    		sbQuery.append("\n                FROM FMU_OP_RATE A");
	    		sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_2_3#");
	    		sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    		sbQuery.append("\n                 AND ITEM_TYPE = 'C' ");
	    		sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n             ) D, ");
	    		sbQuery.append("\n             ( ");
	    		sbQuery.append("\n                        SELECT #UPJANG_2_4# AS UPJANG ");
	    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
	    		sbQuery.append("\n                             , C.ITEM_CODE, C.SALE_PRICE ");
	    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE C, HLDC_ST_UPJANG D ");
	    		sbQuery.append("\n                         WHERE C.UPJANG = D.AP_UNITPRICE_UPJANG ");
	    		sbQuery.append("\n                           AND D.UPJANG = #UPJANG_2_5#");
	    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') ");
	    		sbQuery.append("\n                           AND C.SALE_PRICE > 0 ");
	    		sbQuery.append("\n                        ----------- ");
	    		sbQuery.append("\n                         UNION ALL ");
	    		sbQuery.append("\n                        ----------- ");
	    		sbQuery.append("\n                        SELECT #UPJANG_2_6# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE ");
	    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A , ");
	    		sbQuery.append("\n                               ( ");
	    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
	    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
	    		sbQuery.append("\n                                 WHERE UPJANG = ");
	    		sbQuery.append("\n                                       ( ");
	    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
	    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
	    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_2_7#");
	    		sbQuery.append("\n                                       ) ");
	    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
	    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
	    		sbQuery.append("\n                               ) B ");
	    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
	    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
	    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
	    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
	    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n             ) A, ");
	    		sbQuery.append("\n             FMS_ITEM_V B ");
	    		sbQuery.append("\n       WHERE A.ITEM_CODE = B.ITEM_CODE ");
	    		sbQuery.append("\n         AND A.ITEM_CODE = C.ITEM_CODE(+) ");
	    		sbQuery.append("\n         AND B.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    		sbQuery.append("\n       ) B ");
	    		sbQuery.append("\n WHERE A.ITEM_CODE = B.ITEM_CODE(+) ");
	    		sbQuery.append("\n GROUP BY A.GUBUN, A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.MAIN_ITEM_CODE1, A.RESP_NUT1 ");
	    		sbQuery.append("\n ORDER BY A.RECIPE_CD ");
	    		
		    } else if( sTmpChk.equals("11") ) {		// 한화(본부)/본사 표준레시피 조회일 경우
		    	//sqlRequest = SqlMapManagerUtility.makeSqlRequest("fm/fmm:FMM00030E_S003");
		    	
		    	sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT  ");
	    		sbQuery.append("\n       GUBUN,				--구분 ");
	    		sbQuery.append("\n       RECIPE_CD,			--레시피코드 ");
	    		sbQuery.append("\n       RECIPE_NAME,		--레시피명 ");
	    		sbQuery.append("\n       RECIPE_CLASS,		--레시피분류 ");
	    		sbQuery.append("\n       RECIPE_TYPE,		--레시피유형 ");
	    		sbQuery.append("\n       CUISINE_TYPE,		--조리법유형 ");
	    		sbQuery.append("\n       MAIN_ITEM_CODE1,	--주재료 ");
	    		sbQuery.append("\n       SUM(ROUND(NEED_QTY * OP_PRICE / KG_CONVERT_RATE / 1000)) AS RECIPE_COST,	--레시피원가 ");
	    		sbQuery.append("\n       RESP_NUT1			--대표영양 ");
	    		sbQuery.append("\n  FROM (SELECT TRIM(A.GUBUN) AS GUBUN, A.RECIPE_CD, A.RECIPE_NAME, B.ITEM_CODE, A.RECIPE_CLASS, A.RECIPE_TYPE, ");
	    		sbQuery.append("\n               A.CUISINE_TYPE, A.MAIN_ITEM_CODE1, SUM(A.NEED_QTY) AS NEED_QTY, B.OP_PRICE, B.KG_CONVERT_RATE, A.RESP_NUT1 ");
	    		sbQuery.append("\n          FROM ( ");
	    		sbQuery.append("\n                SELECT '한화' AS GUBUN,		--구분 ");
	    		sbQuery.append("\n                       A.RECIPE_CD,			--레시피코드 ");
	    		sbQuery.append("\n                       A.RECIPE_NAME,			--레시피명 ");
	    		sbQuery.append("\n                       B.ITEM_CODE,			--자재코드 ");
	    		sbQuery.append("\n                       A.RECIPE_CLASS,		--레시피분류 ");
	    		sbQuery.append("\n                       A.RECIPE_TYPE,			--레시피유형 ");
	    		sbQuery.append("\n                       A.CUISINE_TYPE,		--조리법유형 ");
	    		sbQuery.append("\n                       A.MAIN_ITEM_CODE1,		--주재료 ");
	    		sbQuery.append("\n                       A.RESP_NUT1,			--대표영양 ");
	    		sbQuery.append("\n                       B.NEED_QTY 			--1인소요량 ");
	    		sbQuery.append("\n                  FROM FMR_STD_RECIPE_MST A, ");    		
	    		sbQuery.append("\n                       (SELECT A.RECIPE_CD"	   );
	    		sbQuery.append("\n							   , A.NEED_QTY ");    		
	    		sbQuery.append("\n							   , NVL((SELECT ITEM_CODE_TO FROM FMM_CHG_ITEM_LIST WHERE UPJANG = #UPJANG_3_1# AND A.ITEM_CODE = ITEM_CODE AND A.USE_YN = 'Y'), A.ITEM_CODE) AS ITEM_CODE");
	    		//sbQuery.append("\n               	   		   , FMM_CHGITEM_FUN(" + iUpjang + ", ITEM_CODE) AS ITEM_CODE ");
	    		sbQuery.append("\n                          FROM FMR_STD_RECIPE_ITEM A) B ");	    		
	    		sbQuery.append("\n                 WHERE 1 = 1 ");
	    		sbQuery.append("\n                -- 검색조건(식당군, 레시피분류, 레시피유형, 조리법유형, 레시피명) -- ");
	    		if( !sRecipeClass.equals("000") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_CLASS = #RECIPE_CLASS_3_1# /* 선택 검색조건(레시피분류) */ ");
	    		} else {
	    			sbQuery.append("\n                   AND A.RECIPE_CLASS IN (" + sRecipeClass2 + ")");
	    		}
	    		if( !sRecipeType.equals("000") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_TYPE = #RECIPE_TYPE_3_1# /* 선택 검색조건(레시피유형) */ ");
	    		}
	    		if( !sCuisineType.equals("000") ) {
	    			sbQuery.append("\n                   AND A.CUISINE_TYPE = #CUISINE_TYPE_3_1# /* 선택 검색조건(조리법유형) */ ");
	    		}
	    		if( !sRecipeName.equals("") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_NAME LIKE #RECIPE_NAME_3_2# /* 선택 검색조건(레시피명) */ ");
	    		}
	    		sbQuery.append("\n                ------------------------------------------------------------ ");
	    		sbQuery.append("\n                   AND A.RECIPE_CD = B.RECIPE_CD ");
	    		sbQuery.append("\n                 UNION ALL ");
	    		sbQuery.append("\n                SELECT '본사' AS GUBUN,       --구분 ");
	    		sbQuery.append("\n                       A.RECIPE_CD,           --레시피코드 ");
	    		sbQuery.append("\n                       A.RECIPE_NAME,         --레시피명 ");
	    		sbQuery.append("\n                       B.ITEM_CODE,			 --자재코드 ");
	    		sbQuery.append("\n                       A.RECIPE_CLASS,        --레시피분류 ");
	    		sbQuery.append("\n                       A.RECIPE_TYPE,         --레시피유형 ");
	    		sbQuery.append("\n                       A.CUISINE_TYPE,        --조리법유형 ");
	    		sbQuery.append("\n                       A.MAIN_ITEM_CODE1,     --주재료 ");
	    		sbQuery.append("\n                       A.RESP_NUT1,           --대표영양 ");
	    		sbQuery.append("\n                       B.NEED_QTY 			--1인소요량 ");
	    		sbQuery.append("\n                  FROM FMM_STD_RECIPE_MST A, ");
	    		sbQuery.append("\n                       FMM_STD_RECIPE_ITEM B ");
	    		sbQuery.append("\n                 WHERE 1 = 1 ");
	    		sbQuery.append("\n                -- 검색조건(식당군, 레시피분류, 레시피유형, 조리법유형, 레시피명) -- ");
	    		sbQuery.append("\n                   AND A.UPJANG = #MAIN_UPJANG_2#");
	    		if( !sRecipeClass.equals("000") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_CLASS = #RECIPE_CLASS_3_2# /* 선택 검색조건(레시피분류) */ ");
	    		} else {
	    			sbQuery.append("\n                   AND A.RECIPE_CLASS IN (" + sRecipeClass2 + ")");
	    		}
	    		if( !sRecipeType.equals("000") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_TYPE = #RECIPE_TYPE_3_2# /* 선택 검색조건(레시피유형) */ ");
	    		}
	    		if( !sCuisineType.equals("000") ) {
	    			sbQuery.append("\n                   AND A.CUISINE_TYPE = #CUISINE_TYPE_3_2# /* 선택 검색조건(조리법유형) */ ");
	    		}
	    		if( !sRecipeName.equals("") ) {
	    			sbQuery.append("\n                   AND A.RECIPE_NAME LIKE #RECIPE_NAME_3_2# /* 선택 검색조건(레시피명) */ ");
	    		}
	    		sbQuery.append("\n                ------------------------------------------------------------ ");
	    		sbQuery.append("\n                   AND A.RECIPE_CD = B.RECIPE_CD ");
	    		sbQuery.append("\n               ) A, ");
	    		sbQuery.append("\n               ( ");
	    		sbQuery.append("\n                SELECT ");
	    		sbQuery.append("\n                       A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE ");
	    		sbQuery.append("\n                     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    		sbQuery.append("\n                            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    		sbQuery.append("\n                            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    		sbQuery.append("\n                            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    		sbQuery.append("\n                            ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) ");
	    		sbQuery.append("\n                  FROM ");
	    		sbQuery.append("\n                       ( ");
	    		sbQuery.append("\n                        SELECT #UPJANG_3_2# AS UPJANG ");
	    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
	    		sbQuery.append("\n                             , C.ITEM_CODE, C.SALE_PRICE ");
	    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE C, HLDC_ST_UPJANG D ");
	    		sbQuery.append("\n                         WHERE C.UPJANG = D.AP_UNITPRICE_UPJANG ");
	    		sbQuery.append("\n                           AND D.UPJANG = #UPJANG_3_3#");
	    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') ");
	    		sbQuery.append("\n                           AND C.SALE_PRICE > 0 ");
	    		sbQuery.append("\n                        ----------- ");
	    		sbQuery.append("\n                         UNION ALL ");
	    		sbQuery.append("\n                        ----------- ");
	    		sbQuery.append("\n                        SELECT #UPJANG_3_4# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE ");
	    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A , ");
	    		sbQuery.append("\n                               ( ");
	    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
	    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
	    		sbQuery.append("\n                                 WHERE UPJANG = ");
	    		sbQuery.append("\n                                       ( ");
	    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
	    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
	    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_3_5#");
	    		sbQuery.append("\n                                       ) ");
	    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
	    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
	    		sbQuery.append("\n                               ) B ");
	    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
	    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
	    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
	    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
	    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n                       ) A, ");
	    		sbQuery.append("\n                       FMS_ITEM_V B, ");
	    		sbQuery.append("\n                       ( ");
	    		sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    		sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    		sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_3_6#");
	    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    		sbQuery.append("\n                           AND ITEM_TYPE = 'M' ");
	    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n                       ) C, ");
	    		sbQuery.append("\n                       ( ");
	    		sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    		sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    		sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_3_7#");
	    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    		sbQuery.append("\n                           AND ITEM_TYPE = 'C' ");
	    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    		sbQuery.append("\n                       ) D ");
	    		sbQuery.append("\n                 WHERE A.ITEM_CODE = B.ITEM_CODE ");
	    		sbQuery.append("\n                   AND A.ITEM_CODE = C.ITEM_CODE(+) ");
	    		sbQuery.append("\n                   AND B.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    		sbQuery.append("\n               ) B ");
	    		sbQuery.append("\n         WHERE A.ITEM_CODE = B.ITEM_CODE(+) ");
	    		sbQuery.append("\n         GROUP BY TRIM(A.GUBUN), A.RECIPE_CD, A.RECIPE_NAME, B.ITEM_CODE, A.RECIPE_CLASS, A.RECIPE_TYPE, ");
	    		sbQuery.append("\n                  A.CUISINE_TYPE, A.MAIN_ITEM_CODE1, B.OP_PRICE, B.KG_CONVERT_RATE, A.RESP_NUT1) ");
	    		sbQuery.append("\n GROUP BY GUBUN, RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, RESP_NUT1 ");
	    		sbQuery.append("\n ORDER BY GUBUN, RECIPE_CD ");
	    		
		    }
		    
	    	// SQL 요청자 정보 생성
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    	if( sTmpChk.equals("10") ) {	// 한화(본부) 표준레시피 조회일 경우
	    		sqlRequest.addParamObject("UPJANG_1_1", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_1_2", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_1_3", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_1_4", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_1_5", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_1_6", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_1_7", iUpjang);
	    		if( !sRecipeClass.equals("000") ) {
	    			sqlRequest.addParamObject("RECIPE_CLASS_1_1", sRecipeClass);
	    		}
	    		if( !sRecipeType.equals("000") ) {
	    			sqlRequest.addParamObject("RECIPE_TYPE_1_1", sRecipeType);
	    		}
	    		if( !sCuisineType.equals("000") ) {
	    			sqlRequest.addParamObject("CUISINE_TYPE_1_1", sCuisineType);
	    		}
	    		if( !sRecipeName.equals("") ) {
	    			sqlRequest.addParamObject("RECIPE_NAME_1_1", "%" + sRecipeName + "%");
	    		}
	    		
		    } else if( sTmpChk.equals("01") ) {		// 본사 표준레시피 조회일 경우
	    		sqlRequest.addParamObject("UPJANG_2_1", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_2_2", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_2_3", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_2_4", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_2_5", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_2_6", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_2_7", iUpjang);
	    		sqlRequest.addParamObject("MAIN_UPJANG_1", iMainUpjang);
	    		if( !sRecipeClass.equals("000") ) {
	    			sqlRequest.addParamObject("RECIPE_CLASS_2_1", sRecipeClass);
	    		}
	    		if( !sRecipeType.equals("000") ) {
	    			sqlRequest.addParamObject("RECIPE_TYPE_2_1", sRecipeType);
	    		}
	    		if( !sCuisineType.equals("000") ) {
	    			sqlRequest.addParamObject("CUISINE_TYPE_2_1", sCuisineType);
	    		}
	    		if( !sRecipeName.equals("") ) {
	    			sqlRequest.addParamObject("RECIPE_NAME_2_1", "%" + sRecipeName + "%");
	    		}
	    		
		    } else if( sTmpChk.equals("11") ) {		// 한화(본부)/본사 표준레시피 조회일 경우
	    		sqlRequest.addParamObject("UPJANG_3_1", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_3_2", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_3_3", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_3_4", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_3_5", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_3_6", iUpjang);
	    		sqlRequest.addParamObject("UPJANG_3_7", iUpjang);

	    		if( !sRecipeClass.equals("000") ) {
	    			sqlRequest.addParamObject("RECIPE_CLASS_3_1", sRecipeClass);
	    			sqlRequest.addParamObject("RECIPE_CLASS_3_2", sRecipeClass);
	    		}
	    		if( !sRecipeType.equals("000") ) {
	    			sqlRequest.addParamObject("RECIPE_TYPE_3_1", sRecipeType);
	    			sqlRequest.addParamObject("RECIPE_TYPE_3_2", sRecipeType);
	    		}
	    		if( !sCuisineType.equals("000") ) {
	    			sqlRequest.addParamObject("CUISINE_TYPE_3_1", sCuisineType);
	    			sqlRequest.addParamObject("CUISINE_TYPE_3_2", sCuisineType);
	    		}
	    		if( !sRecipeName.equals("") ) {
	    			sqlRequest.addParamObject("RECIPE_NAME_3_1", "%" + sRecipeName + "%");
	    			sqlRequest.addParamObject("RECIPE_NAME_3_2", "%" + sRecipeName + "%");
	    		}
	    		sqlRequest.addParamObject("MAIN_UPJANG_2", iMainUpjang);
		    }			
			
			// Execute Result DataSet
			dsStdRecipeMst = (DataSet)executor.query(sqlRequest).getResultObject();
	    }
		/************* 표준 레시피 리스트 조회 End **********************************************************/
		
		/************* 업장 레시피 리스트 조회 Start ********************************************************/
		// SQL Setting
	    sTmpChk = dsSearch.getString(0, "UPJANG_RECIPE");
	    if( sTmpChk.equals("1") ) {
			
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT A.RECIPE_CD, --레시피코드 ");
	    	sbQuery.append("\n       A.RECIPE_NAME, --레시피명 ");
	    	sbQuery.append("\n       SUM(ROUND(B.NEED_QTY * C.OP_PRICE / C.KG_CONVERT_RATE / 1000)) AS RECIPE_COST, --레시피원가");
	    	sbQuery.append("\n       A.RECIPE_CLASS, --레시피분류 ");
	    	sbQuery.append("\n       A.RECIPE_TYPE, --레시피유형 ");
	    	sbQuery.append("\n       A.CUISINE_TYPE, --조리법유형 ");
	    	sbQuery.append("\n       A.MAIN_ITEM_CODE1, --주재료 ");
	    	sbQuery.append("\n	     A.RESP_NUT1 --대표영양 ");
	    	sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_MST A, ");
	    	sbQuery.append("\n       FMM_UPJANG_RECIPE_ITEM B, ");
	    	sbQuery.append("\n      ( ");
	    	sbQuery.append("\n      SELECT ");
	    	sbQuery.append("\n             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE ");
	    	sbQuery.append("\n           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
    		sbQuery.append("\n                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
    		sbQuery.append("\n                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
    		sbQuery.append("\n                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
    		sbQuery.append("\n                  ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가) ");
	    	sbQuery.append("\n        FROM ");
	    	sbQuery.append("\n             ( ");
    		sbQuery.append("\n                        SELECT #UPJANG_4_1# AS UPJANG ");
    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
    		sbQuery.append("\n                             , C.ITEM_CODE, C.SALE_PRICE ");
    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE C, HLDC_ST_UPJANG D ");
    		sbQuery.append("\n                         WHERE C.UPJANG = D.AP_UNITPRICE_UPJANG ");
    		sbQuery.append("\n                           AND D.UPJANG = #UPJANG_4_2#");
    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') ");
    		sbQuery.append("\n                           AND C.SALE_PRICE > 0 ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                         UNION ALL ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                        SELECT #UPJANG_4_3# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE ");
    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A , ");
    		sbQuery.append("\n                               ( ");
    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
    		sbQuery.append("\n                                 WHERE UPJANG = ");
    		sbQuery.append("\n                                       ( ");
    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_4_4#");
    		sbQuery.append("\n                                       ) ");
    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
    		sbQuery.append("\n                               ) B ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) A, ");
	    	sbQuery.append("\n             FMS_ITEM_V B, ");
	    	sbQuery.append("\n             ( ");
    		sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
    		sbQuery.append("\n                FROM FMU_OP_RATE A");
    		sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_4_5#");
    		sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
    		sbQuery.append("\n                 AND ITEM_TYPE = 'M' ");
    		sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
    		sbQuery.append("\n             ) C, ");
    		sbQuery.append("\n             ( ");
    		sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
    		sbQuery.append("\n                FROM FMU_OP_RATE A");
    		sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_4_6#");
    		sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
    		sbQuery.append("\n                 AND ITEM_TYPE = 'C' ");
    		sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
    		sbQuery.append("\n             ) D ");
    		sbQuery.append("\n       WHERE A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n         AND A.ITEM_CODE = C.ITEM_CODE(+) ");
    		sbQuery.append("\n         AND B.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    	sbQuery.append("\n      ) C ");
	    	sbQuery.append("\n WHERE 1 = 1 ");
	    	sbQuery.append("\n  -- 검색조건(업장, 식당군, 레시피분류, 레시피유형, 조리법유형, 레시피명) -- ");
	    	sbQuery.append("\n   AND A.UPJANG = #UPJANG_4_7# /* 필수 검색조건(업장코드) */ ");
	    	sbQuery.append("\n   AND A.SUBINV_CLASS = #SUBINV_CLASS# /* 필수 검색조건(식당군) */ ");
	    	if( !sRecipeClass.equals("000") ) {
	    		sbQuery.append("\n   AND A.RECIPE_CLASS = #RECIPE_CLASS_4_1# /* 선택 검색조건(레시피분류) */ ");
    		}
    		if( !sRecipeType.equals("000") ) {
    			sbQuery.append("\n   AND A.RECIPE_TYPE = #RECIPE_TYPE_4_1# /* 선택 검색조건(레시피유형) */ ");
    		}
    		if( !sCuisineType.equals("000") ) {
    			sbQuery.append("\n   AND A.CUISINE_TYPE = #CUISINE_TYPE_4_1# /* 선택 검색조건(조리법유형) */ ");
    		}
    		if( !sRecipeName.equals("") ) {
    			sbQuery.append("\n   AND A.RECIPE_NAME LIKE #RECIPE_NAME_4_1# /* 선택 검색조건(레시피명) */ ");
    		}
	    	sbQuery.append("\n  -------------------------------------------------------------------------- ");
	    	sbQuery.append("\n   AND A.RECIPE_CD = B.RECIPE_CD ");
	    	sbQuery.append("\n   AND A.UPJANG = B.UPJANG ");
	    	sbQuery.append("\n   AND A.SUBINV_CLASS = B.SUBINV_CLASS ");
	    	sbQuery.append("\n   AND B.ITEM_CODE = C.ITEM_CODE(+) ");
	    	sbQuery.append("\n GROUP BY A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.MAIN_ITEM_CODE1, A.RESP_NUT1 ");
	    	sbQuery.append("\n ORDER BY A.RECIPE_CD ");

			// SQL 요청자 정보 생성
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
    		sqlRequest.addParamObject("UPJANG_4_1", iUpjang);
    		sqlRequest.addParamObject("UPJANG_4_2", iUpjang);
    		sqlRequest.addParamObject("UPJANG_4_3", iUpjang);
    		sqlRequest.addParamObject("UPJANG_4_4", iUpjang);
    		sqlRequest.addParamObject("UPJANG_4_5", iUpjang);
    		sqlRequest.addParamObject("UPJANG_4_6", iUpjang);
    		sqlRequest.addParamObject("UPJANG_4_7", iUpjang);
    		sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
    		if( !sRecipeClass.equals("000") ) {
    			sqlRequest.addParamObject("RECIPE_CLASS_4_1", sRecipeClass);
    		}
    		if( !sRecipeType.equals("000") ) {
    			sqlRequest.addParamObject("RECIPE_TYPE_4_1", sRecipeType);
    		}
    		if( !sCuisineType.equals("000") ) {
    			sqlRequest.addParamObject("CUISINE_TYPE_4_1", sCuisineType);
    		}
    		if( !sRecipeName.equals("") ) {
    			sqlRequest.addParamObject("RECIPE_NAME_4_1", "%" + sRecipeName + "%");
    		}
			
			// Execute Result DataSet
			dsUpjangRecipeMst = (DataSet)executor.query(sqlRequest).getResultObject();
	    }
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		/************* 업장 레시피 리스트 조회 End **********************************************************/
		
	    // Result DataSet Return
		ctx.addOutput("ds_STD_RECIPE_MST",    dsStdRecipeMst   );
		ctx.addOutput("ds_UPJANG_RECIPE_MST", dsUpjangRecipeMst);
	
	}
	
	/**
	 * 레시피 상세정보 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchRecipeInfo(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_INPUT");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수설정
		String sGubun       = dsInput.getString(0, "GUBUN");
		int    iMainUpjang  = 0;
		int    iUpjang      = dsInput.getInt(0, "UPJANG");
		String strOpLen;
		String sRecipeCd    = dsInput.getString(0, "RECIPE_CD");
		String sSubinvClass = dsInput.getString(0, "SUBINV_CLASS");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = null;
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Result DataSet
	    DataSet dsRecipeInfo = null;
	    
	    // SQL StringBuffer 변수 생성
	    StringBuffer sbQuery = new StringBuffer();
	    
	    /************* 본사코드 조회 Start ***************************************************************/
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	    if ( sGubun.equals("본사") ) {
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT MAIN_UPJANG");
	    	sbQuery.append("\n  FROM FMS_UPJANG");
	    	sbQuery.append("\n WHERE UPJANG = #UPJANG#");
	    	
	    	// SQL 요청자 정보 생성
	    	sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    	sqlRequest.addParamObject("UPJANG", iUpjang);
	    	
	    	// Execute Result DataSet
	    	DataSet dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    	
	    	if( dsTemp.getRowCount() == 1 ) {
	    		iMainUpjang = dsTemp.getInt(0, "MAIN_UPJANG");
	    	} else {
	    		throw new Exception("본사 업장코드가 올바르지 않습니다.");
	    	}
	    }
	    /************* 본사코드 조회 End *****************************************************************/
	    
	    if( sGubun.equals("한화") ) {
	    	
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT TRIM(#GUBUN_1#) AS GUBUN, #UPJANG_1_1# AS UPJANG, #SUBINV_CLASS_1# AS SUBINV_CLASS, RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, ");
	    	sbQuery.append("\n       MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, ");
	    	sbQuery.append("\n       RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, ");
	    	sbQuery.append("\n       AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, ");
	    	sbQuery.append("\n       SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, '' AS PREFER, PHF_MGMT_YN, ");
	    	sbQuery.append("\n       PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, ");
	    	sbQuery.append("\n       SPHOTO_PATH, '' AS REMARK, USE_YN, ");
	    	sbQuery.append("\n       NVL(SUM(ROUND(NEED_QTY * OP_PRICE / KG_CONVERT_RATE / 1000)), 0) AS RECIPE_COST ");
	    	sbQuery.append("\n  FROM (SELECT A.RECIPE_CD, B.ITEM_CODE, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, ");
	    	sbQuery.append("\n               A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1, A.COOK_TOOL2, A.RECIPE_COLOR, ");
	    	sbQuery.append("\n               A.RECIPE_SHAPE, A.RECIPE_TASTE, A.RECIPE_FEEL, A.RECIPE_TEMPER, A.SPRING_YN, A.SUMMER_YN, ");
	    	sbQuery.append("\n               A.AUTUMN_YN, A.WINTER_YN, A.RESP_NUT1, A.RESP_NUT2, A.USE_TOOL, A.VALID_TIME, A.DISPLAY_METHOD, ");
	    	sbQuery.append("\n               A.SALE_UOM, A.SALE_PRICE, A.COST_RATE, A.CORE_TEMPER_YN, A.GOODS_FEATURE, A.PHF_MGMT_YN, ");
	    	sbQuery.append("\n               A.PHF, A.PHF_MGMT1, A.PHF_MGMT2, A.PHF_MGMT3, A.PHF_MGMT4, A.PHF_MGMT5, A.COOK_OPRN, A.PHOTO_PATH, ");
	    	sbQuery.append("\n               A.SPHOTO_PATH, A.USE_YN, SUM(B.NEED_QTY) AS NEED_QTY, C.OP_PRICE, C.KG_CONVERT_RATE ");
	    	sbQuery.append("\n          FROM FMR_STD_RECIPE_MST A, ");
	    	sbQuery.append("\n               (SELECT RECIPE_CD, FMM_CHGITEM_FUN(#UPJANG_1_2#, ITEM_CODE) AS ITEM_CODE, NEED_QTY ");
	    	sbQuery.append("\n                  FROM FMR_STD_RECIPE_ITEM ");
	    	sbQuery.append("\n                 WHERE RECIPE_CD = #RECIPE_CD_1_1#) B, ");
	    	sbQuery.append("\n               ( ");
	    	sbQuery.append("\n                SELECT ");
	    	sbQuery.append("\n                       A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE ");
    		
	    	sbQuery.append("\n                     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    	sbQuery.append("\n                            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    	sbQuery.append("\n                            ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)");
	    	
	    	sbQuery.append("\n                  FROM ");
	    	
	    	sbQuery.append("\n                       ( ");
    		sbQuery.append("\n                        SELECT #UPJANG_1_3# AS UPJANG ");
    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
    		sbQuery.append("\n                             , C.ITEM_CODE, C.SALE_PRICE ");
    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE C, HLDC_ST_UPJANG D ");
    		sbQuery.append("\n                         WHERE C.UPJANG = D.AP_UNITPRICE_UPJANG ");
    		sbQuery.append("\n                           AND D.UPJANG = #UPJANG_1_4#");
    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') ");
    		sbQuery.append("\n                           AND C.SALE_PRICE > 0 ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                         UNION ALL ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                        SELECT #UPJANG_1_5# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE ");
    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A , ");
    		sbQuery.append("\n                               ( ");
    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
    		sbQuery.append("\n                                 WHERE UPJANG = ");
    		sbQuery.append("\n                                       ( ");
    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_1_6#");
    		sbQuery.append("\n                                       ) ");
    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
    		sbQuery.append("\n                               ) B ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n                       ) A, ");
	    	sbQuery.append("\n                       FMS_ITEM_V B, ");
	    	sbQuery.append("\n                       ( ");
	    	sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    	sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_1_7#");
	    	sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                           AND ITEM_TYPE = 'M' ");
	    	sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n                       ) C, ");
	    	sbQuery.append("\n                       ( ");
	    	sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    	sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_1_8#");
	    	sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                           AND ITEM_TYPE = 'C' ");
	    	sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n                       ) D ");
    		
	    	sbQuery.append("\n                 WHERE A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n                   AND A.ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\n                   AND B.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    	
	    	sbQuery.append("\n               ) C ");
	    	sbQuery.append("\n         WHERE 1 = 1 ");
	    	sbQuery.append("\n           AND A.RECIPE_CD = #RECIPE_CD_1_2#");
	    	sbQuery.append("\n           AND A.RECIPE_CD = B.RECIPE_CD ");
	    	sbQuery.append("\n           AND B.ITEM_CODE = C.ITEM_CODE(+) ");
	    	sbQuery.append("\n         GROUP BY A.RECIPE_CD, B.ITEM_CODE, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, ");
	    	sbQuery.append("\n                  A.MAIN_ITEM_CODE1, A.MAIN_ITEM_CODE2, A.COOK_TOOL1, A.COOK_TOOL2, A.RECIPE_COLOR, ");
	    	sbQuery.append("\n                  A.RECIPE_SHAPE, A.RECIPE_TASTE, A.RECIPE_FEEL, A.RECIPE_TEMPER, A.SPRING_YN, A.SUMMER_YN, ");
	    	sbQuery.append("\n                  A.AUTUMN_YN, A.WINTER_YN, A.RESP_NUT1, A.RESP_NUT2, A.USE_TOOL, A.VALID_TIME, A.DISPLAY_METHOD, ");
	    	sbQuery.append("\n                  A.SALE_UOM, A.SALE_PRICE, A.COST_RATE, A.CORE_TEMPER_YN, A.GOODS_FEATURE, A.PHF_MGMT_YN, ");
	    	sbQuery.append("\n                  A.PHF, A.PHF_MGMT1, A.PHF_MGMT2, A.PHF_MGMT3, A.PHF_MGMT4, A.PHF_MGMT5, A.COOK_OPRN, A.PHOTO_PATH, ");
	    	sbQuery.append("\n                  A.SPHOTO_PATH, A.USE_YN, C.OP_PRICE, C.KG_CONVERT_RATE) ");
	    	sbQuery.append("\n GROUP BY RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, ");
	    	sbQuery.append("\n       MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, ");
	    	sbQuery.append("\n       RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, ");
	    	sbQuery.append("\n       AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, ");
	    	sbQuery.append("\n       SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, ");
	    	sbQuery.append("\n       PHF, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, ");
	    	sbQuery.append("\n       SPHOTO_PATH, USE_YN ");
	    	
	    } else if( sGubun.equals("본사") ) {
	    	
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT TRIM(#GUBUN_2#) AS GUBUN, #UPJANG_2_1# AS UPJANG, #SUBINV_CLASS_2# AS SUBINV_CLASS, A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, ");
	    	sbQuery.append("\n       A.RESP_NUT1, A.MAIN_ITEM_CODE1, A.RECIPE_SHAPE, A.RECIPE_TASTE, A.RECIPE_FEEL, ");
	    	sbQuery.append("\n       A.RECIPE_COLOR, A.RECIPE_TEMPER, A.CORE_TEMPER_YN, A.PHF_MGMT_YN, A.PHF_MGMT1, A.PHF_MGMT2, ");
	    	sbQuery.append("\n       A.PHF_MGMT3, A.PHF_MGMT4, A.PHF_MGMT5, A.PHF, A.USE_TOOL, ");
	    	sbQuery.append("\n       A.SPRING_YN, A.SUMMER_YN, A.AUTUMN_YN, A.WINTER_YN, '' AS PREFER, A.SPHOTO_PATH, ");
	    	sbQuery.append("\n       NVL(SUM(ROUND(B.NEED_QTY * C.OP_PRICE / C.KG_CONVERT_RATE / 1000)), 0) AS RECIPE_COST ");
	    	sbQuery.append("\n  FROM FMM_STD_RECIPE_MST A, ");
	    	sbQuery.append("\n       FMM_STD_RECIPE_ITEM B, ");
	    	sbQuery.append("\n      ( ");
	    	sbQuery.append("\n      SELECT ");
	    	sbQuery.append("\n             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE ");
    		
	    	sbQuery.append("\n           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    	sbQuery.append("\n                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    	sbQuery.append("\n                  ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)");
	    	
	    	sbQuery.append("\n        FROM ");
	    	
	    	sbQuery.append("\n             ( ");
    		sbQuery.append("\n                        SELECT #UPJANG_2_2# AS UPJANG ");
    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
    		sbQuery.append("\n                             , C.ITEM_CODE, C.SALE_PRICE ");
    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE C, HLDC_ST_UPJANG D ");
    		sbQuery.append("\n                         WHERE C.UPJANG = D.AP_UNITPRICE_UPJANG ");
    		sbQuery.append("\n                           AND D.UPJANG = #UPJANG_2_3#");
    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') ");
    		sbQuery.append("\n                           AND C.SALE_PRICE > 0 ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                         UNION ALL ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                        SELECT #UPJANG_2_4# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE ");
    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A , ");
    		sbQuery.append("\n                               ( ");
    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
    		sbQuery.append("\n                                 WHERE UPJANG = ");
    		sbQuery.append("\n                                       ( ");
    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_2_5#");
    		sbQuery.append("\n                                       ) ");
    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
    		sbQuery.append("\n                               ) B ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) A, ");
	    	sbQuery.append("\n             FMS_ITEM_V B, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_2_6#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'M' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) C, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_2_7#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'C' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) D ");
    		
	    	sbQuery.append("\n       WHERE A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n         AND A.ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\n         AND B.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    	
	    	sbQuery.append("\n      ) C ");
	    	sbQuery.append("\n WHERE 1 = 1 ");
	    	sbQuery.append("\n   AND A.UPJANG = #MAIN_UPJANG#");
	    	sbQuery.append("\n   AND A.RECIPE_CD = #RECIPE_CD_2_1#");
	    	sbQuery.append("\n   AND A.RECIPE_CD = B.RECIPE_CD ");
	    	sbQuery.append("\n   AND B.ITEM_CODE = C.ITEM_CODE(+) ");
	    	sbQuery.append("\n GROUP BY A.UPJANG, A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, ");
	    	sbQuery.append("\n          A.RESP_NUT1, A.MAIN_ITEM_CODE1, A.RECIPE_SHAPE, A.RECIPE_TASTE, A.RECIPE_FEEL, ");
	    	sbQuery.append("\n          A.RECIPE_COLOR, A.RECIPE_TEMPER, A.CORE_TEMPER_YN, A.PHF_MGMT_YN, A.PHF, A.PHF_MGMT1, A.PHF_MGMT2, ");
	    	sbQuery.append("\n          A.PHF_MGMT3, A.PHF_MGMT4, A.PHF_MGMT5,A.USE_TOOL, ");
	    	sbQuery.append("\n          A.SPRING_YN, A.SUMMER_YN, A.AUTUMN_YN, A.WINTER_YN, A.SPHOTO_PATH ");

	    } else if( sGubun.equals("업장") ) {
	    	
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT TRIM(#GUBUN_3#) AS GUBUN, A.UPJANG, A.SUBINV_CLASS, A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, ");
	    	sbQuery.append("\n       A.RESP_NUT1, A.MAIN_ITEM_CODE1, A.RECIPE_SHAPE, A.RECIPE_TASTE, A.RECIPE_FEEL, ");
	    	sbQuery.append("\n       A.RECIPE_COLOR, A.RECIPE_TEMPER, A.CORE_TEMPER_YN, A.PHF_MGMT_YN, A.PHF_MGMT1, A.PHF_MGMT2, ");
	    	sbQuery.append("\n       A.PHF_MGMT3, A.PHF_MGMT4, A.PHF_MGMT5, A.PHF, A.USE_TOOL, ");
	    	sbQuery.append("\n       A.SPRING_YN, A.SUMMER_YN, A.AUTUMN_YN, A.WINTER_YN, A.PREFER, A.SPHOTO_PATH, ");
	    	sbQuery.append("\n       NVL(SUM(ROUND(B.NEED_QTY * C.OP_PRICE / C.KG_CONVERT_RATE / 1000)), 0) AS RECIPE_COST ");
	    	
	    	sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_MST A, ");
	    	sbQuery.append("\n       FMM_UPJANG_RECIPE_ITEM B, ");
	    	sbQuery.append("\n      ( ");
	    	sbQuery.append("\n      SELECT ");
	    	sbQuery.append("\n             A.UPJANG, A.ITEM_CODE, A.SALE_PRICE, B.KG_CONVERT_RATE ");
    		
	    	sbQuery.append("\n           , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                  THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    	sbQuery.append("\n                  WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                  THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    	sbQuery.append("\n                  ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)");
	    	
	    	sbQuery.append("\n        FROM ");
	    	
	    	sbQuery.append("\n             ( ");
    		sbQuery.append("\n                        SELECT #UPJANG_3_1# AS UPJANG ");
    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
    		sbQuery.append("\n                             , C.ITEM_CODE, C.SALE_PRICE ");
    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE C, HLDC_ST_UPJANG D ");
    		sbQuery.append("\n                         WHERE C.UPJANG = D.AP_UNITPRICE_UPJANG ");
    		sbQuery.append("\n                           AND D.UPJANG = #UPJANG_3_2#");
    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START AND NVL(C.CONTRACT_END,'99999999') ");
    		sbQuery.append("\n                           AND C.SALE_PRICE > 0 ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                         UNION ALL ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                        SELECT #UPJANG_3_3# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE ");
    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A , ");
    		sbQuery.append("\n                               ( ");
    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
    		sbQuery.append("\n                                 WHERE UPJANG = ");
    		sbQuery.append("\n                                       ( ");
    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_3_4#");
    		sbQuery.append("\n                                       ) ");
    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
    		sbQuery.append("\n                               ) B ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) A, ");
	    	sbQuery.append("\n             FMS_ITEM_V B, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_3_5#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'M' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) C, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_3_6#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'C' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) D ");
    		
	    	sbQuery.append("\n       WHERE A.ITEM_CODE = B.ITEM_CODE ");
			sbQuery.append("\n         AND A.ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\n         AND B.ITEM_CLASS4 = D.ITEM_CODE(+) ");
			
	    	sbQuery.append("\n      ) C ");
	    	sbQuery.append("\n WHERE 1 = 1 ");
	    	sbQuery.append("\n   AND A.UPJANG = #UPJANG_3_7#");
	    	sbQuery.append("\n   AND A.UPJANG = B.UPJANG ");
	    	sbQuery.append("\n   AND A.SUBINV_CLASS = #SUBINV_CLASS_3#");
	    	sbQuery.append("\n   AND A.RECIPE_CD = #RECIPE_CD_3_1#");
	    	sbQuery.append("\n   AND A.RECIPE_CD = B.RECIPE_CD ");
	    	sbQuery.append("\n   AND B.ITEM_CODE = C.ITEM_CODE(+) ");
	    	sbQuery.append("\n GROUP BY A.UPJANG, A.SUBINV_CLASS, A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, ");
	    	sbQuery.append("\n          A.RESP_NUT1, A.MAIN_ITEM_CODE1, A.RECIPE_SHAPE, A.RECIPE_TASTE, A.RECIPE_FEEL, ");
	    	sbQuery.append("\n          A.RECIPE_COLOR, A.RECIPE_TEMPER, A.CORE_TEMPER_YN, A.PHF_MGMT_YN, A.PHF, A.PHF_MGMT1, A.PHF_MGMT2, ");
	    	sbQuery.append("\n          A.PHF_MGMT3, A.PHF_MGMT4, A.PHF_MGMT5,A.USE_TOOL, ");
	    	sbQuery.append("\n          A.SPRING_YN, A.SUMMER_YN, A.AUTUMN_YN, A.WINTER_YN, A.PREFER, A.SPHOTO_PATH ");

	    }
	    
	    // SQL 요청자 정보 생성
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    if( sGubun.equals("한화") ) {
	    	sqlRequest.addParamObject("GUBUN_1", sGubun);
	    	sqlRequest.addParamObject("UPJANG_1_1", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_2", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_3", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_4", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_5", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_6", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_7", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_8", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_1", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_1_1", sRecipeCd);
	    	sqlRequest.addParamObject("RECIPE_CD_1_2", sRecipeCd);
	    	
	    } else if( sGubun.equals("본사") ) {
	    	sqlRequest.addParamObject("GUBUN_2", sGubun);
	    	sqlRequest.addParamObject("UPJANG_2_1", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_2", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_3", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_4", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_5", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_6", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_7", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_2", sSubinvClass);
	    	sqlRequest.addParamObject("MAIN_UPJANG", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2_1", sRecipeCd);

	    } else if( sGubun.equals("업장") ) {
	    	sqlRequest.addParamObject("GUBUN_3", sGubun);
	    	sqlRequest.addParamObject("UPJANG_3_1", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_2", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_3", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_4", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_5", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_6", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_7", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_3", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3_1", sRecipeCd);
	    }
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		
	    // Execute Result DataSet
	    dsRecipeInfo = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_RECIPE_INFO", dsRecipeInfo);
	}
	
	/**
	 * 레시피 식자재 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchItemList(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_INPUT");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수설정
		String sGubun       = dsInput.getString(0, "GUBUN");
		int    iMainUpjang  = 0;
		int    iUpjang      = dsInput.getInt(0, "UPJANG");
		String strOpLen;
		String sRecipeCd    = dsInput.getString(0, "RECIPE_CD");
		String sSubinvClass = dsInput.getString(0, "SUBINV_CLASS");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = null;
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Result DataSet
	    DataSet dsItemList = null;
	    
	    // SQL StringBuffer 변수 생성
	    StringBuffer sbQuery = new StringBuffer();
	    
	    /************* 본사코드 조회 Start ***************************************************************/
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	    if ( sGubun.equals("본사") ) {
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT MAIN_UPJANG");
	    	sbQuery.append("\n  FROM FMS_UPJANG");
	    	sbQuery.append("\n WHERE UPJANG = #UPJANG#");
	    	
	    	// SQL 요청자 정보 생성
	    	sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    	sqlRequest.addParamObject("UPJANG", iUpjang);
	    	
	    	// Execute Result DataSet
	    	DataSet dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    	
	    	if( dsTemp.getRowCount() == 1 ) {
	    		iMainUpjang = dsTemp.getInt(0, "MAIN_UPJANG");
	    	} else {
	    		throw new Exception("본사 업장코드가 올바르지 않습니다.");
	    	}
	    }
	    /************* 본사코드 조회 End *****************************************************************/
	    
	    if( sGubun.equals("한화") ) {
	    	
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT #UPJANG_1_1# AS UPJANG, --업장코드 ");
	    	sbQuery.append("\n       RECIPE_CD,	--레시피코드 ");
	    	sbQuery.append("\n       #SUBINV_CLASS_1# AS SUBINV_CLASS, --식당군 ");
	    	sbQuery.append("\n       ROWNUM AS ITEM_SEQ,  --자재순번 ");
	    	sbQuery.append("\n       ITEM_CODE,	--레시피명 ");
	    	sbQuery.append("\n       ITEM_NAME,	--자재명 ");
	    	sbQuery.append("\n       ITEM_SIZE,	--규격 ");
	    	sbQuery.append("\n       PO_UOM,	--구매단위 ");
	    	sbQuery.append("\n       FEATURE_NAME,	--자재특성 ");
	    	sbQuery.append("\n       NEED_QTY,	--1인소요량 ");
	    	sbQuery.append("\n       NVL(OP_PRICE,0) OP_PRICE,	--구매단가 ");
	    	sbQuery.append("\n       DISUSE_RATE,	--페기율 ");
	    	sbQuery.append("\n       CUT_SPEC,	--커팅규격 ");
	    	sbQuery.append("\n       NULL AS REMARK,  --비고 ");
	    	sbQuery.append("\n       CAL,		--100g당 에너지 ");
	    	sbQuery.append("\n       DECODE(NVL(OP_PRICE,0),0,'Y','N') RESTRICT_YN, --상태 ");
	    	sbQuery.append("\n       DECODE( NVL(DISUSE_RATE,0), 0, NEED_QTY, ROUND(NEED_QTY*(100-DISUSE_RATE)/100,2) ) EDIBLE_QTY,		--가식부량 ");
	    	sbQuery.append("\n       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017' AND CODE = CUT_SPEC) CUT_SPEC_NAME,		--커팅규격명 ");
	    	sbQuery.append("\n       ROUND(NEED_QTY * (NVL(OP_PRICE,0) / KG_CONVERT_RATE / 1000) ) PERSON_PRICE,				--1인원가 ");
	    	sbQuery.append("\n       ROUND( NVL(CAL,0) * DECODE( NVL(DISUSE_RATE,0), 0, NEED_QTY, ROUND(NEED_QTY*(100-DISUSE_RATE)/100,2) ) / 100,2) CAL_CALC,	--가식부량에 대한 에너지 ");
	    	sbQuery.append("\n       ROUND(NVL(OP_PRICE,0) / KG_CONVERT_RATE / 1000,2) AS GRAM_PRICE,						--g당 단가 ");
	    	sbQuery.append("\n       ORIGIN_TYPE	--원산지 ");
	    	sbQuery.append("\n  FROM (SELECT A.RECIPE_CD, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, FMS_ITEM_FEATURE_FUN(#UPJANG_1_2#, TO_CHAR(SYSDATE,'YYYYMMDD'), A.ITEM_CODE, 'N') AS FEATURE_NAME, SUM(A.NEED_QTY) AS NEED_QTY, ");
	    	sbQuery.append("\n               B.OP_PRICE, D.DISUSE_RATE, MAX(A.CUT_SPEC) AS CUT_SPEC, D.CAL, A.KG_CONVERT_RATE, A.ORIGIN_TYPE ");
	    	sbQuery.append("\n          FROM (SELECT /*+ INDEX(A FMR_STD_RECIPE_ITEM_PK) */ ");
	    	sbQuery.append("\n                       A.RECIPE_CD, A.ITEM_SEQ, FMM_CHGITEM_FUN(#UPJANG_1_3#, A.ITEM_CODE) AS ITEM_CODE, A.NEED_QTY, A.CUT_SPEC ");
	    	sbQuery.append("\n                     , B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.KG_CONVERT_RATE, B.ORIGIN_TYPE ");
	    	sbQuery.append("\n                  FROM FMR_STD_RECIPE_ITEM A, FMS_ITEM_V B ");
	    	sbQuery.append("\n                 WHERE RECIPE_CD = #RECIPE_CD_1_1#");
	    	sbQuery.append("\n                   AND A.ITEM_CODE = B.ITEM_CODE ");
	    	sbQuery.append("\n               ) A, ");
	    	sbQuery.append("\n               ( ");
	    	sbQuery.append("\n                SELECT ");
	    	sbQuery.append("\n                       A.UPJANG, A.ITEM_CODE, A.SALE_PRICE ");
	    	sbQuery.append("\n                     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    	sbQuery.append("\n                            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    	sbQuery.append("\n                            ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)");
	    	sbQuery.append("\n                  FROM ");
	    	sbQuery.append("\n                       ( ");
    		sbQuery.append("\n                        SELECT #UPJANG_1_4# AS UPJANG ");
    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
    		sbQuery.append("\n                             , A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 ");
    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG ");
    		sbQuery.append("\n                           AND B.UPJANG = #UPJANG_1_5#");
    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = C.ITEM_CODE ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                         UNION ALL ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                        SELECT #UPJANG_1_6# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 ");
    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C, ");
    		sbQuery.append("\n                               ( ");
    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
    		sbQuery.append("\n                                 WHERE UPJANG = ");
    		sbQuery.append("\n                                       ( ");
    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_1_7#");
    		sbQuery.append("\n                                       ) ");
    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
    		sbQuery.append("\n                               ) B ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = C.ITEM_CODE ");
	    	sbQuery.append("\n                       ) A, ");
	    	sbQuery.append("\n                       ( ");
	    	sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    	sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_1_8#");
	    	sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                           AND ITEM_TYPE = 'M' ");
	    	sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n                       ) C, ");
	    	sbQuery.append("\n                       ( ");
	    	sbQuery.append("\n                        SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                          FROM FMU_OP_RATE A");
	    	sbQuery.append("\n                         WHERE A.UPJANG = #UPJANG_1_9#");
	    	sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                           AND ITEM_TYPE = 'C' ");
	    	sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n                       ) D ");
	    	sbQuery.append("\n                 WHERE A.ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\n                   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    	sbQuery.append("\n               )  B ,--단가 ");
	    	sbQuery.append("\n               ( ");
	    	sbQuery.append("\n                 SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
	    	sbQuery.append("\n                   FROM	FMP_ITEM_NUT ");
	    	sbQuery.append("\n                  WHERE	UPJANG = #UPJANG_1_10#");
	    	sbQuery.append("\n                  UNION ALL ");
	    	sbQuery.append("\n                        ( ");
	    	sbQuery.append("\n                        SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
	    	sbQuery.append("\n                          FROM	FSI_ITEM_NUT ");
	    	sbQuery.append("\n                         WHERE ITEM_CODE IN ");
	    	sbQuery.append("\n                               ( ");
	    	sbQuery.append("\n                               SELECT ITEM_CODE ");
	    	sbQuery.append("\n                                 FROM FSI_ITEM_NUT MINUS ");
	    	sbQuery.append("\n                               SELECT ITEM_CODE ");
	    	sbQuery.append("\n                                 FROM FMP_ITEM_NUT ");
	    	sbQuery.append("\n                                WHERE UPJANG = #UPJANG_1_11#");
	    	sbQuery.append("\n                               ) ");
	    	sbQuery.append("\n                        ) ");
	    	sbQuery.append("\n               ) D ");
	    	sbQuery.append("\n         WHERE A.RECIPE_CD = #RECIPE_CD_1_2#");
	    	sbQuery.append("\n           AND A.ITEM_CODE = B.ITEM_CODE(+) ");
	    	sbQuery.append("\n           AND A.ITEM_CODE = D.ITEM_CODE(+) ");
	    	sbQuery.append("\n       GROUP BY A.RECIPE_CD, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, ");
	    	sbQuery.append("\n		          B.OP_PRICE, D.DISUSE_RATE, D.CAL, A.KG_CONVERT_RATE, A.ORIGIN_TYPE) ");
	    	sbQuery.append("\n ORDER BY ITEM_CODE ");

	    } else if( sGubun.equals("본사") ) {
	    	
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT #UPJANG_2_1# AS UPJANG, ");
	    	sbQuery.append("\n       A.RECIPE_CD,	--레시피코드 ");
	    	sbQuery.append("\n       #SUBINV_CLASS_2# AS SUBINV_CLASS, --식당군 ");
	    	sbQuery.append("\n       A.ITEM_SEQ,  --자재순번 ");
	    	sbQuery.append("\n       A.ITEM_CODE,	--레시피명 ");
	    	sbQuery.append("\n       A.ITEM_NAME,	--자재명 ");
	    	sbQuery.append("\n       A.ITEM_SIZE,	--규격 ");
	    	sbQuery.append("\n       A.PO_UOM,	--구매단위 ");
	    	sbQuery.append("\n       FMS_ITEM_FEATURE_FUN(#UPJANG_2_2#, TO_CHAR(SYSDATE,'YYYYMMDD'), A.ITEM_CODE, 'N') AS FEATURE_NAME,	--자재특성 ");
	    	sbQuery.append("\n       A.NEED_QTY,	--1인소요량 ");
	    	sbQuery.append("\n       NVL(B.OP_PRICE,0) OP_PRICE,	--구매단가 ");
	    	sbQuery.append("\n       D.DISUSE_RATE,	--페기율 ");
	    	sbQuery.append("\n       A.CUT_SPEC,	--커팅규격 ");
	    	sbQuery.append("\n       A.REMARK,  --비고 ");
	    	sbQuery.append("\n       D.CAL,		--100g당 에너지 ");
	    	sbQuery.append("\n       DECODE(NVL(B.OP_PRICE,0),0,'Y','N') RESTRICT_YN, --상태 ");
	    	sbQuery.append("\n       DECODE( NVL(D.DISUSE_RATE,0), 0, A.NEED_QTY, ROUND(A.NEED_QTY*(100-D.DISUSE_RATE)/100,2) ) EDIBLE_QTY,		--가식부량 ");
	    	sbQuery.append("\n       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017' AND CODE = A.CUT_SPEC) CUT_SPEC_NAME,		--커팅규격명 ");
	    	sbQuery.append("\n       ROUND(A.NEED_QTY * (NVL(B.OP_PRICE,0) / A.KG_CONVERT_RATE / 1000) ) PERSON_PRICE,				--1인원가 ");
	    	sbQuery.append("\n       ROUND( NVL(D.CAL,0) * DECODE( NVL(D.DISUSE_RATE,0), 0, A.NEED_QTY, ROUND(A.NEED_QTY*(100-D.DISUSE_RATE)/100,2) ) / 100,2) CAL_CALC,	--가식부량에 대한 에너지 ");
	    	sbQuery.append("\n       ROUND(NVL(B.OP_PRICE,0) / A.KG_CONVERT_RATE / 1000,2) AS GRAM_PRICE,						--g당 단가 ");
	    	sbQuery.append("\n       A.ORIGIN_TYPE	--원산지 ");
	    	sbQuery.append("\n  FROM (SELECT /*+ INDEX(A FMM_STD_RECIPE_ITEM_PK) */ ");
		    sbQuery.append("\n               A.*, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.KG_CONVERT_RATE, B.ORIGIN_TYPE, ");
		    sbQuery.append("\n               B.ITEM_CLASS1, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 ");  
		    sbQuery.append("\n          FROM FMM_STD_RECIPE_ITEM A, FMS_ITEM_V B "); 
		    sbQuery.append("\n         WHERE A.ITEM_CODE = B.ITEM_CODE "); 
		    sbQuery.append("\n        ) A, "); 
	    	sbQuery.append("\n       ( ");
	    	sbQuery.append("\n        SELECT ");
	    	sbQuery.append("\n               A.UPJANG, A.ITEM_CODE, A.SALE_PRICE ");
	    	sbQuery.append("\n             , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    	sbQuery.append("\n                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    	sbQuery.append("\n                    ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)");
	    	sbQuery.append("\n          FROM ");
	    	sbQuery.append("\n             ( ");
    		sbQuery.append("\n                        SELECT #UPJANG_2_3# AS UPJANG ");
    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
    		sbQuery.append("\n                             , A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 ");
    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG ");
    		sbQuery.append("\n                           AND B.UPJANG = #UPJANG_2_4#");
    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = C.ITEM_CODE ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                         UNION ALL ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                        SELECT #UPJANG_2_5# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 ");
    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C, ");
    		sbQuery.append("\n                               ( ");
    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
    		sbQuery.append("\n                                 WHERE UPJANG = ");
    		sbQuery.append("\n                                       ( ");
    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_2_6#");
    		sbQuery.append("\n                                       ) ");
    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
    		sbQuery.append("\n                               ) B ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = C.ITEM_CODE ");
	    	sbQuery.append("\n             ) A, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_2_7#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'M' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) C, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_2_8#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'C' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) D ");
	    	sbQuery.append("\n        WHERE A.ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\n          AND A.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    	sbQuery.append("\n       )  B ,--단가 ");
	    	sbQuery.append("\n       ( ");
	    	sbQuery.append("\n         SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
	    	sbQuery.append("\n           FROM	FMP_ITEM_NUT ");
	    	sbQuery.append("\n          WHERE	UPJANG = #UPJANG_2_9#");
	    	sbQuery.append("\n          UNION ALL ");
	    	sbQuery.append("\n                ( ");
	    	sbQuery.append("\n                SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
	    	sbQuery.append("\n                  FROM	FSI_ITEM_NUT ");
	    	sbQuery.append("\n                 WHERE ITEM_CODE IN ");
	    	sbQuery.append("\n                       ( ");
	    	sbQuery.append("\n                       SELECT ITEM_CODE ");
	    	sbQuery.append("\n                         FROM FSI_ITEM_NUT MINUS ");
	    	sbQuery.append("\n                       SELECT ITEM_CODE ");
	    	sbQuery.append("\n                         FROM FMP_ITEM_NUT ");
	    	sbQuery.append("\n                        WHERE UPJANG = #UPJANG_2_10#");
	    	sbQuery.append("\n                       ) ");
	    	sbQuery.append("\n                ) ");
	    	sbQuery.append("\n       ) D ");
	    	sbQuery.append("\n WHERE A.UPJANG = #MAIN_UPJANG#");
	    	sbQuery.append("\n   AND A.RECIPE_CD = #RECIPE_CD_2_1#");
	    	sbQuery.append("\n   AND A.ITEM_CODE = B.ITEM_CODE(+) ");
	    	sbQuery.append("\n   AND A.ITEM_CODE = D.ITEM_CODE(+) ");
	    	sbQuery.append("\n ORDER BY ITEM_SEQ ");
	    	
	    } else if( sGubun.equals("업장") ) {
	    	
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT A.UPJANG, --업장코드 ");
	    	sbQuery.append("\n       A.RECIPE_CD,	--레시피코드 ");
	    	sbQuery.append("\n       A.SUBINV_CLASS, --식당군 ");
	    	sbQuery.append("\n       A.ITEM_SEQ,  --자재순번 ");
	    	sbQuery.append("\n       A.ITEM_CODE,	--레시피명 ");
	    	sbQuery.append("\n       A.ITEM_NAME,	--자재명 ");
	    	sbQuery.append("\n       A.ITEM_SIZE,	--규격 ");
	    	sbQuery.append("\n       A.PO_UOM,	--구매단위 ");
	    	sbQuery.append("\n       FMS_ITEM_FEATURE_FUN(#UPJANG_3_1#, TO_CHAR(SYSDATE,'YYYYMMDD'), A.ITEM_CODE, 'N') AS FEATURE_NAME,	--자재특성 ");
	    	sbQuery.append("\n       A.NEED_QTY,	--1인소요량 ");
	    	sbQuery.append("\n       NVL(B.OP_PRICE,0) OP_PRICE,	--구매단가 ");
	    	sbQuery.append("\n       D.DISUSE_RATE,	--페기율 ");
	    	sbQuery.append("\n       A.CUT_SPEC,	--커팅규격 ");
	    	sbQuery.append("\n       A.REMARK,  --비고 ");
	    	sbQuery.append("\n       D.CAL,		--100g당 에너지 ");
	    	sbQuery.append("\n       DECODE(NVL(B.OP_PRICE,0),0,'Y','N') RESTRICT_YN, --상태 ");
	    	sbQuery.append("\n       DECODE( NVL(D.DISUSE_RATE,0), 0, A.NEED_QTY, ROUND(A.NEED_QTY*(100-D.DISUSE_RATE)/100,2) ) EDIBLE_QTY,		--가식부량 ");
	    	sbQuery.append("\n       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0017' AND CODE = A.CUT_SPEC) CUT_SPEC_NAME,		--커팅규격명 ");
	    	sbQuery.append("\n       ROUND(A.NEED_QTY * (NVL(B.OP_PRICE,0) / A.KG_CONVERT_RATE / 1000) ) PERSON_PRICE,				--1인원가 ");
	    	sbQuery.append("\n       ROUND( NVL(D.CAL,0) * DECODE( NVL(D.DISUSE_RATE,0), 0, A.NEED_QTY, ROUND(A.NEED_QTY*(100-D.DISUSE_RATE)/100,2) ) / 100,2) CAL_CALC,	--가식부량에 대한 에너지 ");
	    	sbQuery.append("\n       ROUND(NVL(B.OP_PRICE,0) / A.KG_CONVERT_RATE / 1000,2) AS GRAM_PRICE,						--g당 단가 ");
	    	sbQuery.append("\n       A.ORIGIN_TYPE	--원산지 ");
	    	sbQuery.append("\n  FROM (SELECT /*+ INDEX(A FMM_UPJANG_RECIPE_ITEM_PK) */ ");
		    sbQuery.append("\n               A.*, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM, B.KG_CONVERT_RATE, B.ORIGIN_TYPE, ");
		    sbQuery.append("\n               B.ITEM_CLASS1, B.ITEM_CLASS2, B.ITEM_CLASS3, B.ITEM_CLASS4 ");  
		    sbQuery.append("\n          FROM FMM_UPJANG_RECIPE_ITEM A, FMS_ITEM_V B "); 
		    sbQuery.append("\n         WHERE A.ITEM_CODE = B.ITEM_CODE "); 
		    sbQuery.append("\n        ) A, "); 
	    	sbQuery.append("\n       ( ");
	    	sbQuery.append("\n        SELECT ");
	    	sbQuery.append("\n               A.UPJANG, A.ITEM_CODE, A.SALE_PRICE ");
	    	sbQuery.append("\n             , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                    THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) ");
	    	sbQuery.append("\n                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL ");
	    	sbQuery.append("\n                    THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) ");
	    	sbQuery.append("\n                    ELSE A.SALE_PRICE END AS OP_PRICE --운영단가(1인원가)");
	    	sbQuery.append("\n          FROM ");
	    	sbQuery.append("\n             ( ");
    		sbQuery.append("\n                        SELECT #UPJANG_3_2# AS UPJANG ");
    		sbQuery.append("\n                             , TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE ");
    		sbQuery.append("\n                             , A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 ");
    		sbQuery.append("\n                          FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B, HLDC_PO_ITEM_MST C ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG ");
    		sbQuery.append("\n                           AND B.UPJANG = #UPJANG_3_3#");
    		sbQuery.append("\n                           AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = C.ITEM_CODE ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                         UNION ALL ");
    		sbQuery.append("\n                        ----------- ");
    		sbQuery.append("\n                        SELECT #UPJANG_3_4# AS UPJANG, TO_CHAR(SYSDATE,'YYYYMMDD') AS NEED_DATE, A.ITEM_CODE, A.SALE_PRICE, C.ITEM_CLASS4 ");
    		sbQuery.append("\n                          FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM C, ");
    		sbQuery.append("\n                               ( ");
    		sbQuery.append("\n                                SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE ");
    		sbQuery.append("\n                                  FROM FMP_OTCUST_PRICE_AVA_V ");
    		sbQuery.append("\n                                 WHERE UPJANG = ");
    		sbQuery.append("\n                                       ( ");
    		sbQuery.append("\n                                        SELECT OTCUST_PRICE_UPJANG ");
    		sbQuery.append("\n                                          FROM FMS_UPJANG ");
    		sbQuery.append("\n                                         WHERE UPJANG = #UPJANG_3_5#");
    		sbQuery.append("\n                                       ) ");
    		sbQuery.append("\n                                   AND SDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') ");
    		sbQuery.append("\n                                 GROUP BY UPJANG, ITEM_CODE ");
    		sbQuery.append("\n                               ) B ");
    		sbQuery.append("\n                         WHERE A.UPJANG = B.UPJANG ");
    		sbQuery.append("\n                           AND A.SDATE = B.SDATE ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = B.ITEM_CODE ");
    		sbQuery.append("\n                           AND A.SALE_PRICE > 0 ");
    		sbQuery.append("\n                           AND A.USE_YN = 'Y' ");
    		sbQuery.append("\n                           AND A.ITEM_CODE = C.ITEM_CODE ");
	    	sbQuery.append("\n             ) A, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_3_6#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'M' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) C, ");
	    	sbQuery.append("\n             ( ");
	    	sbQuery.append("\n              SELECT A.ITEM_CODE, A.OP_RATE, A.OP_PRICE, A.CEIL_VAL ");
	    	sbQuery.append("\n                FROM FMU_OP_RATE A");
	    	sbQuery.append("\n               WHERE A.UPJANG = #UPJANG_3_7#");
	    	sbQuery.append("\n                 AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SDATE AND A.EDATE ");
	    	sbQuery.append("\n                 AND ITEM_TYPE = 'C' ");
	    	sbQuery.append("\n                 AND A.USE_YN = 'Y' ");
	    	sbQuery.append("\n             ) D ");
	    	sbQuery.append("\n        WHERE A.ITEM_CODE = C.ITEM_CODE(+) ");
			sbQuery.append("\n          AND A.ITEM_CLASS4 = D.ITEM_CODE(+) ");
	    	sbQuery.append("\n       )  B ,--단가 ");
	    	sbQuery.append("\n       ( ");
	    	sbQuery.append("\n         SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
	    	sbQuery.append("\n           FROM	FMP_ITEM_NUT ");
	    	sbQuery.append("\n          WHERE	UPJANG = #UPJANG_3_8#");
	    	sbQuery.append("\n          UNION ALL ");
	    	sbQuery.append("\n                ( ");
	    	sbQuery.append("\n                SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE ");
	    	sbQuery.append("\n                  FROM	FSI_ITEM_NUT ");
	    	sbQuery.append("\n                 WHERE ITEM_CODE IN ");
	    	sbQuery.append("\n                       ( ");
	    	sbQuery.append("\n                       SELECT ITEM_CODE ");
	    	sbQuery.append("\n                         FROM FSI_ITEM_NUT MINUS ");
	    	sbQuery.append("\n                       SELECT ITEM_CODE ");
	    	sbQuery.append("\n                         FROM FMP_ITEM_NUT ");
	    	sbQuery.append("\n                        WHERE UPJANG = #UPJANG_3_9#");
	    	sbQuery.append("\n                       ) ");
	    	sbQuery.append("\n                ) ");
	    	sbQuery.append("\n       ) D ");
	    	sbQuery.append("\n WHERE A.UPJANG = #UPJANG_3_10#");
	    	sbQuery.append("\n   AND A.SUBINV_CLASS = #SUBINV_CLASS_3# ");
	    	sbQuery.append("\n   AND A.RECIPE_CD = #RECIPE_CD_3_1# ");
	    	sbQuery.append("\n   AND A.ITEM_CODE = B.ITEM_CODE(+) ");
	    	sbQuery.append("\n   AND A.ITEM_CODE = D.ITEM_CODE(+) ");
	    	sbQuery.append("\n ORDER BY ITEM_SEQ ");
	    	
	    }
	    
	    // SQL 요청자 정보 생성
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    if( sGubun.equals("한화") ) {
	    	sqlRequest.addParamObject("UPJANG_1_1", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_2", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_3", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_4", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_5", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_6", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_7", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_8", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_9", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_10", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_1_11", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_1", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_1_1", sRecipeCd);
	    	sqlRequest.addParamObject("RECIPE_CD_1_2", sRecipeCd);

	    } else if( sGubun.equals("본사") ) {
	    	sqlRequest.addParamObject("UPJANG_2_1", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_2", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_3", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_4", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_5", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_6", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_7", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_8", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_9", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_2_10", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_2", sSubinvClass);
	    	sqlRequest.addParamObject("MAIN_UPJANG", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2_1", sRecipeCd);
	    	
	    } else if( sGubun.equals("업장") ) {
	    	sqlRequest.addParamObject("UPJANG_3_1", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_2", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_3", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_4", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_5", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_6", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_7", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_8", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_9", iUpjang);
	    	sqlRequest.addParamObject("UPJANG_3_10", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_3", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3_1", sRecipeCd);
	    }		
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		
	    // Execute Result DataSet
	    dsItemList = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_ITEM_LIST", dsItemList);
		
	}
	
	/**
	 * 레시피 조리법 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchCuisineList(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_INPUT");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수설정
		String sGubun       = dsInput.getString(0, "GUBUN"                   );
		int    iMainUpjang  = 0;
		int    iUpjang      = dsInput.getInt(0, "UPJANG");
		String sSubinvClass = dsInput.getString(0, "SUBINV_CLASS"            );
		String sRecipeCd    = dsInput.getString(0, "RECIPE_CD"               );
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Result DataSet
	    DataSet dsCuisineList = null;
	    
	    // SQL 셋팅
	    StringBuffer sbQuery = new StringBuffer();
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = null;
	    
	    /************* 본사코드 조회 Start ***************************************************************/
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	    if ( sGubun.equals("본사") ) {
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = #UPJANG#");
	    	
	    	// SQL 요청자 정보 생성
	    	sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    	sqlRequest.addParamObject("UPJANG", iUpjang);
	    	
	    	// Execute Result DataSet
	    	DataSet dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    	
	    	if( dsTemp.getRowCount() == 1 ) {
	    		iMainUpjang = dsTemp.getInt(0, "MAIN_UPJANG");
	    	} else {
	    		throw new Exception("본사 업장코드가 올바르지 않습니다.");
	    	}
	    }
	    /************* 본사코드 조회 End *****************************************************************/
	    
		sbQuery.setLength(0);
	    if( sGubun.equals("한화") ) {
	    	sbQuery.append("\nSELECT #UPJANG_1# AS UPJANG, #SUBINV_CLASS_1# AS SUBINV_CLASS,				        ");
	    	sbQuery.append("\n       RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, NULL AS REMARK	");
	    	sbQuery.append("\n  FROM FMR_STD_RECIPE_CUISINE															");
	    	sbQuery.append("\n WHERE RECIPE_CD = #RECIPE_CD_1#												        ");
	    	sbQuery.append("\n ORDER BY CUISINE_SEQ																	");
	    } else if( sGubun.equals("본사") ) {
	    	sbQuery.append("\nSELECT #UPJANG_2# AS UPJANG, #SUBINV_CLASS_2# AS SUBINV_CLASS,				        ");
	    	sbQuery.append("\n       RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, REMARK			");
	    	sbQuery.append("\n  FROM FMM_STD_RECIPE_CUISINE															");
	    	sbQuery.append("\n WHERE UPJANG = #MAIN_UPJANG#													        ");
	    	sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD_2#												        ");
	    	sbQuery.append("\n   AND USE_YN = 'Y'																	");
	    	sbQuery.append("\n ORDER BY CUISINE_SEQ																	");
	    } else if( sGubun.equals("업장") ) {
	    	sbQuery.append("\nSELECT UPJANG, SUBINV_CLASS,													        ");
	    	sbQuery.append("\n       RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, REMARK	        ");
	    	sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_CUISINE												        ");
	    	sbQuery.append("\n WHERE UPJANG = #UPJANG_3#												            ");
	    	sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS_3#									            ");
	    	sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD_3#										                ");
	    	sbQuery.append("\n   AND USE_YN = 'Y'															        ");
	    	sbQuery.append("\n ORDER BY CUISINE_SEQ															        ");
	    }
	    
	    // SQL 요청자 정보 생성 
	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    if( sGubun.equals("한화") ) {
	    	sqlRequest.addParamObject("UPJANG_1", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_1", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_1", sRecipeCd);
	    } else if( sGubun.equals("본사") ) {
	    	sqlRequest.addParamObject("UPJANG_2", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_2", sSubinvClass);
	    	sqlRequest.addParamObject("MAIN_UPJANG", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2", sRecipeCd);
	    } else if( sGubun.equals("업장") ) {
	    	sqlRequest.addParamObject("UPJANG_3", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_3", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3", sRecipeCd);
	    }
// [속도개선 Project   끝] 2017. 7. 7. 최범주
	    
	    // Execute Result DataSet
	    dsCuisineList = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_CUISINE_LIST", dsCuisineList);
	}
	
	/**
	 * 레시피 PHF관리 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchRecipePhf(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_INPUT");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수설정
		String sGubun       = dsInput.getString(0, "GUBUN"                   );
		int    iMainUpjang  = 0;
		int    iUpjang      = Integer.parseInt(dsInput.getString(0, "UPJANG"));
		String sSubinvClass = dsInput.getString(0, "SUBINV_CLASS"            );
		String sRecipeCd    = dsInput.getString(0, "RECIPE_CD"               );
		String sTableNm		= "";
		String sWhere1	    = "";
		String sWhere2	    = "";
		String sWhere3	    = "";
		String sWhere4	    = "";
		String sWhere5	    = "";
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 셋팅
	    StringBuffer sbQuery = new StringBuffer();
	    
	    // Result DataSet
	    DataSet dsRecipePhf = null;
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = null;
	    
	    /************* 본사코드 조회 Start ***************************************************************/
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	    if ( sGubun.equals("본사") ) {
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = #UPJANG_1#");
	    	
	    	// SQL 요청자 정보 생성
	    	sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    	sqlRequest.addParamObject("UPJANG_1", iUpjang);
	    	
	    	// Execute Result DataSet
	    	DataSet dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    	
	    	if( dsTemp.getRowCount() == 1 ) {
	    		iMainUpjang = dsTemp.getInt(0, "MAIN_UPJANG");
	    	} else {
	    		throw new Exception("본사 업장코드가 올바르지 않습니다.");
	    	}
	    }
	    /************* 본사코드 조회 End *****************************************************************/
	    
	    // 레시피별 SQL 조건 셋팅
	    if( sGubun.equals("한화") ) {
	    	sTableNm = "FMR_STD_RECIPE_MST";
	    	sWhere1   = "RECIPE_CD = #RECIPE_CD_1_1#";
	    	sWhere2   = "RECIPE_CD = #RECIPE_CD_1_2#";
	    	sWhere3   = "RECIPE_CD = #RECIPE_CD_1_3#";
	    	sWhere4   = "RECIPE_CD = #RECIPE_CD_1_4#";
	    	sWhere5   = "RECIPE_CD = #RECIPE_CD_1_5#";
	    } else if( sGubun.equals("본사") ) {
	    	sTableNm = "FMM_STD_RECIPE_MST";
	    	sWhere1   = "UPJANG = #MAIN_UPJANG_1# AND RECIPE_CD = #RECIPE_CD_2_1#";
	    	sWhere2   = "UPJANG = #MAIN_UPJANG_2# AND RECIPE_CD = #RECIPE_CD_2_2#";
	    	sWhere3   = "UPJANG = #MAIN_UPJANG_3# AND RECIPE_CD = #RECIPE_CD_2_3#";
	    	sWhere4   = "UPJANG = #MAIN_UPJANG_4# AND RECIPE_CD = #RECIPE_CD_2_4#";
	    	sWhere5   = "UPJANG = #MAIN_UPJANG_5# AND RECIPE_CD = #RECIPE_CD_2_5#";
	    } else if( sGubun.equals("업장") ) {
	    	sTableNm = "FMM_UPJANG_RECIPE_MST";
	    	sWhere1   = "UPJANG = #UPJANG_2_1# AND SUBINV_CLASS = #SUBINV_CLASS_1# AND RECIPE_CD = #RECIPE_CD_3_1#";
	    	sWhere2   = "UPJANG = #UPJANG_2_2# AND SUBINV_CLASS = #SUBINV_CLASS_2# AND RECIPE_CD = #RECIPE_CD_3_2#";
	    	sWhere3   = "UPJANG = #UPJANG_2_3# AND SUBINV_CLASS = #SUBINV_CLASS_3# AND RECIPE_CD = #RECIPE_CD_3_3#";
	    	sWhere4   = "UPJANG = #UPJANG_2_4# AND SUBINV_CLASS = #SUBINV_CLASS_4# AND RECIPE_CD = #RECIPE_CD_3_4#";
	    	sWhere5   = "UPJANG = #UPJANG_2_5# AND SUBINV_CLASS = #SUBINV_CLASS_5# AND RECIPE_CD = #RECIPE_CD_3_5#";
	    }
		
		sbQuery.setLength(0);
	    sbQuery.append("\nSELECT A.CODE_NAME AS PHF_DESC, NVL(B.PHF,'N') AS PHF										    ");
    	sbQuery.append("\n  FROM SCC_COMMON_CODE A,																	    ");
    	sbQuery.append("\n       (SELECT '001' CODE, PHF_MGMT1 AS PHF FROM " + sTableNm + " WHERE " + sWhere1            );
    	sbQuery.append("\n         UNION ALL																		    ");
    	sbQuery.append("\n        SELECT '002' CODE, PHF_MGMT2 AS PHF FROM " + sTableNm + " WHERE " + sWhere2            );
    	sbQuery.append("\n         UNION ALL																	    	");
    	sbQuery.append("\n        SELECT '003' CODE, PHF_MGMT3 AS PHF FROM " + sTableNm + " WHERE " + sWhere3            );
    	sbQuery.append("\n         UNION ALL																		    ");
    	sbQuery.append("\n        SELECT '004' CODE, PHF_MGMT4 AS PHF FROM " + sTableNm + " WHERE " + sWhere4            );
    	sbQuery.append("\n         UNION ALL																		    ");
    	sbQuery.append("\n        SELECT '005' CODE, PHF_MGMT5 AS PHF FROM " + sTableNm + " WHERE " + sWhere5 + ") B	");
    	sbQuery.append("\n WHERE A.USE_YN = 'Y'																		    ");
    	sbQuery.append("\n   AND A.GROUP_CODE = 'FS0018'															    ");
    	sbQuery.append("\n   AND A.CODE = B.CODE(+)																	    ");
    	sbQuery.append("\n ORDER BY A.SORT_SEQ																		    ");
    	
	    // SQL 요청자 정보 생성 
	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    if( sGubun.equals("한화") ) {
	    	sqlRequest.addParamObject("RECIPE_CD_1_1", sRecipeCd);
	    	sqlRequest.addParamObject("RECIPE_CD_1_2", sRecipeCd);
	    	sqlRequest.addParamObject("RECIPE_CD_1_3", sRecipeCd);
	    	sqlRequest.addParamObject("RECIPE_CD_1_4", sRecipeCd);
	    	sqlRequest.addParamObject("RECIPE_CD_1_5", sRecipeCd);
	    } else if( sGubun.equals("본사") ) {
	    	sqlRequest.addParamObject("MAIN_UPJANG_1", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2_1", sRecipeCd);
	    	sqlRequest.addParamObject("MAIN_UPJANG_2", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2_2", sRecipeCd);
	    	sqlRequest.addParamObject("MAIN_UPJANG_3", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2_3", sRecipeCd);
	    	sqlRequest.addParamObject("MAIN_UPJANG_4", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2_4", sRecipeCd);
	    	sqlRequest.addParamObject("MAIN_UPJANG_5", iMainUpjang);
	    	sqlRequest.addParamObject("RECIPE_CD_2_5", sRecipeCd);
	    } else if( sGubun.equals("업장") ) {
	    	sqlRequest.addParamObject("UPJANG_2_1", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_1", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3_1", sRecipeCd);
	    	sqlRequest.addParamObject("UPJANG_2_2", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_2", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3_2", sRecipeCd);
	    	sqlRequest.addParamObject("UPJANG_2_3", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_3", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3_3", sRecipeCd);
	    	sqlRequest.addParamObject("UPJANG_2_4", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_4", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3_4", sRecipeCd);
	    	sqlRequest.addParamObject("UPJANG_2_5", iUpjang);
	    	sqlRequest.addParamObject("SUBINV_CLASS_5", sSubinvClass);
	    	sqlRequest.addParamObject("RECIPE_CD_3_5", sRecipeCd);
	    }
// [속도개선 Project   끝] 2017. 7. 7. 최범주
	    
	    // Execute Result DataSet
	    dsRecipePhf = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_RECIPE_PHF", dsRecipePhf);
	}
	
	/**
	 * 신규 사업장레시피 생성시 중복체크
	 * @param ctx
	 * @throws Exception
	 */
	public void searchChkRecipe(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_INPUT");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 레시피 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수설정
		int     iUpjang     = dsInput.getInt(0, "UPJANG");
		String sSubinvClass = dsInput.getString(0, "SUBINV_CLASS"            );
		String sRecipeCd    = dsInput.getString(0, "RECIPE_CD"               );
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Result DataSet
	    DataSet dsChkRecipe = null;
	    
	    // SQL 셋팅
	    StringBuffer sbQuery = new StringBuffer();
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT COUNT(RECIPE_CD) AS CNT				");
    	sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_MST					");
    	sbQuery.append("\n WHERE UPJANG = #UPJANG#");
    	sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#");
    	sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#");
    	
	    // SQL 요청자 정보 생성 
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    sqlRequest.addParamObject("UPJANG", iUpjang);
	    sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
	    sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
// [속도개선 Project   끝] 2017. 7. 7. 최범주
	    
	    // Execute Result DataSet
	    dsChkRecipe = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_CHK_RECIPE", dsChkRecipe);
	}
	
	/**
	 * 사업장레시피 등록(신규/재신규)
	 * @param ctx
	 * @throws Exception
	 */
	public void saveInsert(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput       = (DataSet) ctx.getInputObject("ds_INPUT"       );
		DataSet dsRecipeInfo  = (DataSet) ctx.getInputObject("ds_RECIPE_INFO" );
		DataSet dsItemList    = (DataSet) ctx.getInputObject("ds_ITEM_LIST"   );
		DataSet dsCuisineList = (DataSet) ctx.getInputObject("ds_CUISINE_LIST");
		DataSet dsRecipePhf   = (DataSet) ctx.getInputObject("ds_RECIPE_PHF"  );
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 || dsRecipeInfo.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 레시피 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수설정
		String  sGubun       = dsInput.getString(0, "GUBUN"					);
		int     iUpjang      = dsInput.getInt(0, "UPJANG");
		String  sRecipeCd    = dsInput.getString(0, "RECIPE_CD"             );
		String  sSubinvClass = dsInput.getString(0, "SUBINV_CLASS"          );
		String  sEmpNo       = ctx.getInputString("EMP_NO"                        );
		int     iSucCount    = 0;
		int     iTotCount    = 0;
		DataSet iTmpDataSet  = null;
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성 
	    SqlRequest sqlRequest = null;
	    
	    // SQL
	    StringBuffer sbQuery = new StringBuffer();
	    
		// 모드설정
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
		String sMode = ctx.getInputString("MODE");
		if( sMode.equals("I2") ) {	// 기존 사업장레시피 삭제 후 신규 등록
			// 업장레시피 영양정보 삭제
			sbQuery.setLength(0);
			sbQuery.append("DELETE FROM FMM_UPJANG_RECIPE_NUT				");
			sbQuery.append(" WHERE UPJANG = #UPJANG_1#                      ");
			sbQuery.append("   AND RECIPE_CD = #RECIPE_CD_1#			    ");
			sbQuery.append("   AND SUBINV_CLASS = #SUBINV_CLASS_1#	        ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG_1", iUpjang);
			sqlRequest.addParamObject("RECIPE_CD_1", sRecipeCd);
			sqlRequest.addParamObject("SUBINV_CLASS_1", sSubinvClass);
			executor.execute(sqlRequest);
			
			// 업장레시피 특이사항 삭제
			sbQuery.setLength(0);
			sbQuery.append("DELETE FROM FMM_UPJANG_RECIPE_SPECIAL			");
			sbQuery.append(" WHERE UPJANG = #UPJANG_2#			 			");
			sbQuery.append("   AND RECIPE_CD = #RECIPE_CD_2#			    ");
			sbQuery.append("   AND SUBINV_CLASS = #SUBINV_CLASS_2#	        ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG_2", iUpjang);
			sqlRequest.addParamObject("RECIPE_CD_2", sRecipeCd);
			sqlRequest.addParamObject("SUBINV_CLASS_2", sSubinvClass);
			executor.execute(sqlRequest);
			
			// 업장레시피 조리법 삭제
			sbQuery.setLength(0);
			sbQuery.append("DELETE FROM FMM_UPJANG_RECIPE_CUISINE			");
			sbQuery.append(" WHERE UPJANG = #UPJANG_3#			 			");
			sbQuery.append("   AND RECIPE_CD = #RECIPE_CD_3#			    ");
			sbQuery.append("   AND SUBINV_CLASS = #SUBINV_CLASS_3#	        ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG_3", iUpjang);
			sqlRequest.addParamObject("RECIPE_CD_3", sRecipeCd);
			sqlRequest.addParamObject("SUBINV_CLASS_3", sSubinvClass);
			executor.execute(sqlRequest);
			
			// 업장레시피 식자재 삭제
			sbQuery.setLength(0);
			sbQuery.append("DELETE FROM FMM_UPJANG_RECIPE_ITEM				");
			sbQuery.append(" WHERE UPJANG = #UPJANG_4#			 			");
			sbQuery.append("   AND RECIPE_CD = #RECIPE_CD_4#			    ");
			sbQuery.append("   AND SUBINV_CLASS = #SUBINV_CLASS_4#	        ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG_4", iUpjang);
			sqlRequest.addParamObject("RECIPE_CD_4", sRecipeCd);
			sqlRequest.addParamObject("SUBINV_CLASS_4", sSubinvClass);
			executor.execute(sqlRequest);
			
			// 업장레시피 삭제
			sbQuery.setLength(0);
			sbQuery.append("DELETE FROM FMM_UPJANG_RECIPE_MST				");
			sbQuery.append(" WHERE UPJANG = #UPJANG_5#			 			");
			sbQuery.append("   AND RECIPE_CD = #RECIPE_CD_5#			    ");
			sbQuery.append("   AND SUBINV_CLASS = #SUBINV_CLASS_5#	        ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG_5", iUpjang);
			sqlRequest.addParamObject("RECIPE_CD_5", sRecipeCd);
			sqlRequest.addParamObject("SUBINV_CLASS_5", sSubinvClass);
			executor.execute(sqlRequest);
		}
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		
		/************** 1.업장레시피 마스터 등록 Start **********************************************************************/
		iSucCount = 0;
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fm/fmm:FMM00030E_I001", SqlMapFactoryHelper.XDATASET);
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		
		sqlRequest.addParamObject("UPJANG",          dsRecipeInfo.getInt(0, "UPJANG"));
		sqlRequest.addParamObject("SUBINV_CLASS",    dsRecipeInfo.getString(0, "SUBINV_CLASS"));
		sqlRequest.addParamObject("RECIPE_CD",       dsRecipeInfo.getString(0, "RECIPE_CD"));
		sqlRequest.addParamObject("RECIPE_NAME",     dsRecipeInfo.getString(0, "RECIPE_NAME"));
		sqlRequest.addParamObject("RECIPE_CLASS",    dsRecipeInfo.getString(0, "RECIPE_CLASS"));
		sqlRequest.addParamObject("RECIPE_TYPE",     dsRecipeInfo.getString(0, "RECIPE_TYPE"));
		sqlRequest.addParamObject("CUISINE_TYPE",    dsRecipeInfo.getString(0, "CUISINE_TYPE"));
		sqlRequest.addParamObject("MAIN_ITEM_CODE1", dsRecipeInfo.getString(0, "MAIN_ITEM_CODE1"));
		sqlRequest.addParamObject("RECIPE_COLOR",    dsRecipeInfo.getString(0, "RECIPE_COLOR"));
		sqlRequest.addParamObject("RECIPE_SHAPE",    dsRecipeInfo.getString(0, "RECIPE_SHAPE"));
		sqlRequest.addParamObject("RECIPE_TASTE",    dsRecipeInfo.getString(0, "RECIPE_TASTE"));
		sqlRequest.addParamObject("RECIPE_FEEL",     dsRecipeInfo.getString(0, "RECIPE_FEEL"));
		sqlRequest.addParamObject("RECIPE_TEMPER",   dsRecipeInfo.getString(0, "RECIPE_TEMPER"));
		sqlRequest.addParamObject("SPRING_YN",       dsRecipeInfo.getString(0, "SPRING_YN"));
		sqlRequest.addParamObject("SUMMER_YN",       dsRecipeInfo.getString(0, "SUMMER_YN"));
		sqlRequest.addParamObject("AUTUMN_YN",       dsRecipeInfo.getString(0, "AUTUMN_YN"));
		sqlRequest.addParamObject("WINTER_YN",       dsRecipeInfo.getString(0, "WINTER_YN"));
		sqlRequest.addParamObject("RESP_NUT1",       dsRecipeInfo.getString(0, "RESP_NUT1"));
		sqlRequest.addParamObject("USE_TOOL",        dsRecipeInfo.getString(0, "USE_TOOL"));
		sqlRequest.addParamObject("CORE_TEMPER_YN",  dsRecipeInfo.getString(0, "CORE_TEMPER_YN"));
		sqlRequest.addParamObject("PREFER",          dsRecipeInfo.getString(0, "PREFER"));
		sqlRequest.addParamObject("PHF_MGMT_YN",     dsRecipeInfo.getString(0, "PHF_MGMT_YN"));
		sqlRequest.addParamObject("PHF",             dsRecipeInfo.getString(0, "PHF"));
		sqlRequest.addParamObject("PHF_MGMT1",       dsRecipeInfo.getString(0, "PHF_MGMT1"));
		sqlRequest.addParamObject("PHF_MGMT2",       dsRecipeInfo.getString(0, "PHF_MGMT2"));
		sqlRequest.addParamObject("PHF_MGMT3",       dsRecipeInfo.getString(0, "PHF_MGMT3"));
		sqlRequest.addParamObject("PHF_MGMT4",       dsRecipeInfo.getString(0, "PHF_MGMT4"));
		sqlRequest.addParamObject("PHF_MGMT5",       dsRecipeInfo.getString(0, "PHF_MGMT5"));
		sqlRequest.addParamObject("SPHOTO_PATH",     dsRecipeInfo.getString(0, "SPHOTO_PATH"));
		sqlRequest.addParamObject("CUSER",           sEmpNo);
		
		//sqlRequest.addParamObject("ds_RECIPE_INFO", dsRecipeInfo);
		//sqlRequest.addParamObject("CUSER",          sEmpNo      );
		iSucCount = executor.execute(sqlRequest);
		if( iSucCount != 1 ) {
			throw new BusinessRuntimeException("사업장레시피 마스터 테이블에 등록 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		}
		/************** 1.업장레시피 마스터 등록 End ************************************************************************/
		
		/************** 2.업장레시피 식자재 등록 Start **********************************************************************/
		iSucCount = 0;
		
		// INSERT COUNT 셋팅
		iTotCount = dsItemList.getRowCount();
		
		if( iTotCount > 0 ) {
			sbQuery.setLength(0);
			sbQuery.append("\nINSERT INTO FMM_UPJANG_RECIPE_ITEM										");
			sbQuery.append("\n           (UPJANG, SUBINV_CLASS, RECIPE_CD, ITEM_CODE,					");
			sbQuery.append("\n            ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, REMARK,				");
			sbQuery.append("\n            CUSER, CDATE)													");
			sbQuery.append("\n     VALUES(#UPJANG#, #SUBINV_CLASS#, #RECIPE_CD#, #ITEM_CODE#,			");
			sbQuery.append("\n            #ITEM_SEQ#, #NEED_QTY#, #EDIBLE_QTY#, #CUT_SPEC#, #REMARK#,	");
			sbQuery.append("\n            #CUSER#, SYSDATE)												");
			
			// SQL 셋팅
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			
			for( int i = 0; i < iTotCount; i++ ) {
				sqlRequest.addParamObject("UPJANG",       dsItemList.getInt(i, "UPJANG")      );
				sqlRequest.addParamObject("SUBINV_CLASS", dsItemList.getString (i, "SUBINV_CLASS"));
				sqlRequest.addParamObject("RECIPE_CD",    dsItemList.getString (i, "RECIPE_CD")   );
				sqlRequest.addParamObject("ITEM_CODE",    dsItemList.getString (i, "ITEM_CODE")   );
				sqlRequest.addParamObject("ITEM_SEQ",     new Integer(i+1)                                );
				sqlRequest.addParamObject("NEED_QTY",     dsItemList.getInt(i, "NEED_QTY")    );
				sqlRequest.addParamObject("EDIBLE_QTY",   dsItemList.getInt(i, "EDIBLE_QTY")  );
				sqlRequest.addParamObject("CUT_SPEC",     dsItemList.getString (i, "CUT_SPEC")    );
				sqlRequest.addParamObject("REMARK",       dsItemList.getString (i, "REMARK")      );
				sqlRequest.addParamObject("CUSER",        sEmpNo                                          );
				
				// execute
				iSucCount += executor.execute(sqlRequest);
			}
		}
		
		// Transaction 처리
		if( iTotCount != iSucCount ) {
			throw new BusinessRuntimeException("사업장레시피 식자재 테이블에 등록 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		}
		/************** 2.업장레시피 식자재 등록 End ************************************************************************/
		
		/************** 3.업장레시피 조리법 등록 Start **********************************************************************/
		iSucCount = 0;
		
		// INSERT COUNT 셋팅
		iTotCount = dsCuisineList.getRowCount();
		
		if( iTotCount > 0 ) {
			sbQuery.setLength(0);
			sbQuery.append("\nINSERT INTO FMM_UPJANG_RECIPE_CUISINE									");
			sbQuery.append("\n	          (UPJANG, SUBINV_CLASS, RECIPE_CD, CUISINE_SEQ,			");
			sbQuery.append("\n	           CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, REMARK,			");
			sbQuery.append("\n	           CUSER, CDATE)											");
			sbQuery.append("\n	    VALUES(#UPJANG#, #SUBINV_CLASS#, #RECIPE_CD#, #CUISINE_SEQ#,	");
			sbQuery.append("\n	           #CUISINE_DESC#, #PHOTO_PATH#, #SPHOTO_PATH#, #REMARK#,	");
			sbQuery.append("\n	           #CUSER#, SYSDATE)										");
		}
		
		// SQL 셋팅
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		for( int i = 0; i < iTotCount; i++ ) {
			sqlRequest.addParamObject("UPJANG",       dsCuisineList.getInt(i, "UPJANG")      );
			sqlRequest.addParamObject("SUBINV_CLASS", dsCuisineList.getString (i, "SUBINV_CLASS"));
			sqlRequest.addParamObject("RECIPE_CD",    dsCuisineList.getString (i, "RECIPE_CD")   );
			sqlRequest.addParamObject("CUISINE_SEQ",  new Integer(i+1)                                   );
			sqlRequest.addParamObject("CUISINE_DESC", dsCuisineList.getString (i, "CUISINE_DESC"));
			sqlRequest.addParamObject("PHOTO_PATH",   dsCuisineList.getString (i, "PHOTO_PATH")  );
			sqlRequest.addParamObject("SPHOTO_PATH",  dsCuisineList.getString (i, "SPHOTO_PATH") );
			sqlRequest.addParamObject("REMARK",       dsCuisineList.getString (i, "REMARK")      );
			sqlRequest.addParamObject("CUSER",        sEmpNo                                             );
			// execute
			iSucCount += executor.execute(sqlRequest);
		}
		
		// Transaction 처리
		if( iTotCount != iSucCount ) {
			throw new BusinessRuntimeException("사업장레시피 조리법 테이블에 등록 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		}
		/************** 3.업장레시피 조리법 등록 End ************************************************************************/
		
		/************** 4.업장레시피 특이사항 등록 Start ********************************************************************/
		iSucCount = 0;
		
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
		sbQuery.setLength(0);
		if( sGubun.equals("한화") ) {
			sbQuery.append("\nSELECT #UPJANG_4_1# AS UPJANG, #SUBINV_CLASS_4_1# AS SUBINV_CLASS, RECIPE_CD, SPECIAL_SEQ,	");
			sbQuery.append("\n       SPECIAL_DESC, NULL AS REMARK										                    ");
			sbQuery.append("\n  FROM FSR_STD_RECIPE_SPECIAL												                    ");
			sbQuery.append("\n WHERE RECIPE_CD = #RECIPE_CD_4_1#									                        ");
		} else if( sGubun.equals("본사") ) {
			sbQuery.append("\nSELECT #UPJANG_4_2# AS UPJANG, #SUBINV_CLASS_4_2# AS SUBINV_CLASS, RECIPE_CD, SPECIAL_SEQ,	");
			sbQuery.append("\n       SPECIAL_DESC, REMARK												                    ");
			sbQuery.append("\n  FROM FMM_STD_RECIPE_SPECIAL												                    ");
			sbQuery.append("\n WHERE RECIPE_CD = #RECIPE_CD_4_2#									                        ");
		} else {
			throw new BusinessRuntimeException("올바르지 않은 작업구분입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		if( sGubun.equals("한화") ) {
			sqlRequest.addParamObject("UPJANG_4_1", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS_4_1", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD_4_1", sRecipeCd);
		} else if( sGubun.equals("본사") ) {
			sqlRequest.addParamObject("UPJANG_4_2", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS_4_2", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD_4_2", sRecipeCd);
		}
		iTmpDataSet = (DataSet)executor.query(sqlRequest).getResultObject();
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		
		// INSERT COUNT 셋팅
		iTotCount = iTmpDataSet.getRowCount();
		
		// INSERT QUERY 셋팅
		sbQuery.setLength(0);
		sbQuery.append("\nINSERT INTO FMM_UPJANG_RECIPE_SPECIAL												");
		sbQuery.append("\n           (UPJANG, SUBINV_CLASS, RECIPE_CD, SPECIAL_SEQ,							");
		sbQuery.append("\n            SPECIAL_DESC, REMARK, CUSER, CDATE)									");
		sbQuery.append("\n     VALUES(#UPJANG#, #SUBINV_CLASS#, #RECIPE_CD#, #SPECIAL_SEQ#,					");
		sbQuery.append("\n            #SPECIAL_DESC#, #REMARK#, #CUSER#, SYSDATE)							");
		
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		if( iTotCount > 0 ) {
			for( int i = 0; i < iTotCount; i++ ) {
				sqlRequest.addParamObject("UPJANG",       iTmpDataSet.getInt(i, "UPJANG")      );
				sqlRequest.addParamObject("SUBINV_CLASS", iTmpDataSet.getString (i, "SUBINV_CLASS"));
				sqlRequest.addParamObject("RECIPE_CD",    iTmpDataSet.getString (i, "RECIPE_CD")   );
				sqlRequest.addParamObject("SPECIAL_SEQ",  new Integer(i+1)                                 );
				sqlRequest.addParamObject("SPECIAL_DESC", iTmpDataSet.getString (i, "SPECIAL_DESC"));
				sqlRequest.addParamObject("REMARK",       iTmpDataSet.getString (i, "REMARK")      );
				sqlRequest.addParamObject("CUSER",        sEmpNo                                           );
				iSucCount += executor.execute(sqlRequest);
			}
			
			// Transaction 처리
			if( iTotCount != iSucCount ) {
				throw new BusinessRuntimeException("사업장레시피 특이사항 테이블에 등록 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
			}
		}
		/************** 4.업장레시피 특이사항 등록 End **********************************************************************/
		
		/************** 5.업장레시피 영양정보 등록 Start ********************************************************************/
		iSucCount = 0;
		
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
		sbQuery.setLength(0);
		if( sGubun.equals("한화") ) {
			sbQuery.append("\nSELECT #UPJANG_5_1# AS UPJANG, #SUBINV_CLASS_5_1# AS SUBINV_CLASS, RECIPE_CD, NUT_SEQ,	");
			sbQuery.append("\n       NUT_DESC, NULL AS REMARK										                    ");
			sbQuery.append("\n  FROM FSR_STD_RECIPE_NUT												                    ");
			sbQuery.append("\n WHERE RECIPE_CD = #RECIPE_CD_5_1#								                        ");
		} else if( sGubun.equals("본사") ) {
			sbQuery.append("\nSELECT #UPJANG_5_2# AS UPJANG, #SUBINV_CLASS_5_2# AS SUBINV_CLASS, RECIPE_CD, NUT_SEQ,	");
			sbQuery.append("\n       NUT_DESC, REMARK												                    ");
			sbQuery.append("\n  FROM FMM_STD_RECIPE_NUT												                    ");
			sbQuery.append("\n WHERE RECIPE_CD = #RECIPE_CD_5_2#								                        ");
		} else {
			throw new BusinessRuntimeException("올바르지 않은 작업구분입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		if( sGubun.equals("한화") ) {
			sqlRequest.addParamObject("UPJANG_5_1", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS_5_1", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD_5_1", sRecipeCd);
		} else if( sGubun.equals("본사") ) {
			sqlRequest.addParamObject("UPJANG_5_2", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS_5_2", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD_5_2", sRecipeCd);
		}
		iTmpDataSet = (DataSet)executor.query(sqlRequest).getResultObject();
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		
		// INSERT COUNT 셋팅
		iTotCount = iTmpDataSet.getRowCount();
		
		// INSERT QUERY 셋팅
		sbQuery.setLength(0);
		sbQuery.append("\nINSERT INTO FMM_UPJANG_RECIPE_NUT								");
		sbQuery.append("\n           (UPJANG, SUBINV_CLASS, RECIPE_CD, NUT_SEQ,			");
		sbQuery.append("\n            NUT_DESC, REMARK, CUSER, CDATE)					");
		sbQuery.append("\n     VALUES(#UPJANG#, #SUBINV_CLASS#, #RECIPE_CD#, #NUT_SEQ#,	");
		sbQuery.append("\n            #NUT_DESC#, #REMARK#, #CUSER#, SYSDATE)			");
		
		
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		if( iTotCount > 0 ) {
			for( int i = 0; i < iTotCount; i++ ) {
				sqlRequest.addParamObject("UPJANG",       iTmpDataSet.getInt(i, "UPJANG")      );
				sqlRequest.addParamObject("SUBINV_CLASS", iTmpDataSet.getString (i, "SUBINV_CLASS"));
				sqlRequest.addParamObject("RECIPE_CD",    iTmpDataSet.getString (i, "RECIPE_CD")   );
				sqlRequest.addParamObject("NUT_SEQ",      new Integer(i+1)                                 );
				sqlRequest.addParamObject("NUT_DESC",     iTmpDataSet.getString (i, "NUT_DESC")    );
				sqlRequest.addParamObject("REMARK",       iTmpDataSet.getString (i, "REMARK")      );
				sqlRequest.addParamObject("CUSER",        sEmpNo                                           );
				iSucCount += executor.execute(sqlRequest);
			}
			
			// Transaction 처리
			if( iTotCount != iSucCount ) {
				throw new BusinessRuntimeException("사업장레시피 영양정보 테이블에 등록 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
			}
		}
		/************** 5.업장레시피 영양정보 등록 End **********************************************************************/
	}
	
	/**
	 * 사업장레시피 삭제
	 * @param ctx
	 * @throws Exception
	 */
	public void deleteRecipe(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsRecipeInfo  = (DataSet) ctx.getInputObject("ds_RECIPE_INFO" );
		
		// 검색조건 DataSet 검증
		if( dsRecipeInfo.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 레시피 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수설정
		int     iUpjang      = dsRecipeInfo.getInt(0, "UPJANG");
		String  sRecipeCd    = dsRecipeInfo.getString(0, "RECIPE_CD"               );
		String  sSubinvClass = dsRecipeInfo.getString(0, "SUBINV_CLASS"            );
		int     iSucCount    = 0;
		int     iTotCount    = 0;
		DataSet iTmpDataSet  = null;
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성 
	    SqlRequest sqlRequest = null;
	    
	    // SQL
	    StringBuffer sbQuery = new StringBuffer();
	    
		/************* 1.업장레시피 영양정보(FMM_UPJANG_RECIPE_NUT) 삭제 Start ****************************************/
// [속도개선 Project 시작] 2017. 7. 7. 최범주 ChangeAddParamObject
	    sbQuery.setLength(0);
		sbQuery.append("\nSELECT NUT_SEQ								");
		sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_NUT					");
		sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
		sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
		sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		sqlRequest.addParamObject("UPJANG", iUpjang);
		sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
		sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
		iTmpDataSet = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// 업장레시피 영양정보 갯수
		iTotCount = iTmpDataSet.getRowCount();
		if( iTotCount > 0 ) {
			sbQuery.setLength(0);
			sbQuery.append("\nDELETE										");
			sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_NUT					");
			sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
			sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
			sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
			iSucCount = executor.execute(sqlRequest);
			
			// Transaction 처리
			if( iTotCount != iSucCount ) {
				throw new BusinessRuntimeException("사업장레시피 영양정보 삭제 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
			}
		}
		/************* 1.업장레시피 영양정보(FMM_UPJANG_RECIPE_NUT) 삭제 Start ****************************************/
		
		/************* 2.업장레시피 특이사항(FMM_UPJANG_RECIPE_SPECIAL) 삭제 Start ************************************/
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT SPECIAL_SEQ							");
		sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_SPECIAL				");
		sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
		sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
		sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		sqlRequest.addParamObject("UPJANG", iUpjang);
		sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
		sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
		iTmpDataSet = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// 업장레시피 영양정보 갯수
		iTotCount = iTmpDataSet.getRowCount();
		if( iTotCount > 0 ) {
			sbQuery.setLength(0);
			sbQuery.append("\nDELETE										");
			sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_SPECIAL				");
			sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
			sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
			sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
			iSucCount = executor.execute(sqlRequest);
			
			// Transaction 처리
			if( iTotCount != iSucCount ) {
				throw new BusinessRuntimeException("사업장레시피 특이사항 삭제 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
			}
		}
		/************* 2.업장레시피 특이사항(FMM_UPJANG_RECIPE_SPECIAL) 삭제 End **************************************/
		
		/************* 3.업장레시피 조리법(FMM_UPJANG_RECIPE_CUISINE) 삭제 Start **************************************/
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT CUISINE_SEQ							");
		sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_CUISINE				");
		sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
		sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
		sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		sqlRequest.addParamObject("UPJANG", iUpjang);
		sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
		sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
		iTmpDataSet = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// 업장레시피 영양정보 갯수
		iTotCount = iTmpDataSet.getRowCount();
		if( iTotCount > 0 ) {
			sbQuery.setLength(0);
			sbQuery.append("\nDELETE										");
			sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_CUISINE				");
			sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
			sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
			sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
			iSucCount = executor.execute(sqlRequest);
			
			// Transaction 처리
			if( iTotCount != iSucCount ) {
				throw new BusinessRuntimeException("사업장레시피 조리법 삭제 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
			}
		}
		/************* 3.업장레시피 조리법(FMM_UPJANG_RECIPE_CUISINE) 삭제 End ****************************************/
		
		/************* 4.업장레시피 식자재(FMM_UPJANG_RECIPE_ITEM) 삭제 Start *****************************************/
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT ITEM_CODE								");
		sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_ITEM					");
		sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
		sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
		sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		sqlRequest.addParamObject("UPJANG", iUpjang);
		sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
		sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
		iTmpDataSet = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// 업장레시피 영양정보 갯수
		iTotCount = iTmpDataSet.getRowCount();
		if( iTotCount > 0 ) {
			sbQuery.setLength(0);
			sbQuery.append("\nDELETE										");
			sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_ITEM					");
			sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
			sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
			sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
			iSucCount = executor.execute(sqlRequest);
			
			// Transaction 처리
			if( iTotCount != iSucCount ) {
				throw new BusinessRuntimeException("사업장레시피 조리법 삭제 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
			}
		}
		 /************* 4.업장레시피 식자재(FMM_UPJANG_RECIPE_ITEM) 삭제 End *******************************************/
		
		 /************* 5.업장레시피(FMM_UPJANG_RECIPE) 삭제 Start ***************************************************/
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT RECIPE_CD								");
		sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_MST					");
		sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
		sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
		sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		sqlRequest.addParamObject("UPJANG", iUpjang);
		sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
		sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
		iTmpDataSet = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// 업장레시피 영양정보 갯수
		iTotCount = iTmpDataSet.getRowCount();
		if( iTotCount == 1 ) {
			sbQuery.setLength(0);
			sbQuery.append("\nDELETE										");
			sbQuery.append("\n  FROM FMM_UPJANG_RECIPE_MST					");
			sbQuery.append("\n WHERE UPJANG = #UPJANG#                      ");
			sbQuery.append("\n   AND SUBINV_CLASS = #SUBINV_CLASS#          ");
			sbQuery.append("\n   AND RECIPE_CD = #RECIPE_CD#                ");
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			sqlRequest.addParamObject("UPJANG", iUpjang);
			sqlRequest.addParamObject("SUBINV_CLASS", sSubinvClass);
			sqlRequest.addParamObject("RECIPE_CD", sRecipeCd);
			iSucCount = executor.execute(sqlRequest);
			
			// Transaction 처리
			if( iTotCount != iSucCount ) {
				throw new BusinessRuntimeException("사업장레시피 삭제 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
			}
		} else {
			throw new BusinessRuntimeException("존재하지 않는 레시피 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
// [속도개선 Project   끝] 2017. 7. 7. 최범주
		/************* 5.업장레시피(FMM_UPJANG_RECIPE) 삭제 End *****************************************************/
	}
}