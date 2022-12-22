package com.ifis.fs.fsr;

import com.sz.business.BusinessRuntimeException;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.util.AppDataUtility;
import com.tobesoft.xplatform.data.DataSet;
/**
 * HMR용 표준레시피 관리
 */
public class FSR00150E_ACT extends AbstractAction {
	
	/**
	 * 레시피 중복체크
	 * @param ctx
	 * @throws Exception
	 */
	public void chkRecipeDuplication(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sRecipeName  = ctx.getInputString("RECIPE_NAME" );
		String sRecipeClass = ctx.getInputString("RECIPE_CLASS");

		// 변수설정
		String sRecipeSeq = "";
		String sRecipeCd  = "";
		
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.append("\nSELECT RECIPE_SEQ						");
		sbQuery.append("\n  FROM FSR_RECIPE_CD_REF				");
		sbQuery.append("\n WHERE RECIPE_NAME = '"+sRecipeName+"'");
		
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		DataSet dsResult = (DataSet) executor.query(sqlRequest).getResultObject();
		
		// FSR_RECIPE_CD_REF
		// 레시피 코드 참조 테이블에 신규레시피명과 동일한 레시피 존재 여부 체크
		if( dsResult.getRowCount() == 0 ) {
			ctx.makeSuccessResult("등록 가능합니다");
		} else { // 레시피 코드 참조 테이블에 신규레시피명과 동일한 레시피 존재할 경우
			sRecipeSeq = dsResult.getString(0, "RECIPE_SEQ");
			sRecipeCd  = sRecipeClass + sRecipeSeq;
			
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT RECIPE_CD, RECIPE_NAME			");
			sbQuery.append("\n  FROM FSR_STD_RECIPE_MST				");
			sbQuery.append("\n WHERE RECIPE_CD = '"+sRecipeCd+"'	");
			
			sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			dsResult = (DataSet) executor.query(sqlRequest).getResultObject();
			
			// 사용자에게 넘기기 
			ctx.addOutput("ds_RecipeValid", dsResult);
			/*
			if( dsResult.getRowCount() == 0 ) {
				ctx.makeSuccessResult("등록 가능합니다.");
			} else {
				ctx.makeSuccessResult("동일한 레시피 존재합니다.\n다른 레시피명을 사용해 주세요.");
			}*/
		}
	}
	
	/**
	 * 신규 레시피코드 생성
	 * @param ctx
	 * @return DataSet
	 * @throws Exception
	 */
	public DataSet getNewRecipeCd(BusinessContext ctx, String sRecipeName, String sRecipeClass) throws Exception {
		
		// return DataSet
		DataSet dsResult = null;
		
		if( AppDataUtility.isNull(sRecipeName) ) {
			return dsResult;
		}
		if( AppDataUtility.isNull(sRecipeClass) ) {
			return dsResult;
		}
		
		// SQL Setting
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.append("\nSELECT RECIPE_SEQ, ('H' || RECIPE_SEQ) AS RECIPE_CD	");
		sbQuery.append("\n  FROM FSR_RECIPE_CD_REF								");
		sbQuery.append("\n WHERE RECIPE_NAME = '"+sRecipeName+"'				");
		
		SqlRequest mainReq = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		dsResult = (DataSet) executor.query(mainReq).getResultObject();
		
		// FSR_RECIPE_CD_REF
		// 레시피 코드 참조 테이블에 신규레시피명과 동일한 레시피 존재 여부 체크
		if( dsResult.getRowCount() == 0 ) { // 신규 순번따기 --> FSR_RECIPE_CD_REF 신규 등록 필요
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT LPAD(NVL(MAX(RECIPE_SEQ),0)+1,5,'0') AS RECIPE_SEQ,							");
			sbQuery.append("\n       ('" + sRecipeClass + "' || LPAD(NVL(MAX(RECIPE_SEQ),0)+1,5,'0')) AS RECIPE_CD	");
			sbQuery.append("\n  FROM FSR_RECIPE_CD_REF																");
			
			mainReq = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
			dsResult = (DataSet) executor.query(mainReq).getResultObject();
			
			sbQuery.setLength(0);
			sbQuery.append("\nINSERT INTO FSR_RECIPE_CD_REF(RECIPE_SEQ, RECIPE_NAME)												");
			sbQuery.append("\n                       VALUES('"+dsResult.getString(0, "RECIPE_SEQ")+"','"+sRecipeName+"')	");
			
			mainReq = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
			
			// INSERT가 제대로 이루어지지 않았다면 null을 넘김으로써 insertRecipe Method에서 Error 처리
			if( executor.execute(mainReq) != 1 ) {
				dsResult = null;
			}
		}
		// 반환 데이터셋
		return dsResult;
	}
	
