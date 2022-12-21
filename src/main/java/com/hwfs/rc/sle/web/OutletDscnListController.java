package com.hwfs.rc.sle.web;

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
import com.hwfs.rc.sle.service.OutletDscnListService;

 /**
 * OutletDscnListController에 대한 설명 작성
 * @ClassName OutletDscnListController.java
 * @Description OutletDscnListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 20.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 5. 20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/sle/outletDscnList/")
public class OutletDscnListController extends DefaultController {
	@Resource(name="/rc/sle/outletDscnListService")
	private OutletDscnListService outletDscnList;

	//업장 인기 상품
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		//Map<String, Object> parameter = xpDTO.getInVariableMap();
		//RecordSet rs = salsListMgmt.saleListRankAll(parameter);
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = outletDscnList.selectList(parameter.get("ds_paramInfo").get(0));
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_outletDscn", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectDayList.xdo")
	public ModelAndView selectDayList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		//Map<String, Object> parameter = xpDTO.getInVariableMap();
		//RecordSet rs = salsListMgmt.saleListRankAll(parameter);
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = outletDscnList.selectDayList(parameter.get("ds_paramInfo").get(0));
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_outletDscn", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//2017.03.13 DC상세내역 추가(현대카드 M포인트 추가 후 수정) 김호석 CH201702_00668
	@SuppressWarnings("unchecked")
	@RequestMapping("dcSalesList.xdo")
	public ModelAndView dcSalesList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		//Map<String, Object> parameter = xpDTO.getInVariableMap();
		//RecordSet rs = salsListMgmt.saleListRankAll(parameter);
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = outletDscnList.dcSalesList(parameter.get("ds_paramInfo").get(0));
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_outletDscn", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectDcSumList.xdo")
	public ModelAndView selectDcSumList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		//Map<String, Object> parameter = xpDTO.getInVariableMap();
		//RecordSet rs = salsListMgmt.saleListRankAll(parameter);
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		RecordSet rs = outletDscnList.selectDcSumList(parameter.get("ds_paramInfo").get(0));
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_dcSum", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
