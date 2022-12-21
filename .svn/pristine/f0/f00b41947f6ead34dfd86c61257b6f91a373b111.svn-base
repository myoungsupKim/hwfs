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
import com.hwfs.sc.cmn.service.OrgChoiceService;

/**
 * 조직정보를 조회한다.
 * 
 * @ClassName OrgChoiceController.java
 * @Description OrgChoiceController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 11.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 11.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/orgChoice/")
public class OrgChoiceController extends DefaultController {
	@Resource(name = "/sc/cmn/orgChoiceService")
	private OrgChoiceService orgChoice;

	/**
	 * 조직정보를 조회한다.
	 * 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * 
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		// Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = orgChoice.selectList();

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
