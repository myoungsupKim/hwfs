<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %> 
<%
	Statement stmt           =  null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		//logger.startIndividualLog(in_vl.getString("titLogId"));
	
		String SABUN 	= in_vl.getString("SABUN");
		String NM_KOR 	= in_vl.getString("NM_KOR");
		String CC_NM 	= in_vl.getString("CC_NM");
	
		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT B.MU_NM||' '||B.CC_NM AS CC_NM \n"); 
			sbSql.append("     , A.SABUN \n"); 
			sbSql.append("     , A.NM_KOR \n"); 
			// 개인정보 보호를 위해 핸드폰번호, 결혼기념일, 생년월일을 자동으로 가져오지 않기로 한다. FC기획팀 이혜은 매니저 요청
			// 김장욱 수정
			//sbSql.append("     , NVL(A.MYBIRTH_DT,'19000101') AS BIR_YMD \n"); 
			sbSql.append("     , '--' AS BIR_YMD \n");
			sbSql.append("     , DECODE(NVL(A.GB_YANGEUM,'1'),1,'N','Y') AS LUNAR_YN \n"); 
			sbSql.append("     , NVL(SC_CRYPTO_FUN('DEC', A.JUMINNO_ENC , '1'),'--') AS JUMINNO \n"); 
			sbSql.append("     , '--' AS TEL_NO \n"); 
			sbSql.append("     , '--' FAX_NO \n"); 
			
			// 개인정보 보호를 위해 핸드폰번호, 결혼기념일, 생년월일을 자동으로 가져오지 않기로 한다. FC기획팀 이혜은 매니저 요청
			// 김장욱 수정
			//sbSql.append("     , NVL(SC_CRYPTO_FUN('DEC', A.COMM_TEL3_ENC, '4'),'--') AS HP_NO \n"); 
			sbSql.append("     , '--' AS HP_NO \n");
			sbSql.append("     , NVL(SC_CRYPTO_FUN('DEC', A.COMM_EMAIL_ENC, '5'),'--') AS EMAIL \n"); 
			// 개인정보 보호를 위해 핸드폰번호, 결혼기념일, 생년월일을 자동으로 가져오지 않기로 한다. FC기획팀 이혜은 매니저 요청
			// 김장욱 수정
			//sbSql.append("     , NVL(A.WEDDING_DT,'--') AS WED_YMD \n"); 
			sbSql.append("     , '--' AS WED_YMD \n");
			sbSql.append("     , CASE WHEN LENGTH(TRIM(A.WEDDING_DT))>0 THEN 'Y' ELSE 'N' END AS WED_YN \n"); 
			
			// 20140319 FC기획팀 이혜은 매니저 요청(SR201403_04397) 사용자의 업장 기본으로 설정
			// 김장욱 수정
			sbSql.append("     , (SELECT MAX(UPJANG) FROM HLDC_ST_UPJANG WHERE DEPT_ID = B.DEPT_ID) AS UPJANG \n");
			
			sbSql.append("     , NVL((SELECT UPJANGNM FROM HLDC_ST_UPJANG WHERE UPJANG = (SELECT MAX(UPJANG) FROM HLDC_ST_UPJANG WHERE DEPT_ID = B.DEPT_ID AND CUSTCD IS NULL)), (SELECT UPJANGNM FROM HLDC_ST_UPJANG WHERE UPJANG = (SELECT MAX(UPJANG) FROM HLDC_ST_UPJANG WHERE DEPT_ID = B.DEPT_ID))) AS UPJANGNM \n");
			//sbSql.append("  FROM SCO_FS_HR_PERSONAL_V \n"); 
			sbSql.append("  FROM HLDC_HR_PERSONAL A, HLDC_SC_DEPT_V B \n"); 
			sbSql.append(" WHERE A.DEPT_ID = B.DEPT_ID \n"); 
			sbSql.append("   AND A.SABUN NOT IN (SELECT SABUN FROM SCC_USERINFO) \n"); 
			if(!SABUN.equals(""))
			{
				sbSql.append("   AND A.SABUN LIKE '%'||'" + SABUN + "'||'%' \n"); 
			}
			if(!NM_KOR.equals(""))
			{
				sbSql.append("   AND A.NM_KOR LIKE '%'||'" + NM_KOR + "'||'%' \n"); 
			}
			if(!CC_NM.equals(""))
			{
				sbSql.append("   AND B.CC_NM LIKE '%'||'" + CC_NM + "'||'%' \n"); 
			}
			sbSql.append(" ORDER BY A.SABUN \n"); 
		
			
			//pstmt = conn.prepareStatement(sbSql.toString());
			//rs = pstmt.executeQuery();
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSql.toString());					

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet SCC00041P_S001 = this.makeDataSet(rs,"SCC00041P_S001");
			out_dl.add(SCC00041P_S001);
			//rs.close();
			//pstmt.close();
			
			this.setResultMessage(0, "OK",out_vl);
		}
	
	} catch(Exception ex) {
		ex.printStackTrace();
		//jsp 로그남기기
		//logger.debug(ex.getMessage(), ex);
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
		//try {
		//	logger.endIndividualLog();
		//} catch( Exception logE) {
		//	logE.printStackTrace();
		//}		
	}
    proc_output(response,out,out_vl,out_dl);
%>