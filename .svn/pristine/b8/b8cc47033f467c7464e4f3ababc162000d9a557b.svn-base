package com.hwfs.sm.srm.web;

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
import com.hwfs.sm.srm.service.MonthCloseChkService;

/**
 * 월마감 현황을 관리하는 MonthCloseChk Controller
 * 
 * @ClassName MonthCloseChkController.java
 * @Description MonthCloseChkController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.21    백승현      최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 백승현
 * @since 2015.12.21
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/srm/monthCloseChk/")
public class MonthCloseChkController extends DefaultController {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapSlipNonUpoadListService Bean 생성 */
	@Resource(name = "/sm/srm/monthCloseChkService")
	private MonthCloseChkService monthCloseChkService;

	/**
	 * 월마감관리 현황 목록을 조회한다.
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
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		Map<String, Object> parameter = param.get("ds_search").get(0);

		// SAP 미발행 전표 을(를) 조회한다.
		RecordSet rs = monthCloseChkService.selectList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
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

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//선수금정산(대체)내역을 조회을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = monthCloseChkService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 회계 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList2.xdo")
	public ModelAndView saveList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//선수금정산(대체)내역을 조회을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = monthCloseChkService.saveList2(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	


	/**
	 * 회계 월마감관리 현황 목록을 조회한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList2.xdo")
	public ModelAndView selectList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> parameter = xpDTO.getInVariableMap();

		// SAP 미발행 전표 을(를) 조회한다.
		RecordSet rs = monthCloseChkService.selectList2(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fiClose", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}


