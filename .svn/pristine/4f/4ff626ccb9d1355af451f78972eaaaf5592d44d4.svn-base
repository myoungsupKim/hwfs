<%
/*
 ******************************************************************************************
 * 시스템구분   : IFIS/메뉴관리/기준정보/영양섭취기준관리
 * 프로그램명   : FSA00080E.XML
 * 기      능  : 업장별 영양섭취기준관리
 * 작  성  자  : 박종세
 * 작성  일자  : 2007-11-16
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
		
		String g_EmpNo = in_vl.getString("g_EmpNo");
		DataSet in_ds  =  in_dl.get("FSA00080E_T001");
		stmt =  conn.createStatement();

						
		int RowCnt = in_ds.getRowCount();
		int i=0;
		int RowStatus;
		StringBuffer sbSql = new StringBuffer();

		RowCnt = in_ds.getRemovedRowCount();

		for ( i = 0 ; i < RowCnt ; i++ )
		{
				sbSql.delete(0, sbSql.length()); 
				sbSql.append("DELETE FROM FSA_HALL_NUT_STD														");
				sbSql.append("WHERE    UPJANG ="+ in_ds.getRemovedData(i, "UPJANG").toString()	    +"			");
				sbSql.append("AND      HALL_CD   ='"+ in_ds.getRemovedData(i, "HALL_CD").toString()+"'			");
			
				//영양관리 기준이 식당+코너일 경우
				if (in_ds.getRemovedData(i,"NUT_MGMT_TYPE").toString().equals("2"))
				{
					sbSql.append("AND      CORNER  ='"+ in_ds.getRemovedData(i, "CORNER").toString()	+"'			");
				}
				
				
				stmt.execute(sbSql.toString());
				
				sbSql.delete(0, sbSql.length());	
			    sbSql.append(" UPDATE FSA_HALL_DTL ");
			    sbSql.append(" SET	  NUT_YN = 'N' ");
			    sbSql.append(" WHERE  UPJANG = "+ in_ds.getRemovedData(i,"UPJANG") +"");
			    sbSql.append(" 	 AND  HALL_CD = '"+ in_ds.getRemovedData(i,"HALL_CD")+"'");
	
			    //영양관리 기준이 식당+코너일 경우
				if (in_ds.getRemovedData(i,"NUT_MGMT_TYPE").toString().equals("2"))
				{
				    sbSql.append(" 	 AND  CORNER = '"+ in_ds.getRemovedData(i,"CORNER")+"'");
				}
				stmt.execute(sbSql.toString());						
		}

		RowCnt = in_ds.getRowCount();
		RowStatus = 0;
		
		if(RowCnt>0)
		{ RowStatus 	= in_ds.getRowType(0); }
				
		if( RowCnt>0 &&( RowStatus == DataSet.ROW_TYPE_INSERTED|| RowStatus == DataSet.ROW_TYPE_UPDATED))
		{   i=0;
	
		    sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSA_HALL_NUT_STD														");
			sbSql.append("WHERE    UPJANG ="+ nullToBlank(in_ds.getString(i, "UPJANG"))	    +"			");
			sbSql.append("AND      HALL_CD   ='"+ nullToBlank(in_ds.getString(i, "HALL_CD"))+"'			");
					
			//영양관리 기준이 식당+코너일 경우
			if (nullToBlank(in_ds.getString(i,"NUT_MGMT_TYPE")).equals("2"))
			{
				sbSql.append("AND      CORNER  ='"+ in_ds.getString(i, "CORNER").toString()	+"'			");
			}
	
			//System.out.println("1 \n");
			//System.out.println(sbSql.toString());
			
			stmt.execute(sbSql.toString());

			sbSql.delete(0, sbSql.length());				
			sbSql.append("INSERT INTO FSA_HALL_NUT_STD									\n");
			sbSql.append("         (													\n");
			sbSql.append("           UPJANG,           \n");
			sbSql.append("           HALL_CD,           \n");
			sbSql.append("           MEAL,           \n");
			sbSql.append("           CORNER,           \n");
			sbSql.append("           NUT_TYPE,           \n");
			sbSql.append("           NUT_DESC,           \n");
			sbSql.append("           START_AGE,           \n");
			sbSql.append("           END_AGE,           \n");
			sbSql.append("           MAN_RATE,           \n");
			sbSql.append("           WOMAN_RATE,           \n");
			sbSql.append("           WEIGHT,           \n");
			sbSql.append("           HEIGHT,           \n");
			sbSql.append("           CAL_QTY,           \n");
			sbSql.append("           PROT_QTY,           \n");
			sbSql.append("           CARBO_AVG_QTY,           \n");
			sbSql.append("           CARBO_RCMD_QTY,           \n");
			sbSql.append("           FAT_AVG_QTY,           \n");
			sbSql.append("           FAT_RCMD_QTY,           \n");
			sbSql.append("           VITA_AVG_QTY,           \n");
			sbSql.append("           VITA_RCMD_QTY,           \n");
			sbSql.append("           THIA_AVG_QTY,           \n");
			sbSql.append("           THIA_RCMD_QTY,           \n");
			sbSql.append("           RIBO_AVG_QTY,           \n");
			sbSql.append("           RIBO_RCMD_QTY,           \n");
			sbSql.append("           VITAC_AVG_QTY,           \n");
			sbSql.append("           VITAC_RCMD_QTY,           \n");
			sbSql.append("           CA_AVG_QTY,           \n");
			sbSql.append("           CA_RCMD_QTY,           \n");
			sbSql.append("           FE_AVG_QTY,           \n");
			sbSql.append("           FE_RCMD_QTY,           \n");
			sbSql.append("           NIACIN_AVG_QTY,           \n");
			sbSql.append("           NIACIN_RCMD_QTY,           \n");
			sbSql.append("           WATER_QTY,           \n");
			sbSql.append("           FIBER_QTY,           \n");
			sbSql.append("           P_QTY,           \n");
			sbSql.append("           NA_QTY,           \n");
			sbSql.append("           K_QTY,           \n");
			sbSql.append("           CU_QTY,           \n");
			sbSql.append("           CHOLE_QTY,           \n");
			sbSql.append("           CPF_C,           \n");
			sbSql.append("           CPF_P,           \n");
			sbSql.append("           CPF_F,           \n");
			sbSql.append("           CUSER,           \n");
			sbSql.append("           CDATE,           \n");
			sbSql.append("           UUSER,           \n");
			sbSql.append("           UDATE            \n");
			sbSql.append("         )													\n");
			sbSql.append("SELECT UPJANG, HALL_CD, MEAL, CORNER, NUT_TYPE, NUT_DESC, START_AGE, END_AGE, MAN_RATE, WOMAN_RATE, WEIGHT, HEIGHT, CAL_QTY, PROT_QTY, CARBO_AVG_QTY, CARBO_RCMD_QTY, FAT_AVG_QTY, FAT_RCMD_QTY, VITA_AVG_QTY, VITA_RCMD_QTY, THIA_AVG_QTY, THIA_RCMD_QTY, RIBO_AVG_QTY, RIBO_RCMD_QTY, VITAC_AVG_QTY, VITAC_RCMD_QTY, CA_AVG_QTY, CA_RCMD_QTY, FE_AVG_QTY, FE_RCMD_QTY, NIACIN_AVG_QTY, NIACIN_RCMD_QTY, WATER_QTY, FIBER_QTY, P_QTY, NA_QTY, K_QTY, CU_QTY, CHOLE_QTY, CPF_C, CPF_P, CPF_F, CUSER, CDATE, UUSER, UDATE  \n");
			sbSql.append("FROM   (  \n");
			sbSql.append("        SELECT A.UPJANG, A.HALL_CD, A.MEAL, A.CORNER, \n" );
			sbSql.append("'" + nullToBlank(in_ds.getString(i,"NUT_TYPE"))   +"' AS NUT_TYPE,  \n");
			sbSql.append("'" + nullToBlank(in_ds.getString(i,"NUT_DESC"))   +"' AS NUT_DESC,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"START_AGE"))   +"  AS START_AGE,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"END_AGE"))   +"  AS END_AGE,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"MAN_RATE"))   +"  AS MAN_RATE,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"WOMAN_RATE"))   +"  AS WOMAN_RATE,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"WEIGHT"))   +"  AS WEIGHT,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"HEIGHT"))   +"  AS HEIGHT,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CAL_QTY"))   +"  AS CAL_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"PROT_QTY"))   +"  AS PROT_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CARBO_AVG_QTY"))   +"  AS CARBO_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CARBO_RCMD_QTY"))   +"  AS CARBO_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"FAT_AVG_QTY"))   +"  AS FAT_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"FAT_RCMD_QTY"))   +"  AS FAT_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"VITA_AVG_QTY"))   +"  AS VITA_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"VITA_RCMD_QTY"))   +"  AS VITA_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"THIA_AVG_QTY"))   +"  AS THIA_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"THIA_RCMD_QTY"))   +"  AS THIA_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"RIBO_AVG_QTY"))   +"  AS RIBO_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"RIBO_RCMD_QTY"))   +"  AS RIBO_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"VITAC_AVG_QTY"))   +"  AS VITAC_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"VITAC_RCMD_QTY"))   +"  AS VITAC_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CA_AVG_QTY"))   +"  AS CA_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CA_RCMD_QTY"))   +"  AS CA_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"FE_AVG_QTY"))   +"  AS FE_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"FE_RCMD_QTY"))   +"  AS FE_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"NIACIN_AVG_QTY"))   +"  AS NIACIN_AVG_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"NIACIN_RCMD_QTY"))   +"  AS NIACIN_RCMD_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"WATER_QTY"))   +"  AS WATER_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"FIBER_QTY"))   +"  AS FIBER_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"P_QTY"))   +"  AS P_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"NA_QTY"))   +"  AS NA_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"K_QTY"))   +"  AS K_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CU_QTY"))   +"  AS CU_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CHOLE_QTY"))   +"  AS CHOLE_QTY,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CPF_C"))   +"  AS CPF_C,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CPF_P"))   +"  AS CPF_P,  \n");
			sbSql.append("" + nullToBlank(in_ds.getString(i,"CPF_F"))   +"  AS CPF_F,  \n");
			sbSql.append(" '"+ g_EmpNo +"' AS CUSER, SYSDATE AS CDATE, '"+ g_EmpNo +"' AS UUSER, SYSDATE AS UDATE  \n");
			sbSql.append("          FROM FSA_HALL_DTL A, \n");
			sbSql.append("           FSA_HALL_NUT_STD B \n");
			sbSql.append("        WHERE  A.UPJANG = B.UPJANG(+) \n");
			sbSql.append("        AND    A.HALL_CD = B.HALL_CD(+) \n");
			sbSql.append("        AND    A.MEAL = B.MEAL(+) \n");
			sbSql.append("        AND    A.CORNER = B.CORNER(+) \n");
			sbSql.append("      ) \n");
	   	    sbSql.append("WHERE UPJANG   =" + nullToBlank(in_ds.getString(i,"UPJANG"))   +" \n");
			sbSql.append("AND   HALL_CD   ='" + nullToBlank(in_ds.getString(i,"HALL_CD"))   +"' \n");
		    //영양관리 기준이 식당+코너일 경우
			if(nullToBlank(in_ds.getString(i,"NUT_MGMT_TYPE")).equals("2"))
		    {	 
			  sbSql.append("AND   CORNER   ='" + nullToBlank(in_ds.getString(i,"CORNER"))   +"' \n");
		    }
		    
			//System.out.println("2 \n");
			//System.out.println(sbSql.toString());
			
		    stmt.execute(sbSql.toString());			
	   
		    //업장 디테일 업데이트한다.
		    sbSql.delete(0, sbSql.length());	
		    sbSql.append(" UPDATE FSA_HALL_DTL ");
		    sbSql.append(" SET	   NUT_YN = 'Y' ");
		    sbSql.append(" ,	   NUT_TYPE = '"+ nullToBlank(in_ds.getString(i,"NUT_TYPE")) +"' ");
		    sbSql.append(" ,	   UUSER = '"+ g_EmpNo +"' ");
		    sbSql.append(" ,	   UDATE = SYSDATE ");
		    sbSql.append(" WHERE   UPJANG = "+ in_ds.getString(i,"UPJANG") +" ");
		    sbSql.append(" 	 AND   HALL_CD = '"+ in_ds.getString(i,"HALL_CD")+"' ");
		  //영양관리 기준이 식당+코너일 경우
			if(nullToBlank(in_ds.getString(i,"NUT_MGMT_TYPE")).equals("2"))
		    {	 
			sbSql.append("AND   CORNER   ='" + nullToBlank(in_ds.getString(i,"CORNER"))   +"' \n");
		    }

 		    stmt.execute(sbSql.toString());		
		}
		
	   //트랜잭션 성공
	   conn.commit();	   
	   this.setResultMessage(0, "OK",out_vl);
		
	} 
	catch(Exception ex) 
	{
		//트랜잭션 실패
		conn.rollback();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
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