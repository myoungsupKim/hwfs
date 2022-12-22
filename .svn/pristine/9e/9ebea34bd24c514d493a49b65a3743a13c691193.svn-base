<%
/*
 ******************************************************************************************
 * 시스템구분: IFIS/메뉴관리/기준정보/업장특성설정
 * 프로그램명: FSA00050E.XML
 * 기ㅡㅡㅡ능: 업장특성설정
 * 작ㅡ성ㅡ자: 한화S&C 박종세
 * 작성ㅡ일자: 2007-11-16
 * ----------------------------------------------------------------------------------------
 * HISTORY    :
 ******************************************************************************************
 */
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	
		String g_EmpNo 		        = in_vl.getString("g_EmpNo");
		
		int v_row_counter = 0;
		String v_nut_type = "";
		
		DataSet in_ds  =  in_dl.get("FSA00050E_T001");
		stmt =  conn.createStatement();

						
		int RowCnt = 0;
		int i;
		int RowStatus;
		StringBuffer sbSql = new StringBuffer();
		RowCnt = in_ds.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= in_ds.getRowType(i);

			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				sbSql.delete(0, sbSql.length());	
				
				sbSql.append("INSERT INTO FSA_HALL_DTL											\n");
				sbSql.append("         (													\n");
				sbSql.append("           UPJANG,           \n");
				sbSql.append("           HALL_CD,           \n");
				sbSql.append("           MEAL,           \n");
				sbSql.append("           CORNER,           \n");
				sbSql.append("           CORNER_DESC,           \n");
				sbSql.append("           RATION_METHOD,           \n");
				sbSql.append("           MEAL_UPRICE,           \n");
				sbSql.append("           AVG_MEAL_QTY,           \n");
				sbSql.append("           D_DAY,           \n");
				sbSql.append("           FIRST_START_TIME,           \n");
				sbSql.append("           FIRST_END_TIME,           \n");
				sbSql.append("           SECOND_START_TIME,           \n");
				sbSql.append("           SECOND_END_TIME,           \n");
				sbSql.append("           PEAK_START_TIME,           \n");
				sbSql.append("           PEAK_END_TIME,           \n");
				sbSql.append("           MENU_CYCLE,           \n");
				sbSql.append("           NUT_TYPE,           \n");
				sbSql.append("           NUT_YN,           \n");
				sbSql.append("           USE_YN,           \n");
				sbSql.append("           CUSER,           \n");
				sbSql.append("           CDATE,           \n");
				sbSql.append("           UUSER,           \n");
				sbSql.append("           UDATE,           \n");
				sbSql.append("           SAT_YN,           \n");
				sbSql.append("           SUN_YN,           \n");
				sbSql.append("           NEED_RATE         \n");
				sbSql.append("         )													\n");
				sbSql.append("  VALUES (													\n");
				sbSql.append("" + nullToBlank(in_ds.getString(i,"UPJANG"))   +",  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"HALL_CD"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"MEAL"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"CORNER"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"CORNER_DESC"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"RATION_METHOD"))   +"',  \n");
				sbSql.append("" + nullToZero(in_ds.getString(i,"MEAL_UPRICE"))   +",  \n");
				sbSql.append("" + nullToBlank(in_ds.getString(i,"AVG_MEAL_QTY"))   +",  \n");
				sbSql.append("" + nullToBlank(in_ds.getString(i,"D_DAY"))   +",  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"FIRST_START_TIME"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"FIRST_END_TIME"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"SECOND_START_TIME"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"SECOND_END_TIME"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"PEAK_START_TIME"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"PEAK_END_TIME"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"MENU_CYCLE"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"NUT_TYPE"))   +"',  \n");
				sbSql.append("'" + nullToBlank(in_ds.getString(i,"NUT_YN"))   +"',  \n");
				sbSql.append("decode(" + nullToBlank(in_ds.getString(i,"USE_YN"))   +",1,'Y','N'),  \n");
				sbSql.append("'" + g_EmpNo   +"',  \n");
				sbSql.append(" SYSDATE,  \n");
				sbSql.append("'" + g_EmpNo   +"',  \n");
				sbSql.append(" SYSDATE,  \n");
				sbSql.append("decode(" + nullToBlank(in_ds.getString(i,"SAT_YN"))   +",1,'Y','N'),  \n");
				sbSql.append("decode(" + nullToBlank(in_ds.getString(i,"SUN_YN"))   +",1,'Y','N'),  \n");
				sbSql.append("" + nullToZero(in_ds.getString(i,"NEED_RATE"))   +"  \n");
				sbSql.append("			)										       			");
				
		    }
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("UPDATE	FSA_HALL_DTL	SET		             						\n");
				sbSql.append("CORNER_DESC   ='" + nullToBlank(in_ds.getString(i,"CORNER_DESC"))   +"', \n");
				sbSql.append("RATION_METHOD   ='" + nullToBlank(in_ds.getString(i,"RATION_METHOD"))   +"', \n");
				sbSql.append("MEAL_UPRICE   =" + nullToBlank(in_ds.getString(i,"MEAL_UPRICE"))   +", \n");
				sbSql.append("AVG_MEAL_QTY  =" + nullToBlank(in_ds.getString(i,"AVG_MEAL_QTY"))  +", \n");
				sbSql.append("D_DAY   =" + nullToBlank(in_ds.getString(i,"D_DAY"))   +", \n");
				sbSql.append("FIRST_START_TIME   ='" + nullToBlank(in_ds.getString(i,"FIRST_START_TIME"))   +"', \n");
				sbSql.append("FIRST_END_TIME   ='" + nullToBlank(in_ds.getString(i,"FIRST_END_TIME"))   +"', \n");
				sbSql.append("SECOND_START_TIME   ='" + nullToBlank(in_ds.getString(i,"SECOND_START_TIME"))   +"', \n");
				sbSql.append("SECOND_END_TIME   ='" + nullToBlank(in_ds.getString(i,"SECOND_END_TIME"))   +"', \n");
				sbSql.append("PEAK_START_TIME   ='" + nullToBlank(in_ds.getString(i,"PEAK_START_TIME"))   +"', \n");
				sbSql.append("PEAK_END_TIME   ='" + nullToBlank(in_ds.getString(i,"PEAK_END_TIME"))   +"', \n");
				sbSql.append("MENU_CYCLE   ='" + nullToBlank(in_ds.getString(i,"MENU_CYCLE"))   +"', \n");
				sbSql.append("NUT_TYPE   ='" + nullToBlank(in_ds.getString(i,"NUT_TYPE"))   +"', \n");
				sbSql.append("NUT_YN   ='" + nullToBlank(in_ds.getString(i,"NUT_YN"))   +"', \n");
				sbSql.append("USE_YN   =decode(" + nullToBlank(in_ds.getString(i,"USE_YN"))  +",1,'Y','N'), \n");
				sbSql.append("SAT_YN   =decode(" + nullToBlank(in_ds.getString(i,"SAT_YN"))  +",1,'Y','N'), \n");
				sbSql.append("SUN_YN   =decode(" + nullToBlank(in_ds.getString(i,"SUN_YN"))  +",1,'Y','N'), \n");
				sbSql.append("NEED_RATE   =" + nullToBlank(in_ds.getString(i,"NEED_RATE"))   +", \n");
		    	sbSql.append("UUSER   ='" + g_EmpNo   +"', \n");
				sbSql.append("UDATE   =SYSDATE \n");
				sbSql.append("WHERE   UPJANG			=" +	in_ds.getString(i,"UPJANG")	+"			\n");
				sbSql.append("AND     HALL_CD			='" +	in_ds.getString(i,"HALL_CD")	+"'			\n");
				sbSql.append("AND     MEAL			    ='" +	in_ds.getString(i,"MEAL")	    +"'			\n");
				sbSql.append("AND     CORNER			='" +	in_ds.getString(i,"CORNER")  	+"'			");
			
			}				 
							 
			//실행
			stmt.execute(sbSql.toString());
		
