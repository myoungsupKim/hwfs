package com.hwfs.ma.mag.web;

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
import com.hwfs.ma.mag.service.LocalPurchaseService;


 /**
 * 현지구매내역 LocalPurchase Controller
 * 
 * @ClassName LocalPurchaseController.java
 * @Description LocalPurchaseController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.02.24	kihoon			[CH201703_00046] 최초작성
 * </pre>
 * @since 2017.02.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ma/mag/localPurchase/")
public class LocalPurchaseController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LocalPurchaseService Bean 생성 */
	@Resource(name = "/ma/mag/localPurchaseService")
	private LocalPurchaseService localPurchaseService;
	
	/**
	 * 정산유형 목록을 조회한다.
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectDltCdList.xdo")
	public ModelAndView selectBeforeMagam(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		@SuppressWarnings("unchecked")
		RecordSet rs = localPurchaseService.selectDltCdList(inVar);

		super.addOutDataSet(mav, "ds_dltCd", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 현지구매내역 차이 조회.
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectCloseInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		ModelAndView mav = super.createModelAndView();
		
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		@SuppressWarnings("unchecked")
		RecordSet rs = localPurchaseService.selectList(param.get("ds_search").get(0));
		
		super.addOutDataSet(mav, "ds_list", rs);
		
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
