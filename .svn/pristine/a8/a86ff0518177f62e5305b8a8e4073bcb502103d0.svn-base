package com.hwfs.fs.fse.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fs.fse.service.EventMealSchlMgntService;


 /**
 * 이벤트 스케줄관리하는 EventMealSchlMgnt Controller
 * 
 * @ClassName EventMealSchlMgntController.java
 * @Description EventMealSchlMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 남기빈
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fse/eventMealSchlMgnt/")
public class EventMealSchlMgntController extends DefaultController {

	/** EventMealSchlMgntService Bean 생성 */
	@Resource(name = "/fs/fse/eventMealSchlMgntService")
	private EventMealSchlMgntService eventMealSchlMgntService;
	
	/**
	 * 이벤트 스케줄관리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//이벤트 스케줄관리 을(를) 조회한다.
		RecordSet rsEvntList = eventMealSchlMgntService.selectList(parameter.get("ds_search").get(0));
		
		RecordSet rsEvntSchl = eventMealSchlMgntService.selectSchl(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsEvntListOutput", rsEvntList);
		super.addOutDataSet(mav, "dsEvntSchlOutput", rsEvntSchl);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 이벤트 등록을 한다
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 *  XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("dsEventList");

		//이벤트 등록을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = eventMealSchlMgntService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		 super.addOutVariable(mav, "fv_processCnt", processCnt);

		//이벤트 등록 을(를) 조회한다.
		 RecordSet rsPlan = eventMealSchlMgntService.selectList(param.get("ds_search").get(0));
		//이벤트 조회 을(를) 조회한다.
		 RecordSet rsCalendar = eventMealSchlMgntService.selectSchl(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsEventList", rsPlan);
		super.addOutDataSet(mav, "dsEventSchl", rsCalendar);
		
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
