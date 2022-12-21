<%-----------------------------------------------------------
 - Project     : ��ȭ FS System
 - MenuID      : �޴����� > �Ĵܰ��� > �����Ĵܰ��� ��¹�
 - ViewPage    : FSM00350V.xml 
 - Description : �����ڵ� ��ȸ(�Ĵ�, ����, �ڳ�) -- FMS00351V ~ FMS00355R���� �������� ���
 - Author      : �� â ��
 - History     : 1) 2008. 03. 26 - �����ۼ�.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility,  com.ifis.sc.scc.CommonUtil"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		// IN Variables
		String sGubun    = in_vl.getString("GUBUN"    );
		String sOutputDS = in_vl.getString("OUTPUT_DS");
	

		DataSet ds_out;
		StringBuffer sbQuery = new StringBuffer();
		
		if( sGubun.equals("HALL") ) {	// ��ü�� �Ĵ� ��ȸ
			// IN DataSet
			DataSet ds_Input = in_dl.get("ds_Input");
			// ���� ����
			int iUpjang = ds_Input.getInt(0, "UPJANG");
			// Query Set
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT HALL_CD, HALL_NAME			");
			sbQuery.append("\n  FROM FSA_HALL_MST				");
			sbQuery.append("\n WHERE UPJANG = " + iUpjang		 );
			sbQuery.append("\n ORDER BY HALL_CLASS, HALL_CD		");
		} else if( sGubun.equals("MEAL") ) {	// �����ڵ��� ���� ��ȸ
			// Query Set
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT '000' AS CODE, '- ��ü -' AS CODE_NAME		");
			sbQuery.append("\n  FROM DUAL										");
			sbQuery.append("\n UNION ALL										");
			sbQuery.append("\nSELECT CODE, CODE_NAME							");
			sbQuery.append("\n  FROM SCC_COMMON_CODE							");
			sbQuery.append("\n WHERE GROUP_CODE = 'FS0023'						");
		} else if( sGubun.equals("CORNER") ) {	// �����ڵ��� �ڳ� ��ȸ
			// Query Set
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT '000' AS CODE, '- ��ü -' AS CODE_NAME		");
			sbQuery.append("\n  FROM DUAL										");
			sbQuery.append("\n UNION ALL										");
			sbQuery.append("\nSELECT CODE, CODE_NAME							");
			sbQuery.append("\n  FROM SCC_COMMON_CODE							");
			sbQuery.append("\n WHERE GROUP_CODE = 'FS0022'						");
		} else {
			throw new Exception("���а��� �ùٸ��� �ʽ��ϴ�.\n�����ڿ��� �����Ͽ� �ֽʽÿ�.");
		}
		
		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();
		
		//DataSet OUTPUT_DS = this.makeDataSet(rs, "OUTPUT_DS");
		DataSet OUTPUT_DS = this.makeDataSet(rs, sOutputDS);
		out_dl.add(OUTPUT_DS);
		
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