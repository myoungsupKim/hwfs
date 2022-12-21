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
import com.hwfs.sc.cmn.service.TmSearchService;

/**
 * 팀정보를 조회한다.
 *
 * @ClassName TmSearchController.java
 * @Description TmSearchController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 10.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 10.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/tmSearch/")
public class TmSearchController extends DefaultController {
	@Resource(name = "/sc/cmn/tmSearchService")
	private TmSearchService tmSearch;

	/**
	 * 예외적인 TM을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectTeamControl.xdo")
	public ModelAndView selectTeamControl(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		//Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = tmSearch.selectTeamControl();

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_teamControl", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 조건에 해당하는 사용자정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = tmSearch.selectList(parameter.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조건에 해당하는 사용자정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectListAll.xdo")
	public ModelAndView selectListAll(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = tmSearch.selectListAll(parameter.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 조건에 해당하는 사용자정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectListBonbu.xdo")
	public ModelAndView selectListBonbu(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = tmSearch.selectListBonbu(parameter.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 2020.06.11 김명섭 월별손익보고서(수주) 팀 조회
	 * 수주물건 등록 담당부서(팀) 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectAccobjList.xdo")
	public ModelAndView selectAccobjList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = tmSearch.selectAccobjList(parameter.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
