package com.hwfs.fs.fsl.web;

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
import com.hwfs.fs.fsl.service.AdvanceYnPopupService;


 /**
 * 선수금 선택하는 AdvanceYnPopup Controller
 * 
 * @ClassName AdvanceYnPopupController.java
 * @Description AdvanceYnPopupController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.30    이지운        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 이지운
 * @since 2015.07.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsl/advanceYnPopup/")
public class AdvanceYnPopupController extends DefaultController {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdvanceYnPopupService Bean 생성 */
	@Resource(name = "/fs/fsl/advanceYnPopupService")
	private AdvanceYnPopupService advanceYnPopupService;
	
	/**
	 * 선수금 선택 목록을 조회한다.
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
	@RequestMapping("selectAdvanceYnList.xdo")
	public ModelAndView selectAdvanceYnList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//선수금 선택 을(를) 조회한다.
		RecordSet rs = advanceYnPopupService.selectAdvanceYnList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선수금 선택 목록을 조회한다.
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
	@RequestMapping("selectAdvanceYnDetailList.xdo")
	public ModelAndView selectAdvanceYnDetailList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//조회 조건 파라미터를 얻는다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//선수금 선택 을(를) 조회한다.
		RecordSet rs = advanceYnPopupService.selectAdvanceYnDetailList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list2", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
