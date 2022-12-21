package com.ifis.sc.scc;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import org.apache.commons.io.output.FileWriterWithEncoding;

import com.hwfs.sc.cmn.util.namo.NamoMimeToHtml;
import com.sz.core.ServiceManagerFactory;

/**
 * Namo 관련 처리
 * 1) 저장 디렉토리는 ServiceManagerFactory.getProperty("WORK_DIR") 아래의 bbs/$bbs_id 로 읽어 온다.
 */
public class NamoWebUtility {

	/**
	 * 파일 디렉토리에 있는 Namo File 읽어들이기
	 * @param conId
	 * @return
	 * @throws Exception
	 */
	public static String getContents(String bbsId, String conId) throws Exception {
		String str = "";
		File f = getFile(bbsId, conId);
		if ( f.exists() ) {
			FileReader fr = new FileReader(f);
			BufferedReader r = new BufferedReader(fr);

			StringBuffer buf = new StringBuffer();
			try {
				while( (str = r.readLine()) != null ) {
						buf.append(str);
						buf.append("\n");
					}
					r.close();
					fr.close();
					str = buf.toString();
			} catch( Exception e) {
				throw e;
			} finally {
				if ( r != null ) {
					r.close();
				}
				if ( fr != null ) {
					fr.close();
				}
			}
		}

		return str;
	}

	/**
	 * 내용 쓰기
	 * @param bbsId
	 * @param conId
	 * @param conts
	 * @throws Exception
	 */
	public static String writeContents(String bbsId, String conId, String conts, boolean isMobile) throws Exception {
		File f = getFile(bbsId, conId);
		//f.deleteOnExit(); => 필요없을것....같은데....
		String url = "";

		FileWriter fw = null;
		try {
			fw = new FileWriter(f);
			fw.write(conts);
			fw.flush();

			if (isMobile) {
				//[[모바일 공지건
				String newDir = bbsId;
				if ( newDir.lastIndexOf(".0") != -1 ) {
					newDir = newDir.substring(0, newDir.length() -2);
				}

				String newFile = conId;
				if ( newFile.lastIndexOf(".0") != -1 ) {
					newFile = newFile.substring(0, newFile.length() -2);
				}

				File htmlDir = new File(ServiceManagerFactory.getProperty("global.imagerepository.path") + "/bbs/" + newDir + "/" + newFile);
				if (!htmlDir.exists()) {
					htmlDir.mkdirs();
				}

				NamoMimeToHtml mineToHtml = new NamoMimeToHtml();

				mineToHtml.setSaveURL(".");
				mineToHtml.setSavePath(ServiceManagerFactory.getProperty("global.imagerepository.path") + "/bbs/" + newDir + "/" + newFile);
				mineToHtml.decode(conts);	// saveFile을 하기전에 decode를 먼저 실행해야 한다.
				mineToHtml.saveFile(conId);
				String html = mineToHtml.getBodyContent();

				html = html.replaceAll("charset=euc-kr", "charset=utf-8");		
				
				File htmlFile = new File(htmlDir, newFile+".html");

				if (htmlFile.exists()) {
					htmlFile.delete();
				}

				FileWriterWithEncoding htmlFileWriter = new FileWriterWithEncoding(htmlFile, ServiceManagerFactory.getProperty("mobile.bbs.html.charset"));
				htmlFileWriter.write(html);
				htmlFileWriter.flush();
				htmlFileWriter.close();

				url = ServiceManagerFactory.getProperty("mobile.bbs.url") + "/" + newDir + "/" + newFile + "/" + newFile+".html";
				//모바일 공지건]]
			}
			else {
				url = "";
			}
		} catch( IOException e) {
			throw e;
		} finally {
			if ( fw != null ) {
				fw.close();
			}
		}

		return url;
	}
	/**
	 * 내용 삭제
	 * @param bbsId
	 * @param conId
	 * @param conts
	 * @throws Exception
	 */
	public static void deleteContents(String bbsId, String conId) throws Exception {
		File f = getFile(bbsId, conId);
		//f.deleteOnExit();

		try {
			f.delete();

		} catch( SecurityException e) {
			throw e;
		}
	}

	private static File getFile(String bbsId, String conId) throws Exception {
		if ( bbsId.lastIndexOf(".0") != -1 ) {
			bbsId = bbsId.substring(0, bbsId.length() -2);
		}

		if ( conId.lastIndexOf(".0") != -1 ) {
			conId = conId.substring(0, conId.length() -2);
		}

		String wk = ServiceManagerFactory.getProperty("WORK_DIR");

		File f = new File( wk + "/bbs/" + bbsId);
		if ( !f.exists() ) {
			f.mkdirs();
		}

		File conFile = new File(f, conId + ".bbs");
		return conFile;
	}
	
	public static Boolean checkContents(String contents) {
		
		String[] keyword = {"alert", "append", "cookie", "iframe", "frame"
							, "frameset", "object", "msgbox", "create"
							, "expression", "applet", "layer", "ilayer", "eval"
							, "javascript", "script"};
		
		for ( String s: keyword ) {
			if ( contents.toLowerCase().indexOf(s) != -1 ) {
				return false;
			}
		}
		
		return true;
	}
}
