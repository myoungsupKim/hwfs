<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매관리/구매신청/구매신청내역 조회
■ 프로그램ID   : FSP00090V_S001.jsp
■ 프로그램명   : 구매신청내역 조회
■ 작성일자     : 2008-01-28
■ 작성자       : 김동표
■ 수정자       : 정영철
■ 이력관리     : 2015-06-03
1)고도화 수정내용 - 테이블명 수정
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
		DataSet ds_input = in_dl.get("ds_input");

		//입력 데이타
		String MU_CD   	   = nullToBlank(ds_input.getString(0, "MU_CD"));
		String TM_CD   	   = nullToBlank(ds_input.getString(0, "TM_CD"));
		String DATE_TYPE   = nullToBlank(ds_input.getString(0, "DATE_TYPE"));
		String START_DATE  = nullToBlank(ds_input.getString(0, "START_DATE"));
		String END_DATE    = nullToBlank(ds_input.getString(0, "END_DATE"));
		String UPJANG      = nullToBlank(ds_input.getString(0, "UPJANG"));
		String DEPT_TYPE   = nullToBlank(ds_input.getString(0, "DEPT_TYPE"));
		String PO_TYPE     = nullToBlank(ds_input.getString(0, "PO_TYPE"));

		//out 데이타
		DataSet ds_list;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());

		sbSql.append("\nSELECT  A.PO_NUM   AS PR_NUM                                                                        ");
		sbSql.append("\n      , A.PO_DATE  AS PR_DATE                                                                       ");
		sbSql.append("\n      , F.CC_NM AS TM_CC_NM                                                                         ");
		sbSql.append("\n      , A.ITEM_NAME||DECODE(SIGN(G.CNT - 1),1,' 외 '||TO_CHAR(G.CNT - 1)||'건') AS TITLE             ");
		sbSql.append("\n      , H.PO_TYPE                                                                                 ");
		sbSql.append("\n      , G.AMT                                                                                       ");
		sbSql.append("\n      , G.VAT                                                                                       ");
		sbSql.append("\n      , (G.AMT + G.VAT) AS TOT                                                                      ");
		sbSql.append("\n      , A.PO_SABUN ||' '||C.NM_KOR AS CUUSER                                                        ");
	    sbSql.append("\n      , (SELECT SABUN || ' ' || NM_KOR                                                              ");
	    sbSql.append("\n              FROM HR_PERSONAL                                                                      ");
	    sbSql.append("\n             WHERE SABUN = G.PR_SABUN) PR_SABUN                                                     ");
		sbSql.append("\n      , A.PR_DEPT_ID                                                                                ");
		sbSql.append("\n      , F.CC_NM AS RC_TM_CC_NM                                                                      ");
		sbSql.append("\n      , A.NEED_DATE                                                                                 ");
		sbSql.append("\n      , A.RC_DEPT_ID                                                                                ");
		sbSql.append("\n      , B.SUBINV_NAME                                                                               ");
		sbSql.append("\n      , A.LINE_STATUS                                                                               ");
		sbSql.append("\n  FROM HLDC_PO_PO A                                                                                 ");
		sbSql.append("\n     , HLDC_PO_SUBINVENTORY B                                                                       ");
		sbSql.append("\n     , HR_PERSONAL C                                                                                ");
		sbSql.append("\n     , ST_UPJANG D                                                                                  ");
		sbSql.append("\n     , HLDC_SC_DEPT_V E                                                                             ");
		sbSql.append("\n     , HLDC_SC_DEPT_V F                                                                             ");
		sbSql.append("\n     , (                                                                                            ");
		sbSql.append("\n        SELECT  PO_NUM                                                                              ");
		sbSql.append("\n              , MIN(IA.PO_ID ) AS PO_ID                                                             ");
		sbSql.append("\n              , COUNT(*) AS CNT                                                                     ");
		sbSql.append("\n              , SUM(IA.MARGIN_PRICE * IA.PO_QTY) AS AMT                                             ");
		sbSql.append("\n              , SUM(IA.MARGIN_PRICE * IA.PO_QTY * DECODE(IA.TAX_CODE,100,0.1,0)) AS VAT             ");
		sbSql.append("\n              , MAX(IA.LINE_STATUS) AS LINE_STATUS                                                  ");
		sbSql.append("\n              , MAX(IA.PR_SABUN) AS PR_SABUN                                                        ");
        sbSql.append("\n          FROM (                                                                                    ");
        sbSql.append("\n                SELECT DECODE(B.ORG_PR_NUM, NULL, A.PO_NUM, B.ORG_PR_NUM) AS PO_NUM                 ");
        sbSql.append("\n                     , A.PO_ID                                                                      ");
        sbSql.append("\n                     , A.MARGIN_PRICE                                                               ");
        sbSql.append("\n                     , A.PO_QTY                                                                     ");
        sbSql.append("\n                     , A.TAX_CODE                                                                   ");
        sbSql.append("\n                     , A.LINE_STATUS                                                                ");
        sbSql.append("\n                     , A.RC_DEPT_ID                                                                 ");
        sbSql.append("\n                     , B.PR_SABUN                                                                   ");
        sbSql.append("\n                  FROM HLDC_PO_PO A, SO_PR B                                                        ");
        sbSql.append("\n                 WHERE A.PO_ID = B.PR_ID (+)                                                        ");
        sbSql.append("\n                   AND A.PO_NUM = B.PR_NUM (+)                                                      ");
        if(DATE_TYPE.equals("0")) {  //신청일자 
        	sbSql.append("\n                   AND A.PO_DATE   BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'					");
        	//신청일자로만 조회 시 속도개선, 입고일자 조건 추가 20190218 김호석, 당일주문은 안되므로 입고일자는 시작일 이후
        	sbSql.append("\n                   AND A.NEED_DATE >= '"+ START_DATE +"' ");
        } else {
        	sbSql.append("\n                   AND A.NEED_DATE BETWEEN   '"+ START_DATE +"' AND '"+ END_DATE +"'				");
        }
        if(!UPJANG.equals("")) 
        	sbSql.append("\n                   AND A.RC_UPJANG = " + UPJANG                                   );
        else 
        	//팀전체 조회 시 업장 조건 추가로 속도개선 20190218 김호석
        	if(!TM_CD.equals("")) {
        		sbSql.append("\n AND A.RC_UPJANG IN ( 														");
        		sbSql.append("\n SELECT UPJANG 																");
        		sbSql.append("\n        FROM ST_UPJANGV														");
        		sbSql.append("\n       WHERE CC_CD IN (SELECT CC_CD FROM HLDC_SC_DEPT_V WHERE TM_CD = '" + TM_CD +"') ");
        		sbSql.append("\n    )																		");
        	}
        sbSql.append("\n               ) IA                                                                                 ");
		sbSql.append("\n              , HLDC_SC_DEPT_V IB                                                                   ");
		sbSql.append("\n          WHERE 1=1                                                                                 ");
		sbSql.append("\n            AND IA.RC_DEPT_ID = IB.DEPT_ID                                                          ");
		if(!MU_CD.equals(""))
			
            sbSql.append("\n            AND IB.MU_CD = '" + MU_CD + "'"                                           );
        if(!TM_CD.equals(""))
            sbSql.append("\n            AND IB.TM_CD = '" + TM_CD +"'"                                            );        
        if(DEPT_TYPE.equals("0"))  //검수부서별 조회 언체크
            sbSql.append("\n          GROUP BY IA.PO_NUM"              );
        else
            sbSql.append("\n          GROUP BY IA.PO_NUM, IA.RC_DEPT_ID");
		sbSql.append("\n       ) G                                                                                          ");
		sbSql.append("\n     , (                                                                               				");
		sbSql.append("\n        SELECT PO_TYPE, TYPE_NAME                                                                   ");
		sbSql.append("\n          FROM HLDC_PO_TYPE_FS                                                                         ");
		sbSql.append("\n        UNION ALL                                                                            		");
		sbSql.append("\n        SELECT PO_TYPE, TYPE_NAME                                                                   ");
		sbSql.append("\n          FROM HLDC_VO_PO_TYPE                                                                      ");
		sbSql.append("\n        ) H                                                                            				");		
		sbSql.append("\n WHERE 1=1                                                                                          ");
		sbSql.append("\n   AND A.SUBINV_CODE = B.SUBINV_CODE(+)                                                             ");
		sbSql.append("\n   AND A.PO_SABUN    = C.SABUN                                                                      ");
		sbSql.append("\n   AND A.PR_UPJANG   = D.UPJANG                                                                     ");
		sbSql.append("\n   AND A.PR_DEPT_ID  = E.DEPT_ID                                                                    ");
		sbSql.append("\n   AND A.RC_DEPT_ID  = F.DEPT_ID                                                                    ");
		if(!MU_CD.equals(""))
			//신청자 팀코드로 하면 내역조회안되는 문제 수정(대상업장 RC_UPJANG 기준으로 변경) 20190123 김호석
            sbSql.append("\n            AND F.MU_CD = '" + MU_CD + "'"                                           );
        if(!TM_CD.equals(""))
        	//신청자 팀코드로 하면 내역조회안되는 문제 수정(대상업장 RC_UPJANG 기준으로 변경) 20190123 김호석
            sbSql.append("\n            AND F.TM_CD = '" + TM_CD +"'"                                            );        
		sbSql.append("\n   AND A.PO_NUM      = G.PO_NUM                                                                     ");
		sbSql.append("\n   AND A.PO_ID       = G.PO_ID                                                                      ");
        if(DATE_TYPE.equals("0")) { //신청일자
        	sbSql.append("\n                   AND A.PO_DATE   BETWEEN '"+ START_DATE +"' AND '"+ END_DATE +"'					");
      		//신청일자로만 조회 시  속도개선, 입고일자 조건 추가 20190218 김호석, 당일주문은 안되므로 입고일자는 시작일 이후
    		sbSql.append("\n                   AND A.NEED_DATE >= '"+ START_DATE +"' ");
        } else {
        	sbSql.append("\n                   AND A.NEED_DATE BETWEEN   '"+ START_DATE +"' AND '"+ END_DATE +"'				");
        }
        if(!UPJANG.equals(""))
        	sbSql.append("\n                   AND A.RC_UPJANG = " + UPJANG                                   );
		sbSql.append("\n   AND A.PO_TYPE     = H.PO_TYPE (+)                                                                ");
 		if(!PO_TYPE.equals(""))
			sbSql.append("\n    AND A.PO_TYPE     = '"+ PO_TYPE +"'															"); 
		

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		DataSet ds_grdList1 = this.makeDataSet(rs, "ds_grdList1"); //ds_list
		
		/**종료**/
		out_dl.add(ds_grdList1);
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