package com.hwfs.sc.scp.web;

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
import com.hwfs.sc.scp.service.PersDstryStatisticsService;


 /**
 * 개인정보 파기이력통계를 조회하는 PersDstryStatistics Controller
 * 
 * @ClassName PersDstryStatisticsController.java
 * @Description PersDstryStatisticsController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.22    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.05.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scp/persDstryStatistics/")
public class PersDstryStatisticsController extends DefaultController {
	
	/** PersDstryStatisticsService Bean 생성 */
	@Resource(name = "/sc/scp/persDstryStatisticsService")
	private PersDstryStatisticsService persDstryStatisticsService;
	
	/**
	 * 개인정보 파기이력통계 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		@SuppressWarnings("unchecked")
		Map <String, Object> inVar = param.get("ds_search").get(0);
		
		//파기상태별 개인정보 파기이력통계 을(를) 조회한다.
		RecordSet rsDstryStatus = persDstryStatisticsService.selectListPerDstryStatus(inVar);

		//파기구분별 개인정보 파기이력통계 을(를) 조회한다.
		RecordSet rsDstryClass = persDstryStatisticsService.selectListPerDstryClass(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listStatus", rsDstryStatus);
		super.addOutDataSet(mav, "ds_listClass", rsDstryClass);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
