
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_Master  	= in_dl.get("ds_Master");
		DataSet ds_Detail  	= in_dl.get("ds_Detail");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int i;
		int RowStatus;
	
	
		// 1.Master
		RowCnt = ds_Master.getRowCount();
		
		if (RowCnt > 0)
		{
			RowStatus 	= ds_Master.getRowType(0);
			
			String strFromTime 	= nullToBlank(ds_Master.getString(0,"CHECK_START_TIME"));
			String strToTime 	= nullToBlank(ds_Master.getString(0,"CHECK_END_TIME"));
			
			//System.out.println("strFromTime : " + strFromTime);
			//System.out.println("strToTime : " + strToTime);
			
			if (strFromTime.length() > 4)
			{
				strFromTime = strFromTime.substring(0, 4);
			}
			else
			{
				strFromTime = "";
			}
			
			if (strToTime.length() > 4)
			{
				strToTime = strToTime.substring(0, 4);
			}
			else
			{
				strToTime = "";
			}
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				// 1. insert
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_RESULT_MST( \n");
				sbSql.append("	  TABLE_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, UPJANG \n");
				sbSql.append("	, CHECK_DATE \n");
				sbSql.append("	, CHECK_TYPE \n");
				sbSql.append("	, LEAD_CHECK_TYPE \n");
				sbSql.append("	, CHECK_SABUN \n");
				sbSql.append("	, CHECK_START_TIME \n");
				sbSql.append("	, CHECK_END_TIME \n");
				sbSql.append("	, RPT_DATE \n");
				sbSql.append("	, THEME_MGMT \n");
				sbSql.append("	, REMARK \n");
				sbSql.append("	, TM_CD \n");
				sbSql.append("	, TEAM_MST_SABUN \n");
				sbSql.append("	, SUBTEAM_MST_SABUN \n");
				sbSql.append("	, LEADER_SABUN \n");
				sbSql.append("	, CHARGE_SABUN \n");
				sbSql.append("	, KUNSOK \n");
				sbSql.append("	, WATER_IRRIGATION \n");
				sbSql.append("	, OPEN_DATE \n");
				sbSql.append("	, PERMISSION_TYPE \n");
				sbSql.append("	, PERSON_CNT \n");
				sbSql.append("	, DIST_TYPE \n");
				sbSql.append("	, AVG_MEAL_QTY \n");
				sbSql.append("	, MEAL_CNT \n");
				sbSql.append("	, MENU_CNT \n");
				sbSql.append("	, SPECIAL_FACT \n");
				sbSql.append("	, SCORE \n");
				sbSql.append("	, NOT_FIT_TOT_CNT \n");
				sbSql.append("	, INDICATE_CNT \n");
				sbSql.append("	, CONFIRM_YN \n");
				sbSql.append("	, NOT_FIT_YN \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append("	, UUSER \n");
				sbSql.append("	, UDATE \n");
				
				// 책임자1,2,3  추가 20140902 식품연구소 이재우요청, by 김장욱
				sbSql.append("	, RESP_SABUN1 \n");
				sbSql.append("	, RESP_SABUN2 \n");
				sbSql.append("	, RESP_SABUN3 \n");
				sbSql.append("	, ATTR01 \n");
				sbSql.append("	, ATTR05 \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"	+	nullToBlank(ds_Master.getString(0,"TABLE_TYPE"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"FORM_CD"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"UPJANG"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHECK_DATE"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHECK_TYPE"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"LEAD_CHECK_TYPE"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHECK_SABUN"))		+"' \n");
				sbSql.append("	, '"	+	strFromTime														+"' \n");
				sbSql.append("	, '"	+	strToTime														+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"RPT_DATE"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"THEME_MGMT"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"REMARK"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TM_CD"))				+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"TEAM_MST_SABUN"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"SUBTEAM_MST_SABUN"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"LEADER_SABUN"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CHARGE_SABUN"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"KUNSOK"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"WATER_IRRIGATION"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"OPEN_DATE"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"PERMISSION_TYPE"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"PERSON_CNT"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"DIST_TYPE"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"AVG_MEAL_QTY"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"MEAL_CNT"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"MENU_CNT"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"SPECIAL_FACT"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"SCORE"))				+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"NOT_FIT_TOT_CNT"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"INDICATE_CNT"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"CONFIRM_YN"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"NOT_FIT_YN"))		+"' \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 														+"' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 														+"' \n");
				sbSql.append("	, SYSDATE \n");
				
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"RESP_SABUN1"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"RESP_SABUN2"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"RESP_SABUN3"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"ATTR01"))		    +"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"ATTR05"))		    +"' \n");
				sbSql.append(" ) \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				// 2. update
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_RESULT_MST \n");
				sbSql.append("   SET CHECK_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"CHECK_TYPE"))		+"' \n");
				sbSql.append("	 , LEAD_CHECK_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"LEAD_CHECK_TYPE"))	+"' \n");
				sbSql.append("	 , CHECK_SABUN = '"			+	nullToBlank(ds_Master.getString(0,"CHECK_SABUN"))		+"' \n");
				sbSql.append("	 , CHECK_START_TIME = '"	+	strFromTime														+"' \n");
				sbSql.append("	 , CHECK_END_TIME = '"		+	strToTime														+"' \n");
				sbSql.append("	 , RPT_DATE = '"			+	nullToBlank(ds_Master.getString(0,"RPT_DATE"))			+"' \n");
				sbSql.append("	 , THEME_MGMT = '"			+	nullToBlank(ds_Master.getString(0,"THEME_MGMT"))		+"' \n");
				sbSql.append("	 , REMARK = '"				+	nullToBlank(ds_Master.getString(0,"REMARK"))			+"' \n");
				sbSql.append("	 , TM_CD = '"				+	nullToBlank(ds_Master.getString(0,"TM_CD"))				+"' \n");
				sbSql.append("	 , TEAM_MST_SABUN = '"		+	nullToBlank(ds_Master.getString(0,"TEAM_MST_SABUN"))	+"' \n");
				sbSql.append("	 , SUBTEAM_MST_SABUN = '"	+	nullToBlank(ds_Master.getString(0,"SUBTEAM_MST_SABUN"))	+"' \n");
				sbSql.append("	 , LEADER_SABUN = '"		+	nullToBlank(ds_Master.getString(0,"LEADER_SABUN"))		+"' \n");
				sbSql.append("	 , CHARGE_SABUN = '"		+	nullToBlank(ds_Master.getString(0,"CHARGE_SABUN"))		+"' \n");
				sbSql.append("	 , KUNSOK = '"				+	nullToBlank(ds_Master.getString(0,"KUNSOK"))			+"' \n");
				sbSql.append("	 , WATER_IRRIGATION = '"	+	nullToBlank(ds_Master.getString(0,"WATER_IRRIGATION"))	+"' \n");
				sbSql.append("	 , OPEN_DATE = '"			+	nullToBlank(ds_Master.getString(0,"OPEN_DATE"))			+"' \n");
				sbSql.append("	 , PERMISSION_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"PERMISSION_TYPE"))	+"' \n");
				sbSql.append("	 , PERSON_CNT = '"			+	nullToBlank(ds_Master.getString(0,"PERSON_CNT"))		+"' \n");
				sbSql.append("	 , DIST_TYPE = '"			+	nullToBlank(ds_Master.getString(0,"DIST_TYPE"))			+"' \n");
				sbSql.append("	 , AVG_MEAL_QTY = '"		+	nullToBlank(ds_Master.getString(0,"AVG_MEAL_QTY"))		+"' \n");
				sbSql.append("	 , MEAL_CNT = '"			+	nullToBlank(ds_Master.getString(0,"MEAL_CNT"))			+"' \n");
				sbSql.append("	 , MENU_CNT = '"			+	nullToBlank(ds_Master.getString(0,"MENU_CNT"))			+"' \n");
				sbSql.append("	 , SPECIAL_FACT = '"		+	nullToBlank(ds_Master.getString(0,"SPECIAL_FACT"))		+"' \n");
				sbSql.append("	 , SCORE = '"				+	nullToBlank(ds_Master.getString(0,"SCORE"))				+"' \n");
				sbSql.append("	 , NOT_FIT_TOT_CNT = '"		+	nullToBlank(ds_Master.getString(0,"NOT_FIT_TOT_CNT"))	+"' \n");
				sbSql.append("	 , INDICATE_CNT = '"		+	nullToBlank(ds_Master.getString(0,"INDICATE_CNT"))		+"' \n");
				sbSql.append("	 , CONFIRM_YN = '"			+	nullToBlank(ds_Master.getString(0,"CONFIRM_YN"))		+"' \n");
				sbSql.append("	 , NOT_FIT_YN = '"			+	nullToBlank(ds_Master.getString(0,"NOT_FIT_YN"))		+"' \n");
				sbSql.append("	 , UUSER = '" 				+ 	g_EmpNo 														+"' \n");
				sbSql.append("	 , UDATE = SYSDATE \n");
				
				sbSql.append("	 , RESP_SABUN1 = '"			+	nullToBlank(ds_Master.getString(0,"RESP_SABUN1"))		+"' \n");
				sbSql.append("	 , RESP_SABUN2 = '"			+	nullToBlank(ds_Master.getString(0,"RESP_SABUN2"))		+"' \n");
				sbSql.append("	 , RESP_SABUN3 = '"			+	nullToBlank(ds_Master.getString(0,"RESP_SABUN3"))		+"' \n");
				sbSql.append("	 , ATTR01 = '"			    +	nullToBlank(ds_Master.getString(0,"ATTR01"))		    +"' \n");
				sbSql.append("	 , ATTR05 = '"			    +	nullToBlank(ds_Master.getString(0,"ATTR05"))		    +"' \n");
				
				sbSql.append(" WHERE TABLE_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"TABLE_TYPE"))		+"' \n");
				sbSql.append("   AND FORM_CD = '"			+	nullToBlank(ds_Master.getString(0,"FORM_CD"))			+"' \n");
				sbSql.append("   AND UPJANG = '"			+	nullToBlank(ds_Master.getString(0,"UPJANG"))			+"' \n");
				sbSql.append("   AND CHECK_DATE = '"		+	nullToBlank(ds_Master.getString(0,"CHECK_DATE"))		+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			
		}

		// 2.Detail
		RowCnt = ds_Detail.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= ds_Detail.getRowType(i);
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_RESULT_DTL( \n");
				sbSql.append("	  TABLE_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, UPJANG \n");
				sbSql.append("	, CHECK_DATE \n");
				sbSql.append("	, CLASS_CD \n");
				sbSql.append("	, MARK \n");
				sbSql.append("	, SCORE \n");
				sbSql.append("	, INDICATE_CNT \n");
				sbSql.append("	, NOT_FIT_CNT \n");
				sbSql.append("	, EVAL_CONTENTS \n");
				sbSql.append("	, MAX_YN \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append("	, UUSER \n");
				sbSql.append("	, UDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"	+	nullToBlank(ds_Detail.getString(i,"TABLE_TYPE"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"FORM_CD"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"UPJANG"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"CHECK_DATE"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"CLASS_CD"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"MARK"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"CHK_POINT"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"INDICATE_CNT"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"NOT_FIT_CNT"))	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"EVAL_CONTENTS")).replaceAll("'","''")	+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail.getString(i,"MAX_YN"))		+"' \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 													+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 													+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_RESULT_DTL \n");
				sbSql.append("   SET MARK = '"			+	nullToBlank(ds_Detail.getString(i,"MARK"))			+"' \n");
				sbSql.append("     , SCORE = '"			+	nullToBlank(ds_Detail.getString(i,"CHK_POINT"))			+"' \n");
				sbSql.append("     , INDICATE_CNT = '"	+	nullToBlank(ds_Detail.getString(i,"INDICATE_CNT"))	+"' \n");
				sbSql.append("     , NOT_FIT_CNT = '"		+	nullToBlank(ds_Detail.getString(i,"NOT_FIT_CNT"))	+"' \n");
				sbSql.append("     , EVAL_CONTENTS = '"	+	nullToBlank(ds_Detail.getString(i,"EVAL_CONTENTS")).replaceAll("'","''")	+"' \n");
				sbSql.append("     , MAX_YN = '"			+	nullToBlank(ds_Detail.getString(i,"MAX_YN"))		+"' \n");
				sbSql.append("     , UUSER = '" 			+ 	g_EmpNo 													+ "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE TABLE_TYPE = '"	+	nullToBlank(ds_Detail.getString(i,"TABLE_TYPE"))	+"' \n");
				sbSql.append("   AND FORM_CD = '"		+	nullToBlank(ds_Detail.getString(i,"FORM_CD"))		+"' \n");
				sbSql.append("   AND UPJANG = '"		+	nullToBlank(ds_Detail.getString(i,"UPJANG"))		+"' \n");
				sbSql.append("   AND CHECK_DATE = '"	+	nullToBlank(ds_Detail.getString(i,"CHECK_DATE"))	+"' \n");
				sbSql.append("   AND CLASS_CD = '"		+	nullToBlank(ds_Detail.getString(i,"CLASS_CD"))		+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}

	    //20210419078 - 1
		////2008.12.19 박은규, 이명희 : 중분류에 중점관리여부 및 건수를 추가하여 해당 중분류에 속하는 소분류에서 최대점이 아닌 항목이 설정건수를 초과하면 부적합처리.
		//RowCnt = ds_Master.getRowCount();
		//if (RowCnt > 0)
		//{
		//	//일단 부적합이 아닌 것을 대상으로 확인.
		//	//if (nullToBlank(ds_Master.getString(0,"NOT_FIT_YN")).equals("0.0"))
		//	//if( Double.parseDouble(nullToZero(ds_Master.getString(i, "NOT_FIT_YN"))) == 0 )
		//	//{
		//		sbSql.delete(0, sbSql.length());
		//		sbSql.append("SELECT Y.CLASS_CD, Y.MNGM_CNT, COUNT(X.CLASS_CD) \n");
		//		sbSql.append("  FROM FSC_RESULT_DTL X, FSC_CLASS_MST Y \n");
		//		sbSql.append(" WHERE Y.TABLE_TYPE = X.TABLE_TYPE \n");
		//		sbSql.append("   AND Y.FORM_CD = X.FORM_CD \n");
		//		sbSql.append("   AND Y.CLASS_CD = SUBSTR(X.CLASS_CD,1,5)||'000' \n");
		//		sbSql.append("   AND Y.MNGM_FLAG = 'Y' --중점관리하는 중분류 \n");
		//		sbSql.append("   AND Y.MNGM_CNT > 0 --중점관리수량설정이 있는 것 \n");
		//		sbSql.append("   AND X.MAX_YN != 'Y' --만점이 아닌 항목 \n");
		//		sbSql.append("   AND X.TABLE_TYPE = '" + nullToBlank(ds_Master.getString(0,"TABLE_TYPE")) + "' \n");
		//		sbSql.append("   AND X.FORM_CD = '" + nullToBlank(ds_Master.getString(0,"FORM_CD")) + "' \n");
		//		sbSql.append("   AND X.UPJANG = '" + nullToBlank(ds_Master.getString(0,"UPJANG")) + "' \n");
		//		sbSql.append("   AND X.CHECK_DATE = '" + nullToBlank(ds_Master.getString(0,"CHECK_DATE")) + "' \n");
		//		sbSql.append(" GROUP BY Y.CLASS_CD, Y.MNGM_CNT \n");
		//		sbSql.append("HAVING Y.MNGM_CNT <= COUNT(X.CLASS_CD)--만점아닌 갯수가 중점관리갯수 이상이면 부적합 \n");
		//		pstmt = conn.prepareStatement(sbSql.toString());
		//		rs = pstmt.executeQuery();
		//		
		//		int procCnt = 0;
		//		if(rs.next())
		//		{
		//			//해당 사항이 있으면 전체 부적합처리.
		//			sbSql.delete(0, sbSql.length());
		//			sbSql.append("UPDATE FSC_RESULT_MST A \n");
		//			sbSql.append("   SET A.NOT_FIT_YN = 1 \n");
		//			sbSql.append("     , A.ATTR01 = A.ATTR01 || ' 법규항목 불합격건수 초과' \n");
		//			sbSql.append(" WHERE A.TABLE_TYPE = '" + nullToBlank(ds_Master.getString(0,"TABLE_TYPE")) + "' \n");
		//			sbSql.append("   AND A.FORM_CD = '" + nullToBlank(ds_Master.getString(0,"FORM_CD")) + "' \n");
		//			sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Master.getString(0,"UPJANG")) + "' \n");
		//			sbSql.append("   AND A.CHECK_DATE = '" + nullToBlank(ds_Master.getString(0,"CHECK_DATE")) + "' \n");
		//			//일단 기존기준에서 적합인 것만 체크
		//			//sbSql.append("   AND A.NOT_FIT_YN = 0 \n");
		//
		//			stmt = conn.createStatement();
		//			stmt.execute(sbSql.toString());
		//			stmt.close();
		//			
		//			procCnt++;
		//		}
		//		
		//		if(procCnt == 0) {
		//			sbSql.delete(0, sbSql.length());
		//			sbSql.append("UPDATE FSC_RESULT_MST A \n");
		//			sbSql.append("   SET A.ATTR01 = REPLACE(A.ATTR01, ' 중점관리항목 불합격건수 초과', '') \n");
		//			sbSql.append(" WHERE A.TABLE_TYPE = '" + nullToBlank(ds_Master.getString(0,"TABLE_TYPE")) + "' \n");
		//			sbSql.append("   AND A.FORM_CD = '" + nullToBlank(ds_Master.getString(0,"FORM_CD")) + "' \n");
		//			sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Master.getString(0,"UPJANG")) + "' \n");
		//			sbSql.append("   AND A.CHECK_DATE = '" + nullToBlank(ds_Master.getString(0,"CHECK_DATE")) + "' \n");
		//			stmt = conn.createStatement();
		//			stmt.execute(sbSql.toString());
		//			stmt.close();
		//		}
		//		
		//	//}
		//}

		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
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
			
			//jsp log 서비스 닫기 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	