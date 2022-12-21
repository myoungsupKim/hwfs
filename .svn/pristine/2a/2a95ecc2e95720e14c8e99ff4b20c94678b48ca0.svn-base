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
		DataSet ds_in          = in_dl.get("ds_in");		    // 조회조건
		String BASE_DD         = nullToBlank(ds_in.getString(0, "BASE_DD"));
		
		System.out.println("BASE_DD : " + BASE_DD);
		//System.out.println("HALL_CD : " + HALL_CD);
		//System.out.println("START_DATE : " + START_DATE);
		//System.out.println("END_DATE : " + END_DATE);
		//System.out.println("ds_bodyList.getRowCount() : " + ds_bodyList.getRowCount());

		cstmt = conn.prepareCall( "{call FSI_STD_PRICE_CREATE_PRO(?, ?, ?, ?, ?)}" );
		
		int idx = 1;
		cstmt.setString(idx++, BASE_DD);			
		cstmt.setString(idx++, g_EmpNo);
		cstmt.registerOutParameter(idx++, Types.INTEGER);
		cstmt.registerOutParameter(idx++, Types.VARCHAR);
		cstmt.registerOutParameter(idx++, Types.VARCHAR);
		cstmt.execute();
		
		if(cstmt.getString(4).equals("FALSE")) {
			conn.rollback();
			this.setResultMessage(-1, cstmt.getString(5), out_vl);  
		} else {
			conn.commit();		
			this.setResultMessage(0, "OK", out_vl);
		}
		
		cstmt.close();
	
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