package com.hwfs.sm.sar.web;

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
import com.hwfs.sm.sar.service.SapHwfcGapMonService;


 /**
 * SAP HWFC 거래처별 잔액비교 SapHwfcGapMon Controller
 * 
 * @ClassName SapHwfcGapMonController.java
 * @Description SapHwfcGapMonController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.09.20    김호석        최초생성
 * </pre>
 * @author 
 * @since 2018.09.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2018 by HANWHA System/ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/sar/sapHwfcGapMon/")
public class SapHwfcGapMonController extends DefaultController {
	
	/** SapHwfcGapMonService Bean 생성 */
	@Resource(name = "/sm/sar/sapHwfcGapMonService")
	private SapHwfcGapMonService sapHwfcGapMonService;
	
	/**
	 * SAP HWFC 거래처별 잔액비교  목록을 조회한다.
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
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//SAP HWFC 거래처별 잔액비교 조회한다.
		RecordSet rs = sapHwfcGapMonService.selectList(parameter.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
