package com.hwfs.ms.mtm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ms.mtm.service.TeamLeaderAppService;


 /**
 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)하는 TeamLeaderApp Controller
 * 
 * @ClassName TeamLeaderAppController.java
 * @Description TeamLeaderAppController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 :  현장지원_모바일 강대성
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ms/mtm/teamLeaderApp/")
public class TeamLeaderAppController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TeamLeaderAppService Bean 생성 */
	@Resource(name = "/ms/mtm/teamLeaderAppService")
	private TeamLeaderAppService teamLeaderAppService;
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 목록을 조회한다.
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
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 을(를) 조회한다.
		RecordSet rs = teamLeaderAppService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 목록을 조회한다.
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
	@RequestMapping("selectDetailList.xdo")
	public ModelAndView selectDetailList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 을(를) 조회한다.
		RecordSet rs = teamLeaderAppService.selectDetailList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
				
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = teamLeaderAppService.saveList(parameter, inVar);
		logger.debug("processCnt >>>>>"+processCnt);
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveReturnList.xdo")
	public ModelAndView saveReturnList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
				
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = teamLeaderAppService.saveReturnList(parameter, inVar);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 목록을 조회한다.
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
	@RequestMapping("selectCount.xdo")
	public ModelAndView selectCount(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 을(를) 조회한다.
		RecordSet rs = teamLeaderAppService.selectCount(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
