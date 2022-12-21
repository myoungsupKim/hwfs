
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타               
		DataSet ds_CommentList = in_dl.get("ds_cond");
		
		String USERID = "";
		String PWD 	 = "";
		String NM_KOR  = "";
		
		int RowStatus;
		
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		
		int RowCnt = ds_CommentList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
		
			USERID        = nullToBlank(ds_CommentList.getString(i, "ID"));          
			PWD           = nullToBlank(ds_CommentList.getString(i, "PWD"));
			NM_KOR        = nullToBlank(ds_CommentList.getString(i, "NAME"));
				
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT COUNT(1) AS CNT FROM SCC_USERINFO WHERE USERID = '" + USERID + "' \n");
			pstmt = conn.prepareStatement(sbSql.toString());
	        rs = pstmt.executeQuery();
	        rs.next();
	        
	        if ( rs.getInt("CNT") > 0 ) {
	        	throw new Exception("이미 등록된 사용자ID입니다.");
	        	
	        } else {
			
				sbSql.delete(0, sbSql.length());
				sbSql.append("	INSERT INTO SCC_USERINFO ( 																		\n");
				sbSql.append("		SABUN                                                                                       \n");
				sbSql.append("		, USERID                                                                                    \n");
				sbSql.append("		, PASSWORD                                                                                  \n");
				sbSql.append("		, NM_KOR                                                                                    \n");
				sbSql.append("		, USER_GROUP                                                                                \n");
				sbSql.append("		, USER_TYPE                                                                                 \n");
				sbSql.append("		, UPJANG                                                                                    \n");
				sbSql.append("		, LUNAR_YN                                                                                  \n");
				sbSql.append("		, SMS_YN                                                                                    \n");
				sbSql.append("		, EMAIL_YN                                                                                  \n");
				sbSql.append("		, SDATE                                                                                     \n");
				sbSql.append("		, EDATE                                                                                     \n");
				sbSql.append("		, JOIN_DATE                                                                                 \n");
				sbSql.append("		, PWD_CHG_DATE                                                                              \n");
				sbSql.append("		, USE_YN                                                                                    \n");
				sbSql.append("		, SIMPLE_PO_YN                                                                              \n");
				sbSql.append("		, PERS_INFO_PROC_LEVEL                                                                      \n");
				sbSql.append("		, PERS_INFO_PROC_GRADE                                                                           \n");
				sbSql.append("		, PWD_ERR_CNT                                                                               \n");
				sbSql.append("		, ACCT_STATUS                                                                               \n");
				sbSql.append("		, MAIN_TYPE                                                                                 \n");
				sbSql.append("		, DEPT_AUTH_APPLY_YN                                                                        \n");
				sbSql.append("		, USER_GROUP_AUTH_APPLY_YN                                                                  \n");
				sbSql.append("		, BOARD_MST				                                                                    \n");
				sbSql.append("		, CUSER                                                                                     \n");
				sbSql.append("	) SELECT                                                                                        \n");
				sbSql.append("		(SELECT 'Z' || TO_CHAR( MAX(SUBSTR(SABUN,-7))+1)  FROM SCC_USERINFO WHERE SABUN LIKE 'Z%') AS SABUN   \n");
				sbSql.append("		, '" + USERID + "'                                                                         \n");
				sbSql.append("		, SCC_CRYPTO.ONEWAY_ENC_FUN('" + PWD + "')                                                  \n");
				sbSql.append("		, '" + NM_KOR + "'                                                                          \n");
				sbSql.append("		, 'FC'                                                                                      \n");
				sbSql.append("		, '내부'                                                                                     \n");
				sbSql.append("		, '114998'                                                                                  \n");
				sbSql.append("		, 'N'                                                                                       \n");
				sbSql.append("		, 'N'                                                                                       \n");
				sbSql.append("		, 'N'                                                                                       \n");
				sbSql.append("		, '20210215'                                                                                \n");
				sbSql.append("		, '21001231'                                                                                \n");
				sbSql.append("		, '20210215'                                                                                \n");
				sbSql.append("		, '20210215'                                                                                \n");
				sbSql.append("		, 'Y'                                                                                       \n");
				sbSql.append("		, 'N'                                                                                       \n");
				sbSql.append("		, '2'                                                                                       \n");
				sbSql.append("		, 'C'                                                                                       \n");
				sbSql.append("		, 0                                                                                         \n");
				sbSql.append("		, 'NORMAL'                                                                                  \n");
				sbSql.append("		, 'INTRO_01'                                                                                \n");
				sbSql.append("		, 'N'                                                                                       \n");
				sbSql.append("		, 'N'                                                                                       \n");
				sbSql.append("		, '일반'                                                                              		\n");
				sbSql.append("		, 'APP_TESTER'                                                                              \n");
				sbSql.append("		FROM DUAL	                                                                                \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
	        }
		}
		
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-100, ex.toString(),out_vl);
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