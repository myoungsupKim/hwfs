<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS식단/구매관리 / 즐겨찾기
■ 프로그램ID   : FSP90020E_S001.jsp
■ 프로그램명   : 즐겨찾기 목록 저장
■ 작성일자     : 2015-07-07
■ 작성자       : 정영철
■ 이력관리     : 2015-07-07 정영철 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt            = null;
    PreparedStatement pstmt1  = null;
    PreparedStatement pstmt2  = null;
    PlatformRequest platformRequest = this.proc_input(request);
    in_vl = platformRequest.getData().getVariableList();
    in_dl = platformRequest.getData().getDataSetList();

    try {

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_favorite_list = in_dl.get("ds_favorite_list");
        
        //입력 파라메터
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"    ));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"     ));
        
        //out 데이타
        DataSet ds_out; 
        
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();

		sbSql.append("MERGE INTO FSP_FAVORITE A \n");
		sbSql.append("USING DUAL \n");
		sbSql.append("ON ( \n");
		sbSql.append("     A.UPJANG      = ? \n");
		sbSql.append("AND  A.FAVOR_GROUP = ? \n");
		sbSql.append("AND  A.ITEM_CODE   = ? \n");
		sbSql.append(")                           \n");
		sbSql.append("WHEN MATCHED THEN \n");
		sbSql.append("    UPDATE SET \n");
		sbSql.append("    A.USE_YN = 'Y' \n");
		sbSql.append("    ,A.UUSER  = '"+ g_EmpNo +"'              \n");
		sbSql.append("    ,A.UDATE  = SYSDATE \n");
		sbSql.append("WHEN NOT MATCHED THEN \n");
		sbSql.append("    INSERT ( \n");
		sbSql.append("         UPJANG, \n");
		sbSql.append("         FAVOR_GROUP, \n");
		sbSql.append("         ITEM_CODE, \n");
		sbSql.append("         USE_YN, \n");
		sbSql.append("         CUSER, \n");
		sbSql.append("         CDATE \n");
		sbSql.append("        ) VALUES ( \n");
		sbSql.append("         ? \n");
		sbSql.append("         ,? \n");
		sbSql.append("         ,? \n");
		sbSql.append("  ,'Y' \n");
		sbSql.append("  ,'"+ g_EmpNo +"'              \n");
		sbSql.append("  ,SYSDATE                  \n");
		sbSql.append(")                           \n");
        
        String strItemInsert = sbSql.toString();
        pstmt1 = conn.prepareStatement(strItemInsert);
        
        sbSql.delete(0,sbSql.length());
        sbSql.append("UPDATE FSP_FAVORITE A \n");
        sbSql.append("    SET \n");
        sbSql.append("    A.USE_YN = 'N' \n");
        sbSql.append("    ,A.UUSER  = '"+ g_EmpNo +"'              \n");
        sbSql.append("    ,A.UDATE  = SYSDATE \n");
        sbSql.append("WHERE 1=1                    \n");
        sbSql.append("AND UPJANG = ? \n");
        sbSql.append("AND FAVOR_GROUP = ? \n");
        sbSql.append("AND ITEM_CODE = ? \n");

        String strItemUpdate = sbSql.toString();
        pstmt2 = conn.prepareStatement(strItemUpdate);
        
        // 입력
        int iInsertCnt = 0;
        for(int i=0; i < ds_favorite_list.getRowCount(); i++)
        {
	         pstmt1.setString(1, ds_favorite_list.getString(i,"UPJANG"));
	         pstmt1.setString(2, ds_favorite_list.getString(i,"FAVOR_GROUP"));
	         pstmt1.setString(3, ds_favorite_list.getString(i,"ITEM_CODE"));
	         pstmt1.setString(4, ds_favorite_list.getString(i,"UPJANG"));
	         pstmt1.setString(5, ds_favorite_list.getString(i,"FAVOR_GROUP"));
	         pstmt1.setString(6, ds_favorite_list.getString(i,"ITEM_CODE"));

			pstmt1.addBatch();
			iInsertCnt++;
 		}
		
        // 삭제
        int iDeleteCnt = 0;
	 	for(int i=0; i < ds_favorite_list.getRemovedRowCount(); i++)
        {
	         pstmt2.setString(1, ds_favorite_list.getRemovedStringData(i,"UPJANG"));
	         pstmt2.setString(2, ds_favorite_list.getRemovedStringData(i,"FAVOR_GROUP"));
	         pstmt2.setString(3, ds_favorite_list.getRemovedStringData(i,"ITEM_CODE"));

 			pstmt2.addBatch();
			iDeleteCnt++;
         }
		
        if(iInsertCnt > 0) pstmt1.executeBatch();
        if(iDeleteCnt > 0) pstmt2.executeBatch();

        conn.commit();
        
        this.setResultMessage(0, "OK",out_vl);

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