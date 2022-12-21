/**
 * Copyright 2009 by HANWHA S&C Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HANWHA S&C Corp. ("Confidential Information").  You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with HANWHA S&C Corp.
 */
package hanwha.neo.modules.agent;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

/**
 * @author : 박성수
 * 
 */
public class HttpBaseConnector {

	private Map headerList; 
	
	private String resultMessage;
	private int statusCode;
	private String statusMessage;
	private InputStream resultStream;
	
	private String charset;
	
	protected HttpClient httpClient;
	protected HttpClient getHttpClient(){
		return httpClient;
	}
	
	protected HttpBaseConnector(String host, String port) throws Exception {
		this(host, port, false);
	}	
	
	protected HttpBaseConnector(String host, String port, boolean setMultiThreadedConnection) throws Exception {
		init(host, port, setMultiThreadedConnection);
	}	

	protected void init(String host, String port, boolean setMultiThreadedConnection) throws Exception {
		headerList = new HashMap();

		httpClient = (setMultiThreadedConnection) ? new HttpClient(new MultiThreadedHttpConnectionManager()) : new HttpClient();
		
		httpClient.getParams().setSoTimeout(1000*5);
		
		httpClient.getHostConfiguration().setHost(host, Integer.parseInt(port), "http");
	}
	
	
	public void addHeader(String key, String value) throws Exception {
		headerList.put(key, value);
	}
	
	public void removeHeader(String key) throws Exception {
		if ( headerList.containsKey(key) ) headerList.remove(key);
	}
	
	public void removeAllHeader() throws Exception {
		headerList.clear();
	}
	
	protected NameValuePair[] createParameter(Map map) throws Exception {
		return createParameter(map, true);
	}
	
	protected NameValuePair[] createParameter(Map map, boolean encoding) throws Exception {
//		logger.debug("map : " + map);
		NameValuePair[] nvPair = new NameValuePair[map.size()];
		Iterator iter = map.keySet().iterator();
		for(int i=0; iter.hasNext(); i++) {
			String key = (String)iter.next();
			String value = (String)map.get(key);
			if ( value != null ) value = fromEncode(value);
			nvPair[i] = new NameValuePair(key, value);
		}
		return nvPair;
	}	
	
	protected static String fromEncode(String str) {
        if (str == null)
            return null;
        try {
			return new String(str.getBytes("UTF-8"), "8859_1");
		} catch (UnsupportedEncodingException e) {
			System.out.println("fromEncode(String) : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
    }
	
	protected static String toEncode(String str) {
        if (str == null)
            return null;
        try {
			return new String(str.getBytes("8859_1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("toEncode(String) : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
    }
	
	protected static String urlEncoding(String str) {
        if (str == null)
            return null;
        try {
			return URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("urlEncoding(String) : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
    }	
	
	
	protected void executeMethod(HttpMethod method) throws Exception {
		try {
			httpClient.executeMethod(method);
			resultMessage = method.getResponseBodyAsString();
			statusCode = method.getStatusCode();
			statusMessage = method.getStatusText();
		} catch (Exception e) {
			throw e;
		} finally {
			method.releaseConnection();
		}
	}
	
	protected void executeMethodAsStream(HttpMethod method) throws Exception {
		try {
			httpClient.executeMethod(method);
			resultStream = method.getResponseBodyAsStream();
			statusCode = method.getStatusCode();
			statusMessage = method.getStatusText();
		} catch (Exception e) {
			throw e;
		} finally {
//			method.releaseConnection();
		}
	}	
	
	
//	protected InputStream executeMethodAsStream(HttpMethod method) throws Exception {
//		InputStream is = null;
//		try {
//			httpClient.executeMethod(method);
//			is = method.getResponseBodyAsStream();
//		} catch (Exception e) {
//			throw e;
//		} finally {
////			method.releaseConnection();
//		}
//		return is;
//	}


	public String getCharset() {
		return charset;
	}

	public void setCharset(String charset) {
		this.charset = charset;
	}

	public Map getHeaderList() {
		return headerList;
	}

	public String getResultMessage() {
		return resultMessage;
	}

	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatusMessage() {
		return statusMessage;
	}

	public void setStatusMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}

	public InputStream getResultStream() {
		return resultStream;
	}

	public void setTimeout(int milliseconds) {
		httpClient.getParams().setSoTimeout(milliseconds);
	}

}
