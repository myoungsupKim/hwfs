<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		// [식단복사]
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		String MEAL 		= in_vl.getString("MEAL");
		String CORNER		= in_vl.getString("CORNER");
		String MENU_DATE	= in_vl.getString("MENU_DATE");
		String MENU_CLASS	= in_vl.getString("MENU_CLASS");
		String COST_TYPE  	= in_vl.getString("COST_TYPE");
		String MENU_TYPE	= in_vl.getString("MENU_TYPE");	
		String v_MenuCD		= "";
		
		stmt 		=  conn.createStatement();
	
	
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
			
		// 1.1 먼저 복사할 대상 테이블에 식단이 있는지 체크
		//   COUNT(*) <= 0일 경우 INSERT 
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT  TERM_MENU_CD          					\n");
		sbSelSql.append("FROM    FSM_TERM_MENU_MST     					\n");
		sbSelSql.append("WHERE   MENU_DATE = '" + MENU_DATE + "'		\n");
		sbSelSql.append("AND     MENU_CLASS = '" + MENU_CLASS + "'		\n");
		sbSelSql.append("AND     COST_TYPE = '" + COST_TYPE + "'		\n");
		sbSelSql.append("AND     MENU_TYPE = '" + MENU_TYPE + "'		\n");
		sbSelSql.append("AND     MEAL = '" + MEAL + "'				\n");
		sbSelSql.append("AND     CORNER = '" + CORNER + "'			\n");
		                 
		System.out.println(sbSelSql.toString());
		
		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery(); 		
		
		if(rs.next())	// 메뉴가 있는경우
		{
			v_MenuCD = rs.getString("TERM_MENU_CD");
		}
		else
		{
			// 1.2 식단이 없는 경우 식단 INSERT
			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT  '" + MENU_DATE + "' || NVL(DECODE(LENGTH(MAX(SUBSTR(TERM_MENU_CD,9,3)+1)),1,'00',2,'0') || MAX(SUBSTR(TERM_MENU_CD,9,3)+1),'001') AS TERM_MENU_CD	\n");
			sbSelSql.append("FROM    FSM_TERM_MENU_MST                                                                                                                       			\n");
			sbSelSql.append("WHERE   SUBSTR(TERM_MENU_CD,0,8) = '" + MENU_DATE + "'                                                                                                   	\n");
			System.out.println(sbSelSql.toString());
			pstmt = conn.prepareStatement(sbSelSql.toString());
			rs = pstmt.executeQuery();
			rs.next();
			v_MenuCD = rs.getString("TERM_MENU_CD");
			
			// 2. 기간표준식단 복사 INSERT
			sbInsSql.delete(0, sbInsSql.length());
			sbInsSql.append("INSERT INTO FSM_TERM_MENU_MST 				\n");
			sbInsSql.append("(             								\n");
			sbInsSql.append("	 TERM_MENU_CD              				\n");
			sbInsSql.append("	, MENU_DESC                				\n");
			sbInsSql.append("	, MENU_DATE                				\n");
			sbInsSql.append("	, MENU_CLASS               				\n");
			sbInsSql.append("	, COST_TYPE								\n");
			sbInsSql.append("	, MENU_TYPE								\n");
			sbInsSql.append("	, MEAL                     				\n");
			sbInsSql.append("	, CORNER                   				\n");
			sbInsSql.append("	, START_DATE               				\n");
			sbInsSql.append("	, END_DATE                 				\n");
			sbInsSql.append("	, USE_YN                   				\n");
			sbInsSql.append("	, ATTR01, ATTR02, ATTR03, ATTR04, ATTR05\n");
			sbInsSql.append("	, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10\n");
			sbInsSql.append("	, CUSER                    				\n");
			sbInsSql.append("	, CDATE                    				\n");
			sbInsSql.append("	, UUSER                    				\n");
			sbInsSql.append("	, UDATE                    				\n");
			sbInsSql.append(" ) VALUES (                   				\n");
			sbInsSql.append("	 '" + v_MenuCD + "' --#TERM_MENU_CD#	\n");
			sbInsSql.append("	, '' --#MENU_DESC#              		\n");
			sbInsSql.append("	, '" + MENU_DATE + "' --#MENU_DATE#  	\n");
			sbInsSql.append("	, '" + MENU_CLASS + "' --#MENU_CLASS#	\n");
			sbInsSql.append("	, '" + COST_TYPE + "' --#COST_TYPE#  	\n");
			sbInsSql.append("	, '" + MENU_TYPE + "' --#MENU_TYPE#  	\n");
			sbInsSql.append("	, '" + MEAL + "' --#MEAL#				\n");
			sbInsSql.append("	, '" + CORNER + "' --#CORNER#			\n");
			sbInsSql.append("	, '' --#START_DATE#             		\n");
			sbInsSql.append("	, '' --#END_DATE#               		\n");
			sbInsSql.append("	, 'Y' --#USE_YN#                 		\n");
			sbInsSql.append("	, '', '', '', '', ''					\n");
			sbInsSql.append("	, '', '', '', '', ''					\n");
			sbInsSql.append("	, '" + g_EmpNo + "'                   	\n");
			sbInsSql.append("	, SYSDATE                  				\n");
			sbInsSql.append("	, '" + g_EmpNo + "'                   	\n");
			sbInsSql.append("	, SYSDATE                  				\n");
			sbInsSql.append(")      									\n");  
		               
			System.out.println(sbInsSql.toString());
			stmt.execute(sbInsSql.toString());
		}
		
		conn.commit();
		
	   this.setResultMessage(0, "OK",out_vl);
	   
	} catch(Exception ex) {
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