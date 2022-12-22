package com.ifis.ma.mae;

import com.sz.core.ServiceManagerFactory;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.service.ui.xplatform.SaveService; 
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.tobesoft.xplatform.data.DataSet;
/**
 * 
 */
public class MAE10010E_ACT extends AbstractAction {
	
	//String str_SELECT = "MAE10010E_SEL001";
	//String str_INSERT = "MAE10010E_I001";
	//String str_UPDATE = "MAE10010E_U001";
	//String str_DELETE = "";
	
	public void search(BusinessContext ctx) throws Exception {	
		
			
		
		// 입력 데이터 셋 구하기 
		DataSet ds = (DataSet)ctx.getInputObject("ds_cond");
		
		// Sql 처리 객체 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequest(
				"ma/mae:" + ctx.getInputString("SqlSearchCode"));

		// 처리할 Parameter 정보 설정 
		sqlRequest.addParamObject("ds_cond", ds);

		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		               
	    // 처리된 결과 반환 
		DataSet dsRtn = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// 사용자에게 넘기기 
		ctx.addOutput("ds_list", dsRtn);
	}

	public void getDuplicationCheck(BusinessContext ctx) throws Exception {	
		
		// 입력 데이터 셋 구하기 
		DataSet ds = (DataSet)ctx.getInputObject("ds_cond");
		
		// Sql 처리 객체 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequest(
					"ma/mae:" + ctx.getInputString("SqlSearchCode"));

		// 처리할 Parameter 정보 설정 
		sqlRequest.addParamObject("ds_cond", ds);

		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
		/*               
	    // 처리된 결과 반환 
		DataSet dsRtn = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// 사용자에게 넘기기 
		ctx.addOutput("ds_list", dsRtn);
		*/
	
	    // 처리된 결과 반환 
	    DataSet dsRtn = (DataSet)executor.query(sqlRequest).getResultObject();
		ctx.addOutput("ds_list", dsRtn);		
	}

	public void execute(BusinessContext ctx) throws Exception {	
		// 입력 데이터 셋 구하기 
		DataSet ds = (DataSet)ctx.getInputObject("ds_cond");
		//ds.addColumn("CUSER", arg1, ctx.getUserInfo().get(""))		
		SaveService saveSvr = (SaveService)ServiceManagerFactory.getServiceObject("saveService");
		
		//SqlRequest req = SqlMapManagerUtility.makeSelectSql("select ");
		//req.add
		
		saveSvr.save(ds, "ma/mae:" + ctx.getInputString("SqlSearchCode_INSERT")
					, "ma/mae:" + ctx.getInputString("SqlSearchCode_UPDATE")
					, null);
	}	
}
