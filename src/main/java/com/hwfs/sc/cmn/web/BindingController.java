package com.hwfs.sc.cmn.web;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.NoSuchMessageException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.SystemCommonService;

 /**
 * Combo, Checkbox, Popup, Radio에 자료를 바인딩을 담당한다.
 * @ClassName BindingComCodeController.java
 * @Description BindingComCodeController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 6.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 1. 6.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/binding/")
public class BindingController extends DefaultController {
	private final Logger logger = LoggerFactory.getLogger(BindingController.class);

	@Resource(name = "/sc/cmn/systemCommonService")
	private SystemCommonService systemCommonService;

	/**
	 * 공통 Combo, Checkbox, Radio, Popup으로 사용하는 공통 처리 부분
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws NoSuchMessageException
	 * @throws JSONException
	 */
	@RequestMapping("select.xdo")
	public ModelAndView select(@Bind(id="", type=XplatformMapDTO.class) XplatformMapDTO xpDTO) throws NoSuchMessageException, JSONException {
		ModelAndView mav = createModelAndView();

		Map<String, Object> parameter = xpDTO.getInVariableMap();
		JSONObject input = null;

		try {
			input = new JSONObject(parameter.get("input").toString());
		}
		catch (JSONException e) {
			logger.error(e.getMessage());
		}

		SearchParameters searchParameter = new SearchParameters();
		searchParameter.put("qid", input.get("qid").toString());

		//[[기본 Option에 대하여 Query 조건값을 생성합니다.
		JSONObject option = null;

		try {
			option = new JSONObject(input.get("option").toString());

			Iterator<?> keys = option.keys();

			while (keys.hasNext()) {
				String key = keys.next().toString();
				searchParameter.put(key, option.get(key));
			}
		}
		catch (JSONException e) {
			logger.error(e.getMessage());
		}
		//기본 Option에 대하여 Query 조건값을 생성합니다.]]

		RecordSet rs = systemCommonService.select(searchParameter);

		super.addOutDataSet(mav, "output", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("select2.xdo")
	public ModelAndView select2(@Bind(id="", type=XplatformMapDTO.class) XplatformMapDTO xpDTO) throws NoSuchMessageException, JSONException {
		ModelAndView mav = createModelAndView();

		//Map<String, Object> parameter = xpDTO.getInVariableMap();
		Map<String, DataSetMap> p = xpDTO.getInDataSetMap();

		/*JSONObject input = null;

		try {
			input = new JSONObject(parameter.get("input").toString());
		}
		catch (JSONException e) {
			logger.error(e.getMessage());
		}*/

		SearchParameters searchParameter = new SearchParameters();
		searchParameter.put("qid", "ComCode2");

		DataSetMap groupCodeList = p.get("ds_search");
		ArrayList<Object> lst = new ArrayList<Object>();
		for (int i=0;i<groupCodeList.size();i++) {
			lst.add(groupCodeList.get(i).get("groupCode"));
		}

		searchParameter.put("groupCode", lst);

		//[[기본 Option에 대하여 Query 조건값을 생성합니다.
		/*JSONObject option = null;

		try {
			option = new JSONObject(input.get("option").toString());

			Iterator<?> keys = option.keys();

			while (keys.hasNext()) {
				String key = keys.next().toString();
				searchParameter.put(key, option.get(key));
			}
		}
		catch (JSONException e) {
			logger.error(e.getMessage());
		}*/
		//기본 Option에 대하여 Query 조건값을 생성합니다.]]

		RecordSet rs = systemCommonService.select(searchParameter);

		super.addOutDataSet(mav, "output", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	@RequestMapping("popupDesign.xdo")
	public ModelAndView popupDesign(@Bind(id="", type=XplatformMapDTO.class) XplatformMapDTO xpDTO) throws NoSuchMessageException, JSONException {
		ModelAndView mav = createModelAndView();

		Map<String, Object> parameter = xpDTO.getInVariableMap();
		String variableName = parameter.get("variableName").toString();
		String qid = parameter.get("qid").toString();

		StringBuffer variableValue = new StringBuffer();
		variableValue.append("{");
		variableValue.append("\"title\":");         variableValue.append("\""+super.messageService.getMessage("cmn.popup."+qid+".title")+"\"");
		variableValue.append(", \"label\":");       variableValue.append("\""+super.messageService.getMessage("cmn.popup."+qid+".label")+"\"");
		variableValue.append(", \"labelWidth\":");  variableValue.append("\""+super.messageService.getMessage("cmn.popup."+qid+".labelWidth")+"\"");
		variableValue.append(", \"columns\":");     variableValue.append(super.messageService.getMessage("cmn.popup."+qid+".columns"));
		variableValue.append(", \"bindingCode\":"); variableValue.append("\""+super.messageService.getMessage("cmn.popup."+qid+".bindingCode")+"\"");
		variableValue.append(", \"bindingName\":"); variableValue.append("\""+super.messageService.getMessage("cmn.popup."+qid+".bindingName")+"\"");
		variableValue.append(", \"width\":");       variableValue.append("\""+super.messageService.getMessage("cmn.popup."+qid+".width")+"\"");
		variableValue.append(", \"height\":");      variableValue.append("\""+super.messageService.getMessage("cmn.popup."+qid+".height")+"\"");
		variableValue.append("}");

		super.addOutVariable(mav, variableName, variableValue.toString());

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("selectColInfo.xdo")
	public ModelAndView selectColInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = systemCommonService.selectColInfo(parameter.get("ds_search").get(0));
		RecordSet rs1 = systemCommonService.selectColPkInfo(parameter.get("ds_search").get(0));
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		super.addOutDataSet(mav, "ds_listPk", rs1);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
