package com.hwfs.fs.fsc.web;

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
import com.hwfs.fs.fsc.service.CateringSchlReptService;


 /**
 * 케터링 스케줄보고하는 CateringSchlRept Controller
 * 
 * @ClassName CateringSchlReptController.java
 * @Description CateringSchlReptController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 yanghj
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsc/cateringSchlRept/")
public class CateringSchlReptController extends DefaultController {

	/** CateringSchlReptService Bean 생성 */
	@Resource(name = "/fs/fsc/cateringSchlReptService")
	private CateringSchlReptService cateringSchlReptService;
	
	/**
	 * 케터링 스케줄보고 목록을 조회한다.
	 * <pre>
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
		
		//케터링 실적보고(사업장 주요행사 계획<행사실적>) 을(를) 조회한다.
		RecordSet rsCele = cateringSchlReptService.selectCeleList(parameter.get("ds_search").get(0));
		//케터링 실적보고(사업장 인력지원 계획<조리인력>) 을(를) 조회한다.
		RecordSet rsCookHuman = cateringSchlReptService.selectCookHumanList(parameter.get("ds_search").get(0));
		//케터링 실적보고(개인별근무 스케줄 리스트) 을(를) 조회한다.
		RecordSet rsPlan = cateringSchlReptService.selectPlanList(parameter.get("ds_search").get(0));
		//케터링 실적보고(개인별근무 스케줄 달력) 을(를) 조회한다.		
		RecordSet rsCalendar = cateringSchlReptService.selectCalendarList(parameter.get("ds_search").get(0));

		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsCeleOutput", rsCele);
		super.addOutDataSet(mav, "dsCookHumanOutput", rsCookHuman);
		super.addOutDataSet(mav, "dsGrdPlan", rsPlan);
		super.addOutDataSet(mav, "dsGrdCalendar", rsCalendar);


		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 케터링 스케줄보고(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
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
		DataSetMap parameter = param.get("dsGrdPlan");

		//케터링 스케줄보고을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = cateringSchlReptService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//케터링 실적보고(개인별근무 스케줄 리스트) 을(를) 조회한다.
		RecordSet rsPlan = cateringSchlReptService.selectPlanList(param.get("ds_search").get(0));
		//케터링 실적보고(개인별근무 스케줄 달력) 을(를) 조회한다.
		RecordSet rsCalendar = cateringSchlReptService.selectCalendarList(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsGrdPlan", rsPlan);
		super.addOutDataSet(mav, "dsGrdCalendar", rsCalendar);
		
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
