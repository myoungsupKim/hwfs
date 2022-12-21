<%@page import="com.tobesoft.xplatform.data.Debugger"%>
<%@page import="com.tobesoft.xplatform.data.PlatformData"%>
<%@page import="com.sz.ui.xplatform.XplatformBusinessContext"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="com.sz.ui.BusinessContext"%>
<%@page import="com.sz.service.resource.TransactionResource"%>
<%@page import="com.sz.service.resource.ResourceFactory"%>
<%@page import="com.sz.core.ServiceManagerFactory"%>
<%@page import="java.sql.Connection"%>

<%!
	private String RESOURCE_SVC_NAME = "JdbcConnectionFactory";
	private boolean isDebug = true;
	private Connection conn = null;
	
	/**
	*	Connection 가져오기 
	**/
	private Connection getConnection() throws Exception {
		return getConnection("");
	}
	
	/**
	*	Connection 가져오기 
	**/
	private Connection getConnection(String resName) throws Exception {
		ResourceFactory mResourceFactory =(ResourceFactory)
				ServiceManagerFactory.getServiceObject(RESOURCE_SVC_NAME);
		
		TransactionResource res = mResourceFactory.makeResource(resName);
		
		conn = (Connection) res.getResource();
		return conn;
	}
	
	/**
	*	Business Context 가져오기 
	**/
	private BusinessContext makeBusinessContext(HttpServletRequest req, HttpServletResponse res) {
		XplatformBusinessContext ctx = new XplatformBusinessContext(req, res);
		return ctx;
	}
	
	/**
	*	처리 종료 
	**/
	private void end(BusinessContext ctx) throws Exception {
		if ( conn != null ) {
			conn.rollback();
			conn.close();
			conn = null;
		}
		
		Debugger debug = new Debugger();
		if (ctx != null && isDebug ) {
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			pw.write("======================= INDATA ========================\n");
			PlatformData inData = (PlatformData) ctx.getInputList();
			pw.write("[DataSets]\n");
			pw.write(debug.detail(inData.getDataSetList()));
			pw.write("\n[Variables]\n");
			pw.write(debug.detail(inData.getVariableList()));
			
			pw.write("======================= OUTDATA ========================\n");
			PlatformData outData = (PlatformData) ctx.getOutputList();
			pw.write("[DataSets]\n");
			pw.write(debug.detail(outData.getDataSetList()));
			pw.write("\n[Variables]\n");
			pw.write(debug.detail(outData.getVariableList()));
			
			System.out.println( sw.toString() );
			pw.close();
			sw.close();
		}
		
		if ( ctx != null ) {
			ctx.sendData();
		}
	}
%>