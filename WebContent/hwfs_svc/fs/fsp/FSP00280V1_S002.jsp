<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : ���Ű���/��Ȳ�м�/���籸�����Ϻм�
�� ���α׷�ID   : FSP00280V1_S002.jsp
�� ���α׷���   : ����, ������ ��ȸ
�� �ۼ�����     : 2015-07-01
�� �ۼ���       : ����ö
�� �̷°���     : 
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		//�Ⱓ�� �󼼳��� ��ȸ
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//�Է� ����Ÿ
		DataSet ds_condi     	= in_dl.get("ds_condi");

		//�Է� ����Ÿ
		String TYPE  = nullToBlank(ds_condi.getString(0, "TYPE"));
		String JOB_CD  = nullToBlank(ds_condi.getString(0, "JOB_CD"));

		//out ����Ÿ
		DataSet ds_out;

		//sql�� ���ۻ���
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //Ŭ����

		// �����ڵ�
		if(TYPE.equals("SEARCH_JOP_CD"))
		{
			sbSql.append(" \n SELECT '000' AS JOB_CD"			);
			sbSql.append(" \n      , '��ü' AS JOB_NAME"			);
			sbSql.append(" \n   FROM DUAL"						);
			sbSql.append(" \n  UNION ALL"						);
			sbSql.append(" \n SELECT JOB_CD, JOB_NAME"			);
			sbSql.append(" \n   FROM MAS_JOB"					);
			sbSql.append(" \n  ORDER BY JOB_CD"					);
		}
		// �������ڵ�
 		else if(TYPE.equals("SEARCH_SUB_JOP_CD"))
		{
 	        sbSql.append(" \n SELECT '000000' AS SUB_JOB_CD"	);
 	        sbSql.append(" \n      , '��ü' AS SUB_JOB_NAME"		);
 	        sbSql.append(" \n FROM DUAL"						);
 	        sbSql.append(" \n UNION ALL"						);
 	        sbSql.append(" \n SELECT SUB_JOB_CD, SUB_JOB_NAME"	);
 	        sbSql.append(" \n   FROM MAS_JOB_SUB"				);
 	        if(!JOB_CD.equals("000"))
 	        	sbSql.append(" \n  WHERE JOB_CD = '" + JOB_CD + "'"	);
 	        sbSql.append(" ORDER BY SUB_JOB_CD"					);
		}

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_out = this.makeDataSet(rs, "ds_out");

		/**����**/
		out_dl.add(ds_out);
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