package com.hwfs.guide.sample.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.guide.sample.dto.GuideSampleDTO;
import com.hwfs.guide.sample.service.GuideSampleService;
import com.hwfs.guide.sample.service.GuideSampleMysqlService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;

 /**
 * GuideListController에 대한 설명 작성
 * @ClassName GuideListController.java
 * @Description GuideListController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.01.22.   김재섭       최초생성
 *  2015.02.02.   kksoo        첨부파일 추가
 *  2015.03.20.   kksoo        전자결재 연동 추가
 * </pre>
 * @author FC종합전산구축 : 공통 김재섭
 * @since 2015. 1. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/guide/sample/guideList/")
public class GuideListController extends DefaultController {
	/** Guide Sample Service */
	@Resource(name="/guide/sample/guideSampleService")
	private GuideSampleService guideSampleService;

	@Resource(name="/guide/sample/guideSampleMysqlService")
	private GuideSampleMysqlService guideSampleMysqlService;
	
	/** Guide Jdbc Service */
	//@Resource(name="/guide/sample/guideJdbcService")
	//private GuideJdbcService guideJdbcService;

	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;


	/**
	 * 조회를 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
    @ValidationToken
	@SuppressWarnings("unchecked")
	@RequestMapping("selectCcsTempList.xdo")
	public ModelAndView selectCcsTempList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

    	//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = new HashMap<String, Object>();

		RecordSet rs = guideSampleService.selectCcsTempList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_ccsTemp", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

    /**
	 * 저장을 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("saveCcsTempList.xdo")
	public ModelAndView saveCcsTempList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_ccsTemp");

		int processCnt = guideSampleService.saveCcsTempList(parameter);

		//XPlatform으로 넘겨줄 Out Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조회를 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
    @ValidationToken
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
    	//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);

		RecordSet rs = guideSampleService.selectList(parameter);
		//RecordSet rs = guideJdbcService.selectList(parameter);	//jdbc test

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 저장을 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = guideSampleService.saveList(parameter);
		//int processCnt = guideJdbcService.saveList(parameter);	//jdbc test

		//XPlatform으로 넘겨줄 Out Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조회를 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	@RequestMapping("selectListDTO.xdo")
	public ModelAndView selectListDTO(@Bind(id="ds_search", type=GuideSampleDTO.class) GuideSampleDTO parameter) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		RecordSet rs = guideSampleService.selectListDTO(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 저장을 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param insertParameter
	 * @param updateParameter
	 * @param deleteParameter
	 * @return
	 */
	@RequestMapping("saveListDTO.xdo")
	public ModelAndView saveListDTO(
			@Bind(id="ds_list:ins", type=GuideSampleDTO.class) List<GuideSampleDTO> insertParameter,
			@Bind(id="ds_list:upd", type=GuideSampleDTO.class) List<GuideSampleDTO> updateParameter,
			@Bind(id="ds_list:del", type=GuideSampleDTO.class) List<GuideSampleDTO> deleteParameter,
			HttpServletRequest request) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);

		int processCnt = guideSampleService.saveListDTO(loginDTO, insertParameter, updateParameter, deleteParameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

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
		RecordSet sampleList = guideSampleService.selectList(inVar);

		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (sampleList.size() > 0) {
			Map map = sampleList.get(0);
			if (map.get("refSeq") != null)
				strRefSeq =  map.get("refSeq").toString(); //필드명이 "refSeq"인 경우임
		}

		//첨부파일 조회 Service 호출
		List<Map> sampleFileList = attachFileService.selectList(strRefSeq);

		//조회결과를 전달할 DataSet 설정
		addOutDataSet (mav, "ds_list", sampleList);		//데이터
		addOutDataSet (mav, "ds_file", sampleFileList);	//첨부파일 정보

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
	public ModelAndView saveSampleAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO
		  ,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		Map <String, DataSetMap> inDataset = xpDTO.getInDataSetMap();

		//Service호출에 전달할 DataSetMap을 얻는다.
		DataSetMap list = (DataSetMap) inDataset.get("ds_list");		//데이터
		DataSetMap listFile = (DataSetMap) inDataset.get("ds_file");	//첨부파일 정보

		//로그인 세션 정보 얻기
		//LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//서비스 호출 후 첨부참조일련번호가 반환된다.
		String strRefSeq = guideSampleService.saveAttachFile(list, listFile);

		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		addOutVariable(mav, "fv_RefSeq", strRefSeq);

		//(중요)첨부파일정보가 바뀌므로 재조회 하여 클라이언트에 전달한다.
		//첨부파일 조회 Service 호출
		if (!strRefSeq.equals("")) {
			List<Map> sampleFileList = attachFileService.selectList(strRefSeq);
			addOutDataSet (mav, "ds_file", sampleFileList);
		}

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 그룹웨어 상신을 위한 첨부파일 목록을 얻는다.
	 * <pre>
	 * - 첨부 파일은 서버에 존재해야 하며, 파일이 있는 Full Path로 설정해야 한다.
	 * - 목록은 json 형태로 생성한다.
	 * </pre>
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "selectGwDraftAttachFile.xdo")
	public ModelAndView selectGwDraftAttachFile (
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (inVar.get("refSeq") != null)
			strRefSeq =  inVar.get("refSeq").toString();

		if (!strRefSeq.equals("")) {
			//첨부파일 조회 Service 호출
			List<Map> attachList = attachFileService.selectList(strRefSeq);

			//첨부파일정보는 파일이 있는 실제 위치를 설정해야 함 : 업무에 맞게 설정
			//"fileName", "filePath" 명칭은 고정
			List<Map<String, Object>> gwDraftAttachList = new ArrayList<Map<String, Object>>();
			for (int i=0; i<attachList.size(); i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put ("fileName", (String)attachList.get(i).get("orgnlFileNm"));
				map.put ("filePath", propertiesService.getString("global.filerepository.path")
								   + (String)attachList.get(i).get("relPath") +"/"
								   + (String)attachList.get(i).get("saveFileNm"));

				gwDraftAttachList.add(map);
			}
			//Json 형식으로 변환하여 outVariable로 반환
			JSONArray jsonList = new JSONArray( gwDraftAttachList );
			addOutDataSet (mav, "fv_attachList", jsonList.toString());
		}
		else
			addOutDataSet (mav, "fv_attachList", "");

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
	 * <pre>
	 * - RequestMapping은 .do로 해야 한다.
	 * - 상신을 위한 본문은 DB에서 쿼리하여 JSP를 이용하여 동적으로 HTML 본문을 만든다.
	 * - JSP 본문 양식은 WEB-INF/jsp에서 관리한다.
	 * - 본문 title 파라미터는 공통에서 전달한다.
	 * </pre>
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "makeGwDraftContent.do")
	public ModelAndView makeGwDraftContent (HttpServletRequest request, Model model
			, @RequestParam(value="searchId", required=true) String strId
			, @RequestParam(value="title", required=false, defaultValue="") String strBodyTitle) throws Exception {

		//상신 본문 데이터를 조회 - 업무에 맞게 조회
		Map<String, Object> parameter = new HashMap<String, Object>();

		RecordSet rs = guideSampleService.selectList(parameter);	//전체 목록 조회

		parameter.put("id", strId);
		RecordSet rs2 = guideSampleService.selectList(parameter);	//해당 건 조회

		//본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
		model.addAttribute("gwDraftInfo", rs2.get(0));
		model.addAttribute("gwDraftList", rs);

		//본문 타이틀 설정
		model.addAttribute("gwDraftTitle", strBodyTitle);

		//본문을 생성하는 JSP 호출
    	return new ModelAndView("/gw/guide/SampleGwDraft");
	}

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "saveSignInfo.xdo")
	public ModelAndView saveSignInfo(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		guideSampleService.saveSignInfo(parameter);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조회를 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
    @ValidationToken
	@RequestMapping("selectOrg.xdo")
	public ModelAndView selectOrg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

    	//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		RecordSet rs = guideSampleService.selectOrg();

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_org", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
    
    /**
	 * 조회를 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
    @ValidationToken
	@SuppressWarnings("unchecked")
	@RequestMapping("selectMyList.xdo")
	public ModelAndView selectMyList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
    	//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);

		RecordSet rs = guideSampleMysqlService.selectList(parameter);
		//RecordSet rs = guideJdbcService.selectList(parameter);	//jdbc test

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 저장을 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("saveMyList.xdo")
	public ModelAndView saveMyList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = guideSampleMysqlService.saveList(parameter);
		//int processCnt = guideJdbcService.saveList(parameter);	//jdbc test

		//XPlatform으로 넘겨줄 Out Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
