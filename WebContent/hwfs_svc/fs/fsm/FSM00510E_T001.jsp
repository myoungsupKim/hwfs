<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FSM00510E_T001.jsp
■ 프로그램명   : 성심병원네임카드
■ 작성일자     : 2014-02-20
■ 작성자       : 박용대
■ 이력관리     : 2014-02-20 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);
	
	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();	//데이터셋 받는 객체
	
	//입력 데이타셋
	DataSet ds_cond   	= in_dl.get("inDs_Cond");
	
	//입력 데이타셋 값 설정
	String upjang 		= ds_cond.getString(0, "UPJANG");
	String hall 		= ds_cond.getString(0, "HALL");
	String needDate 	= ds_cond.getString(0, "DATE");
	
	//테스트 출력
	System.out.println("======================");
	System.out.println(upjang +"/"+ hall +"/"+ needDate);
	System.out.println("======================");
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
		sbSql.append("\n\n");
        sbSql.append("SELECT /*+ USE_HASH(B A) */                                                          \n");
        sbSql.append("       A.CORNER ,                                                                    \n");
        sbSql.append("       D.CODE_NAME AS CORNER_NAME,                                                   \n");
        sbSql.append("       A.MEAL ,                                                                      \n");
        sbSql.append("       C.CODE_NAME AS MEAL_NAME,                                                     \n");
        sbSql.append("       (rank() over (partition by a.corner, a.meal order by a.MAJOR_DISH_INFO )) as NO, \n");
        sbSql.append("       B.RECIPE_NAME                                                                 \n");
        sbSql.append("  FROM                                                                               \n");
        sbSql.append("       (                                                                             \n");
        sbSql.append("       SELECT (C.YMD||'-'||A.HALL_CD||A.MEAL||A.CORNER) AS MENU_CD,                  \n");
        sbSql.append("              C.YMD AS MENU_DATE,                                                    \n");
        sbSql.append("              A.UPJANG AS UPJANG,                                                    \n");
        sbSql.append("              A.HALL_CD AS HALL_CD,                                                  \n");
        sbSql.append("              A.MEAL AS MEAL,                                                        \n");
        sbSql.append("              A.CORNER AS CORNER,                                                    \n");
        sbSql.append("              B.CODE AS MAJOR_DISH_INFO,                                             \n");
        sbSql.append("              B.CODE_NAME AS MAJOR_DISH_INFO_NAME,                                   \n");
        sbSql.append("              NVL(D.EXPECT_MEAL_QTY,0) AS EXPECT_MEAL_QTY                            \n");
        sbSql.append("         FROM FSA_HALL_DTL A,                                                        \n");
        sbSql.append("              SCC_COMMON_CODE B,                                                     \n");
        sbSql.append("              SCC_COPY_YMD C,                                                        \n");
        sbSql.append("              FSM_REAL_MENU_MST D                                                    \n");
        sbSql.append("        WHERE A.UPJANG = '"+upjang.toString()+"'                                                    \n");
        sbSql.append("          AND A.HALL_CD = '"+hall.toString()+"'                                                    \n");
        sbSql.append("                   AND B.GROUP_CODE = 'FS0032'                                       \n");
        sbSql.append("          AND C.YMD       BETWEEN '"+needDate.toString()+"' AND '"+needDate.toString()+"'                          \n");
        sbSql.append("          AND A.UPJANG  = D.UPJANG                                                   \n");
        sbSql.append("          AND A.HALL_CD = D.HALL_CD                                                  \n");
        sbSql.append("          AND A.MEAL    = D.MEAL                                                     \n");
        sbSql.append("          AND A.CORNER  = D.CORNER                                                   \n");
        sbSql.append("          AND C.YMD     = D.MENU_DATE                                                \n");
        sbSql.append("          AND A.USE_YN  = 'Y'                                                        \n");
        sbSql.append("       ) A,                                                                          \n");
        sbSql.append("       (                                                                             \n");
        sbSql.append("       SELECT  MENU_CD ,                                                             \n");
        sbSql.append("            UPJANG ,                                                                 \n");
        sbSql.append("            MAJOR_DISH_INFO ,                                                        \n");
        sbSql.append("            RECIPE_CD,                                                               \n");
        sbSql.append("            RECIPE_NAME,                                                             \n");
        sbSql.append("            0 AS RECIPE_COST_PRICE                                                   \n");
        sbSql.append("               ,( SELECT   ORDER_YN AS RECIPE_ORDER_YN                               \n");
        sbSql.append("              FROM   FSM_REAL_RECIPE_ITEM X                                          \n");
        sbSql.append("             WHERE  X.MENU_CD=A.MENU_CD                                              \n");
        sbSql.append("               AND  X.RECIPE_CD=A.RECIPE_CD                                          \n");
        sbSql.append("               AND  X.UPJANG = '"+upjang.toString()+"'                               \n");
        sbSql.append("               AND  ROWNUM <=1) AS RECIPE_ORDER_YN                                   \n");
        sbSql.append("             FROM FSM_REAL_RECIPE_MST A                                              \n");
        sbSql.append("            WHERE A.UPJANG = '"+upjang.toString()+"'                                 \n");
        sbSql.append("           AND A.MENU_CD BETWEEN '"+needDate.toString()+"' AND '"+needDate.toString()+"' ||'9'                       \n");
        sbSql.append("       ) B,                                                                          \n");
        sbSql.append("       SCC_COMMON_CODE C,                                                            \n");
        sbSql.append("       SCC_COMMON_CODE D                                                             \n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG(+)                                                        \n");
        sbSql.append("   AND A.MENU_CD = B.MENU_CD(+)                                                      \n");
        sbSql.append("   AND A.MAJOR_DISH_INFO = B.MAJOR_DISH_INFO                                         \n");
        sbSql.append("   AND A.MEAL = C.CODE                                                               \n");
        sbSql.append("   AND A.CORNER = D.CODE                                                             \n");
        sbSql.append("   AND C.GROUP_CODE = 'FS0023'                                                       \n");
        sbSql.append("   AND D.GROUP_CODE = 'FS0022'                                                       \n");
        sbSql.append("ORDER BY A.CORNER, A.MEAL, A.MAJOR_DISH_INFO                                         \n");
	    sbSql.append("\n\n");
        
        //출력 파라미터 셋팅
		out_vl.add("fa_Sql", sbSql.toString());
		
		//쿼리문 실행
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set으로 부터 데이터셋 생성
		DataSet ds_List = this.makeDataSet(rs, "ds_List");
		
		//출력 데이터 리스트에 데이터 셋 추가 
		out_dl.add(ds_List);
		
		//출력 변수리스트에 메세지를 저장
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
