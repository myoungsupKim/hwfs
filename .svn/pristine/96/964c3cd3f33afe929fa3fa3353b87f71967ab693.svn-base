<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS식단/구매관리 / 즐겨찾기
■ 프로그램ID   : FSP90020E_S001.jsp
■ 프로그램명   : 즐겨찾기 그룹조회
■ 작성일자     : 2015-07-07
■ 작성자       : 정영철
■ 이력관리     : 2015-07-07 정영철 최초작성
-----------------------------------------------------------------------------*/
%>

<%@page import="oracle.jdbc.oracore.OracleType"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt            = null;
    PreparedStatement pstmt1  = null;
    PreparedStatement pstmt2  = null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_groupList = in_dl.get("ds_groupList");
        DataSet ds_cond      = in_dl.get("ds_cond");
        
        //입력 파라메터
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"    ));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"     ));
        
        String UPJANG       = nullToBlank(ds_cond.getString(0, "UPJANG"));
        
        //out 데이타
        DataSet ds_out; 
        
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        
        sbSql.append("INSERT INTO FSP_FAVORITE_GROUP(   \n");
        sbSql.append("       FAVOR_GROUP                \n");
        sbSql.append("     , UPJANG                     \n");
        sbSql.append("     , FAVOR_NAME                 \n");
        sbSql.append("     , SORT_SEQ                   \n");
        sbSql.append("     , FAVOR_TYPE                 \n");
        sbSql.append("     , CONTENTS                   \n");
        sbSql.append("     , REMARK                     \n");
        sbSql.append("     , CUSER                      \n");
        sbSql.append("     , CDATE                      \n");
        sbSql.append("     , UUSER                      \n");
        sbSql.append("     , UDATE                      \n");
        sbSql.append(" ) VALUES (                       \n");
        sbSql.append("  FSP_FAVORITE_GROUP_S.NEXTVAL    \n");
        sbSql.append(", ? \n");
        sbSql.append(", ? \n");
        sbSql.append(", ? \n");
        sbSql.append(", ? \n");
        sbSql.append(", ? \n");
        sbSql.append(", ? \n");
        sbSql.append(", ? \n");
        sbSql.append(", SYSDATE \n");
        sbSql.append(", ? \n");
        sbSql.append(", SYSDATE \n");
        sbSql.append(")   \n");
        
        String strGroupInsert = sbSql.toString();
        pstmt1 = conn.prepareStatement(strGroupInsert);

        sbSql.delete(0, sbSql.length());
        sbSql.append("UPDATE                            \n");
        sbSql.append("   FSP_FAVORITE_GROUP             \n");
        sbSql.append("SET                               \n");
        sbSql.append("     FAVOR_NAME = ?               \n");
        sbSql.append("   , SORT_SEQ   = ?               \n");
        sbSql.append("   , FAVOR_TYPE = ?               \n");
        sbSql.append("   , CONTENTS   = ?               \n");
        sbSql.append("   , REMARK     = ?               \n");
        sbSql.append("   , USE_YN     = ?               \n");
        sbSql.append("   , UUSER      = ?               \n");
        sbSql.append("   , UDATE      = SYSDATE         \n");
        sbSql.append("WHERE                             \n");
        sbSql.append("    FAVOR_GROUP = ?               \n");
        sbSql.append("    AND UPJANG  = ?               \n");
        
        String strGroupUpdate = sbSql.toString();
        pstmt2 = conn.prepareStatement(strGroupUpdate);
        
        int iInsertCnt = 0;
        int iUpdateCnt = 0;
        
        for(int i=0; i < ds_groupList.getRowCount(); i++)
        {
            // 입력
            if(ds_groupList.getRowType(i) == DataSet.ROW_TYPE_INSERTED)
            {
                pstmt1.setString(1, ds_groupList.getString(i,"UPJANG"));
                pstmt1.setString(2, ds_groupList.getString(i,"FAVOR_NAME"));
                pstmt1.setString(3, ds_groupList.getString(i,"SORT_SEQ"));
                pstmt1.setString(4, ds_groupList.getString(i,"FAVOR_TYPE"));
                pstmt1.setString(5, ds_groupList.getString(i,"CONTENTS"));
                pstmt1.setString(6, ds_groupList.getString(i,"REMARK"));
                pstmt1.setString(7, ds_groupList.getString(i,"CUSER"));
                pstmt1.setString(8, ds_groupList.getString(i,"UUSER"));
                
                pstmt1.addBatch();
                iInsertCnt++;
            }
            // 업데이트 
            else
            {                
                pstmt2.setString(1, ds_groupList.getString(i,"FAVOR_NAME"));
                pstmt2.setString(2, ds_groupList.getString(i,"SORT_SEQ"));
                pstmt2.setString(3, ds_groupList.getString(i,"FAVOR_TYPE"));
                pstmt2.setString(4, ds_groupList.getString(i,"CONTENTS"));
                pstmt2.setString(5, ds_groupList.getString(i,"REMARK"));
                pstmt2.setString(6, "Y");
                pstmt2.setString(7, ds_groupList.getString(i,"UUSER"));
                pstmt2.setString(8, ds_groupList.getString(i,"FAVOR_GROUP"));
                pstmt2.setString(9, ds_groupList.getString(i,"UPJANG"));
                pstmt2.addBatch();
                iUpdateCnt++;
            }
        }
        
         // 삭제("N"으로 업데이트)
        for (int i=0; i < ds_groupList.getRemovedRowCount(); i++)
        {
        	pstmt2.setString(1, ds_groupList.getRemovedStringData(i,"FAVOR_NAME"));
            pstmt2.setString(2, ds_groupList.getRemovedStringData(i,"SORT_SEQ"));
            pstmt2.setString(3, ds_groupList.getRemovedStringData(i,"FAVOR_TYPE"));
            pstmt2.setString(4, ds_groupList.getRemovedStringData(i,"CONTENTS"));
            pstmt2.setString(5, ds_groupList.getRemovedStringData(i,"REMARK"));
            pstmt2.setString(6, "N");
            pstmt2.setString(7, ds_groupList.getRemovedStringData(i,"UUSER"));
            pstmt2.setString(8, ds_groupList.getRemovedStringData(i,"FAVOR_GROUP"));
            pstmt2.setString(9, ds_groupList.getRemovedStringData(i,"UPJANG"));
            pstmt2.addBatch();
            iUpdateCnt++;
        	
        }
        
        if(iInsertCnt > 0) pstmt1.executeBatch();
        if(iUpdateCnt > 0) pstmt2.executeBatch();
        
        conn.commit();

        sbSql.delete(0, sbSql.length());
        sbSql.append("\n                                \n");
        sbSql.append("SELECT                            \n");
        sbSql.append("   FAVOR_GROUP AS FAVOR_GROUP     \n");
        sbSql.append("  , UPJANG AS UPJANG              \n");
        sbSql.append("  , FAVOR_NAME AS FAVOR_NAME      \n");
        sbSql.append("  , SORT_SEQ AS SORT_SEQ          \n");
        sbSql.append("  , FAVOR_TYPE AS FAVOR_TYPE      \n");
        sbSql.append("  , CONTENTS AS CONTENTS          \n");
        sbSql.append("  , REMARK AS REMARK              \n");
        sbSql.append("  , USE_YN AS USE_YN              \n");
        sbSql.append("  , CUSER AS CUSER                \n");
        sbSql.append("  , CDATE AS CDATE                \n");
        sbSql.append("  , UUSER AS UUSER                \n");
        sbSql.append("  , UDATE AS UDATE                \n");
        sbSql.append(" FROM FSP_FAVORITE_GROUP          \n");
        sbSql.append("WHERE UPJANG = " + UPJANG + "     \n");
        sbSql.append("  AND USE_YN = 'Y'                \n");
        sbSql.append("ORDER BY SORT_SEQ                 \n");
        sbSql.append("\n                                \n");

        stmt = conn.createStatement();      
        rs = stmt.executeQuery(sbSql.toString());
        
        ds_out = this.makeDataSet(rs,"ds_out");
        out_dl.add(ds_out);
        
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