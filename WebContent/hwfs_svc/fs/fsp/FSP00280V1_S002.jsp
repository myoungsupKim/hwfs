<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/현황분석/자재구매패턴분석
■ 프로그램ID   : FSP00280V1_S002.jsp
■ 프로그램명   : 직군, 상세직군 조회
■ 작성일자     : 2015-07-01
■ 작성자       : 정영철
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		//기간별 상세내역 조회
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//입력 데이타
		DataSet ds_condi     	= in_dl.get("ds_condi");

		//입력 데이타
		String TYPE  = nullToBlank(ds_condi.getString(0, "TYPE"));
		String JOB_CD  = nullToBlank(ds_condi.getString(0, "JOB_CD"));

		//out 데이타
		DataSet ds_out;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //클리어

		// 직군코드
		if(TYPE.equals("SEARCH_JOP_CD"))
		{
			sbSql.append(" \n SELECT '000' AS JOB_CD"			);
			sbSql.append(" \n      , '전체' AS JOB_NAME"			);
			sbSql.append(" \n   FROM DUAL"						);
			sbSql.append(" \n  UNION ALL"						);
			sbSql.append(" \n SELECT JOB_CD, JOB_NAME"			);
			sbSql.append(" \n   FROM MAS_JOB"					);
			sbSql.append(" \n  ORDER BY JOB_CD"					);
		}
		// 상세직군코드
 		else if(TYPE.equals("SEARCH_SUB_JOP_CD"))
		{
 	        sbSql.append(" \n SELECT '000000' AS SUB_JOB_CD"	);
 	        sbSql.append(" \n      , '전체' AS SUB_JOB_NAME"		);
 	        sbSql.append(" \n FROM DUAL"						);
 	        sbSql.append(" \n UNION ALL"						);
 	        sbSql.append(" \n SELECT SUB_JOB_CD, SUB_JOB_NAME"	);
 	        sbSql.append(" \n   FROM MAS_JOB_SUB"				);
 	        if(!JOB_CD.equals("000"))
 	        	sbSql.append(" \n  WHERE JOB_CD = '" + JOB_CD + "'"	);
 	        sbSql.append(" ORDER BY SUB_JOB_CD"					);
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_out = this.makeDataSet(rs, "ds_out");

		/**종료**/
		out_dl.add(ds_out);
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}
	proc_output(response,out,out_vl,out_dl);
%>