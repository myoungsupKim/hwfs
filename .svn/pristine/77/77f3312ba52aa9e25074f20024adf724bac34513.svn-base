package com.hwfs.sc.scm.web;

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
import com.hwfs.sc.scm.service.MenuMgmtService;

/**
 * MenuMgmtController에 대한 설명 작성
 * 
 * @ClassName MenuMgmtController.java
 * @Description MenuMgmtController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 27.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 27.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scm/menuMgmt/")
public class MenuMgmtController extends DefaultController {
	@Resource(name = "/sc/scm/menuMgmtService")
	private MenuMgmtService menuMgmt;

	/**
	 * 메뉴정보를 조회한다.
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = menuMgmt.selectList(parameter.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 메뉴정보를 저장한다.
	 * 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * 
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		int procCnt = menuMgmt.saveList(parameter.get("ds_list"));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_procCnt", procCnt);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
