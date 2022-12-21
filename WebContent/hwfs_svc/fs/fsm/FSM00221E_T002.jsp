<%
/*
 ******************************************************************************************
 * �ý��۱���: IFIS/�Ĵܰ���/�Ĵܵ��(����)
 * ���α׷���: FSM00221E.XML
 * ��ѤѤѴ�: �Ĵܵ��(����)-�����ֱ�Ĵ� ===> Delete Key �����ϱ� ��������
 * �ۤѼ�����: ��ȭS&C ������
 * �ۼ�������: 2008-05-13
 * ----------------------------------------------------------------------------------------
 * HISTORY    : 
 ******************************************************************************************
 */
 %> 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		// �Է� �����ͼ¸���Ʈ
		in_dl = platformRequest.getData().getDataSetList();
		// �Է�  ��������Ʈ
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 	   = in_vl.getString("g_EmpNo");
		String UPJANG      = in_vl.getString("UPJANG");	
		String MENU_DATE   = in_vl.getString("MENU_DATE");
		String HALL_CD     = in_vl.getString("HALL_CD");
		String CORNER      = in_vl.getString("CORNER");
		String MEAL        = in_vl.getString("MEAL");
		String RECIPE_CD   = in_vl.getString("RECIPE_CD");
		
		stmt 	   = conn.createStatement();                                  //������ ����
		StringBuffer sbSql = new StringBuffer();
	
	
				// �ֱ�Ĵ��� üũ���� �ʴ´�. ���� �Ĵܸ� üũ�Ѵ�.
				//����üũ
				//0) �ǽļ��� ��ϵ� �Ĵ���  ��ŵ�ϴ�.
				//0) �������簡 ��ϵ� �Ĵ��� ��ŵ�Ѵ�.
				
				
				//1.������ ���� ����
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_ITEM                                        \n ");
				sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                               \n ");
				sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
				sbSql.append(" AND   RECIPE_CD = '"+ RECIPE_CD +"'                                            \n ");
				stmt.execute(sbSql.toString());
		
				
				//2.������ ������  ����
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_CUISINE                                        \n ");
				sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                               \n ");
				sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
				sbSql.append(" AND   RECIPE_CD = '"+ RECIPE_CD +"'                                            \n ");
				stmt.execute(sbSql.toString());
		
								
				//3.������ ������ ����
				sbSql.delete(0, sbSql.length());	
				sbSql.delete(0, sbSql.length());	
				sbSql.append(" DELETE FROM FSH_CYCLE_RECIPE_MST                                        \n ");
				sbSql.append(" WHERE UPJANG    = "+ UPJANG +"                                               \n ");
				sbSql.append(" AND   MENU_CD   = '"+ MENU_DATE +"'|| '-' ||'"+HALL_CD+"'||'"+MEAL+"'||'"+CORNER+"'  \n ");
				sbSql.append(" AND   RECIPE_CD = '"+ RECIPE_CD +"'                                            \n ");
				stmt.execute(sbSql.toString());
				
				//Ʈ����� ����
				conn.commit();		
				this.setResultMessage(0, "OK", out_vl);
	
	} catch(Exception ex) {		
		//Ʈ����� ����
		conn.rollback();
		//jsp �α׳����
		logger.debug(ex.getMessage(), ex);
		//�޼�����ȯ
		this.setResultMessage(-1, ex.toString(),out_vl);
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
		if(stmt != null) {
			try {
				stmt.close();
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
