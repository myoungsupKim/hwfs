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

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

/**
 * @author : 박성수
 * 
 */
public class MultipartUploader extends HttpBaseConnector {

	protected String target;
	
	protected List attachList;
	private List parameters;
	protected long fileSize;
	protected long fileSizeLimit;
	
	private PostMethod method;

	/**
	 * 생성자
	 * @param host 호스트명
	 * @param port 포트
	 * @throws Exception
	 */
	public MultipartUploader(String host, String port) throws Exception {
		super(host, port);
		attachList = new ArrayList();
		parameters = new ArrayList();
		fileSize = 0;
//		fileSizeLimit = 1024*1000*30;	// 30MB
		fileSizeLimit = 1024*1000*150;	// 150MB  //건설이관 때문에 용량 늘림  2010.03
	}	
	
	/**
	 * 업로드 파일 추가
	 * @param fileName  (사용자에게 보여질) 파일명 or 문서명
	 * @param file      파일
	 * @throws Exception
	 */
	public void addFile(String fileName, File file) throws Exception {
		if ( file == null ) {
			throw new Exception("addFile(String fileName, File file)에 file이 NULL 입니다.");
		}
		if ( !file.exists() ) {
			throw new Exception("addFile(String fileName, File file) 존재하지 않는 파일입니다. file : " + file.getAbsolutePath());
		}
		
//		attachList.add(new FilePart(urlEncoding(fileName), file));
		// Part 소스를 패치함으로써 urlEncoding 작업이 필요 없어졌음.
		// hanwha.commons.httpclient.methods.multipart.Part  sendDispositionHeader(OutputStream out)
		attachList.add(new FilePart(fileName, file));
		fileSize += file.length();
		if ( fileSize >= fileSizeLimit ) throw new Exception("첨부 제한크기인 30MB 를 초과하였습니다. [totalSize : " + fileSize + "]");
	}

	/**
	 * 업로드 파일 추가
	 *  - 위의 메소드와 같으나 파일에서 파일명을 얻어오지 않게 하기 위해 FilePartSource를 직접 지정함
	 *  - POST 전송시 지정한 fileName을 동일하게 넘길 수 있음
	 *  - 한화화약 연동에 적용하기 위해 최초 작성됨
	 * @param fileName  (사용자에게 보여질) 파일명 or 문서명
	 * @param file      파일
	 * @throws Exception
	 */
	public void addFileWithName(String fileName, File file) throws Exception {
		if ( file == null ) {
			throw new Exception("addFile(String fileName, File file)에 file이 NULL 입니다.");
		}
		if ( !file.exists() ) {
			throw new Exception("addFile(String fileName, File file) 존재하지 않는 파일입니다. file : " + file.getAbsolutePath());
		}

		FilePartSource fps = new FilePartSource(fileName, file);
		FilePart fp = new FilePart(fileName, fps);
		attachList.add(fp);
		fileSize += file.length();
		if ( fileSize >= fileSizeLimit ) throw new Exception("첨부 제한크기인 30MB 를 초과하였습니다. [totalSize : " + fileSize + "]");
	}

	public void addFileFromString(String fileName, String contents, String enc) throws Exception {
		if ( contents == null ) {
			throw new Exception("addFileFromString(String fileName, String contents)에 contents가 NULL 입니다.");
		}

		StringFilePartSource sp = new StringFilePartSource(fileName, contents, enc);
		attachList.add(new FilePart(fileName, sp));
	}

	/**
	 * 전송 (결과값으로 업로드 결과가 성공했는지 여부를 내부적으로 판단한 후 XML String 리턴)
	 * @return 결과 XML
	 * @throws Exception
	 */
	public String submit() throws Exception {
		method = new PostMethod(getTarget());
		
		Part[] parts = new Part[attachList.size()+parameters.size()];
		
		int i=0;
		
		for(Iterator iter=attachList.iterator(); iter.hasNext(); i++) {
			parts[i] = (Part)iter.next();
		}
		for(Iterator iter=parameters.iterator(); iter.hasNext(); i++) {
			//method.addParameter((NameValuePair)iter.next());
			NameValuePair nvp = (NameValuePair)iter.next();
			parts[i] = new StringPart(nvp.getName(), nvp.getValue(), "UTF-8");
		}
		MultipartRequestEntity mre = new MultipartRequestEntity(parts, method.getParams());
		method.setRequestEntity(mre);
		
		if ( getHeaderList() != null ) {
			for(Iterator headerIter=getHeaderList().keySet().iterator(); headerIter.hasNext(); ) {
				String hKey = (String)headerIter.next();
				String hValue = (String)getHeaderList().get(hKey);
				method.setRequestHeader(hKey, hValue);
			}
		}
		
		executeMethod(method);
		
		method.releaseConnection();
		
		return getResultMessage();
	}
	
	public void releaseConnection() {
		if ( method != null ) method.releaseConnection();
	}
	
	public void addParameter(String key, String value) throws Exception {
//		if ( value != null ) value = fromEncode(value);
		parameters.add(new NameValuePair(key, value));
	}
	

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		setTarget(target, false);
	}
	
	public void setTarget(String target, boolean fl) {
//		Crypt cry = new Crypt();
		try {
			this.target = target;
			if ( fl ) {
				this.target += "&loginName="+"BGsomsVBse0="+"&passwd="+"spNmmO7G719f0cna5RtzlQ=="+"&forcedLogin=true";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
	

	public String getResponseCharset() {
		return method.getResponseCharSet();
	}


}
