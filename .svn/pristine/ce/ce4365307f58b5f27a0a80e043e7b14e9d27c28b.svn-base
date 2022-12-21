package com.hwfs.rc.rcm.web;

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
import com.hwfs.rc.rcm.service.CloseMgnt01Service;


 /**
 * 업장 마감을하는 CloseMgnt01 Controller
 * 
 * @ClassName CloseMgnt01Controller.java
 * @Description CloseMgnt01Controller Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 JUN
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/rcm/closeMgnt01/")
public class CloseMgnt01Controller extends DefaultController {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CloseMgnt01Service Bean 생성 */
	@Resource(name = "/rc/rcm/closeMgnt01Service")
	private CloseMgnt01Service closeMgnt01Service;
	
	/**
	 * 업장 마감 (매출목록)을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("salsList.xdo")
	public ModelAndView salsList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//업장 마감 (매출목록)을(를) 조회한다.
		RecordSet rs = closeMgnt01Service.salsList(inVar);
		//업장 마감 (선수금발생목록)을(를) 조회한다.
		RecordSet rs2 = closeMgnt01Service.selectAdvanceOccurList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_salsList", rs);
		super.addOutDataSet(mav, "ds_advanceOccurList", rs2);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장 마감 (지불목록)을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("paymentList.xdo")
	public ModelAndView paymentList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//업장 마감 (지불목록)을(를) 조회한다.
		RecordSet rs = closeMgnt01Service.paymentList(inVar);
		

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_paymentList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 업장 마감(을)를 Insert/Update/Delete 처리한다.
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

		//업장 마감을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = closeMgnt01Service.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
