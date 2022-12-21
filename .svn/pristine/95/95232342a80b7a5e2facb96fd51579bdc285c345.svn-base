package com.hwfs.sc.sca.web;

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
import com.hwfs.sc.sca.service.AuthChngListService;

/**
 * 권한 변경요청 내역을 관리하는 AuthChngList Controller
 *
 * @ClassName AuthChngListController.java
 * @Description AuthChngListController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.24
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/sca/authChngList/")
public class AuthChngListController extends DefaultController {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AuthChngListService Bean 생성 */
	@Resource(name = "/sc/sca/authChngListService")
	private AuthChngListService authChngListService;

	/**
	 * 권한 변경요청 내역 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		// Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> param = parameter.get("ds_search").get(0);

		// 권한 변경요청 내역 을(를) 조회한다.
		RecordSet rs = authChngListService.selectList(param);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