	/**
	 * HMR 레시피 등록
	 * @param ctx
	 * @throws Exception
	 */
	public void insertRecipe(BusinessContext ctx) throws Exception {
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
		// SQL 요청자 정보 변수 선언
		SqlRequest sqlRequest = null;
		
		// Input DataSet 가져오기
		DataSet dsRecipeInfo = (DataSet)ctx.getInputObject("ds_RecipeInfo");
		DataSet dsItemList   = (DataSet)ctx.getInputObject("ds_ItemList"  );
		DataSet dsCookMethod = (DataSet)ctx.getInputObject("ds_CookMethod");
		DataSet dsSpecial    = (DataSet)ctx.getInputObject("ds_Special"   );
		
		// 레시피 정보 체크
		if( dsRecipeInfo.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("레시피 정보가 올바르지 않습니다.");
		}
		
		// Arguments 가져오기
		String sRecipeName  = ctx.getInputString("RECIPE_NAME" );
		String sRecipeClass = ctx.getInputString("RECIPE_CLASS");
		
		// INSERT 갯수 체크 변수
		int iInsertCnt = 0;
		
		// 신규 레시피순번(등록), 레시피코드 생성
		DataSet dsNew = getNewRecipeCd(ctx, sRecipeName, sRecipeClass);
		
		if( dsNew.equals(null) || dsNew.getRowCount() == 0 ) {
			throw new BusinessRuntimeException("신규 레시피 순번/코드 생성 중 오류가 발생하였습니다.");
		}
		// 레시피코드
		String sNewRecipeCd = dsNew.getString(0, "RECIPE_CD");
		
		/*************** 1.FSR_STD_RECIPE_MST INSERT START **************************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_I001");
		
		// 파라메터 설정하기
		sqlRequest.addParamObject("RECIPE_CD",     sNewRecipeCd                                      );
		sqlRequest.addParamObject("RECIPE_NAME",   dsRecipeInfo.getObject(0, "RECIPE_NAME")  );
		sqlRequest.addParamObject("RECIPE_CLASS",  dsRecipeInfo.getObject(0, "RECIPE_CLASS") );
		sqlRequest.addParamObject("RECIPE_TYPE",   dsRecipeInfo.getObject(0, "RECIPE_TYPE")  );
		sqlRequest.addParamObject("VALID_TIME",    dsRecipeInfo.getObject(0, "VALID_TIME")   );
		sqlRequest.addParamObject("SALE_UOM",      dsRecipeInfo.getObject(0, "SALE_UOM")     );
		sqlRequest.addParamObject("SALE_PRICE",    dsRecipeInfo.getObject(0, "SALE_PRICE")   );
		sqlRequest.addParamObject("GOODS_FEATURE", dsRecipeInfo.getObject(0, "GOODS_FEATURE"));
		sqlRequest.addParamObject("SABUN",         dsRecipeInfo.getObject(0, "SABUN")        );
		sqlRequest.addParamObject("g_EmpNo",       ctx.getInputString("g_EmpNo")                   );
		
		// INSERT COUNT CHECK
		if( executor.execute(sqlRequest) != 1 ) {
			throw new BusinessRuntimeException("레시피 정보 등록 중 오류가 발생하였습니다.");
		}
		/*************** 1.FSR_STD_RECIPE_MST INSERT END ****************************************************************/
		
		/*************** 2.FSR_STD_RECIPE_ITEM INSERT START *************************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_I002");
		
		iInsertCnt = 0;
		for( int i=0; i<dsItemList.getRowCount(); i++ ) {
			sqlRequest.addParamObject("RECIPE_CD",       sNewRecipeCd                                );
			sqlRequest.addParamObject("ITEM_CODE",       dsItemList.getObject(i, "ITEM_CODE"));
			sqlRequest.addParamObject("ds_Key.ITEM_SEQ", dsItemList.getObject(i, "ITEM_SEQ") );
			sqlRequest.addParamObject("NEED_QTY",        dsItemList.getObject(i, "NEED_QTY") );
			sqlRequest.addParamObject("g_EmpNo",         ctx.getInputString("g_EmpNo")             );
			
			iInsertCnt += executor.execute(sqlRequest);
		}
		
		// INSERT COUNT CHECK
		if( iInsertCnt != dsItemList.getRowCount() ) {
			throw new BusinessRuntimeException("자재 정보 등록 중 오류가 발생하였습니다.");
		}
		/*************** 2.FSR_STD_RECIPE_ITEM INSERT END ***************************************************************/
		
		/*************** 3.FSR_STD_RECIPE_CUISINE INSERT START **********************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_I003");
		
		iInsertCnt = 0;
		for( int i=0; i<dsCookMethod.getRowCount(); i++ ) {
			sqlRequest.addParamObject("RECIPE_CD",          sNewRecipeCd                                     );
			sqlRequest.addParamObject("ds_Key.CUISINE_SEQ", new Integer(i+1)                                 );
			sqlRequest.addParamObject("CUISINE_DESC",       dsCookMethod.getObject(i, "CUISINE_DESC"));
			sqlRequest.addParamObject("g_EmpNo",            ctx.getInputString("g_EmpNo")                  );
			
			iInsertCnt += executor.execute(sqlRequest);
		}
		
		// INSERT COUNT CHECK
		if( iInsertCnt != dsCookMethod.getRowCount() ) {
			throw new BusinessRuntimeException("조리과정 등록 중 오류가 발생하였습니다.");
		}
		/*************** 3.FSR_STD_RECIPE_CUISINE INSERT END ************************************************************/
		
		/*************** 4.FSR_STD_RECIPE_SPECIAL INSERT START **********************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_I004");
		
		iInsertCnt = 0;
		for( int i=0; i<dsSpecial.getRowCount(); i++ ) {
			sqlRequest.addParamObject("RECIPE_CD",          sNewRecipeCd                                  );
			sqlRequest.addParamObject("ds_Key.SPECIAL_SEQ", new Integer(i+1)                              );
			sqlRequest.addParamObject("SPECIAL_DESC",       dsSpecial.getObject(i, "SPECIAL_DESC"));
			sqlRequest.addParamObject("g_EmpNo",            ctx.getInputString("g_EmpNo")               );
			
			iInsertCnt += executor.execute(sqlRequest);
		}
		
		// INSERT COUNT CHECK
		if( iInsertCnt != dsSpecial.getRowCount() ) {
			throw new BusinessRuntimeException("위생 및 조리포인트 등록 중 오류가 발생하였습니다.");
		}
		/*************** 4.FSR_STD_RECIPE_SPECIAL INSERT END ************************************************************/
		
		/*************** 5.신규HMR레시피 입력 후 바로 사진정보 입력 / 수정을 위해서 신규레시피코드 SETTING START ************************/
		dsRecipeInfo.set(0, "RECIPE_CD", sNewRecipeCd);
		ctx.addOutput("ds_RecipeInfo", dsRecipeInfo);
		/*************** 5.신규HMR레시피 입력 후 바로 사진정보 입력 / 수정을 위해서 신규레시피코드 SETTING END **************************/
		
		// Transaction
		// ctx.makeSuccessResult("Success!!");
	}
	
