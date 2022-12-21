<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00400E_T001.jsp
■ 프로그램명   : 운영율 조회
■ 작성일자     : 2015.11.11
■ 작성자       : 박용대
■ 이력관리     : 
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
	String upjang 		= nullToBlank(ds_cond.getString(0, "UPJANG"));
	String sdate 		= nullToBlank(ds_cond.getString(0, "PRE_DATE"));
	String sItemType	= nullToBlank(ds_cond.getString(0, "ITEM_TYPE"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	
	try
	{
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//sql문
		sbSql.append("\n\n");
        sbSql.append("SELECT A.UPJANG,                                                                              \n");
        sbSql.append("       B.UPJANGNM_DISP,                                                                       \n");
        sbSql.append("       (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS2) AS CLASS2, \n");
        sbSql.append("       (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS3) AS CLASS3, \n");
        sbSql.append("       (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS Z WHERE Z.CLASS_CODE = C.ITEM_CLASS4) AS CLASS4, \n");
        sbSql.append("       A.ITEM_CODE,                                                                           \n");
        sbSql.append("       C.ITEM_NAME,                                                                           \n");
        sbSql.append("       C.ITEM_SIZE,                                                                           \n");
        sbSql.append("       C.PO_UOM,                                                                              \n");
        sbSql.append("       A.ITEM_TYPE,                                                                           \n");
        sbSql.append("       A.OP_RATE,                                                                             \n");
        sbSql.append("       A.SDATE,                                                                               \n");
        sbSql.append("       A.EDATE                                                                                \n");
        sbSql.append("  FROM FMU_OP_RATE A,                                                                         \n");
        sbSql.append("       FMS_UPJANG B,                                                                          \n");
        sbSql.append("       FMS_ITEM_V C                                                                           \n");
        sbSql.append(" WHERE 1=1                                                                      \n");
        sbSql.append("   AND A.USE_YN = 'Y'                                                                      \n");
        sbSql.append("   AND B.USE_YN = 'Y'                                                                      \n");
        sbSql.append("   AND C.USE_YN = 'Y'                                                                      \n");
        if(!upjang.equals("")){
        	sbSql.append(" AND A.UPJANG = '"+upjang+"' \n");}       
   		sbSql.append("   AND A.SDATE = '"+sdate+"'                                                                     \n");
   		sbSql.append("   AND A.ITEM_TYPE = '"+sItemType+"'                                                                 \n");
   		sbSql.append("   AND A.UPJANG = B.UPJANG(+)                                                                 \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+)                                                           \n");
        sbSql.append("   ORDER BY 1,2,3,4,5,6,7                                                                    \n");
	    sbSql.append("\n\n");
        
	    //테스트
	    System.out.println(sbSql.toString());
	    
        //출력 파라미터 셋팅
		out_vl.add("fa_Sql", sbSql.toString());
		
		//쿼리문 실행
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		//Result set으로 부터 데이터셋 생성
		ds_list = this.makeDataSet(rs, "ds_List");
		
		this.accessReadLog(pageContext, ds_cond, ds_list.getRowCount());
		
		//출력 데이터 리스트에 데이터 셋 추가 
		out_dl.add(ds_list);
		
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