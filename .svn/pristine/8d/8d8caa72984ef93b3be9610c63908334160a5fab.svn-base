package com.ifis.fs.fsi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.tobesoft.xplatform.data.DataSet;

public class FSI00080V_ACT extends AbstractAction  {

	public void Save(BusinessContext ctx) throws Exception {

		int ds_cnt; 
		String strItemCode, strSelectSql, strInsertSql, strUpdateSql;
		
		strSelectSql = "SELECT 1 AS CNT FROM FSI_STD_PRICE WHERE 1 = 1";
		strSelectSql += " AND ITEM_CODE = ?";
		
		strInsertSql = "INSERT INTO FSI_STD_PRICE( ";
		strInsertSql += "	  ITEM_CODE ";
		strInsertSql +=  "	, MARGIN_PRICE ";
		strInsertSql +=  "	, CUSER ";
		strInsertSql +=  "	, CDATE ";
		strInsertSql += "	, UUSER ";
		strInsertSql += "	, UDATE ";
		strInsertSql += " ) VALUES ( ";
		strInsertSql += "	  #ITEM_CODE# ";
		strInsertSql += "	, #MARGIN_PRICE# ";
		strInsertSql += "	, #CUSER# ";
		strInsertSql += "	, SYSDATE ";
		strInsertSql += "	, #UUSER# ";
		strInsertSql += "	, SYSDATE ";
		strInsertSql += " ) ";
		
		strUpdateSql = " UPDATE ";
		strUpdateSql += " 	FSI_STD_PRICE ";
		strUpdateSql += " SET ";
		strUpdateSql += "	  MARGIN_PRICE = #MARGIN_PRICE# ";
		strUpdateSql += "	, UUSER = #UUSER# ";
		strUpdateSql += "	, UDATE = SYSDATE ";
		strUpdateSql += " WHERE ";
		strUpdateSql += "	 ITEM_CODE = #ITEM_CODE#";		
		
		// SqlRequest 생성
		SqlRequest insertReq = SqlMapFactoryHelper.makeSqlRequestByInsertSql(strInsertSql);
		SqlRequest updateReq = SqlMapFactoryHelper.makeSqlRequestByUpdateSql(strUpdateSql);
		
		SqlExecutor inDb = SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		SqlExecutor upDb = SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
		int inCnt = 0; 
		int upCnt = 0;
		
		int[] rInCnt = new int[]{};
		int[] rUpCnt = new int[]{};
		
		DataSet ds = (DataSet) ctx.getInputObject("ds_in");
		ds_cnt = ds.getRowCount();
		
		Connection con = null;
		PreparedStatement psmt = null;
		
		con = getConnection();

		for(int i = 0; i < ds_cnt; i++){
			
			strItemCode = ds.getString(i, "ITEM_CODE");
			
			psmt = con.prepareStatement(strSelectSql);
			psmt.setString(1, strItemCode);

			ResultSet rs = psmt.executeQuery();
			
			if ( rs.next() ) {
				//  데이터가 있는 경우

				updateReq.addParamObject("ITEM_CODE", strItemCode);
				updateReq.addParamObject("MARGIN_PRICE", ds.getObject(i, "ITEM_PRICE").toString());
				updateReq.addParamObject("UUSER", ctx.getInputString("g_EmpNO"));
				
				if( upCnt == 0 ) {
					upDb.startBatch(updateReq);
				} else {
					upDb.addBatch(updateReq);
				}

				upCnt++;
			} else {
				
				insertReq.addParamObject("ITEM_CODE", strItemCode);
				insertReq.addParamObject("MARGIN_PRICE", ds.getObject(i, "ITEM_PRICE").toString());
				insertReq.addParamObject("CUSER", ctx.getInputString("g_EmpNO"));
				insertReq.addParamObject("UUSER", ctx.getInputString("g_EmpNO"));
				
				
				if( inCnt == 0 ) {
					inDb.startBatch(insertReq);
				} else {
					inDb.addBatch(insertReq);
				}
				
				inCnt++;
			}
			rs.close();
			psmt.close();
		}
		
		if ( inCnt > 0 ) {
			rInCnt = inDb.executeBatch();
		}

		if ( upCnt > 0 ) {
			rUpCnt = upDb.executeBatch();
		}
		
		int ModCnt = rInCnt.length+rUpCnt.length;

		ctx.addOutput("SaveCnt", Integer.toString(ModCnt)); 
		
		rInCnt = null;
		rUpCnt = null;
		
		/*		
		 * Oracle open_cursors의 갯수으로 디폴트 300개 초과시 문제 발생
		 * => JDBC API로 변경 
		int ds_cnt; 
		String strItemCode, strSelectSql, strInsertSql, strUpdateSql;
		
		strSelectSql = "SELECT 1 AS CNT FROM FSI_STD_PRICE WHERE 1 = 1";
		strSelectSql += " AND ITEM_CODE = #ITEM_CODE#";
		
		strInsertSql = "INSERT INTO FSI_STD_PRICE( ";
		strInsertSql += "	  ITEM_CODE ";
		strInsertSql +=  "	, MARGIN_PRICE ";
		strInsertSql +=  "	, CUSER ";
		strInsertSql +=  "	, CDATE ";
		strInsertSql += "	, UUSER ";
		strInsertSql += "	, UDATE ";
		strInsertSql += " ) VALUES ( ";
		strInsertSql += "	  #ITEM_CODE# ";
		strInsertSql += "	, #MARGIN_PRICE# ";
		strInsertSql += "	, #CUSER# ";
		strInsertSql += "	, SYSDATE ";
		strInsertSql += "	, #UUSER# ";
		strInsertSql += "	, SYSDATE ";
		strInsertSql += " ) ";
		
		strUpdateSql = " UPDATE ";
		strUpdateSql += " 	FSI_STD_PRICE ";
		strUpdateSql += " SET ";
		strUpdateSql += "	  MARGIN_PRICE = #MARGIN_PRICE# ";
		strUpdateSql += "	, UUSER = #UUSER# ";
		strUpdateSql += "	, UDATE = SYSDATE ";
		strUpdateSql += " WHERE ";
		strUpdateSql += "	 ITEM_CODE = #ITEM_CODE#";		
		
		// SqlRequest 생성
		SqlRequest selectReq = SqlMapManagerUtility.makeSelectSqlRequestForSql(strSelectSql);
		SqlRequest insertReq = SqlMapManagerUtility.makeInsertSqlRequestForSql(strInsertSql);
		SqlRequest updateReq = SqlMapManagerUtility.makeUpdateSqlRequestForSql(strUpdateSql);
		
		SqlExecutor inDb = new DatasetSqlExecutor(getConnection());
		SqlExecutor upDb = new DatasetSqlExecutor(getConnection());
		
		int inCnt = 0; 
		int upCnt = 0;
		int totCnt = 0;
		int[] rInCnt = new int[]{};
		int[] rUpCnt = new int[]{};
		
		Dataset ds = ctx.getInputDataset("ds_in");
		ds_cnt = ds.getRowCount();

		for(int i = 0; i < ds_cnt; i++){
			
			strItemCode = ds.getColumn(i, "ITEM_CODE").toString();
			
			// 파라메터 설정하기 
			selectReq.addParamObject("ITEM_CODE", strItemCode);

			SqlExecutor SelDb = new SimpleSqlExecutor(getConnection());			
			// 조회 처리
			SqlResult result = SelDb.query(selectReq);
			
			// 조회 결과 객체 찾아오기 
			ResultSet rs = (ResultSet)result.getResultObject();
			
			if ( rs.next() ) {
				//  데이터가 있는 경우

				updateReq.addParamObject("ITEM_CODE", strItemCode);
				updateReq.addParamObject("MARGIN_PRICE", ds.getColumn(i, "ITEM_PRICE").toString());
				updateReq.addParamObject("UUSER", ctx.getInputVariable("g_EmpNO"));
				
				if( upCnt == 0 ) {
					upDb.startBatch(updateReq);
				} else {
					upDb.addBatch(updateReq);
				}

				upCnt++;
				totCnt++;
				
				if(upCnt > 100)
				{
					rUpCnt = upDb.executeBatch();
					upCnt = 0;
				}
			} else {
				
				insertReq.addParamObject("ITEM_CODE", strItemCode);
				insertReq.addParamObject("MARGIN_PRICE", ds.getColumn(i, "ITEM_PRICE").toString());
				insertReq.addParamObject("CUSER", ctx.getInputVariable("g_EmpNO"));
				insertReq.addParamObject("UUSER", ctx.getInputVariable("g_EmpNO"));
				
				
				if( inCnt == 0 ) {
					inDb.startBatch(insertReq);
				} else {
					inDb.addBatch(insertReq);
				}
				
				inCnt++;
				totCnt++;
				
				if(inCnt > 100)
				{
					rInCnt = inDb.executeBatch();
					inCnt = 0;
				}
				
			}
		}
		
		if ( inCnt > 0 ) {
			rInCnt = inDb.executeBatch();
		}

		if ( upCnt > 0 ) {
			rUpCnt = upDb.executeBatch();
		}
		
		//int ModCnt = rInCnt.length+rUpCnt.length;

		ctx.addOutputVariable("SaveCnt", Integer.toString(totCnt)); 
		
		rInCnt = null;
		rUpCnt = null;
*/
	}
		
}
