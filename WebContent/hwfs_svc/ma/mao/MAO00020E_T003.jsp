<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���翵��/�������
�� ���α׷�ID   : MAO00020E_T003.jsp
�� ���α׷���   : �����ȹ ��ϰ���(����,��,��������� ��ȸ)
�� �ۼ�����     : 2015-09-04
�� �ۼ���       : ������
�� �̷°���     : 2015-09-04 ������ - ���ʰ��� (CH201203_00081)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//�Է� ����Ÿ
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//�Է� �Ķ����
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out ����Ÿ
		DataSet ds_List;
		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("/*	MAO00020E_T003.jsp		*/ \n");
		sbSql.append("SELECT DISTINCT A.PART_SABUN \n");
		sbSql.append("	, A.PART_SABUN_NAME||'('||A.MU_NM||'  '||A.CC_NM||')' AS PART_SABUN_NAME \n");
		sbSql.append("	, A.TM_CD \n");
		sbSql.append("	, A.TM_NM  \n");
		//2018.03.27 ��� �⺻ ���ξ��� ���� �����߰�
		if (nullToBlank(ds_Cond.getString(0, "selGubun")).equals("1")){
			sbSql.append("	, A.MAIN_UPJANG  \n");
			sbSql.append("	, A.UPJANGNM_DISP  \n");
		}else{
			sbSql.append("	, '' AS MAIN_UPJANG  \n");
			sbSql.append("	, '' AS UPJANGNM_DISP  \n");
		}
		sbSql.append("	, A.PART_NAME  \n");
		sbSql.append("	, A.PART_CODE  \n");
		sbSql.append("FROM ( \n");
		sbSql.append("SELECT UJ.PART_SALES_SABUN PART_SABUN \n"); 
		sbSql.append("		, (SELECT SCC_CRYPTO.MASKAUTH_FUN (NM_KOR, 12, 'YYYYNNNNNNNNNNN', '0') FROM HR_PERSONAL WHERE SABUN=UJ.PART_SALES_SABUN ) AS PART_SABUN_NAME  \n");
		sbSql.append("		, V.TM_CD  \n");
		sbSql.append("		, V.TM_NM  \n");
		sbSql.append("		, V.CC_NM \n");
		sbSql.append("		, V.MU_NM \n");
		sbSql.append("		, UJ.MAIN_UPJANG \n");
		sbSql.append("		, UJ.UPJANGNM_DISP \n");
		sbSql.append("		, P.CODE_NAME AS PART_NAME  \n");
		sbSql.append("		, UJ.PART_CODE  \n");
		sbSql.append("FROM FMS_UPJANG UJ  \n");
		sbSql.append(", ST_UPJANG ST  \n");
		sbSql.append(", HLDC_SC_DEPT_V V  \n");
		sbSql.append(", SCC_COMMON_CODE P  \n");
		sbSql.append("WHERE UJ.UPJANG=UJ.MAIN_UPJANG \n"); 
		sbSql.append("	AND UJ.UPJANG=ST.UPJANG  \n");
		sbSql.append("	AND ST.DEPT_ID=V.DEPT_ID  \n");
		sbSql.append("	AND UJ.PART_CODE=P.CODE   \n");
		sbSql.append("	AND P.GROUP_CODE='FM0022'  \n");
		sbSql.append("	AND UJ.PART_SALES_SABUN IS NOT NULL \n"); 
		//2018.03.27 ���: ���ڵ� ��ȸ ���� �߰�
		sbSql.append("	AND V.TM_CD = '" + nullToBlank(ds_Cond.getString(0, "teamCode")) + "' \n");
		sbSql.append(") A  \n");
		sbSql.append("WHERE 1=1 \n"); 
		if (! nullToBlank(ds_Cond.getString(0, "mainUpjang")).equals(""))
			sbSql.append("   AND A.MAIN_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "mainUpjang")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "SABUN")).equals(""))
			sbSql.append("   AND A.PART_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SABUN")) + "' \n");

		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_Condinfo");
		rs.close(); 
		pstmt.close();		

		/**����**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp �α׳����
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
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>
