<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 사업계획관리
■ 프로그램ID   : MAP30110V_T001.jsp
■ 프로그램명   : 업장별 입력여부 조회
■ 작성일자     : 2015-07-09
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
		//입력 파라메터
		//String g_Upjang    	= nullToBlank(in_vl.getString("g_Upjang"));
		//String g_Yy     	= nullToBlank(in_vl.getString("g_Yy"));
		
		//구분에 따라 쿼리 분기.
		String g_MuCd			= nullToBlank(ds_Cond.getString(0, "MU_CD"));
		String g_TmCd			= nullToBlank(ds_Cond.getString(0, "TM_CD"));
		//String g_CcCd			= nullToBlank(ds_Cond.getString(0, "CC_CD"));
		//String g_Upjang			= nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String g_Yy				= nullToBlank(ds_Cond.getString(0, "YY"));
		String g_BizClass		= nullToBlank(ds_Cond.getString(0, "BIZ_CLASS"));
		/*
		System.out.println("g_MuCd===>"+g_MuCd);
		System.out.println("g_TmCd===>"+g_TmCd);
		System.out.println("g_CcCd===>"+g_CcCd);
		System.out.println("g_Upjang===>"+g_Upjang);
		System.out.println("g_Yy===>"+g_Yy);
		System.out.println("g_BizClass===>"+g_BizClass);
		*/
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		if("사업계획".equals(g_BizClass) || "월추정".equals(g_BizClass)){
			// 사업계획
			sbSql.delete(0, sbSql.length());
			sbSql.append("	SELECT B.UPJANGNM                                                     \n");
			sbSql.append("	      ,B.UPJANG                                                       \n");
			//sbSql.append("	      ,A.PLAN_YEAR AS YY                                              \n");
			sbSql.append("	      ,DECODE(A.PLAN_YEAR, NULL, '" + ds_Cond.getString(0, "YY") + "', A.PLAN_YEAR) AS YY  \n");
			
			if("사업계획".equals(g_BizClass)){
				sbSql.append("	      ,'사업계획' AS BIZ_CLASS                                    \n");
			}else{
				sbSql.append("	      ,'월추정' AS BIZ_CLASS                                      \n");
			}
			
			sbSql.append("	      ,DECODE(SUM(MM_AMT_01), NULL, '미입력', '입력') AS MM_AMT_01    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_02), NULL, '미입력', '입력') AS MM_AMT_02    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_03), NULL, '미입력', '입력') AS MM_AMT_03    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_04), NULL, '미입력', '입력') AS MM_AMT_04    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_05), NULL, '미입력', '입력') AS MM_AMT_05    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_06), NULL, '미입력', '입력') AS MM_AMT_06    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_07), NULL, '미입력', '입력') AS MM_AMT_07    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_08), NULL, '미입력', '입력') AS MM_AMT_08    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_09), NULL, '미입력', '입력') AS MM_AMT_09    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_10), NULL, '미입력', '입력') AS MM_AMT_10    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_11), NULL, '미입력', '입력') AS MM_AMT_11    \n");
			sbSql.append("	      ,DECODE(SUM(MM_AMT_12), NULL, '미입력', '입력') AS MM_AMT_12    \n");
			sbSql.append("	  FROM MAP_BPC_BIZ_PLAN_INFO A                                        \n");
			sbSql.append("	      ,SCO_UPJANG_MST_V B                                             \n");
			sbSql.append("	 WHERE B.CLOSE_DATE IS NULL                                           \n");
			sbSql.append("	   AND A.CC_CD(+) = B.CC_CD		                     				  \n");
			
			if("사업계획".equals(g_BizClass)){
				sbSql.append("	   AND A.PLAN_CLASS(+) = 'AP'                                     \n");
			}else{
				sbSql.append("	   AND A.PLAN_CLASS(+) = 'MP'                                     \n");
			}	
			
			sbSql.append("	   AND A.PLAN_YEAR(+) = '" + ds_Cond.getString(0, "YY") + "'    	  \n");
			
			if(!"".equals(g_MuCd)){
				sbSql.append(" AND B.MU_CD = '" + ds_Cond.getString(0, "MU_CD") + "'           	  \n");	
			}
			if(!"".equals(g_TmCd)){
				sbSql.append(" AND B.TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'           	  \n");	
			}
			
			/*
			if(!"".equals(g_CcCd)){
				sbSql.append(" AND A.CC_CD = '" + ds_Cond.getString(0, "CC_CD") + "'           	  \n");	
			}
			*/
			if("사업계획".equals(g_BizClass)){
				sbSql.append("	 GROUP BY B.UPJANGNM, B.UPJANG, A.PLAN_YEAR, '사업계획', A.CC_CD  \n");
			}else{
				sbSql.append("	 GROUP BY B.UPJANGNM, B.UPJANG, A.PLAN_YEAR, '월추정', A.CC_CD    \n");
			}	
		// 일추정, 일계획
		}else{
			sbSql.append("    SELECT UPJANGNM                                                                  \n"); 
			sbSql.append("          ,UPJANG                                                                    \n");
			sbSql.append("	        ,DECODE(YY, NULL, '" + ds_Cond.getString(0, "YY") + "', YY) AS YY  		   \n");
			sbSql.append("          ,BIZ_CLASS                                                                 \n");
			sbSql.append("          ,(CASE WHEN MM IS NOT NULL AND MM = '01' AND (DD_AMT != '0') THEN '입력'   \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_01                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '02' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_02                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '03' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_03                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '04' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_04                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '05' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_05                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '06' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_06                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '07' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_07                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '08' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_08                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '09' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_09                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '10' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_10                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '11' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_11                                                               \n");
			sbSql.append("           ,(CASE WHEN MM IS NOT NULL AND MM = '12' AND (DD_AMT != '0') THEN '입력'  \n");
			sbSql.append("            ELSE '미입력'                                                            \n");
			sbSql.append("             END                                                                     \n");
			sbSql.append("           ) MM_AMT_12                                                               \n");
			sbSql.append("      FROM (                                                                         \n");
			sbSql.append("            SELECT B.UPJANGNM                                                        \n");
			sbSql.append("                  ,B.UPJANG                                                          \n");
			sbSql.append("                  ,A.YY                                                              \n");
			sbSql.append("                  ,A.MM                                                              \n");
			
			if("일계획".equals(g_BizClass)){
				sbSql.append("              ,'일계획' AS BIZ_CLASS                                             \n");
			}else{
				sbSql.append("              ,'일추정' AS BIZ_CLASS                                             \n");
			}	
			
			sbSql.append("                  ,SUM(DD_AMT) DD_AMT                                                \n");
			sbSql.append("              FROM MAP_DAY_PLAN A                                                    \n");
			sbSql.append("                  ,SCO_UPJANG_MST_V B                                                \n");
			sbSql.append("             WHERE A.UPJANG(+) = B.UPJANG                                            \n");
			sbSql.append("               AND A.YY(+) = '" + ds_Cond.getString(0, "YY") + "'                    \n");
			
			if("일계획".equals(g_BizClass)){
				sbSql.append("           AND A.DAY_CLASS(+) = 'P'                                              \n");
			}else{
				sbSql.append("           AND A.DAY_CLASS(+) = 'R'                                              \n");
			}
			
			if(!"".equals(g_MuCd)){
				sbSql.append(" AND B.MU_CD = '" + ds_Cond.getString(0, "MU_CD") + "'           	  \n");	
			}
			if(!"".equals(g_TmCd)){
				sbSql.append(" AND B.TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'           	  \n");	
			}
			//sbSql.append(" 	   			 AND B.MU_CD = '" + ds_Cond.getString(0, "MU_CD") + "'           	  \n");
			//sbSql.append(" 	   			 AND B.TM_CD = '" + ds_Cond.getString(0, "TM_CD") + "'           	  \n");
			/*
			if(!"".equals(g_Upjang)){
				sbSql.append(" 			 AND A.UPJANG = '" + ds_Cond.getString(0, "UPJANG") + "'           	  \n");	
			}
			*/
			if("일계획".equals(g_BizClass)){
				sbSql.append("         GROUP BY B.UPJANGNM, B.UPJANG, A.YY, A.MM, '일계획'                     \n");
			}else{
				sbSql.append("         GROUP BY B.UPJANGNM, B.UPJANG, A.YY, A.MM, '일추정'                     \n");
			}
			sbSql.append("           )                                                                         \n");			
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