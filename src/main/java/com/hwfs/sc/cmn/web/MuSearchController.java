package com.hwfs.sc.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.MuSearchService;

 /**
 * MuSearchController에 대한 설명 작성
 * @ClassName MuSearchController.java
 * @Description MuSearchController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 4. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/muSearch/")
public class MuSearchController extends DefaultController {
	@Resource(name = "/sc/cmn/muSearchService")
	private MuSearchService muSearch;

	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		RecordSet rs = muSearch.selectList();
		RecordSet rsAll = muSearch.selectAllList();

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_muSearchList", rs);
		super.addOutDataSet(mav, "ds_muSearchListAll", rsAll);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
