<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/손익실적
■ 프로그램ID   : MAS40030E_T001.jsp
■ 프로그램명   : 일손익실적관리
■ 작성일자     : 2013-11-29
■ 작성자       : 김장욱
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		// 업장실적마감
		if(ds_Cond.getString(0, "DOC_GUBUN").equals("U")){
	        sbSql.append("SELECT DISTINCT                                                                                                                                                     \n");
	        sbSql.append("       TO_CHAR(A10.UPJANG) AS DOC_CD                                                                                                                                                  \n");
	        sbSql.append("     , A10.UPJANGNM AS DOC_NM                                                                                                                                                 \n");
	        sbSql.append("     , A10.P_DATE AS CLOSE_DD                                                                                                                                       \n");
	        sbSql.append("     , DECODE(B10.CONFIRM_YN, 'Y', '작성완료', 'N', '작성중', '작성전') AS CONFIRM_YN                                                                               \n");
        	sbSql.append("     , DECODE((SELECT FST_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, 'N', 'Y') AS FST_CLOSE_YN \n");
        	sbSql.append("     , DECODE((SELECT SND_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, 'N', 'Y') AS SND_CLOSE_YN \n");
	        
	        // 팀장(F)인지 기획팀(S)인지 구분
	        if(ds_Cond.getString(0, "USER_DIV").equals("S")){
	        	sbSql.append("     , DECODE((SELECT SND_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, '0', '1') AS CLOSE_YN \n");
	        }else{
	        	sbSql.append("     , DECODE((SELECT FST_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, '0', '1') AS CLOSE_YN \n");
	        }
	        
	        sbSql.append("  FROM (                                                                                                                                                            \n");
	        sbSql.append("        SELECT A.UPJANG, A.UPJANGNM, B.P_DATE                                                                                                                       \n");
	        sbSql.append("          FROM (                                                                                                                                                    \n");
	        sbSql.append("                SELECT UPJANG, UPJANGNM                                                                                                                             \n");
	        sbSql.append("                  FROM SCO_UPJANG_MST_V                                                                                                                             \n");
	        sbSql.append("                 WHERE TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'                                                                                                                                \n");
	        sbSql.append("                   AND CLOSE_DATE IS NULL                                                                                                                           \n");
	        sbSql.append("               ) A,                                                                                                                                                 \n");
	        sbSql.append("               (                                                                                                                                                    \n");
	        sbSql.append("                SELECT P_DATE                                                                                                                                       \n");
	        sbSql.append("                  FROM (                                                                                                                                            \n");
	        sbSql.append("                        -- 가상테이블                                                                                                                               \n");
	        sbSql.append("                        SELECT TO_CHAR(TO_DATE('" + ds_Cond.getString(0, "INPUT_YM") + "'||'01', 'YYYYMMDD')+LEVEL-1,'YYYYMMDD') P_DATE                                                               \n");
	        sbSql.append("                          FROM DUAL                                                                                                                                 \n");
	        sbSql.append("                         WHERE 1=1                                                                                                                                  \n");
	        sbSql.append("                       CONNECT BY LEVEL-1 <= 365*10                                                                                                                 \n");
	        sbSql.append("                        )                                                                                                                                           \n");
	        sbSql.append("                 WHERE P_DATE BETWEEN '" + ds_Cond.getString(0, "INPUT_YM") + "'||'01' AND '" + ds_Cond.getString(0, "INPUT_YM") + "'||'31'                                                                                             \n");
	        sbSql.append("               ) B                                                                                                                                                  \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                \n");
	        sbSql.append("       ) A10, /* 모든업장에 대한 월의 일자 데이터 생성 */                                                                                                           \n");
	        sbSql.append("       MAS_DAILY_PL_REPORT B10                                                                                                                                      \n");
	        sbSql.append(" WHERE 1=1                                                                                                                                                          \n");
	        sbSql.append("   AND B10.INPUT_YM(+) = '" + ds_Cond.getString(0, "INPUT_YM") + "'                                                                                                                                   \n");
	        sbSql.append("   AND A10.P_DATE = B10.INPUT_DD(+)                                                                                                                                 \n");
	        sbSql.append("   AND A10.UPJANG = B10.DOC_CD(+)                                                                                                                                   \n");
	        sbSql.append("   AND B10.DOC_GUBUN(+) = 'R'                                                                                                                                       \n");
	        
	        // 마감일자정보
	        if(!ds_Cond.getString(0, "INPUT_DD").equals("")){
	            sbSql.append("   AND A10.P_DATE = '" + ds_Cond.getString(0, "INPUT_DD") + "'   \n");
	        }
	        
	        // 업장정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("   AND A10.UPJANG = '" + ds_Cond.getString(0, "DOC_CD") + "'     \n");
	        }        
	        
	        sbSql.append(" ORDER BY A10.UPJANGNM, A10.P_DATE                                                                                                                                    \n");
		}else{ // 마케터실적마감
			sbSql.append("SELECT DISTINCT                                                                                                                                                     \n");
	        sbSql.append("       A10.UPJANG AS DOC_CD                                                                                                                                                  \n");
	        sbSql.append("     , A10.UPJANGNM AS DOC_NM                                                                                                                                                 \n");
	        sbSql.append("     , A10.P_DATE AS CLOSE_DD                                                                                                                                       \n");
	        sbSql.append("     , DECODE(B10.CONFIRM_YN, 'Y', '작성완료', 'N', '작성중', '작성전') AS CONFIRM_YN                                                                               \n");
        	sbSql.append("     , DECODE((SELECT FST_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, 'N', 'Y') AS FST_CLOSE_YN \n");
        	sbSql.append("     , DECODE((SELECT SND_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, 'N', 'Y') AS SND_CLOSE_YN \n");
	        
	     	// 팀장(F)인지 기획팀(S)인지 구분
	        if(ds_Cond.getString(0, "USER_DIV").equals("S")){
	        	sbSql.append("     , DECODE((SELECT SND_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, '0', '1') AS CLOSE_YN \n");
	        }else{
	        	sbSql.append("     , DECODE((SELECT FST_CLOSE_SABUN FROM MAS_DAILY_CLOSE WHERE INPUT_YM = '" + ds_Cond.getString(0, "INPUT_YM") + "' AND CLOSE_DD = A10.P_DATE AND DOC_CD = A10.UPJANG), NULL, '0', '1') AS CLOSE_YN \n");
	        }
	     
	        sbSql.append("  FROM (                                                                                                                                                            \n");
	        sbSql.append("        SELECT A.UPJANG, A.UPJANGNM, B.P_DATE                                                                                                                       \n");
	        sbSql.append("          FROM (                                                                                                                                                    \n");
	        sbSql.append("                SELECT V.SABUN AS UPJANG                                                                                                                             \n");
	        sbSql.append("                     , V.NM_KOR||' ('||V.MU_NM||' '||V.CC_NM||')' AS UPJANGNM                                                                                                                             \n");
	        sbSql.append("                  FROM SCO_FS_HR_PERSONAL_V V                                                                                                                          \n");
	        sbSql.append("                 WHERE 1=1                                                                                                                                \n");
	        sbSql.append("                   AND EXISTS (SELECT 1 FROM SCC_COMMON_CODE WHERE CODE = V.DEPT_ID AND GROUP_CODE = 'MA1002' AND SET1 = 'FICS')                                                                                                                                \n");
	        sbSql.append("                   AND TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'                                                                                                                                \n");
	        sbSql.append("               ) A,                                                                                                                                                 \n");
	        sbSql.append("               (                                                                                                                                                    \n");
	        sbSql.append("                SELECT P_DATE                                                                                                                                       \n");
	        sbSql.append("                  FROM (                                                                                                                                            \n");
	        sbSql.append("                        -- 가상테이블                                                                                                                               \n");
	        sbSql.append("                        SELECT TO_CHAR(TO_DATE('" + ds_Cond.getString(0, "INPUT_YM") + "'||'01', 'YYYYMMDD')+LEVEL-1,'YYYYMMDD') P_DATE                                                               \n");
	        sbSql.append("                          FROM DUAL                                                                                                                                 \n");
	        sbSql.append("                         WHERE 1=1                                                                                                                                  \n");
	        sbSql.append("                       CONNECT BY LEVEL-1 <= 365*10                                                                                                                 \n");
	        sbSql.append("                        )                                                                                                                                           \n");
	        sbSql.append("                 WHERE P_DATE BETWEEN '" + ds_Cond.getString(0, "INPUT_YM") + "'||'01' AND '" + ds_Cond.getString(0, "INPUT_YM") + "'||'31'                                                                                             \n");
	        sbSql.append("               ) B                                                                                                                                                  \n");
	        sbSql.append("         WHERE 1 = 1                                                                                                                                                \n");
	        sbSql.append("       ) A10, /* 모든업장에 대한 월의 일자 데이터 생성 */                                                                                                           \n");
	        sbSql.append("       MAS_DAILY_PL_REPORT B10                                                                                                                                      \n");
	        sbSql.append(" WHERE 1=1                                                                                                                                                          \n");
	        sbSql.append("   AND B10.INPUT_YM(+) = '" + ds_Cond.getString(0, "INPUT_YM") + "'                                                                                                                                   \n");
	        sbSql.append("   AND A10.P_DATE = B10.INPUT_DD(+)                                                                                                                                 \n");
	        sbSql.append("   AND A10.UPJANG = B10.DOC_CD(+)                                                                                                                                   \n");
	        sbSql.append("   AND B10.DOC_GUBUN(+) = 'R'                                                                                                                                       \n");
	        
	        // 마감일자정보
	        if(!ds_Cond.getString(0, "INPUT_DD").equals("")){
	            sbSql.append("   AND A10.P_DATE = '" + ds_Cond.getString(0, "INPUT_DD") + "'   \n");
	        }
	        
	        // 업장정보
	        if(!ds_Cond.getString(0, "DOC_CD").equals("")){
	        	sbSql.append("   AND A10.UPJANG = '" + ds_Cond.getString(0, "DOC_CD") + "'     \n");
	        }        
	        
	        sbSql.append(" ORDER BY A10.UPJANGNM, A10.P_DATE                                                                                                                                    \n");			
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
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
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>