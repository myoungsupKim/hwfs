
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log ���� ����
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//�Է� ����Ÿ
		DataSet ds_input     	= in_dl.get("ds_Input");

		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String strSubinvCode	= nullToBlank(ds_input.getString(0, "SUBINV_CODE"));// â���ڵ�
		String strHalCD			= nullToBlank(ds_input.getString(0, "HALL_CD"));	// �Ĵ��ڵ�
		String strMenuDate		= nullToBlank(ds_input.getString(0, "MENU_DATE"));	// ������
		String strFromDate		= nullToBlank(ds_input.getString(0, "FROM_DATE"));	// ������ ����
		String strToDate		= nullToBlank(ds_input.getString(0, "TO_DATE"));	// ������ ����
		String strMeal	 		= nullToBlank(ds_input.getString(0, "MEAL"));		// ����
		String strCorner 		= nullToBlank(ds_input.getString(0, "CORNER"));		// �ڳ�

		String strBuyUnit		= nullToBlank(ds_input.getString(0, "BUYUNIT"));			// ���Ŵ�����ȸ
		String strCookingRecipe = nullToBlank(ds_input.getString(0, "COOKINGRECIPE"));		// �������������
		String strResourceCooking = nullToBlank(ds_input.getString(0, "RESOURCECOOKING"));	// ���纰 ������ȹǥ
		String strDressing		= nullToBlank(ds_input.getString(0, "DRESSING"));			// ����
	//System.out.println("strHalCD: "+strHalCD+", strSubinvCode: "+strSubinvCode);

		//out ����Ÿ
		DataSet ds_list;

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //������ȸ
		sbSql.append("\n  SELECT /*+ ORDERED */ A.MENU_DATE, D.HALL_NAME ");
		if(strResourceCooking.equals("1")){
			sbSql.append("\n    	,F.CLASS_NAME  ");
		}
		sbSql.append("\n        ,(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) ||						");
		sbSql.append("\n         (SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) MENU_NAME  ");
		sbSql.append("\n        ,DECODE(D.CAFE_YN,'Y',B.EXPECT_SALE_QTY,DECODE(D.CATER_YN,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY)) EXPECT_MEAL_QTY	  ");
		sbSql.append("\n        ,B.PHF		   		  ");
		sbSql.append("\n        ,B.RECIPE_NAME        ");
		sbSql.append("\n        ,E.ITEM_NAME          ");
		sbSql.append("\n        ,C.NEED_QTY           ");

		// ���Ŵ�����ȸ üũ(1)�� �ƴҶ�(0)
		if(strBuyUnit.equals("1")){
			sbSql.append("\n        ,ROUND(DECODE(D.CAFE_YN,'Y',B.EXPECT_SALE_QTY,DECODE(D.CATER_YN,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))*C.NEED_QTY/1000/E.KG_CONVERT_RATE,2) TOT_QTY  ");
			sbSql.append("\n        ,E.PO_UOM                               ");
		}else{
			sbSql.append("\n        ,DECODE(D.CAFE_YN,'Y',B.EXPECT_SALE_QTY,DECODE(D.CATER_YN,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY))*C.NEED_QTY/1000 TOT_QTY  ");
			sbSql.append("\n        ,'KG' AS PO_UOM 	                ");
		}
		sbSql.append("\n        ,(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0017' AND X.CODE = C.CUT_SPEC) CUT_NAME ");
		sbSql.append("\n        ,DECODE(C.ORDER_YN,'Y',C.NEED_DATE,'') NEED_DATE  ");
		sbSql.append("\n        ,(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0013' AND X.CODE = B.USE_TOOL) TOOL_NAME ");
		sbSql.append("\n    FROM FSM_REAL_MENU_MST A		");
		sbSql.append("\n        ,FSM_REAL_RECIPE_MST B      ");
		sbSql.append("\n        ,FSM_REAL_RECIPE_ITEM C     ");
		sbSql.append("\n        ,FSA_HALL_MST D             ");
		sbSql.append("\n        ,HLDC_PO_ITEM_MST E         ");
		sbSql.append("\n        ,FSA_HALL_DTL G         ");
		// ���纰 ������ȹǥ ����
		if(strResourceCooking.equals("1")){
			sbSql.append("\n		,HLDC_PO_ITEM_CLASS_HLDC_V F   ");
		}
		sbSql.append("\n   WHERE A.UPJANG = B.UPJANG        ");
		sbSql.append("\n     AND A.MENU_CD = B.MENU_CD      ");
		sbSql.append("\n     AND B.UPJANG = C.UPJANG        ");
		sbSql.append("\n     AND B.MENU_CD = C.MENU_CD      ");
		sbSql.append("\n     AND B.RECIPE_CD = C.RECIPE_CD  ");
		sbSql.append("\n     AND A.UPJANG = D.UPJANG        ");
		sbSql.append("\n     AND A.HALL_CD = D.HALL_CD      ");
		sbSql.append("\n     AND C.ITEM_CODE = E.ITEM_CODE  ");
	    sbSql.append("\n     AND G.UPJANG(+) = A.UPJANG        ");
	    sbSql.append("\n     AND G.HALL_CD(+) = A.HALL_CD      ");
	    sbSql.append("\n     AND G.MEAL(+) = A.MEAL            ");
	    sbSql.append("\n     AND G.CORNER(+) = A.CORNER        ");
	    sbSql.append("\n     AND G.USE_YN(+) = 'Y'             ");

		// ���� ����
		if(strDressing.equals("1")){
			sbSql.append("\n		AND E.SPICE_YN = 'N'    ");
		}
		// ���纰 ������ȹǥ ����
		if(strResourceCooking.equals("1")){
			sbSql.append("\n		AND E.ITEM_CLASS2 = F.CLASS_CODE    ");
		}
		sbSql.append("\n     AND A.UPJANG = "+strUpjang+"	-- '100751' ");
		if(!strSubinvCode.equals("00000") && !strSubinvCode.equals("") ){
			sbSql.append("\n     AND A.SUBINV_CODE = '"+strSubinvCode+"'   -- 'C1000001' ");
		}
		//sbSql.append("\n     AND A.MENU_DATE = 	'"+strMenuDate+"'	-- '20071120'    ");
		//������ ����~���� ���� 20180813 ��ȣ��
		sbSql.append("\n     AND A.MENU_DATE between '"+strFromDate+"' AND '"+strToDate+"'	-- '20071120'    ");

		// �Ĵ���   �������� ��쿡�� SQL ���ǹ� �߰�, ��ü�� ������쿡�� throw
		if(! strHalCD.equals("00000") && !strHalCD.equals("")){
			if(! strMenuDate.equals("null")){
				sbSql.append("\n     AND A.HALL_CD = '"+strHalCD+"'		-- '00101' �ϹݽĴ�01  ");
			}
		}

		if(!strMeal.equals("") && !strCorner.equals("")){
			sbSql.append("\n     AND A.MEAL = '"+strMeal+"'		-- '002'         �߽�         ");
			sbSql.append("\n     AND A.CORNER = '"+strCorner+"'		-- '001'     A�ڳ�        ");
		}
		else if(!strMeal.equals("")){
			sbSql.append("\n     AND A.MEAL = '"+strMeal+"' ");
		}
		else if(!strCorner.equals("")){
			sbSql.append("\n     AND A.CORNER = '"+strCorner+"' ");
		}

		// ���纰 ������ȹǥ üũ��
		if(strResourceCooking.equals("1"))
			
			sbSql.append("\n   ORDER BY A.MENU_DATE DESC, F.CLASS_CODE, E.ITEM_NAME, D.HALL_NAME, A.MEAL, A.CORNER");
		else
			sbSql.append("\n   ORDER BY A.MENU_DATE DESC, A.MEAL, A.CORNER, B.MAJOR_DISH_INFO, B.RECIPE_SEQ, B.CUISINE_TYPE, DECODE(D.CATER_YN,'Y',B.EXPECT_SALE_QTY,A.EXPECT_MEAL_QTY), B.RECIPE_CD, C.ITEM_CODE");
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_List"); //ds_list

		/**����**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

		rs.close();
		pstmt.close();
	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
		//jsp log ���� �ݱ�
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}

	}

	proc_output(response,out,out_vl,out_dl);

%>