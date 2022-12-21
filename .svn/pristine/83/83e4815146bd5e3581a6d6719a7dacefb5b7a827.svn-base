
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		//입력 데이타
		DataSet ds_Cond = in_dl.get("ds_Cond");
		
		String strUpjang       = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String strOtcustcd     = nullToBlank(ds_Cond.getString(0, "OTCUSTCD"));
		String strClass_code_s = nullToBlank(ds_Cond.getString(0, "CLASS_CODE_S"));
		String strItem_code    = nullToBlank(ds_Cond.getString(0, "ITEM_CODE"));
	
		//out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		
        sbSql.append("SELECT A.ITEM_CODE                   \n");
        sbSql.append("     , A.ITEM_NAME                   \n");
        sbSql.append("     , A.ITEM_NAME||';'||A.ITEM_SIZE AS ITEM_NAME_DISP  \n");
        sbSql.append("     , A.ITEM_CLASS3                 \n");
        sbSql.append("     , A.ITEM_SIZE_KG                \n");
        sbSql.append("     , A.ITEM_SIZE_BONG              \n");
        sbSql.append("     , A.ITEM_SIZE_BOX               \n");
        sbSql.append("     , A.G_CONVERT_RATE              \n");
        sbSql.append("     , A.BODY_WIDTH                  \n");
        sbSql.append("     , A.BODY_VERTICAL               \n"); 
        sbSql.append("     , A.BODY_HEIGHT                 \n");
        sbSql.append("     , A.OTCUSTCD                    \n");
        sbSql.append("     , A.UNIT_PRICE_BONG             \n");
        sbSql.append("     , A.SALE_PRICE_BONG             \n"); 
        sbSql.append("     , A.TAX_CODE                    \n");
        sbSql.append("     , A.SHELF_LIFE                  \n");
        sbSql.append("     , A.USE_YN                      \n");
        sbSql.append("     , A.UPJANG                      \n");
        sbSql.append("     , B.OTCUSTNM                    \n");
        sbSql.append("  FROM FMW_ITEM_V A, FMW_OTCUST B    \n");
        sbSql.append(" WHERE A.OTCUSTCD = B.OTCUSTCD  \n");
        //매입업체가 한화가 아니면 해당 대리점의 타 매입처 기준으로 등록 된 상품을 조회
        if (! strOtcustcd.equals("0000"))
        {
            sbSql.append("   AND A.UPJANG = '" + strUpjang + "' \n");
            sbSql.append("   AND A.OTCUSTCD = '" + strOtcustcd + "' \n");
        }
        else  //매입 업체가 한화면 모든 등록 상품을 보여 준다.
        {
        	sbSql.append("   AND A.OTCUSTCD = '" + strOtcustcd + "' \n");	
        }        

        if (! strClass_code_s.equals(""))
        {
        	sbSql.append("   AND SUBSTR(A.ITEM_CLASS3,1,6) = SUBSTR('" + strClass_code_s + "',1,6)     \n");        	
        }
        if (! strItem_code.equals(""))
        {
        	sbSql.append("   AND A.ITEM_CODE = '" + strItem_code + "'           \n");        	
        }
        sbSql.append("  ORDER BY ITEM_CODE \n");        

out_vl.add("fa_Sql", sbSql.toString());
		System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");	
		pstmt.close();
		rs.close();
		
		/**종료**/
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK", out_vl);
		//FileLog.println("c:\\aaa.txt",ds_out);
	   	
	    } catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
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