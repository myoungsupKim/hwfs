<%
/*-----------------------------------------------------------------------------
■ 시스템명     :
■ 프로그램ID   : SCC99998E_T002.jsp
■ 프로그램명   : 진척률 저장
■ 작성일자     : 2015-01-18
■ 작성자       : 박용대
■ 이력관리     : 2015-01-18 최초작성
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);

	in_vl = platformRequest.getData().getVariableList();
	in_dl = platformRequest.getData().getDataSetList();

	//입력 데이타셋
	DataSet ds_list   = in_dl.get("inds_List");
	DataSet ds_pl_test_list = in_dl.get("inds_PlTestList");
	DataSet ds_pi_test_list = in_dl.get("inds_PiTestList");

	//입력 파라미터
	String g_EmpNo    = nullToBlank(in_vl.getString("g_EmpNo"));

	//FileLog.println("d:\\aaa.txt", ds_cond);

	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		String checkFlag	= "";

		if (ds_list != null)
		{
			//입력,수정
			for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
			{


				sbSql.delete(0, sbSql.length());
				sRowStatus = ds_list.getRowType(i);
				System.out.println(sRowStatus);

				if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
				{
					continue;
				}
				else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
				{

					sbSql.delete(0, sbSql.length());

					sbSql.append("\n\n");
			        sbSql.append("INSERT INTO SCC_PROGRESS_YD(   \n");
			        sbSql.append("       SEQ ,      \n");
			        sbSql.append("       PREFIX ,    \n");
			        sbSql.append("       PROGRAM ,   \n");
			        sbSql.append("       MENU_NAME , \n");
			        sbSql.append("       PROGRAM_NAME , \n");
			        sbSql.append("       WINDOW_SIZE , \n");
			        sbSql.append("       MENU_TYPE , \n");
			        sbSql.append("       DEV_REF ,   \n");
			        sbSql.append("       DEV_ERROR , \n");
			        sbSql.append("       DEV_NAME ,  \n");
			        sbSql.append("       DEV_SCR_YN , \n");
			        sbSql.append("       DEV_SCR_EDATE , \n");
			        sbSql.append("       DEV_SCRT_YN , \n");
			        sbSql.append("       DEV_SCRT_SDATE , \n");
			        sbSql.append("       DEV_SCRT_EDATE , \n");
			        sbSql.append("       DEV_TEST_DATE , \n");
			        sbSql.append("       DEV_TEST_YN , \n");
			        sbSql.append("       ITO_NAME ,  \n");
			        sbSql.append("       ITO_TEST_DATE , \n");
			        sbSql.append("       ITO_CHK_YN , \n");
			        sbSql.append("       ITO_NAME2 ,  \n");
			        sbSql.append("       ITO_TEST_DATE2 , \n");
			        sbSql.append("       ITO_CHK_YN2 , \n");
			        sbSql.append("       ITO_ERROR , \n");
			        sbSql.append("       PI_NAME ,   \n");
			        sbSql.append("       PI_TEST_DATE , \n");
			        sbSql.append("       PI_CHK_YN , \n");
			        sbSql.append("       PI_ERROR,    \n");
			        sbSql.append("       GUBUN,    \n");
			        sbSql.append("       SUB_GUBUN,    \n");
			        sbSql.append("       DEV_PLAN_SDATE,    \n");
			        sbSql.append("       DEV_PLAN_EDATE,    \n");
			        sbSql.append("       DEL_YN,    \n");
			        sbSql.append("    	 CUSER,                  \n");
			        sbSql.append("    	 CDATE,                  \n");
			        sbSql.append("    	 UUSER,                  \n");
			        sbSql.append("    	 UDATE                   \n");
			        sbSql.append(") (SELECT NVL(MAX(SEQ), 0)+1,                    \n");
			        //sbSql.append("    '"+nullToBlank(ds_list.getString(i,"SEQ"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"PREFIX"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"PROGRAM"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"MENU_NAME"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"PROGRAM_NAME"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"WINDOW_SIZE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"MENU_TYPE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_REF"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_ERROR"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_NAME"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_SCR_YN"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_SCR_EDATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_SCRT_YN"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_SCRT_SDATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_SCRT_EDATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_TEST_DATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_TEST_YN"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITO_NAME"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITO_TEST_DATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITO_CHK_YN"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITO_NAME2"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITO_TEST_DATE2"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITO_CHK_YN2"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ITO_ERROR"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"PI_NAME"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"PI_TEST_DATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"PI_CHK_YN"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"PI_ERROR"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"GUBUN"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"SUB_GUBUN"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_PLAN_SDATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEV_PLAN_EDATE"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"DEL_YN"))+"',\n");
			        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
			        sbSql.append("    SYSDATE,              \n");
			        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
			        sbSql.append("    SYSDATE               \n");
			        sbSql.append("FROM SCC_PROGRESS_YD                     \n");
			        sbSql.append(")                           \n");
			        sbSql.append("\n\n");

					pstmt = conn.prepareStatement(sbSql.toString());
					pstmt.executeUpdate();
					pstmt.close();

				}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
				{
					//작은 따음표를 작은 따움표 두개로 만들어 쿼리 날리기
					String devRef = nullToBlank(ds_list.getString(i,"DEV_REF"));
					String devRefQ = devRef.replaceAll("'","''");
					String devError = nullToBlank(ds_list.getString(i,"DEV_ERROR"));
					String devErrorQ = devError.replaceAll("'","''");
					String itoError = nullToBlank(ds_list.getString(i,"ITO_ERROR"));
					String itoErrorQ = itoError.replaceAll("'","''");
					String piError = nullToBlank(ds_list.getString(i,"PI_ERROR"));
					String piErrorQ = piError.replaceAll("'","''");


					sbSql.delete(0, sbSql.length());

					sbSql.append("\n\n");
			        sbSql.append("UPDATE SCC_PROGRESS_YD          \n");
			        sbSql.append("   SET SEQ = '"		+nullToBlank(ds_list.getString(i,"SEQ"))+"',     \n");
			        sbSql.append("       PREFIX = '"	+nullToBlank(ds_list.getString(i,"PREFIX"))+"',      \n");
			        sbSql.append("       PROGRAM = '"	+nullToBlank(ds_list.getString(i,"PROGRAM"))+"',  \n");
			        sbSql.append("       MENU_NAME = '"	+nullToBlank(ds_list.getString(i,"MENU_NAME"))+"',  \n");
			        sbSql.append("       PROGRAM_NAME = '"		+nullToBlank(ds_list.getString(i,"PROGRAM_NAME"))+"',  \n");
			        sbSql.append("       WINDOW_SIZE = '"	+nullToBlank(ds_list.getString(i,"WINDOW_SIZE"))+"',  \n");
			        sbSql.append("       MENU_TYPE = '"		+nullToBlank(ds_list.getString(i,"MENU_TYPE"))+"',  \n");
			        sbSql.append("       DEV_REF = '"		+nullToBlank(devRefQ)+"',  \n");
			        sbSql.append("       DEV_ERROR = '"		+nullToBlank(devErrorQ)+"',  \n");
			        sbSql.append("       DEV_NAME = '"+nullToBlank(ds_list.getString(i,"DEV_NAME"))+"',  \n");
			        sbSql.append("       DEV_SCR_YN = '"		+nullToBlank(ds_list.getString(i,"DEV_SCR_YN"))+"',  \n");
			        sbSql.append("       DEV_SCR_EDATE = '"		+nullToBlank(ds_list.getString(i,"DEV_SCR_EDATE"))+"',  \n");
			        sbSql.append("       DEV_SCRT_YN = '"	+nullToBlank(ds_list.getString(i,"DEV_SCRT_YN"))+"',  \n");
			        sbSql.append("       DEV_SCRT_SDATE = '"	+nullToBlank(ds_list.getString(i,"DEV_SCRT_SDATE"))+"',  \n");
			        sbSql.append("       DEV_SCRT_EDATE = '"	+nullToBlank(ds_list.getString(i,"DEV_SCRT_EDATE"))+"',  \n");
			        sbSql.append("       DEV_TEST_DATE = '"	+nullToBlank(ds_list.getString(i,"DEV_TEST_DATE"))+"',  \n");
			        sbSql.append("       DEV_TEST_YN = '"	+nullToBlank(ds_list.getString(i,"DEV_TEST_YN"))+"',  \n");
			        sbSql.append("       ITO_NAME = '"	+nullToBlank(ds_list.getString(i,"ITO_NAME"))+"',  \n");
			        sbSql.append("       ITO_TEST_DATE = '"	+nullToBlank(ds_list.getString(i,"ITO_TEST_DATE"))+"',  \n");
			        sbSql.append("       ITO_CHK_YN = '"	+nullToBlank(ds_list.getString(i,"ITO_CHK_YN"))+"',  \n");
			        sbSql.append("       ITO_NAME2 = '"	+nullToBlank(ds_list.getString(i,"ITO_NAME2"))+"',  \n");
			        sbSql.append("       ITO_TEST_DATE2 = '"	+nullToBlank(ds_list.getString(i,"ITO_TEST_DATE2"))+"',  \n");
			        sbSql.append("       ITO_CHK_YN2 = '"	+nullToBlank(ds_list.getString(i,"ITO_CHK_YN2"))+"',  \n");
			        sbSql.append("       ITO_ERROR = '"	+nullToBlank(itoErrorQ)+"',  \n");
			        sbSql.append("       PI_NAME = '"	+nullToBlank(ds_list.getString(i,"PI_NAME"))+"',  \n");
			        sbSql.append("       PI_TEST_DATE = '"	+nullToBlank(ds_list.getString(i,"PI_TEST_DATE"))+"',  \n");
			        sbSql.append("       PI_CHK_YN = '"	+nullToBlank(ds_list.getString(i,"PI_CHK_YN"))+"',  \n");
			        sbSql.append("       PI_ERROR = '"	+nullToBlank(piErrorQ)+"',  \n");
			        sbSql.append("       GUBUN = '"	+nullToBlank(ds_list.getString(i,"GUBUN"))+"',  \n");
			        sbSql.append("       SUB_GUBUN = '"	+nullToBlank(ds_list.getString(i,"SUB_GUBUN"))+"',  \n");
			        sbSql.append("       DEV_PLAN_SDATE = '"	+nullToBlank(ds_list.getString(i,"DEV_PLAN_SDATE"))+"',  \n");
			        sbSql.append("       DEV_PLAN_EDATE = '"	+nullToBlank(ds_list.getString(i,"DEV_PLAN_EDATE"))+"',  \n");
			        sbSql.append("       DEL_YN = '"	+nullToBlank(ds_list.getString(i,"DEL_YN"))+"',  \n");
			        sbSql.append("       UUSER = '"+g_EmpNo+"',     \n");
			        sbSql.append("       UDATE = SYSDATE           \n");
			        sbSql.append(" WHERE 1 = 1               \n");
			        sbSql.append(" AND SEQ = '"		+nullToBlank(ds_list.getString(i,"SEQ"))+"'   \n");
			        sbSql.append("\n\n");

			        pstmt = conn.prepareStatement(sbSql.toString());
					pstmt.executeUpdate();
					pstmt.close();
				}
			}

			//삭제
			for ( int i = 0 ; i < ds_list.getRemovedRowCount() ; i++ )
			{
				sbSql.delete(0, sbSql.length());

				sbSql.append("\n\n");
		        sbSql.append("UPDATE SCC_PROGRESS_YD SET DEL_YN = 'Y', UUSER= '" + g_EmpNo + "', UDATE=SYSDATE   \n");
		        sbSql.append("WHERE SEQ = '"+ds_list.getRemovedData(i,"SEQ")+"'           \n");
		        sbSql.append("\n\n");

				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
		}


		if (ds_pl_test_list != null)
		{
			//PL Test 처리
			for (int i=0; i<ds_pl_test_list.getRowCount(); i++)
			{
				sbSql.delete(0, sbSql.length());
				sRowStatus = ds_pl_test_list.getRowType(i);

				if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
				{
					continue;
				}
				else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
				{

					sbSql.delete(0, sbSql.length());

					sbSql.append("\n\n");
			        sbSql.append("INSERT INTO SCC_PROGRESS_LST(   \n");
			        sbSql.append("       MAIN_SEQ ,      \n");
			        sbSql.append("       SEQ ,    \n");
			        sbSql.append("       GUBUN ,   \n");
			        sbSql.append("       USER_NAME , \n");
			        sbSql.append("       TST_DT , \n");
			        sbSql.append("       TST_CONTENT , \n");
			        sbSql.append("       FILE_REF_SEQ , \n");
			        sbSql.append("       WRN_CODE , \n");
			        sbSql.append("       CNF_CODE ,   \n");
			        sbSql.append("       CNF_DT , \n");
			        sbSql.append("       CUSER ,  \n");
			        sbSql.append("       CDATE , \n");
			        sbSql.append("       UUSER , \n");
			        sbSql.append("       UDATE \n");
			        sbSql.append(") (SELECT                    \n");
			        sbSql.append("    "+nullToBlank(ds_pl_test_list.getString(i,"mainSeq"))+",\n");
			        sbSql.append("    NVL(MAX(SEQ)+1, 1),\n");
			        sbSql.append("    '"+nullToBlank(ds_pl_test_list.getString(i,"gubun"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pl_test_list.getString(i,"userName")).replaceAll("'","''")+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pl_test_list.getString(i,"tstDt"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pl_test_list.getString(i,"tstContent")).replaceAll("'","''")+"',\n");
			        sbSql.append("    NVL('"+nullToBlank(ds_pl_test_list.getString(i,"fileRefSeq"))+"',0),\n");
			        sbSql.append("    '"+nullToBlank(ds_pl_test_list.getString(i,"wrnCode"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pl_test_list.getString(i,"cnfCode"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pl_test_list.getString(i,"cnfDt"))+"',\n");
			        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
			        sbSql.append("    SYSDATE,              \n");
			        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
			        sbSql.append("    SYSDATE               \n");
			        sbSql.append(" FROM  SCC_PROGRESS_LST             \n");
			        sbSql.append(" WHERE MAIN_SEQ = " + nullToBlank(ds_pl_test_list.getString(i,"mainSeq")) + "\n");
			        sbSql.append(")                           \n");
			        sbSql.append("\n\n");

					pstmt = conn.prepareStatement(sbSql.toString());
					pstmt.executeUpdate();
					pstmt.close();

				}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
				{
					sbSql.delete(0, sbSql.length());

					sbSql.append("\n\n");
			        sbSql.append("UPDATE SCC_PROGRESS_LST          \n");
			        sbSql.append("   SET USER_NAME = '"		+nullToBlank(ds_pl_test_list.getString(i,"userName")).replaceAll("'","''")+"',     \n");
			        sbSql.append("       TST_DT = '"	+nullToBlank(ds_pl_test_list.getString(i,"tstDt"))+"',      \n");
			        sbSql.append("       TST_CONTENT = '"	+nullToBlank(ds_pl_test_list.getString(i,"tstContent")).replaceAll("'","''")+"',  \n");
			        sbSql.append("       FILE_REF_SEQ = NVL('"	+nullToBlank(ds_pl_test_list.getString(i,"fileRefSeq"))+"', 0),  \n");
			        sbSql.append("       WRN_CODE = '"		+nullToBlank(ds_pl_test_list.getString(i,"wrnCode"))+"',  \n");
			        sbSql.append("       CNF_CODE = '"		+nullToBlank(ds_pl_test_list.getString(i,"cnfCode"))+"',  \n");
			        sbSql.append("       CNF_DT = '"	+nullToBlank(ds_pl_test_list.getString(i,"cnfDt"))+"',  \n");
			        sbSql.append("       UUSER = '"+g_EmpNo+"',     \n");
			        sbSql.append("       UDATE = SYSDATE           \n");
			        sbSql.append(" WHERE MAIN_SEQ = " +nullToBlank(ds_pl_test_list.getString(i,"mainSeq"))+ "  \n");
			        sbSql.append(" AND SEQ = "		+nullToBlank(ds_pl_test_list.getString(i,"seq"))+"   \n");
			        sbSql.append("\n\n");

			        pstmt = conn.prepareStatement(sbSql.toString());
					pstmt.executeUpdate();
					pstmt.close();
				}
			}

			//삭제
			for ( int i = 0 ; i < ds_pl_test_list.getRemovedRowCount() ; i++ )
			{
				sbSql.delete(0, sbSql.length());

				sbSql.append("\n\n");
		        sbSql.append("DELETE FROM SCC_PROGRESS_LST   \n");
		        sbSql.append("WHERE MAIN_SEQ = "+ds_pl_test_list.getRemovedData(i,"mainSeq")+"           \n");
		        sbSql.append("AND SEQ = "+ds_pl_test_list.getRemovedData(i,"seq")+"           \n");
		        sbSql.append("\n\n");

				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
		}


		//PI Test 처리
		if (ds_pi_test_list != null)
		{
			for (int i=0; i<ds_pi_test_list.getRowCount(); i++)
			{
				sbSql.delete(0, sbSql.length());
				sRowStatus = ds_pi_test_list.getRowType(i);

				if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
				{
					continue;
				}
				else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
				{

					sbSql.delete(0, sbSql.length());

					sbSql.append("\n\n");
			        sbSql.append("INSERT INTO SCC_PROGRESS_LST(   \n");
			        sbSql.append("       MAIN_SEQ ,      \n");
			        sbSql.append("       SEQ ,    \n");
			        sbSql.append("       GUBUN ,   \n");
			        sbSql.append("       USER_NAME , \n");
			        sbSql.append("       TST_DT , \n");
			        sbSql.append("       TST_CONTENT , \n");
			        sbSql.append("       FILE_REF_SEQ , \n");
			        sbSql.append("       WRN_CODE ,   \n");
			        sbSql.append("       CNF_CODE ,   \n");
			        sbSql.append("       CNF_DT , \n");
			        sbSql.append("       CUSER ,  \n");
			        sbSql.append("       CDATE , \n");
			        sbSql.append("       UUSER , \n");
			        sbSql.append("       UDATE \n");
			        sbSql.append(") (SELECT                    \n");
			        sbSql.append("    "+nullToBlank(ds_pi_test_list.getString(i,"mainSeq"))+",\n");
			        sbSql.append("    NVL(MAX(seq)+1, 1),\n");
			        sbSql.append("    '"+nullToBlank(ds_pi_test_list.getString(i,"gubun"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pi_test_list.getString(i,"userName")).replaceAll("'","''")+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pi_test_list.getString(i,"tstDt"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pi_test_list.getString(i,"tstContent")).replaceAll("'","''")+"',\n");
			        sbSql.append("    NVL('"+nullToBlank(ds_pi_test_list.getString(i,"fileRefSeq"))+"', 0),\n");
			        sbSql.append("    '"+nullToBlank(ds_pi_test_list.getString(i,"wrnCode"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pi_test_list.getString(i,"cnfCode"))+"',\n");
			        sbSql.append("    '"+nullToBlank(ds_pi_test_list.getString(i,"cnfDt"))+"',\n");
			        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
			        sbSql.append("    SYSDATE,              \n");
			        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
			        sbSql.append("    SYSDATE               \n");
			        sbSql.append(" FROM  SCC_PROGRESS_LST             \n");
			        sbSql.append(" WHERE MAIN_SEQ = " + nullToBlank(ds_pi_test_list.getString(i,"mainSeq")) + "\n");
			        sbSql.append(")                           \n");
			        sbSql.append("\n\n");

					pstmt = conn.prepareStatement(sbSql.toString());
					pstmt.executeUpdate();
					pstmt.close();

				}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
				{
					sbSql.delete(0, sbSql.length());

					sbSql.append("\n\n");
			        sbSql.append("UPDATE SCC_PROGRESS_LST          \n");
			        sbSql.append("   SET USER_NAME = '"		+nullToBlank(ds_pi_test_list.getString(i,"userName")).replaceAll("'","''")+"',     \n");
			        sbSql.append("       TST_DT = '"	+nullToBlank(ds_pi_test_list.getString(i,"tstDt"))+"',      \n");
			        sbSql.append("       TST_CONTENT = '"	+nullToBlank(ds_pi_test_list.getString(i,"tstContent")).replaceAll("'","''")+"',  \n");
			        sbSql.append("       FILE_REF_SEQ = NVL('"	+nullToBlank(ds_pi_test_list.getString(i,"fileRefSeq"))+"', 0),  \n");
			        sbSql.append("       WRN_CODE = '"		+nullToBlank(ds_pl_test_list.getString(i,"wrnCode"))+"',  \n");
			        sbSql.append("       CNF_CODE = '"		+nullToBlank(ds_pi_test_list.getString(i,"cnfCode"))+"',  \n");
			        sbSql.append("       CNF_DT = '"	+nullToBlank(ds_pi_test_list.getString(i,"cnfDt"))+"',  \n");
			        sbSql.append("       UUSER = '"+g_EmpNo+"',     \n");
			        sbSql.append("       UDATE = SYSDATE           \n");
			        sbSql.append(" WHERE MAIN_SEQ = " +nullToBlank(ds_pi_test_list.getString(i,"mainSeq"))+ "  \n");
			        sbSql.append(" AND SEQ = "		+nullToBlank(ds_pi_test_list.getString(i,"seq"))+"   \n");
			        sbSql.append("\n\n");

			        pstmt = conn.prepareStatement(sbSql.toString());
					pstmt.executeUpdate();
					pstmt.close();
				}
			}

			//삭제
			for ( int i = 0 ; i < ds_pi_test_list.getRemovedRowCount() ; i++ )
			{
				sbSql.delete(0, sbSql.length());

				sbSql.append("\n\n");
		        sbSql.append("DELETE FROM SCC_PROGRESS_LST   \n");
		        sbSql.append("WHERE MAIN_SEQ = "+ds_pi_test_list.getRemovedData(i,"mainSeq")+"           \n");
		        sbSql.append("AND SEQ = "+ds_pi_test_list.getRemovedData(i,"seq")+"           \n");
		        sbSql.append("\n\n");

				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
		}



		/**종료**/
		conn.commit();
		//out_vl.addStr("fa_Msg", "");

		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(), out_vl);
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