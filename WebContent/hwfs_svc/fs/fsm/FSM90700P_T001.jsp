<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	CallableStatement cstmt = null;

	try {
		//////////////////////////////////////////////////////////
		//프로그램  명: FSM90700P_T001.jsp
		//작   성   일: 2015.07.06
		//작   성   자: 김민수 
		//프로그램기능: 식단등록(병원식) - 식단자동생성
		///////////////////////////////////////////////////////////
		PlatformRequest platformRequest = this.proc_input(request);  
		in_dl = platformRequest.getData().getDataSetList();
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo         = in_vl.getString("g_EmpNo");
		DataSet ds_cond        = in_dl.get("ds_cond");		    // 조회조건
		DataSet ds_bodyList    = in_dl.get("ds_bodyList");	    // 식단정보
		String UPJANG          = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String HALL_CD         = nullToBlank(ds_cond.getString(0, "HALL_CD"));
		String SUBINV_CODE     = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		String START_DATE      = nullToBlank(ds_cond.getString(0, "START_DATE"));
		String END_DATE        = nullToBlank(ds_cond.getString(0, "END_DATE"));
		
		String MENU_DATE       = "";
		String MEAL            = "";
		String CORNER          = "";
		String MAJOR_DISH_INFO = "";
		String RECIPE_CD       = "";
		
		//System.out.println("UPJANG : " + UPJANG);
		//System.out.println("HALL_CD : " + HALL_CD);
		//System.out.println("START_DATE : " + START_DATE);
		//System.out.println("END_DATE : " + END_DATE);
		//System.out.println("ds_bodyList.getRowCount() : " + ds_bodyList.getRowCount());

		String MENU_CD = "";
		HashMap menuMap = new HashMap();
		for(int i=0; i<ds_bodyList.getRowCount(); i++)
		{
			MENU_DATE       = START_DATE;
			MEAL            = nullToBlank(ds_bodyList.getString(i, "MEAL"));
			CORNER          = nullToBlank(ds_bodyList.getString(i, "CORNER"));
			RECIPE_CD       = "";
			MAJOR_DISH_INFO = nullToBlank(ds_bodyList.getString(i, "MAJOR_DISH_INFO"));
			MENU_CD         = MENU_DATE + "-" + HALL_CD + MEAL + CORNER;
			
			if(menuMap.get(MENU_CD) != null) {
				continue;
			}
		
			// 레시피목록 생성 (레시피코드/구성/레시피구분,레시피코드/구성/레시피구분...)
			String GUBUN = "";
			for(int j=0; j<ds_bodyList.getRowCount(); j++) {
				if(MENU_CD.equals(MENU_DATE + "-" + HALL_CD + nullToBlank(ds_bodyList.getString(j, "MEAL")) + nullToBlank(ds_bodyList.getString(j, "CORNER")))) {
					if(nullToBlank(ds_bodyList.getString(j, "GUBUN")).equals("업장")) {
						GUBUN = "U";
					} else {
						GUBUN = "S";
					}
					RECIPE_CD = RECIPE_CD + nullToBlank(ds_bodyList.getString(j, "RECIPE_CD")) + "/" + nullToBlank(ds_bodyList.getString(j, "MAJOR_DISH_INFO")) + "/" + GUBUN + ",";
				}
			}
			
			cstmt = conn.prepareCall( "{call FSM_MENU_CREATE_PRO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}" );
			int idx = 1;
			cstmt.setString(idx++, UPJANG);			
			cstmt.setString(idx++, HALL_CD);
			cstmt.setString(idx++, SUBINV_CODE);
		    cstmt.setString(idx++, START_DATE);
		    cstmt.setString(idx++, END_DATE);
		    cstmt.setString(idx++, MEAL);
		    cstmt.setString(idx++, CORNER);
		    cstmt.setString(idx++, RECIPE_CD.substring(0, RECIPE_CD.length() - 1));
		    cstmt.setString(idx++, g_EmpNo);
			cstmt.registerOutParameter(idx++, Types.VARCHAR);
			cstmt.registerOutParameter(idx++, Types.VARCHAR);
			cstmt.execute();
			
			if(cstmt.getString(10).equals("E")) {
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(11), out_vl);  
			} else {
				conn.commit();		
				this.setResultMessage(0, "OK", out_vl);
			}
			
			cstmt.close();
		}
	
	} catch(Exception ex) {		
		//트랜잭션 실패
		conn.rollback();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		//메세지반환
		this.setResultMessage(-1, ex.toString(),out_vl);  
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}
		if(cstmt != null) {
			try {
				cstmt.close();
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