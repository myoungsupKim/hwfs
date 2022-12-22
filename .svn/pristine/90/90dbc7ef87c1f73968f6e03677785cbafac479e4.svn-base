<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ include file = "../main/common.jsp" %>
<%
	PlatformRequest platformRequest = this.proc_input(request);  
	in_vl = platformRequest.getData().getVariableList();
	in_dl = platformRequest.getData().getDataSetList();
	
	String v_url  = in_vl.getString("v_url");
	String v_Check = "N";

	//String strData = null;
	int charData = -1;
	
	URL url = null; 
	
	if(conn != null) {
		try {
			conn.close();
		}catch(Exception e) {}
	}	

	try{ 
		url = new URL(v_url); 
	}catch(MalformedURLException e){ 
		//e.printStackTrace(); 
	} 

	try{
		BufferedReader bufReader;
		//BufferedReader bufReader = new BufferedReader(new InputStreamReader((new URL(v_url)).openConnection().getInputStream()));
		bufReader = new BufferedReader(new InputStreamReader(url.openConnection().getInputStream()));
	
		
		//strData = bufReader.readLine();
		charData = bufReader.read();
		
		
		//System.out.println(Integer.toString(charData));
		
		bufReader.close();
		
	} catch(IOException e) {
		
		v_Check = "N";
		out_vl.add("v_Check", "N");
	} 	
	
	//if(strData != null)
	if(charData != -1)
	{
		v_Check = "Y";
		out_vl.add("v_Check", "Y");
	}
	else
	{
		v_Check = "N";
		out_vl.add("v_Check", "N");				
	}
	
	this.setResultMessage(0, "OK",out_vl);  
	
    proc_output(response,out,out_vl,out_dl);
%>