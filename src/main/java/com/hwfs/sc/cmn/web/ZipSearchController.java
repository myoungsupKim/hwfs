package com.hwfs.sc.cmn.web;

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
import com.hwfs.sc.cmn.service.ZipSearchService;

 /**
 * ZipSearchController에 대한 설명 작성
 * @ClassName ZipSearchController.java
 * @Description ZipSearchController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 2.   김재섭      최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/zipSearch/")
public class ZipSearchController extends DefaultController {
	@Resource(name="/sc/cmn/zipSearchService")
	private ZipSearchService zipSearch;
	
	/**
	 * 도로명 조건에 대한 시도 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectSidoList.xdo")
	public ModelAndView selectSidoList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		//Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rs = zipSearch.selectSidoList();
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_cbo_sido", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 도로명 조건에 대한 시도 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectGugunList.xdo")
	public ModelAndView selectGugunList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();
		
		RecordSet rs = zipSearch.selectGugunList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_cbo_gugun", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 조건에 맞는 도로명 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectRoadList.xdo")
	public ModelAndView selectRoadList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rs = zipSearch.selectRoadList(parameter.get("ds_searchRoad").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listRoad", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 조건에 맞는 지번 주소를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectJibunList.xdo")
	public ModelAndView selectJibunList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rs = zipSearch.selectJibunList(parameter.get("ds_searchJibun").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listJibun", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
