<!-- 2007.11.13 charset 위치를 각 JSP 파일에 입력 -->
<%@page import="com.tobesoft.xplatform.tx.HttpPlatformResponse"%>
<%@page import="com.tobesoft.platform.PlatformResponse"%>
<%@page import="com.tobesoft.xplatform.tx.PlatformException"%>
<%@page import="com.tobesoft.xplatform.tx.HttpPlatformRequest"%>
<%@page import="com.tobesoft.xplatform.tx.PlatformType"%>
<%@page import="com.tobesoft.xplatform.tx.PlatformRequest"%>
<%@page import="com.tobesoft.xplatform.data.*"%>
<%@page import="com.sz.service.sqlmap.xplatform.DataSetResultSet"%>
<%@ page language="java"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.sql.*" %>

<%@page import="com.sz.service.resource.TransactionResource"%>
<%@page import="com.sz.service.resource.ResourceFactory"%>
<%@page import="com.sz.core.ServiceManagerFactory"%>
<%@page import="com.sz.service.log.*"%>
<%-- [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가 --%>
<%@page import="com.hwfs.sc.cmn.util.Const"%>
<%@page import="com.hwfs.sc.cmn.util.NamedParameterStatement"%>
<%@page import="com.hwfs.sc.cmn.util.StringUtil"%>
<%@page import="com.hwfs.sc.cmn.util.ValidationUtil"%>
<%-- [속도개선 Project   끝] 2017. 8. 4. 최범주 --%>


<!-- 접근로그 공통 패키지 추가 by kksoo -->
<%@ page import="java.io.*
			   , java.util.*
			   , com.hwfs.cmn.util.SessionUtil
			   , com.hwfs.cmn.log.AccessLogService
			   , com.hwfs.sc.cmn.dto.LoginDTO
			   , com.hwfs.sc.cmn.util.BeanUtil
			   , com.hwfs.sc.cmn.util.DataSetMapUtil
			   , org.springframework.context.support.MessageSourceAccessor"%>

<!-- TOBE방식 사용자별 로그 처리를 위한 패키지 추가 by kksoo -->
<%@ page import="com.hwfs.cmn.log4jsp.UserIdLogService"%>
			   
<%@page session="false" %>	<!-- (중요)세션을 새로 생성하지 못하게 설정 by kksoo -->

<%!
	String RESOURCE_SVC_NAME = "JSPJdbcConnectionFactory";
	AccessLogService accessLogService = null;		//접근로그를 위해 추가 by kksoo
	MessageSourceAccessor messageService = null;	//MessageService by kksoo
	UserIdLogService userLogger = null;				//사용자별 로그 처리를 위한 logger by kksoo
%>
<%
	
	Connection conn = null; //Connection 객체
	Logger logger = null;
	
	String Insert_Sql = null;   // insert sql문으로 사용할 변수
	String Update_Sql = null;   // update sql문으로 사용할 변수
	String Delete_Sql = null;   // delete sql문으로 사용할 변수

	VariableList in_vl = new VariableList();     //input variable list
	DataSetList  in_dl = new DataSetList();     //input dataset list

	VariableList out_vl = new VariableList();    // output variable list
	DataSetList  out_dl = new DataSetList();    // output dataset list
	
	
	// sql에서 사용할 statement를 선언
	PreparedStatement pstmt= null;
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	NamedParameterStatement npstmt = null;
// [속도개선 Project   끝] 2017. 8. 4. 최범주	
	
	// sql결과를 받을 resultset 선언
	ResultSet rs = null;
	int rvalue=-1;
/*	
	String db_driver="oracle.jdbc.driver.OracleDriver"; 
	String db_url="jdbc:oracle:thin:@172.25.251.25:1621:FSDBTEST";
	String db_user="fstest"; 
	String db_password="fstest";   

	try
	{ 
		Class.forName(db_driver); 
		try
		{ 
			conn = DriverManager.getConnection(db_url,db_user,db_password); 
		//	System.out.println("연결성공"); 
		}catch(Exception e){ 
			System.out.println("DB에 연결할 수 없습니다." + e.toString()); 
			conn = null;
		} 
	}catch(ClassNotFoundException e){ 
		System.out.println("JDBC 드라이버를 찾을 수 없습니다." + e); 
		conn = null;
	} 
*/
	conn = getConnection("");
/*
	try
	{
		conn = getConnection("");
	}
	catch( Exception e )
	{
		System.out.println("####### common.jsp:getConnection() ########");
		e.printStackTrace();
		if ( conn != null )
		{
			try 
			{
				conn.close();
			}
			catch( Exception e1 ) {}  
    		}		
	}
*/	
	try {
		// jsp 시작 부분에 
		logger = (LogService)
			ServiceManagerFactory.getServiceObject("DefaultLogService");
		
		if (accessLogService == null)	//접근로그를 위해 추가 by kksoo
			accessLogService = (AccessLogService)BeanUtil.getBean(pageContext.getServletContext(), "accessLogService");

		if (messageService == null)		//접근로그를 위해 추가 by kksoo
			messageService = (MessageSourceAccessor)BeanUtil.getBean(pageContext.getServletContext(), "messageSourceAccessor");
		
		if (userLogger == null)			//사용자별 로그 처리를 위한 logger by kksoo
			userLogger = (UserIdLogService)BeanUtil.getBean(pageContext.getServletContext(), "/cmn/log/userIdLogService");

	} catch( Exception ee) {
		ee.printStackTrace();
	}
%>
<%!
//PlatformData in_data = null;	//threadsafe 하지 않아 제거 by kksoo
public String default_charset = "euc-kr";   //character set
//public String default_charset = "UTF-8";   //character set	KO16KSC5601

public String default_encode_method = PlatformType.CONTENT_TYPE_XML;
//public String default_encode_method = PlatformType.CONTENT_TYPE_BINARY; // PlatformRequest.ZLIB_COMP;
/**********************************
 * output variable에 message를 지정한다.
 *
 **********************************/
public void setResultMessage(int code, String msg,VariableList out_vl) 
{ 
	if (out_vl == null)
	    out_vl = new VariableList();
	
	out_vl.add("ErrorCode", code);
	out_vl.add("ErrorMsg", msg);
}
/*********************************************************
 * request로 들어온 내용을 parsing하여
 * input variable list, input dataset list에 저장한다.
 *********************************************************/
public PlatformRequest proc_input(HttpServletRequest request) throws ServletException, IOException 
{
	PlatformRequest platformRequest = new HttpPlatformRequest(request);
	
	try {
		platformRequest.receiveData();
	} catch( PlatformException e) {
		throw new IOException( e);
	}
	
	//in_data = platformRequest.getData();		//threadsafe 하지 않아 제거 by kksoo
	
	this.default_charset = platformRequest.getCharset();
	
	return platformRequest;
}

/*********************************************************
 * response로 작성된 output variable list,output dataset을
 * 보낸다.
 *********************************************************/
public void proc_output(HttpServletResponse response, JspWriter out,VariableList out_vl,DataSetList out_dl)  throws ServletException, IOException,Exception 
{   //-------------오류인 경우 접근로그에 저장 START by kksoo --------------
	if (out_vl != null && out_vl.getInt("ErrorCode") < 0) {
		accessErrorLog (out_vl.getString("ErrorMsg"));
	}
	
	//-------------오류인 경우 접근로그에 저장 END by kksoo --------------
	HttpPlatformResponse platformResponse = new HttpPlatformResponse(response
				, default_encode_method
				, default_charset);
	
	// 압축필요한 경우 
	// platformResponse.addProtocolType(PlatformType.PROTOCOL_TYPE_ZLIB);
	if (out_vl == null)
	    out_vl = new VariableList();

	if (out_dl == null)
	    out_dl = new DataSetList();

	PlatformData pData = new PlatformData();
	pData.setDataSetList(out_dl);
	pData.setVariableList(out_vl);
	
//	System.out.println("############################### out ##############################");
	out.clearBuffer();  // 가비지값들이 존재할수 있어서 out을 clear해준다.
	platformResponse.setData(pData);
	platformResponse.sendData();
}

/*********************************************************
 * resultset으로 부터 dataset을 생성한다.
 *********************************************************/
public DataSet makeDataSet(ResultSet rs,String strDataSet)  throws ServletException, Exception
{
	// 수정 	
	DataSetResultSet dsResult = new DataSetResultSet();
	dsResult.parseResultSet(rs);
	
	DataSet ds = (DataSet)dsResult.getResultObject();
	ds.setName(strDataSet);
	ds.setCharset(default_charset);
/*	
	DataSet(strDataSet,default_charset);
	ds.setUpdate(false);

	ResultSetMetaData rsmd = rs.getMetaData();     // select 한 정보
	int numberOfColumns = rsmd.getColumnCount();   // select한 컬럼수

	int    ColSize;

System.out.println(">>> NUMERIC " + Types.NUMERIC);
System.out.println(">>> DOUBLE " + Types.DOUBLE);
System.out.println(">>> VARCHAR " + Types.VARCHAR);
System.out.println(">>> DATE " + Types.DATE);
System.out.println(">>> INT " + Types.INTEGER);

	for ( int j = 1 ; j <= numberOfColumns ; j++ )
	{
		String Colnm = rsmd.getColumnName(j);
		int    ColType = rsmd.getColumnType(j);
		ColSize = rsmd.getColumnDisplaySize(j);

		// select한 컬럼의 type에 맞게 데이타셋 컬럼을 생성
		if ( ColType == Types.NUMERIC || ColType == Types.DOUBLE )
		{
			ds.addColumn(Colnm, ColumnInfo.CY_COLINFO_DECIMAL,ColSize);
		}
		else if ( ColType == Types.VARCHAR )
		{
			ds.addColumn(Colnm, ColumnInfo.CY_COLINFO_STRING,ColSize);
		}
		else if ( ColType == Types.DATE )
		{
			ds.addColumn(Colnm, ColumnInfo.CY_COLINFO_DATE,ColSize);
		}
		else if ( ColType == Types.INTEGER )
		{
			ds.addColumn(Colnm, ColumnInfo.CY_COLINFO_INT,ColSize);
		}
		else
		{
			ds.addColumn(Colnm, ColumnInfo.CY_COLINFO_STRING,ColSize);
		}
	}

	int Row = 0;
	int i;

	while(rs.next())
	{

		Row = ds.appendRow();   // 데이타셋 row 추가
		for ( i = 0 ; i < numberOfColumns ; i++ )
		{
			if ( ds.getColumnInfo(i).getColumnType() == ColumnInfo.CY_COLINFO_DATE )
			{
				ds.setColumn(Row,ds.getColumnID(i),new Variant(rs.getDate(ds.getColumnID(i))));  // 데이타저장
			}        
			else
			{
				ds.setColumn(Row,ds.getColumnID(i),new Variant(rs.getString(ds.getColumnID(i))));  // 데이타저장
			}        
		}	

	}
*/
	return ds;
}

/*******************************************************************
 * DataSet을 생성
 * ex) makeDataSet("output2");
 *******************************************************************/
public DataSet makeDataSet(String strDataSet)  throws ServletException, Exception
{
	return new DataSet(strDataSet,default_charset);
}

/*********************************************************
 * null인경우 empty string을 return
 *********************************************************/
public String checkNullString(String str)
{
	if ( str == null || str.equals("") ) str = "null";
	else str = "'" + replaceAll(str,"'","''") + "'";
	return str;
}
/*********************************************************
 * null인경우 empty string을 return
 * LIKE '%?%' 를 사용할 경우,
 *********************************************************/
public String checkNullStringLIKE(String str)
{
	if ( str == null || str.equals("") ) str = "null";
	else str = "'%" + replaceAll(str,"'","''") + "%'";
	return str;
}
/*********************************************************
 * null인경우 blank string을 return
 *********************************************************/
public String nullToBlank(String str) {
    if(str == null || str == "") str = "";
    return str;
}

/*********************************************************
 * null인경우 zero string을 return
 *********************************************************/
public String nullToZero(String str) {
    if(str == null || str.equals("")) str = "0";
    return str;
}

/*********************************************************
 * String을 float 으로 변경하여 return
 *********************************************************/
public float stringToFloat(String str) {
    float ft;

    if(str == null || str.equals("")) ft = 0;
    else ft = Float.parseFloat(str);

    return ft;
}

/*********************************************************
 * String을 입력한 소숫점 이하 자릿수만큼만 float 으로 변경하여 return
 *********************************************************/
public float stringToFloat(String str, int dp) {

    float ft;

    if(str == null || str.equals("")) {
        ft = 0;
    } else {
        if(str.indexOf('.') > 0) {
            String strInt = str.substring(0, str.indexOf('.'));
            String strDp  = str.substring(str.indexOf('.') + 1, str.length());

            if(strDp.length() > dp) {
                strDp = strDp.substring(0, dp);
            } else {
                strDp = strDp.substring(0, strDp.length());
            }

            str = strInt + "." + strDp;
        }

        ft = Float.parseFloat(str);
    }

    return ft;
}

public static String EucToUni(String s)
{
  try{
    if ( s == null )  return null;
    return new String(s.getBytes("8859_1"),"EUC-KR");
  }
  catch(Exception e){
    return s;
  }
}

public static String UniToEuc(String s)
{
  try{

    if ( s == null )  return null;
    return new String(s.getBytes("EUC-KR"),"8859_1");
  }
  catch(Exception e){
    return s;
  } 
}

public String replaceAll(String str, String pattern, String replace) {
    int e = 0, s = 0;
    StringBuffer result = new StringBuffer();

    while ((e = str.indexOf(pattern, s)) >= 0) {
      result.append(str.substring(s, e));
      result.append(replace);
      s = e+pattern.length();
    }
    result.append(str.substring(s));

    return result.toString();
}

/**************************************************************************
 * 현재 날짜/시간을 구해오는 함수
 **************************************************************************/
public int getTime(int section) {
    Calendar cal = Calendar.getInstance();
    return cal.get(section);
}

public String getYear() {
    return String.valueOf(getTime(Calendar.YEAR));
}

public String getMonth() {
    return String.valueOf(getTime(Calendar.MONTH));
}

public String getDay() {
    return String.valueOf(getTime(Calendar.DAY_OF_MONTH));
}

public String getHour() {
    return String.valueOf(getTime(Calendar.HOUR_OF_DAY));
}

public String getMinute() {
    return String.valueOf(getTime(Calendar.MINUTE));
}

public String getSecond() {
    return String.valueOf(getTime(Calendar.SECOND));
}

public String getNextDate(String strDate, int IncNum)
{
	DecimalFormat df = new DecimalFormat("00");
	Calendar cal = Calendar.getInstance();

	cal.clear();
	cal.set(Integer.parseInt(strDate.substring(0,4)), Integer.parseInt(strDate.substring(4,6))-1, Integer.parseInt(strDate.substring(6)));
	cal.add(cal.DATE, IncNum);

	String year = Integer.toString(cal.get(cal.YEAR));
	String month = df.format(cal.get(cal.MONTH) + 1);
	String day = df.format(cal.get(cal.DATE));

    return year + month + day;
}
/**************************************************************************/

public Connection getConnection(String dbStr) throws Exception {
	try {
		ResourceFactory mResourceFactory =(ResourceFactory)
					ServiceManagerFactory.getServiceObject(RESOURCE_SVC_NAME);
			
		TransactionResource res = mResourceFactory.makeResource(dbStr);
		
		return (Connection) res.getResource();
	} catch( Exception e ) {
		throw e;
	}	
}
/**
*	IRIS Connection 가져오기 
**/
public Connection getIRISConn() throws Exception {
	return getConnection("jdbc/irisdb");
}

/**********************************
 * 개인정보보호 조회 접근로그를 쌓는다. 조회조건과 조회건수 by kksoo
 **********************************/
public void accessReadLog(PageContext pageContext, DataSet dsCond, int cnt) 
{ 
	//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
	if (this.accessLogService != null)
		this.accessLogService.readLog(DataSetMapUtil.convertDataSet2DataSetMap(dsCond).get(0), cnt);
}

/**********************************
 * 개인정보보호 저장/삭제 접근로그를 쌓는다. by kksoo
 **********************************/
public void accessWriteLog(PageContext pageContext, Object[] objArgs) 
{ 
	//개인정보보호 접근로그를 쌓는다.	
	if (this.accessLogService != null && this.messageService != null)
		this.accessLogService.writeLog(this.messageService.getMessage("accesslog.message.write", objArgs));
}

/**********************************
 * 개인정보보호 오류 접근로그를 쌓는다. by kksoo
 **********************************/
public void accessErrorLog(String errMsg) 
{ 
	//오류 접근로그를 쌓는다.
	if (this.accessLogService != null) {
		this.accessLogService.errorLog(errMsg);
	}
}

%>