<%
/*-----------------------------------------------------------------------------
■ 시스템명     :
■ 프로그램ID   : SCC99998E_T001.jsp
■ 프로그램명   : 진척률 조회
■ 작성일자     : 2015-01-18
■ 작성자       : 박용대
■ 이력관리     : 2015-01-18 최초작성
-----------------------------------------------------------------------------*/
%>
<%@page import="com.sz.util.AppDataUtility,  com.ifis.sc.scc.CommonUtil"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    //리퀘스트 객체
    PlatformRequest platformRequest = this.proc_input(request);

    in_vl = platformRequest.getData().getVariableList();
    in_dl = platformRequest.getData().getDataSetList();

    //입력 데이타셋
    DataSet ds_cond   	= in_dl.get("inDs_Cond");

    //입력 데이타셋 값 설정
    String devName 		= nullToBlank(ds_cond.getString(0, "DEV_NAME"));
    String devDate 		= nullToBlank(ds_cond.getString(0, "DEV_SCRT_EDATE"));
    String devChk 		= nullToBlank(ds_cond.getString(0, "DEV_SCRT_YN"));
    String devTstDate	= nullToBlank(ds_cond.getString(0, "DEV_TEST_DATE"));
    String devTstYn		= nullToBlank(ds_cond.getString(0, "DEV_TEST_YN"));
    String itoName	 	= nullToBlank(ds_cond.getString(0, "ITO_NAME"));
    String itoDate 		= nullToBlank(ds_cond.getString(0, "ITO_TEST_DATE"));
    String itoChk 		= nullToBlank(ds_cond.getString(0, "ITO_CHK_YN"));
    String itoName2	 	= nullToBlank(ds_cond.getString(0, "ITO_NAME2"));
    String itoDate2 	= nullToBlank(ds_cond.getString(0, "ITO_TEST_DATE2"));
    String itoChk2 		= nullToBlank(ds_cond.getString(0, "ITO_CHK_YN2"));
    String piName 		= nullToBlank(ds_cond.getString(0, "PI_NAME"));
    String piDate 		= nullToBlank(ds_cond.getString(0, "PI_TEST_DATE"));
    String piChk 		= nullToBlank(ds_cond.getString(0, "PI_CHK_YN"));
    String programNm	= nullToBlank(ds_cond.getString(0, "PROGRAM_NAME"));
    String programId	= nullToBlank(ds_cond.getString(0, "PROGRAM"));
    String prefix		= nullToBlank(ds_cond.getString(0, "PREFIX"));
    String gubun		= nullToBlank(ds_cond.getString(0, "GUBUN"));
    String subGubun		= nullToBlank(ds_cond.getString(0, "SUB_GUBUN"));
    String delYn        = nullToBlank(ds_cond.getString(0, "DEL_YN"));

    //테스트 출력
    //System.out.println("======================");
    System.out.println(subGubun +"/"+ gubun +"/"+ devChk);
    //System.out.println("======================");

    //FileLog.println("d:\\aaa.txt", ds_cond);

    try
    {
        //out 데이타
        DataSet ds_list;
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

        //sql문
        sbSql.append("\n\n");
        sbSql.append("SELECT A.SEQ ,            \n");
        sbSql.append("       A.PREFIX ,         \n");
        sbSql.append("       A.PROGRAM ,        \n");
        sbSql.append("       A.MENU_NAME ,      \n");
        sbSql.append("       A.PROGRAM_NAME ,   \n");
        sbSql.append("       A.WINDOW_SIZE ,    \n");
        sbSql.append("       A.MENU_TYPE ,      \n");
        sbSql.append("       A.DEV_REF ,        \n");
        sbSql.append("       A.DEV_ERROR ,      \n");
        sbSql.append("       A.DEV_NAME ,       \n");
        sbSql.append("       A.DEV_SCR_YN ,     \n");
        sbSql.append("       A.DEV_SCR_EDATE ,  \n");
        sbSql.append("       A.DEV_SCRT_YN ,    \n");
        sbSql.append("       A.DEV_SCRT_SDATE , \n");
        sbSql.append("       A.DEV_SCRT_EDATE , \n");
        sbSql.append("       A.DEV_TEST_DATE ,  \n");
        sbSql.append("       A.DEV_TEST_YN ,    \n");
        sbSql.append("       A.ITO_NAME ,       \n");
        sbSql.append("       A.ITO_TEST_DATE ,  \n");
        sbSql.append("       A.ITO_CHK_YN ,     \n");
        sbSql.append("       A.ITO_NAME2 ,       \n");
        sbSql.append("       A.ITO_TEST_DATE2 ,  \n");
        sbSql.append("       A.ITO_CHK_YN2 ,     \n");
        sbSql.append("       A.ITO_ERROR ,      \n");
        sbSql.append("       A.PI_NAME ,        \n");
        sbSql.append("       A.PI_TEST_DATE ,   \n");
        sbSql.append("       A.PI_CHK_YN ,      \n");
        sbSql.append("       A.GUBUN ,      \n");
        sbSql.append("       A.SUB_GUBUN ,      \n");
        sbSql.append("       A.DEV_PLAN_SDATE ,      \n");
        sbSql.append("       A.DEV_PLAN_EDATE ,      \n");
        sbSql.append("       A.DEL_YN ,      \n");
        sbSql.append("       A.PI_ERROR         \n");
        sbSql.append("  FROM SCC_PROGRESS_YD A  \n");
        sbSql.append("  WHERE 1=1             \n");

        if(!devName.equals("")){
        sbSql.append(" AND A.DEV_NAME = '"+devName.toString()+"'      \n");}
        if(!devDate.equals("")){
            sbSql.append(" AND DEV_SCRT_EDATE = '"+devDate.toString()+"'      \n");}
        if(!devChk.equals("")){
            sbSql.append(" AND A.DEV_SCRT_YN = '"+devChk.toString()+"'      \n"); }
        if(!devTstDate.equals("")){
            sbSql.append(" AND A.DEV_TEST_DATE = '"+devTstDate.toString()+"'      \n"); }
        if(!devTstYn.equals("")){
            sbSql.append(" AND A.DEV_TEST_YN = '"+devTstYn.toString()+"'      \n"); }
        if(!itoName.equals("")){
            sbSql.append(" AND A.ITO_NAME = '"+itoName.toString()+"'      \n");}
        if(!itoDate.equals("")){
            sbSql.append(" AND A.ITO_TEST_DATE = '"+itoDate.toString()+"'      \n");}
        if(!itoChk.equals("")){
            sbSql.append(" AND A.ITO_CHK_YN = '"+itoChk.toString()+"'      \n");}
        if(!itoName2.equals("")){
            sbSql.append(" AND A.ITO_NAME2 = '"+itoName2.toString()+"'      \n");}
        if(!itoDate2.equals("")){
            sbSql.append(" AND A.ITO_TEST_DATE2 = '"+itoDate2.toString()+"'      \n");}
        if(!itoChk2.equals("")){
            sbSql.append(" AND A.ITO_CHK_YN2 = '"+itoChk2.toString()+"'      \n");}
        if(!piName.equals("")){
            sbSql.append(" AND (EXISTS (SELECT 1 FROM SCC_PROGRESS_LST WHERE MAIN_SEQ = A.SEQ AND USER_NAME LIKE \'"+piName.toString()+"%\')      \n");
            sbSql.append("  OR A.PI_NAME = '"+piName.toString()+"')      \n");}
        if(!piDate.equals("")){
            sbSql.append(" AND A.PI_TEST_DATE = '"+piDate.toString()+"'      \n");}
        if(!piChk.equals("")){
            sbSql.append(" AND A.PI_CHK_YN = '"+piChk.toString()+"'      \n");}
        if(!programNm.equals("")){
            sbSql.append(" AND A.PROGRAM_NAME LIKE '%"+programNm.toString()+"%'      \n");}
        if(!programId.equals("")){
            sbSql.append(" AND A.PROGRAM LIKE '%"+programId.toString()+"%'      \n");}
        if(!prefix.equals("")){
            sbSql.append(" AND A.PREFIX LIKE '%"+prefix.toString()+"%'      \n");}
        if(!gubun.equals("")){
            sbSql.append(" AND A.GUBUN = '"+gubun.toString()+"'      \n");}
        if(!subGubun.equals("")){
            sbSql.append(" AND A.SUB_GUBUN = '"+subGubun.toString()+"'      \n");}

        if(!delYn.equals("Y")){
            sbSql.append(" AND A.DEL_YN = 'N'      \n");}

        sbSql.append("  ORDER BY A.SEQ             \n");

        //출력 파라미터 셋팅
        //out_vl.addStr("fa_Sql", sbSql.toString());

        //쿼리문 실행
        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();

        //Result set으로 부터 데이터셋 생성
        ds_list = this.makeDataSet(rs, "ds_List");

        pstmt.close();
        rs.close();


        //out 데이타
        DataSet ds_list1;

        //sql문
        sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT GUBUN                                                       AS GUBUN  \n");
        sbSql.append(" , SUB_GUBUN                                                       AS SUB_GUBUN  \n");
        sbSql.append(" , COUNT(1)                                                        AS TOT  \n");
        sbSql.append(" , SUM( CASE WHEN DEV_PLAN_EDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') THEN 1 ELSE 0 END ) AS DEV_PLAN  \n");
        sbSql.append(" , SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END )         AS DEV_COMP  \n");
        sbSql.append(" , SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END )         AS PL_COMP  \n");

        sbSql.append(" , CASE WHEN SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END ) = 0 THEN  \n");
        sbSql.append("       0  \n");
        sbSql.append("   ELSE  \n");
        sbSql.append("       ROUND( SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) / SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END ) * 100 )   \n");
        sbSql.append("   END AS PL_PERC    \n");
        sbSql.append(" , SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END )         AS PI_COMP    \n");
        sbSql.append(" , CASE WHEN SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) = 0 THEN  \n");
        sbSql.append("       0  \n");
        sbSql.append("   ELSE  \n");
        sbSql.append("       ROUND( SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END ) / SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) * 100 )   \n");
        sbSql.append("   END AS PI_PERC   \n");

        /* sbSql.append(" , ROUND( SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) / COUNT(1) * 100 ) AS PL_PERC  \n");
        sbSql.append(" , SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END )         AS PI_COMP  \n");
        sbSql.append(" , ROUND( SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END ) / COUNT(1) * 100 ) AS PI_PERC  \n"); */

        sbSql.append(" , CASE WHEN SUM( CASE WHEN DEV_PLAN_EDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') THEN 1 ELSE 0 END ) = 0 THEN 0 ELSE ROUND(((  \n");
        sbSql.append("	     SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END ) /  \n");
        sbSql.append("	     SUM( CASE WHEN DEV_PLAN_EDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') THEN 1 ELSE 0 END )   \n");
        sbSql.append("	 ) * 100), 1) END AS DEV_RATE  \n");
        sbSql.append("FROM SCC_PROGRESS_YD  \n");

        if(!delYn.equals("Y")){
            sbSql.append("WHERE DEL_YN = 'N'      \n");}

        sbSql.append("GROUP BY GUBUN, SUB_GUBUN  \n");
        sbSql.append("UNION ALL  \n");
        sbSql.append("SELECT ''                                                         AS GUBUN  \n");
        sbSql.append(", '합계'                                                          AS SUB_GUBUN  \n");
        sbSql.append(", COUNT(1)                                                        AS TOT  \n");
        sbSql.append(", SUM( CASE WHEN DEV_PLAN_EDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') THEN 1 ELSE 0 END ) AS DEV_PLAN  \n");
        sbSql.append(", SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END )        AS DEV_COMP  \n");
        sbSql.append(", SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END )        AS PL_COMP  \n");

        sbSql.append(", CASE WHEN SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END ) = 0 THEN  \n");
        sbSql.append("      0  \n");
        sbSql.append("  ELSE  \n");
        sbSql.append("      ROUND( SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) / SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END ) * 100 )   \n");
        sbSql.append("  END AS PL_PERC    \n");
        sbSql.append(", SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END )         AS PI_COMP    \n");
        sbSql.append(", CASE WHEN SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) = 0 THEN  \n");
        sbSql.append("      0  \n");
        sbSql.append("  ELSE  \n");
        sbSql.append("      ROUND( SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END ) / SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) * 100 )  \n");
        sbSql.append("  END AS PI_PERC    \n");

        /* sbSql.append(", ROUND( SUM( CASE WHEN ITO_CHK_YN  = '완료' THEN 1 ELSE 0 END ) / COUNT(1) * 100 ) AS PL_PERC  \n");
        sbSql.append(", SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END )         AS PI_COMP  \n");
        sbSql.append(", ROUND( SUM( CASE WHEN PI_CHK_YN   = '완료' THEN 1 ELSE 0 END ) / COUNT(1) * 100 )AS PI_PERC  \n"); */

        sbSql.append(", ROUND(((  \n");
        sbSql.append("	    SUM( CASE WHEN DEV_SCRT_YN = '완료' THEN 1 ELSE 0 END ) /  \n");
        sbSql.append("	    SUM( CASE WHEN DEV_PLAN_EDATE <= TO_CHAR(SYSDATE,'YYYYMMDD') THEN 1 ELSE 0 END )  \n");
        sbSql.append("	) * 100), 1) AS DEV_RATE   \n");
        sbSql.append("FROM SCC_PROGRESS_YD  \n");
        if(!delYn.equals("Y")){
            sbSql.append("WHERE DEL_YN = 'N'      \n");}
        sbSql.append("ORDER BY 1, 2  \n");

        sbSql.append("\n\n");
        /*sbSql.append("SELECT AA.TYPE, AA.CCC A, BB.SSS B, CC.FFF C FROM         \n");
        sbSql.append("(SELECT TYPE, A||'/'||round(A/885*100,1)||'%' CCC FROM   \n");
        sbSql.append("    (                                               \n");
        sbSql.append("        SELECT 'DEV' TYPE, COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE DEV_SCRT_YN = '완료' OR DEV_SCRT_YN = '미사용' \n");
        sbSql.append("        UNION ALL                                   \n");
        sbSql.append("        SELECT 'ITO' TYPE,COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE ITO_CHK_YN = '완료' OR DEV_SCRT_YN = '미사용' \n");
        sbSql.append("        UNION ALL                                   \n");
        sbSql.append("        SELECT 'PI' TYPE,COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE PI_CHK_YN = '완료' OR DEV_SCRT_YN = '미사용' \n");
        sbSql.append("    )                                               \n");
        sbSql.append(")AA,                                                \n");
        sbSql.append("(SELECT TYPE, A||'/'||round(A/885*100,1)||'%' SSS FROM   \n");
        sbSql.append("    (                                               \n");
        sbSql.append("        SELECT 'DEV' TYPE, COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE DEV_SCRT_YN = '반송'                  \n");
        sbSql.append("        UNION ALL                                   \n");
        sbSql.append("        SELECT 'ITO' TYPE,COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE ITO_CHK_YN = '반송'                   \n");
        sbSql.append("        UNION ALL                                   \n");
        sbSql.append("        SELECT 'PI' TYPE,COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE PI_CHK_YN = '반송'                    \n");
        sbSql.append("    )                                               \n");
        sbSql.append(")BB,                                                \n");
        sbSql.append("(SELECT TYPE, A||'/'||round(A/885*100,1)||'%' FFF FROM   \n");
        sbSql.append("    (                                               \n");
        sbSql.append("        SELECT 'DEV' TYPE, COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE DEV_SCRT_YN = '미완료'                \n");
        sbSql.append("        UNION ALL                                   \n");
        sbSql.append("        SELECT 'ITO' TYPE,COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE ITO_CHK_YN = '미완료'                 \n");
        sbSql.append("        UNION ALL                                   \n");
        sbSql.append("        SELECT 'PI' TYPE,COUNT(*) A FROM SCC_PROGRESS_YD \n");
        sbSql.append("        WHERE PI_CHK_YN = '미완료'                  \n");
        sbSql.append("    )                                               \n");
        sbSql.append(")CC                                                 \n");
        sbSql.append("WHERE 1=1                                           \n");
        sbSql.append("AND AA.TYPE=BB.TYPE                                 \n");
        sbSql.append("AND AA.TYPE=CC.TYPE                                 \n");
        sbSql.append("\n\n"); */

        pstmt = conn.prepareStatement(sbSql.toString());
        rs = pstmt.executeQuery();
        ds_list1 = this.makeDataSet(rs, "ds_List1");
        //Result set으로 부터 데이터셋 생성

        //출력 데이터 리스트에 데이터 셋 추가
        out_dl.add(ds_list);
        out_dl.add(ds_list1);



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