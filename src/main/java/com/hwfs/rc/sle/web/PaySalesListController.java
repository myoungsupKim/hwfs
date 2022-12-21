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
import com.hwfs.rc.sle.service.PaySalesListService;

 /**
 * PaySalesListController에 대한 설명 작성
 * @ClassName PaySalesListController.java
 * @Description PaySalesListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 20.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/sle/paySalesList/")
public class PaySalesListController extends DefaultController {
	@Resource(name="/rc/sle/paySalesListService")
	private PaySalesListService paySalesList;
	
	
	@RequestMapping("selectList.xdo")
	@SuppressWarnings("unchecked")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		//Map<String, Object> parameter = xpDTO.getInVariableMap();
		//RecordSet rs = salsListMgmt.saleListRankAll(parameter);
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		RecordSet rs = paySalesList.selectList(parameter.get("ds_paramInfo").get(0));
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_paymInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectListDetail.xdo")
	@SuppressWarnings("unchecked")
	public ModelAndView selectListDetail(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		//Map<String, Object> parameter = xpDTO.getInVariableMap();
		//RecordSet rs = salsListMgmt.saleListRankAll(parameter);
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		RecordSet rs = paySalesList.selectListDetail(parameter.get("ds_paramInfo").get(0));
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_paymSellInfo", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
