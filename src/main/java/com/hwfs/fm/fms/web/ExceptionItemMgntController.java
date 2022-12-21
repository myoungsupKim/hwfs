package com.hwfs.fm.fms.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fm.fms.service.ExceptionItemMgntService;


/**
* 수발주제어 예외품목 등록하는 Controller
* 
* @ClassName ReturnItemMgntController.java
* @Description ReturnItemMgntController Class
* @Modification-Information
* <pre>
*    수정일                 수정자              수정내용
*  ----------   ----------   -------------------------------
*  2022.04.22  hye.jin94        최초생성
* </pre>
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Controller
@RequestMapping("/fm/fms/exceptionItemMgnt/")
public class ExceptionItemMgntController extends DefaultController {
	
	/** ReturnItemMgntService Bean 생성 */
	@Resource(name = "/fm/fms/exceptionItemMgntService")
	private ExceptionItemMgntService exceptionItemMgntService;
	
	/**
	 * 자재를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectItem.xdo")
	public ModelAndView selectItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> parameter = param.get("ds_search").get(0);
		
		//자재 중분류를 조회한다.
		RecordSet rs = exceptionItemMgntService.selectItem(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 예외 품목을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectExceptionItem.xdo")
	public ModelAndView selectReturnItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> parameter = param.get("ds_search").get(0);
		
		//자재 중분류를 조회한다.
		RecordSet rs = exceptionItemMgntService.selectExceptionItem(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 예외품목을 저장합니다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveExceptionItem.xdo")
	public ModelAndView saveReturnItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//예외품목을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> rtnMap = exceptionItemMgntService.saveExceptionItem(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", rtnMap.get("processCnt"));
		super.addOutVariable(mav, "fv_totCnt", parameter.size()); //전체 처리건수
		super.addOutDataSet(mav, "ds_listDupCheck", rtnMap.get("listDupCheck"));
		

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
