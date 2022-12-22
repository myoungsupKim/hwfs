<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단공유                                                                                                                                                                     
■ 프로그램ID   : FSM00610E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 공유레시피 등록                                                                                                                                               
■ 작성일자     : 2015-02-23                                                                                                                                                                           
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		DataSet ds_menuJointMst = in_dl.get("ds_menuJointMst");	// 공유레시피

		String g_EmpNo               = in_vl.getString("g_EmpNo");
		String JOINT_YYMM            = "";
		String UPJANG                = "";
		String JOINT_CLASS           = "";
		String CHARGE_SABUN          = "";
		String JOINT_WEEKSEQ         = "";
		String MEAL_QTY              = "";
		String MAN_RATE              = "";
		String WOMAN_RATE            = "";
		String MEAL_UPRICE           = "";
		String MEAL_CLASS            = "";
		String MEAL_CLASS_ETC        = "";
		String PATRON_AGES           = "";
		String MEAL_RAWCOST          = "";
		String RATION_METHOD         = "";
		String RATION_METHOD_ETC     = "";
		String MENU_MGRP             = "";
		String MENU_SCLASS           = "";
		String MENU_MGRP_ETC         = "";
		String OFFER_DD              = "";
		String JOINT_RECIPE_CONTENTS = "";
		String STATUS_CD             = "";
		String INQUERY_CNT           = "";
		String RECOMMEND_CNT         = "";
		String WRITE_DD              = "";
		String WRITE_USER            = "";
		String JOINT_YN              = "";
		String REMARK                = "";
		String CUSER                 = "";
		String CDATE                 = "";
		String UUSER                 = "";
		String UDATE                 = "";

		int RowStatus;
		StringBuffer sbSql = new StringBuffer();
		
		// 공유레시피 수정
		int RowCnt = ds_menuJointMst.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			JOINT_YYMM            = nullToBlank(ds_menuJointMst.getString(i,"JOINT_YYMM"));           
			UPJANG                = nullToBlank(ds_menuJointMst.getString(i,"UPJANG"));               
			JOINT_CLASS           = nullToBlank(ds_menuJointMst.getString(i,"JOINT_CLASS"));          
			CHARGE_SABUN          = nullToBlank(ds_menuJointMst.getString(i,"CHARGE_SABUN"));         
			JOINT_WEEKSEQ         = nullToBlank(ds_menuJointMst.getString(i,"JOINT_WEEKSEQ"));        
			MEAL_QTY              = nullToBlank(ds_menuJointMst.getString(i,"MEAL_QTY"));             
			MAN_RATE              = nullToBlank(ds_menuJointMst.getString(i,"MAN_RATE"));             
			WOMAN_RATE            = nullToBlank(ds_menuJointMst.getString(i,"WOMAN_RATE"));           
			MEAL_UPRICE           = nullToBlank(ds_menuJointMst.getString(i,"MEAL_UPRICE"));          
			MEAL_CLASS            = nullToBlank(ds_menuJointMst.getString(i,"MEAL_CLASS"));           
			MEAL_CLASS_ETC        = nullToBlank(ds_menuJointMst.getString(i,"MEAL_CLASS_ETC"));       
			PATRON_AGES           = nullToBlank(ds_menuJointMst.getString(i,"PATRON_AGES"));          
			MEAL_RAWCOST          = nullToBlank(ds_menuJointMst.getString(i,"MEAL_RAWCOST"));         
			RATION_METHOD         = nullToBlank(ds_menuJointMst.getString(i,"RATION_METHOD"));        
			RATION_METHOD_ETC     = nullToBlank(ds_menuJointMst.getString(i,"RATION_METHOD_ETC"));    
			MENU_MGRP             = nullToBlank(ds_menuJointMst.getString(i,"MENU_MGRP"));            
			MENU_SCLASS           = nullToBlank(ds_menuJointMst.getString(i,"MENU_SCLASS"));          
			MENU_MGRP_ETC         = nullToBlank(ds_menuJointMst.getString(i,"MENU_MGRP_ETC"));        
			OFFER_DD              = nullToBlank(ds_menuJointMst.getString(i,"OFFER_DD"));             
			JOINT_RECIPE_CONTENTS = nullToBlank(ds_menuJointMst.getString(i,"JOINT_RECIPE_CONTENTS"));
			STATUS_CD             = nullToBlank(ds_menuJointMst.getString(i,"STATUS_CD"));            
			INQUERY_CNT           = nullToBlank(ds_menuJointMst.getString(i,"INQUERY_CNT"));          
			RECOMMEND_CNT         = nullToBlank(ds_menuJointMst.getString(i,"RECOMMEND_CNT"));        
			WRITE_DD              = nullToBlank(ds_menuJointMst.getString(i,"WRITE_DD"));             
			WRITE_USER            = nullToBlank(ds_menuJointMst.getString(i,"WRITE_USER"));           
			JOINT_YN              = nullToBlank(ds_menuJointMst.getString(i,"JOINT_YN"));
			REMARK                = nullToBlank(ds_menuJointMst.getString(i,"REMARK"));

			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FSM_MENU_JOINT                                             \n"); 
			sbSql.append("   SET                                                            \n"); 
			sbSql.append("       MEAL_QTY              = '" + MEAL_QTY              + "'    \n");
			sbSql.append("     , MAN_RATE              = '" + MAN_RATE              + "'    \n");
			sbSql.append("     , WOMAN_RATE            = '" + WOMAN_RATE            + "'    \n");
			sbSql.append("     , MEAL_UPRICE           = '" + MEAL_UPRICE           + "'    \n");
			sbSql.append("     , MEAL_CLASS            = '" + MEAL_CLASS            + "'    \n");
			sbSql.append("     , MEAL_CLASS_ETC        = '" + MEAL_CLASS_ETC        + "'    \n");
			sbSql.append("     , PATRON_AGES           = '" + PATRON_AGES           + "'    \n");
			sbSql.append("     , MEAL_RAWCOST          = '" + MEAL_RAWCOST          + "'    \n");
			sbSql.append("     , RATION_METHOD         = '" + RATION_METHOD         + "'    \n");
			sbSql.append("     , RATION_METHOD_ETC     = '" + RATION_METHOD_ETC     + "'    \n");
			sbSql.append("     , MENU_MGRP             = '" + MENU_MGRP             + "'    \n");
			sbSql.append("     , MENU_SCLASS           = '" + MENU_SCLASS           + "'    \n");
			sbSql.append("     , MENU_MGRP_ETC         = '" + MENU_MGRP_ETC         + "'    \n");
			sbSql.append("     , OFFER_DD              = '" + OFFER_DD              + "'    \n");
			sbSql.append("     , JOINT_RECIPE_CONTENTS = '" + JOINT_RECIPE_CONTENTS + "'    \n");
			sbSql.append("     , STATUS_CD             = '" + STATUS_CD             + "'    \n");
			sbSql.append("     , INQUERY_CNT           = '" + INQUERY_CNT           + "'    \n");
			sbSql.append("     , RECOMMEND_CNT         = '" + RECOMMEND_CNT         + "'    \n");
			sbSql.append("     , WRITE_DD              = TO_CHAR(SYSDATE, 'YYYYMMDD')       \n");
			sbSql.append("     , WRITE_USER            = '" + g_EmpNo               + "'    \n");
			sbSql.append("     , JOINT_YN              = 'Y'                                \n");
			sbSql.append("     , REMARK                = '" + REMARK                + "'    \n");
			sbSql.append("     , UUSER                 = '" + g_EmpNo               + "'    \n"); 
			sbSql.append("     , UDATE                 = SYSDATE                            \n"); 
			sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'   \n");
			sbSql.append("   AND UPJANG = '" + UPJANG + "'           \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		logger.debug(ex.getMessage(), ex);
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
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}
	
    proc_output(response,out,out_vl,out_dl);

%>