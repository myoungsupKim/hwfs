package com.hwfs.sc.cmn.util.namo;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeUtility;

import org.hamcrest.core.Is;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.cmn.exception.BizException;


 /**
 * NamoMimeToHtml에 대한 설명 작성
 * Mime으로 저장된 파일을 Html으로 저장한다.
 * @ClassName NamoMimeToHtml.java
 * @Description NamoMimeToHtml Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 4.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 6. 4.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class NamoMimeToHtml {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	class MimePart
	{
		private String bodypart;
		private String contentType;
		private String contentID;
		private String encoding;
		private String name;

		public void setName(String name)
		{
			String convstr = CodeConverter.getMIMEEncodedString(name);
			if(convstr != null)
				this.name = convstr;
			else
				this.name = name;
		}

		public String getName()
		{
			return name;
		}

		public void setBodypart(String part)
		{
			bodypart = part;
		}

		public String getBodypart()
		{
			return bodypart;
		}

		public void setContentType(String contentType)
		{
			this.contentType = contentType;
		}

		public String getContentType()
		{
			return contentType;
		}

		public void setContentID(String contentID)
		{
			this.contentID = contentID;
		}

		public String getContentID()
		{
			return contentID;
		}

		public void setEncoding(String encoding)
		{
			this.encoding = encoding;
		}

		public String getEncoding()
		{
			return encoding;
		}
	}

	/**
	파싱에 사용되는 상태값들
	*/
	final static class MIME
	{
		public static int begin = 0;
		public static int header = 1;
		public static int body = 2;
		public static int end = 3;

	};

	// multipart 인가?
	private boolean multipart;
	// multipart 인 경우 바운더리는?
	private String boundary;
	// 디코드할 파트들
	private List<MimePart> decodePart;
	// save Path
	private String savePath;
	// save URL
	private String saveURL = "";

	/**
	 * 첨부 파일을 저장할 위치를 지정합니다.
	 */
	public void setSavePath(String path)
	{
		savePath = path;
	}

	/**
	 * 첨부 파일을 억세스할수 있는 URL을 지정합니다.
	 */
	public void setSaveURL(String url)
	{
		saveURL = url;
	}

	/**
	 * MIME 데이터의 형식을 검사한다.
	 */
	protected void checkMimeType(String encodedString) throws Exception, IOException
	{
		String line, data;
		int pos = 0;
		BufferedReader br = null;
		
		try {
			br = new BufferedReader(new StringReader(encodedString));
	
			data = null;
	
			while(true)
			{
				line = br.readLine();
				line.trim();
				if(line == null || line.length() <= 0)
					break;
				data += line;
			}
			if(data.length() <= 0)
				throw new BizException("Not found MIME Header");
			line = data.toLowerCase();
			pos = line.indexOf("content-type");							// find content-type
			if(pos == -1)
				throw new BizException("Not found content-type");
			pos = line.indexOf("multipart", pos + 1);					// find multipart directive
			if(pos != -1)
				this.multipart = true;
			else
				this.multipart = false;
			pos = line.indexOf("boundary", pos + 1);					// find boundary
			if(pos == -1 && this.multipart)
				throw new BizException("Not found boundary");
			pos = data.indexOf("\"", pos + 1);							// find boundary data
			if(pos == -1 && this.multipart)
				throw new BizException("Not found boundary");
			if(this.multipart)
				this.boundary = data.substring(pos + 1, data.indexOf("\"", pos + 1));
		}
		catch (Exception ept) {
			logger.error(ept.getMessage());
		}
		finally {
			if (br != null) br.close();
		}
	}

	/**
	 * 하나의 MIME Part를 헤더, 본문 으로 분리한다.
	 */
	protected void splitSinglePart(String encodedString) throws IOException
	{
		BufferedReader br = null;
		String line = null;																// 현재줄
		String compare = null;
		String body = ""; //new String();
		MimePart part = new MimePart();
		int nowState = MIME.begin;

		try {
			br = new BufferedReader(new StringReader(encodedString));		// 한줄씩 읽기 위해서 스트림을 할당
	
			while(((line = br.readLine()) != null) && nowState != MIME.end)							// 한줄씩 읽어 들인다
			{
				line = line.trim();
				if(line.length() == 0 && nowState == MIME.begin)										// 시작부분에 있는 공백 무시
					continue;
				else
				{
					if(nowState == MIME.begin)															// 이전 상황에 시작이었으면 헤더상태로
						nowState = MIME.header;
	
					compare = line.toLowerCase();														// 모두 소문자로 변경
					if(nowState == MIME.header)
					{
						if(compare.indexOf("mime-version") != -1)										// MIME Version은 저장하지 않는다
						{
							continue;
						}
						else if(compare.indexOf("content-type") != -1)									// content type
						{
							part.setContentType(compare.substring(compare.indexOf(':') + 1).trim());
						}
						else if(compare.indexOf("content-transfer-encoding") != -1)						// encoding type
						{
							part.setEncoding(line.substring(line.indexOf(':') + 1).trim());
						}
						else if(compare.indexOf("content-id") != -1)									// CID
						{
							compare = line.substring(line.indexOf("&amp;lt;") + 1, line.indexOf("&amp;gt;"));
							part.setContentID(compare);
						}
						else if(compare.indexOf("name") != -1)											// File name
						{
							compare = line.substring(line.indexOf('\"') + 1, line.length() - 1);
							part.setName(compare);
	
						}
						else if(compare.length() == 0)													// 헤더 상태에서 공백이 오면 본문상태로 전환 ^__^
						{
							nowState = MIME.body;
						}
					}
					else if(nowState == MIME.body)														// MIME 본문
					{
	
						if(line.length() == 0 && multipart)												// 본문 끝
							nowState = MIME.end;
						else
						{
							body = body + line;
							break;
						}
					}
				}
			}
	
			if(nowState == MIME.body &&line != null) {
				body = encodedString.substring(encodedString.indexOf(line));
			}
		}
		catch (Exception ept) {
			logger.error(ept.getMessage());
		}
		finally {
			if (br != null) br.close();
		}
		
		part.setBodypart(body);																		// MIME 본문 셋팅
		decodePart.add(part);
	}
	// MultiPart 인 경우 나눈다
	protected void splitMultiPart(String encodedString) throws IOException
	{
		String part = null;
		int start = 0;
		int pos = 0;

		while(true)
		{
			pos = encodedString.indexOf("--" + boundary, start);													// 바운더리를 찾는다
			if(pos == -1)																			// 다음 바운더리가 없는 경우 패스
				break;
			start = encodedString.indexOf("--" + boundary, pos + boundary.length() + 2);
			if(start == -1)
				break;
			part = encodedString.substring(pos + boundary.length() + 2, start);
			splitSinglePart(part);
		}
	}

	// MIME 을 part 별로 나누고, 정보를 분석한다
	protected void splitMimePart(String encodedString) throws IOException
	{
		if(this.multipart)						// 멀티 파트인경우
		{
			splitMultiPart(encodedString);
		}
		else									// 싱글 파트인경우
		{
			splitSinglePart(encodedString);
		}
	}

	/**
	 * MIME을 디코딩한다.
	 */
	public boolean decode(String encodedString) throws Exception, IOException
	{
		//int i = 0;
		//MimePart part;
		decodePart = null;
		decodePart = new ArrayList<MimePart>(); //Vector<MimePart>();
		checkMimeType(encodedString);
		splitMimePart(encodedString);

		return true;
	}

	/**
	 * 원본 문자열에서 특정 문자열을 찾아서 새 문자열로 치환한다.
	 */
	public String replace(String original, String oldstr, String newstr)
	{
		String convert = ""; //new String();
		int pos = 0;
		int begin = 0;
		pos = original.indexOf(oldstr);

		if(pos == -1)
			return original;

		while(pos != -1)
		{
			convert = convert + original.substring(begin, pos) + newstr;
			begin = pos + oldstr.length();
			pos = original.indexOf(oldstr, begin);
		}
		convert = convert + original.substring(begin);

		return convert;
	}

	/**
	 * 첨부된 파일이 있을 경우 CID 링크 내용을 저장한 파일 이름으로 변경한다.
	 */
	protected String changeCIDPath(String content)
	{
		int i = 0;
		String convert;
		MimePart part;
		convert = content;
		for( i = 1; i < decodePart.size(); i++)
		{

			part = (MimePart)decodePart.get(i); //.elementAt(i);
			if(part.getContentID() != null)
			{
				String contentID = replace(part.getContentID(), "amp;lt;", "");
				if(saveURL.length() <= 0)
					convert = replace(convert, "cid:" + contentID, part.getName());
				else
					convert = replace(convert, "cid:" + contentID, saveURL + "/" + part.getName());
			}
		}

		return convert;
	}

	/**
	 * HTML본문 또는 TEXT 메시지 내용을 반환한다.
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("resource")
	public String getBodyContent() throws Exception, UnsupportedEncodingException
	{
		MimePart part;
		byte [] decodeByte;
		String decodeText = "";
		
		if(decodePart.size() <= 0)
			return null;

		part = (MimePart)decodePart.get(0);//elementAt(0);
		decodeText = part.getBodypart();

		if(part.getEncoding() == null)																	// 인코딩 타입이 없으므로 인코딩 하지 말것
			return part.getBodypart();
		
		InputStream is = null;
		
		try
		{
			is = new ByteArrayInputStream(part.getBodypart().getBytes("iso-8859-1"));		// iso-8859-1 String 을 바이트로 바꿔서 입력 스트림으로 바꾼다. 이때 인코딩 타입을 iso-8859-1로 셋팅한다
			try
			{
				is = MimeUtility.decode(is, part.getEncoding());										// 디코딩
			}
			catch(Exception me)
			{
				logger.error(me.getMessage());
				throw me;
			}

			decodeByte = new byte[is.available() + 1];													// 바이트배열로 읽어 들인다
			is.read(decodeByte);
		}
		catch(IOException ioe)
		{
			logger.error(ioe.getMessage());
			throw ioe; //new Exception("Cannot create input stream");
		}
		finally {
			if (is != null) is.close();
		}
		
		//decodeText = new String(decodeByte, "euc-kr");															// 스트링으로 바꾼다
		decodeText = new String(decodeByte, "UTF-8");	
		
		
		if(multipart)
		{
			decodeText = changeCIDPath(decodeText);
		}
		return decodeText;
	}

	/**
	 * MIME에 첨부된 파일을 저장한다. 반드시 decode()메쏘드를 먼저 콜해야 한다.
	 */
	@SuppressWarnings("resource")
	public void saveFile(String conId) throws Exception // MimeDecodeException
	{
		File outFile;
		OutputStream os;
		InputStream is;
		MimePart part;
		String fileName;
		byte [] fileContent;
		int i;

		for(i = 1; i < decodePart.size(); i++)
		{
			outFile = null;
			os = null;
			is = null;
			fileContent = null;


			part = (MimePart)decodePart.get(i); //elementAt(i);

			// Test
			// Mime file 을 가져온다
			try
			{
				is = new ByteArrayInputStream(part.getBodypart().getBytes("utf-8"));				// String을 byte array로 바꾼다 iso-8859-1
				is = MimeUtility.decode(is, part.getEncoding());										// MIME Decoding을 한다
				fileContent = new byte [is.available() + 1];											// byte 배열로 디코딩 내용을 가져온다
				is.read(fileContent);
				String fn = part.getName();
				fileName = getWritableFileName(part.getName(), conId);
				part.setName(fileName);
			
				String fn1 = getWritableFileName(savePath + "/" + fn, "");
				
				outFile = new File(fn1);									// 파일을 새로 생성한다
				os = new FileOutputStream(outFile);														// 파일에 저장한다
				os.write(fileContent);
				//os.close();																				// 스트림을 닫는다
				
				File f = new File(savePath + "/" + fileName);
				outFile.renameTo(f);
				
			}
			catch(Exception e)
			{
				logger.error(e.getMessage());

				throw e;// new Exception("Cannot create file");
			}
			finally {
				if (is != null) is.close();
				if (os != null) os.close();
			}
			
			/*catch(IOException ioe)
			{
				throw ioe;// new Exception("Cannot write file");
			}
			catch(MessagingException me)
			{
				throw me; //new Exception("Cannot decode file");
			}*/
		}
	}

	/**
	 * 저장이 가능한 파일 이름을 정한다.
	 */
	public String getWritableFileName(String fileName, String conId)
	{
		String writableName = fileName;

		String name = null;
		String ext = null;
		
		if ("".equals(conId)) {
			name = fileName.substring(0, fileName.lastIndexOf('.'));
			ext = fileName.substring(fileName.lastIndexOf('.'));
			writableName = name + ext;
		}
		else {
			name = conId; //fileName.substring(0, fileName.lastIndexOf('.'));
			ext = fileName.substring(fileName.lastIndexOf('.'));
			writableName = name + ext;
		}
		
		File writeFile = new File(savePath + "/" + writableName);
		int i = 0;
		
		while(writeFile.exists())
		{
			writableName = name + "[" + Integer.toString(i) + "]" + ext;
			writeFile = null;
			writeFile = new File(savePath + "/" + writableName);
			i++;
		}
		return writableName;
	}

	/**
	 * Default Contructor
	 */
	public NamoMimeToHtml()
	{
		multipart = false;
		boundary = null;
	}

	/**
	 * MIME Decoding 테스트용 main 함수
	 * @throws UnsupportedEncodingException
	 *//*
	static public void main(String []argv) throws MimeDecodeException
	{
		NamoMimeToHtml test = new NamoMimeToHtml();
		byte [] content;
		String strContent = null;
		try
		{
			InputStream is = new FileInputStream("C:/TEST/55297.bbs");
			content = new byte[is.available() + 1];
			is.read(content);
		}
		catch(FileNotFoundException fnfe)
		{
			return;
		}
		catch(IOException ioe)
		{
			return;
		}

		try {
			strContent = new String(content, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		try
		{
			test.setSaveURL("http://localhost:8080");
			test.setSavePath("C:/TEST");
			test.decode(strContent);	// saveFile을 하기전에 decode를 먼저 실행해야 한다.
			test.saveFile();
			System.out.println(test.getBodyContent());
		}
		catch(IOException ioe)
		{
			return ;
		}
	}*/
}
