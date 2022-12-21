package com.hwfs.sc.scp.web;

import hone.core.util.record.Record;
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.scp.service.PersDstryReqService;


 /**
 * 개인정보 파기요청을 관리하는 PersDstryReq Controller
 * 
 * @ClassName PersDstryReqController.java
 * @Description PersDstryReqController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scp/persDstryReq/")
public class PersDstryReqController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PersDstryReqService Bean 생성 */
	@Resource(name = "/sc/scp/persDstryReqService")
	private PersDstryReqService persDstryReqService;
	
	/**
	 * 개인정보 파기요청 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		@SuppressWarnings("unchecked")
		Map <String, Object> inVar = param.get("ds_search").get(0);
		
		//개인정보 파기요청 을(를) 조회한다.
		RecordSet rs = persDstryReqService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 개인정보 파기요청(을)를 Insert/Update/Delete 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		logger.info("PersDstryReqController.saveList={}", parameter);
		
		//개인정보 파기요청을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = persDstryReqService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
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

//		//상신 본문 데이터 조회를 위한 조건인 JsonArray를 List<Map>으로 변환  --> 그룹웨어 에이전트 오류로 사용할 수 없음
//		List<Map<String, Object>> listParam = new ArrayList<Map<String, Object>>();
//		JSONArray jsonParam = new JSONArray (strId);
//		for (int i=0; i<jsonParam.length(); i++) {
//			Map<String, Object> map = new HashMap<String, Object>();
//			JSONObject json = jsonParam.getJSONObject(i);
//			@SuppressWarnings("rawtypes")
//			Iterator iter = json.keys();
//			while (iter.hasNext()) {
//				String key = iter.next().toString();
//				map.put(key, json.getString(key));
//			}
//			listParam.add(map);
//		}
//		

		//상신 본문 데이터 조회를 위한 조건인 구분자 문자열을 List<Map>으로 변환 : key|value형태로 구성 (2개가 1쌍)
		String[] arrParams= strId.split("\\|");
		List<Map<String, Object>> listParam = new ArrayList<Map<String, Object>>();
		
		for (int i=0; i<arrParams.length/4; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			int pos = i * 4;
			map.put(arrParams[pos], arrParams[pos+1]);
			map.put(arrParams[pos+2], arrParams[pos+3]);
			listParam.add(map);
		}

		logger.info("PersDstryReqController.makeGwDraftContent={}", listParam);

		List<Record> rs = persDstryReqService.selectGwDraftList(listParam);	//상신 목록 조회

		//본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
		model.addAttribute("gwDraftList", rs);

		//본문 타이틀 설정
		model.addAttribute("gwDraftTitle", strBodyTitle);

		//본문을 생성하는 JSP 호출
    	return new ModelAndView("/gw/scp/PersDstryReqGwDraft");
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

		logger.info("PersDstryReqController.saveSignInfo={}", parameter);

		persDstryReqService.saveSignInfo(parameter);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
