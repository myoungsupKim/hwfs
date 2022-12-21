<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30210E_T001.jsp
■ 프로그램명   : 마케터별 사업계획관리
■ 작성일자     : 2015-08-06
■ 작성자       : 김태윤
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
		DataSet ds_CcCd     = in_dl.get("ds_CcCd");
		
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
		
		//out 데이타
		DataSet ds_List;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		// 사업계획, 최종PL, 수정계획 입력여부 조회.
        sbSql.append("SELECT COUNT(1) ISDATA  														\n");
        sbSql.append("  FROM MAP_BIZ_LOG_MGMT2														\n");
        sbSql.append(" WHERE YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");
        sbSql.append("   AND BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");
        sbSql.append("   AND TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' 			\n");
        sbSql.append("   AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' 			\n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		String isData = rs.getString("ISDATA");
		//System.out.println("isData================>"+isData);

		// BPC에서 최종PL 정보 유무 조회.
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT COUNT(1) ISDATA4  														\n");
        sbSql.append("  FROM MAP_BPC_CONFIRM_PL_INFO												\n");
        sbSql.append(" WHERE PLAN_CLASS = 'AP'												 		\n");
        sbSql.append("  AND VER_CD = '" + nullToBlank(ds_Cond.getString(0, "VER_CD")) + "'			\n");
        sbSql.append("  AND PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 	\n");
        sbSql.append("  AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 			\n");
        
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		String isData4 = rs.getString("ISDATA4");
		//System.out.println("isData4================>"+isData4);
		
		String chkVal = nullToBlank(ds_Cond.getString(0, "BIZ_CLASS"));
		//System.out.println("chkVal================>"+chkVal+"<==");
		// BPC에서 최종PL 정보가 있을때.
		String isData5 = "0";
		if(chkVal != "" || !"".equals(chkVal)){
			sbSql.delete(0, sbSql.length());
	        //sbSql.append("SELECT DECODE(substr('"+ chkVal +"', -2), '최종', '1', '0') isData5			\n");
	        sbSql.append("SELECT COUNT(1) isData5														\n");
	        sbSql.append("  FROM MAP_BIZ_LOG_MGMT2														\n");
	        sbSql.append(" WHERE BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'	\n");
	        sbSql.append("   AND YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "' 			\n");
	        sbSql.append("   AND TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "' 			\n");
	        sbSql.append("   AND SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' 			\n");
	        //sbSql.append("   AND UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' 		\n");

			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();
			
			isData5 = nullToBlank(rs.getString("ISDATA5"));
			//System.out.println("isData5================>"+isData5);
		}
		
		// 최초 등록이면 월추정 데이터(실적+추정)를 기본값으로 보여준다.
		if("0".equals(isData)){
			sbSql.delete(0, sbSql.length());
			sbSql.append(" SELECT UPJANG, UPJANGNM, ACCT_CD, ACCT_NM, ACCT_CLASS, CLASS, CC_CD						                                                             \n");
			sbSql.append("       ,(                                                                                                                                       		 \n");
			sbSql.append("          MM_AMT_01 + MM_AMT_02 + MM_AMT_03 + MM_AMT_04 + MM_AMT_05 + MM_AMT_06                                                                        \n");
			sbSql.append("        + MM_AMT_07 + MM_AMT_08 + MM_AMT_09 + MM_AMT_10 + MM_AMT_11 + MM_AMT_12                                                                        \n");
			sbSql.append("        ) SUM_AMT                                                                                                                                      \n");
			sbSql.append("       ,MM_AMT_01, MM_AMT_02, MM_AMT_03, MM_AMT_04, MM_AMT_05, MM_AMT_06                                                                               \n");
			sbSql.append("       ,MM_AMT_07, MM_AMT_08, MM_AMT_09, MM_AMT_10, MM_AMT_11, MM_AMT_12                                                                               \n");
			sbSql.append("   FROM (                                                                                                                                       		 \n");
			sbSql.append(" SELECT A.UPJANG                                                                                                                                       \n");
			sbSql.append("       ,A.UPJANGNM_DISP AS UPJANGNM                                                                                                                    \n");
			sbSql.append("       ,A.ACCT_CD                                                                                                                                      \n");
			sbSql.append("       ,A.ACCT_NM                                                                                                                                      \n");
			sbSql.append("       ,A.ACCT_CLASS                                                                                                                                   \n");
			sbSql.append("       ,'" + g_Yy + "' || '년_실적' AS CLASS                                                                                                           \n");
			sbSql.append("       ,A.CC_CD		                                                                                                           						 \n");
			sbSql.append("       ,0 AS SUM_AMT                                                                                                           						 \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_01), 0, SUM(B.MM_AMT_01), SUM(A.NET_AMT_01))                           	 \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_01), 0, SUM(B.MM_AMT_01), SUM(A.TRANS_NET_AMT_01))                        	 \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_01), 0, SUM(B.MM_AMT_01), SUM(A.PAY_COMM_01))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_01) - SUM(A.TRANS_NET_AMT_01 + A.PAY_COMM_01)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_01), 0, SUM(B.MM_AMT_01), SUM(A.NET_AMT_01)) - DECODE(SUM(A.TRANS_NET_AMT_01), 0, SUM(B.MM_AMT_01), SUM(A.TRANS_NET_AMT_01)) + DECODE(SUM(A.PAY_COMM_01), 0, SUM(B.MM_AMT_01), SUM(A.PAY_COMM_01))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000)  MM_AMT_01                                                                                                                        \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_02), 0, SUM(B.MM_AMT_02), SUM(A.NET_AMT_02))                           	 \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_02), 0, SUM(B.MM_AMT_02), SUM(A.TRANS_NET_AMT_02))                        	 \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_02), 0, SUM(B.MM_AMT_02), SUM(A.PAY_COMM_02))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_02) - SUM(A.TRANS_NET_AMT_02 + A.PAY_COMM_02)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_02), 0, SUM(B.MM_AMT_02), SUM(A.NET_AMT_02)) - DECODE(SUM(A.TRANS_NET_AMT_02), 0, SUM(B.MM_AMT_02), SUM(A.TRANS_NET_AMT_02)) + DECODE(SUM(A.PAY_COMM_02), 0, SUM(B.MM_AMT_02), SUM(A.PAY_COMM_02))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_02                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_03), 0, SUM(B.MM_AMT_03), SUM(A.NET_AMT_03))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_03), 0, SUM(B.MM_AMT_03), SUM(A.TRANS_NET_AMT_03))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_03), 0, SUM(B.MM_AMT_03), SUM(A.PAY_COMM_03))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_03) - SUM(A.TRANS_NET_AMT_03 + A.PAY_COMM_03)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_03), 0, SUM(B.MM_AMT_03), SUM(A.NET_AMT_03)) - DECODE(SUM(A.TRANS_NET_AMT_03), 0, SUM(B.MM_AMT_03), SUM(A.TRANS_NET_AMT_03)) + DECODE(SUM(A.PAY_COMM_03), 0, SUM(B.MM_AMT_03), SUM(A.PAY_COMM_03))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_03                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_04), 0, SUM(B.MM_AMT_04), SUM(A.NET_AMT_04))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_04), 0, SUM(B.MM_AMT_04), SUM(A.TRANS_NET_AMT_04))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_04), 0, SUM(B.MM_AMT_04), SUM(A.PAY_COMM_04))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_04) - SUM(A.TRANS_NET_AMT_04 + A.PAY_COMM_04)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_04), 0, SUM(B.MM_AMT_04), SUM(A.NET_AMT_04)) - DECODE(SUM(A.TRANS_NET_AMT_04), 0, SUM(B.MM_AMT_04), SUM(A.TRANS_NET_AMT_04)) + DECODE(SUM(A.PAY_COMM_04), 0, SUM(B.MM_AMT_04), SUM(A.PAY_COMM_04))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_04                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_05), 0, SUM(B.MM_AMT_05), SUM(A.NET_AMT_05))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_05), 0, SUM(B.MM_AMT_05), SUM(A.TRANS_NET_AMT_05))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_05), 0, SUM(B.MM_AMT_05), SUM(A.PAY_COMM_05))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_05) - SUM(A.TRANS_NET_AMT_05 + A.PAY_COMM_05)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_05), 0, SUM(B.MM_AMT_05), SUM(A.NET_AMT_05)) - DECODE(SUM(A.TRANS_NET_AMT_05), 0, SUM(B.MM_AMT_05), SUM(A.TRANS_NET_AMT_05)) + DECODE(SUM(A.PAY_COMM_05), 0, SUM(B.MM_AMT_05), SUM(A.PAY_COMM_05))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_05                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_06), 0, SUM(B.MM_AMT_06), SUM(A.NET_AMT_06))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_06), 0, SUM(B.MM_AMT_06), SUM(A.TRANS_NET_AMT_06))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_06), 0, SUM(B.MM_AMT_06), SUM(A.PAY_COMM_06))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_06) - SUM(A.TRANS_NET_AMT_06 + A.PAY_COMM_06)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_06), 0, SUM(B.MM_AMT_06), SUM(A.NET_AMT_06)) - DECODE(SUM(A.TRANS_NET_AMT_06), 0, SUM(B.MM_AMT_06), SUM(A.TRANS_NET_AMT_06)) + DECODE(SUM(A.PAY_COMM_06), 0, SUM(B.MM_AMT_06), SUM(A.PAY_COMM_06))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_06                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_07), 0, SUM(B.MM_AMT_07), SUM(A.NET_AMT_07))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_07), 0, SUM(B.MM_AMT_07), SUM(A.TRANS_NET_AMT_07))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_07), 0, SUM(B.MM_AMT_07), SUM(A.PAY_COMM_07))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_07) - SUM(A.TRANS_NET_AMT_07 + A.PAY_COMM_07)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_07), 0, SUM(B.MM_AMT_07), SUM(A.NET_AMT_07)) - DECODE(SUM(A.TRANS_NET_AMT_07), 0, SUM(B.MM_AMT_07), SUM(A.TRANS_NET_AMT_07)) + DECODE(SUM(A.PAY_COMM_07), 0, SUM(B.MM_AMT_07), SUM(A.PAY_COMM_07))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_07                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_08), 0, SUM(B.MM_AMT_08), SUM(A.NET_AMT_08))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_08), 0, SUM(B.MM_AMT_08), SUM(A.TRANS_NET_AMT_08))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_08), 0, SUM(B.MM_AMT_08), SUM(A.PAY_COMM_08))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_08) - SUM(A.TRANS_NET_AMT_08 + A.PAY_COMM_08)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_08), 0, SUM(B.MM_AMT_08), SUM(A.NET_AMT_08)) - DECODE(SUM(A.TRANS_NET_AMT_08), 0, SUM(B.MM_AMT_08), SUM(A.TRANS_NET_AMT_08)) + DECODE(SUM(A.PAY_COMM_08), 0, SUM(B.MM_AMT_08), SUM(A.PAY_COMM_08))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_08                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_09), 0, SUM(B.MM_AMT_09), SUM(A.NET_AMT_09))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_09), 0, SUM(B.MM_AMT_09), SUM(A.TRANS_NET_AMT_09))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_09), 0, SUM(B.MM_AMT_09), SUM(A.PAY_COMM_09))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_09) - SUM(A.TRANS_NET_AMT_09 + A.PAY_COMM_09)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_09), 0, SUM(B.MM_AMT_09), SUM(A.NET_AMT_09)) - DECODE(SUM(A.TRANS_NET_AMT_09), 0, SUM(B.MM_AMT_09), SUM(A.TRANS_NET_AMT_09)) + DECODE(SUM(A.PAY_COMM_09), 0, SUM(B.MM_AMT_01), SUM(A.PAY_COMM_09))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_09                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_10), 0, SUM(B.MM_AMT_10), SUM(A.NET_AMT_10))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_10), 0, SUM(B.MM_AMT_10), SUM(A.TRANS_NET_AMT_10))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_10), 0, SUM(B.MM_AMT_10), SUM(A.PAY_COMM_10))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_10) - SUM(A.TRANS_NET_AMT_10 + A.PAY_COMM_10)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_10), 0, SUM(B.MM_AMT_10), SUM(A.NET_AMT_10)) - DECODE(SUM(A.TRANS_NET_AMT_10), 0, SUM(B.MM_AMT_10), SUM(A.TRANS_NET_AMT_10)) + DECODE(SUM(A.PAY_COMM_10), 0, SUM(B.MM_AMT_10), SUM(A.PAY_COMM_10))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_10                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_11), 0, SUM(B.MM_AMT_11), SUM(A.NET_AMT_11))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_11), 0, SUM(B.MM_AMT_11), SUM(A.TRANS_NET_AMT_11))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_11), 0, SUM(B.MM_AMT_11), SUM(A.PAY_COMM_11))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_11) - SUM(A.TRANS_NET_AMT_11 + A.PAY_COMM_11)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_11), 0, SUM(B.MM_AMT_11), SUM(A.NET_AMT_11)) - DECODE(SUM(A.TRANS_NET_AMT_11), 0, SUM(B.MM_AMT_11), SUM(A.TRANS_NET_AMT_11)) + DECODE(SUM(A.PAY_COMM_11), 0, SUM(B.MM_AMT_11), SUM(A.PAY_COMM_11))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_11                                                                                                                         \n");
			sbSql.append("       ,ROUND(NVL(CASE WHEN A.ACCT_CD = '41201010' THEN DECODE(SUM(A.NET_AMT_12), 0, SUM(B.MM_AMT_12), SUM(A.NET_AMT_12))                           \n");
			sbSql.append("              WHEN A.ACCT_CD = '42201010' THEN DECODE(SUM(A.TRANS_NET_AMT_12), 0, SUM(B.MM_AMT_12), SUM(A.TRANS_NET_AMT_12))                        \n");
			sbSql.append("              WHEN A.ACCT_CD = '43216050' THEN DECODE(SUM(A.PAY_COMM_12), 0, SUM(B.MM_AMT_12), SUM(A.PAY_COMM_12))                        			 \n");
			//sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN SUM(A.NET_AMT_12) - SUM(A.TRANS_NET_AMT_12 + A.PAY_COMM_12)											 \n");
			sbSql.append("              WHEN A.ACCT_CD = '44000000' THEN DECODE(SUM(A.NET_AMT_12), 0, SUM(B.MM_AMT_12), SUM(A.NET_AMT_12)) - DECODE(SUM(A.TRANS_NET_AMT_12), 0, SUM(B.MM_AMT_12), SUM(A.TRANS_NET_AMT_12)) + DECODE(SUM(A.PAY_COMM_12), 0, SUM(B.MM_AMT_12), SUM(A.PAY_COMM_12))	\n");
			sbSql.append("         ELSE 0                                                                                                                                        \n");
			sbSql.append("          END                                                                                                                                          \n");
			sbSql.append("        , 0) / 1000) MM_AMT_12                                                                                                                         \n");
			sbSql.append("   FROM (                                                                                                                                              \n");
			sbSql.append("         SELECT UPJANG                                                                                                                                 \n");
			sbSql.append("               ,UPJANGNM_DISP                                                                                                                          \n");
			sbSql.append("               ,'41201010' AS ACCT_CD                                                                                                                  \n");
			sbSql.append("               ,'상품매출_일반' AS ACCT_NM                                                                                                             \n");
			sbSql.append("               ,'매출액' AS ACCT_CLASS                                                                                                                 \n");
			sbSql.append("               ,A.CC_CD                                                                                                                 				 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '1' THEN NET_AMT ELSE 0 END) NET_AMT_01                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '2' THEN NET_AMT ELSE 0 END) NET_AMT_02                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '3' THEN NET_AMT ELSE 0 END) NET_AMT_03                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '4' THEN NET_AMT ELSE 0 END) NET_AMT_04                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '5' THEN NET_AMT ELSE 0 END) NET_AMT_05                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '6' THEN NET_AMT ELSE 0 END) NET_AMT_06                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '7' THEN NET_AMT ELSE 0 END) NET_AMT_07                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '8' THEN NET_AMT ELSE 0 END) NET_AMT_08                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '9' THEN NET_AMT ELSE 0 END) NET_AMT_09                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '10' THEN NET_AMT ELSE 0 END) NET_AMT_10                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '11' THEN NET_AMT ELSE 0 END) NET_AMT_11                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '12' THEN NET_AMT ELSE 0 END) NET_AMT_12                                                                         \n");
			sbSql.append("               ,0 TRANS_NET_AMT_01, 0 TRANS_NET_AMT_02, 0 TRANS_NET_AMT_03, 0 TRANS_NET_AMT_04, 0 TRANS_NET_AMT_05, 0 TRANS_NET_AMT_06  \n");
			sbSql.append("               ,0 TRANS_NET_AMT_07, 0 TRANS_NET_AMT_08, 0 TRANS_NET_AMT_09, 0 TRANS_NET_AMT_10, 0 TRANS_NET_AMT_11, 0 TRANS_NET_AMT_12  \n");
			sbSql.append("               ,0 PAY_COMM_01, 0 PAY_COMM_02, 0 PAY_COMM_03, 0 PAY_COMM_04, 0 PAY_COMM_05, 0 PAY_COMM_06  							 \n");
			sbSql.append("               ,0 PAY_COMM_07, 0 PAY_COMM_08, 0 PAY_COMM_09, 0 PAY_COMM_10, 0 PAY_COMM_11, 0 PAY_COMM_12  							 \n");
			sbSql.append("               ,0 SALE_AMT_01, 0 SALE_AMT_02, 0 SALE_AMT_03, 0 SALE_AMT_04, 0 SALE_AMT_05, 0 SALE_AMT_06  							 \n");
			sbSql.append("               ,0 SALE_AMT_07, 0 SALE_AMT_08, 0 SALE_AMT_09, 0 SALE_AMT_10, 0 SALE_AMT_11, 0 SALE_AMT_12  							 \n");			
			sbSql.append("           FROM ( SELECT EXTRACT( YEAR FROM TO_DATE(A.SALE_DATE)) YY                                                                                 	 \n");
			sbSql.append("                        ,EXTRACT(MONTH FROM TO_DATE(A.SALE_DATE)) MM                                                                                 	 \n");
			sbSql.append("                        ,A.NET_AMT                                                                                                                     \n");
			sbSql.append("                        ,B.UPJANG                                                                                                                      \n");
			sbSql.append("                        ,B.UPJANGNM_DISP                                                                                                               \n");
			sbSql.append("                        ,B.CC_CD                                                                                                               		 \n");
			sbSql.append("                    FROM FMS_SALES A                                                                                                                   \n");
			sbSql.append("                        ,(                                                                                                                             \n");
			sbSql.append("                          SELECT A.UPJANG                                                                                                              \n");
			sbSql.append("                                ,A.UPJANGNM_DISP                                                                                                       \n");
			sbSql.append("                                ,B.CC_CD		                                                                                                         \n");
			sbSql.append("                            FROM FMS_UPJANG A                                                                                                          \n");
			sbSql.append("                                ,ST_UPJANG B                                                                                                           \n");
			sbSql.append("                                ,ST_CUST C                                                                                                             \n");
			sbSql.append("                           WHERE A.UPJANG = B.UPJANG                                                                                                   \n");
			sbSql.append("                             AND A.UPJANGNM_DISP = B.UPJANGNM                                                                                          \n");
			sbSql.append("                             AND B.CUSTCD = C.CUSTCD                                                                                                   \n");
			sbSql.append("                             AND A.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND C.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND A.PART_SALES_SABUN = '" + ds_Cond.getString(0, "SABUN") + "'                                                          \n");
			sbSql.append("                         ) B                                                                                                                           \n");
			sbSql.append("                   WHERE A.UPJANG(+) = B.UPJANG                                                                                                        \n");
			sbSql.append("                     AND SUBSTR(A.SALE_DATE(+), 1, 4) = '" + g_Yy + "'	                                                                             \n");
			sbSql.append("                     AND A.TRANS_YN(+) = 'Y'                                                                                                           \n");
			sbSql.append("                     AND A.SALE_TYPE(+) = '1301'                                                                                                       \n");
			sbSql.append("                                                                                                                                                       \n");
			sbSql.append("                ) A                                                                                                                                    \n");
			sbSql.append("          GROUP BY UPJANG, UPJANGNM_DISP, CC_CD                                                                                                        \n");
			sbSql.append("          UNION ALL                                                                                                                                    \n");
			sbSql.append("         SELECT UPJANG                                                                                                                                 \n");
			sbSql.append("               ,UPJANGNM_DISP AS UPJANGNM                                                                                                              \n");
			sbSql.append("               ,'42201010' AS ACCT_CD                                                                                                                  \n");
			sbSql.append("               ,'상품원가_일반' AS ACCT_NM                                                                                                             \n");
			sbSql.append("               ,'재료비' AS ACCT_CLASS                                                                                                                 \n");
			sbSql.append("               ,A.CC_CD                                                                                                                 				 \n");
			sbSql.append("               ,0 NET_AMT_01, 0 NET_AMT_02, 0 NET_AMT_03, 0 NET_AMT_04, 0 NET_AMT_05, 0 NET_AMT_06                                   \n");
			sbSql.append("               ,0 NET_AMT_07, 0 NET_AMT_08, 0 NET_AMT_09, 0 NET_AMT_10, 0 NET_AMT_11, 0 NET_AMT_12                                   \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '1' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_01                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '2' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_02                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '3' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_03                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '4' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_04                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '5' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_05                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '6' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_06                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '7' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_07                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '8' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_08                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '9' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_09                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '10' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_10                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '11' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_11                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '12' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_12                                                             \n");
			sbSql.append("               ,0 PAY_COMM_01, 0 PAY_COMM_02, 0 PAY_COMM_03, 0 PAY_COMM_04, 0 PAY_COMM_05, 0 PAY_COMM_06  							 \n");
			sbSql.append("               ,0 PAY_COMM_07, 0 PAY_COMM_08, 0 PAY_COMM_09, 0 PAY_COMM_10, 0 PAY_COMM_11, 0 PAY_COMM_12  							 \n");
			sbSql.append("               ,0 SALE_AMT_01, 0 SALE_AMT_02, 0 SALE_AMT_03, 0 SALE_AMT_04, 0 SALE_AMT_05, 0 SALE_AMT_06  							 \n");
			sbSql.append("               ,0 SALE_AMT_07, 0 SALE_AMT_08, 0 SALE_AMT_09, 0 SALE_AMT_10, 0 SALE_AMT_11, 0 SALE_AMT_12  							 \n");
			sbSql.append("           FROM ( SELECT EXTRACT( YEAR FROM TO_DATE(A.SALE_DATE)) YY                                                                                 	 \n");
			sbSql.append("                        ,EXTRACT(MONTH FROM TO_DATE(A.SALE_DATE)) MM                                                                                 	 \n");
			sbSql.append("                        ,A.TRANS_NET_AMT                                                                                                               \n");
			sbSql.append("                        ,B.UPJANG                                                                                                                      \n");
			sbSql.append("                        ,B.UPJANGNM_DISP                                                                                                               \n");
			sbSql.append("                        ,B.CC_CD                                                                                                               		 \n");
			sbSql.append("                    FROM FMS_SALES A                                                                                                                   \n");
			sbSql.append("                        ,(                                                                                                                             \n");
			sbSql.append("                          SELECT A.UPJANG                                                                                                              \n");
			sbSql.append("                                ,A.UPJANGNM_DISP                                                                                                       \n");
			sbSql.append("                                ,B.CC_CD		                                                                                                         \n");
			sbSql.append("                            FROM FMS_UPJANG A                                                                                                          \n");
			sbSql.append("                                ,ST_UPJANG B                                                                                                           \n");
			sbSql.append("                                ,ST_CUST C                                                                                                             \n");
			sbSql.append("                           WHERE A.UPJANG = B.UPJANG                                                                                                   \n");
			sbSql.append("                             AND A.UPJANGNM_DISP = B.UPJANGNM                                                                                          \n");
			sbSql.append("                             AND B.CUSTCD = C.CUSTCD                                                                                                   \n");
			sbSql.append("                             AND A.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND C.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND A.PART_SALES_SABUN = '" + ds_Cond.getString(0, "SABUN") + "'                                                          \n");
			sbSql.append("                         ) B                                                                                                                           \n");
			sbSql.append("                   WHERE A.UPJANG(+) = B.UPJANG                                                                                                        \n");
			sbSql.append("                     AND SUBSTR(A.SALE_DATE(+), 1, 4) = '" + g_Yy + "'	                                                                             \n");
			sbSql.append("                     AND A.TRANS_YN(+) = 'Y'                                                                                                           \n");
			sbSql.append("                     AND A.SALE_TYPE(+) = '1301'                                                                                                       \n");
			sbSql.append("                ) A                                                                                                                                    \n");
			sbSql.append("          GROUP BY UPJANG, UPJANGNM_DISP, CC_CD                                                                                                        \n");
			sbSql.append("          UNION ALL                                                                                                                                    \n");
			sbSql.append("         SELECT UPJANG                                                                                                                                 \n");
			sbSql.append("               ,UPJANGNM_DISP AS UPJANGNM                                                                                                              \n");
			sbSql.append("               ,'43216050' AS ACCT_CD                                                                                                                  \n");
			sbSql.append("               ,'지급수수료' AS ACCT_NM                                                                                                             	 \n");
			sbSql.append("               ,'경비' AS ACCT_CLASS                                                                                                                 	 \n");
			sbSql.append("               ,A.CC_CD                                                                                                                 				 \n");
			sbSql.append("               ,0 NET_AMT_01, 0 NET_AMT_02, 0 NET_AMT_03, 0 NET_AMT_04, 0 NET_AMT_05, 0 NET_AMT_06                                   \n");
			sbSql.append("               ,0 NET_AMT_07, 0 NET_AMT_08, 0 NET_AMT_09, 0 NET_AMT_10, 0 NET_AMT_11, 0 NET_AMT_12                                   \n");
			sbSql.append("               ,0 TRANS_NET_AMT_01, 0 TRANS_NET_AMT_02, 0 TRANS_NET_AMT_03, 0 TRANS_NET_AMT_04, 0 TRANS_NET_AMT_05, 0 TRANS_NET_AMT_06  \n");
			sbSql.append("               ,0 TRANS_NET_AMT_07, 0 TRANS_NET_AMT_08, 0 TRANS_NET_AMT_09, 0 TRANS_NET_AMT_10, 0 TRANS_NET_AMT_11, 0 TRANS_NET_AMT_12  \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '1' THEN PAY_COMM ELSE 0 END) PAY_COMM_01                                                           			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '2' THEN PAY_COMM ELSE 0 END) PAY_COMM_02                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '3' THEN PAY_COMM ELSE 0 END) PAY_COMM_03                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '4' THEN PAY_COMM ELSE 0 END) PAY_COMM_04                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '5' THEN PAY_COMM ELSE 0 END) PAY_COMM_05                                                           		     \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '6' THEN PAY_COMM ELSE 0 END) PAY_COMM_06                                                           			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '7' THEN PAY_COMM ELSE 0 END) PAY_COMM_07                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '8' THEN PAY_COMM ELSE 0 END) PAY_COMM_08                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '9' THEN PAY_COMM ELSE 0 END) PAY_COMM_09                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '10' THEN PAY_COMM ELSE 0 END) PAY_COMM_10                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '11' THEN PAY_COMM ELSE 0 END) PAY_COMM_11                                                             			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '12' THEN PAY_COMM ELSE 0 END) PAY_COMM_12                                                             			 \n");
			sbSql.append("               ,0 SALE_AMT_01, 0 SALE_AMT_02, 0 SALE_AMT_03, 0 SALE_AMT_04, 0 SALE_AMT_05, 0 SALE_AMT_06  							 \n");
			sbSql.append("               ,0 SALE_AMT_07, 0 SALE_AMT_08, 0 SALE_AMT_09, 0 SALE_AMT_10, 0 SALE_AMT_11, 0 SALE_AMT_12  							 \n");
			sbSql.append("           FROM ( SELECT EXTRACT( YEAR FROM TO_DATE(A.SALE_DATE)) YY                                                                                 	 \n");
			sbSql.append("                        ,EXTRACT(MONTH FROM TO_DATE(A.SALE_DATE)) MM                                                                                 	 \n");
			sbSql.append("                        ,A.PAY_COMM                                                                                                               	 \n");
			sbSql.append("                        ,B.UPJANG                                                                                                                      \n");
			sbSql.append("                        ,B.UPJANGNM_DISP                                                                                                               \n");
			sbSql.append("                        ,B.CC_CD                                                                                                               		 \n");
			sbSql.append("                    FROM FMS_SALES A                                                                                                                   \n");
			sbSql.append("                        ,(                                                                                                                             \n");
			sbSql.append("                          SELECT A.UPJANG                                                                                                              \n");
			sbSql.append("                                ,A.UPJANGNM_DISP                                                                                                       \n");
			sbSql.append("                                ,B.CC_CD		                                                                                                         \n");
			sbSql.append("                            FROM FMS_UPJANG A                                                                                                          \n");
			sbSql.append("                                ,ST_UPJANG B                                                                                                           \n");
			sbSql.append("                                ,ST_CUST C                                                                                                             \n");
			sbSql.append("                           WHERE A.UPJANG = B.UPJANG                                                                                                   \n");
			sbSql.append("                             AND A.UPJANGNM_DISP = B.UPJANGNM                                                                                          \n");
			sbSql.append("                             AND B.CUSTCD = C.CUSTCD                                                                                                   \n");
			sbSql.append("                             AND A.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND C.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND A.PART_SALES_SABUN = '" + ds_Cond.getString(0, "SABUN") + "'                                                          \n");
			sbSql.append("                         ) B                                                                                                                           \n");
			sbSql.append("                   WHERE A.UPJANG(+) = B.UPJANG                                                                                                        \n");
			sbSql.append("                     AND SUBSTR(A.SALE_DATE(+), 1, 4) = '" + g_Yy + "'	                                                                             \n");
			sbSql.append("                     AND A.TRANS_YN(+) = 'Y'                                                                                                           \n");
			sbSql.append("                     AND A.SALE_TYPE(+) = '1301'                                                                                                       \n");
			sbSql.append("                ) A                                                                                                                                    \n");
			sbSql.append("          GROUP BY UPJANG, UPJANGNM_DISP, CC_CD                                                                                                        \n");
			sbSql.append("          UNION ALL                                                                                                                                    \n");
			sbSql.append("         SELECT UPJANG                                                                                                                                 \n");
			sbSql.append("               ,UPJANGNM_DISP AS UPJANGNM                                                                                                              \n");
			sbSql.append("               ,'44000000' AS ACCT_CD                                                                                                                  \n");
			sbSql.append("               ,'매출이익' AS ACCT_NM                                                                                                             	 \n");
			sbSql.append("               ,'매출이익' AS ACCT_CLASS                                                                                                             	 \n");
			sbSql.append("               ,A.CC_CD                                                                                                                 				 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '1' THEN NET_AMT ELSE 0 END) NET_AMT_01                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '2' THEN NET_AMT ELSE 0 END) NET_AMT_02                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '3' THEN NET_AMT ELSE 0 END) NET_AMT_03                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '4' THEN NET_AMT ELSE 0 END) NET_AMT_04                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '5' THEN NET_AMT ELSE 0 END) NET_AMT_05                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '6' THEN NET_AMT ELSE 0 END) NET_AMT_06                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '7' THEN NET_AMT ELSE 0 END) NET_AMT_07                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '8' THEN NET_AMT ELSE 0 END) NET_AMT_08                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '9' THEN NET_AMT ELSE 0 END) NET_AMT_09                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '10' THEN NET_AMT ELSE 0 END) NET_AMT_10                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '11' THEN NET_AMT ELSE 0 END) NET_AMT_11                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '12' THEN NET_AMT ELSE 0 END) NET_AMT_12                                                                         \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '1' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_01                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '2' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_02                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '3' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_03                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '4' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_04                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '5' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_05                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '6' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_06                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '7' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_07                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '8' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_08                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '9' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_09                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '10' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_10                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '11' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_11                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '12' THEN TRANS_NET_AMT ELSE 0 END) TRANS_NET_AMT_12                                                             \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '1' THEN PAY_COMM ELSE 0 END) PAY_COMM_01                                                           			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '2' THEN PAY_COMM ELSE 0 END) PAY_COMM_02                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '3' THEN PAY_COMM ELSE 0 END) PAY_COMM_03                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '4' THEN PAY_COMM ELSE 0 END) PAY_COMM_04                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '5' THEN PAY_COMM ELSE 0 END) PAY_COMM_05                                                           		     \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '6' THEN PAY_COMM ELSE 0 END) PAY_COMM_06                                                           			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '7' THEN PAY_COMM ELSE 0 END) PAY_COMM_07                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '8' THEN PAY_COMM ELSE 0 END) PAY_COMM_08                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM =  '9' THEN PAY_COMM ELSE 0 END) PAY_COMM_09                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '10' THEN PAY_COMM ELSE 0 END) PAY_COMM_10                                                            			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '11' THEN PAY_COMM ELSE 0 END) PAY_COMM_11                                                             			 \n");
			sbSql.append("               ,SUM(CASE WHEN MM = '12' THEN PAY_COMM ELSE 0 END) PAY_COMM_12                                                             			 \n");
			sbSql.append("               ,0 SALE_AMT_01                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_02                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_03                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_04                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_05                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_06                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_07                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_08                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_09                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_10                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_11                                                             															 \n");
			sbSql.append("               ,0 SALE_AMT_12                                                             															 \n");
			sbSql.append("           FROM ( SELECT EXTRACT( YEAR FROM TO_DATE(A.SALE_DATE)) YY                                                                                 	 \n");
			sbSql.append("                        ,EXTRACT(MONTH FROM TO_DATE(A.SALE_DATE)) MM                                                                                 	 \n");
			sbSql.append("                        ,A.NET_AMT                                                                                                               	 	 \n");
			sbSql.append("                        ,A.TRANS_NET_AMT                                                                                                               \n");
			sbSql.append("                        ,A.PAY_COMM                                                                                                               	 \n");
			sbSql.append("                        ,0 SALE_AMT                                                                                                               	 \n");
			sbSql.append("                        ,B.UPJANG                                                                                                                      \n");
			sbSql.append("                        ,B.UPJANGNM_DISP                                                                                                               \n");
			sbSql.append("                        ,B.CC_CD                                                                                                               		 \n");
			sbSql.append("                    FROM FMS_SALES A                                                                                                                   \n");
			sbSql.append("                        ,(                                                                                                                             \n");
			sbSql.append("                          SELECT A.UPJANG                                                                                                              \n");
			sbSql.append("                                ,A.UPJANGNM_DISP                                                                                                       \n");
			sbSql.append("                                ,B.CC_CD		                                                                                                         \n");
			sbSql.append("                            FROM FMS_UPJANG A                                                                                                          \n");
			sbSql.append("                                ,ST_UPJANG B                                                                                                           \n");
			sbSql.append("                                ,ST_CUST C                                                                                                             \n");
			sbSql.append("                           WHERE A.UPJANG = B.UPJANG                                                                                                   \n");
			sbSql.append("                             AND A.UPJANGNM_DISP = B.UPJANGNM                                                                                          \n");
			sbSql.append("                             AND B.CUSTCD = C.CUSTCD                                                                                                   \n");
			sbSql.append("                             AND A.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND C.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND A.PART_SALES_SABUN = '" + ds_Cond.getString(0, "SABUN") + "'                                                          \n");
			sbSql.append("                         ) B                                                                                                                           \n");
			sbSql.append("                   WHERE A.UPJANG(+) = B.UPJANG                                                                                                        \n");
			sbSql.append("                     AND SUBSTR(A.SALE_DATE(+), 1, 4) = '" + g_Yy + "'	                                                                             \n");
			sbSql.append("                     AND A.TRANS_YN(+) = 'Y'                                                                                                           \n");
			sbSql.append("                     AND A.SALE_TYPE(+) = '1301'                                                                                                       \n");
			sbSql.append("                ) A                                                                                                                                    \n");
			sbSql.append("          GROUP BY UPJANG, UPJANGNM_DISP, CC_CD                                                                                                        \n");
			sbSql.append("        ) A                                                                                                                                            \n");
			sbSql.append("       ,(                                                                                                                                              \n");
			sbSql.append("         SELECT *                                                                                                                                      \n");
			sbSql.append("           FROM MAP_MON_PLAN2                                                                                                                          \n");
			sbSql.append("          WHERE YY = '" + g_Yy + "'			                                                                 										 \n");
			sbSql.append("            AND UPJANG IN (                                                                                                                            \n");
			sbSql.append("                          SELECT A.UPJANG                                                                                                              \n");
			sbSql.append("                            FROM FMS_UPJANG A                                                                                                          \n");
			sbSql.append("                                ,ST_UPJANG B                                                                                                           \n");
			sbSql.append("                                ,ST_CUST C                                                                                                             \n");
			sbSql.append("                           WHERE A.UPJANG = B.UPJANG                                                                                                   \n");
			sbSql.append("                             AND A.UPJANGNM_DISP = B.UPJANGNM                                                                                          \n");
			sbSql.append("                             AND B.CUSTCD = C.CUSTCD                                                                                                   \n");
			sbSql.append("                             AND A.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND C.USE_YN = 'Y'                                                                                                        \n");
			sbSql.append("                             AND A.PART_SALES_SABUN = '" + ds_Cond.getString(0, "SABUN") + "'                                                          \n");
			sbSql.append("                          )                                                                                                                            \n");
			sbSql.append("        ) B                                                                                                                                            \n");
			sbSql.append("  WHERE A.UPJANG = B.UPJANG(+)                                                                                                                         \n");
			sbSql.append("    AND A.ACCT_CD = B.ACCT_CD(+)                                                                                                                       \n");
			sbSql.append("  GROUP BY A.UPJANG, A.UPJANGNM_DISP, A.ACCT_CD, A.ACCT_NM, A.ACCT_CLASS, B.ACCT_CD, A.CC_CD                                                           \n");
			sbSql.append("  )      																													 							 \n");
			sbSql.append("  ORDER BY UPJANG, ACCT_CD, CC_CD      																												 \n");
		}else{
			// BPC에서 전송받은 BPC 최종PL이 있을때
			if(!"0".equals(isData4) && "1".equals(isData5) ){
			//if(!"0".equals(isData4) ){
				sbSql.delete(0, sbSql.length());
				sbSql.append(" SELECT A.UPJANG, A.CC_CD, B.UPJANGNM, A.ACCT_CD, A.ACCT_NM, DECODE(ACCT_CD, '41201010', '매출액', '42201010', '재료비', '43216050', '경비', '44000000', '매출이익') ACCT_CLASS,  '" + g_Yy + "' || '년_BPC수정' AS CLASS	 \n");
				sbSql.append("        ,(                                                                                 													            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_01 / 1000), 0) + NVL(ROUND(MM_AMT_02 / 1000), 0) + NVL(ROUND(MM_AMT_03 / 1000), 0) + 								            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_04 / 1000), 0) + NVL(ROUND(MM_AMT_05 / 1000), 0) + NVL(ROUND(MM_AMT_06 / 1000), 0) + 								            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_07 / 1000), 0) + NVL(ROUND(MM_AMT_08 / 1000), 0) + NVL(ROUND(MM_AMT_09 / 1000), 0) + 								            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_10 / 1000), 0) + NVL(ROUND(MM_AMT_11 / 1000), 0) + NVL(ROUND(MM_AMT_12 / 1000), 0)   								            \n");
				sbSql.append("         ) SUM_AMT,                                                                         													                      \n");
				sbSql.append("           NVL(ROUND(MM_AMT_01 / 1000), 0) MM_AMT_01, NVL(ROUND(MM_AMT_02 / 1000), 0) MM_AMT_02, NVL(ROUND(MM_AMT_03 / 1000), 0) MM_AMT_03, \n");	
				sbSql.append("           NVL(ROUND(MM_AMT_04 / 1000), 0) MM_AMT_04, NVL(ROUND(MM_AMT_05 / 1000), 0) MM_AMT_05, NVL(ROUND(MM_AMT_06 / 1000), 0) MM_AMT_06, \n");	
				sbSql.append("           NVL(ROUND(MM_AMT_07 / 1000), 0) MM_AMT_07, NVL(ROUND(MM_AMT_08 / 1000), 0) MM_AMT_08, NVL(ROUND(MM_AMT_09 / 1000), 0) MM_AMT_09, \n");	
				sbSql.append("           NVL(ROUND(MM_AMT_10 / 1000), 0) MM_AMT_10, NVL(ROUND(MM_AMT_11 / 1000), 0) MM_AMT_11, NVL(ROUND(MM_AMT_12 / 1000), 0) MM_AMT_12  \n");
				sbSql.append("    FROM MAP_BPC_CONFIRM_PL_INFO A                                                                    									  \n");
				sbSql.append("        ,ST_UPJANG B                                                                                                                        \n");
				sbSql.append("   WHERE A.UPJANG = B.UPJANG                                                                                                                \n");
				sbSql.append("     AND PLAN_CLASS = 'AP'                                                                                                                  \n");
				sbSql.append("     AND A.VER_CD = '" + nullToBlank(ds_Cond.getString(0, "VER_CD")) + "'                    										  		  \n");
				sbSql.append("     AND A.PLAN_YEAR = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                    									 	  \n");
				sbSql.append("     AND A.UPJANG != '" + 100000 + "'                    												  									  \n");
				sbSql.append("     AND A.UPJANG IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG                         \n");                                                                           
				sbSql.append("                         AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'   				  \n");
				sbSql.append("                         AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  									  \n");
				sbSql.append("   ORDER BY A.UPJANG, A.ACCT_CD, A.CC_CD                                                                                                    \n");
											
			}else{
				// BPC에서 전송받은 BPC 최종PL이 없을때
				sbSql.delete(0, sbSql.length());
				sbSql.append(" SELECT A.UPJANG, A.CC_CD, B.UPJANGNM, A.ACCT_CD, A.ACCT_NM, A.ACCT_CLASS,  '" + g_Yy + "' || '년_계획' AS CLASS										            \n");
				sbSql.append("        ,(                                                                                 													            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_01 / 1000), 0) + NVL(ROUND(MM_AMT_02 / 1000), 0) + NVL(ROUND(MM_AMT_03 / 1000), 0) + 								            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_04 / 1000), 0) + NVL(ROUND(MM_AMT_05 / 1000), 0) + NVL(ROUND(MM_AMT_06 / 1000), 0) + 								            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_07 / 1000), 0) + NVL(ROUND(MM_AMT_08 / 1000), 0) + NVL(ROUND(MM_AMT_09 / 1000), 0) + 								            \n");
				sbSql.append("           NVL(ROUND(MM_AMT_10 / 1000), 0) + NVL(ROUND(MM_AMT_11 / 1000), 0) + NVL(ROUND(MM_AMT_12 / 1000), 0)   								            \n");
				sbSql.append("         ) SUM_AMT,                                                                         													                      \n");
				sbSql.append("           NVL(ROUND(MM_AMT_01 / 1000), 0) MM_AMT_01, NVL(ROUND(MM_AMT_02 / 1000), 0) MM_AMT_02, NVL(ROUND(MM_AMT_03 / 1000), 0) MM_AMT_03, \n");	
				sbSql.append("           NVL(ROUND(MM_AMT_04 / 1000), 0) MM_AMT_04, NVL(ROUND(MM_AMT_05 / 1000), 0) MM_AMT_05, NVL(ROUND(MM_AMT_06 / 1000), 0) MM_AMT_06, \n");	
				sbSql.append("           NVL(ROUND(MM_AMT_07 / 1000), 0) MM_AMT_07, NVL(ROUND(MM_AMT_08 / 1000), 0) MM_AMT_08, NVL(ROUND(MM_AMT_09 / 1000), 0) MM_AMT_09, \n");	
				sbSql.append("           NVL(ROUND(MM_AMT_10 / 1000), 0) MM_AMT_10, NVL(ROUND(MM_AMT_11 / 1000), 0) MM_AMT_11, NVL(ROUND(MM_AMT_12 / 1000), 0) MM_AMT_12, \n");
				sbSql.append("           MM_IMPROV_AMT_01, MM_IMPROV_AMT_02, MM_IMPROV_AMT_03, MM_IMPROV_AMT_04, MM_IMPROV_AMT_05, MM_IMPROV_AMT_06,                      \n");
				sbSql.append("           MM_IMPROV_AMT_07, MM_IMPROV_AMT_08, MM_IMPROV_AMT_09, MM_IMPROV_AMT_10, MM_IMPROV_AMT_11, MM_IMPROV_AMT_12                       \n");
				sbSql.append("    FROM MAP_BIZ_PLAN2 A                                                                    												  \n");
				sbSql.append("        ,ST_UPJANG B                                                                                                                        \n");
				sbSql.append("        ,(                                                                                                                                  \n");
				sbSql.append("         SELECT T1.UPJANG, T1.IMPROV_YEAR AS YY, T2.ACCT_CD, T2.CC_CD                                                                       \n");
				/*
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_01 / 1000), 0) AS MM_IMPROV_AMT_01	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_02 / 1000), 0) AS MM_IMPROV_AMT_02	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_03 / 1000), 0) AS MM_IMPROV_AMT_03	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_04 / 1000), 0) AS MM_IMPROV_AMT_04	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_05 / 1000), 0) AS MM_IMPROV_AMT_05	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_06 / 1000), 0) AS MM_IMPROV_AMT_06	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_07 / 1000), 0) AS MM_IMPROV_AMT_07	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_08 / 1000), 0) AS MM_IMPROV_AMT_08	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_09 / 1000), 0) AS MM_IMPROV_AMT_09	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_10 / 1000), 0) AS MM_IMPROV_AMT_10	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_11 / 1000), 0) AS MM_IMPROV_AMT_11	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_12 / 1000), 0) AS MM_IMPROV_AMT_12	                                                              \n");
				*/
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_01), 0) AS MM_IMPROV_AMT_01	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_02), 0) AS MM_IMPROV_AMT_02	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_03), 0) AS MM_IMPROV_AMT_03	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_04), 0) AS MM_IMPROV_AMT_04	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_05), 0) AS MM_IMPROV_AMT_05	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_06), 0) AS MM_IMPROV_AMT_06	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_07), 0) AS MM_IMPROV_AMT_07	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_08), 0) AS MM_IMPROV_AMT_08	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_09), 0) AS MM_IMPROV_AMT_09	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_10), 0) AS MM_IMPROV_AMT_10	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_11), 0) AS MM_IMPROV_AMT_11	                                                              \n");
				sbSql.append("               ,NVL(ROUND(T2.MM_IMPROV_AMT_12), 0) AS MM_IMPROV_AMT_12	                                                              \n");
				sbSql.append("           FROM MAP_IMPROV_MGT_MST T1													                                                      \n");
				sbSql.append("               ,MAP_IMPROV_PL_DTL  T2														                                                  \n");
				sbSql.append("          WHERE  T1.IMPROV_YEAR    = T2.IMPROV_YEAR						                                                                  \n");
				sbSql.append("            AND T1.UPJANG           = T2.UPJANG								                                                              \n");
				sbSql.append("            AND T1.IMPROV_MGRP      = T2.IMPROV_MGRP						                                                                  \n");
				sbSql.append("            AND T1.IMPROV_MCALSS    = T2.IMPROV_MCALSS					                                                                  \n");
				sbSql.append("            AND T1.IMPROV_SCLASS    = T2.IMPROV_SCLASS					                                                                  \n");
				sbSql.append("            AND T1.IMPROV_THEME_SEQ = T2.IMPROV_THEME_SEQ			                                                                          \n");
				sbSql.append("            AND T1.REV_SEQ          = T2.REV_SEQ								                                                              \n");
				sbSql.append("            AND T1.APPROV_YN != 'Y'															                                              \n");
				//sbSql.append("            AND T2.CC_CD IN ('" + nullToBlank(ds_CcCd.getString(0, "CC_CD")) + "', '" + nullToBlank(ds_CcCd.getString(1, "CC_CD")) + "', '" + nullToBlank(ds_CcCd.getString(2, "CC_CD")) + "')    \n");
				sbSql.append("     		  AND T2.UPJANG IN (SELECT DISTINCT B.UPJANG FROM FMS_UPJANG A, ST_UPJANG B, ST_CUST C  WHERE A.UPJANG = B.UPJANG                         \n");                                                                           
				sbSql.append("                                AND A.UPJANGNM_DISP = B.UPJANGNM AND B.CUSTCD = C.CUSTCD AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'   				  \n");
				sbSql.append("                                AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "')  									  \n");
				sbSql.append("            AND '" + nullToBlank(ds_Cond.getString(0, "INPUT_YMD")) + "' BETWEEN T1.APPLY_ST_DT AND T1.APPLY_ND_DT                          \n");
				sbSql.append("         ) C                                                                                                                                \n");
				sbSql.append("   WHERE A.UPJANG = B.UPJANG                                                                                                                \n");
				sbSql.append("     AND A.UPJANG = C.UPJANG(+)                                                                                                             \n");
				sbSql.append("     AND A.ACCT_CD = C.ACCT_CD(+)                                                                                                           \n");
				sbSql.append("     AND A.BIZ_CLASS = '" + nullToBlank(ds_Cond.getString(0, "BIZ_CLASS")) + "'                    										  \n");
				sbSql.append("     AND A.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "TM_CD")) + "'                    												  \n");
				sbSql.append("     AND A.SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "'                    												  \n");
				sbSql.append("     AND A.YY = '" + nullToBlank(ds_Cond.getString(0, "INPUT_YY")) + "'                    												  \n");
				sbSql.append("   ORDER BY A.UPJANG, A.ACCT_CD, A.CC_CD                                                                                                    \n");											
			}	
		}	
		
		out_vl.add("fa_Sql", sbSql.toString());
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