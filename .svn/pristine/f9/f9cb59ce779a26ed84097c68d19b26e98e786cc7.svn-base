package com.hwfs.sc.scc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sc.scc.service.ConnectUserService;

/**
 * 접속사용자를 조회하는 ConnectUser Controller
 *
 * @ClassName ConnectUserController.java
 * @Description ConnectUserController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.08    김재섭        최초생성
 *  2015.07.09    kksoo         무단사용자 접속차단 및 접속상태 변경
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.08
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/connectUser/")
public class ConnectUserController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** ConnectUserService Bean 생성 */
	@Resource(name = "/sc/scc/connectUserService")
	private ConnectUserService connectUserService;

	/**
	 * 접속사용자 목록을 조회한다.
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
	@RequestMapping("selectUserList.xdo")
	public ModelAndView selectUserList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> inVar = parameter.get("ds_search").get(0);

		// 접속사용자 을(를) 조회한다.
		RecordSet rs = connectUserService.selectUserList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_userList", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 접속사용자 목록을 조회한다.
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
		Map<String, Object> inVar = parameter.get("ds_search").get(0);

		// 접속사용자 을(를) 조회한다.
		Map<String, RecordSet> rtn = connectUserService.selectList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_ccByConnectList",
				rtn.get("ccByConnectList"));
		super.addOutDataSet(mav, "ds_userList", rtn.get("userList"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 미접속 상태로 변경한다.
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("changeDisconnStatus.xdo")
	public ModelAndView changeDisconnStatus(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		String jsonParams = inVar.get("jsonParams").toString();

		//JsonArray를 List<Map>으로 변환
		List<Map<String, Object>> listParam = StringUtil.jsonArr2Map(jsonParams);
		
		// 접속사용자 을(를) 조회한다.
		connectUserService.changeDisconnStatus(listParam);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