	/**
	 * HMR 레시피 삭제
	 * @param ctx
	 * @throws Exception
	 */
	public void deleteRecipe(BusinessContext ctx) throws Exception {
		System.out.println("deleteRecipe");
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
		// SQL ID로 SQL을 처리할 수 있는 요청자 정보 생성 
		// SqlRequest sqlRequest = SqlMapManagerUtility.makeSqlRequest("sample/search:SEARCH_01");
		SqlRequest sqlRequest = null;
		
		// Input DataSet 가져오기
		DataSet dsRecipeInfo = (DataSet) ctx.getInputObject("ds_RecipeInfo");
		DataSet dsItemList   = (DataSet) ctx.getInputObject("ds_ItemList"  );
		DataSet dsCookMethod = (DataSet) ctx.getInputObject("ds_CookMethod");
		DataSet dsSpecial    = (DataSet) ctx.getInputObject("ds_Special"   );
		
		// 레시피 정보 체크
		if( dsRecipeInfo.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("레시피 정보가 올바르지 않습니다.");
		}
		
		// DELETE 갯수 체크 변수
		int iDeleteCnt = 0;
		
		/*************** 1.FSR_STD_RECIPE_MST DELETE START **************************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_D001");
		
		// 파라메터 설정하기
		sqlRequest.addParamObject("RECIPE_CD", dsRecipeInfo.getObject(0, "RECIPE_CD"));
		
		// INSERT COUNT CHECK
		if( executor.execute(sqlRequest) != 1 ) {
			throw new BusinessRuntimeException("레시피 정보 삭제 중 오류가 발생하였습니다.");
		}
		/*************** 1.FSR_STD_RECIPE_MST DELETE END ****************************************************************/
		
		/*************** 2.FSR_STD_RECIPE_ITEM DELETE START *************************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_D002");
		
		iDeleteCnt = 0;
		for( int i=0; i<dsItemList.getRowCount(); i++ ) {
			sqlRequest.addParamObject("RECIPE_CD", dsItemList.getObject(i, "RECIPE_CD"));
			sqlRequest.addParamObject("ITEM_CODE", dsItemList.getObject(i, "ITEM_CODE"));
			
			iDeleteCnt += executor.execute(sqlRequest);
		}
		
		// INSERT COUNT CHECK
		if( iDeleteCnt != dsItemList.getRowCount() ) {
			throw new BusinessRuntimeException("자재 정보 삭제 중 오류가 발생하였습니다.");
		}
		/*************** 2.FSR_STD_RECIPE_ITEM DELETE END ***************************************************************/
		
		/*************** 3.FSR_STD_RECIPE_CUISINE DELETE START **********************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_D003");
		
		iDeleteCnt = 0;
		for( int i=0; i<dsCookMethod.getRowCount(); i++ ) {
			sqlRequest.addParamObject("RECIPE_CD",   dsCookMethod.getObject(i, "RECIPE_CD")  );
			sqlRequest.addParamObject("CUISINE_SEQ", dsCookMethod.getObject(i, "CUISINE_SEQ"));
			
			iDeleteCnt += executor.execute(sqlRequest);
		}
		
		// DELETE COUNT CHECK
		if( iDeleteCnt != dsCookMethod.getRowCount() ) {
			throw new BusinessRuntimeException("조리과정 삭제 중 오류가 발생하였습니다.");
		}
		/*************** 3.FSR_STD_RECIPE_CUISINE DELETE END ************************************************************/
		
		/*************** 4.FSR_STD_RECIPE_SPECIAL DELETE START **********************************************************/
		// SQL Setting
		sqlRequest = SqlMapFactoryHelper.makeSqlRequest("fs/fsr:FSR00150E_D004");
		
		iDeleteCnt = 0;
		for( int i=0; i<dsSpecial.getRowCount(); i++ ) {
			sqlRequest.addParamObject("RECIPE_CD",   dsSpecial.getObject(i, "RECIPE_CD")  );
			sqlRequest.addParamObject("SPECIAL_SEQ", dsSpecial.getObject(i, "SPECIAL_SEQ"));
			
			iDeleteCnt += executor.execute(sqlRequest);
		}
		
		// INSERT COUNT CHECK
		if( iDeleteCnt != dsSpecial.getRowCount() ) {
			throw new BusinessRuntimeException("위생 및 조리포인트 삭제 중 오류가 발생하였습니다.");
		}
		/*************** 4.FSR_STD_RECIPE_SPECIAL DELETE END ************************************************************/
		
		// Transaction
		// ctx.makeSuccessResult("Success!!");
	}
}
