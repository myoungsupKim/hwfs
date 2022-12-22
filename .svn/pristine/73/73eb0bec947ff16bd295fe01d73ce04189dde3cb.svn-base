<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS식단/구매관리 / 즐겨찾기
■ 프로그램ID   : FSP90020E_S001.jsp
■ 프로그램명   : 자재조회
■ 작성일자     : 2015-07-07
■ 작성자       : 정영철
■ 이력관리     : 2015-07-07 정영철 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
    Statement stmt             =  null;
    try {
        PlatformRequest platformRequest = this.proc_input(request);
        in_vl = platformRequest.getData().getVariableList();
        in_dl = platformRequest.getData().getDataSetList();

        //jsp log 서비스 시작
        logger.startIndividualLog(in_vl.getString("titLogId"));

        //입력 데이타
        DataSet ds_item_cond = in_dl.get("ds_item_cond");
        //입력 파라메터
        String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"    ));
        String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"     ));

        String MU_CD        = nullToBlank(ds_item_cond.getString(0, "MU_CD"         ));
        String TM_CD        = nullToBlank(ds_item_cond.getString(0, "TM_CD"         ));
        String UPJANG       = nullToBlank(ds_item_cond.getString(0, "UPJANG"        ));
        String SUBINV_CODE  = nullToBlank(ds_item_cond.getString(0, "SUBINV_CODE"   ));
        String ITEM_CLASS1  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS1"   ));
        String ITEM_CLASS2  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS2"   ));
        String ITEM_CLASS3  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS3"   ));
        String ITEM_CLASS4  = nullToBlank(ds_item_cond.getString(0, "ITEM_CLASS4"   ));
        String ITEM_CODE    = nullToBlank(ds_item_cond.getString(0, "ITEM_CODE"     ));

        //out 데이타
        DataSet ds_out;
        //sql문 버퍼생성
        StringBuffer sbSql = new StringBuffer();
        //내역조회
        sbSql.delete(0, sbSql.length());
        sbSql.append("\n                                                                                                                        \n");
        sbSql.append("SELECT A.ITEM_CODE            -- 상품코드                                                                                                \n");
        sbSql.append("     , A.ITEM_NAME            -- 상품명                                                                                                  \n");
        sbSql.append("     , A.ITEM_SIZE            -- 규격                                                                                                    \n");
        sbSql.append("     , A.ORIGIN_TYPE          -- 원산지타입                                                                                              \n");
        sbSql.append("     , A.ORIGIN_NAT           -- 원산지국가                                                                                              \n");
        sbSql.append("     , A.PO_UOM               -- 단위                                                                                                    \n");
        sbSql.append("     , B.CONTRACT_PRICE_M     -- 관리단가                                                                                                \n");
        sbSql.append("  FROM HLDC_PO_ITEM_MST A                                                                                                 \n");
        sbSql.append("     , HLDC_PO_CONTRACT_F B                                                                                               \n");
        sbSql.append("     , SCO_UPJANG_MST_V C                                                                                                 \n");
        sbSql.append(" WHERE A.ITEM_CODE        = B.ITEM_CODE                                                                                   \n");
        sbSql.append("   AND A.USE_YN           = 'Y'                                                                                           \n");
        sbSql.append("   AND B.UPJANG           = C.UPJANG                                                                                      \n");
        sbSql.append("   AND C.UPJANG           = "  + UPJANG      + "                                                                          \n");
        sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN B.CONTRACT_START AND NVL(B.CONTRACT_END, '99991231')                           \n");
        sbSql.append("   AND B.USE_YN           = 'Y'                                                                                           \n");
        sbSql.append("   AND B.CONTRACT_PRICE_M > 0                                                                                             \n");
        sbSql.append("   AND A.ITEM_CLASS1      = '" + ITEM_CLASS1 + "'                                                                         \n");
        if(!ITEM_CODE.equals(""))
        {   
        	//REGEXP_LIKE 함수의 변수값이 200자 넘으면 에러 발생 substr함수로 200자 제한 추가 김호석 CH201703_00107
			sbSql.append("   AND (REGEXP_LIKE(A.ITEM_NAME, (SELECT SUBSTR(TRIM(LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP)),0,200) AS ITEM_NAME \n");
			sbSql.append("             FROM																																		   \n");
			sbSql.append("      						  (SELECT REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|') AS ITEM_NAME									   \n");
			sbSql.append("      							      , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM DUAL																										   \n");
			sbSql.append("                                     UNION ALL																										   \n");
			sbSql.append("                                     --정규식에서 괄호가 한쪽만 있으면 에러 발생하기때문에 치환처리													   \n");
			sbSql.append("   		                                  SELECT REPLACE(REPLACE(REPLACE(KEYWORD||'|'||SIM_TXT, '(', ''), ')', ''), ' ', '|') AS ITEM_NAME			   \n");
			sbSql.append("                                          , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM EPROCUSR.VO_ITEM_SIM_WORD																					   \n");
			sbSql.append("                                      --유사어에 등록된 키워드는 일치검색으로 변경																	   \n");
			sbSql.append("                                      WHERE KEYWORD = REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|')									   \n");
			sbSql.append("                                    ) T																												   \n");
			sbSql.append("                              )																														   \n");	 
			sbSql.append("   			             )																															   \n");
			sbSql.append("   OR REGEXP_LIKE(A.ITEM_CODE, (SELECT SUBSTR(TRIM(LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP)),0,200) AS ITEM_NAME \n");
			sbSql.append("             FROM																																		   \n");
			sbSql.append("      						  (SELECT REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|') AS ITEM_NAME									   \n");
			sbSql.append("      							      , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM DUAL																										   \n");
			sbSql.append("                                     UNION ALL																										   \n");
			sbSql.append("                                     --정규식에서 괄호가 한쪽만 있으면 에러 발생하기때문에 치환처리													   \n");
			sbSql.append("   		                                  SELECT REPLACE(REPLACE(REPLACE(KEYWORD||'|'||SIM_TXT, '(', ''), ')', ''), ' ', '|') AS ITEM_NAME			   \n");
			sbSql.append("                                          , '1' AS ITEM_GROUP																							   \n");
			sbSql.append("                                       FROM EPROCUSR.VO_ITEM_SIM_WORD																					   \n");
			sbSql.append("                                      --유사어에 등록된 키워드는 일치검색으로 변경																	   \n");
			sbSql.append("                                      WHERE KEYWORD = REPLACE(REPLACE(REPLACE('" + ITEM_CODE + "', '(', '\\('), ')', '\\)'), ' ', '|')									   \n");
			sbSql.append("                                    ) T																												   \n");
			sbSql.append("                              )																														   \n");	 
			sbSql.append("   			             ))																															   \n");	
            /* sbSql.append("   AND (REGEXP_LIKE(A.ITEM_NAME, (SELECT LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME	\n");
            sbSql.append("                                   FROM 																								\n");
            sbSql.append("                                       (SELECT KEYWORD||'|'||SIM_TXT AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM EPROCUSR.VO_ITEM_SIM_WORD																\n");
            sbSql.append("                                         WHERE REGEXP_LIKE(KEYWORD, REPLACE('" + ITEM_CODE + "', ' ', '|'))							\n");
            sbSql.append("                                         UNION ALL																					\n");
            sbSql.append("                                        SELECT REPLACE('" + ITEM_CODE + "', ' ', '|') AS ITEM_NAME									\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM DUAL																					\n");
            sbSql.append("                                        ) T																							\n");
            sbSql.append("                                )																										\n");
            sbSql.append("                   )																													\n");
            
            sbSql.append("   OR REGEXP_LIKE(A.ITEM_CODE, (SELECT LISTAGG(REPLACE(T.ITEM_NAME, ',', '|'), '|') WITHIN GROUP(ORDER BY ITEM_GROUP) AS ITEM_NAME	\n");
            sbSql.append("                                   FROM 																								\n");
            sbSql.append("                                       (SELECT KEYWORD||'|'||SIM_TXT AS ITEM_NAME														\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM EPROCUSR.VO_ITEM_SIM_WORD																\n");
            sbSql.append("                                         WHERE REGEXP_LIKE(KEYWORD, REPLACE('" + ITEM_CODE + "', ' ', '|'))							\n");
            sbSql.append("                                         UNION ALL																					\n");
            sbSql.append("                                        SELECT REPLACE('" + ITEM_CODE + "', ' ', '|') AS ITEM_NAME									\n");
            sbSql.append("                                             , '1' AS ITEM_GROUP																		\n");
            sbSql.append("                                          FROM DUAL																					\n");
            sbSql.append("                                        ) T																							\n");
            sbSql.append("                                )																										\n");
            sbSql.append("                   ))																													\n"); */
        }
        else
        {
            if(!ITEM_CLASS2.equals(""))
                sbSql.append("   AND A.ITEM_CLASS2 = '" + ITEM_CLASS2 + "'                                                                      \n");
            if(!ITEM_CLASS3.equals(""))
                sbSql.append("   AND A.ITEM_CLASS3 = '" + ITEM_CLASS3 + "'                                                                      \n");
            if(!ITEM_CLASS4.equals(""))
                sbSql.append("   AND A.ITEM_CLASS4 = '" + ITEM_CLASS4 + "'                                                                      \n");
        }
        sbSql.append(" ORDER BY A.ITEM_NAME                   			                                                                        \n");
        sbSql.append("\n                                                                                                                        \n");

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