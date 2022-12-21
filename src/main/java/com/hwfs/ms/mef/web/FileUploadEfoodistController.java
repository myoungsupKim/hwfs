package com.hwfs.ms.mef.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.ms.mef.dto.FileUploadEfoodistDTO;
import com.hwfs.ms.mef.service.FileUploadEfoodistService;


 /**
 * E-FOODIST등록관리(파일첨부)하는 FileUploadEfoodist Controller
 * 
 * @ClassName FileUploadEfoodistController.java
 * @Description FileUploadEfoodistController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 :  E-FOODIST(런타임,모바일) 강대성
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ms/mef/fileUploadEfoodist/")
public class FileUploadEfoodistController extends DefaultController {	
	/** Guide Sample Service */
	@Resource(name="/ms/mef/fileUploadEfoodistService")
	private FileUploadEfoodistService fileUploadEfoodistService;
	
	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	
	/**
	 * 단일 건과 첨부파일 select 문이 수행되는 서비스이다.
	 * @param xpDTO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "selectAttachFile.xdo")
	public ModelAndView selectAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//데이터 조회 Service 호출
		RecordSet fileUploadEfoodistList = fileUploadEfoodistService.selectList(inVar);
		
		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (fileUploadEfoodistList.size() > 0) {
			Map map = fileUploadEfoodistList.get(0);
			if (map.get("refSeq") != null)
				strRefSeq =  map.get("refSeq").toString(); //필드명이 "refSeq"인 경우임
		}
		
		//첨부파일 조회 Service 호출
		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//조회결과를 전달할 DataSet 설정
		addOutDataSet (mav, "ds_list", fileUploadEfoodistList);		//데이터
		addOutDataSet (mav, "ds_file", fileList);	//첨부파일 정보
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 단일 건과 첨부파일 select 문이 수행되는 서비스이다.
	 * @param xpDTO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "selectDetailAttachFile.xdo")
	public ModelAndView selectDetailAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//데이터 조회 Service 호출
		RecordSet fileUploadEfoodistList = fileUploadEfoodistService.selectDetailList(inVar);
		
		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (fileUploadEfoodistList.size() > 0) {
			Map map = fileUploadEfoodistList.get(0);
			if (map.get("refSeq") != null)
				strRefSeq =  map.get("refSeq").toString(); //필드명이 "refSeq"인 경우임
		}
		
		//첨부파일 조회 Service 호출
		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//조회결과를 전달할 DataSet 설정
		addOutDataSet (mav, "ds_list", fileUploadEfoodistList);		//데이터
		addOutDataSet (mav, "ds_file", fileList);	//첨부파일 정보
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 단일 건과 첨부파일 select 문이 수행되는 서비스이다.
	 * @param xpDTO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "selectPopList.xdo")
	public ModelAndView selectPopList(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
		
		// ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//데이터 조회 Service 호출
		RecordSet dsList = fileUploadEfoodistService.selectPopList(parameter.get("ds_search").get(0));
		
		addOutDataSet (mav, "ds_list", dsList);	//첨부파일 정보
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * DataSet의 rowType별로 Insert, Update, Delete가 수행되는 서비스이다.
	 * <pre>
	 * -데이터와 첨부파일을 함께 처리한다.
	 * -첨부파일은 파일 저장소에 저장한다.
	 * </pre>
	 * 
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	//@ValidationToken
	@RequestMapping(value = "saveAttachFile.xdo")
	public ModelAndView saveAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  ,	HttpServletRequest req) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();
		
		//Service호출에 전달할 DataSetMap을 얻는다.
		DataSetMap list = (DataSetMap) inDataset.get("ds_list");		//데이터
		DataSetMap listFile = (DataSetMap) inDataset.get("ds_file");	//첨부파일 정보

		//서비스 호출 후 첨부참조일련번호가 반환된다.
		String strRefSeq = fileUploadEfoodistService.saveAttachFile(list, listFile);
		
		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		addOutVariable(mav, "fv_RefSeq", strRefSeq);
		
		//(중요)첨부파일정보가 바뀌므로 재조회 하여 클라이언트에 전달한다.
		//첨부파일 조회 Service 호출
		if (!strRefSeq.equals("")) {
			List<Map> fileList = attachFileService.selectList(strRefSeq);
			addOutDataSet (mav, "ds_file", fileList);
		}
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
	}	
	
}
