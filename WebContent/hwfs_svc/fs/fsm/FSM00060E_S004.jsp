<%
/*-----------------------------------------------------------------------------
�� �ý��۸�     : IFIS/�Ĵܰ���
�� ���α׷�ID   : FSM00060E_S004.jsp
�� ���α׷���   : ������ ���缳��
�� �ۼ�����     : 2009.03.30
�� �ۼ���       : ������
�� �̷°���     : 2008.03.30 CSR(#25617) �����ۼ�
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
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		DataSet ds_Item  	= in_dl.get("ds_Item");
		
		String p_NeedDate 		= in_vl.getString("p_NeedDate");
		
		//if(conn != null && !conn.isClosed()) conn.close();
		
		//conn = getIRISConn();
	
	
		//DataSet ds_out;	
		StringBuffer sbSelSql = new StringBuffer();
		
		String strItemCode, strItemClass4, strUpjang, strCheapYN, strGItemPrice, strNeedDateLine;
		
		for(int i = 0; i < ds_Item.getRowCount(); i++)
		{
			strUpjang   =  ds_Item.getString(i,"UPJANG");
			strItemCode =  ds_Item.getString(i,"ITEM_CODE");
			strItemClass4 = ds_Item.getString(i,"ITEM_CLASS4");
			strGItemPrice = ds_Item.getString(i, "G_ITEM_PRICE");
			strNeedDateLine = ds_Item.getString(i, "NEED_DATE");
			
			sbSelSql.delete(0, sbSelSql.length());
				
			sbSelSql.append("SELECT PO_PR_CHEAP_ITEM_FUN( \n");
			sbSelSql.append("        '" + strNeedDateLine + "' \n");
			sbSelSql.append("       ,'" + strItemCode + "' \n");
			sbSelSql.append("       ,'" + strItemClass4 + "' \n");
			sbSelSql.append("       ," + strUpjang + " \n");
			sbSelSql.append("       ," + strGItemPrice + " \n");
			sbSelSql.append("       ) CHEAP_YN \n");
			sbSelSql.append("  FROM DUAL \n");
				
			//pstmt = conn.prepareStatement(sbSelSql.toString());		
			//rs = pstmt.executeQuery();
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSelSql.toString());				
				
			rs.next();
				
			strCheapYN = rs.getString("CHEAP_YN");
				
			rs.close();
			stmt.close();

			System.out.println(strCheapYN);
			
			ds_Item.set(i,"CHEAP_YN",strCheapYN);
		}

		out_dl.add(ds_Item);
		
		//FileLog.println("c:\\aaa.txt",ds_out);
		
	   	this.setResultMessage(0, "OK",out_vl);
	   	
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp �α׳����
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
			//jsp log ���� �ݱ� 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}				
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	