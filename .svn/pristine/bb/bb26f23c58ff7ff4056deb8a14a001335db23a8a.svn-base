package com.ifis.ma.mac;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.tobesoft.xplatform.data.DataSet;
/**
 * 
 */
public class MAC_COMMON_SELECT extends AbstractAction {
	
	public void search(BusinessContext ctx) throws Exception {	
		// 입력 데이터 셋 구하기 
		DataSet ds = (DataSet)ctx.getInputObject("ds_cond");
		
		// Sql 처리 객체 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequest(ctx.getInputString("SqlSearchCode"));
		
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
	
	
    // 해당 COMMON QUERY XMD NAME RETURN#######################################
	public String SqlSearch(String SqlID) throws Exception {	
		
	    String str_Return;
	    str_Return = "ma/mac:" + SqlID;
	    
	    // 추후 구현부#######################################
		return str_Return;		
	}
    // 해당 COMMON QUERY XMD NAME RETURN#######################################
	
	
}
