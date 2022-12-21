<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 레시피관리 > HMR용 표준레시피 관리
 - ViewPage    : FSR00150E.xml
 - Description : 표준레시피 리스트 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 05. 27 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility"%>

<%@page contentType="text/html; charset=EUC-KR"%>
<%@include file = "../../sc/main/common.jsp"%>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN DataSet
		DataSet ds_MainInput = in_dl.get("ds_MainInput");
		
		// Variables
		String sRecipeName  = nullToBlank(ds_MainInput.getString(0, "RECIPE_NAME" ));
		String sRecipeClass = nullToBlank(ds_MainInput.getString(0, "RECIPE_CLASS"));
		String sRecipeType  = nullToBlank(ds_MainInput.getString(0, "RECIPE_TYPE" ));
		String sCuisineType = nullToBlank(ds_MainInput.getString(0, "CUISINE_TYPE"));
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT RECIPE_CD, RECIPE_NAME, RECIPE_CLASS,		");
		sbQuery.append("\n       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE='FS0001' AND USE_YN='Y' AND CODE=RECIPE_CLASS) AS RECIPE_CLASS_NAME,	");
		sbQuery.append("\n       RECIPE_TYPE, (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE='FS0002' AND USE_YN='Y' AND CODE=RECIPE_TYPE) AS RECIPE_TYPE_NAME,	");
		sbQuery.append("\n       SALE_PRICE, (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE='FS0015' AND CODE=SALE_UOM) AS SALE_UOM, WONGA_PRICE,					");
		sbQuery.append("\n       ROUND(DECODE(SALE_PRICE, 0, 0, (WONGA_PRICE / SALE_PRICE) * 100), 1) || '%' AS WONGA_PER -- 원가율 = (원가/판매가) * 100	");
		sbQuery.append("\n  FROM (SELECT RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, SALE_PRICE, SALE_UOM,	");
		sbQuery.append("\n               MAX(MARGIN_PRICE) AS MARGIN_PRICE, ROUND(SUM(WONGA_PRICE)) AS WONGA_PRICE	");
		sbQuery.append("\n          FROM (SELECT A.RECIPE_CD, A.RECIPE_NAME, A.RECIPE_CLASS, A.RECIPE_TYPE, NVL(A.SALE_PRICE,0) AS SALE_PRICE, A.SALE_UOM, B.ITEM_CODE, C.MARGIN_PRICE,	");
		sbQuery.append("\n                       B.NEED_QTY * (NVL(C.MARGIN_PRICE,0) / D.KG_CONVERT_RATE / 1000) AS WONGA_PRICE -- 원가 = (필요량 * (출하율적용단가 / KG당비율)) / 1000		");
		sbQuery.append("\n                  FROM FSR_STD_RECIPE_MST A,  -- KEY : RECIPE_CD	");
		sbQuery.append("\n                       FSR_STD_RECIPE_ITEM B, -- KEY : RECIPE_CD, ITEM_CODE	");
		sbQuery.append("\n                       FSI_STD_PRICE C,       -- KEY : ITEM_CODE	");
		sbQuery.append("\n                       (SELECT ITEM_CODE, KG_CONVERT_RATE	");
		sbQuery.append("\n                          FROM HLDC_PO_ITEM_MST	");
		sbQuery.append("\n                         WHERE ITEM_CODE BETWEEN '010100000001' AND '019999999999') D	");
		sbQuery.append("\n                 WHERE 1 = 1	");
		if( !sRecipeName.equals("") ) {
			sbQuery.append("\n                   AND A.RECIPE_NAME LIKE '%' || '" + sRecipeName + "' || '%'	");
		}
		if( !sRecipeClass.equals("0") ) {
			sbQuery.append("\n                   AND A.RECIPE_CLASS = '" + sRecipeClass + "'	");
		}
		if( !sRecipeType.equals("0") ) {
			sbQuery.append("\n                   AND A.RECIPE_TYPE = '" + sRecipeType + "'	");
		}
		if( !sCuisineType.equals("0") ) {
			sbQuery.append("\n                   AND A.CUISINE_TYPE = '" + sCuisineType + "'	");
		}
	    sbQuery.append("\n                   AND A.RECIPE_CD = B.RECIPE_CD	");
	    sbQuery.append("\n                   AND B.ITEM_CODE = C.ITEM_CODE(+)	");
	    sbQuery.append("\n                   AND B.ITEM_CODE = D.ITEM_CODE(+))	");
	    sbQuery.append("\n         GROUP BY RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, SALE_PRICE, SALE_UOM)	");
	    sbQuery.append("\n ORDER BY RECIPE_CLASS, RECIPE_TYPE, RECIPE_CD	");
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		DataSet ds_MainRecipeList = this.makeDataSet(rs, "ds_MainRecipeList");
		out_dl.add(ds_MainRecipeList);
		
	   	this.setResultMessage(0, "OK", out_vl);
	} catch(Exception ex) {
	   ex.printStackTrace();
       this.setResultMessage(-1, ex.toString(), out_vl);
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
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		proc_output(response, out, out_vl, out_dl);
	}
%>