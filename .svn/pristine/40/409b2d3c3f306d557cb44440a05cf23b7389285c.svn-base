<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 위생관리 > 건강진단결과 관리
 - ViewPage    : FSC00100E.xml
 - Description : FSC_건강_점검 리스트 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 21 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN DataSet
		DataSet ds_Input = in_dl.get("ds_Input");
		
		// Variables
		String MU_CD = nullToBlank(ds_Input.getString(0, "MU_CD"));
		String TM_CD = nullToBlank(ds_Input.getString(0, "TM_CD"));
		String UPJANG = nullToBlank(ds_Input.getString(0, "UPJANG"));
		
		System.out.println(MU_CD);
		System.out.println(TM_CD);
		System.out.println(UPJANG);
		
		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
	    sbQuery.append("SELECT U.UPJANG                                                                                                            \n");
	    sbQuery.append("     , U.SABUN                                                                                                             \n");
	    sbQuery.append("     , U.NM_KOR                                                                                                            \n");
	    sbQuery.append("     , 0 AS CHK                                                                                                            \n");
	    sbQuery.append("     , C.JIK_KUN                                                                                                           \n");
	    sbQuery.append("     , C.CHECK_DATE                                                                                                        \n");
	    sbQuery.append("     , C.CHECK_TERM                                                                                                        \n");
	    sbQuery.append("     , C.END_DD                                                                                                            \n");
	    sbQuery.append("     , DECODE(C.END_DD, NULL, '', TO_DATE(C.END_DD, 'YYYYMMDD') - TO_DATE(SYSDATE) || '일') AS REMAIN_DATE                 \n");
	    sbQuery.append("     , C.FIRST_INFORM                                                                                                      \n");
	    sbQuery.append("     , TO_CHAR(TO_DATE(C.FIRST_INFORM,'YYYYMMDD'),'D') AS FIRST_DAY                                                        \n");
	    sbQuery.append("     , C.SECOND_INFORM                                                                                                     \n");
	    sbQuery.append("     , TO_CHAR(TO_DATE(C.SECOND_INFORM,'YYYYMMDD'),'D') AS SECOND_DAY                                                      \n");
	    sbQuery.append("     , C.THIRD_INFORM                                                                                                      \n");
	    sbQuery.append("     , TO_CHAR(TO_DATE(C.THIRD_INFORM,'YYYYMMDD'),'D') AS THIRD_DAY                                                        \n");
	    sbQuery.append("     , DECODE(C.CHECK_ITEM, NULL, '폐결핵, 장티푸스, 전염성피부질환', C.CHECK_ITEM) AS CHECK_ITEM                          \n");
	    sbQuery.append("     , C.ADD_CHECK                                                                                                         \n");
	    sbQuery.append("     , DECODE(C.CHECK_RESULT, NULL, DECODE(C.CHECK_DATE, NULL, C.CHECK_RESULT, '1'), C.CHECK_RESULT) AS CHECK_RESULT       \n");
	    sbQuery.append("     , C.CHARG_TERM                                                                                                        \n");
	    sbQuery.append("     , C.REMARK                                                                                                            \n");
	    sbQuery.append("     , C.HLTH_CHK_DD                                                                                                       \n");
	    sbQuery.append("     , NVL(C.HLTH_CHK_YN, 'N') AS HLTH_CHK_YN                                                                              \n");
	    sbQuery.append("  FROM (SELECT A.MU_CD, A.TM_CD, A.UPJANG, B.SABUN, B.NM_KOR FROM SCO_UPJANG_MST_V A, SCO_FS_HR_PERSONAL_V B               \n");
	    //sbQuery.append("         WHERE A.CC_CD = B.CC_CD AND B.PER_DTD IS NULL AND B.EMP_TYPE_CD NOT LIKE 'Z%' 			             \n");
	    //퇴사자 조건 변경 20200604 
	    sbQuery.append("         WHERE A.CC_CD = B.CC_CD AND B.EMP_TYPE_CD NOT LIKE 'Z%' AND B.GB_JAEJIK != 'RA'           				  \n");

	    if(!MU_CD.equals("")) {
	    	sbQuery.append("   AND A.MU_CD = ?                                                                                                     \n");
	    }
	    
	    if(!TM_CD.equals("")) {
	    	sbQuery.append("   AND A.TM_CD = ?                                                                                                     \n");
	    }
	    
	    if(!UPJANG.equals("")) {
	    	sbQuery.append("   AND A.UPJANG = ?                                                                                                    \n");
	    }

	    sbQuery.append("       ) U                                                                                                                 \n");
	    
	    sbQuery.append("     , FSC_HEALTH_CHECK C                                                                                                  \n");
	    sbQuery.append(" WHERE U.UPJANG = C.UPJANG(+)                                                                                              \n");
	    sbQuery.append("   AND U.SABUN = C.SABUN(+)                                                                                                \n");
	    sbQuery.append(" ORDER BY U.MU_CD, U.TM_CD, U.UPJANG, U.SABUN		                                                                       \n");

	    pstmt = conn.prepareStatement(sbQuery.toString());
	    int idx = 1;
	    if(!MU_CD.equals("")) pstmt.setString(idx++, MU_CD);
	    if(!TM_CD.equals("")) pstmt.setString(idx++, TM_CD);
	    if(!UPJANG.equals("")) pstmt.setString(idx++, UPJANG);
		rs = pstmt.executeQuery();
		
		ds_out = this.makeDataSet(rs, "ds_List");
		out_dl.add(ds_out);
		
	   	this.setResultMessage(0, "OK", out_vl);
	} catch(Exception ex) {
	   ex.printStackTrace();
       this.setResultMessage(-1, ex.toString(), out_vl);
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
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		proc_output(response, out, out_vl, out_dl);
	}
%>