package com.hwfs.fm.fmc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

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
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fmc.service.DistributionRequestRptProcService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;


 /**
 * 물류요청서처리하는 DistributionRequestRptProc Controller
 * 
 * @ClassName DistributionRequestRptProcController.java
 * @Description DistributionRequestRptProcController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최영준
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmc/distributionRequestRptProc/")
public class DistributionRequestRptProcController extends DefaultController {

	/** DistributionRequestRptProcService Bean 생성 */
	@Resource(name = "/fm/fmc/distributionRequestRptProcService")
	private DistributionRequestRptProcService distributionRequestRptProcService;
	
	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/**
	 * 물류요청서 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param parameter
	 *            XplatformMapDTO XPLATFORM에서 전달된 MAP
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		RecordSet rs = distributionRequestRptProcService.selectList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 물류요청서처리의 각 문서의 첨부파일을 찾는다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param parameter
	 *            DistributionRequestRptProcDTO XPLATFORM에서 전달된 DTO
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("searchFile.xdo")
	public ModelAndView selectFile(@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		String strRefSeq = (String) inVar.get("refSeq");
		
		//첨부파일 조회 Service 호출
		List<Map> dsFileList = attachFileService.selectList(strRefSeq);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_file", dsFileList);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 첨부파일은 파일의 첨부참조일련번호를 찾는다.
	 * <pre>
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
	public ModelAndView saveSampleAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  ,	HttpServletRequest req) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();
		
		//Service호출에 전달할 DataSetMap을 얻는다.
		DataSetMap listFile = (DataSetMap) inDataset.get("ds_file");	//첨부파일 정보

		//서비스 호출 후 첨부참조일련번호가 반환된다.
		String strRefSeq = distributionRequestRptProcService.saveAttachFile(listFile, inVar);
		
		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		addOutVariable(mav, "fv_RefSeq", strRefSeq);
		
		//(중요)첨부파일정보가 바뀌므로 재조회 하여 클라이언트에 전달한다.
		//첨부파일 조회 Service 호출
		if (!"".equals(strRefSeq)) {
			List<Map> sampleFileList = attachFileService.selectList(strRefSeq);
			addOutDataSet (mav, "ds_file", sampleFileList);
		}
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
	
	}
	
	
	/**
	 * 물류요청서 마스터 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param parameter
	 *            XplatformMapDTO XPLATFORM에서 전달된 MAP
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectMast.xdo")
	public ModelAndView selectMast(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		RecordSet rs = distributionRequestRptProcService.selectMast(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listMast", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 물류요청서(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param parameter
	 *            XplatformMapDTO XPLATFORM에서 전달된 DTO List 
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		DataSetMap paramListMast = param.get("ds_listMast");

		int processCnt = distributionRequestRptProcService.saveList(parameter);
		int processCnt2 = distributionRequestRptProcService.saveListMast(paramListMast);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
}