package com.hwfs.sc.scu.web;

import hone.core.util.record.Record;
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
import com.hwfs.sc.scu.service.UserRoleGrantService;

/**
 * 사용자 권한을 부여하는 UserRoleGrant Controller
 *
 * @ClassName UserRoleGrantController.java
 * @Description UserRoleGrantController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.25    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.25
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scu/userRoleGrant/")
public class UserRoleGrantController extends DefaultController {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** UserRoleGrantService Bean 생성 */
	@Resource(name = "/sc/scu/userRoleGrantService")
	private UserRoleGrantService userRoleGrantService;

	/**
	 * 권한부여 목록을 조회한다.
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
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> param = parameter.get("ds_search").get(0);

		// 권한부여 을(를) 조회한다.
		Map<String, Object> rtn = userRoleGrantService.selectList(param);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_userAuthlist",
				(RecordSet) rtn.get("userAuth"));
		super.addOutDataSet(mav, "ds_userInfo", (Record) rtn.get("userInfo"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 권한부여(을)를 Insert/Update/Delete 처리한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		String sabun = param.get("ds_search").get(0).get("sabun").toString();
		String chgSrlnum = param.get("ds_search").get(0).get("chgSrlnum")
				.toString();
		Map<String, Object> userInfo = param.get("ds_userInfo").get(0);

		// 권한부여을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = userRoleGrantService.saveList(chgSrlnum, sabun,
				parameter, userInfo);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
