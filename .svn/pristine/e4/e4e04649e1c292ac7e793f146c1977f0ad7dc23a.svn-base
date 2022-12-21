
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		String g_EmpNo = in_vl.getString("g_EmpNo");

		DataSet in_ds  =  in_dl.get("FSA00030E_T001");
		stmt =  conn.createStatement();

		//FileLog.println("d:\\bbb.txt",in_ds);


		int RowCnt = in_ds.getRowCount();
		int i=0;
		int RowStatus=0;
		StringBuffer sbSql = new StringBuffer();

		RowCnt = in_ds.getRowCount();

		//System.out.println("RowCnt : " + RowCnt);
		for ( i = 0 ; i < RowCnt ; i++ )
		{

			if(RowCnt>0){ RowStatus	= in_ds.getRowType(i); }

			//System.out.println(i + ":" + RowStatus);
			//System.out.println("CHG_DATA : " + in_ds.getString(i, "CHG_DATA"));
			//System.out.println("RECIPE_CD : " + in_ds.getString(i, "RECIPE_CD").toString());

			if( RowCnt > 0 && (RowStatus == DataSet.ROW_TYPE_INSERTED || RowStatus == DataSet.ROW_TYPE_UPDATED))
			{

 		    	//표준레시피일 경우
			    if (nullToBlank(in_ds.getString(i, "CHG_DATA")).equals("S"))
			    {
	    	    ///로우 스태이터스 플래그가 insert 이면 insert 를 수행한다.
				   if(RowStatus == DataSet.ROW_TYPE_INSERTED)
				   {
				   //표준레시피 마스터 복사 후 업장 표준레시피로 전환: ATTR01====> :STD || TO_CHAR(SYSDATE,'YYYYMMDD')
			       	sbSql.delete(0, sbSql.length());
			        sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_MST(UPJANG, HALL_CLASS, RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, USE_YN, SPHOTO_PATH, ATTR01, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()     +", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, USE_YN, SPHOTO_PATH, 'STD:'||TO_CHAR(SYSDATE,'YYYYMMDD'), '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_STD_RECIPE_MST ");
	        		sbSql.append("WHERE  RECIPE_CD = '"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
	        		stmt.execute(sbSql.toString());
	               }
				   ///로우 스태이터스 플래그가  update 이면 마스터는 update 를 수행- 선호도, 찬기(사용기구), 예상판매수량, 판매가는  기존 데이터를 유지 그외는 모두  update
				   // 레시피 품목, 조리법, 특이사항은 DELETE 후 insert 를 구현한다.
				   else if(RowStatus == DataSet.ROW_TYPE_UPDATED)
				    {
			    			sbSql.delete(0, sbSql.length());
						//DELETE를 수행한다. --업장표준레시피 품목
				    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_ITEM											  ");
						sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
						sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
						sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
							stmt.execute(sbSql.toString());

							sbSql.delete(0, sbSql.length());
						//DELETE를 수행한다. --업장표준레시피 조리법
				    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_CUISINE								  ");
						sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
						sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
						sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
							stmt.execute(sbSql.toString());

							sbSql.delete(0, sbSql.length());
						//DELETE를 수행한다. --업장표준레시피 특이사항
				    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_SPECIAL											  ");
						sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
						sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
						sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
							stmt.execute(sbSql.toString());


						sbSql.delete(0, sbSql.length());
						//표준 레시피 마스터를 SELECT 해 온다.
						sbSql.append(" SELECT RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, USE_YN, SPHOTO_PATH ");
						sbSql.append("   FROM FSR_STD_RECIPE_MST ");
						sbSql.append("   WHERE RECIPE_CD=    '"+ in_ds.getString(i, "RECIPE_CD").toString() + "' ");
							rs = stmt.executeQuery(sbSql.toString());
							rs.next();


							sbSql.delete(0, sbSql.length());
						//업장마스터는 UPDATE를 수행한다.	 - 사용기구(찬기), 예상판매수량, 선호도를 제외하고 모두 UPDATE 한다.
					    sbSql.append("UPDATE FSR_UPJANG_RECIPE_MST ");
					    sbSql.append("SET ");
					//	sbSql.append("UPJANG          =" + nullToBlank(in_ds.getString(i,"UPJANG"))   +", \n");
					//	sbSql.append("HALL_CLASS      ='" + nullToBlank(in_ds.getString(i,"HALL_CLASS"))   +"', \n");
					//	sbSql.append("RECIPE_CD       ='" + nullToBlank(in_ds.getString(i,"RECIPE_CD"))   +"', \n");
						sbSql.append("RECIPE_NAME     ='" + nullToBlank(rs.getString("RECIPE_NAME"))  +"', \n");
						sbSql.append("RECIPE_CLASS    ='" + nullToBlank(rs.getString("RECIPE_CLASS"))   +"', \n");
						sbSql.append("RECIPE_TYPE     ='" + nullToBlank(rs.getString("RECIPE_TYPE"))   +"', \n");
						sbSql.append("CUISINE_TYPE    ='" + nullToBlank(rs.getString("CUISINE_TYPE")) +"', \n");
						sbSql.append("MAIN_ITEM_CODE1 ='" + nullToBlank(rs.getString("MAIN_ITEM_CODE1"))  +"', \n");
						sbSql.append("MAIN_ITEM_CODE2 ='" + nullToBlank(rs.getString("MAIN_ITEM_CODE2"))  +"', \n");
						sbSql.append("COOK_TOOL1      ='" + nullToBlank(rs.getString("COOK_TOOL1"))   +"', \n");
						sbSql.append("COOK_TOOL2      ='" + nullToBlank(rs.getString("COOK_TOOL2"))   +"', \n");
						sbSql.append("RECIPE_COLOR    ='" + nullToBlank(rs.getString("RECIPE_COLOR"))   +"', \n");
						sbSql.append("RECIPE_SHAPE    ='" + nullToBlank(rs.getString("RECIPE_SHAPE"))   +"', \n");
						sbSql.append("RECIPE_TASTE    ='" + nullToBlank(rs.getString("RECIPE_TASTE"))   +"', \n");
						sbSql.append("RECIPE_FEEL     ='" + nullToBlank(rs.getString("RECIPE_FEEL"))   +"', \n");
						sbSql.append("RECIPE_TEMPER   ='" + nullToBlank(rs.getString("RECIPE_TEMPER"))   +"', \n");
						sbSql.append("SPRING_YN       ='" + nullToBlank(rs.getString("SPRING_YN"))   +"', \n");
						sbSql.append("SUMMER_YN       ='" + nullToBlank(rs.getString("SUMMER_YN"))   +"', \n");
						sbSql.append("AUTUMN_YN       ='" + nullToBlank(rs.getString("AUTUMN_YN"))   +"', \n");
						sbSql.append("WINTER_YN       ='" + nullToBlank(rs.getString("WINTER_YN"))   +"', \n");
						sbSql.append("RESP_NUT1       ='" + nullToBlank(rs.getString("RESP_NUT1"))   +"', \n");
						sbSql.append("RESP_NUT2       ='" + nullToBlank(rs.getString("RESP_NUT2"))   +"', \n");
				   //   sbSql.append("USE_TOOL        ='" + rs.getString("USE_TOOL")   +"', \n");
						sbSql.append("VALID_TIME      ='" + nullToBlank(rs.getString("VALID_TIME"))   +"', \n");
						sbSql.append("DISPLAY_METHOD  ='" + nullToBlank(rs.getString("DISPLAY_METHOD"))   +"', \n");
						sbSql.append("SALE_UOM        ='" + nullToBlank(rs.getString("SALE_UOM"))   +"', \n");
				   //	sbSql.append("SALE_PRICE      =" + rs.getString("SALE_PRICE")   +", \n");
						sbSql.append("COST_RATE       =" + nullToZero(rs.getString("COST_RATE"))   +", \n");
				   //   sbSql.append("EXPECT_SALE_QTY =" + rs.getString("EXPECT_SALE_QTY")   +", \n");
						sbSql.append("CORE_TEMPER_YN  ='" + nullToBlank(rs.getString("CORE_TEMPER_YN"))   +"', \n");
						sbSql.append("GOODS_FEATURE   ='" + nullToBlank(rs.getString("GOODS_FEATURE"))   +"', \n");
						sbSql.append("PHF_MGMT_YN     ='" + nullToBlank(rs.getString("PHF_MGMT_YN"))   +"', \n");
						sbSql.append("PHF_MGMT1       ='" + nullToBlank(rs.getString("PHF_MGMT1"))   +"', \n");
						sbSql.append("PHF_MGMT2       ='" + nullToBlank(rs.getString("PHF_MGMT2"))   +"', \n");
						sbSql.append("PHF_MGMT3       ='" + nullToBlank(rs.getString("PHF_MGMT3"))   +"', \n");
						sbSql.append("PHF_MGMT4       ='" + nullToBlank(rs.getString("PHF_MGMT4"))   +"', \n");
						sbSql.append("PHF_MGMT5       ='" + nullToBlank(rs.getString("PHF_MGMT5"))   +"', \n");
						sbSql.append("COOK_OPRN       ='" + nullToBlank(rs.getString("COOK_OPRN"))   +"', \n");
						sbSql.append("PHOTO_PATH      ='" + nullToBlank(rs.getString("PHOTO_PATH"))   +"', \n");
				   //   sbSql.append("PREFER          ='" + rs.getString("PREFER")   +"', \n");
						sbSql.append("USE_YN          ='" + nullToBlank(rs.getString("USE_YN"))   +"', \n");
						sbSql.append("CUSER           = '" + g_EmpNo + "', \n");
						sbSql.append("CDATE           = SYSDATE, \n");
						sbSql.append("UUSER           = '" + g_EmpNo + "', \n");
						sbSql.append("UDATE           = SYSDATE, \n");
						sbSql.append("SPHOTO_PATH     ='" + nullToBlank(rs.getString("SPHOTO_PATH"))   +"', \n");
						sbSql.append("ATTR01          ='STD:'||TO_CHAR(SYSDATE,'YYYYMMDD') \n");
						sbSql.append("WHERE UPJANG    = " + nullToBlank(in_ds.getString(i,"UPJANG"))   +" \n");
						sbSql.append("AND HALL_CLASS  ='" + nullToBlank(in_ds.getString(i,"HALL_CLASS"))   +"' \n");
						sbSql.append("AND RECIPE_CD   ='" + nullToBlank(in_ds.getString(i,"RECIPE_CD"))   +"' \n");
						stmt.execute(sbSql.toString());

				   }

	        		   sbSql.delete(0, sbSql.length());
	        		sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_ITEM(UPJANG, HALL_CLASS, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, USE_YN, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()     +", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, USE_YN, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_STD_RECIPE_ITEM ");
	        		sbSql.append("WHERE  RECIPE_CD ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
	            		stmt.execute(sbSql.toString());

	        		   sbSql.delete(0, sbSql.length());
	        		sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_CUISINE(UPJANG, HALL_CLASS, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()     +", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_STD_RECIPE_CUISINE ");
	        		sbSql.append("WHERE  RECIPE_CD ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
	        			stmt.execute(sbSql.toString());

	        		   sbSql.delete(0, sbSql.length());
	        		sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_SPECIAL(UPJANG, HALL_CLASS, RECIPE_CD, SPECIAL_SEQ, SPECIAL_DESC, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()     +", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, SPECIAL_SEQ, SPECIAL_DESC, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_STD_RECIPE_SPECIAL ");
	        		sbSql.append("WHERE  RECIPE_CD ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
	        			stmt.execute(sbSql.toString());

	    	    }
				//타 업장 표준레시피일 경우
				else if(nullToBlank(in_ds.getString(i, "CHG_DATA")).equals("U"))
			    {
				    ///로우 스태이터스 플래그가 insert 이면 insert 를 수행한다.
				    if(RowStatus == DataSet.ROW_TYPE_INSERTED)
		    		{
				    	//System.out.println(">>>>>> 입력");
				    	//타업장표준레시피 마스터 복사 : ATTR01====> 'UPJANG:'||'"+ in_ds.getString(i,  "TA_UPJANG").toString() +"'||TO_CHAR(SYSDATE,'YYYYMMDD')

 				       	sbSql.delete(0, sbSql.length());
				        sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_MST(UPJANG, HALL_CLASS, RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, USE_YN, SPHOTO_PATH, ATTR01, CUSER, CDATE, UUSER, UDATE) ");
		        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()     +", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, USE_YN, SPHOTO_PATH,'UPJANG:'||'"+ in_ds.getString(i,  "TA_UPJANG").toString() +"'||':'||TO_CHAR(SYSDATE,'YYYYMMDD'), '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
		        		sbSql.append("FROM   FSR_UPJANG_RECIPE_MST ");
		        		sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i,  "TA_UPJANG").toString()     +"  ");
						sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "TA_HALL_CLASS").toString()+"' ");
						sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
						stmt.execute(sbSql.toString());

		    		}

				    ///로우 스태이터스 플래그가  update 이면 마스터는 update 를 수행- 선호도, 찬기(사용기구), 예상판매수량은 기존 데이터를 유지 그외는 모두  update
				    // 레시피 품목, 조리법, 특이사항은 DELETE 후 insert 를 구현한다.
				    else if(RowStatus == DataSet.ROW_TYPE_UPDATED)
				    {
				    	//System.out.println(">>>>>> 수정");
 						sbSql.delete(0, sbSql.length());
						//DELETE를 수행한다. --업장표준레시피 품목
				    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_ITEM											  ");
						sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
						sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
						sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
						stmt.execute(sbSql.toString());

						sbSql.delete(0, sbSql.length());
						//DELETE를 수행한다. --업장표준레시피 조리법
				    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_CUISINE								  ");
						sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
						sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
						sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
						stmt.execute(sbSql.toString());

						sbSql.delete(0, sbSql.length());
						//DELETE를 수행한다. --업장표준레시피 특이사항
				    	sbSql.append("DELETE FROM FSR_UPJANG_RECIPE_SPECIAL											  ");
						sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "UPJANG").toString()     +"  ");
						sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "HALL_CLASS").toString()+"' ");
						sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
						stmt.execute(sbSql.toString());


						sbSql.delete(0, sbSql.length());
						//타업장 레시피 마스터를 SELECT 해 온다.
						sbSql.append(" SELECT RECIPE_NAME, RECIPE_CLASS, RECIPE_TYPE, CUISINE_TYPE, MAIN_ITEM_CODE1, MAIN_ITEM_CODE2, COOK_TOOL1, COOK_TOOL2, RECIPE_COLOR, RECIPE_SHAPE, RECIPE_TASTE, RECIPE_FEEL, RECIPE_TEMPER, SPRING_YN, SUMMER_YN, AUTUMN_YN, WINTER_YN, RESP_NUT1, RESP_NUT2, USE_TOOL, VALID_TIME, DISPLAY_METHOD, SALE_UOM, SALE_PRICE, COST_RATE, EXPECT_SALE_QTY, CORE_TEMPER_YN, GOODS_FEATURE, PHF_MGMT_YN, PHF_MGMT1, PHF_MGMT2, PHF_MGMT3, PHF_MGMT4, PHF_MGMT5, COOK_OPRN, PHOTO_PATH, PREFER, USE_YN, SPHOTO_PATH ");
						sbSql.append("   FROM FSR_UPJANG_RECIPE_MST ");
						sbSql.append("  WHERE UPJANG=        "+ in_ds.getString(i, "TA_UPJANG").toString() +" ");
						sbSql.append("    AND HALL_CLASS=   '"+ in_ds.getString(i, "TA_HALL_CLASS").toString() + "' ");
						sbSql.append("    AND RECIPE_CD=    '"+ in_ds.getString(i, "RECIPE_CD").toString() + "' ");
						rs = stmt.executeQuery(sbSql.toString());
						rs.next();

						sbSql.delete(0, sbSql.length());
						//업장마스터는 UPDATE를 수행한다.	 - 사용기구(찬기), 예상판매수량, 선호도를 제외하고 모두 UPDATE 한다.
					    sbSql.append("UPDATE FSR_UPJANG_RECIPE_MST ");
					    sbSql.append("SET ");
					//	sbSql.append("UPJANG          =" + nullToBlank(in_ds.getString(i,"UPJANG"))   +", \n");
					//	sbSql.append("HALL_CLASS      ='" + nullToBlank(in_ds.getString(i,"HALL_CLASS"))   +"', \n");
					//	sbSql.append("RECIPE_CD       ='" + nullToBlank(in_ds.getString(i,"RECIPE_CD"))   +"', \n");
						sbSql.append("RECIPE_NAME     ='" + nullToBlank(rs.getString("RECIPE_NAME"))  +"', \n");
						sbSql.append("RECIPE_CLASS    ='" + nullToBlank(rs.getString("RECIPE_CLASS"))   +"', \n");
						sbSql.append("RECIPE_TYPE     ='" + nullToBlank(rs.getString("RECIPE_TYPE"))   +"', \n");
						sbSql.append("CUISINE_TYPE    ='" + nullToBlank(rs.getString("CUISINE_TYPE")) +"', \n");
						sbSql.append("MAIN_ITEM_CODE1 ='" + nullToBlank(rs.getString("MAIN_ITEM_CODE1"))  +"', \n");
						sbSql.append("MAIN_ITEM_CODE2 ='" + nullToBlank(rs.getString("MAIN_ITEM_CODE2"))  +"', \n");
						sbSql.append("COOK_TOOL1      ='" + nullToBlank(rs.getString("COOK_TOOL1"))   +"', \n");
						sbSql.append("COOK_TOOL2      ='" + nullToBlank(rs.getString("COOK_TOOL2"))   +"', \n");
						sbSql.append("RECIPE_COLOR    ='" + nullToBlank(rs.getString("RECIPE_COLOR"))   +"', \n");
						sbSql.append("RECIPE_SHAPE    ='" + nullToBlank(rs.getString("RECIPE_SHAPE"))   +"', \n");
						sbSql.append("RECIPE_TASTE    ='" + nullToBlank(rs.getString("RECIPE_TASTE"))   +"', \n");
						sbSql.append("RECIPE_FEEL     ='" + nullToBlank(rs.getString("RECIPE_FEEL"))   +"', \n");
						sbSql.append("RECIPE_TEMPER   ='" + nullToBlank(rs.getString("RECIPE_TEMPER"))   +"', \n");
						sbSql.append("SPRING_YN       ='" + nullToBlank(rs.getString("SPRING_YN"))   +"', \n");
						sbSql.append("SUMMER_YN       ='" + nullToBlank(rs.getString("SUMMER_YN"))   +"', \n");
						sbSql.append("AUTUMN_YN       ='" + nullToBlank(rs.getString("AUTUMN_YN"))   +"', \n");
						sbSql.append("WINTER_YN       ='" + nullToBlank(rs.getString("WINTER_YN"))   +"', \n");
						sbSql.append("RESP_NUT1       ='" + nullToBlank(rs.getString("RESP_NUT1"))   +"', \n");
						sbSql.append("RESP_NUT2       ='" + nullToBlank(rs.getString("RESP_NUT2"))   +"', \n");
				   //   sbSql.append("USE_TOOL        ='" + rs.getString("USE_TOOL")   +"', \n");
						sbSql.append("VALID_TIME      ='" + nullToBlank(rs.getString("VALID_TIME"))   +"', \n");
						sbSql.append("DISPLAY_METHOD  ='" + nullToBlank(rs.getString("DISPLAY_METHOD"))   +"', \n");
						sbSql.append("SALE_UOM        ='" + nullToBlank(rs.getString("SALE_UOM"))   +"', \n");
						sbSql.append("SALE_PRICE      =" + nullToZero(rs.getString("SALE_PRICE"))   +", \n");
						sbSql.append("COST_RATE       =" + nullToZero(rs.getString("COST_RATE"))   +", \n");
				   //   sbSql.append("EXPECT_SALE_QTY =" + rs.getString("EXPECT_SALE_QTY")   +", \n");
						sbSql.append("CORE_TEMPER_YN  ='" + nullToBlank(rs.getString("CORE_TEMPER_YN"))   +"', \n");
						sbSql.append("GOODS_FEATURE   ='" + nullToBlank(rs.getString("GOODS_FEATURE"))   +"', \n");
						sbSql.append("PHF_MGMT_YN     ='" + nullToBlank(rs.getString("PHF_MGMT_YN"))   +"', \n");
						sbSql.append("PHF_MGMT1       ='" + nullToBlank(rs.getString("PHF_MGMT1"))   +"', \n");
						sbSql.append("PHF_MGMT2       ='" + nullToBlank(rs.getString("PHF_MGMT2"))   +"', \n");
						sbSql.append("PHF_MGMT3       ='" + nullToBlank(rs.getString("PHF_MGMT3"))   +"', \n");
						sbSql.append("PHF_MGMT4       ='" + nullToBlank(rs.getString("PHF_MGMT4"))   +"', \n");
						sbSql.append("PHF_MGMT5       ='" + nullToBlank(rs.getString("PHF_MGMT5"))   +"', \n");
						sbSql.append("COOK_OPRN       ='" + nullToBlank(rs.getString("COOK_OPRN"))   +"', \n");
						sbSql.append("PHOTO_PATH      ='" + nullToBlank(rs.getString("PHOTO_PATH"))   +"', \n");
				   //   sbSql.append("PREFER          ='" + rs.getString("PREFER")   +"', \n");
						sbSql.append("USE_YN          ='" + nullToBlank(rs.getString("USE_YN"))   +"', \n");
						sbSql.append("CUSER           = '" + g_EmpNo + "', \n");
						sbSql.append("CDATE           = SYSDATE, \n");
						sbSql.append("UUSER           = '" + g_EmpNo + "', \n");
						sbSql.append("UDATE           = SYSDATE, \n");
						sbSql.append("SPHOTO_PATH     ='" + nullToBlank(rs.getString("SPHOTO_PATH"))   +"',  \n");
						sbSql.append("ATTR01          ='TA_UPJANG:'||'"+ in_ds.getString(i,  "TA_UPJANG").toString() +"'||':'||TO_CHAR(SYSDATE,'YYYYMMDD')  \n");
						sbSql.append("WHERE UPJANG    = " + nullToBlank(in_ds.getString(i,"UPJANG"))   +"  \n");
						sbSql.append("AND HALL_CLASS  ='" + nullToBlank(in_ds.getString(i,"HALL_CLASS"))   +"' \n");
						sbSql.append("AND RECIPE_CD   ='" + nullToBlank(in_ds.getString(i,"RECIPE_CD"))   +"' \n");
						stmt.execute(sbSql.toString());
				    }

 					sbSql.delete(0, sbSql.length());
					//INSERT 수행한다. --업장표준레시피 품목
	        		sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_ITEM(UPJANG, HALL_CLASS, RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, USE_YN, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()+", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, ITEM_CODE, ITEM_SEQ, NEED_QTY, EDIBLE_QTY, CUT_SPEC, USE_YN, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_UPJANG_RECIPE_ITEM ");
	        		sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "TA_UPJANG").toString()     +"  ");
					sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "TA_HALL_CLASS").toString()+"' ");
					sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
					stmt.execute(sbSql.toString());

	        		sbSql.delete(0, sbSql.length());
	       			//INSERT 수행한다. --업장표준레시피 조리법
	        		sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_CUISINE(UPJANG, HALL_CLASS, RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()+", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, CUISINE_SEQ, CUISINE_DESC, PHOTO_PATH, SPHOTO_PATH, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_UPJANG_RECIPE_CUISINE ");
	        		sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "TA_UPJANG").toString()     +"  ");
					sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "TA_HALL_CLASS").toString()+"' ");
					sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
					stmt.execute(sbSql.toString());

	        		sbSql.delete(0, sbSql.length());
	       			//INSERT 수행한다. --업장표준레시피 특이사항
	        		sbSql.append("INSERT INTO FSR_UPJANG_RECIPE_SPECIAL(UPJANG, HALL_CLASS, RECIPE_CD, SPECIAL_SEQ, SPECIAL_DESC, CUSER, CDATE, UUSER, UDATE) ");
	        		sbSql.append("SELECT "+ in_ds.getString(i, "UPJANG").toString()+", '"+ in_ds.getString(i, "HALL_CLASS").toString()+"', RECIPE_CD, SPECIAL_SEQ, SPECIAL_DESC, '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "',SYSDATE ");
	        		sbSql.append("FROM   FSR_UPJANG_RECIPE_SPECIAL ");
	        		sbSql.append("WHERE    UPJANG     ="+ in_ds.getString(i, "TA_UPJANG").toString()     +"  ");
					sbSql.append("AND      HALL_CLASS ='"+ in_ds.getString(i, "TA_HALL_CLASS").toString()+"' ");
					sbSql.append("AND      RECIPE_CD  ='"+ in_ds.getString(i, "RECIPE_CD").toString() +"' ");
					stmt.execute(sbSql.toString());
			    }
			}


		}

	  //트랜잭션 성공
	  conn.commit();

	   this.setResultMessage(0, "OK",out_vl);

	} catch(Exception ex) {
      ex.printStackTrace();
	  //트랜잭션 실패
	  conn.rollback();

       this.setResultMessage(-1, ex.toString(),out_vl);
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
		if(stmt != null) {
			try {
				stmt.close();
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