//			Insert 일때... 영양관리기준이 있으면 자동으로 생성한다.			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{   
					sbSql.delete(0, sbSql.length());	
					sbSql.append(" SELECT COUNT(UPJANG) AS ROW_COUNTER, MIN(NUT_TYPE) AS NUT_TYPE FROM FSA_HALL_NUT_STD ");
					sbSql.append(" WHERE  UPJANG = "+ in_ds.getString(i,"UPJANG") +"");
					sbSql.append(" AND    HALL_CD = '"+ in_ds.getString(i,"HALL_CD") +"'");
					if (nullToBlank(in_ds.getString(i,"NUT_MGMT_TYPE")).equals("2"))
					{
					    sbSql.append(" 	 AND  CORNER = '"+ in_ds.getString(i,"CORNER")+"'");
					}	
					sbSql.append(" AND    ROWNUM <=1 ");
					
					rs = stmt.executeQuery(sbSql.toString());
					rs.next();
					
					v_row_counter = rs.getInt("ROW_COUNTER");
					v_nut_type    = rs.getString("NUT_TYPE");
					
					if(v_row_counter>0)
					{
						sbSql.delete(0, sbSql.length());	
						sbSql.append(" INSERT INTO FSA_HALL_NUT_STD(UPJANG, HALL_CD, MEAL, CORNER, NUT_TYPE, NUT_DESC, START_AGE, END_AGE, MAN_RATE, WOMAN_RATE, WEIGHT, HEIGHT, CAL_QTY, PROT_QTY, CARBO_AVG_QTY, CARBO_RCMD_QTY, FAT_AVG_QTY, FAT_RCMD_QTY, VITA_AVG_QTY, VITA_RCMD_QTY, THIA_AVG_QTY, THIA_RCMD_QTY, RIBO_AVG_QTY, RIBO_RCMD_QTY, VITAC_AVG_QTY, VITAC_RCMD_QTY, CA_AVG_QTY, CA_RCMD_QTY, FE_AVG_QTY, FE_RCMD_QTY, NIACIN_AVG_QTY, NIACIN_RCMD_QTY, WATER_QTY, FIBER_QTY, P_QTY, NA_QTY, K_QTY, CU_QTY, CHOLE_QTY, CPF_C, CPF_P, CPF_F, ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10, CUSER, CDATE, UUSER, UDATE) ");
						sbSql.append(" SELECT UPJANG, HALL_CD, '"+ in_ds.getString(i,"MEAL") +"', '"+ in_ds.getString(i,"CORNER") +"', NUT_TYPE, NUT_DESC, START_AGE, END_AGE, MAN_RATE, WOMAN_RATE, WEIGHT, HEIGHT, CAL_QTY, PROT_QTY, CARBO_AVG_QTY, CARBO_RCMD_QTY, FAT_AVG_QTY, FAT_RCMD_QTY, VITA_AVG_QTY, VITA_RCMD_QTY, THIA_AVG_QTY, THIA_RCMD_QTY, RIBO_AVG_QTY, RIBO_RCMD_QTY, VITAC_AVG_QTY, VITAC_RCMD_QTY, CA_AVG_QTY, CA_RCMD_QTY, FE_AVG_QTY, FE_RCMD_QTY, NIACIN_AVG_QTY, NIACIN_RCMD_QTY, WATER_QTY, FIBER_QTY, P_QTY, NA_QTY, K_QTY, CU_QTY, CHOLE_QTY, CPF_C, CPF_P, CPF_F, ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10, CUSER, SYSDATE, UUSER, SYSDATE ");
						sbSql.append(" FROM FSA_HALL_NUT_STD ");
					    sbSql.append(" WHERE  UPJANG = "+ in_ds.getString(i,"UPJANG") +"");
					    sbSql.append(" 	 AND  HALL_CD = '"+ in_ds.getString(i,"HALL_CD")+"'");
						if (nullToBlank(in_ds.getString(i,"NUT_MGMT_TYPE")).equals("2"))
						{
						    sbSql.append(" 	 AND  CORNER = '"+ in_ds.getString(i,"CORNER")+"'");
						}	
					    sbSql.append("   AND  ROWNUM <=1 ");
					    stmt.execute(sbSql.toString());
					    
					    sbSql.delete(0, sbSql.length());	
					    sbSql.append(" UPDATE FSA_HALL_DTL ");
					    sbSql.append(" SET	   NUT_YN = 'Y' ");
					    sbSql.append(" ,	   NUT_TYPE = '"+ v_nut_type +"' ");
					    sbSql.append(" WHERE  UPJANG = "+ in_ds.getString(i,"UPJANG") +"");
					    sbSql.append(" 	 AND  HALL_CD = '"+ in_ds.getString(i,"HALL_CD")+"'");
						if (nullToBlank(in_ds.getString(i,"NUT_MGMT_TYPE")).equals("2"))
						{
						    sbSql.append(" 	 AND  CORNER = '"+ in_ds.getString(i,"CORNER")+"'");
						}	
					    stmt.execute(sbSql.toString());						
					}
				
				}
				else 
				{
					//System.out.println("else");	
				}
			}

		//트랜잭션 성공
		conn.commit();
		this.setResultMessage(0, "OK",out_vl);
	
	} catch(Exception ex) {
		//트랜잭션 실패
		conn.rollback();
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