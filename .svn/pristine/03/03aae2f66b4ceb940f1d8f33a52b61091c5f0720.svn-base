package com.hwfs.fm.fms.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.batch.defaults.DefaultBatchController;
import com.hwfs.batch.launch.BatchRunner;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scb.dto.JobExecDTO;
import com.hwfs.sc.scb.dto.JobInfoDTO;
import com.hwfs.sc.scb.service.BatchJobMngtService;
import com.hwfs.fm.fms.service.HubPriceInterfaceService;
import com.tobesoft.xplatform.data.DataSet;


 /**
 * 허브메카 아이디별 인터페이스 설정 BatchJobMngt Controller
 * 
 * @ClassName HubInterfaceMngtController.java
 * @Description HubInterfaceMngtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.22    hyejin.94        최초생성
 * </pre>
 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fms/hubPriceInterface/")
public class HubPriceInterfaceController extends DefaultBatchController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** HubInterfaceMngtService Bean 생성 */
	@Resource(name = "/fm/fms/hubPriceInterfaceService")
	private HubPriceInterfaceService hubPriceInterfaceService;
	
	
	/**
	 * DB에 등록된 User ID 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPriceUpjang.xdo")
	public ModelAndView selectPriceUpjang(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		
		//DB에 등록된 Job 정보 을(를) 조회한다.
		RecordSet jobList = hubPriceInterfaceService.selectPriceUpjang(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", jobList);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * User 정보를 저장합니다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveHubInterface.xdo")
	public ModelAndView saveReturnItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//예외품목을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> rtnMap = hubPriceInterfaceService.saveHubInterface(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", rtnMap.get("processCnt"));
		super.addOutVariable(mav, "fv_totCnt", parameter.size()); //전체 처리건수
		super.addOutDataSet(mav, "ds_listDupCheck", rtnMap.get("listDupCheck"));
		

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	/**
	 * 수동배치 실행 권한을 조회한다.
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
	@RequestMapping("selectBatchAuth.xdo")
	public ModelAndView selectBatchAuth(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = hubPriceInterfaceService.selectBatchAuth(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_batchYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	

}
