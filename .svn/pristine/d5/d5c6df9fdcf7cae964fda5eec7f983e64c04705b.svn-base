package com.hwfs.sc.cmn.hqml.loader.web;

import hone.dbio.provider.HoneDbioProvider;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;
import com.hwfs.sc.cmn.hqml.loader.FileChangeListener;
import com.hwfs.sc.cmn.hqml.loader.FileMonitor;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;

 /**
 * HqmlAutoLoader에 대한 설명 작성
 * @ClassName HqmlAutoLoader.java
 * @Description HqmlAutoLoader Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 8.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 1. 8.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Controller
public class HqmlAutoLoader extends DefaultController implements FileChangeListener {
	WebApplicationContext webApplicationContext;
	HoneDbioProvider honeDbioProvider;
	FileMonitor fileMonitor;
	List<String> fileList = new ArrayList<String>();

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * fileList 얻기
	 *
	 * @return the fileList
	 */
	public List<String> getFileList() {
		return fileList;
	}

	/**
	 * fileList 설정
	 *
	 * @param fileList the fileList to set
	 */
	public void setFileList(List<String> fileList) {
		this.fileList = fileList;
	}

	public void fileChanged(String fileName) {
		BufferedReader in = null;
		String s = "";
		String content = "";
		String mode = "";
		try {
			mode = propertiesService.getString("run.mode");
			
			if ( "server".equalsIgnoreCase(mode) )	//운영
	        {
	        	logger.info("########### 운영시스템에서는 HqmlAutoLoader 기능을 사용할 수 없습니다. [ " + fileName + " ]###########");
	        	return;
	        }
			in = new BufferedReader(new FileReader(fileName));

			while ((s=in.readLine()) != null) {
				content += s + "\r\n";
			}
		}
		catch (FileNotFoundException e1) {
			logger.info(e1.getMessage());
		}
		catch (IOException e) {
			logger.info(e.getMessage());
		}

		try {
			honeDbioProvider.removeStatements(content);
			honeDbioProvider.updateStatements(content);

			logger.info(" ★★★★★★★  HQML 리로드 완료 [ " + fileName + " ] ★★★★★★★ ");
		}
		catch (Exception ept) {
			logger.info(" ★★★★★★★ ERROR ★★★★★★★ ");
			logger.info(ept.getMessage());
			logger.info(" ★★★★★★★  HQML 리로드 에러 [ " + fileName + " ] ★★★★★★★ ");
		}
	}

	@RequestMapping("/sc/cmn/hqml/loader/hqmlAutoLoader.xdo")
	public ModelAndView test(@Bind(id="", type=XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) {
		ModelAndView mav = createModelAndView();

		webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		honeDbioProvider = (HoneDbioProvider)webApplicationContext.getBean("hone.dbio.provider.StatementProvider");
		fileMonitor = FileMonitor.getInstance();

		subDirList("C:\\HWFS_DEV\\workspace\\hwfs\\src\\main\\resources\\hqml");

		try {
			for (int i = 0 ; i < this.fileList.size() ; i++)
				fileMonitor.addFileChangeListener(this, this.fileList.get(i));
		}
		catch (Exception e) {
			logger.debug(e.getMessage());
		}

		return setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	private void subDirList(String source) {
		File dir = new File(source);
		File[] fileList = dir.listFiles();

		try {
			for (int i = 0 ; i < fileList.length ; i++) {
				File file = fileList[i];

				if (file.isFile())
					this.fileList.add(file.getPath());
				else if (file.isDirectory())
					subDirList(file.getCanonicalPath().toString());
			}
		}
		catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
}
