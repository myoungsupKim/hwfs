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
import com.hwfs.rc.sle.service.DailyTicketSaleListService;

/**
* 일별 식권판매현황 조회하는 DailyTicketSaleList Controller
* @ClassName DailyTicketSaleListController.java
* @Description DailyTicketSaleListController Class 
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2016. 1. 20.   Administrator        최초생성
* </pre>
* @author FC종합전산구축 : 팀명 Administrator
* @since 2016. 2. 15.
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/

@Controller
@RequestMapping("/rc/sle/dailyTicketSaleList/")
public class DailyTicketSaleListController extends DefaultController
{
	/** DailyTicketSaleListService Bean 생성 */
	@Resource(name="/rc/sle/dailyTicketSaleListService")
	private DailyTicketSaleListService dailyTicketSaleListService;

	/**
	 * 일별 식권판매현황을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception
	{
    	// XPLATFORM에 결과를 전달할 객체 생성
    	ModelAndView mav = super.createModelAndView();

    	// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
    	Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

    	// Dataset에서 첫번째 행의 정보만 추출한다.
    	Map<String, Object> parameter = param.get("ds_cond").get(0);

    	// 일별 식권판매현황을 조회한다
		RecordSet rs = dailyTicketSaleListService.selectList(parameter);
		
    	// XPlatform으로 넘겨줄 Dataset을 설정한다.
    	super.addOutDataSet(mav, "ds_list", rs);

    	// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
